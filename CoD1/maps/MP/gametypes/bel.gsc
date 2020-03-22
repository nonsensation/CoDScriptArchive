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
	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();

	allowed[0] = "bel";
	maps\mp\gametypes\_gameobjects::main(allowed);

	if(getcvar("scr_bel_timelimit") == "")
		setcvar("scr_bel_timelimit", "30");
	else if(getcvarfloat("scr_bel_timelimit") > 1440)
		setcvar("scr_bel_timelimit", "1440");
	level.timelimit = getcvarfloat("scr_bel_timelimit");

	if(getcvar("scr_bel_scorelimit") == "")
		setcvar("scr_bel_scorelimit", "50");
	level.playerscorelimit = getcvarint("scr_bel_scorelimit");

	if(getcvar("scr_bel_alivepointtime") == "")
		setcvar("scr_bel_alivepointtime", "10");
	level.AlivePointTime = getcvarint("scr_bel_alivepointtime");

	if(getcvar("scr_bel_positiontime") == "")
		setcvar("scr_bel_positiontime", "6");
	level.PositionUpdateTime = getcvarint("scr_bel_positiontime");

	if(getcvar("scr_bel_respawndelay") == "")
		setcvar("scr_bel_respawndelay", "0");

	if(getcvar("scr_bel_showoncompass") == "")
		setcvar("scr_bel_showoncompass", "1");

	if(getcvar("scr_friendlyfire") == "")
		setcvar("scr_friendlyfire", "0");

	if(getcvar("scr_drawfriend") == "")
		setcvar("scr_drawfriend", "0");
	level.drawfriend = getcvarint("scr_drawfriend");

	if(getcvar("g_allowvote") == "")
		setcvar("g_allowvote", "1");
	level.allowvote = getcvarint("g_allowvote");
	setcvar("scr_allow_vote", level.allowvote);

	if(!isdefined(game["state"]))
		game["state"] = "playing";

	level.mapended = false;
	level.alliesallowed = 1;
	
	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(spawnpoints.size > 0)
	{
		for(i = 0; i < spawnpoints.size; i++)
			spawnpoints[i] placeSpawnpoint();
	}
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
		
	setarchive(true);
}

Callback_StartGameType()
{
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

	if(getcvar("scr_allies") != "")
		game["allies"] = getcvar("scr_allies");
	if(getcvar("scr_axis") != "")
		game["axis"] = getcvar("scr_axis");

	game["menu_team"] = "team_germanonly";
	
	game["menu_weapon_all"] = "weapon_" + game["allies"] + game["axis"];
	game["menu_weapon_allies_only"] = "weapon_" + game["allies"];
	game["menu_weapon_axis_only"] = "weapon_" + game["axis"];
	game["menu_viewmap"] = "viewmap";
	game["menu_callvote"] = "callvote";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	game["headicon_allies"] = "gfx/hud/headicon@allies.tga";
	game["headicon_axis"] = "gfx/hud/headicon@axis.tga";

	precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	precacheString(&"MPSCRIPT_KILLCAM");
	precacheString(&"BEL_TIME_ALIVE");
	precacheString(&"BEL_TIME_TILL_SPAWN");
	precacheString(&"BEL_PRESS_TO_RESPAWN");
	precacheString(&"BEL_POINTS_EARNED");
	precacheString(&"BEL_WONTBE_ALLIED");
	precacheString(&"BEL_BLACKSCREEN_KILLEDALLIED");
	precacheString(&"BEL_BLACKSCREEN_WILLSPAWN");
	
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_all"]);
	precacheMenu(game["menu_weapon_allies_only"]);
	precacheMenu(game["menu_weapon_axis_only"]);
	precacheMenu(game["menu_viewmap"]);
	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);

	precacheShader("black");
	precacheShader("gfx/hud/hud@objective_bel.tga");
	precacheShader("gfx/hud/hud@objective_bel_up.tga");
	precacheShader("gfx/hud/hud@objective_bel_down.tga");
	precacheShader("hudScoreboard_mp");
	precacheShader("gfx/hud/hud@mpflag_spectator.tga");
	precacheHeadIcon("gfx/hud/headicon@killcam_arrow");
	precacheHeadIcon(game["headicon_allies"]);
	precacheHeadIcon(game["headicon_axis"]);
	precacheStatusIcon("gfx/hud/hud@status_dead.tga");
	precacheStatusIcon("gfx/hud/hud@status_connecting.tga");

	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::precache();
	maps\mp\gametypes\_teams::scoreboard();
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();

	setClientNameMode("auto_change");

	thread startGame();
	thread updateScriptCvars();
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";
	self.god = false;
	self.respawnwait = false;
	
	if(!isdefined(self.pers["team"]))
		iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	logPrint("J;" + lpselfnum + ";" + self.name + "\n");

	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}

	level endon("intermission");
	
	if (isdefined (self.blackscreen))
		self.blackscreen destroy();
	if (isdefined (self.blackscreentext))
		self.blackscreentext destroy();
	if (isdefined (self.blackscreentext2))
		self.blackscreentext2 destroy();
	if (isdefined (self.blackscreentimer))
		self.blackscreentimer destroy();

	if(isdefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("scr_showweapontab", "1");

		if(self.pers["team"] == "allies")
			self.sessionteam = "allies";
		else
			self.sessionteam = "axis";
		
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
		
		if(isdefined(self.pers["weapon"]))
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
		self setClientCvar("scr_showweapontab", "0");

		if(!isdefined(self.pers["team"]))
			self openMenu(game["menu_team"]);

		self.pers["team"] = "spectator";
		self.sessionteam = "spectator";
		
		spawnSpectator();
	}

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		if(response == "open" || response == "close")
			continue;

		if(menu == game["menu_team"])
		{
			switch(response)
			{
				case "axis":
					if ( (self.pers["team"] != "axis") && (self.pers["team"] != "allies") )
					{
						self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis_only"]);
						self.pers["team"] = "axis";
						if (isdefined (self.blackscreen))
							self.blackscreen destroy();
						if (isdefined (self.blackscreentext))
							self.blackscreentext destroy();
						if (isdefined (self.blackscreentext2))
							self.blackscreentext2 destroy();
						if (isdefined (self.blackscreentimer))
							self.blackscreentimer destroy();
						CheckAllies_andMoveAxis_to_Allies(self);
						if (self.pers["team"] == "axis")
						{
							self thread printJoinedTeam("axis");
							self move_to_axis();
						}
						else if (self.pers["team"] == "allies")
							self thread printJoinedTeam("allies");
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
						self setClientCvar("scr_showweapontab", "0");
						if (isdefined (self.blackscreen))
							self.blackscreen destroy();
						if (isdefined (self.blackscreentext))
							self.blackscreentext destroy();
						if (isdefined (self.blackscreentext2))
							self.blackscreentext2 destroy();
						if (isdefined (self.blackscreentimer))
							self.blackscreentimer destroy();
						self spawnSpectator();
						CheckAllies_andMoveAxis_to_Allies();
					}
					break;

				case "weapon":
					if ( (self.pers["team"] == "axis") || (self.pers["team"] == "allies") )
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
			
			if(!isdefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;
			
			weapon = self maps\mp\gametypes\_teams::restrict_anyteam(response);

			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}
			
			axisweapon = false;
			if (response == "kar98k_mp")
				axisweapon = true;
			else if (response == "mp40_mp")
				axisweapon = true;
			else if (response == "mp44_mp")
				axisweapon = true;
			else if (response == "kar98k_sniper_mp")
				axisweapon = true;

			if(isdefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
				continue;

			if(!isdefined(self.pers["weapon"]))
			{
				if (axisweapon == true)
					self.pers["LastAxisWeapon"] = weapon;
				else
					self.pers["LastAlliedWeapon"] = weapon;

				if (self.respawnwait != true)
				{
					if (self.pers["team"] == "allies")
					{
						if (axisweapon == true)
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
					else if (self.pers["team"] == "axis")
					{
						if (axisweapon != true)
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
				if ( (self.sessionstate != "playing") && (self.respawnwait != true) )
				{
					if (isdefined (self.pers["team"]))
					{
						if ( (self.pers["team"] == "allies") && (axisweapon != true) )
							self.pers["LastAlliedWeapon"] = weapon;
						else if ( (self.pers["team"] == "axis") && (axisweapon == true) )
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
					if (axisweapon == true)
					{
						self.pers["LastAxisWeapon"] = weapon;
						if (maps\mp\gametypes\_teams::useAn(weapon))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_AN", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_A", weaponname);
					}
					else
					{
						self.pers["LastAlliedWeapon"] = weapon;
						if (maps\mp\gametypes\_teams::useAn(weapon))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_AN", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_A", weaponname);
					}

					if ( (self.pers["team"] == "allies") && (axisweapon != true) )
						self.pers["nextWeapon"] = weapon;
					else if ( (self.pers["team"] == "axis") && (axisweapon == true) )
						self.pers["nextWeapon"] = weapon;
					else
						continue;
				}

				if (isdefined (self.pers["team"]))
				{	
					if (axisweapon != true)
					{
						self.pers["LastAlliedWeapon"] = weapon;
						continue;
					}
					else if (axisweapon == true)
					{
						self.pers["LastAxisWeapon"] = weapon;
						continue;
					}
				}
				continue;
			}
		}
		else if(menu == game["menu_viewmap"])
		{
			switch(response)
			{
				case "team":
					self openMenu(game["menu_team"]);
					break;

				case "weapon":
					if ( (self.pers["team"] == "axis") || (self.pers["team"] == "allies") )
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
					if ( (self.pers["team"] == "axis") || (self.pers["team"] == "allies") )
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
	}
}

Callback_PlayerDisconnect()
{
	iprintln(&"MPSCRIPT_DISCONNECTED", self);

	lpselfnum = self getEntityNumber();
	logPrint("Q;" + lpselfnum + ";" + self.name + "\n");

	self.pers["team"] = "spectator";
	self check_delete_objective();
	CheckAllies_andMoveAxis_to_Allies();
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if ( (isdefined (eAttacker)) && (isPlayer(eAttacker)) && (isdefined (eAttacker.god)) && (eAttacker.god == true) )
		return;

	if ( (self.sessionteam == "spectator") || (self.god == true) )
		return;
	
	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// check for completely getting out of the damage
	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(getCvarInt("scr_friendlyfire") <= 0)
				return;

			if(getCvarInt("scr_friendlyfire") == 2)
				reflect = true;
		}
	}

	// Apply the damage to the player
	if(!isdefined(reflect))
	{
		// Make sure at least one point of damage is done
		if(iDamage < 1)
			iDamage = 1;

		self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
	}
	else
	{
		eAttacker.reflectdamage = true;

		iDamage = iDamage * .5;

		// Make sure at least one point of damage is done
		if(iDamage < 1)
			iDamage = 1;

		eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
		eAttacker.reflectdamage = undefined;
	}

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
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isdefined(reflect)) 
		{  
			lpattacknum = lpselfnum;
			lpattackname = lpselfname;
			lpattackerteam = lpattackerteam;
		}

		logPrint("D;" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	self endon("spawned");
	self notify ("Stop give points");
	
	self check_delete_objective();
	
	if ( (self.sessionteam == "spectator") || (self.god == true) )
		return;
	
	obituary(self, attacker, sWeapon, sMeansOfDeath);
	
	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";
	
	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.deaths++;
	self.headicon = "";

	body = self cloneplayer();
	self dropItem(self getcurrentweapon());
	self updateDeathArray();

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfteam = self.pers["team"];
	lpattackerteam = "";
	
	attackerNum = -1;
	if(isPlayer(attacker))
	{
		lpattacknum = attacker getEntityNumber();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
		logPrint("K;" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
		
		if(attacker == self) // player killed himself
		{
			if(isdefined(attacker.reflectdamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
			
			self.score--;
			if (self.pers["team"] == "allies")
			{
				if (Number_On_Team("axis") < 1)
					self thread respawn("auto");
				else
				{
					self move_to_axis();
					CheckAllies_andMoveAxis_to_Allies(undefined, self);
					self thread respawn();
				}
			}
			else
				self thread respawn();
			return;
		}
		else if(self.pers["team"] == attacker.pers["team"]) // player was killed by a friendly
		{
			attacker.score--;
			if (attacker.pers["team"] == "allies")
			{
				attacker move_to_axis();
				CheckAllies_andMoveAxis_to_Allies();
			}
			self thread respawn();
			return;
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			if (self.pers["team"] == "allies") //Allied player was killed by an Axis
			{
				attacker.god = true;
				iprintln (&"BEL_KILLED_ALLIED_SOLDIER",attacker);
				
				self thread killcam (attackerNum, 2, "allies to axis");
				Set_Number_Allowed_Allies(Number_On_Team("axis"));
				if (Number_On_Team("allies") < level.alliesallowed)
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
			
				self thread killcam (attackerNum, 2, "axis to axis");
				return;
			}
		}
	}
	else // Player wasn't killed by another player or themself (landmines, etc.)
	{
		lpattacknum = -1;
		lpattackname = "";
		lpattackerteam = "world";
		logPrint("K;" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
		
		self.score--;
		if (self.pers["team"] == "allies")
		{
			if (Number_On_Team("axis") < 1)
				self thread respawn("auto");
			else
			{
				self move_to_axis();
				CheckAllies_andMoveAxis_to_Allies(undefined, self);
				self thread respawn();
			}
		}
		else
			self thread respawn();
	}
}

spawnPlayer()
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("stop weapon timeout");
	self notify ("do_timer_cleanup");
	
	resettimeout();

	self.respawnwait = false;
	self.sessionteam = self.pers["team"];
	self.lastteam = self.pers["team"];
	self.sessionstate = "playing";
	self.reflectdamage = undefined;
	
	if (isdefined(self.spawnMsg))
		self.spawnMsg destroy();

	spawnpointname = "mp_teamdeathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);

	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	self.pers["savedmodel"] = undefined;
	
	maps\mp\gametypes\_teams::model();

	maps\mp\gametypes\_teams::loadout();
	
	self setClientCvar("scr_showweapontab", "1");
	self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
	
	if (self.pers["team"] == "allies")
	{
		if (isdefined (self.pers["LastAlliedWeapon"]))
			self.pers["weapon"] = self.pers["LastAlliedWeapon"];
		else
		{
			if (isdefined (self.pers["nextWeapon"]))
			{
				self.pers["weapon"] = self.pers["nextWeapon"];
				self.pers["nextWeapon"] = undefined;
			}
		}
	}
	else if (self.pers["team"] == "axis")
	{
		if (isdefined (self.pers["LastAxisWeapon"]))
			self.pers["weapon"] = self.pers["LastAxisWeapon"];
		else
		{
			if (isdefined (self.pers["nextWeapon"]))
			{
				self.pers["weapon"] = self.pers["nextWeapon"];
				self.pers["nextWeapon"] = undefined;
			}
		}
	}

	self giveWeapon(self.pers["weapon"]);
	self giveMaxAmmo(self.pers["weapon"]);
	self setSpawnWeapon(self.pers["weapon"]);
	
	self.archivetime = 0;
	
	if(self.pers["team"] == "allies")
	{
		self thread make_obj_marker();
		self setClientCvar("cg_objectiveText", &"BEL_OBJ_ALLIED");
	}
	else if(self.pers["team"] == "axis")
		self setClientCvar("cg_objectiveText", &"BEL_OBJ_AXIS");

	if (level.drawfriend == 1)
	{
		if(self.pers["team"] == "allies")
		{
			self.headicon = game["headicon_allies"];
			self.headiconteam = "allies";
		}
		else if(self.pers["team"] == "axis")
		{
			self.headicon = game["headicon_axis"];
			self.headiconteam = "axis";
		}
		else
		{
			self.headicon = "";
		}
	}
	self.god = false;
	wait 0.05;
	if (isdefined (self))
	{
		if (isdefined (self.blackscreen))
			self.blackscreen destroy();
		if (isdefined (self.blackscreentext))
			self.blackscreentext destroy();
		if (isdefined (self.blackscreentext2))
			self.blackscreentext2 destroy();
		if (isdefined (self.blackscreentimer))
			self.blackscreentimer destroy();
	}
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
	self.reflectdamage = undefined;
	self.pers["savedmodel"] = undefined;
	self.headicon = "";

	spawnpointname = "mp_teamdeathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self setClientCvar("cg_objectiveText", &"BEL_SPECTATOR_OBJS");
}

spawnIntermission()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.reflectdamage = undefined;

	spawnpointname = "mp_teamdeathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");

	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);

	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	
	if (isdefined (self.blackscreen))
		self.blackscreen destroy();
	if (isdefined (self.blackscreentext))
		self.blackscreentext destroy();
	if (isdefined (self.blackscreentext2))
		self.blackscreentext2 destroy();
	if (isdefined (self.blackscreentimer))
		self.blackscreentimer destroy();
}

respawn(noclick, delay)
{
	self endon("end_respawn");
	
	if (!isdefined (delay))
		delay = 2;
	wait delay;

	if (isdefined (self))
	{
		if (!isdefined (noclick))
		{
			if(getcvarint("scr_bel_respawndelay") > 0)
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

	if (self.spawnTimer)
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
	self endon ("respawn");
	self endon ("end_respawn");
	
	respawntime = getcvarint("scr_bel_respawndelay");
	wait .1;
	
	if (!isdefined(self.toppart))
	{
		self.spawnMsg = newClientHudElem(self);
		self.spawnMsg.alignX = "center";
		self.spawnMsg.alignY = "middle";
		self.spawnMsg.x = 305;
		self.spawnMsg.y = 140;
		self.spawnMsg.fontScale = 1.5;
	}
	self.spawnMsg setText(&"BEL_TIME_TILL_SPAWN");
	
	if (!isdefined(self.spawnTimer))
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

	wait (respawntime);

	self notify("do_timer_cleanup");
	self.spawnMsg setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
}

Respawn_HUD_NoTimer()
{
	self endon ("respawn");
	self endon ("end_respawn");
	
	wait .1;
	if (!isdefined(self.spawnMsg))
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
	wait getcvarint("scr_bel_respawndelay");
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
	level notify ("End of Round");
	game["state"] = "intermission";
	level notify("intermission");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isdefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;

		if(!isdefined(highscore))
		{
			highscore = player.score;
			playername = player;
			name = player.name;
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
		}
	}

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");

		if(isdefined(tied) && tied == true)
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_THE_GAME_IS_A_TIE");
		else if(isdefined(playername))
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_WINS", playername);
		
		player spawnIntermission();
	}
	if (isdefined (name))
		logPrint("W;;" + name + "\n");
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

	endMap();
}

checkScoreLimit()
{
	if(level.playerscorelimit <= 0)
		return;

	if(self.score < level.playerscorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	endMap();
}

updateScriptCvars()
{
	count = 1;
	for(;;)
	{
		timelimit = getcvarfloat("scr_bel_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setcvar("scr_bel_timelimit", "1440");
			}

			level.timelimit = timelimit;
			level.starttime = getTime();

			if(level.timelimit > 0)
			{
				if (!isdefined(level.clock))
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
				if (isdefined(level.clock))
					level.clock destroy();
			}

			checkTimeLimit();
		}

		scorelimit = getcvarint("scr_bel_scorelimit");
		if(level.playerscorelimit != scorelimit)
		{
			level.playerscorelimit = scorelimit;

			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				players[i] checkScoreLimit();
		}

		drawfriend = getcvarfloat("scr_drawfriend");
		if(level.drawfriend != drawfriend)
		{
			level.drawfriend = drawfriend;

			if(level.drawfriend)
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];

					if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
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
					}
				}
			}
			else
			{
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];

					if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
						player.headicon = "";
				}
			}
		}

		allowvote = getcvarint("g_allowvote");
		if(level.allowvote != allowvote)
		{
			level.allowvote = allowvote;
			setcvar("scr_allow_vote", allowvote);
		}

		level notify ("update obj");

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
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers = [];
			alliedplayers[alliedplayers.size] = players[i];
			numOnTeam["allies"]++;
		}
		else if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers = [];
			axisplayers[axisplayers.size] = players[i];
			numOnTeam["axis"]++;
		}
	}

	Set_Number_Allowed_Allies(numOnTeam["axis"]);
	
	if (numOnTeam["allies"] == level.alliesallowed)
	{
		return;
	}
	
	if (numOnTeam["allies"] < level.alliesallowed)
	{
		if ( (isdefined (playertomove)) && (playertomove.pers["team"] != "allies") )
		{
			playertomove move_to_allies(undefined, 2, undefined, 2);
		}
		else if (isdefined (playernottomove))
			move_random_axis_to_allied(playernottomove);
		else
			move_random_axis_to_allied();

		if (level.alliesallowed > 1)
			iprintln(&"BEL_ADDING_ALLIED");

		return;
	}
	
	if (numOnTeam["allies"] > (level.alliesallowed + 1))
	{
		move_random_allied_to_axis();
		iprintln(&"BEL_REMOVING_ALLIED");
		return;
	}
	if ( (numOnTeam["allies"] > level.alliesallowed) && (level.alliesallowed == 1) )
	{
		move_random_allied_to_axis();
		iprintln(&"BEL_REMOVING_ALLIED");
		return;
	}
}

Set_Number_Allowed_Allies(axis)
{
	if (axis > 30)
		level.alliesallowed = 11;
	else if (axis > 27)
		level.alliesallowed = 10;
	else if (axis > 24)
		level.alliesallowed = 9;
	else if (axis > 21)
		level.alliesallowed = 8;
	else if (axis > 18)
		level.alliesallowed = 7;
	else if (axis > 15)
		level.alliesallowed = 6;
	else if (axis > 12)
		level.alliesallowed = 5;
	else if (axis > 9)
		level.alliesallowed = 4;
	else if (axis > 6)
		level.alliesallowed = 3;
	else if (axis > 3)
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
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers[axisplayers.size] = players[i];
			if ( (isdefined (playernottoinclude)) && (playernottoinclude == players[i]) )
				continue;
			candidates[candidates.size] = players[i];
		}
	}
	if (axisplayers.size == 1)
	{
		num = randomint(axisplayers.size);
		iprintln(&"BEL_IS_NOW_ALLIED",axisplayers[num]);
		axisplayers[num] move_to_allies(undefined, 2, undefined, 2);
	}
	else if (axisplayers.size > 1)
	{
		if (candidates.size > 0)
		{
			num = randomint(candidates.size);
			iprintln(&"BEL_IS_NOW_ALLIED",candidates[num]);
			candidates[num] move_to_allies(undefined, 2, undefined, 2);
			return;
		}
		else
		{
			num = randomint(axisplayers.size);
			iprintln(&"BEL_IS_NOW_ALLIED",axisplayers[num]);
			axisplayers[num] move_to_allies(undefined, 2, undefined, 2);
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
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers = [];
			alliedplayers[alliedplayers.size] = players[i];
			numOnTeam["allies"]++;
		}
	}
	if (numOnTeam["allies"] > 0)
	{
		num = randomint(alliedplayers.size);
		iprintln(&"BEL_MOVED_TO_AXIS",alliedplayers[num]);
		alliedplayers[num] move_to_axis();
	}
}

move_to_axis(delay, respawnoption)
{
	if (isplayer (self))
	{
		self check_delete_objective();
		self.pers["nextWeapon"] = undefined;
		self.pers["lastweapon1"] = undefined;
		self.pers["lastweapon2"] = undefined;
		self.pers["savedmodel"] = undefined;
		self.pers["team"] = ("axis");
		self.sessionteam = ("axis");

		if (isdefined (delay))
			wait delay;

		if (isplayer (self))
		{
			if (!isdefined (self.pers["LastAxisWeapon"]))
			{
				self spawnSpectator();
				
				self setClientCvar("scr_showweapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis_only"]);
				self openMenu(game["menu_weapon_axis_only"]);
			}
			else
			{
				self setClientCvar("scr_showweapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
				
				if ( (isdefined (delay)) && (isdefined (respawnoption)) && (respawnoption == "nodelay on respawn") )
					self thread respawn("auto",0);
				else
					self thread respawn("auto");
			}
		}
	}
}

move_to_allies(nospawn, delay, respawnoption, blackscreen)
{
	if (isplayer (self))
	{
		self.god = true;
		self.pers["team"] = ("allies");
		self.sessionteam = ("allies");
		self.lastteam = ("allies");
		self.pers["nextWeapon"] = undefined;
		self.pers["lastweapon1"] = undefined;
		self.pers["lastweapon2"] = undefined;
		self.pers["savedmodel"] = undefined;

		if (isdefined (delay))
		{
			if (blackscreen == 1)
			{
				if (!isdefined (self.blackscreen))
					self blackscreen();
			}
			else if (blackscreen == 2)
			{
				if (!isdefined (self.blackscreen))
					self blackscreen(2);
			}
			wait 2;
		}
		
		if (isplayer (self))
		{
			if (!isdefined (self.pers["LastAlliedWeapon"]))
			{
				self spawnSpectator();
				
				self setClientCvar("scr_showweapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies_only"]);
				self openMenu(game["menu_weapon_allies_only"]);
				
				self thread auto_giveweapon_allied();
				return;
			}
			else
			{
				self setClientCvar("scr_showweapontab", "1");
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
				
				if ( (isdefined (delay)) && (isdefined (respawnoption)) && (respawnoption == "nodelay on respawn") )
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
}

allied_hud_element()
{
	wait .1;
	
	if (!isdefined(self.hud_bgnd))
	{
		self.hud_bgnd = newClientHudElem(self);
		self.hud_bgnd.alpha = 0.2;
		self.hud_bgnd.x = 505;
		self.hud_bgnd.y = 382;
		self.hud_bgnd.sort = -1;
		self.hud_bgnd setShader("black", 130, 35);
	}
	
	if (!isdefined(self.hud_clock))
	{
		self.hud_clock = newClientHudElem(self);
		self.hud_clock.x = 520;
		self.hud_clock.y = 385;
		self.hud_clock.label = &"BEL_TIME_ALIVE";
	}
	self.hud_clock setTimerUp(0);
	
	if (!isdefined(self.hud_points))
	{
		self.hud_points = newClientHudElem(self);
		self.hud_points.x = 520;
		self.hud_points.y = 401;
		self.hud_points.label = &"BEL_POINTS_EARNED";
		self.hud_points setValue(1);
	}

	self thread give_allied_points();
}

check_delete_objective()
{
	if (isdefined(self.hud_points))
		self.hud_points destroy();
	if (isdefined(self.hud_clock))
		self.hud_clock destroy();
	if (isdefined(self.hud_bgnd))
		self.hud_bgnd destroy();
	
	self notify ("Stop Blip");
	objnum = ((self getEntityNumber()) + 1);
	objective_delete(objnum);
}

make_obj_marker()
{
	level endon ("End of Round");
	self endon ("Stop Blip");
	self endon ("death");	
	count1 = 1;
	count2 = 1;
	
	if(getcvar("scr_bel_showoncompass") == "1")
	{
		objnum = ((self getEntityNumber()) + 1);
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
	
	while ((isplayer (self)) && (isalive(self)))
	{
		level waittill ("update obj");
	
		if (self.health < 100)
			self.health = (self.health + 3);
	
		if (count1 != level.PositionUpdateTime)
			count1++;
		else
		{
			count1 = 1;
			if(getcvar("scr_bel_showoncompass") == "1")
			{
				lastobjpos = newobjpos;
				newobjpos = ( ((lastobjpos[0] + self.origin[0]) * 0.5), ((lastobjpos[1] + self.origin[1]) * 0.5), ((lastobjpos[2] + self.origin[2]) * 0.5) );
				objective_position(objnum, newobjpos);
			}
		}
	}
}

give_allied_points()
{
	level endon ("End of Round");
	self endon ("Stop give points");
	self endon ("Stop Blip");
	self endon ("death");
	
	lpselfnum = self getEntityNumber();
	
	PointsEarned = 1;
	while ((isplayer (self)) && (isalive(self)))
	{
		wait level.AlivePointTime;
		self.score++;
		PointsEarned++;
		self.god = false; //failsafe to fix a very rare bug
		logPrint("A;" + lpselfnum + ";allies;" + self.name + ";bel_alive_tick\n");
		self.hud_points setValue(PointsEarned);
		self checkScoreLimit();
	}
}

auto_giveweapon_allied()
{
	self endon ("end_respawn");
	self endon ("stop weapon timeout");

	wait 6;
	if ( (isplayer (self)) && (self.sessionstate == "spectator") )
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
	if (!isdefined (didntkill))
	{
		self.blackscreentext = newClientHudElem(self);
		self.blackscreentext.sort = -1;
		self.blackscreentext.archived = false;
		self.blackscreentext.alignX = "center";
		self.blackscreentext.alignY = "middle";
		self.blackscreentext.x = 320;
		self.blackscreentext.y = 220;
		self.blackscreentext settext (&"BEL_BLACKSCREEN_KILLEDALLIED");
	}
	
	self.blackscreentext2 = newClientHudElem(self);
	self.blackscreentext2.sort = -1;
	self.blackscreentext2.archived = false;
	self.blackscreentext2.alignX = "center";
	self.blackscreentext2.alignY = "middle";
	self.blackscreentext2.x = 320;
	self.blackscreentext2.y = 240;
	self.blackscreentext2 settext (&"BEL_BLACKSCREEN_WILLSPAWN");
	
	self.blackscreentimer = newClientHudElem(self);
	self.blackscreentimer.sort = -1;
	self.blackscreentimer.archived = false;
	self.blackscreentimer.alignX = "center";
	self.blackscreentimer.alignY = "middle";
	self.blackscreentimer.x = 320;
	self.blackscreentimer.y = 260;
	self.blackscreentimer settimer (2);
	
	self.blackscreen = newClientHudElem(self);
	self.blackscreen.sort = -2;
	self.blackscreen.archived = false;
	self.blackscreen.alignX = "left";
	self.blackscreen.alignY = "top";
	self.blackscreen.x = 0;
	self.blackscreen.y = 0;
	self.blackscreen.alpha = 1;
	self.blackscreen setShader("black", 640, 480);
	if (!isdefined (didntkill))
	{
		self.blackscreen.alpha = 0;
		self.blackscreen fadeOverTime(1.5);
	}
	self.blackscreen.alpha = 1;
}

Number_On_Team(team)
{
	players = getentarray("player", "classname");

	if (team == "axis")
	{
		numOnTeam["axis"] = 0;
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
				numOnTeam["axis"]++;
		}
		return numOnTeam["axis"];
	}
	else if (team == "allies")
	{
		numOnTeam["allies"] = 0;
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
				numOnTeam["allies"]++;
		}
		return numOnTeam["allies"];
	}
}

updateDeathArray()
{
	if(!isdefined(level.deatharray))
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
	self notify ("stop client print");
	self endon ("stop client print");
	
	if (!isdefined(self.print))
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
	if (isdefined(self.kc_topbar))
		self.kc_topbar destroy();
	if (isdefined(self.kc_bottombar))
		self.kc_bottombar destroy();
	if (isdefined(self.kc_title))
		self.kc_title destroy();
	if (isdefined(self.kc_skiptext))
		self.kc_skiptext destroy();
	if (isdefined(self.kc_timer))
		self.kc_timer destroy();
}

killcam(attackerNum, delay, option)
{
	self endon("spawned");

	if(attackerNum < 0)
		return;

	if (option == "axis to axis")
		wait 2;
	else if (option == "allies to axis")
	{
		self.pers["team"] = ("axis");
		self.sessionteam = ("axis");
		wait 2;
	}

	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.archivetime = delay + 7;
	
	wait 0.05;

	if(self.archivetime <= delay)
	{
		self.spectatorclient = -1;
		self.archivetime = 0;

		if (option == "axis to axis")
		{
			if (!isalive (self))
				self thread respawn("auto",0);
		}
		else if (option == "allies to axis")
			self move_to_axis(0,"nodelay on respawn");
	
		return;
	}

	if (!isdefined(self.kc_topbar))
	{
		self.kc_topbar = newClientHudElem(self);
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader("black", 640, 112);
	}
	
	if (!isdefined(self.kc_bottombar))
	{
		self.kc_bottombar = newClientHudElem(self);
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader("black", 640, 112);
	}
	
	if (!isdefined(self.kc_title))
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
	
	if (!isdefined(self.kc_skiptext))
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

	if (!isdefined(self.kc_timer))
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

	if (option == "axis to axis")
	{
		if (!isalive (self))
			self thread respawn("auto",0);
	}
	else if (option == "allies to axis")
		self move_to_axis(0,"nodelay on respawn");
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

printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}
