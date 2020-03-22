/*
	Retrieval
	Attackers objective: Retrieve the specified object and return it to the specified goal
	Defenders objective: Defend the specified object
	Round ends:	When one team is eliminated, all objectives are retrieved and taken to the goal, or roundlength time is reached
	Map ends:	When one team reaches the score limit, or time limit or round limit is reached
	Respawning:	Players remain dead for the round and will respawn at the beginning of the next round

	Level requirements
	------------------
		Allied Spawnpoints:
			classname		mp_retrieval_spawn_allied
			Allied players spawn from these. Place atleast 16 of these relatively close together.

		Axis Spawnpoints:
			classname		mp_retrieval_spawn_axis
			Axis players spawn from these. Place atleast 16 of these relatively close together.

		Spectator Spawnpoints:
			classname		mp_retrieval_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

		Objective Item(s):
			classname		script_model
			targetname		retrieval_objective
			target			<Each must target their own pick up trigger, their own goal trigger, and atleast one item spawn location.>
			script_gameobjectname	retrieval
			script_objective_name	"Artillery Map" (example)
			There can be more than one of these for multiple objectives.

		Item Pick Up Trigger(s):
			classname		trigger_use
			script_gameobjectname	retrieval
			This trigger is used to pick up an objective item. This should be a 16x16 unit trigger with an origin brush placed
			so that it's center lies on the bottom plane of the trigger. Must be in the level somewhere. It is automatically
			moved to the position of the objective item targeting it.

		Item Spawn Location(s):
			classname		mp_retrieval_objective
			script_gameobjectname	retrieval
			An objective item targeting this will spawn at this location. If an objective item targets more than one it will randomly choose between them.
		
		Goal(s):
			classname		trigger_multiple
			script_gameobjectname	retrieval
			This is the area the attacking team must return an objective item to. Must contain an origin brush.

	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "american";
			game["axis"] = "german";
			This sets the nationalities of the teams. Allies can be american, british, or russian. Axis can be german.
	
			game["re_attackers"] = "allies";
			game["re_defenders"] = "axis";
			This sets which team is attacking and which team is defending. Attackers retrieve the objective items. Defenders protect them.

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

		Objective Text:
			game["re_attackers_obj_text"] = "Capture the code book";
			game["re_defenders_obj_text"] = "Defend the code book";
			game["re_spectator_obj_text"] = "Allies: Capture the code book\nAxis: Defend the code book";
			These set custom objective text. Otherwise default text is used.

	Note
	----
		Setting "script_gameobjectname" to "retrieval" on any entity in a level will cause that entity to be removed in any gametype that
		does not explicitly allow it. This is done to remove unused entities when playing a map in other gametypes that have no use for them.
*/

/*QUAKED mp_retrieval_spawn_allied (0.5 0.0 1.0) (-16 -16 0) (16 16 72)
Allied players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_retrieval_spawn_axis (1.0 0.0 0.5) (-16 -16 0) (16 16 72)
Axis players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_retrieval_intermission (0.0 0.5 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/

/*QUAKED mp_retrieval_objective (0.0 0.5 1.0) (-8 -8 -8) (8 8 8)
The objective item will spawn randomly at one of these if the objective item targets it.
*/

main()
{
	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;

	maps\mp\gametypes\_callbacksetup::SetupCallbacks();

	allowed[0] = "re";
	allowed[1] = "retrieval";
	maps\mp\gametypes\_gameobjects::main(allowed);

	if(getcvar("scr_re_timelimit") == "")		// Time limit per map
		setcvar("scr_re_timelimit", "0");
	else if(getcvarfloat("scr_re_timelimit") > 1440)
		setcvar("scr_re_timelimit", "1440");
	level.timelimit = getcvarfloat("scr_re_timelimit");

	if(!isdefined(game["timeleft"]))
		game["timeleft"] = level.timelimit;

	if(getcvar("scr_re_scorelimit") == "")		// Score limit per map
		setcvar("scr_re_scorelimit", "10");
	level.scorelimit = getcvarint("scr_re_scorelimit");

	if(getcvar("scr_re_roundlimit") == "")		// Round limit per map
		setcvar("scr_re_roundlimit", "0");
	level.roundlimit = getcvarint("scr_re_roundlimit");

	if(getcvar("scr_re_roundlength") == "")		// Time length of each round
		setcvar("scr_re_roundlength", "4");
	else if(getcvarfloat("scr_re_roundlength") > 10)
		setcvar("scr_re_roundlength", "10");
	level.roundlength = getcvarfloat("scr_re_roundlength");

	if(getcvar("scr_re_graceperiod") == "")		// Time at round start where spawning and weapon choosing is still allowed
		setcvar("scr_re_graceperiod", "15");
	else if(getcvarfloat("scr_re_graceperiod") > 60)
		setcvar("scr_re_graceperiod", "60");
	level.graceperiod = getcvarfloat("scr_re_graceperiod");

	if(getcvar("scr_friendlyfire") == "")		// Friendly fire
		setcvar("scr_friendlyfire", "0");

	if(getcvar("scr_roundcam") == "")		// Round Cam On or Off (Default 0 - off)
		setcvar("scr_roundcam", "0");

	if(getcvar("scr_drawfriend") == "")		// Draws a team icon over teammates
		setcvar("scr_drawfriend", "0");
	level.drawfriend = getcvarint("scr_drawfriend");

	if(getcvar("g_allowvote") == "")
		setcvar("g_allowvote", "1");
	level.allowvote = getcvarint("g_allowvote");
	setcvar("scr_allow_vote", level.allowvote);

	if(!isdefined(game["re_attackers"]))
		game["re_attackers"] = "allies";
	if(!isdefined(game["re_defenders"]))
		game["re_defenders"] = "axis";

	if(getcvar("scr_re_showcarrier") == "")
		setcvar("scr_re_showcarrier", "0");

	if(!isdefined(game["re_attackers_obj_text"]))
		game["re_attackers_obj_text"] = (&"RE_ATTACKERS_OBJ_TEXT_GENERIC");
	if(!isdefined(game["re_defenders_obj_text"]))
		game["re_defenders_obj_text"] = (&"RE_DEFENDERS_OBJ_TEXT_GENERIC");

	if(!isdefined(game["state"]))
		game["state"] = "playing";
	if(!isdefined(game["roundsplayed"]))
		game["roundsplayed"] = 0;
	if(!isdefined(game["matchstarted"]))
		game["matchstarted"] = false;

	if(!isdefined(game["alliedscore"]))
		game["alliedscore"] = 0;
	setTeamScore("allies", game["alliedscore"]);

	if(!isdefined(game["axisscore"]))
		game["axisscore"] = 0;
	setTeamScore("axis", game["axisscore"]);

	game["headicon_allies"] = "gfx/hud/headicon@allies.tga";
	game["headicon_axis"] = "gfx/hud/headicon@axis.tga";
	game["headicon_carrier"] = "gfx/hud/headicon@re_objcarrier.tga";

	level.roundstarted = false;
	level.roundended = false;
	level.mapended = false;

	level.exist["allies"] = 0;
	level.exist["axis"] = 0;
	level.exist["teams"] = false;
	level.didexist["allies"] = false;
	level.didexist["axis"] = false;
	level.numobjectives = 0;
	level.objectives_done = 0;
	level.hudcount = 0;
	level.barsize = 288;
	
	spawnpointname = "mp_retrieval_spawn_allied";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(spawnpoints.size > 0)
	{
		for(i = 0; i < spawnpoints.size; i++)
			spawnpoints[i] placeSpawnpoint();
	}
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	spawnpointname = "mp_retrieval_spawn_axis";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(spawnpoints.size > 0)
	{
		for(i = 0; i < spawnpoints.size; i++)
			spawnpoints[i] PlaceSpawnpoint();
	}
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i].objs_held = 0;

	//get the minefields
	level.minefield = getentarray("minefield", "targetname");

	thread retrieval();
	
	setarchive(true);
}

Callback_StartGameType()
{
	// if this is a fresh map start, set nationalities based on cvars, otherwise leave game variable nationalities as set in the level script
	if(!isdefined(game["gamestarted"]))
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

		game["menu_team"] = "team_" + game["allies"] + game["axis"];
		game["menu_weapon_allies"] = "weapon_" + game["allies"];
		game["menu_weapon_axis"] = "weapon_" + game["axis"];
		game["menu_viewmap"] = "viewmap";
		game["menu_callvote"] = "callvote";
		game["menu_quickcommands"] = "quickcommands";
		game["menu_quickstatements"] = "quickstatements";
		game["menu_quickresponses"] = "quickresponses";
		
		precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_SKIP");
		precacheString(&"MPSCRIPT_KILLCAM");
		precacheString(&"MPSCRIPT_ROUNDCAM");
		precacheString(&"MPSCRIPT_ALLIES_WIN");
		precacheString(&"MPSCRIPT_AXIS_WIN");
		precacheString(&"MPSCRIPT_STARTING_NEW_ROUND");
		precacheString(&"RE_U_R_CARRYING");
		precacheString(&"RE_U_R_CARRYING_GENERIC");
		precacheString(&"RE_PICKUP_AXIS_ONLY_GENERIC");
		precacheString(&"RE_PICKUP_AXIS_ONLY");
		precacheString(&"RE_PICKUP_ALLIES_ONLY_GENERIC");
		precacheString(&"RE_PICKUP_ALLIES_ONLY");
		precacheString(&"RE_OBJ_PICKED_UP_GENERIC");
		precacheString(&"RE_OBJ_PICKED_UP_GENERIC_NOSTARS");
		precacheString(&"RE_OBJ_PICKED_UP");
		precacheString(&"RE_OBJ_PICKED_UP_NOSTARS");
		precacheString(&"RE_PRESS_TO_PICKUP");
		precacheString(&"RE_PRESS_TO_PICKUP_GENERIC");
		precacheString(&"RE_OBJ_TIMEOUT_RETURNING");
		precacheString(&"RE_OBJ_DROPPED");
		precacheString(&"RE_OBJ_DROPPED_DEFAULT");
		precacheString(&"RE_OBJ_INMINES_MULTIPLE");
		precacheString(&"RE_OBJ_INMINES_GENERIC");
		precacheString(&"RE_OBJ_INMINES");
		precacheString(&"RE_ATTACKERS_OBJ_TEXT_GENERIC");
		precacheString(&"RE_DEFENDERS_OBJ_TEXT_GENERIC");
		precacheString(&"RE_ROUND_DRAW");
		precacheString(&"RE_MATCHSTARTING");
		precacheString(&"RE_MATCHRESUMING");
		precacheString(&"RE_TIMEEXPIRED");
		precacheString(&"RE_ELIMINATED_ALLIES");
		precacheString(&"RE_ELIMINATED_AXIS");
		precacheString(&"RE_OBJ_CAPTURED_GENERIC");
		precacheString(&"RE_OBJ_CAPTURED_ALL");
		precacheString(&"RE_OBJ_CAPTURED");
		precacheString(&"RE_RETRIEVAL");
		precacheString(&"RE_ALLIES");
		precacheString(&"RE_AXIS");
		precacheString(&"RE_OBJ_ARTILLERY_MAP");
		precacheString(&"RE_OBJ_PATROL_LOGS");
		precacheString(&"RE_OBJ_CODE_BOOK");
		precacheString(&"RE_OBJ_FIELD_RADIO");
		precacheString(&"RE_OBJ_SPY_RECORDS");
		precacheString(&"RE_OBJ_ROCKET_SCHEDULE");
		precacheString(&"RE_OBJ_CAMP_RECORDS");
		
		precacheHeadIcon(game["headicon_allies"]);
		precacheHeadIcon(game["headicon_axis"]);
		precacheHeadIcon(game["headicon_carrier"]);
		
		precacheShader("gfx/hud/hud@objectivegoal.tga");
		precacheShader("gfx/hud/hud@objectivegoal_up.tga");
		precacheShader("gfx/hud/hud@objectivegoal_down.tga");
		precacheShader("gfx/hud/objective.tga");
		precacheShader("gfx/hud/objective_up.tga");
		precacheShader("gfx/hud/objective_down.tga");
		precacheShader("black");
		precacheShader("white");
		precacheShader("hudScoreboard_mp");
		precacheShader("gfx/hud/hud@mpflag_spectator.tga");
		
		precacheMenu(game["menu_team"]);
		precacheMenu(game["menu_weapon_allies"]);
		precacheMenu(game["menu_weapon_axis"]);
		precacheMenu(game["menu_viewmap"]);
		precacheMenu(game["menu_callvote"]);
		precacheMenu(game["menu_quickcommands"]);
		precacheMenu(game["menu_quickstatements"]);
		precacheMenu(game["menu_quickresponses"]);
		
		precacheStatusIcon("gfx/hud/hud@status_dead.tga");
		precacheStatusIcon("gfx/hud/hud@status_connecting.tga");
		precacheStatusIcon(game["headicon_carrier"]);
		
		maps\mp\gametypes\_teams::precache();
		maps\mp\gametypes\_teams::scoreboard();
		maps\mp\gametypes\_teams::initGlobalCvars();

		//thread addBotClients();
	}

	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();

	game["gamestarted"] = true;
	
	setClientNameMode("manual_change");

	thread startGame();
	thread updateScriptCvars();
	//thread addBotClients();
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";
	self.hudelem = [];
	
	if(!isdefined(self.pers["team"]))
		iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	logPrint("J;" + lpselfnum + ";" + self.name + "\n");

	self.objs_held = 0;
	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}

	level endon("intermission");

	if(isdefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("scr_showweapontab", "1");

		if(self.pers["team"] == "allies")
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
		else
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);

		if(isdefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			self.sessionteam = "spectator";

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
				}

				if(response == self.pers["team"] && self.sessionstate == "playing")
					break;

				if(response != self.pers["team"] && self.sessionstate == "playing")
					self suicide();

				self.pers["team"] = response;
				self.pers["weapon"] = undefined;
				self.pers["weapon1"] = undefined;
				self.pers["weapon2"] = undefined;
				self.pers["spawnweapon"] = undefined;
				self.pers["savedmodel"] = undefined;

				self setClientCvar("scr_showweapontab", "1");

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

			case "spectator":
				if(self.pers["team"] != "spectator")
				{
					if(isalive(self))
						self suicide();

					self.pers["team"] = "spectator";
					self.pers["weapon"] = undefined;
					self.pers["weapon1"] = undefined;
					self.pers["weapon2"] = undefined;
					self.pers["spawnweapon"] = undefined;
					self.pers["savedmodel"] = undefined;

					self.sessionteam = "spectator";
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
					self setClientCvar("scr_showweapontab", "0");
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

			if(isdefined(self.pers["weapon"]) && self.pers["weapon"] == weapon && !isdefined(self.pers["weapon1"]))
				continue;

			if(!game["matchstarted"])
			{
				self.pers["weapon"] = weapon;
				self.spawned = undefined;
				spawnPlayer();
				self thread printJoinedTeam(self.pers["team"]);
				level checkMatchStart();
			}
			else if(!level.roundstarted)
			{
				if(isdefined(self.pers["weapon"]))
				{
					self.pers["weapon"] = weapon;
			 		self setWeaponSlotWeapon("primary", weapon);
					self setWeaponSlotAmmo("primary", 999);
					self setWeaponSlotClipAmmo("primary", 999);
					self switchToWeapon(weapon);
				}
				else
				{
					self.pers["weapon"] = weapon;

					if(!level.exist[self.pers["team"]])
					{
						self.spawned = undefined;
						spawnPlayer();
						self thread printJoinedTeam(self.pers["team"]);
						level checkMatchStart();
					}
					else
					{
						spawnPlayer();
						self thread printJoinedTeam(self.pers["team"]);
					}
				}
			}
			else
			{
				if(isdefined(self.pers["weapon"]))
					self.oldweapon = self.pers["weapon"];

				self.pers["weapon"] = weapon;
				self.sessionteam = self.pers["team"];

				if(self.sessionstate != "playing")
					self.statusicon = "gfx/hud/hud@status_dead.tga";

				if(self.pers["team"] == "allies")
					otherteam = "axis";
				else if(self.pers["team"] == "axis")
					otherteam = "allies";
					
				// if joining a team that has no opponents, just spawn
				if(!level.didexist[otherteam] && !level.roundended)
				{
					self.spawned = undefined;
					spawnPlayer();
					self thread printJoinedTeam(self.pers["team"]);
				}				
				else if(!level.didexist[self.pers["team"]] && !level.roundended)
				{
					self.spawned = undefined;
					spawnPlayer();
					self thread printJoinedTeam(self.pers["team"]);
					level checkMatchStart();
				}
				else
				{
					weaponname = maps\mp\gametypes\_teams::getWeaponName(self.pers["weapon"]);

					if(self.pers["team"] == "allies")
					{
						if(maps\mp\gametypes\_teams::useAn(self.pers["weapon"]))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_AN_NEXT_ROUND", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_ALLIED_WITH_A_NEXT_ROUND", weaponname);
					}
					else if(self.pers["team"] == "axis")
					{
						if(maps\mp\gametypes\_teams::useAn(self.pers["weapon"]))
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_AN_NEXT_ROUND", weaponname);
						else
							self iprintln(&"MPSCRIPT_YOU_WILL_SPAWN_AXIS_WITH_A_NEXT_ROUND", weaponname);
					}
				}
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
	}
}

Callback_PlayerDisconnect()
{
	iprintln(&"MPSCRIPT_DISCONNECTED", self);

	lpselfnum = self getEntityNumber();
	logPrint("Q;" + lpselfnum + ";" + self.name + "\n");

	if (isdefined (self.objs_held))
	{
		if (self.objs_held > 0)
		{
			for (i=0;i<(level.numobjectives + 1);i++)
			{
				if (isdefined (self.hasobj[i]))
				{
					//if (self isonground())
						self.hasobj[i] drop_objective_on_disconnect_or_death(self);
					//else
					//	self.hasobj[i] drop_objective_on_disconnect_or_death(self, "trace");
				}
			}
		}
	}

	self notify ("death");
	
	if(game["matchstarted"])
	level thread updateTeamStatus();
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if(self.sessionteam == "spectator")
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

	if(self.sessionteam == "spectator")
		return;

	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";

	// send out an obituary message to all clients about the kill
	obituary(self, attacker, sWeapon, sMeansOfDeath);
	self notify ("death");

	if (isdefined (self.objs_held))
	{
		if (self.objs_held > 0)
		{
			for (i=0;i<(level.numobjectives + 1);i++)
			{
				if (isdefined (self.hasobj[i]))
				{
					//if (self isonground())
					//{
					//	println ("PLAYER KILLED ON THE GROUND");
						self.hasobj[i] thread drop_objective_on_disconnect_or_death(self);
					//}
					//else
					//{
					//	println ("PLAYER KILLED NOT ON THE GROUND");
					//	self.hasobj[i] thread drop_objective_on_disconnect_or_death(self.origin, "trace");
					//}
				}
			}
		}
	}

	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.headicon = "";
	self.pers["deaths"]++;
	self.deaths = self.pers["deaths"];

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfteam = self.pers["team"];
	lpattackerteam = "";

	attackerNum = -1;
	level.playercam = attacker getEntityNumber();

	if(isPlayer(attacker))
	{
		if(attacker == self) // killed himself
		{
			doKillcam = false;

			attacker.pers["score"]--;
			attacker.score = attacker.pers["score"];

			if(isdefined(attacker.reflectdamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			doKillcam = true;

			if(self.pers["team"] == attacker.pers["team"]) // killed by a friendly
			{
				attacker.pers["score"]--;
				attacker.score = attacker.pers["score"];
			}
			else
			{
				attacker.pers["score"]++;
				attacker.score = attacker.pers["score"];
			}
		}

		lpattacknum = attacker getEntityNumber();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;

		self.pers["score"]--;
		self.score = self.pers["score"];
		
		lpattacknum = -1;
		lpattackname = "";
		lpattackerteam = "world";
	}

	logPrint("K;" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Make the player drop his weapon
	self dropItem(self getcurrentweapon());

	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;

	//Remove HUD text if there is any
	for (i=1;i<16;i++)
	{
		if ( (isdefined (self.hudelem)) && (isdefined (self.hudelem[i])) )
			self.hudelem[i] destroy();
	}
	if (isdefined (self.progressbackground))
		self.progressbackground destroy();
	if (isdefined (self.progressbar))
		self.progressbar destroy();
	
	body = self cloneplayer();

	updateTeamStatus();

	// TODO: Add additional checks that allow killcam when the last player killed wouldn't end the round (bomb is planted)
	if(!level.exist[self.pers["team"]]) // If the last player on a team was just killed, don't do killcam
		doKillcam = false;

	delay = 2;	// Delay the player becoming a spectator till after he's done dying
	wait delay;	// ?? Also required for Callback_PlayerKilled to complete before killcam can execute

	if(doKillcam && !level.roundended)
		self thread killcam(attackerNum, delay);
	else
	{
		currentorigin = self.origin;
		currentangles = self.angles;

		self thread spawnSpectator(currentorigin + (0, 0, 60), currentangles);
	}
}

spawnPlayer()
{
	self notify("spawned");

	resettimeout();

	self.sessionteam = self.pers["team"];
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.reflectdamage = undefined;
				
	if(isdefined(self.spawned))
			return;

	self.sessionstate = "playing";

	if(self.pers["team"] == "allies")
		spawnpointname = "mp_retrieval_spawn_allied";
	else
		spawnpointname = "mp_retrieval_spawn_axis";

	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	//Set their intro text
	/*REMOVED
	if(self.pers["team"] == "allies")
	{
		if (isdefined (game["re_attackers_intro_text"]))
			clientAnnouncement (self,game["re_attackers_intro_text"]);
	}
	else if(self.pers["team"] == "axis")
	{
		if (isdefined (game["re_defenders_intro_text"]))
			clientAnnouncement (self,game["re_defenders_intro_text"]);
	}
	*/

	self.spawned = true;
	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	self.objs_held = 0;

	updateTeamStatus();

	if(!isdefined(self.pers["score"]))
		self.pers["score"] = 0;
	self.score = self.pers["score"];

	if(!isdefined(self.pers["deaths"]))
		self.pers["deaths"] = 0;
	self.deaths = self.pers["deaths"];

	if(!isdefined(self.pers["savedmodel"]))
	maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	maps\mp\gametypes\_teams::loadout();

	if(isdefined(self.pers["weapon1"]) && isdefined(self.pers["weapon2"]))
	{
	 	self setWeaponSlotWeapon("primary", self.pers["weapon1"]);
		self setWeaponSlotAmmo("primary", 999);
		self setWeaponSlotClipAmmo("primary", 999);

	 	self setWeaponSlotWeapon("primaryb", self.pers["weapon2"]);
		self setWeaponSlotAmmo("primaryb", 999);
		self setWeaponSlotClipAmmo("primaryb", 999);

		self setSpawnWeapon(self.pers["spawnweapon"]);
	}
	else
	{
		self setWeaponSlotWeapon("primary", self.pers["weapon"]);
		self setWeaponSlotAmmo("primary", 999);
		self setWeaponSlotClipAmmo("primary", 999);

		self setSpawnWeapon(self.pers["weapon"]);
	}

	if(self.pers["team"] == game["re_attackers"])
		self setClientCvar("cg_objectiveText", game["re_attackers_obj_text"]);
	else if(self.pers["team"] == game["re_defenders"])
		self setClientCvar("cg_objectiveText", game["re_defenders_obj_text"]);

	if(level.drawfriend)
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

spawnSpectator(origin, angles)
{
	self notify("spawned");

	resettimeout();

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.reflectdamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";

	if(isdefined(origin) && isdefined(angles))
		self spawn(origin, angles);
	else
	{
 		spawnpointname = "mp_retrieval_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

		if(isdefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}

	updateTeamStatus();

	//if(game["re_attackers"] == "allies")
	//	self setClientCvar("cg_objectiveText", &"RE_ALLIES", game["re_attackers_obj_text"]);
	//else if(game["re_attackers"] == "axis")
	//	self setClientCvar("cg_objectiveText", &"RE_AXIS", game["re_attackers_obj_text"]);
	self setClientCvar("cg_objectiveText", game["re_spectator_obj_text"]);
}

spawnIntermission()
{
	self notify("spawned");

	resettimeout();

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.reflectdamage = undefined;

	spawnpointname = "mp_retrieval_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
	if(isdefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
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

	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if(self.archivetime <= delay)
	{
		self.spectatorclient = -1;
		self.archivetime = 0;
	
		return;
	}

	self.killcam = true;
	
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
		self.kc_title.sort = 1; // force to draw after the bars
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
		self.kc_skiptext.sort = 1; // force to draw after the bars
	}
	self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_SKIP");

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
	
	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;
	self.killcam = undefined;
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

roundcam(delay,winningteam)
{
	self endon("spawned");

	spawnSpectator();

	if(isdefined(level.goalcam))
		self thread spawnSpectator(level.goalcam.origin, level.goalcam.angles);
	else
		self.spectatorclient = level.playercam;

	self.archivetime = delay + 7;

	// wait till the next server frame to give the player the kill-cam huddraw elements
	wait 0.05;
	
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

	if(winningteam == "allies")
		self.kc_title setText(&"MPSCRIPT_ALLIES_WIN");
	else if (winningteam == "axis")
		self.kc_title setText(&"MPSCRIPT_AXIS_WIN");
	else
		self.kc_title setText(&"MPSCRIPT_ROUNDCAM");
	
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
	self.kc_skiptext setText(&"MPSCRIPT_STARTING_NEW_ROUND");

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
	self.kc_timer setTimer(self.archivetime - 1.05);
	
	self thread spawnedKillcamCleanup();
	self thread waitSkipKillcamButton();
	wait (self.archivetime - 0.05);
	self removeKillcamElements();
	
	self.spectatorclient = -1;
	self.archivetime = 0;

	level notify("roundcam_ended");
}

startGame()
{
	level.starttime = getTime();
	thread startRound();

	for(;;)
	{
		checkTimeLimit();
		wait 1;
	}
}

startRound()
{
	thread maps\mp\gametypes\_teams::sayMoveIn();
	
	level.clock = newHudElem();
	level.clock.x = 320;
	level.clock.y = 460;
	level.clock.alignX = "center";
	level.clock.alignY = "middle";
	level.clock.font = "bigfixed";
	level.clock setTimer(level.roundlength * 60);
	
	if(game["matchstarted"])
	{
		level.clock.color = (0, 1, 0);

		if((level.roundlength * 60) > level.graceperiod)
		{
			wait level.graceperiod;
	
			level.roundstarted = true;
			level.clock.color = (1, 1, 1);
	
			// Players on a team but without a weapon show as dead since they can not get in this round
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
	
				if(player.sessionteam != "spectator" && !isdefined(player.pers["weapon"]))
					player.statusicon = "gfx/hud/hud@status_dead.tga";
			}
			
			wait ((level.roundlength * 60) - level.graceperiod);
		}	
		else
			wait (level.roundlength * 60);
	}
	else
	{
		level.clock.color = (1, 1, 1);
		wait (level.roundlength * 60);
	}

	if(level.roundended)
		return;

	if(!level.exist[game["re_attackers"]] || !level.exist[game["re_defenders"]])
	{
		announcement(&"RE_TIMEEXPIRED");
		level thread endRound("draw",true);
		return;
	}

	announcement(&"RE_TIMEEXPIRED");
	level thread endRound(game["re_defenders"], true);
}

checkMatchStart()
{
	oldvalue["teams"] = level.exist["teams"];
	level.exist["teams"] = false;

	// If teams currently exist
	if(level.exist["allies"] && level.exist["axis"])
		level.exist["teams"] = true;

	// If teams previously did not exist and now they do
	if(!oldvalue["teams"] && level.exist["teams"] && !level.roundended)
	{
		if(!game["matchstarted"])
		{
			announcement(&"RE_MATCHSTARTING");
			level thread endRound("reset");
		}
		else
		{
			announcement(&"RE_MATCHRESUMING");
			level thread endRound("draw");
		}

		return;
	}
}

resetScores()
{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			player.pers["score"] = 0;
			player.pers["deaths"] = 0;
		}

		game["alliedscore"] = 0;
		setTeamScore("allies", game["alliedscore"]);
		game["axisscore"] = 0;
		setTeamScore("axis", game["axisscore"]);
}

endRound(roundwinner, timeexpired)
{
	if(level.roundended)
		return;
	level.roundended = true;

	if (!isdefined (timeexpired))
		timeexpired = false;
	
	winners = "";
	losers = "";
	
	if(roundwinner == "allies")
	{
		game["alliedscore"]++;
		setTeamScore("allies", game["alliedscore"]);

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if ( (isdefined (players[i].pers["team"])) && (players[i].pers["team"] == "allies") )
				winners = (winners + ";" + players[i].name);
			else if ( (isdefined (players[i].pers["team"])) && (players[i].pers["team"] == "axis") )
				losers = (losers + ";" + players[i].name);
			players[i] playLocalSound("MP_announcer_allies_win");
		}
		logPrint("W;allies" + winners + "\n");
		logPrint("L;axis" + losers + "\n");
	}
	else if(roundwinner == "axis")
	{
		game["axisscore"]++;
		setTeamScore("axis", game["axisscore"]);

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if ( (isdefined (players[i].pers["team"])) && (players[i].pers["team"] == "axis") )
				winners = (winners + ";" + players[i].name);
			else if ( (isdefined (players[i].pers["team"])) && (players[i].pers["team"] == "allies") )
				losers = (losers + ";" + players[i].name);
			players[i] playLocalSound("MP_announcer_axis_win");
		}
		logPrint("W;axis" + winners + "\n");
		logPrint("L;allies" + losers + "\n");
	}
	else if(roundwinner == "draw")
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
			players[i] playLocalSound("MP_announcer_round_draw");
	}
	
	if ( (getcvar("scr_roundcam") == "1") && (!timeexpired) && (game["matchstarted"]) )
	{
		if((isdefined(level.playercam) || isdefined(level.goalcam)) && roundwinner != "draw" && roundwinner != "reset")
		{
			delay = 2;	// Delay the player becoming a spectator
			wait delay;

			viewers = 0;
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				//if((player.sessionstate != "playing") && (player getEntityNumber() != level.playercam) && !isdefined(player.killcam))
				if(!isdefined(player.killcam))
				{
					player thread roundcam(delay,roundwinner);
					viewers++;
				}
			}

			if(viewers)
				level waittill("roundcam_ended");
			else
				wait 7;
		}
		else
		{
			wait 5;
		}
	}
	else
	{
		wait 5;
	}

	if(game["matchstarted"])
	{
		checkScoreLimit();
		game["roundsplayed"]++;
		checkRoundLimit();
	}

	if(!game["matchstarted"] && roundwinner == "reset")
	{
		game["matchstarted"] = true;
		thread resetScores();
		game["roundsplayed"] = 0;
	}

	if(level.mapended)
		return;
	level.mapended = true;

	// for all living players store their weapons
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
		{
			primary = player getWeaponSlotWeapon("primary");
			primaryb = player getWeaponSlotWeapon("primaryb");

			// If a menu selection was made
			if(isdefined(player.oldweapon))
			{
				// If a new weapon has since been picked up (this fails when a player picks up a weapon the same as his original)
				if(player.oldweapon != primary && player.oldweapon != primaryb && primary != "none")
				{
					player.pers["weapon1"] = primary;
					player.pers["weapon2"] = primaryb;
					player.pers["spawnweapon"] = player getCurrentWeapon();
				} // If the player's menu chosen weapon is the same as what is in the primaryb slot, swap the slots
				else if(player.pers["weapon"] == primaryb)
				{
					player.pers["weapon1"] = primaryb;
					player.pers["weapon2"] = primary;
					player.pers["spawnweapon"] = player.pers["weapon1"];
				} // Give them the weapon they chose from the menu
				else
				{
					player.pers["weapon1"] = player.pers["weapon"];
					player.pers["weapon2"] = primaryb;
					player.pers["spawnweapon"] = player.pers["weapon1"];
				}
} // No menu choice was ever made, so keep their weapons and spawn them with what they're holding, unless it's a pistol or grenade
			else
			{
				if(primary == "none")
					player.pers["weapon1"] = player.pers["weapon"];
				else
					player.pers["weapon1"] = primary;

				player.pers["weapon2"] = primaryb;

				spawnweapon = player getCurrentWeapon();
				if(!maps\mp\gametypes\_teams::isPistolOrGrenade(spawnweapon))
					player.pers["spawnweapon"] = spawnweapon;
				else
					player.pers["spawnweapon"] = player.pers["weapon1"];
			}
		}
	}

	if(level.timelimit > 0)
	{
		timepassed = (getTime() - level.starttime) / 1000;
		timepassed = timepassed / 60.0;

		game["timeleft"] = level.timelimit - timepassed;
	}

	map_restart(true);
}

endMap()
{
	game["state"] = "intermission";
	level notify("intermission");

	if(game["alliedscore"] == game["axisscore"])
		text = &"MPSCRIPT_THE_GAME_IS_A_TIE";
	else if(game["alliedscore"] > game["axisscore"])
		text = &"MPSCRIPT_ALLIES_WIN";
	else
		text = &"MPSCRIPT_AXIS_WIN";

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");
		player setClientCvar("cg_objectiveText", text);
		player spawnIntermission();
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

	if(timepassed < game["timeleft"])
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_TIME_LIMIT_REACHED");
	endMap();
}

checkScoreLimit()
{
	if(level.scorelimit <= 0)
		return;

	if(game["alliedscore"] < level.scorelimit && game["axisscore"] < level.scorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_SCORE_LIMIT_REACHED");
	endMap();
}

checkRoundLimit()
{
	if(level.roundlimit <= 0)
		return;

	if(game["roundsplayed"] < level.roundlimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_ROUND_LIMIT_REACHED");
	endMap();
}

updateScriptCvars()
{
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
			game["timeleft"] = timelimit;
			level.starttime = getTime();

			checkTimeLimit();
		}

		scorelimit = getcvarint("scr_re_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;

			if(game["matchstarted"])
				checkScoreLimit();
		}

		roundlimit = getcvarint("scr_re_roundlimit");
		if(level.roundlimit != roundlimit)
		{
			level.roundlimit = roundlimit;

			if(game["matchstarted"])
				checkRoundLimit();
		}

		roundlength = getcvarfloat("scr_re_roundlength");
		if(roundlength > 10)
			setcvar("scr_re_roundlength", "10");

		graceperiod = getcvarfloat("scr_re_graceperiod");
		if(graceperiod > 60)
			setcvar("scr_re_graceperiod", "60");

		drawfriend = getcvarfloat("scr_drawfriend");
		if(level.drawfriend != drawfriend)
		{
			level.drawfriend = drawfriend;

			if(level.drawfriend)
			{
				// for all living players, show the appropriate headicon
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

		wait 1;
	}
}

updateTeamStatus()
{
	wait 0;	// Required for Callback_PlayerDisconnect to complete before updateTeamStatus can execute
	
	resettimeout();
	
	oldvalue["allies"] = level.exist["allies"];
	oldvalue["axis"] = level.exist["axis"];
	level.exist["allies"] = 0;
	level.exist["axis"] = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
			level.exist[player.pers["team"]]++;
	}

	if(level.exist["allies"])
		level.didexist["allies"] = true;
	if(level.exist["axis"])
		level.didexist["axis"] = true;

	if(level.roundended)
		return;

	if(oldvalue["allies"] && !level.exist["allies"] && oldvalue["axis"] && !level.exist["axis"])
	{
		announcement(&"RE_ROUND_DRAW");
		level thread endRound("draw");
		return;
	}

	if(oldvalue["allies"] && !level.exist["allies"])
	{
		announcement(&"RE_ELIMINATED_ALLIES");
		level thread endRound("axis");
		return;
	}

	if(oldvalue["axis"] && !level.exist["axis"])
	{
		announcement(&"RE_ELIMINATED_AXIS");
		level thread endRound("allies");
		return;
	}
}

retrieval()
{
	level.retrieval_objective = getentarray("retrieval_objective","targetname");
	for(i = 0; i < level.retrieval_objective.size; i++)
	{
		level.retrieval_objective[i] thread retrieval_spawn_objective();
		level.retrieval_objective[i] thread objective_think("objective");
	}
}

objective_think(type)
{
	level.numobjectives = (level.numobjectives + 1);
	num = level.numobjectives;

	objective_add(num, "current", self.origin, "gfx/hud/objective.tga");
	self.objnum = (num);

	if (type == "objective")
	{
		level.hudcount++;
		self.hudnum = level.hudcount;
		objective_position(num, self.origin);
		if (getcvar("scr_re_showcarrier") == "0")
		{
			while (1)
			{
				self waittill ("picked up");
				objective_team(num,game["re_attackers"]);

				self waittill ("dropped");
				objective_team(num,"none");
			}
		}
	}
	else
	if (type == "goal")
	{
		objective_icon (num,"gfx/hud/hud@objectivegoal.tga");
		//if (getcvar("scr_re_showcarrier") == "0")
		//	objective_team(num,game["re_attackers"]);
	}
}

retrieval_spawn_objective()
{
	targeted = getentarray (self.target,"targetname");
	for (i=0;i<targeted.size;i++)
	{
		if (targeted[i].classname == "mp_retrieval_objective")
			spawnloc = maps\MP\_utility::add_to_array(spawnloc, targeted[i]);
		else
		if (targeted[i].classname == "trigger_use")
			self.trigger = (targeted[i]);
		else
		if (targeted[i].classname == "trigger_multiple")
		{
			self.goal = (targeted[i]);
			self.goal thread objective_think("goal");
		}
	}

	if ( (!isdefined (spawnloc)) || (spawnloc.size < 1) )
	{
		maps\mp\_utility::error("retrieval_objective does not target any mp_retrieval_objectives");
		return;
	}
	if (!isdefined (self.trigger))
	{
		maps\mp\_utility::error("retrieval_objective does not target a trigger_use");
		return;
	}
	if (!isdefined (self.goal))
	{
		maps\mp\_utility::error("retrieval_objective trigger_use does not target a trigger_multiple");
		return;
	}

	//move objective to random spot
	rand = randomint(spawnloc.size);
	if (spawnloc.size > 2)
	{
		if (isdefined(game["last_objective_pos"]))
		while (rand == game["last_objective_pos"])
			rand = randomint(spawnloc.size);
		game["last_objective_pos"] = rand;
	}
	self.origin = (spawnloc[rand].origin);
	self.startorigin = self.origin;
	self.startangles = self.angles;
	self.trigger.origin = (spawnloc[rand].origin);
	self.trigger.startorigin = self.trigger.origin;
	
	self thread retrieval_think();
	
	//Set hintstring on the objectives trigger
	wait 0;//required for level script to run and load the level.obj array
	if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
		self.trigger setHintString (&"RE_PRESS_TO_PICKUP",level.obj[self.script_objective_name]);
	else
		self.trigger setHintString (&"RE_PRESS_TO_PICKUP_GENERIC");
}

retrieval_think() //each objective model runs this to find it's trigger and goal
{
	if (isdefined (self.objnum))
		objective_position(self.objnum,self.origin);

	while (1)
	{
		self.trigger waittill ("trigger",other);
		
		if(!game["matchstarted"])
			return;

		if ( (isPlayer(other)) && (other.pers["team"] == game["re_attackers"]) )
		{
			if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			{
				if (getcvar("scr_re_showcarrier") == "0")
					announcement(&"RE_OBJ_PICKED_UP_NOSTARS",level.obj[self.script_objective_name]);
				else
				announcement(&"RE_OBJ_PICKED_UP",level.obj[self.script_objective_name]);
			}
			else
			{
				if (getcvar("scr_re_showcarrier") == "0")
					announcement(&"RE_OBJ_PICKED_UP_GENERIC_NOSTARS");
				else
				announcement(&"RE_OBJ_PICKED_UP_GENERIC");
			}

			self thread hold_objective(other);
			other.hasobj[self.objnum] = self;
			//println ("SETTING HASOBJ[" + self.objnum + "] as the " + self.script_objective_name);
			other.objs_held++;
			/*
			println ("PUTTING OBJECTIVE " + self.objnum + " ON THE PLAYER ENTITY");
			objective_onEntity(self.objnum, other);
			*/
			other thread display_holding_obj(self);
			return;

		}
		else if ( (isPlayer(other)) && (other.pers["team"] == game["re_defenders"]) )
		{
			if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			{
				if ( game["re_attackers"] == "allies" )
					other thread client_print(self, &"RE_PICKUP_ALLIES_ONLY",level.obj[self.script_objective_name]);
				else if ( game["re_attackers"] == "axis" )
					other thread client_print(self, &"RE_PICKUP_AXIS_ONLY",level.obj[self.script_objective_name]);
			}
			else
			{
				if ( game["re_attackers"] == "allies" )
					other thread client_print(self, &"RE_PICKUP_ALLIES_ONLY_GENERIC");
				else if ( game["re_attackers"] == "axis" )
					other thread client_print(self, &"RE_PICKUP_AXIS_ONLY_GENERIC");
			}
		}
		else
			wait (.5);
	}
}

hold_objective(player) //the objective model runs this to be held by 'player'
{
	self endon ("completed");
	self endon ("dropped");
	team = player.sessionteam;
	self hide();
	
	lpselfnum = player getEntityNumber();
	logPrint("A;" + lpselfnum + ";" + game["re_attackers"] + ";" + player.name + ";" + "re_pickup" + "\n");
	
	if (player.pers["team"] == game["re_attackers"])

	self.trigger triggerOff();
	player playLocalSound ("re_pickup_paper");
	self notify ("picked up");

	//println ("PUTTING OBJECTIVE " + self.objnum + " ON THE PLAYER ENTITY");
	player.statusicon = game["headicon_carrier"];
	objective_onEntity(self.objnum, player);

	self thread objective_carrier_atgoal_wait(player);
	self thread holduse(player);
	self thread pressuse_notify(player);

	player.headicon = game["headicon_carrier"];
	if (getcvar("scr_re_showcarrier") == "0")
		player.headiconteam = (game["re_attackers"]);
	else
		player.headiconteam = "none";
}

objective_carrier_atgoal_wait(player)
{
	self endon ("dropped");
	while (1)
	{
		self.goal waittill ("trigger",other);
		if ( (other == player) && (isPlayer(player)) && (player.pers["team"] == game["re_attackers"]) )
		{
			//player.pers["score"] += 3;
			//player.score = player.pers["score"];
			level.objectives_done++;

			objective_delete(self.objnum);
			self notify ("completed");

			//org = (player.origin);
			self thread drop_objective(player,1);

			objective_delete(self.objnum);

			self delete();

			if (level.objectives_done < level.retrieval_objective.size)
			{
				return;
			}
			else
			{
				if(isdefined (self.goal.target))
					level.goalcam = getent(self.goal.target, "targetname");
				else
					level.goalcam = spawn ("script_origin",(self.goal.origin + (0,0,100)) );

				if (isdefined (level.goalcam.target))
				{
					goalcam_focus = getent (level.goalcam.target,"targetname");
					level.goalcam.angles = vectortoangles(goalcam_focus.origin - level.goalcam.origin);
				}
				else
					level.goalcam.angles = vectortoangles(self.goal.origin - level.goalcam.origin);

				announcement (&"RE_OBJ_CAPTURED_ALL");
				level thread endRound(game["re_attackers"]);
				return;
			}
		}
		else
		{
			wait .05;
		}
	}
}

drop_objective(player,option)
{
	if (isPlayer(player))
	{
		num = (16 - (self.hudnum));
		if (isdefined (self.objs_held))
		{
			if (self.objs_held > 0)
			{
				for (i=0;i<(level.numobjectives + 1);i++)
				{
					if (isdefined (self.hasobj[i]))
					{
						//if (self isonground())
							self.hasobj[i] thread drop_objective_on_disconnect_or_death(self);
						//else
						//	self.hasobj[i] thread drop_objective_on_disconnect_or_death(self.origin, "trace");
					}
				}
			}
		}
		
		if ( (isdefined (player.hudelem)) && (isdefined (player.hudelem[num])) )
			player.hudelem[num] destroy();
	}

	//if (isdefined (loc))
	loc = (player.origin + (0,0,25));

	if ( (isdefined (option)) && (option == 1) )
	{
		player.objs_held--;
		if ( (isdefined (self.objnum)) && (isdefined (player.hasobj[self.objnum])) )
			player.hasobj[self.objnum] = undefined;
		else
			println ("#### " + self.objnum + "UNDEFINED");

		objective_delete(self.objnum);
		
		lpselfnum = player getEntityNumber();
		logPrint("A;" + lpselfnum + ";" + game["re_attackers"] + ";" + player.name + ";" + "re_capture" + "\n");
		
		if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			announcement(&"RE_OBJ_CAPTURED",level.obj[self.script_objective_name]);
		else
			announcement(&"RE_OBJ_CAPTURED_GENERIC");

		if (isdefined (self.trigger))
			self.trigger delete();

		if ( (isPlayer(player)) && (player.objs_held < 1) )
		{
			if (level.drawfriend == 1)
			{
				if (isPlayer(player))
				if(player.pers["team"] == "allies")
				{
					player.headicon = game["headicon_allies"];
					player.headiconteam = "allies";
				}
				else if(player.pers["team"] == "axis")
				{
					player.headicon = game["headicon_axis"];
					player.headiconteam = "axis";
				}
				else
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
			else
			{
				if (isPlayer(player))
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
		}
	}
	else
	{
		/*
		if (player isOnGround())
		{
			trace = bulletTrace(loc, (loc-(0,0,5000)), false, undefined);
			end_loc = trace["position"]; //where the ground under the player is
		}
		else
		{
			println ("PLAYER IS ON GROUND - SKIPPING TRACE");
			end_loc = player.origin;
		}
		*/
		//CHAD
		plant = player maps\mp\_utility::getPlant();
		end_loc = plant.origin;
		
		if (distance(loc,end_loc) > 0 )
		{
			self.origin = (loc);
			self.angles = plant.angles;
			self show();
			speed = (distance(loc,end_loc) / 250);
			if (speed > 0.4)
			{
				self moveto(end_loc,speed,.1,.1);
				self waittill ("movedone");
				self.trigger.origin = (end_loc);
			}
			else
			{
				self.origin = end_loc;
				self.angles = plant.angles;
				self show();
				self.trigger.origin = (end_loc);
			}
		}
		else
		{
			self.origin = end_loc;
			self.angles = plant.angles;
			self show();
			self.trigger.origin = (end_loc);
		}

		//check if it's in a minefield
		In_Mines = 0;
		for (i=0;i<level.minefield.size;i++)
		{
			if (self istouching(level.minefield[i]))
			{
				In_Mines = 1;
				break;
			}
		}

		if (In_Mines == 1)
		{
			if (player.objs_held > 1)
			{	//IF A PLAYER HOLDS 2 OR MORE OBJECTIVES AND DROPS ONLY ONE INTO THE MINEFIELD
				//THEN THIS WILL STILL SAY "MULTIPLE OBJECTIVES..." BUT A PLAYER SHOULD NEVER
				//BE ABOVE A MINEFIELD IN ONE OF THE SHIPPED MAPS SO I'LL LEAVE IT FOR NOW
				if ( (!isdefined (level.lastdropper)) || (level.lastdropper != player) )
				{
					level.lastdropper = player;
					announcement (&"RE_OBJ_INMINES_MULTIPLE");
				}
			}
			else
			{
				if ( (!isdefined (level.lastdropper)) || (level.lastdropper != player) )
				{
					level.lastdropper = player;
					if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
						announcement (&"RE_OBJ_INMINES",level.obj[self.script_objective_name]);
					else
						announcement (&"RE_OBJ_INMINES_GENERIC");
				}
			}
			self.trigger.origin = (self.trigger.startorigin);
			self.origin = (self.startorigin);
			self.angles = (self.startangles);
		}
		else
		{
			if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )

				announcement (&"RE_OBJ_DROPPED",level.obj[self.script_objective_name]);
			else
				announcement (&"RE_OBJ_DROPPED");
		}

		if (isPlayer(player))
		{
			if ( (isdefined (self.objnum)) && (isdefined (player.hasobj[self.objnum])) )
				player.hasobj[self.objnum] = undefined;
			else
				println ("#### " + self.objnum + "UNDEFINED");
			player.objs_held--;
		}

		if ( (isPlayer(player)) && (player.objs_held < 1) )
		{
			if (level.drawfriend == 1)
			{
				if (isPlayer(player))
				if(player.pers["team"] == "allies")
				{
					player.headicon = game["headicon_allies"];
					player.headiconteam = "allies";
				}
				else if(player.pers["team"] == "axis")
				{
					player.headicon = game["headicon_axis"];
					player.headiconteam = "axis";
				}
				else
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
			else
			{
				if (isPlayer(player))
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
		}

		if (self istouching (self.goal))
		{
			if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
				announcement(&"RE_OBJ_CAPTURED",level.obj[self.script_objective_name]);
			else
				announcement(&"RE_OBJ_CAPTURED_GENERIC");

			if (isdefined (self.trigger))
				self.trigger delete();

			if ( (isPlayer(player)) && (player.objs_held < 1) )
			{
				if (level.drawfriend == 1)
				{
					if (isPlayer(player))
					if(player.pers["team"] == "allies")
					{
						player.headicon = game["headicon_allies"];
						player.headiconteam = "allies";
					}
					else if(player.pers["team"] == "axis")
					{
						player.headicon = game["headicon_axis"];
						player.headiconteam = "axis";
					}
					else
					{
						player.statusicon = "";
						player.headicon = "";
					}
				}
				else
				{
					if (isPlayer(player))
					{
						player.statusicon = "";
						player.headicon = "";
					}
				}
			}

			//player.pers["score"] += 3;
			//player.score = player.pers["score"];
			level.objectives_done++;

			self notify ("completed");
			level thread clear_player_dropbar(player);
			
			objective_delete(self.objnum);
			self delete();

			if (level.objectives_done < level.retrieval_objective.size)
			{
				return;
			}
			else
			{
				announcement (&"RE_OBJ_CAPTURED_ALL");
				level thread endRound(game["re_attackers"]);
				return;
			}
		}

		self thread objective_timeout();
		self notify ("dropped");
		self thread retrieval_think();
	}
}

clear_player_dropbar(player)
{
	if (isdefined (player))
	{
		player.progressbackground destroy();
		player.progressbar destroy();
		player unlink();
		player.isusing = false;
	}
}

objective_timeout()
{
	self endon ("picked up");
	obj_timeout = 60;
	wait obj_timeout;
	announcement (&"RE_OBJ_TIMEOUT_RETURNING",obj_timeout);
	self.trigger.origin = (self.trigger.startorigin);
	self.origin = (self.startorigin);
	self.angles = (self.startangles);
	objective_position(self.objnum,self.origin);
}

holduse(player)
{
	player endon ("death");
	self endon ("completed");
	self endon ("dropped");
	player.isusing = false;
	delaytime = .3;
	droptime = 2;
	barsize = 288;
	level.barincrement = (barsize / (20.0 * droptime));
	
	wait (1);

	while (isPlayer(player))
	{
		player waittill ("Pressed Use");
		if (player.isusing == true)
			continue;
		else
			player.isusing = true;

		player.currenttime = 0;
		while(player useButtonPressed() && (isalive (player)))
		{
			usetime = 0;
			while(isalive(player) && player useButtonPressed() && (usetime < delaytime))
			{
				wait .05;
				usetime = (usetime + .05);
			}

			if (!(player isOnGround()))
				continue;

			if (!( (isalive(player)) && (player useButtonPressed()) ) )
			{
				player unlink();
				continue;
			}
			else
			{
				if(!isdefined(player.progressbackground))
				{
					player.progressbackground = newClientHudElem(player);
					player.progressbackground.alignX = "center";
					player.progressbackground.alignY = "middle";
					player.progressbackground.x = 320;
					player.progressbackground.y = 385;
					player.progressbackground.alpha = 0.5;
				}
				player.progressbackground setShader("black", (level.barsize + 4), 12);		
				progresstime = 0;
				progresslength = 0;
				
				spawned = spawn ("script_origin",player.origin);
				if (isdefined (spawned))
					player linkto(spawned);

				while(isalive(player) && player useButtonPressed() && (progresstime < droptime))
				{
					progresstime += 0.05;
					progresslength += level.barincrement;

					if(!isdefined(player.progressbar))
					{
						player.progressbar = newClientHudElem(player);				
						player.progressbar.alignX = "left";
						player.progressbar.alignY = "middle";
						player.progressbar.x = (320 - (level.barsize / 2.0));
						player.progressbar.y = 385;
					}
					player.progressbar setShader("white", progresslength, 8);			

					wait 0.05;
				}

				if(progresstime >= droptime)
				{
					if (isdefined (player.progressbackground))
						player.progressbackground destroy();
					if (isdefined (player.progressbar))
						player.progressbar destroy();
					
					self thread drop_objective(player);
					self notify ("dropped");
					player unlink();
					player.isusing = false;
					return;
				}
				else if(isalive(player))
				{
					player.progressbackground destroy();
					player.progressbar destroy();
				}
			}
		}
		player unlink();
		player.isusing = false;
		wait(.05);
	}
}

pressuse_notify(player)
{
	player endon ("death");
	self endon ("dropped");
	while (isPlayer(player))
	{
		if (player useButtonPressed())
			player notify ("Pressed Use");

		wait (.05);
	}
}

display_holding_obj(obj_ent)
{
	num = (16 - (obj_ent.hudnum));

	if (num > 16)
		return;
	
	offset = (150 + (obj_ent.hudnum * 15));
	
	self.hudelem[num] = newClientHudElem(self);
	self.hudelem[num].alignX = "right";
	self.hudelem[num].alignY = "middle";
	self.hudelem[num].x = 635;
	self.hudelem[num].y = (550-offset);

	if ( (isdefined (obj_ent.script_objective_name)) && (isdefined (level.obj[obj_ent.script_objective_name])) )
	{
		self.hudelem[num].label = (&"RE_U_R_CARRYING");
		self.hudelem[num] setText(level.obj[obj_ent.script_objective_name]);
	}
	else
		self.hudelem[num] setText (&"RE_U_R_CARRYING_GENERIC");
}

triggerOff()
{
	self.origin = (self.origin - (0,0,10000));
}

client_print(obj, text, s)
{
	num = (16 - (obj.hudnum));

	if (num > 16)
		return;

	self notify ("stop client print");
	self endon ("stop client print");

	//if ( (isdefined (self.hudelem)) && (isdefined (self.hudelem[num])) )
	//	self.hudelem[num] destroy();
	
	for (i=1;i<16;i++)
	{
		if ( (isdefined (self.hudelem)) && (isdefined (self.hudelem[i])) )
			self.hudelem[i] destroy();
	}
	
	self.hudelem[num] = newClientHudElem(self);
	self.hudelem[num].alignX = "center";
	self.hudelem[num].alignY = "middle";
	self.hudelem[num].x = 320;
	self.hudelem[num].y = 200;

	if (isdefined (s))
	{
		self.hudelem[num].label = text;
		self.hudelem[num] setText(s);
	}
	else
		self.hudelem[num] setText(text);

	wait 3;
	
	if ( (isdefined (self.hudelem)) && (isdefined (self.hudelem[num])) )
		self.hudelem[num] destroy();
}

drop_objective_on_disconnect_or_death(player)
{
	//CHAD
	/*
	if (isdefined (trace))
	{
		loc = (loc + (0,0,25));
		trace = bulletTrace(loc, (loc-(0,0,5000)), false, undefined);
		end_loc = trace["position"]; //where the ground under the player is
	}
	else
	{
		println ("PLAYER IS ON GROUND - SKIPPING TRACE");
		end_loc = loc;
	}
	*/
	
	plant = player maps\mp\_utility::getPlant();
	end_loc = plant.origin;
	
	if (distance(player.origin,end_loc) > 0 )
	{
		self.origin = (player.origin);
		self.angles = plant.angles;
		self show();
		speed = (distance(player.origin,end_loc) / 250);
		if (speed > 0.4)
		{
			self moveto(end_loc,speed,.1,.1);
			self waittill ("movedone");
			self.trigger.origin = (end_loc);
		}
		else
		{
			self.origin = end_loc;
			self.angles = plant.angles;
			self show();
			self.trigger.origin = (end_loc);
		}
	}
	else
	{
		self.origin = end_loc;
		self.angles = plant.angles;
		self show();
		self.trigger.origin = (end_loc);
	}

	//check if it's in a minefield
	In_Mines = 0;
	for (i=0;i<level.minefield.size;i++)
	{
		if (self istouching(level.minefield[i]))
		{
			In_Mines = 1;
			break;
		}
	}

	if (In_Mines == 1)
	{
		if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			announcement (&"RE_OBJ_INMINES",level.obj[self.script_objective_name]);
		else
			announcement (&"RE_OBJ_INMINES_GENERIC");

		self.trigger.origin = (self.trigger.startorigin);
		self.origin = (self.startorigin);
		self.angles = (self.startangles);
	}
	else if (self istouching (self.goal))
	{
		if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			announcement(&"RE_OBJ_CAPTURED",level.obj[self.script_objective_name]);
		else
			announcement(&"RE_OBJ_CAPTURED_GENERIC");

		if (isdefined (self.trigger))
			self.trigger delete();

		if ( (isPlayer(player)) && (player.objs_held < 1) )
		{
			if (level.drawfriend == 1)
			{
				if (isPlayer(player))
				if(player.pers["team"] == "allies")
				{
					player.headicon = game["headicon_allies"];
					player.headiconteam = "allies";
				}
				else if(player.pers["team"] == "axis")
				{
					player.headicon = game["headicon_axis"];
					player.headiconteam = "axis";
				}
				else
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
			else
			{
				if (isPlayer(player))
				{
					player.statusicon = "";
					player.headicon = "";
				}
			}
		}

		//player.pers["score"] += 3;
		//player.score = player.pers["score"];
		level.objectives_done++;

		self notify ("completed");
		level thread clear_player_dropbar(player);
		
		objective_delete(self.objnum);
		self delete();

		if (level.objectives_done < level.retrieval_objective.size)
		{
			return;
		}
		else
		{
			announcement (&"RE_OBJ_CAPTURED_ALL");
			level thread endRound(game["re_attackers"]);
			return;
		}
	}
	else
	{
		if ( (isdefined (self.script_objective_name)) && (isdefined (level.obj[self.script_objective_name])) )
			announcement (&"RE_OBJ_DROPPED",level.obj[self.script_objective_name]);
		else
			announcement (&"RE_OBJ_DROPPED");
	}

	self thread objective_timeout();
	self notify ("dropped");
	self thread retrieval_think();
}

printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}

addBotClients()
{
	wait 5;
	
	for(i = 0; i < 2; i++)
	{
		ent[i] = addtestclient();
		wait 0.5;
	
		if(isPlayer(ent[i]))
		{
			if(i & 1)
			{
				ent[i] notify("menuresponse", game["menu_team"], "axis");
				wait 0.5;
				ent[i] notify("menuresponse", game["menu_weapon_axis"], "kar98k_mp");
			}
			else
			{
				ent[i] notify("menuresponse", game["menu_team"], "allies");
				wait 0.5;
				ent[i] notify("menuresponse", game["menu_weapon_allies"], "m1garand_mp");
			}
		}
	}
}