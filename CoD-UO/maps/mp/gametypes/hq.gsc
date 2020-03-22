/*
	HQ
	Objective: 	Set up HQ at a radio and run the other teams points down to 0 by not allowing them to have a HQ
	Map ends:	When one teams score reaches 0, or time limit is reached
	Respawning:	No wait / Near teammates

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_teamdeathmatch_spawn
			All players spawn from these. The spawnpoint chosen is dependent on the current locations of teammates and enemies
			at the time of spawn. Players generally spawn behind their teammates relative to the direction of enemies. 

		Spectator Spawnpoints:
			classname		mp_teamdeathmatch_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "american";
			game["axis"] = "german";
			This sets the nationalities of the teams. Allies can be american, british, or russian. Axis can be german.
	
		If using minefields or exploders:
			maps\mp\_load::main();
		
		Radio Position information:
			You can place the radios in your map file using a script_model, and targetname of "hqradio"
			
			If you can't put the script_models into the map file (you only have the bsp) you can spawn the radios into the
			map in the level script (see the official level scripts). Here is how you spawn them into the map via the script...
			
			if (getcvar("g_gametype") == "hq")
			{
				//spawn radio 1
				radio = spawn ("script_model", (0,0,0));
				radio.origin = (-1167, -18611, 64);
				radio.angles = (0, 82, 0);
				radio.targetname = "hqradio";
				
				//spawn radio 2
				radio = spawn ("script_model", (0,0,0));
				radio.origin = (111, -16064, 29);
				radio.angles = (353, 47, 16);
				radio.targetname = "hqradio";
			}
			
			and so on...
		
	Optional level script settings
	------------------------------
		Soldier Type and Variation:
			game["american_soldiertype"] = "airborne";
			game["american_soldiervariation"] = "normal";
			game["german_soldiertype"] = "wehrmacht";
			game["german_soldiervariation"] = "normal";
			This sets what models are used for each nationality on a particular map.
			
			Valid settings:
				american_soldiertype		airborne
				american_soldiervariation	normal, winter
				
				british_soldiertype		airborne, commando
				british_soldiervariation	normal, winter
				
				russian_soldiertype		conscript, veteran
				russian_soldiervariation	normal, winter
				
				german_soldiertype		waffen, wehrmacht, fallschirmjagercamo, fallschirmjagergrey, kriegsmarine
				german_soldiervariation		normal, winter

		Layout Image:
			game["layoutimage"] = "yourlevelname";
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.
*/

main()
{
	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(!spawnpoints.size)
	{
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return;
	}
	
	for(i = 0; i < spawnpoints.size; i++)
		spawnpoints[i] placeSpawnpoint();

	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;

	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	
	level._effect["radioexplosion"] = loadfx("fx/explosions/grenade1.efx");
	
	allowed[0] = "tdm";
	allowed[1] = "hq";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();
	
	if(getcvar("scr_hq_timelimit") == "")		// Time limit per map
		setcvar("scr_hq_timelimit", "30");
	else if(getcvarfloat("scr_hq_timelimit") > 1440)
		setcvar("scr_hq_timelimit", "1440");
	level.timelimit = getcvarfloat("scr_hq_timelimit");
	setCvar("ui_hq_timelimit", level.timelimit);
	makeCvarServerInfo("ui_hq_timelimit", "30");
	
	if(getcvar("scr_hq_extrapoints") == "")
		setcvar("scr_hq_extrapoints", "0");
	
	if(getcvar("scr_hq_scorelimit") == "")		// Score limit per map
		setcvar("scr_hq_scorelimit", "450");
	level.scorelimit = getcvarint("scr_hq_scorelimit");
	setCvar("ui_hq_scorelimit", level.scorelimit);
	makeCvarServerInfo("ui_hq_scorelimit", "450");

	if(getCvar("scr_teambalance") == "")		// Auto Team Balancing
		setCvar("scr_teambalance", "0");
	level.teambalance = getCvarInt("scr_teambalance");
	level.teambalancetimer = 0;
	
	if(getCvar("scr_battlerank") == "")		
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");

	if(getCvar("scr_shellshock") == "")		// controls whether or not players get shellshocked from grenades or rockets
		setCvar("scr_shellshock", "1");
	setCvar("ui_shellshock", getCvar("scr_shellshock"));
	makeCvarServerInfo("ui_shellshock", "0");
			
	if(getCvar("scr_drophealth") == "")		// Free look spectator
		setCvar("scr_drophealth", "1");

	killcam = getCvar("scr_killcam");
	if(killcam == "")		// Kill cam
		killcam = "1";
	setCvar("scr_killcam", killcam, true);
	level.killcam = getCvarInt("scr_killcam");
	
	if(getCvar("scr_freelook") == "")		// Free look spectator
		setCvar("scr_freelook", "1");
	level.allowfreelook = getCvarInt("scr_freelook");
	
	if(getCvar("scr_spectateenemy") == "")	// Spectate Enemy Team
		setCvar("scr_spectateenemy", "1");
	level.allowenemyspectate = getCvarInt("scr_spectateenemy");
	
	if(getcvar("scr_drawfriend") == "")			// Draws a team icon over teammates
		setcvar("scr_drawfriend", "1");
	level.drawfriend = getcvarint("scr_drawfriend");
	
	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	if(!isdefined(game["state"]))
		game["state"] = "playing";
	
	// turn off ceasefire
	level.ceasefire = 0;
	setCvar("scr_ceasefire", "0");

	level.mapended = false;
	level.healthqueue = [];
	level.healthqueuecurrent = 0;
	
	level.team["allies"] = 0;
	level.team["axis"] = 0;
	
	level.zradioradius = 50; // Z Distance players must be from a radio to capture/neutralize it
	level.captured_radios["allies"] = 0;
	level.captured_radios["axis"] = 0;
	
	if(level.killcam >= 1)
		setarchive(true);
	
	level.RadioNeutralTime = 8;
	level.RadioCaptureTime = 10;
	level.RadioSpawnDelay = 30;
	level.radioradius = 120;
	level.wavetime = 45;
	level.respawngracetime = 5;
	level.RadioMaxHold = 6;
	level.timesCaptured = 0;
	level.nextradio = 0;
	level.reinforcement_time = level.wavetime;
	level.checkteambalance = false;
	level.spawnframe = 0;
	hq_setup();
}

Callback_StartGameType()
{
	// defaults if not defined in level script
	if(!isdefined(game["allies"]))
		game["allies"] = "american";
	if(!isdefined(game["axis"]))
		game["axis"] = "german";

	if(!isdefined(game["layoutimage"]))
		game["layoutimage"] = "default";
	layoutname = "levelshots/layouts/hud@layout_" + game["layoutimage"];
	precacheShader(layoutname);
	setcvar("scr_layoutimage", layoutname);
	makeCvarServerInfo("scr_layoutimage", "");

	// server cvar overrides
	if(getcvar("scr_allies") != "")
		game["allies"] = getcvar("scr_allies");	
	if(getcvar("scr_axis") != "")
		game["axis"] = getcvar("scr_axis");
	
	game["menu_serverinfo"] = "serverinfo_" + getCvar("g_gametype");
	game["menu_team"] = "team_" + game["allies"] + game["axis"];
	game["menu_weapon_allies"] = "weapon_" + game["allies"];
	game["menu_weapon_axis"] = "weapon_" + game["axis"];
	game["menu_viewmap"] = "viewmap";
	game["menu_callvote"] = "callvote";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	game["menu_quickvehicles"] = "quickvehicles";
	game["menu_quickrequests"] = "quickrequests";
	
	game["radio_prespawn"] = "gfx/hud/hud@objective_bel.tga";
	game["radio_none"] = "gfx/hud/objective.tga";
	game["radio_axis"] = "gfx/hud/hud@objective_german.tga";
	if (game["allies"] == "russian")
		game["radio_allies"] = "gfx/hud/hud@objective_russian.tga";
	else if (game["allies"] == "british")
		game["radio_allies"] = "gfx/hud/hud@objective_british.tga";
	else
		game["radio_allies"] = "gfx/hud/hud@objective_american.tga";

	precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	precacheString(&"MPSCRIPT_KILLCAM");
	precacheString(&"HQ_REINFORCEMENTS");
	precacheString(&"HQ_CAPTURNING_RADIO");
	precacheString(&"HQ_DESTROYING_RADIO");
	precacheString(&"HQ_LOSING_RADIO");
	precacheString(&"HQ_PRESS_ACTIVATE_TO_SKIP");
	precacheString(&"HQ_MAXHOLDTIME_ALLIES");
	precacheString(&"HQ_MAXHOLDTIME_AXIS");
	precacheString(&"GMI_MP_CEASEFIRE");

	precacheMenu(game["menu_serverinfo"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_allies"]);
	precacheMenu(game["menu_weapon_axis"]);
	precacheMenu(game["menu_viewmap"]);
	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
	precacheMenu(game["menu_quickvehicles"]);
	precacheMenu(game["menu_quickrequests"]);

	precacheShader("black");
	precacheShader("white");
	precacheShader("gfx/hud/hud@objective_bel.tga");
	precacheShader("gfx/hud/hud@objective_bel_up.tga");
	precacheShader("gfx/hud/hud@objective_bel_down.tga");
	precacheShader("hudScoreboard_mp");
	precacheShader("gfx/hud/hud@mpflag_spectator.tga");
	precacheShader("gfx/hud/objective.tga");
	precacheShader("gfx/hud/objective_up.tga");
	precacheShader("gfx/hud/objective_down.tga");
	precacheStatusIcon("gfx/hud/hud@status_dead.tga");
	precacheStatusIcon("gfx/hud/hud@status_connecting.tga");
	precacheItem("item_health");
	
	precacheModel("xmodel/objective_german_field_radio_notsolid");
	precacheModel("xmodel/german_field_radio_notsolid");
	precacheHeadIcon(game["radio_allies"]);
	precacheHeadIcon(game["radio_axis"]);
	
	precacheShader(game["radio_allies"]);
	precacheShader(game["radio_axis"]);
	precacheShader("gfx/hud/hud@objective_german_up.tga");
	precacheShader("gfx/hud/hud@objective_german_down.tga");
	if (game["allies"] == "russian")
	{
		precacheShader("gfx/hud/hud@objective_russian_up.tga");
		precacheShader("gfx/hud/hud@objective_russian_down.tga");
	}
	else if (game["allies"] == "british")
	{
		precacheShader("gfx/hud/hud@objective_british_up.tga");
		precacheShader("gfx/hud/hud@objective_british_down.tga");
	}
	else
	{
		precacheShader("gfx/hud/hud@objective_american_up.tga");
		precacheShader("gfx/hud/hud@objective_american_down.tga");
	}
	
	precacheShader("gfx/hud/hud@field_radio.tga");
	
	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::precache();
	maps\mp\gametypes\_teams::scoreboard();
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_teams::updateWeaponCvars();

	setClientNameMode("auto_change");
	level.graceperiod = true;
	thread startGame();
	thread updateGametypeCvars();
	level hq_reinforcements_hud();
	thread hq_reinforcement_timer();
	
	//thread addBotClients();
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.pers["teamTime"] = 1000000;
	
	iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	logPrint("J;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

	// set the cvar for the map quick bind
	self setClientCvar("g_scriptQuickMap", game["menu_viewmap"]);
	
	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}
	
	level endon("intermission");

	// start the vsay thread
	self thread maps\mp\gametypes\_teams::vsay_monitor();

	if(isdefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("ui_weapontab", "1");

		if(self.pers["team"] == "allies")
		{
			self.sessionteam = "allies";
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
		}
		else
		{
			self.sessionteam = "axis";
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
		}
			
		if(isdefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			spawnSpectator();

			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies"]);
			else
				self openMenu(game["menu_weapon_axis"]);
		}
	}
	else
	{
		self setClientCvar("g_scriptMainMenu", game["menu_team"]);
		self setClientCvar("ui_weapontab", "0");
		
		if(!isDefined(self.pers["skipserverinfo"]))
			self openMenu(game["menu_serverinfo"]);

		self.pers["team"] = "spectator";
		self.sessionteam = "spectator";

		spawnSpectator();
	}

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		if(menu == game["menu_serverinfo"] && response == "close")
		{
			self.pers["skipserverinfo"] = true;
			self openMenu(game["menu_team"]);
		}

		if(response == "open" || response == "close")
			continue;

		if(menu == game["menu_team"])
		{
			switch(response)
			{
			case "allies":
			case "axis":
			case "autoassign":
				if(response == "autoassign")
				{
					numonteam["allies"] = 0;
					numonteam["axis"] = 0;

					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						player = players[i];
					
						if(!isdefined(player.pers["team"]) || player.pers["team"] == "spectator" || player == self)
							continue;
			
						numonteam[player.pers["team"]]++;
					}
					
					// if teams are equal return the team with the lowest score
					if(numonteam["allies"] == numonteam["axis"])
					{
						if(getTeamScore("allies") == getTeamScore("axis"))
						{
							teams[0] = "allies";
							teams[1] = "axis";
							response = teams[randomInt(2)];
						}
						else if(getTeamScore("allies") < getTeamScore("axis"))
							response = "allies";
						else
							response = "axis";
					}
					else if(numonteam["allies"] < numonteam["axis"])
						response = "allies";
					else
						response = "axis";
					skipbalancecheck = true;
				}
				
				if (response == self.pers["team"])
					continue;
				
				if(response == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
				{
					if(self.pers["team"] == "allies")
					{
						self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
						self openMenu(game["menu_weapon_allies"]);
					}
					else
					{
						self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
						self openMenu(game["menu_weapon_axis"]);
					}				
					break;
				}
				
				//Check if the teams will become unbalanced when the player goes to this team...
				//------------------------------------------------------------------------------
				if ( (level.teambalance > 0) && (!isdefined (skipbalancecheck)) )
				{
					//Get a count of all players on Axis and Allies
					players = maps\mp\gametypes\_teams::CountPlayers();
					
					if (self.sessionteam != "spectator")
					{
						if (((players[response] + 1) - (players[self.pers["team"]] - 1)) > level.teambalance)
						{
							if (response == "allies")
							{
								if (game["allies"] == "american")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED",&"PATCH_1_3_AMERICAN");
								else if (game["allies"] == "british")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED",&"PATCH_1_3_BRITISH");
								else if (game["allies"] == "russian")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED",&"PATCH_1_3_RUSSIAN");
							}
							else
								self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED",&"PATCH_1_3_GERMAN");
							break;
						}
					}
					else
					{
						if (response == "allies")
							otherteam = "axis";
						else
							otherteam = "allies";
						if (((players[response] + 1) - players[otherteam]) > level.teambalance)
						{
							if (response == "allies")
							{
								if (game["allies"] == "american")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED2",&"PATCH_1_3_AMERICAN");
								else if (game["allies"] == "british")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED2",&"PATCH_1_3_BRITISH");
								else if (game["allies"] == "russian")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_ALLIED2",&"PATCH_1_3_RUSSIAN");
							}
							else
							{
								if (game["allies"] == "american")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_AXIS",&"PATCH_1_3_AMERICAN");
								else if (game["allies"] == "british")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_AXIS",&"PATCH_1_3_BRITISH");
								else if (game["allies"] == "russian")
									self iprintlnbold(&"PATCH_1_3_CANTJOINTEAM_AXIS",&"PATCH_1_3_RUSSIAN");
							}
							break;
						}
					}
				}
				skipbalancecheck = undefined;
				//------------------------------------------------------------------------------
				
				if(response != self.pers["team"] && self.sessionstate == "playing")
					self suicide();
				
				self notify("end_respawn");
				
				self.pers["team"] = response;
				self.sessionteam = self.pers["team"];
				level.checkteambalance = true;
				self.statusicon = "gfx/hud/hud@status_dead.tga";
				self.pers["teamTime"] = (gettime() / 1000);
				self.pers["weapon"] = undefined;
				self.pers["savedmodel"] = undefined;
				
				// update spectator permissions immediately on change of team
				maps\mp\gametypes\_teams::SetSpectatePermissions();
				
				// if there are weapons the user can select then open the weapon menu
				if ( maps\mp\gametypes\_teams::isweaponavailable(self.pers["team"]) )
				{
					if(self.pers["team"] == "allies")
					{
						menu = game["menu_weapon_allies"];
					}
					else
					{
						menu = game["menu_weapon_axis"];
					}
				
					self setClientCvar("ui_weapontab", "1");
					self openMenu(menu);
				}
				else
				{
					self setClientCvar("ui_weapontab", "0");
					self menu_spawn("none");
				}
		
				self setClientCvar("g_scriptMainMenu", menu);
				break;

			case "spectator":
				if(self.pers["team"] != "spectator")
				{
					self.pers["team"] = "spectator";
					self.pers["teamTime"] = 1000000;
					self.pers["weapon"] = undefined;
					self.pers["savedmodel"] = undefined;
					
					self.sessionteam = "spectator";
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
					self setClientCvar("ui_weapontab", "0");
					spawnSpectator();
				}
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;
				
			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}		
		else if(menu == game["menu_weapon_allies"] || menu == game["menu_weapon_axis"])
		{
			if(response == "team")
			{
				self openMenu(game["menu_team"]);
				continue;
			}
			else if(response == "viewmap")
			{
				self openMenu(game["menu_viewmap"]);
				continue;
			}
			else if(response == "callvote")
			{
				self openMenu(game["menu_callvote"]);
				continue;
			}
			
			if(!isdefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;
			
			weapon = self maps\mp\gametypes\_teams::restrict(response);
			
			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}
			
			if(isdefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
				continue;
			
			menu_spawn(weapon);
		}
		else if(menu == game["menu_viewmap"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;
				
			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		else if(menu == game["menu_callvote"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;
				
			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;
			}
		}
		else if(menu == game["menu_quickcommands"])
			maps\mp\gametypes\_teams::quickcommands(response);
		else if(menu == game["menu_quickstatements"])
			maps\mp\gametypes\_teams::quickstatements(response);
		else if(menu == game["menu_quickresponses"])
			maps\mp\gametypes\_teams::quickresponses(response);
		else if(menu == game["menu_quickvehicles"])
			maps\mp\gametypes\_teams::quickvehicles(response);
		else if(menu == game["menu_quickrequests"])
			maps\mp\gametypes\_teams::quickrequests(response);
	}
}

Callback_PlayerDisconnect()
{
	iprintln(&"MPSCRIPT_DISCONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if(self.sessionteam == "spectator")
		return;

	// dont take damage during ceasefire mode
	// but still take damage from ambient damage (water, minefields, fire)
	if(level.ceasefire && sMeansOfDeath != "MOD_EXPLOSIVE" && sMeansOfDeath != "MOD_WATER" && sMeansOfDeath != "MOD_TRIGGER_HURT")
		return;

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// check for completely getting out of the damage
//	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(level.friendlyfire == "1")
			{
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;

				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
			}
			else if(level.friendlyfire == "0" )
			{
				return;
			}
			else if(level.friendlyfire == "2")
			{
				eAttacker.friendlydamage = true;
		
				iDamage = iDamage * .5;

				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
	
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
			else if(level.friendlyfire == "3")
			{
				eAttacker.friendlydamage = true;
		
				iDamage = iDamage * .5;
		
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;

				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
		}
		else
		{
			// Make sure at least one point of damage is done
			if(iDamage < 1)
				iDamage = 1;

			self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
		}
	}

	self maps\mp\gametypes\_shellshock_gmi::DoShellShock(sWeapon, sMeansOfDeath, sHitLoc, iDamage);

	// Do debug print if it's enabled
	if(getCvarInt("g_debugDamage"))
	{
		println("client:" + self getEntityNumber() + " health:" + self.health +
			" damage:" + iDamage + " hitLoc:" + sHitLoc);
	}

	if(self.sessionstate != "dead")
	{
		lpselfnum = self getEntityNumber();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpselfGuid = self getGuid();
		lpattackerteam = "";
		
		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackname = eAttacker.name;
			lpattackGuid = eAttacker getGuid();
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isdefined(friendly)) 
		{  
			lpattacknum = lpselfnum;
			lpattackname = lpselfname;
			lpattackGuid = lpselfGuid;
		}
		
		logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	self endon("spawned");
	
	if(self.sessionteam == "spectator")
		return;
	
	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";
		
	// if this is a melee kill from a binocular then make sure they know that they are a loser
	if(sMeansOfDeath == "MOD_MELEE" && (sWeapon == "binoculars_artillery_mp" || sWeapon == "binoculars_mp") )
	{
		sMeansOfDeath = "MOD_MELEE_BINOCULARS";
	}
	
	// if this is a kill from the artillery binocs change the icon
	if(sMeansOfDeath != "MOD_MELEE_BINOCULARS" && sWeapon == "binoculars_artillery_mp" )
		sMeansOfDeath = "MOD_ARTILLERY";

	// send out an obituary message to all clients about the kill
	obituary(self, attacker, sWeapon, sMeansOfDeath);
	
	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.headicon = "";
	if (!isdefined (self.autobalance))
		self.deaths++;
	
	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfguid = self getGuid();
	lpselfteam = self.pers["team"];
	lpattackerteam = "";

	attackerNum = -1;
	if(isPlayer(attacker))
	{
		if(attacker == self) // killed himself
		{
			doKillcam = false;
			if (!isdefined (self.autobalance))
				attacker.score--;
			
			if(isdefined(attacker.friendlydamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			doKillcam = true;
			
			if ( ( (level.counter > 0) && (level.counter >= (level.wavetime - level.respawngracetime)) ) || (level.counter <= 2) )
			{
				self.freerespawn = true;
			}
			
			if(self.pers["team"] == attacker.pers["team"]) // killed by a friendly
				attacker.score--;
			else
			{
				attacker.score++;
			}
		}

		lpattacknum = attacker getEntityNumber();
		lpattackguid = attacker getGuid();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;
		
		self.score--;

		lpattacknum = -1;
		lpattackname = "";
		lpattackguid = "";
		lpattackerteam = "world";
	}
	
	logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Stop thread if map ended on this death
	if(level.mapended)
		return;

	// Make the player drop his weapon
	self dropItem(self getcurrentweapon());
	self.autobalance = undefined;
	level hq_removeall_hudelems(self);
	body = self cloneplayer();
	// Make the player drop health
	self dropHealth();
	
	delay = 2;
	wait delay;
	
	//fixes a bug so that a player who dies right before a radio is captured or neutralized still gets to spawn in the correct wave
	if ( (isdefined (level.counter)) && (level.counter > 0) && (level.counter >= (level.wavetime - level.respawngracetime)) )
		self.ignoretimer = true;
	
	if(getCvarInt("scr_killcam") <= 0)
		doKillcam = false;
	
	if(doKillcam)
		self thread killcam(attackerNum, delay);
	else
		self thread respawn();
}

// ----------------------------------------------------------------------------------
//	menu_spawn
//
// 		called from the player connect to spawn the player
// ----------------------------------------------------------------------------------
menu_spawn(weapon)
{
	if(!isdefined(self.pers["weapon"]))
	{
		self.pers["weapon"] = weapon;
		self thread respawn();
		self thread printJoinedTeam(self.pers["team"]);
	}
	else
	{
		self.pers["weapon"] = weapon;

		weaponname = maps\mp\gametypes\_teams::getWeaponName(self.pers["weapon"]);
		
		if(maps\mp\gametypes\_teams::useAn(self.pers["weapon"]))
			self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_AN", weaponname);
		else
			self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_A", weaponname);
	}
	self thread maps\mp\gametypes\_teams::SetSpectatePermissions();
	if (isdefined (self.autobalance_notify))
		self.autobalance_notify destroy();
}

spawnPlayer(farthest)
{
	if ( (!isdefined (self.pers["weapon"])) || (!isdefined (self.pers["team"])) )
		return;
	
	self notify("spawned");
	self notify("end_respawn");
	
	self.respawnwait = undefined;
	resettimeout();

	self.sessionteam = self.pers["team"];
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	self.freerespawn = undefined;
	
	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	if (isdefined (farthest))
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Farthest(spawnpoints);
	else
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam_AwayfromRadios(spawnpoints);

	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self.pers["rank"] = maps\mp\gametypes\_rank_gmi::DetermineBattleRank(self);
	self.rank = self.pers["rank"];
	
	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	
	if(!isdefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	if (!isdefined (self))
		return;
	
	// setup all the weapons
	self maps\mp\gametypes\_loadout_gmi::PlayerSpawnLoadout();
	
	self setClientCvar("cg_objectiveText", &"HQ_OBJ_TEXT", level.scorelimit);

	// battle rank icons take precidence over the draw friend icons
	if(level.drawfriend)
	{
		if(level.battlerank)
		{
			self.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(self);
			self.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(self);
			self.headiconteam = self.pers["team"];
		}
		else
		{
			if(self.pers["team"] == "allies")
			{
				self.headicon = game["headicon_allies"];
				self.headiconteam = "allies";
			}
			else
			{
				self.headicon = game["headicon_axis"];
				self.headiconteam = "axis";
			}
		}
	}
	else if(level.battlerank)
	{
		self.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(self);
	}	

	// setup the hud rank indicator
	self thread maps\mp\gametypes\_rank_gmi::RankHudInit();
}

update_scoreboard_objtext()
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		players[i] setClientCvar("cg_objectiveText", &"HQ_OBJ_TEXT", level.scorelimit);
	}
}

spawnSpectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";
	
	maps\mp\gametypes\_teams::SetSpectatePermissions();
	
	if(isdefined(origin) && isdefined(angles))
		self spawn(origin, angles);
	else
	{
        spawnpointname = "mp_teamdeathmatch_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
		if(isdefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}
	
	level hq_removeall_hudelems(self);
	
	self setClientCvar("cg_objectiveText", &"HQ_OBJ_TEXT", level.scorelimit);
}

spawnIntermission()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;

	spawnpointname = "mp_teamdeathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	
	level hq_removeall_hudelems(self);
}

respawn(instant)
{
	self endon("end_respawn");
	firsttime = 0;
	while(!isDefined(self.pers["weapon"])) {
		
		wait 3;
		
		//self iprintln(&"");	// TODO: tell them they need to select a weapon in order to spawn
		
		if (firsttime < 3)
		{
			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies"]);
			else
				self openMenu(game["menu_weapon_axis"]);
		}
		firsttime++;
	
		self waittill("menuresponse");
		
		wait 0.2;
	}
	
	currentorigin = self.origin;
	currentangles = self.angles;
	self spawnSpectator(currentorigin + (0, 0, 60), currentangles);
	
	if ( (level.graceperiod) && (self.deaths == 0) )
		instant = "instant";
	
	if (isdefined (instant))
	{
		self.wavespawner = true;
		self thread hq_wavespawner_flag_remove();
		if (isdefined (self.ignoretimer))
			self.ignoretimer = undefined;
		if (isdefined (self.respawntimer))
			self.respawntimer destroy();
		self thread spawnPlayer();
		return;
	}
	
	self.respawnwait = true;
	
	if ( (!isdefined (self.ignoretimer)) || ( (isdefined (self.ignoretimer)) && (self.ignoretimer == false) ) )
	{
		if ( (level.counter > 0) && (!isdefined (self.freerespawn)) )
		{
			if (!isdefined (self.respawntimer))
			{
				self.respawntimer = newClientHudElem(self);
				self.respawntimer.alignX = "center";
				self.respawntimer.alignY = "middle";
				self.respawntimer.x = 320;
				self.respawntimer.y = 150;
				self.respawntimer.archived = false;
				self.respawntimer.label = (&"HQ_REINFORCEMENTS");
				self.respawntimer setTimer (level.counter);
			}
			
			if ( (!isdefined (self.respawnwait)) || ( (isdefined (self.respawnwait)) && (self.respawnwait == false) ) )
				return;
			level waittill ("timer tick");
			if (isdefined (self.respawntimer))
			{
				if (level.counter > 1)
					self.respawntimer setTimer (level.counter);
				else
					self.respawntimer setTimer (1);
			}
			
			self.spawnwait = level.spawnframe;
			level.spawnframe++;
			wait level.counter;
						
			if ( (!isdefined (self.respawnwait)) || ( (isdefined (self.respawnwait)) && (self.respawnwait == false) ) )
				return;
			
			if (isdefined (self.respawntimer))
				self.respawntimer destroy();
		}
		self.wavespawner = true;
		self thread hq_wavespawner_flag_remove();
	}
	
	if (isdefined (self.ignoretimer))
		self.ignoretimer = undefined;
	
	if (!isdefined (self.freerespawn))
	{
		if (isdefined (self.spawnwait))
		{
			wait (0.05 * self.spawnwait);
			self.spawnwait = undefined;
		}
		self thread spawnPlayer();
	}
	else
		self thread spawnPlayer(true);
}

waitRespawnButton()
{
	self endon("end_respawn");
	self endon("respawn");
	
	wait 0;
	
	if ( getcvar("scr_forcerespawn") == "1" )
		return;
	
	if (!isdefined (self.respawntext))
	{
		self.respawntext = newClientHudElem(self);
		self.respawntext.alignX = "center";
		self.respawntext.alignY = "middle";
		self.respawntext.x = 320;
		self.respawntext.y = 70;
		self.respawntext.archived = false;
		self.respawntext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	}

	thread removeRespawnText();
	thread waitRemoveRespawnText("end_respawn");
	thread waitRemoveRespawnText("respawn");

	while(self useButtonPressed() != true)
		wait .05;
	
	self notify("remove_respawntext");

	self notify("respawn");	
}

removeRespawnText()
{
	self waittill("remove_respawntext");

	if(isdefined(self.respawntext))
		self.respawntext destroy();
}

waitRemoveRespawnText(message)
{
	self endon("remove_respawntext");

	self waittill(message);
	self notify("remove_respawntext");
}

killcam(attackerNum, delay)
{
	self endon("spawned");
	
	// killcam
	if(attackerNum < 0)
		return;

	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.archivetime = delay + 7;
	
	maps\mp\gametypes\_teams::SetKillcamSpectatePermissions();
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if(self.archivetime <= delay)
	{
		self.spectatorclient = -1;
		self.archivetime = 0;
		self.sessionstate = "dead";
		
		maps\mp\gametypes\_teams::SetSpectatePermissions();
		
		self thread respawn();
		return;
	}
	
	self.killcam = true;
	
	if(!isdefined(self.kc_topbar))
	{
		self.kc_topbar = newClientHudElem(self);
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader("black", 640, 112);
	}

	if(!isdefined(self.kc_bottombar))
	{
		self.kc_bottombar = newClientHudElem(self);
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader("black", 640, 112);
	}

	if(!isdefined(self.kc_title))
	{
		self.kc_title = newClientHudElem(self);
		self.kc_title.archived = false;
		self.kc_title.x = 320;
		self.kc_title.y = 40;
		self.kc_title.alignX = "center";
		self.kc_title.alignY = "middle";
		self.kc_title.sort = 1; // force to draw after the bars
		self.kc_title.fontScale = 3.5;
	}
	self.kc_title setText(&"MPSCRIPT_KILLCAM");

	if(!isdefined(self.kc_skiptext))
	{
		self.kc_skiptext = newClientHudElem(self);
		self.kc_skiptext.archived = false;
		self.kc_skiptext.x = 320;
		self.kc_skiptext.y = 70;
		self.kc_skiptext.alignX = "center";
		self.kc_skiptext.alignY = "middle";
		self.kc_skiptext.sort = 1; // force to draw after the bars
	}
	self.kc_skiptext setText(&"HQ_PRESS_ACTIVATE_TO_SKIP");

	if(!isdefined(self.kc_timer))
	{
		self.kc_timer = newClientHudElem(self);
		self.kc_timer.archived = false;
		self.kc_timer.x = 320;
		self.kc_timer.y = 428;
		self.kc_timer.alignX = "center";
		self.kc_timer.alignY = "middle";
		self.kc_timer.fontScale = 3.5;
		self.kc_timer.sort = 1;
	}
	self.kc_timer setTenthsTimer(self.archivetime - delay);

	self thread spawnedKillcamCleanup();
	self thread waitSkipKillcamButton();
	self thread waitKillcamTime();
	self waittill("end_killcam");

	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;
	self.sessionstate = "dead";
	
	self.killcam = undefined;
	
	maps\mp\gametypes\_teams::SetSpectatePermissions();
	
	self thread respawn();
}

waitKillcamTime()
{
	self endon("end_killcam");
	
	wait (self.archivetime - 0.05);
	self notify("end_killcam");
}

waitSkipKillcamButton()
{
	self endon("end_killcam");
	
	while(self useButtonPressed())
		wait .05;

	while(!(self useButtonPressed()))
		wait .05;
	
	self notify("end_killcam");	
}

removeKillcamElements()
{
	if(isdefined(self.kc_topbar))
		self.kc_topbar destroy();
	if(isdefined(self.kc_bottombar))
		self.kc_bottombar destroy();
	if(isdefined(self.kc_title))
		self.kc_title destroy();
	if(isdefined(self.kc_skiptext))
		self.kc_skiptext destroy();
	if(isdefined(self.kc_timer))
		self.kc_timer destroy();
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");

	self waittill("spawned");
	self removeKillcamElements();
}

startGame()
{
	level.starttime = getTime();
	
	if(level.timelimit > 0)
	{
		level.clock = newHudElem();
		level.clock.x = 320;
		level.clock.y = 460;
		level.clock.alignX = "center";
		level.clock.alignY = "middle";
		level.clock.font = "bigfixed";
		level.clock setTimer(level.timelimit * 60);
	}
	
	for(;;)
	{
		checkTimeLimit();
		wait 1;
	}
}

endMap()
{
	game["state"] = "intermission";
	level notify("intermission");
	
	alliedscore = getTeamScore("allies");
	axisscore = getTeamScore("axis");
	
	if(alliedscore == axisscore)
	{
		winningteam = "tie";
		losingteam = "tie";
		text = "MPSCRIPT_THE_GAME_IS_A_TIE";
	}
	else if(alliedscore > axisscore)
	{
		winningteam = "allies";
		losingteam = "axis";
		text = &"MPSCRIPT_ALLIES_WIN";
	}
	else
	{
		winningteam = "axis";
		losingteam = "allies";
		text = &"MPSCRIPT_AXIS_WIN";
	}
	
	if ( (winningteam == "allies") || (winningteam == "axis") )
	{
		winners = "";
		losers = "";
	}
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if ( (winningteam == "allies") || (winningteam == "axis") )
		{
			lpGuid = player getGuid();
			if ( (isdefined (player.pers["team"])) && (player.pers["team"] == winningteam) )
					winners = (winners + ";" + lpGuid + ";" + player.name);
			else if ( (isdefined (player.pers["team"])) && (player.pers["team"] == losingteam) )
					losers = (losers + ";" + lpGuid + ";" + player.name);
		}
		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");
		player setClientCvar("cg_objectiveText", text);
		player spawnIntermission();
	}
	
	if ( (winningteam == "allies") || (winningteam == "axis") )
	{
		logPrint("W;" + winningteam + winners + "\n");
		logPrint("L;" + losingteam + losers + "\n");
	}
	
	wait 10;
	exitLevel(false);
}

checkTimeLimit()
{
	if(level.timelimit <= 0)
		return;
	
	timepassed = (getTime() - level.starttime) / 1000;
	timepassed = timepassed / 60.0;
	
	if(timepassed < level.timelimit)
		return;
	
	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_TIME_LIMIT_REACHED");
	level thread endMap();
}

checkScoreLimit()
{
	if(level.scorelimit <= 0)
		return;
	
	if(getTeamScore("allies") < level.scorelimit && getTeamScore("axis") < level.scorelimit)
		return;
	
	if(level.mapended)
		return;
	level.mapended = true;
	
	iprintln(&"MPSCRIPT_SCORE_LIMIT_REACHED");
	level thread endMap();
}

updateGametypeCvars()
{
	wait 1;
	for(;;)
	{
		ceasefire = getCvarint("scr_ceasefire");

		// if we are in cease fire mode display it on the screen
		if (ceasefire != level.ceasefire)
		{
			level.ceasefire = ceasefire;
			if ( ceasefire )
			{
				level thread maps\mp\_util_mp_gmi::make_permanent_announcement(&"GMI_MP_CEASEFIRE", "end ceasefire", 220, (1.0,0.0,0.0));			
			}
			else
			{
				level notify("end ceasefire");
			}
		}


		// check all the players for rank changes
		if ( getCvarint("scr_battlerank") )
			maps\mp\gametypes\_rank_gmi::CheckPlayersForRankChanges();
			
		timelimit = getcvarfloat("scr_hq_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setcvar("scr_hq_timelimit", "1440");
			}
			
			level.timelimit = timelimit;
			setCvar("ui_hq_timelimit", level.timelimit);
			level.starttime = getTime();
			
			if(level.timelimit > 0)
			{
				if(!isdefined(level.clock))
				{
					level.clock = newHudElem();
					level.clock.x = 320;
					level.clock.y = 440;
					level.clock.alignX = "center";
					level.clock.alignY = "middle";
					level.clock.font = "bigfixed";
				}
				level.clock setTimer(level.timelimit * 60);
			}
			else
			{
				if(isdefined(level.clock))
					level.clock destroy();
			}
			
			checkTimeLimit();
		}
		
		scorelimit = getcvarint("scr_hq_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_hq_scorelimit", level.scorelimit);			
			level update_scoreboard_objtext();
		}
		checkScoreLimit();
		
		drawfriend = getCvarFloat("scr_drawfriend");
		battlerank = getCvarint("scr_battlerank");
		if(level.battlerank != battlerank || level.drawfriend != drawfriend)
		{
			level.drawfriend = drawfriend;
			level.battlerank = battlerank;
			
			// battle rank has precidence over draw friend
			if(level.battlerank)
			{
				// for all living players, show the appropriate headicon
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						// setup the hud rank indicator
						player thread maps\mp\gametypes\_rank_gmi::RankHudInit();

						player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);
						if ( level.drawfriend )
						{
							player.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(player);
							player.headiconteam = player.pers["team"];
						}
						else
						{
							player.headicon = "";
						}
					}
				}
			}
			else if(level.drawfriend)
			{
				// for all living players, show the appropriate headicon
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						if(player.pers["team"] == "allies")
						{
							player.headicon = game["headicon_allies"];
							player.headiconteam = "allies";
				
						}
						else
						{
							player.headicon = game["headicon_axis"];
							player.headiconteam = "axis";
						}
						
						player.statusicon = "";
					}
				}
			}
			else
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						player.headicon = "";
						player.statusicon = "";
					}
				}
			}
		}

		killcam = getCvarInt("scr_killcam");
		if (level.killcam != killcam)
		{
			level.killcam = getCvarInt("scr_killcam");
			if(level.killcam >= 1)
				setarchive(true);
			else
				setarchive(false);
		}
		
		freelook = getCvarInt("scr_freelook");
		if (level.allowfreelook != freelook)
		{
			level.allowfreelook = getCvarInt("scr_freelook");
			level maps\mp\gametypes\_teams::UpdateSpectatePermissions();
		}
		
		enemyspectate = getCvarInt("scr_spectateenemy");
		if (level.allowenemyspectate != enemyspectate)
		{
			level.allowenemyspectate = getCvarInt("scr_spectateenemy");
			level maps\mp\gametypes\_teams::UpdateSpectatePermissions();
		}
		
		teambalance = getCvarInt("scr_teambalance");
		if (level.teambalance != teambalance)
		{
			level.teambalance = getCvarInt("scr_teambalance");
			if (level.teambalance > 0)
				level.checkteambalance = true;
		}
		
		wait 1;
	}
}

printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}

hq_setup()
{
	wait 0.05;
	
	level.radio = getentarray ("hqradio","targetname");

	if ( (!level.radio.size) || (level.radio.size < 3) )
	{
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return;
	}
	
	setTeamScore("allies", 0);
	setTeamScore("axis", 0);
				
	for (i=0;i<level.radio.size;i++)
	{
		level.radio[i] setmodel ("xmodel/objective_german_field_radio_notsolid");
		level.radio[i].team = "none";
		level.radio[i].holdtime_allies = 0;
		level.radio[i].holdtime_axis = 0;
		level.radio[i].hidden = true;
		level.radio[i] hide();
		
		if ( (!isdefined (level.radio[i].script_radius)) || (level.radio[i].script_radius <= 0) )
			level.radio[i].radius = level.radioradius;
		else
			level.radio[i].radius = level.radio[i].script_radius;
		
		level thread hq_radio_think(level.radio[i]);
	}
	
	hq_randomize_radioarray();
	
	level thread hq_obj_think();
}

hq_randomize_radioarray()
{
	for (i=0; i<level.radio.size; i++)
	{
		rand = randomint(level.radio.size);
    	temp = level.radio[i];
    	level.radio[i] = level.radio[rand];
    	level.radio[rand] = temp;
	}
}

hq_obj_think(radio)
{
	NeutralRadios = 0;
	for ( i=0 ; i<level.radio.size ; i++ )
	{
		if (level.radio[i].hidden == true)
			continue;
		NeutralRadios++;
	}
	if (NeutralRadios <= 0)
	{
		if (level.nextradio > level.radio.size - 1)
		{
			hq_randomize_radioarray();
			level.nextradio = 0;
			
			if (isdefined (radio))
			{
				// same radio twice in a row so go to the next radio
				if (radio == level.radio[level.nextradio])
					level.nextradio++;
			}
		}
		
		objective_add(0, "current", level.radio[level.nextradio].origin, game["radio_prespawn"]);
		
		level hq_check_teams_exist();
		while ( (!level.alliesexist) || (!level.axisexist) )
		{
			wait 2;
			level hq_check_teams_exist();
		}
		
		if ( (isdefined (level.counter)) && (level.counter >= 0) )
			wait level.counter;
		else
			wait level.RadioSpawnDelay;
		
		level.radio[level.nextradio] show();
		level.radio[level.nextradio].hidden = false;
		
		level hq_playsound_onplayers("explo_plant_no_tick");
		objective_icon(0, game["radio_none"]);
		
		if ( (level.captured_radios["allies"] <= 0) && (level.captured_radios["axis"] > 0) ) // AXIS HAVE A RADIO AND ALLIES DONT
			objective_team(0, "allies");
		else if ( (level.captured_radios["allies"] > 0) && (level.captured_radios["axis"] <= 0) ) // ALLIES HAVE A RADIO AND AXIS DONT
			objective_team(0, "axis");
		else // NO TEAMS HAVE A RADIO
			objective_team(0, "none");
		
		level.nextradio++;
	}
}

hq_score_update(team, points)
{
	if ( (points <= 0) || (points > level.wavetime) )
		return;
	if (team == "allies")
		iprintln (&"HQ_SCORED_ALLIES", points);
	else
		iprintln (&"HQ_SCORED_AXIS", points);
	
	if( (getTeamScore(team) + points) > level.scorelimit )
		setTeamScore(team, level.scorelimit);
	else
		setTeamScore(team, (getTeamScore(team) + points));
	level thread hq_playsound_onplayers("hq_score");
	
}

// ----------------------------------------------------------------------------------
//	GivePointsToTeam
//
// 		Gives points to everyone on a certain team
// ----------------------------------------------------------------------------------
GivePointsToTeam( team, points )
{
	players = getentarray("player", "classname");
	
	// count up the people in the flag area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isAlive(player) && player.pers["team"] == team)
		{
			player.score += points;
		}
	}
}

hq_playsound_onplayers(sound)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] != "spectator"))
			players[i] playLocalSound(sound);
	}
}

hq_radio_think(radio)
{	
	level endon ("intermission");
	while (!level.mapended)
	{
		wait 0.05;
		if (!radio.hidden)
		{
			players = getentarray("player", "classname");
			radio.allies = 0;
			radio.axis = 0;
			for(i = 0; i < players.size; i++)
			{
				if(isdefined(players[i].pers["team"]) && players[i].pers["team"] != "spectator" && players[i].sessionstate == "playing")
				{
					if ( !(players[i] isInVehicle()) && ((distance(players[i].origin,radio.origin)) <= radio.radius) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= level.zradioradius) )
					{
						if(players[i].pers["team"] == radio.team)
							continue;
						
						if ( (level.captured_radios[players[i].pers["team"]] > 0) && (radio.team == "none") )
							continue;
						
						if ( (!isdefined (players[i].radioicon)) || (!isdefined (players[i].radioicon[0])) )
						{
							players[i].radioicon[0] = newClientHudElem(players[i]);
							players[i].radioicon[0].alignX = "center";
							players[i].radioicon[0].alignY = "middle";
							players[i].radioicon[0].x = 600;
							players[i].radioicon[0].y = 390;
							players[i].radioicon[0] setShader("gfx/hud/hud@field_radio.tga", 40, 32);
						}
						
						if ( (level.captured_radios[players[i].pers["team"]] <= 0) && (radio.team == "none") )
						{
							if(!isdefined(players[i].progressbar_capture))
							{
								players[i].progressbar_capture = newClientHudElem(players[i]);
								players[i].progressbar_capture.alignX = "center";
								players[i].progressbar_capture.alignY = "middle";
								players[i].progressbar_capture.x = 320;
								players[i].progressbar_capture.y = 385;
								players[i].progressbar_capture.alpha = 0.5;
							}
							players[i].progressbar_capture setShader("black", 254, 14);
							
							if(!isdefined(players[i].progressbar_capture2))
							{
								players[i].progressbar_capture2 = newClientHudElem(players[i]);				
								players[i].progressbar_capture2.alignX = "left";
								players[i].progressbar_capture2.alignY = "middle";
								players[i].progressbar_capture2.x = (320 - 125);
								players[i].progressbar_capture2.y = 385;
							}
							if (players[i].pers["team"] == "allies")
								players[i].progressbar_capture2 setShader("white", (radio.holdtime_allies + (12.5 / level.RadioCaptureTime)), 10);
							else
								players[i].progressbar_capture2 setShader("white", (radio.holdtime_axis + (12.5 / level.RadioCaptureTime)), 10);
							
							if(!isdefined(players[i].progressbar_capture3))
							{
								players[i].progressbar_capture3 = newClientHudElem(players[i]);
								players[i].progressbar_capture3.alignX = "center";
								players[i].progressbar_capture3.alignY = "middle";
								players[i].progressbar_capture3.x = 320;
								players[i].progressbar_capture3.y = 384;
								players[i].progressbar_capture3.fontscale = 0.8;
								players[i].progressbar_capture3.color = (.5,.5,.5);
								players[i].progressbar_capture3 settext (&"HQ_CAPTURNING_RADIO");
							}
						}
						else if (radio.team != "none")
						{	
							if(!isdefined(players[i].progressbar_capture))
							{
								players[i].progressbar_capture = newClientHudElem(players[i]);
								players[i].progressbar_capture.alignX = "center";
								players[i].progressbar_capture.alignY = "middle";
								players[i].progressbar_capture.x = 320;
								players[i].progressbar_capture.y = 385;
								players[i].progressbar_capture.alpha = 0.5;
							}
							players[i].progressbar_capture setShader("black", 254, 14);
							
							if(!isdefined(players[i].progressbar_capture2))
							{
								players[i].progressbar_capture2 = newClientHudElem(players[i]);				
								players[i].progressbar_capture2.alignX = "left";
								players[i].progressbar_capture2.alignY = "middle";
								players[i].progressbar_capture2.x = 195;
								players[i].progressbar_capture2.y = 385;
							}
							if (players[i].pers["team"] == "allies")
								players[i].progressbar_capture2 setShader("white", (250 - (radio.holdtime_allies - (12.5 / level.RadioNeutralTime))), 10);
							else
								players[i].progressbar_capture2 setShader("white", (250 - (radio.holdtime_axis - (12.5 / level.RadioNeutralTime))), 10);
							
							if(!isdefined(players[i].progressbar_capture3))
							{
								players[i].progressbar_capture3 = newClientHudElem(players[i]);
								players[i].progressbar_capture3.alignX = "center";
								players[i].progressbar_capture3.alignY = "middle";
								players[i].progressbar_capture3.x = 320;
								players[i].progressbar_capture3.y = 384;
								players[i].progressbar_capture3.fontscale = 0.8;
								players[i].progressbar_capture3.color = (1,1,1);
								players[i].progressbar_capture3 settext (&"HQ_DESTROYING_RADIO");
							}
							
							if (radio.team == "allies")
							{
								if(!isdefined(level.progressbar_axis_neutralize))
								{
									level.progressbar_axis_neutralize = newTeamHudElem("allies");
									level.progressbar_axis_neutralize.alignX = "center";
									level.progressbar_axis_neutralize.alignY = "middle";
									level.progressbar_axis_neutralize.x = 320;
									level.progressbar_axis_neutralize.y = 400;
									level.progressbar_axis_neutralize.alpha = 0.5;
								}
								level.progressbar_axis_neutralize setShader("black", 254, 14);
								
								if(!isdefined(level.progressbar_axis_neutralize2))
								{
									level.progressbar_axis_neutralize2 = newTeamHudElem("allies");
									level.progressbar_axis_neutralize2.alignX = "left";
									level.progressbar_axis_neutralize2.alignY = "middle";
									level.progressbar_axis_neutralize2.x = 195;
									level.progressbar_axis_neutralize2.y = 400;
									level.progressbar_axis_neutralize2.color = (.8,0,0);
								}
								if (players[i].pers["team"] == "allies")
									level.progressbar_axis_neutralize2 setShader("white", (250 - (radio.holdtime_allies - (12.5 / level.RadioNeutralTime))), 10);
								else
									level.progressbar_axis_neutralize2 setShader("white", (250 - (radio.holdtime_axis - (12.5 / level.RadioNeutralTime))), 10);
								
								if(!isdefined(level.progressbar_axis_neutralize3))
								{
									level.progressbar_axis_neutralize3 = newTeamHudElem("allies");
									level.progressbar_axis_neutralize3.alignX = "center";
									level.progressbar_axis_neutralize3.alignY = "middle";
									level.progressbar_axis_neutralize3.x = 320;
									level.progressbar_axis_neutralize3.y = 399;
									level.progressbar_axis_neutralize3.fontscale = 0.8;
									level.progressbar_axis_neutralize3.color = (1,1,1);
									level.progressbar_axis_neutralize3 settext (&"HQ_LOSING_RADIO");
								}
							}
							else
							if (radio.team == "axis")
							{
								if(!isdefined(level.progressbar_allies_neutralize))
								{
									level.progressbar_allies_neutralize = newTeamHudElem("axis");
									level.progressbar_allies_neutralize.alignX = "center";
									level.progressbar_allies_neutralize.alignY = "middle";
									level.progressbar_allies_neutralize.x = 320;
									level.progressbar_allies_neutralize.y = 400;
									level.progressbar_allies_neutralize.alpha = 0.5;
								}
								level.progressbar_allies_neutralize setShader("black", 254, 12);
								
								if(!isdefined(level.progressbar_allies_neutralize2))
								{
									level.progressbar_allies_neutralize2 = newTeamHudElem("axis");
									level.progressbar_allies_neutralize2.alignX = "left";
									level.progressbar_allies_neutralize2.alignY = "middle";
									level.progressbar_allies_neutralize2.x = 195;
									level.progressbar_allies_neutralize2.y = 400;
									level.progressbar_allies_neutralize2.color = (.8,0,0);
								}
								if (players[i].pers["team"] == "allies")
									level.progressbar_allies_neutralize2 setShader("white", (250 - (radio.holdtime_allies - (12.5 / level.RadioNeutralTime))), 8);
								else
									level.progressbar_allies_neutralize2 setShader("white", (250 - (radio.holdtime_axis - (12.5 / level.RadioNeutralTime))), 8);
								
								if(!isdefined(level.progressbar_allies_neutralize3))
								{
									level.progressbar_allies_neutralize3 = newTeamHudElem("axis");
									level.progressbar_allies_neutralize3.alignX = "center";
									level.progressbar_allies_neutralize3.alignY = "middle";
									level.progressbar_allies_neutralize3.x = 320;
									level.progressbar_allies_neutralize3.y = 399;
									level.progressbar_allies_neutralize3.fontscale = 0.8;
									level.progressbar_allies_neutralize3.color = (.5,.5,.5);
									level.progressbar_allies_neutralize3 settext (&"HQ_LOSING_RADIO");
								}
							}
						}
						
						if(players[i].pers["team"] == "allies")
							radio.allies++;
						else
							radio.axis++;
					}
					else if ( (isdefined (players[i].radioicon)) && (isdefined (players[i].radioicon[0])) )
					{
						if ( (isdefined (players[i].radioicon)) || (isdefined (players[i].radioicon[0])) )
							players[i].radioicon[0] destroy();
						if(isdefined(players[i].progressbar_capture))
							players[i].progressbar_capture destroy();
						if(isdefined(players[i].progressbar_capture2))
							players[i].progressbar_capture2 destroy();
						if(isdefined(players[i].progressbar_capture3))
							players[i].progressbar_capture3 destroy();
					}
				}
			}
			
			if (radio.team == "none") // Radio is captured if no enemies around
			{
				if ( (radio.allies > 0) && (radio.axis <= 0) && (radio.team != "allies") )
				{
					radio.holdtime_allies += (12.5 / level.RadioCaptureTime);
					if (radio.holdtime_allies >= 250)
					{
						if ( (level.captured_radios["allies"] > 0) && (radio.team != "none") )
							level hq_radio_capture(radio, "none");
						else if (level.captured_radios["allies"] <= 0)
							level hq_radio_capture(radio, "allies");
					}
				}
				else if ( (radio.axis > 0) && (radio.allies <= 0) && (radio.team != "axis") )
				{
					radio.holdtime_axis += (12.5 / level.RadioCaptureTime);
					if (radio.holdtime_axis >= 250)
					{
						if ( (level.captured_radios["axis"] > 0) && (radio.team != "none") )
							level hq_radio_capture(radio, "none");
						else if (level.captured_radios["axis"] <= 0)
							level hq_radio_capture(radio, "axis");
					}
				}
				else
				{
					radio.holdtime_allies = 0;
					radio.holdtime_axis = 0;
					
					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						if(isdefined(players[i].pers["team"]) && players[i].pers["team"] != "spectator" && players[i].sessionstate == "playing")
						{
							if ( !(players[i] isInVehicle()) && ((distance(players[i].origin,radio.origin)) <= radio.radius) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= level.zradioradius) )
							{	
								if(isdefined(players[i].progressbar_capture))
									players[i].progressbar_capture destroy();
								if(isdefined(players[i].progressbar_capture2))
									players[i].progressbar_capture2 destroy();
								if(isdefined(players[i].progressbar_capture3))
									players[i].progressbar_capture3 destroy();
							}
						}
					}
				}
			}
			else // Radio should go to neutral first
			{
				if ( (radio.team == "allies") && (radio.axis <= 0) )
				{
					if(isdefined(level.progressbar_axis_neutralize))
						level.progressbar_axis_neutralize destroy();
					if(isdefined(level.progressbar_axis_neutralize2))
						level.progressbar_axis_neutralize2 destroy();
					if(isdefined(level.progressbar_axis_neutralize3))
						level.progressbar_axis_neutralize3 destroy();
				}
				else if ( (radio.team == "axis") && (radio.allies <= 0) )
				{
					if(isdefined(level.progressbar_allies_neutralize))
						level.progressbar_allies_neutralize destroy();
					if(isdefined(level.progressbar_allies_neutralize2))
						level.progressbar_allies_neutralize2 destroy();
					if(isdefined(level.progressbar_allies_neutralize3))
						level.progressbar_allies_neutralize3 destroy();
				}
				
				if ( (radio.allies > 0) && (radio.team == "axis") )
				{
					radio.holdtime_allies += (12.5 / level.RadioNeutralTime);
					if (radio.holdtime_allies >= 250)
						level hq_radio_capture(radio, "none");
				}
				else if ( (radio.axis > 0) && (radio.team == "allies") )
				{
					radio.holdtime_axis += (12.5 / level.RadioNeutralTime);
					if (radio.holdtime_axis >= 250)
						level hq_radio_capture(radio, "none");
				}
				else
				{
					radio.holdtime_allies = 0;
					radio.holdtime_axis = 0;
				}
			}
		}
	}
}

hq_radio_capture(radio, team)
{
	radio.holdtime_allies = 0;
	radio.holdtime_axis = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] != "spectator" && players[i].sessionstate == "playing")
		{
			if ( (isdefined (players[i].radioicon)) && (isdefined (players[i].radioicon[0])) )
			{
				players[i].radioicon[0] destroy();
				if(isdefined(players[i].progressbar_capture))
					players[i].progressbar_capture destroy();
				if(isdefined(players[i].progressbar_capture2))
					players[i].progressbar_capture2 destroy();
				if(isdefined(players[i].progressbar_capture3))
					players[i].progressbar_capture3 destroy();
			}
		}
	}
	PointsScored = level.counter;
	level.counter = level.reinforcement_time;
	level notify ("timer tick");
	level notify ("respawn all");
	
	if (radio.team != "none")
	{	
		level.captured_radios[radio.team] = 0;
		level thread hq_playsound_onplayers("hq_explo_radio");
		playfx(level._effect["radioexplosion"], radio.origin);
		level.timesCaptured = 0;
		// Give points to the team that neutralized it and print some text
		if (radio.team == "allies")
		{
			iprintln (&"HQ_SHUTDOWN_ALLIED_HQ");
			level thread hq_points_players("allies", "lost");
			level thread hq_score_update("axis", PointsScored);
			if(isdefined(level.progressbar_axis_neutralize))
				level.progressbar_axis_neutralize destroy();
			if(isdefined(level.progressbar_axis_neutralize2))
				level.progressbar_axis_neutralize2 destroy();
			if(isdefined(level.progressbar_axis_neutralize3))
				level.progressbar_axis_neutralize3 destroy();
		}
		else if (radio.team == "axis")
		{
			iprintln (&"HQ_SHUTDOWN_AXIS_HQ");
			level thread hq_points_players("axis", "lost");
			level thread hq_score_update("allies", PointsScored);
			if(isdefined(level.progressbar_allies_neutralize))
				level.progressbar_allies_neutralize destroy();
			if(isdefined(level.progressbar_allies_neutralize2))
				level.progressbar_allies_neutralize2 destroy();
			if(isdefined(level.progressbar_allies_neutralize3))
				level.progressbar_allies_neutralize3 destroy();
		}
	}
	
	if (radio.team == "none")
		level hq_playsound_onplayers("explo_plant_no_tick");
	
	radio.team = team;
	
	if (team == "none")
	{
		// RADIO GOES NEUTRAL
		level.reinforcement_time = level.wavetime;
		level notify ("Timer Changed");
		level thread hq_reinforcement_timer();
		
		radio setmodel ("xmodel/objective_german_field_radio_notsolid");
		radio stoploopsound ("german_radio");
		radio stoploopsound ("german_radio_pathfinder");
		radio hide();
		radio.hidden = true;
		objective_delete(0);
		level thread hq_removhudelem_allplayers(radio);
	}
	else
	{
		// RADIO CAPTURED BY A TEAM
		level.reinforcement_time = level.wavetime;
		
		level notify ("Timer Changed");
		level thread hq_reinforcement_timer();
		
		level.captured_radios[team] = 1;
		radio setmodel ("xmodel/german_field_radio_notsolid");
		
		if (team == "allies")
		{
			iprintln (&"HQ_SETUP_HQ_ALLIED");
			radio playloopsound ("german_radio_pathfinder");
		}
		else
		{
			iprintln (&"HQ_SETUP_HQ_AXIS");
			radio playloopsound ("german_radio");
		}
	}
	objective_icon(0, ( game["radio_" + team ] ));
	objective_team(0, "none");
	
	objteam = "none";
	if ( (level.captured_radios["allies"] <= 0) && (level.captured_radios["axis"] > 0) )
		objteam = "allies";
	else if ( (level.captured_radios["allies"] > 0) && (level.captured_radios["axis"] <= 0) )
		objteam = "axis";
	
	// Make all neutral radio objectives go to the right team
	for ( i=0 ; i<level.radio.size ; i++ )
	{
		if (level.radio[i].hidden == true)
			continue;
		if (level.radio[i].team == "none")
			objective_team(0, objteam);
	}
	
	level hq_obj_think(radio);
}

hq_points_players(team, reason)
{
	if(getCvarInt("scr_hq_extrapoints") > 0 || level.battlerank)
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if ( !isdefined(players[i].pers["team"]) || players[i].sessionstate != "playing")
				continue;
				
			// if defending then give points to the defending team
			if (reason == "defending" && players[i].pers["team"] == team)
			{
				players[i].score += 3;
			}
			// if lost then give points to the attacking team
			else if (reason == "lost" && players[i].pers["team"] != team)
			{
				players[i].score += 3;
			}
		}
	}
}

hq_radio_resetall(team)
{
	// Find the radio that is in play
	for (i=0;i<level.radio.size;i++)
	{
		if (level.radio[i].hidden == false)
			radio = level.radio[i];
	}
	
	if (!isdefined (radio))
		return;
	
	radio.holdtime_allies = 0;
	radio.holdtime_axis = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] != "spectator" && players[i].sessionstate == "playing")
		{
			if ( (isdefined (players[i].radioicon)) && (isdefined (players[i].radioicon[0])) )
			{
				players[i].radioicon[0] destroy();
				if(isdefined(players[i].progressbar_capture))
					players[i].progressbar_capture destroy();
				if(isdefined(players[i].progressbar_capture2))
					players[i].progressbar_capture2 destroy();
				if(isdefined(players[i].progressbar_capture3))
					players[i].progressbar_capture3 destroy();
			}
		}
	}
	
	level notify ("respawn all");
	
	if (radio.team != "none")
	{	
		level.captured_radios[radio.team] = 0;
		level hq_playsound_onplayers("hq_explo_radio");
		playfx(level._effect["radioexplosion"], radio.origin);
		level.timesCaptured = 0;
		
		if (radio.team == "allies")
		{
			iprintlnbold (&"HQ_MAXHOLDTIME_ALLIES");
			if(isdefined(level.progressbar_axis_neutralize))
				level.progressbar_axis_neutralize destroy();
			if(isdefined(level.progressbar_axis_neutralize2))
				level.progressbar_axis_neutralize2 destroy();
			if(isdefined(level.progressbar_axis_neutralize3))
				level.progressbar_axis_neutralize3 destroy();
		}
		else if (radio.team == "axis")
		{
			iprintlnbold (&"HQ_MAXHOLDTIME_AXIS");
			if(isdefined(level.progressbar_allies_neutralize))
				level.progressbar_allies_neutralize destroy();
			if(isdefined(level.progressbar_allies_neutralize2))
				level.progressbar_allies_neutralize2 destroy();
			if(isdefined(level.progressbar_allies_neutralize3))
				level.progressbar_allies_neutralize3 destroy();
		}
	}
	
	radio.team = "none";
	objective_team(0, "none");
	
	radio setmodel ("xmodel/objective_german_field_radio_notsolid");
	radio stoploopsound ("german_radio");
	radio stoploopsound ("german_radio_pathfinder");
	radio hide();
	radio.hidden = true;
	objective_delete(0);
	
	level.reinforcement_time = level.wavetime;
	level.graceperiod = false;
	level notify ("Timer Changed");
	level thread hq_reinforcement_timer();
	level hq_obj_think(radio);
	level thread hq_removhudelem_allplayers(radio);
}

hq_removeall_hudelems(player)
{
	if (isdefined (self))
	{
		for ( i=0 ; i<level.radio.size ; i++ )
		{
			if ( (isdefined (player.radioicon)) && (isdefined (player.radioicon[0])) )
				player.radioicon[0] destroy();
			if(isdefined(player.progressbar_capture))
				player.progressbar_capture destroy();
			if(isdefined(player.progressbar_capture2))
				player.progressbar_capture2 destroy();
			if(isdefined(player.progressbar_capture3))
				player.progressbar_capture3 destroy();
		}
		if (isdefined (player.respawntimer))
			player.respawntimer destroy();
	}
}

hq_removhudelem_allplayers(radio)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if (!isdefined (players[i]))
			continue;
		if ( (isdefined (players[i].radioicon)) && (isdefined (players[i].radioicon[0])) )
			players[i].radioicon[0] destroy();
		if(isdefined(players[i].progressbar_capture))
			players[i].progressbar_capture destroy();
		if(isdefined(players[i].progressbar_capture2))
			players[i].progressbar_capture2 destroy();
		if(isdefined(players[i].progressbar_capture3))
			players[i].progressbar_capture3 destroy();
	}
}

hq_reinforcements_hud()
{
	if(!isDefined(level.reinforcement_hud_bgnd))
	{
		level.reinforcement_hud_bgnd = newHudElem();
		level.reinforcement_hud_bgnd.archived = false;
		level.reinforcement_hud_bgnd.alpha = 0.4;
		level.reinforcement_hud_bgnd.x = 495;
		level.reinforcement_hud_bgnd.y = 410;
		level.reinforcement_hud_bgnd.sort = -1;
		level.reinforcement_hud_bgnd setShader("black", 135, 15);
	}
	
	if(!isdefined(level.reinforcement_hud))
	{
		level.reinforcement_hud = newHudElem();
		level.reinforcement_hud.archived = false;
		level.reinforcement_hud.alignX = "left";
		level.reinforcement_hud.alignY = "top";
		level.reinforcement_hud.x = 497;
		level.reinforcement_hud.y = 411;
		level.reinforcement_hud.label = &"HQ_REINFORCEMENTS_HUD";
		level.reinforcement_hud setValue(0);
	}
}

hq_reinforcement_timer()
{
	level endon ("Timer Changed");
	level.counter = level.reinforcement_time;
	level notify ("timer tick");
	level hq_update_reinforcement_hud();
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if ( (isdefined (players[i].respawnwait)) && (players[i].respawnwait == true) )
		{
			players[i] notify("end_respawn");
			players[i] thread respawn("instant");
		}
	}
	
	while (!level.mapended)
	{	
		while (level.counter > 0)
		{
			if (level.counter <= 10)
				level.reinforcement_hud.color = (1, 0, 0);
			wait 1;
			level.counter--;
			if ( (level.counter == 15) && (level.teambalance > 0) )
			{
				level.checkteambalance = false;
				level thread maps\mp\gametypes\_teams::TeamBalance_Check();
			}
			level notify ("timer tick");
		}
		
		wait 1;
		
		if (level.captured_radios["axis"] > 0)
		{
			level thread hq_score_update("axis", level.wavetime);
			level.timesCaptured++;
			level thread hq_points_players("axis","defending");
			if (level.timesCaptured >= level.RadioMaxHold)
			{
				level hq_radio_resetall("allies");
				return;
			}
		}
		if (level.captured_radios["allies"] > 0)
		{
			level thread hq_score_update("allies", level.wavetime);
			level.timesCaptured++;
			level thread hq_points_players("allies","defending");
			if (level.timesCaptured >= level.RadioMaxHold)
			{
				level hq_radio_resetall("axis");
				return;
			}
		}
		
		level.graceperiod = false;
		level.counter = level.reinforcement_time;
		level notify ("timer tick");
		level hq_update_reinforcement_hud();
		level.spawnframe = 0;
	}
}

hq_update_reinforcement_hud()
{
	level.reinforcement_hud.color = (1, 1, 1);
	
	if (level.reinforcement_time > 0)
	{
		// Make sure people who were in killcam get to spawn still
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if (isdefined (players[i].killcam))
				players[i].ignoretimer = true;
		}
		
		if (level.counter > 0)
			level.reinforcement_hud setTimer(level.counter);
	}
}

hq_wavespawner_flag_remove()
{
	wait 1;
	if ( (isdefined (self)) && (isdefined (self.wavespawner)) )
		self.wavespawner = false;
}

hq_check_teams_exist()
{
	players = getentarray("player", "classname");
	level.alliesexist = false;
	level.axisexist = false;
	for(i = 0; i < players.size; i++)
	{
		if(!isdefined(players[i].pers["team"]) || players[i].pers["team"] == "spectator")
			continue;
		if (players[i].pers["team"] == "allies")
			level.alliesexist = true;
		else if (players[i].pers["team"] == "axis")
			level.axisexist = true;
		
		if (level.alliesexist && level.axisexist)
			return;
	}
}
/*
addBotClients()
{
	wait 5;

	for(i = 0; i < 40; i++)
	{
		ent[i] = addtestclient();
		wait 0.5;

		if(isPlayer(ent[i]))
		{
			ent[i] notify("menuresponse", game["menu_team"], "axis");
			wait 0.5;
			ent[i] notify("menuresponse", game["menu_weapon_axis"], "kar98k_mp");
		}
	}
}
*/

// ----------------------------------------------------------------------------------
//	dropHealth
// ----------------------------------------------------------------------------------
dropHealth()
{
	if ( !getcvarint("scr_drophealth") )
		return;
		
	if(isDefined(level.healthqueue[level.healthqueuecurrent]))
		level.healthqueue[level.healthqueuecurrent] delete();
	
	level.healthqueue[level.healthqueuecurrent] = spawn("item_health", self.origin + (0, 0, 1));
	level.healthqueue[level.healthqueuecurrent].angles = (0, randomint(360), 0);

	level.healthqueuecurrent++;
	
	if(level.healthqueuecurrent >= 16)
		level.healthqueuecurrent = 0;
}
