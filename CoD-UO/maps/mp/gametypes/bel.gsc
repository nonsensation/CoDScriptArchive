/*
	Behind Enemy Lines
	Number of Allies: The more people playing in the round the more Allies there will be. Currently the Allied:Axis radio is about 1:3-4
	Allied Objective: Kill as many German players as possible before being overrun. You gain more points the longer you stay alive
	Axis objective: Hunt down Allied players
	Map ends:	When a player reaches the score limit, or time limit is reached
	Respawning: 	Axis respawn as Axis when they die, and Allied players respawn as Axis when they die
			An Axis who kills an Allied player will take that Allied players spot on the Allied team
			Uses TDM spawnpoints so all TDM maps automatically support this gametype

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_teamdeathmatch_spawn
			All players spawn from these. The spawnpoint chosen one is dependent on the current locations of teammates and enemies
			at the time of spawn. Players generally spawn away from enemies.

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

	allowed[0] = "bel";
	maps\mp\gametypes\_gameobjects::main(allowed);

	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();
	
	if(getCvar("scr_bel_timelimit") == "")		// Time limit per map
		setCvar("scr_bel_timelimit", "30");
	else if(getCvarFloat("scr_bel_timelimit") > 1440)
		setCvar("scr_bel_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_bel_timelimit");
	setCvar("ui_bel_timelimit", level.timelimit);
	makeCvarServerInfo("ui_bel_timelimit", "30");

	if(getCvar("scr_bel_scorelimit") == "")		// Score limit per map
		setCvar("scr_bel_scorelimit", "50");
	level.scorelimit = getCvarInt("scr_bel_scorelimit");
	setCvar("ui_bel_scorelimit", level.scorelimit);
	makeCvarServerInfo("ui_bel_scorelimit", "50");

	if(getCvar("scr_bel_alivepointtime") == "")
		setCvar("scr_bel_alivepointtime", "10");
	level.AlivePointTime = getCvarInt("scr_bel_alivepointtime");

	if(getCvar("scr_bel_positiontime") == "")
		setCvar("scr_bel_positiontime", "6");
	level.PositionUpdateTime = getCvarInt("scr_bel_positiontime");

	if(getCvar("scr_bel_respawndelay") == "")
		setCvar("scr_bel_respawndelay", "0");

	if(getCvar("scr_bel_showoncompass") == "")
		setCvar("scr_bel_showoncompass", "1");

	if(getCvar("scr_battlerank") == "")		
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");

	if(getCvar("scr_shellshock") == "")		// controls whether or not players get shellshocked from grenades or rockets
		setCvar("scr_shellshock", "1");
	setCvar("ui_shellshock", getCvar("scr_shellshock"));
	makeCvarServerInfo("ui_shellshock", "0");
			
	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	if(getCvar("scr_drophealth") == "")		
		setCvar("scr_drophealth", "1");

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
	
	if(getCvar("scr_drawfriend") == "")		// Draws a team icon over teammates
		setCvar("scr_drawfriend", "1");
	level.drawfriend = getCvarInt("scr_drawfriend");

	if(getCvar("g_allowvote") == "")
		setCvar("g_allowvote", "1");
	level.allowvote = getCvarInt("g_allowvote");
	setCvar("scr_allow_vote", level.allowvote);

	if(!isDefined(game["state"]))
		game["state"] = "playing";

	// turn off ceasefire
	level.ceasefire = 0;
	setCvar("scr_ceasefire", "0");

	level.mapended = false;
	level.alliesallowed = 1;
	
	level.healthqueue = [];
	level.healthqueuecurrent = 0;

	level.numallies = 0;
	level.numaxis = 0;
	
	if(level.killcam >= 1)
		setarchive(true);
	
	level.objused = [];
	for (i=0;i<16;i++)
		level.objused[i] = false;
}

GetNextObjNum()
{
	for (i=0;i<16;i++)
	{
		if (level.objused[i] == true)
			continue;
		
		level.objused[i] = true;
		return ( i + 1 );
	}
	return -1;
}

Callback_StartGameType()
{
	if(!isDefined(game["allies"]))
		game["allies"] = "american";
	if(!isDefined(game["axis"]))
		game["axis"] = "german";

	if(!isDefined(game["layoutimage"]))
		game["layoutimage"] = "default";
	layoutname = "levelshots/layouts/hud@layout_" + game["layoutimage"];
	precacheShader(layoutname);
	setCvar("scr_layoutimage", layoutname);
	makeCvarServerInfo("scr_layoutimage", "");

	if(getCvar("scr_allies") != "")
		game["allies"] = getCvar("scr_allies");
	if(getCvar("scr_axis") != "")
		game["axis"] = getCvar("scr_axis");

	game["menu_team"] = "team_germanonly";
	
	game["menu_serverinfo"] = "serverinfo_" + getCvar("g_gametype");
	game["menu_weapon_all"] = "weapon_" + game["allies"] + game["axis"];
	game["menu_weapon_allies_only"] = "weapon_" + game["allies"];
	game["menu_weapon_axis_only"] = "weapon_" + game["axis"];
	game["menu_viewmap"] = "viewmap";
	game["menu_callvote"] = "callvote";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	game["menu_quickvehicles"] = "quickvehicles";
	game["menu_quickrequests"] = "quickrequests";

	precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	precacheString(&"MPSCRIPT_KILLCAM");
	precacheString(&"BEL_TIME_ALIVE");
	precacheString(&"BEL_TIME_TILL_SPAWN");
	precacheString(&"BEL_PRESS_TO_RESPAWN");
	precacheString(&"BEL_POINTS_EARNED");
	precacheString(&"BEL_WONTBE_ALLIED");
	precacheString(&"BEL_BLACKSCREEN_KILLEDALLIED");
	precacheString(&"BEL_BLACKSCREEN_WILLSPAWN");
	precacheString(&"GMI_MP_CEASEFIRE");
	
	precacheMenu(game["menu_serverinfo"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_all"]);
	precacheMenu(game["menu_weapon_allies_only"]);
	precacheMenu(game["menu_weapon_axis_only"]);
	precacheMenu(game["menu_viewmap"]);
	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
	precacheMenu(game["menu_quickvehicles"]);
	precacheMenu(game["menu_quickrequests"]);

	precacheShader("black");
	precacheShader("gfx/hud/hud@objective_bel.tga");
	precacheShader("gfx/hud/hud@objective_bel_up.tga");
	precacheShader("gfx/hud/hud@objective_bel_down.tga");
	precacheShader("hudScoreboard_mp");
	precacheShader("gfx/hud/hud@mpflag_spectator.tga");
	precacheHeadIcon("gfx/hud/headicon@killcam_arrow");
	precacheStatusIcon("gfx/hud/hud@status_dead.tga");
	precacheStatusIcon("gfx/hud/hud@status_connecting.tga");
	precacheItem("item_health");	

	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::precache();
	maps\mp\gametypes\_teams::scoreboard();
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_teams::updateWeaponCvars();

	setClientNameMode("auto_change");

	thread startGame();
	thread updateGametypeCvars();
	
	// if fs_copyfiles is set then we are building paks and cache everything
	if ( getcvar("fs_copyfiles") == "1")
	{
		precacheMenu("weapon_russian");
		precacheMenu("weapon_american");
		precacheMenu("weapon_british");
		precacheMenu("weapon_russiangerman");
		precacheMenu("weapon_britishgerman");
		precacheMenu("weapon_americangerman");
	}
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";
	self.god = false;
	self.respawnwait = false;
	
	if(!isDefined(self.pers["team"]))
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

	if(isDefined(self.blackscreen))
		self.blackscreen destroy();
	if(isDefined(self.blackscreentext))
		self.blackscreentext destroy();
	if(isDefined(self.blackscreentext2))
		self.blackscreentext2 destroy();
	if(isDefined(self.blackscreentimer))
		self.blackscreentimer destroy();

	if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		if ( maps\mp\gametypes\_teams::isweaponavailable(self.pers["team"]))
		{
			self setClientCvar("ui_weapontab", "1");
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
		}
		else
		{
			self setClientCvar("ui_weapontab", "0");
			self setClientCvar("g_scriptMainMenu", game["menu_team"]);
		}

		if(self.pers["team"] == "allies")
			self.sessionteam = "allies";
		else
			self.sessionteam = "axis";
		
		if(isDefined(self.pers["weapon"]) || !maps\mp\gametypes\_teams::isweaponavailable(self.pers["team"]))
		{
			spawnPlayer();
		}
		else
		{
			spawnSpectator();

			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies_only"]);
			else
				self openMenu(game["menu_weapon_axis_only"]);
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
				case "axis":
					if((self.pers["team"] != "axis") && (self.pers["team"] != "allies"))
					{
						if ( maps\mp\gametypes\_teams::isweaponavailable("axis"))
						{
							self setClientCvar("ui_weapontab", "1");
							self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis_only"]);
						}
						else
						{
							self setClientCvar("ui_weapontab", "0");
							self setClientCvar("g_scriptMainMenu", game["menu_team"]);
						}
						self.pers["team"] = "axis";
						if(isDefined(self.blackscreen))
							self.blackscreen destroy();
						if(isDefined(self.blackscreentext))
							self.blackscreentext destroy();
						if(isDefined(self.blackscreentext2))
							self.blackscreentext2 destroy();
						if(isDefined(self.blackscreentimer))
							self.blackscreentimer destroy();
						
						CheckAllies_andMoveAxis_to_Allies(self);
						if(self.pers["team"] == "axis")
						{
							self thread printJoinedTeam("axis");
							self move_to_axis();
						}
						else if(self.pers["team"] == "allies")
							self thread printJoinedTeam("allies");
						
						// update spectator permissions immediately on change of team
						maps\mp\gametypes\_teams::SetSpectatePermissions();
					}
					break;

				case "spectator":
					if(self.pers["team"] != "spectator")
					{
						self.pers["team"] = "spectator";
						self.pers["weapon"] = undefined;
						self.pers["LastAxisWeapon"] = undefined;
						self.pers["LastAlliedWeapon"] = undefined;
						self.pers["savedmodel"] = undefined;
						self.sessionteam = "spectator";
						self setClientCvar("g_scriptMainMenu", game["menu_team"]);
						self setClientCvar("ui_weapontab", "0");
						if(isDefined(self.blackscreen))
							self.blackscreen destroy();
						if(isDefined(self.blackscreentext))
							self.blackscreentext destroy();
						if(isDefined(self.blackscreentext2))
							self.blackscreentext2 destroy();
						if(isDefined(self.blackscreentimer))
							self.blackscreentimer destroy();
						self spawnSpectator();
						CheckAllies_andMoveAxis_to_Allies();
					}
					break;

				case "weapon":
					if((self.pers["team"] == "axis") || (self.pers["team"] == "allies"))
						self openMenu(game["menu_weapon_all"]);
					break;

				case "viewmap":
					self openMenu(game["menu_viewmap"]);
					break;

				case "callvote":
					self openMenu(game["menu_callvote"]);
					break;
			}
		}		
		else if(menu == game["menu_weapon_all"] || menu == game["menu_weapon_allies_only"] || menu == game["menu_weapon_axis_only"])
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
			
			if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;
			
			weapon = self maps\mp\gametypes\_teams::restrict_anyteam(response);

			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}
			
			axisweapon = false;
			if(response == "kar98k_mp")
				axisweapon = true;
			else if(response == "mp40_mp")
				axisweapon = true;
			else if(response == "mp44_mp")
				axisweapon = true;
			else if(response == "kar98k_sniper_mp")
				axisweapon = true;
			else if(response == "gewehr43_mp")
				axisweapon = true;
			else if(response == "mg34_mp")
				axisweapon = true;
			
			if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
				continue;

			if(!isDefined(self.pers["weapon"]))
			{
				if(axisweapon == true)
					self.pers["LastAxisWeapon"] = weapon;
				else
					self.pers["LastAlliedWeapon"] = weapon;

				if(self.respawnwait != true)
				{
					if(self.pers["team"] == "allies")
					{
						if(axisweapon == true)
						{
							self openMenu(menu);
							continue;
						}
						else
						{
							self.pers["weapon"] = weapon;
							spawnPlayer();
						}

					}
					else if(self.pers["team"] == "axis")
					{
						if(axisweapon != true)
						{
							self openMenu(menu);
							continue;
						}
						else
						{
							self.pers["weapon"] = weapon;
							spawnPlayer();
						}
					}
				}
			}
			else
			{
				if((self.sessionstate != "playing") && (self.respawnwait != true))
				{
					if(isDefined(self.pers["team"]))
					{
						if((self.pers["team"] == "allies") && (axisweapon != true))
							self.pers["LastAlliedWeapon"] = weapon;
						else if((self.pers["team"] == "axis") && (axisweapon == true))
							self.pers["LastAxisWeapon"] = weapon;
						else
							continue;

						self.pers["weapon"] = weapon;
						spawnPlayer();
					}
				}
				else
				{
					weaponname = maps\mp\gametypes\_teams::getWeaponName(weapon);			
					if(axisweapon == true)
					{
						self.pers["LastAxisWeapon"] = weapon;
						if(maps\mp\gametypes\_teams::useAn(weapon))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_AN", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_A", weaponname);
					}
					else
					{
						self.pers["LastAlliedWeapon"] = weapon;
						if(maps\mp\gametypes\_teams::useAn(weapon))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_AN", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_A", weaponname);
					}

					if((self.pers["team"] == "allies") && (axisweapon != true))
						self.pers["nextWeapon"] = weapon;
					else if((self.pers["team"] == "axis") && (axisweapon == true))
						self.pers["nextWeapon"] = weapon;
					else
						continue;
				}

				if(isDefined(self.pers["team"]))
				{	
					if(axisweapon != true)
					{
						self.pers["LastAlliedWeapon"] = weapon;
						continue;
					}
					else if(axisweapon == true)
					{
						self.pers["LastAxisWeapon"] = weapon;
						continue;
					}
				}
				continue;
			}
			self thread maps\mp\gametypes\_teams::SetSpectatePermissions();
		}
		else if(menu == game["menu_viewmap"])
		{
			switch(response)
			{
				case "team":
					self openMenu(game["menu_team"]);
					break;

				case "weapon":
					if((self.pers["team"] == "axis") || (self.pers["team"] == "allies"))
						self openMenu(game["menu_weapon_all"]);
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
					if((self.pers["team"] == "axis") || (self.pers["team"] == "allies"))
						self openMenu(game["menu_weapon_all"]);
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

	self.pers["team"] = "spectator";
	self check_delete_objective();
	CheckAllies_andMoveAxis_to_Allies();
	
	count_num_players();
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if((isDefined(eAttacker)) && (isPlayer(eAttacker)) && (isDefined(eAttacker.god)) && (eAttacker.god == true))
		return;

	if((self.sessionteam == "spectator") || (self.god == true))
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
		lpselfGuid = self getGuid();
		lpselfteam = self.pers["team"];
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackGuid = eAttacker getGuid();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isDefined(friendly)) 
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
	self notify("Stop give points");
	
	self check_delete_objective();
	
	if((self.sessionteam == "spectator") || (self.god == true))
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

	obituary(self, attacker, sWeapon, sMeansOfDeath);
	
	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.deaths++;
	self.headicon = "";
	
	body = self cloneplayer();
	self dropItem(self getcurrentweapon());
	// Make the player drop health
	self dropHealth();
	self updateDeathArray();

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfguid = self getGuid();
	lpselfteam = self.pers["team"];
	lpattackerteam = "";
	
	attackerNum = -1;
	if(isPlayer(attacker))
	{
		lpattacknum = attacker getEntityNumber();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
		lpattackguid = attacker getGuid();
		logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
		
		if(attacker == self) // player killed himself
		{
			if(isDefined(attacker.friendlydamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
			
			self.score--;
			if(self.pers["team"] == "allies")
			{
				if(Number_On_Team("axis") < 1)
					self thread respawn("auto");
				else
				{
					self move_to_axis();
					CheckAllies_andMoveAxis_to_Allies(undefined, self);
				}
			}
			else
				self thread respawn();
			return;
		}
		else if(self.pers["team"] == attacker.pers["team"]) // player was killed by a friendly
		{
			attacker.score--;
			if(attacker.pers["team"] == "allies")
			{
				attacker move_to_axis();
				CheckAllies_andMoveAxis_to_Allies(undefined, attacker);
			}
			self thread respawn();
			return;
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			if(self.pers["team"] == "allies") //Allied player was killed by an Axis
			{
				attacker.god = true;
				iprintln(&"BEL_KILLED_ALLIED_SOLDIER",attacker);
				
				self thread killcam(attackerNum, 2, "allies to axis");
				
				Set_Number_Allowed_Allies(Number_On_Team("axis"));
				
				if(Number_On_Team("allies") < level.alliesallowed)
					attacker move_to_allies(undefined, 2, "nodelay on respawn", 1);
				else
				{
					attacker.god = false;
					attacker thread client_print(&"BEL_WONTBE_ALLIED");
				}
				return;
			}
			else //Axis player was killed by Allies
			{
				attacker.score++;
				attacker checkScoreLimit();
			
				// Stop thread if map ended on this death
				if(level.mapended)
					return;	
			
				//if(getCvarInt("scr_killcam") >= 1)
				self thread killcam(attackerNum, 2, "axis to axis");
					
				return;
			}
		}
	}
	else // Player wasn't killed by another player or themself (landmines, etc.)
	{
		lpattacknum = -1;
		lpattackname = "";
		lpattackguid = "";
		lpattackerteam = "world";
		logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
		
		self.score--;
		if(self.pers["team"] == "allies")
		{
			if(Number_On_Team("axis") < 1)
				self thread respawn("auto");
			else
			{
				self move_to_axis();
				CheckAllies_andMoveAxis_to_Allies(undefined, self);
			}
		}
		else
			self thread respawn();
	}
}

// ----------------------------------------------------------------------------------
//	menu_spawn
//
// 		called from the player connect to spawn the player
// ----------------------------------------------------------------------------------
menu_spawn(weapon)
{
}

spawnPlayer()
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("stop weapon timeout");
	self notify("do_timer_cleanup");
	
	resettimeout();

	self.respawnwait = false;
	self.sessionteam = self.pers["team"];
	self.lastteam = self.pers["team"];
	self.sessionstate = "playing";
	self.friendlydamage = undefined;
	
	if(isDefined(self.spawnMsg))
		self.spawnMsg destroy();

	// make sure that the client compass is at the correct zoom specified by the level
	self setClientCvar("cg_hudcompassMaxRange", game["compass_range"]);

	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self.pers["rank"] = maps\mp\gametypes\_rank_gmi::DetermineBattleRank(self);
	self.rank = self.pers["rank"];
	
	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	self.pers["savedmodel"] = undefined;
	
	maps\mp\gametypes\_teams::model();

	maps\mp\gametypes\_teams::givePistol();
	
	if ( maps\mp\gametypes\_teams::isweaponavailable("axis") || maps\mp\gametypes\_teams::isweaponavailable("allies"))
	{
		self setClientCvar("ui_weapontab", "1");
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
	}
	else
	{
		self setClientCvar("ui_weapontab", "0");
		self setClientCvar("g_scriptMainMenu", game["menu_team"]);
	}
	
	if(self.pers["team"] == "allies")
	{
		if(isDefined(self.pers["LastAlliedWeapon"]))
			self.pers["weapon"] = self.pers["LastAlliedWeapon"];
		else
		{
			if(isDefined(self.pers["nextWeapon"]))
			{
				self.pers["weapon"] = self.pers["nextWeapon"];
				self.pers["nextWeapon"] = undefined;
			}
		}
	}
	else if(self.pers["team"] == "axis")
	{
		if(isDefined(self.pers["LastAxisWeapon"]))
			self.pers["weapon"] = self.pers["LastAxisWeapon"];
		else
		{
			if(isDefined(self.pers["nextWeapon"]))
			{
				self.pers["weapon"] = self.pers["nextWeapon"];
				self.pers["nextWeapon"] = undefined;
			}
		}
	}
	
	// setup all the weapons
	self maps\mp\gametypes\_loadout_gmi::PlayerSpawnLoadout();
	self.archivetime = 0;
	
	if(self.pers["team"] == "allies")
	{
		self thread make_obj_marker();
		self setClientCvar("cg_objectiveText", &"BEL_OBJ_ALLIED");
	}
	else if(self.pers["team"] == "axis")
		self setClientCvar("cg_objectiveText", &"BEL_OBJ_AXIS");

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
	self.god = false;
	//wait 0.05;
	if(isDefined(self))
	{
		if(isDefined(self.blackscreen))
			self.blackscreen destroy();
		if(isDefined(self.blackscreentext))
			self.blackscreentext destroy();
		if(isDefined(self.blackscreentext2))
			self.blackscreentext2 destroy();
		if(isDefined(self.blackscreentimer))
			self.blackscreentimer destroy();
	}

	// setup the hud rank indicator
	self thread maps\mp\gametypes\_rank_gmi::RankHudInit();
}

spawnSpectator()
{	
	self notify("spawned");
	self notify("end_respawn");
	
	self check_delete_objective();
	
	resettimeout();
	
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	self.pers["savedmodel"] = undefined;
	self.headicon = "";
	
	maps\mp\gametypes\_teams::SetSpectatePermissions();
	
	spawnpointname = "mp_teamdeathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self setClientCvar("cg_objectiveText", &"BEL_SPECTATOR_OBJS");
	
	count_num_players();
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

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	
	if(isDefined(self.blackscreen))
		self.blackscreen destroy();
	if(isDefined(self.blackscreentext))
		self.blackscreentext destroy();
	if(isDefined(self.blackscreentext2))
		self.blackscreentext2 destroy();
	if(isDefined(self.blackscreentimer))
		self.blackscreentimer destroy();
}

respawn(noclick, delay)
{
	self endon("end_respawn");
	
	if(!isDefined(delay))
		delay = 2;
	wait delay;

	if(isDefined(self))
	{
		if(!isDefined(noclick))
		{
			if(getCvarInt("scr_bel_respawndelay") > 0)
			{
				self thread waitForceRespawnTime();
				self waittill("respawn");
			}
			else
			{
				self thread spawnPlayer();
				return;
			}
		}
		else
			self thread spawnPlayer();
	}
}

Respawn_HUD_Timer_Cleanup()
{
	self waittill("do_timer_cleanup");

	if(self.spawnTimer)
		self.spawnTimer destroy();
}

Respawn_HUD_Timer_Cleanup_Wait(message)
{
	self endon("do_timer_cleanup");

	self waittill(message);
	self notify("do_timer_cleanup");
}

Respawn_HUD_Timer()
{
	self endon("respawn");
	self endon("end_respawn");
	
	respawntime = getCvarInt("scr_bel_respawndelay");
	wait .1;
	
	if(!isDefined(self.toppart))
	{
		self.spawnMsg = newClientHudElem(self);
		self.spawnMsg.alignX = "center";
		self.spawnMsg.alignY = "middle";
		self.spawnMsg.x = 305;
		self.spawnMsg.y = 140;
		self.spawnMsg.fontScale = 1.5;
	}
	self.spawnMsg setText(&"BEL_TIME_TILL_SPAWN");
	
	if(!isDefined(self.spawnTimer))
	{
		self.spawnTimer = newClientHudElem(self);
		self.spawnTimer.alignX = "center";
		self.spawnTimer.alignY = "middle";
		self.spawnTimer.x = 305;
		self.spawnTimer.y = 155;
		self.spawnTimer.fontScale = 1.5;
	}
	self.spawnTimer setTimer(respawntime);

	self thread Respawn_HUD_Timer_Cleanup_Wait("respawn");
	self thread Respawn_HUD_Timer_Cleanup_Wait("end_respawn");
	self thread Respawn_HUD_Timer_Cleanup();

	wait(respawntime);

	self notify("do_timer_cleanup");

	if ( getcvar("scr_forcerespawn") == "1" )
		return;
	self.spawnMsg setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
}

Respawn_HUD_NoTimer()
{
	self endon("respawn");
	self endon("end_respawn");
	
	if ( getcvar("scr_forcerespawn") == "1" )
		return;
		
	wait .1;
	if(!isDefined(self.spawnMsg))
	{
		self.spawnMsg = newClientHudElem(self);
		self.spawnMsg.alignX = "center";
		self.spawnMsg.alignY = "middle";
		self.spawnMsg.x = 305;
		self.spawnMsg.y = 140;
		self.spawnMsg.fontScale = 1.5;
	}
	self.spawnMsg setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
}

waitForceRespawnTime()
{
	self endon("end_respawn");
	self endon("respawn");

	self.respawnwait = true;
	self thread Respawn_HUD_Timer();
	wait getCvarInt("scr_bel_respawndelay");
	self thread waitForceRespawnButton();
}

waitForceRespawnButton()
{
	self endon("end_respawn");
	self endon("respawn");

	while(self useButtonPressed() != true)
		wait .05;

	self notify("respawn");
}

startGame()
{
	level.starttime = getTime();
	if(level.timelimit > 0)
	{
		level.clock = newHudElem();
		level.clock.alignX = "center";
		level.clock.alignY = "middle";
		level.clock.x = 320;
		level.clock.y = 460;
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
	level notify("End of Round");
	game["state"] = "intermission";
	level notify("intermission");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		player.pers["team"] = "none";
		player.sessionteam = "none";
		
		if(isDefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;
		
		if(!isDefined(highscore))
		{
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
			continue;
		}

		if(player.score == highscore)
			tied = true;
		else if(player.score > highscore)
		{
			tied = false;
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
		}
	}

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");

		if(isDefined(tied) && tied == true)
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_THE_GAME_IS_A_TIE");
		else if(isDefined(playername))
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_WINS", playername);
		
		player spawnIntermission();
	}
	if(isDefined(name))
		logPrint("W;;" + guid + ";" + name + "\n");
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

	level thread endMap();
}

checkScoreLimit()
{
	if(level.scorelimit <= 0)
		return;

	if(self.score < level.scorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	level thread endMap();
}

updateGametypeCvars()
{
	count = 1;
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

		timelimit = getCvarFloat("scr_bel_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_bel_timelimit", "1440");
			}

			level.timelimit = timelimit;
			setCvar("ui_bel_timelimit", level.timelimit);
			level.starttime = getTime();

			if(level.timelimit > 0)
			{
				if(!isDefined(level.clock))
				{
					level.clock = newHudElem();
					level.clock.alignX = "center";
					level.clock.alignY = "middle";
					level.clock.x = 320;
					level.clock.y = 460;
					level.clock.font = "bigfixed";
				}
				level.clock setTimer(level.timelimit * 60);
			}
			else
			{
				if(isDefined(level.clock))
					level.clock destroy();
			}

			checkTimeLimit();
		}

		scorelimit = getCvarInt("scr_bel_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_bel_scorelimit", level.scorelimit);

			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				players[i] checkScoreLimit();
		}

		drawfriend = getCvarint("scr_drawfriend");
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
		
		level notify("update obj");

		wait 1;
	}
}

CheckAllies_andMoveAxis_to_Allies(playertomove, playernottomove)
{
	numOnTeam["allies"] = 0;
	numOnTeam["axis"] = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers = [];
			alliedplayers[alliedplayers.size] = players[i];
			numOnTeam["allies"]++;
		}
		else if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers = [];
			axisplayers[axisplayers.size] = players[i];
			numOnTeam["axis"]++;
		}
	}

	Set_Number_Allowed_Allies(numOnTeam["axis"]);
	
	if(numOnTeam["allies"] == level.alliesallowed)
		return;
	
	if(numOnTeam["allies"] < level.alliesallowed)
	{
		if((isDefined(playertomove)) && (playertomove.pers["team"] != "allies"))
		{
			playertomove move_to_allies(undefined, 2, undefined, 2);
			if(!isDefined(playertomove.blackscreen))
					playertomove blackscreen(2);
		}
		else if(isDefined(playernottomove))
			move_random_axis_to_allied(playernottomove);
		else
			move_random_axis_to_allied();

		if(level.alliesallowed > 1)
			iprintln(&"BEL_ADDING_ALLIED");

		return;
	}
	
	if(numOnTeam["allies"] > (level.alliesallowed + 1))
	{
		move_random_allied_to_axis();
		iprintln(&"BEL_REMOVING_ALLIED");
		return;
	}
	if((numOnTeam["allies"] > level.alliesallowed) && (level.alliesallowed == 1) && (numOnTeam["axis"] < 2))
	{
		move_random_allied_to_axis();
		iprintln(&"BEL_REMOVING_ALLIED");
		return;
	}
}

Set_Number_Allowed_Allies(axis)
{
	if(axis > 48)
		level.alliesallowed = 16;
	else if(axis > 45)
		level.alliesallowed = 15;
	else if(axis > 42)
		level.alliesallowed = 14;
	else if(axis > 39)
		level.alliesallowed = 13;
	else if(axis > 36)
		level.alliesallowed = 12;
	else if(axis > 30)
		level.alliesallowed = 11;
	else if(axis > 27)
		level.alliesallowed = 10;
	else if(axis > 24)
		level.alliesallowed = 9;
	else if(axis > 21)
		level.alliesallowed = 8;
	else if(axis > 18)
		level.alliesallowed = 7;
	else if(axis > 15)
		level.alliesallowed = 6;
	else if(axis > 12)
		level.alliesallowed = 5;
	else if(axis > 9)
		level.alliesallowed = 4;
	else if(axis > 6)
		level.alliesallowed = 3;
	else if(axis > 3)
		level.alliesallowed = 2;
	else
		level.alliesallowed = 1;
}

move_random_axis_to_allied(playernottoinclude)
{
	candidates = [];
	axisplayers = [];
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers[axisplayers.size] = players[i];
			if((isDefined(playernottoinclude)) && (playernottoinclude == players[i]))
				continue;
			candidates[candidates.size] = players[i];
		}
	}
	if(axisplayers.size == 1)
	{
		level.numaxis--;
		level.numallies++;
		num = randomint(axisplayers.size);
		iprintln(&"BEL_IS_NOW_ALLIED",axisplayers[num]);
		axisplayers[num] move_to_allies(undefined, undefined, undefined, 2);
		if(!isDefined(axisplayers[num].blackscreen))
					axisplayers[num] blackscreen(2);
	}
	else if(axisplayers.size > 1)
	{
		if(candidates.size > 0)
		{
			level.numaxis--;
			level.numallies++;
			num = randomint(candidates.size);
			iprintln(&"BEL_IS_NOW_ALLIED",candidates[num]);
			candidates[num] move_to_allies(undefined, undefined, undefined, 2);
			if(!isDefined(candidates[num].blackscreen))
					candidates[num] blackscreen(2);
			return;
		}
		else
		{
			level.numaxis--;
			level.numallies++;
			num = randomint(axisplayers.size);
			iprintln(&"BEL_IS_NOW_ALLIED",axisplayers[num]);
			axisplayers[num] move_to_allies(undefined, undefined, undefined, 2);
			if(!isDefined(axisplayers[num].blackscreen))
					axisplayers[num] blackscreen(2);
			return;
		}
	}
}

move_random_allied_to_axis()
{
	numOnTeam["allies"] = 0;
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers = [];
			alliedplayers[alliedplayers.size] = players[i];
			numOnTeam["allies"]++;
		}
	}
	if(numOnTeam["allies"] > 0)
	{
		num = randomint(alliedplayers.size);
		iprintln(&"BEL_MOVED_TO_AXIS",alliedplayers[num]);
		alliedplayers[num] move_to_axis();
	}
}

move_to_axis(delay, respawnoption)
{
	if(isPlayer(self))
	{
		self check_delete_objective();
		self.pers["nextWeapon"] = undefined;
		self.pers["lastweapon1"] = undefined;
		self.pers["lastweapon2"] = undefined;
		self.pers["savedmodel"] = undefined;
		self.pers["team"] = "axis";
		self.sessionteam = "axis";
		
		maps\mp\gametypes\_teams::SetSpectatePermissions();
		
		if(isDefined(delay))
			wait delay;

		if(isPlayer(self))
		{
			if(!isDefined(self.pers["LastAxisWeapon"]) && maps\mp\gametypes\_teams::isweaponavailable("axis"))
			{
				self spawnSpectator();
				
				self setClientCvar("ui_weapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis_only"]);
				self openMenu(game["menu_weapon_axis_only"]);
			}
			else
			{
				if ( maps\mp\gametypes\_teams::isweaponavailable("axis") || maps\mp\gametypes\_teams::isweaponavailable("allies"))
				{
					self setClientCvar("ui_weapontab", "1");
					self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
				}
				else
				{
					self setClientCvar("ui_weapontab", "0");
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
				}
				
				if((isDefined(delay)) && (isDefined(respawnoption)) && (respawnoption == "nodelay on respawn"))
					self thread respawn("auto",0);
				else
					self thread respawn("auto");
			}
		}
	}
	count_num_players();
}

move_to_allies(nospawn, delay, respawnoption, blackscreen)
{
	if(isPlayer(self))
	{
		self.god = true;
		self.pers["team"] = "allies";
		self.sessionteam = "allies";
		self.lastteam = "allies";
		self.pers["nextWeapon"] = undefined;
		self.pers["lastweapon1"] = undefined;
		self.pers["lastweapon2"] = undefined;
		self.pers["savedmodel"] = undefined;
		
		maps\mp\gametypes\_teams::SetSpectatePermissions();
		
		if(isDefined(delay))
		{
			if(blackscreen == 1)
			{
				if(!isDefined(self.blackscreen))
					self blackscreen();
			}
			else if(blackscreen == 2)
			{
				if(!isDefined(self.blackscreen))
					self blackscreen(2);
			}
			wait 2;
		}
		
		if(isPlayer(self))
		{
			if(!isDefined(self.pers["LastAlliedWeapon"]) && maps\mp\gametypes\_teams::isweaponavailable("allies"))
			{
				self spawnSpectator();
				
				self setClientCvar("ui_weapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies_only"]);
				self openMenu(game["menu_weapon_allies_only"]);
				
				self thread auto_giveweapon_allied();
				return;
			}
			else
			{
				if ( maps\mp\gametypes\_teams::isweaponavailable("axis") || maps\mp\gametypes\_teams::isweaponavailable("allies"))
				{
					self setClientCvar("ui_weapontab", "1");
					self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
				}
				else
				{
					self setClientCvar("ui_weapontab", "0");
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
				}
				
				if((isDefined(delay)) && (isDefined(respawnoption)) && (respawnoption == "nodelay on respawn"))
					self thread respawn("auto",0);
				else
					self thread respawn("auto");
			}
		}
		else
		{
			self.god = false;
		}
	}
	
	count_num_players();
}


moveall_spectator()
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		players[i] thread spawnSpectator();
	}

	count_num_players();
}

count_num_players()
{
	numOnTeam["allies"] = 0;
	numOnTeam["axis"] = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers = [];
			alliedplayers[alliedplayers.size] = players[i];
			numOnTeam["allies"]++;
		}
		else if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers = [];
			axisplayers[axisplayers.size] = players[i];
			numOnTeam["axis"]++;
		}
	}

	level.numallies = numOnTeam["allies"];
	level.numaxis = numOnTeam["axis"];
}


allied_hud_element()
{
	wait .1;
	
	if(!isDefined(self.hud_bgnd))
	{
		self.hud_bgnd = newClientHudElem(self);
		self.hud_bgnd.alpha = 0.2;
		self.hud_bgnd.x = 505;
		self.hud_bgnd.y = 382;
		self.hud_bgnd.sort = -1;
		self.hud_bgnd setShader("black", 130, 35);
	}
	
	if(!isDefined(self.hud_clock))
	{
		self.hud_clock = newClientHudElem(self);
		self.hud_clock.alignx = "right";
		self.hud_clock.x = 620;
		self.hud_clock.y = 385;
		self.hud_clock.label = &"BEL_TIME_ALIVE";
	}
	self.hud_clock setTimerUp(0);
	
	if(!isDefined(self.hud_points))
	{
		self.hud_points = newClientHudElem(self);
		self.hud_points.alignx = "right";
		self.hud_points.x = 620;
		self.hud_points.y = 401;
		self.hud_points.label = &"BEL_POINTS_EARNED";
		self.hud_points setValue(1);
	}

	self thread give_allied_points();
}

check_delete_objective()
{
	if(isDefined(self.hud_points))
		self.hud_points destroy();
	if(isDefined(self.hud_clock))
		self.hud_clock destroy();
	if(isDefined(self.hud_bgnd))
		self.hud_bgnd destroy();
	
	self notify("Stop Blip");
	//objnum = ((self getEntityNumber()) + 1);
	if (isdefined (self.objnum))
	{
		objective_delete(self.objnum);
		level.objused[(self.objnum - 1)] = false;
		self.objnum = undefined;
	}
}

make_obj_marker()
{
	level endon("End of Round");
	self endon("Stop Blip");
	self endon("death");	
	count1 = 1;
	count2 = 1;
	
	if(getCvar("scr_bel_showoncompass") == "1")
	{
		//objnum = ((self getEntityNumber()) + 1);
		objnum = GetNextObjNum();
		self.objnum = objnum;
		objective_add(objnum, "current", self.origin, "gfx/hud/hud@objective_bel.tga");
		objective_icon(objnum,"gfx/hud/hud@objective_bel.tga");
		objective_team(objnum,"axis");
		objective_position(objnum, self.origin);
		lastobjpos = self.origin;
		newobjpos = self.origin;
	}
	self.score++;
	self checkScoreLimit();
	
	self thread allied_hud_element();
	
	while((isPlayer(self)) && (isAlive(self)))
	{
		level waittill("update obj");
	
		if(self.health < 100)
			self.health = (self.health + 3);
	
		if(count1 != level.PositionUpdateTime)
			count1++;
		else
		{
			count1 = 1;
			if(getCvar("scr_bel_showoncompass") == "1")
			{
				lastobjpos = newobjpos;
				newobjpos = (((lastobjpos[0] + self.origin[0]) * 0.5), ((lastobjpos[1] + self.origin[1]) * 0.5), ((lastobjpos[2] + self.origin[2]) * 0.5));
				objective_position(objnum, newobjpos);
			}
		}
	}
}

give_allied_points()
{
	level endon("End of Round");
	self endon("Stop give points");
	self endon("Stop Blip");
	self endon("death");
	
	lpselfnum = self getEntityNumber();
	guid = self getGuid();
	PointsEarned = 1;
	while((isPlayer(self)) && (isAlive(self)))
	{
		wait level.AlivePointTime;
		
		// if there is no axis team in the map do not give points
		if ( level.numaxis == 0 )
			continue;
			
		self.score++;
		PointsEarned++;
		self.god = false; //failsafe to fix a very rare bug
		logPrint("A;" + guid + ";" + lpselfnum + ";allies;" + self.name + ";bel_alive_tick\n");
		self.hud_points setValue(PointsEarned);
		self checkScoreLimit();
	}
}

auto_giveweapon_allied()
{
	self endon("end_respawn");
	self endon("stop weapon timeout");

	wait 6;
	if((isPlayer(self)) && (self.sessionstate == "spectator"))
	{
		self notify("end_respawn");
		
		switch(game["allies"])
		{
			case "american":
				self.pers["weapon"] = "m1garand_mp";
				break;
			case "british":
				self.pers["weapon"] = "enfield_mp";
				break;
			case "russian":
				self.pers["weapon"] = "mosin_nagant_mp";
				break;
		}
		self.pers["LastAlliedWeapon"] = self.pers["weapon"];
		self closeMenu();
			self thread respawn("auto");
	}
}

blackscreen(didntkill)
{
	self notify("blackscreen");
	self thread endkillcam();
	
	if(!isDefined(didntkill))
	{
		self.blackscreentext = newClientHudElem(self);
		self.blackscreentext.sort = -1;
		self.blackscreentext.archived = false;
		self.blackscreentext.alignX = "center";
		self.blackscreentext.alignY = "middle";
		self.blackscreentext.x = 320;
		self.blackscreentext.y = 220;
		self.blackscreentext settext(&"BEL_BLACKSCREEN_KILLEDALLIED");
	}
	
	self.blackscreentext2 = newClientHudElem(self);
	self.blackscreentext2.sort = -1;
	self.blackscreentext2.archived = false;
	self.blackscreentext2.alignX = "center";
	self.blackscreentext2.alignY = "middle";
	self.blackscreentext2.x = 320;
	self.blackscreentext2.y = 240;
	self.blackscreentext2 settext(&"BEL_BLACKSCREEN_WILLSPAWN");
	
	self.blackscreentimer = newClientHudElem(self);
	self.blackscreentimer.sort = -1;
	self.blackscreentimer.archived = false;
	self.blackscreentimer.alignX = "center";
	self.blackscreentimer.alignY = "middle";
	self.blackscreentimer.x = 320;
	self.blackscreentimer.y = 260;
	self.blackscreentimer settimer(2);
	
	self.blackscreen = newClientHudElem(self);
	self.blackscreen.sort = -2;
	self.blackscreen.archived = false;
	self.blackscreen.alignX = "left";
	self.blackscreen.alignY = "top";
	self.blackscreen.x = 0;
	self.blackscreen.y = 0;
	self.blackscreen.alpha = 1;
	self.blackscreen setShader("black", 640, 480);
	if(!isDefined(didntkill))
	{
		self.blackscreen.alpha = 0;
		self.blackscreen fadeOverTime(1.5);
	}
	self.blackscreen.alpha = 1;
	
	//level thread remove_blackscreen(self);
}
/*
remove_blackscreen(player)
{
	wait 4;
	if(isDefined(player))
	{
		if ( (isalive (player)) && (player.pers["team"] == "axis") )
		{
			if(isDefined(player.blackscreen))
				player.blackscreen destroy();
			if(isDefined(player.blackscreentext))
				player.blackscreentext destroy();
			if(isDefined(player.blackscreentext2))
				player.blackscreentext2 destroy();
			if(isDefined(player.blackscreentimer))
				player.blackscreentimer destroy();
		}
	}
}
*/
Number_On_Team(team)
{
	players = getentarray("player", "classname");

	if(team == "axis")
	{
		numOnTeam["axis"] = 0;
		for(i = 0; i < players.size; i++)
		{
			if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
				numOnTeam["axis"]++;
		}
		return numOnTeam["axis"];
	}
	else if(team == "allies")
	{
		numOnTeam["allies"] = 0;
		for(i = 0; i < players.size; i++)
		{
			if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
				numOnTeam["allies"]++;
		}
		return numOnTeam["allies"];
	}
}

updateDeathArray()
{
	if(!isDefined(level.deatharray))
	{
		level.deatharray[0] = self.origin;
		level.deatharraycurrent = 1;
		return;
	}

	if(level.deatharraycurrent < 4)
		level.deatharray[level.deatharraycurrent] = self.origin;
	else
	{
		level.deatharray[0] = self.origin;
		level.deatharraycurrent = 1;
		return;
	}

	level.deatharraycurrent++;
}

client_print(text)
{
	self notify("stop client print");
	self endon("stop client print");
	
	if(!isDefined(self.print))
	{
		self.print = newClientHudElem(self);
		self.print.alignX = "center";
		self.print.alignY = "middle";
		self.print.x = 320;
		self.print.y = 176;
	}
	self.print.alpha = 1;
	self.print setText(text);

	wait 3;
	self.print.alpha = .9;
	wait .9;
	self.print destroy();
}

endkillcam()
{
	if(isDefined(self.kc_topbar))
		self.kc_topbar destroy();
	if(isDefined(self.kc_bottombar))
		self.kc_bottombar destroy();
	if(isDefined(self.kc_title))
		self.kc_title destroy();
	if(isDefined(self.kc_skiptext))
		self.kc_skiptext destroy();
	if(isDefined(self.kc_timer))
		self.kc_timer destroy();
}

killcam(attackerNum, delay, option)
{
	self endon("spawned");
	self endon("blackscreen");
	
	if(attackerNum < 0)
		return;

	if(option == "axis to axis")
		wait 2;
	else if(option == "allies to axis")
	{
		self.pers["team"] = "axis";
		self.sessionteam = "axis";
		wait 2;
	}
	
	if(getCvarInt("scr_killcam") >= 1)
	{
		self.sessionstate = "spectator";
		self.spectatorclient = attackerNum;
		self.archivetime = delay + 7;
		
		maps\mp\gametypes\_teams::SetKillcamSpectatePermissions();
		
		wait 0.05;
	
		if(self.archivetime <= delay)
		{
			self.spectatorclient = -1;
			self.archivetime = 0;
			
			maps\mp\gametypes\_teams::SetSpectatePermissions();
			
			if(option == "axis to axis")
			{
				if(!isAlive(self))
					self thread respawn("auto",0);
			}
			else if(option == "allies to axis")
				self move_to_axis(0,"nodelay on respawn");
		
			return;
		}
	
		if(!isDefined(self.kc_topbar))
		{
			self.kc_topbar = newClientHudElem(self);
			self.kc_topbar.archived = false;
			self.kc_topbar.x = 0;
			self.kc_topbar.y = 0;
			self.kc_topbar.alpha = 0.5;
			self.kc_topbar setShader("black", 640, 112);
		}
		
		if(!isDefined(self.kc_bottombar))
		{
			self.kc_bottombar = newClientHudElem(self);
			self.kc_bottombar.archived = false;
			self.kc_bottombar.x = 0;
			self.kc_bottombar.y = 368;
			self.kc_bottombar.alpha = 0.5;
			self.kc_bottombar setShader("black", 640, 112);
		}
		
		if(!isDefined(self.kc_title))
		{
			self.kc_title = newClientHudElem(self);
			self.kc_title.archived = false;
			self.kc_title.x = 320;
			self.kc_title.y = 40;
			self.kc_title.alignX = "center";
			self.kc_title.alignY = "middle";
			self.kc_title.sort = 1;
			self.kc_title.fontScale = 3.5;
		}
		self.kc_title setText(&"MPSCRIPT_KILLCAM");
		
		if ( getcvar("scr_forcerespawn") != "1" )
		{
			if(!isDefined(self.kc_skiptext))
			{
				self.kc_skiptext = newClientHudElem(self);
				self.kc_skiptext.archived = false;
				self.kc_skiptext.x = 320;
				self.kc_skiptext.y = 70;
				self.kc_skiptext.alignX = "center";
				self.kc_skiptext.alignY = "middle";
				self.kc_skiptext.sort = 1;
			}
			self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
		}
		
		if(!isDefined(self.kc_timer))
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
		
		self endkillcam();
	
		self.spectatorclient = -1;
		self.archivetime = 0;
		
		maps\mp\gametypes\_teams::SetSpectatePermissions();
		
		if(option == "axis to axis")
		{
			if(!isAlive(self))
				self thread respawn("auto",0);
		}
		else if(option == "allies to axis")
			self move_to_axis(0,"nodelay on respawn");
	}
	else
	{
		self.spectatorclient = -1;
		self.archivetime = 0;

		if(option == "axis to axis")
		{
			if(!isAlive(self))
				self thread respawn("auto",0);
		}
		else if(option == "allies to axis")
			self move_to_axis(0,"nodelay on respawn");
	
		return;
	}
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");

	self waittill("spawned");
	self endkillcam();
}

waitKillcamTime()
{
	self endon("end_killcam");

	wait(self.archivetime - 0.05);
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

printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}

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
