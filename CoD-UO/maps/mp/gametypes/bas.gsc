/*
	Base Assault
	Objective: 	destroy the enemy base's and protect your own 
	Map ends:	When one team destroys / captures all the bases, or time limit is reached
	Respawning:	No wait / Near team tanks

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_gmi_bas_allies_spawn
			All allied players spawn from these. The spawnpoint chosen is dependent on the current locations of teammates and enemies
			at the time of spawn. Players generally spawn behind their teammates relative to the direction of enemies. 

			classname		mp_gmi_bas_axis_spawn
			All axis players spawn from these. The spawnpoint chosen is dependent on the current locations of teammates and enemies
			at the time of spawn. Players generally spawn behind their teammates relative to the direction of enemies. 

		Spectator Spawnpoints:
			classname		mp_gmi_tank_bas_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

		Bases:
			targetname		gmi_base
						all bases are the same class name
			should have an origin brush inside the base somewhere for the Compass Icon to be located

			
			keys
			script_team		"axis","allies"
			NOTE: everything the base is targeting will be hidden at the start of the map 
			and UnHidden when it is destroyed 
			also each base NEEDS a trigger_lookat that is targeted from the base ,
			this is the bomb planting 
			this trigger needs a script_origin for the actual MODEL to be placed at
			OR Preferably the trigger should target a model to use 
			

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
			game["bas_layoutimage"] = "yourlevelname";  (or use game["layoutimage"] if no special map for this gametype is needed)
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.
*/

/*QUAKED mp_gmi_bas_allies_spawn (0.0 0.0 1.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/airborne"
Players spawn away from enemies and near their team at one of these positions.
*/

/*QUAKED mp_gmi_bas_axis_spawn (0.0 0.0 1.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/wehrmacht_soldier"
Players spawn away from enemies and near their team at one of these positions.
*/

/*QUAKED mp_gmi_bas_intermission (1.0 0.0 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/

/*QUAKED mp_gmi_bas_allied_spawn_secondary (0.0 1.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/airborne"
Allied players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_gmi_bas_axis_spawn_secondary (1.0 0.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/wehrmacht_soldier"
Axis players spawn randomly at one of these positions at the beginning of a round.
*/

main() // Starts when map is loaded.
{
	// init the spawn points first because if they do not exist then abort the game
	// Set up the spawnpoints of the "allies"

	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_gmi_bas_allies_spawn", 1) )
	{
		maps\mp\_utility::error("NO allied Spawns");
		return;
	}
	// Set up the spawnpoints of the "axis"
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_gmi_bas_axis_spawn", 1) )
	{
		maps\mp\_utility::error("NO axis Spawns");
		return;
	}
	// set up secondary spawn points but don't abort if they are not there
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_gmi_bas_allied_secondary_spawn");
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_gmi_bas_axis_secondary_spawn");

	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();
	
	// set some values for the icon positions
	game["flag_icons_w"] = 32;
	game["flag_icons_h"] = 32;
	game["flag_icons_x"] = 320 - ( game["flag_icons_w"] * 2.5 );
	game["flag_icons_y"] = 480 - game["flag_icons_h"]-4;
	
	level.callbackStartGameType = ::Callback_StartGameType; // Set the level to refer to this script when called upon.
	level.callbackPlayerConnect = ::Callback_PlayerConnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDamage = ::Callback_PlayerDamage; // Set the level to refer to this script when called upon.
	level.callbackPlayerKilled = ::Callback_PlayerKilled; // Set the level to refer to this script when called upon.

	maps\mp\gametypes\_callbacksetup::SetupCallbacks(); // Run this script upon load.

	allowed[0] = "bas"; 
	maps\mp\gametypes\_gameobjects::main(allowed); // Take the "allowed" array and apply it to this script. which just deletes all of the objects that do not have script_objectname set to any of the allowed arrays. Ex. allowed[0].

	if(getCvar("scr_bas_timelimit") == "")		// Time limit per map
		setCvar("scr_bas_timelimit", "0");
	else if(getCvarFloat("scr_bas_timelimit") > 1440)
		setCvar("scr_bas_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_bas_timelimit");
	setCvar("ui_bas_timelimit", level.timelimit);
	makeCvarServerInfo("ui_bas_timelimit", "0");

	if(getCvar("scr_bas_roundlength") == "")		// Time length of each round
		setCvar("scr_bas_roundlength", "30");
	else if(getCvarFloat("scr_bas_roundlength") > 60)
		setCvar("scr_bas_roundlength", "60");
	level.roundlength = getCvarFloat("scr_bas_roundlength");
	setCvar("ui_bas_roundlength", getCvar("scr_bas_roundlength"));
	makeCvarServerInfo("ui_bas_roundlength", "0");


	if(getCvar("scr_bas_scorelimit") == "")		// Score limit per map
		setCvar("scr_bas_scorelimit", "3");
	level.scorelimit = getCvarint("scr_bas_scorelimit");
	setCvar("ui_bas_scorelimit", getCvar("scr_bas_scorelimit"));
	makeCvarServerInfo("ui_bas_scorelimit", "0");
		
	if(getCvar("scr_friendlyfire") == "")		// Friendly fire
		setCvar("scr_friendlyfire", "1");	//default is ON

	if(getCvar("scr_battlerank") == "")		
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");

	if(getCvar("scr_shellshock") == "")		// controls whether or not players get shellshocked from grenades or rockets
		setCvar("scr_shellshock", "1");
	setCvar("ui_shellshock", getCvar("scr_shellshock"));
	makeCvarServerInfo("ui_shellshock", "0");
			
	if(getCvar("scr_showicons") == "")		// flag icons on or off
		setCvar("scr_showicons", "1");

	if(getCvar("scr_bas_startrounddelay") == "")	// Time to wait at the begining of the round
		setCvar("scr_bas_startrounddelay", "15");
	if(getCvar("scr_bas_endrounddelay") == "")		// Time to wait at the end of the round
		setCvar("scr_bas_endrounddelay", "10");

	if(getCvar("scr_drawfriend") == "")		// Draws a team icon over teammates, default is on.
		setCvar("scr_drawfriend", "1");
	level.drawfriend = getCvarint("scr_drawfriend");

	if(getCvar("scr_bas_clearscoreeachround") == "")	// clears everyones score between each round if true
		setCvar("scr_bas_clearscoreeachround", "1");
	setCvar("ui_bas_clearscoreeachround", getCvar("scr_bas_clearscoreeachround"));
	makeCvarServerInfo("ui_bas_clearscoreeachround", "0");

	if(getCvar("g_allowvote") == "")		// Ability to cast votes.
		setCvar("g_allowvote", "1");	
	level.allowvote = getCvarint("g_allowvote");
	setCvar("scr_allow_vote", level.allowvote);

	if(!isDefined(game["state"]))			// Setting the game state.
		game["state"] = "playing";
	if(!isDefined(game["roundsplayed"]))
		game["roundsplayed"] = 0;
	if(!isDefined(game["matchstarted"]))
		game["matchstarted"] = false;
	if(!isDefined(game["matchstarting"]))
		game["matchstarting"] = false;
	if(!isDefined(game["timepassed"]))
		game["timepassed"] = 0;
		
	if(!isDefined(game["alliedscore"]))		// Setup the score for the allies to be 0.
		game["alliedscore"] = 0;
	setTeamScore("allies", game["alliedscore"]);

	if(!isDefined(game["axisscore"]))		// Setup the score for the axis to be 0.
		game["axisscore"] = 0;
	setTeamScore("axis", game["axisscore"]);

	if(getCvar("scr_drophealth") == "")		
		setCvar("scr_drophealth", "1");

	// turn off ceasefire
	level.ceasefire = 0;
	setCvar("scr_ceasefire", "0");

	// set up kill cam
	killcam = getCvar("scr_killcam");
	if(killcam == "")				// Kill cam
		killcam = "1";
	setCvar("scr_killcam", killcam, true);
	level.killcam = getCvarInt("scr_killcam");
	setCvar("ui_killcam", level.killcam);
	makeCvarServerInfo("ui_killcam", "0");

	if(getCvar("scr_teambalance") == "")		// Auto Team Balancing
		setCvar("scr_teambalance", "0");
	level.teambalance = getCvarInt("scr_teambalance");
	level.teambalancetimer = 0;

	if(getCvar("scr_freelook") == "")		// Free look spectator
		setCvar("scr_freelook", "0");
	level.allowfreelook = getCvarInt("scr_freelook");
	
	if(getCvar("scr_spectateenemy") == "")		// Spectate Enemy Team
		setCvar("scr_spectateenemy", "0");
	level.allowenemyspectate = getCvarInt("scr_spectateenemy");
	

	if(getCvar("scr_bas_respawn_wave_time") == "")	
		setCvar("scr_bas_respawn_wave_time", "10");
	else if(getCvarFloat("scr_bas_respawn_wave_time") < 1)
		setCvar("scr_bas_respawn_wave_time", "1");

	level.respawn_wave_time = getCvarint("scr_bas_respawn_wave_time");
	level.respawn_timer["axis"] = level.respawn_wave_time;
	level.respawn_timer["allies"] = level.respawn_wave_time;
	
	
	if(getCvar("scr_bas_roundlimit") == "")		// Round limit per map
		setCvar("scr_bas_roundlimit", "0");
	level.roundlimit = getCvarInt("scr_bas_roundlimit");
	setCvar("ui_bas_roundlimit", level.roundlimit);
	makeCvarServerInfo("ui_bas_roundlimit", "0");

	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	game["bas_obj_text"] = (&"GMI_BAS_ATTACKER_OBJECTIVE");
	
	if (!isdefined (game["BalanceTeamsNextRound"]))
		game["BalanceTeamsNextRound"] = false;
	
	level.roundstarted = false;			// Set up level.roundstarted to be false, until both teams have 1 person.
	level.roundended = false;			// Set up level.roundended to be false, until the round has ended, this will be taken out, since there will not be a timelimit to rounds.
	level.mapended = false;				// Set up level.mapended to be false, until the overall timelimit is finished.
	
	level.exist["allies"] = 0; 	// This is a level counter, used when clients choose a team.
	level.exist["axis"] = 0; 	// This is a level counter, used when clients choose a team.
	level.exist["teams"] = false;
	level.didexist["allies"] = false;
	level.didexist["axis"] = false;
	level.death_pool["allies"] = 0; // Sets the allies death pool to 0.
	level.death_pool["axis"] = 0; // Sets the axis death pool to 0.
	level.max_flag_count = 15;  // this is the limit of the amount of flags in one level
	
	level.healthqueue = [];
	level.healthqueuecurrent = 0;

	// only going to archive if kill cam is on
	if(level.killcam >= 1)
		setarchive(true);

	//get the minefields
	level.minefield = getentarray("minefield", "targetname");
	if (!isdefined (level.minefield))
		level.minefield = [];
	hurtTrigs = getentarray("trigger_hurt","classname");
	for (i=0;i<hurtTrigs.size;i++)
		level.minefield[level.minefield.size] = hurtTrigs[i];

	// 
	// DEBUG
	//
	if(getCvar("scr_debug_bas") == "")
		setCvar("scr_debug_bas", "0"); 
	if(getCvar("scr_debug_bas") != "0")
	{		
		setCvar("scr_startrounddelay", "5");
		setCvar("scr_respawn_wave_time", "2");
	}

	precacheShader("baseassault_clockface");
	precacheShader("baseassault_clockfaceneedle");
	precacheShader("gfx/hud/baseassault/hud@ba_bomb.dds");
	precacheShader("gfx/hud/baseassault/hud@ba_tool.dds");
	precacheShader("gfx/hud/baseassault/bomb_blink.dds");
	precacheShader("gfx/hud/baseassault/hud@ba_death.dds");

	//precacheShader("gfx/hud/baseassault/hud@ba_death.dds");

	game["hud_allies_base"] = "gfx/hud/hud@alliesflag";
	game["hud_axis_base"] = "gfx/hud/hud@axisflag";
	precacheItem("item_health");
	
	if(getCvar("scr_bas_planttime") == "") setCvar("scr_bas_planttime",15);
	if(getCvar("scr_bas_defusetime") == "") setCvar("scr_bas_defusetime",10);
	if(getCvar("scr_bas_bombtime") == "") setCvar("scr_bas_bombtime",60);
	if(getCvar("scr_bas_announcer") == "") setCvar("scr_bas_announcer",15);

//	scores adjusting

	setCvar("scr_bas_plant_score",2);
	setCvar("scr_bas_breach_score",4);
	setCvar("scr_bas_defuse_score",4);
	setCvar("scr_bas_destroyed_score",5);
	setCvar("scr_bas_defend_score",1);

	level.planttime 	= getCvarInt("scr_bas_planttime");		// seconds to plant a bomb
	level.defusetime 	= getCvarInt("scr_bas_defusetime");		// seconds to defuse a bomb
	level.objective_countdown = getCvarInt("scr_bas_bombtime");	// seconds for bomb to blow up 
	level.announcer_time = getCvarInt("scr_bas_announcer");
	level.hudcount = 0;
	level.numobjectives = 0;

	if(getCvar("scr_bas_basehealth") == "")		// healtg for each base
		setCvar("scr_bas_basehealth", "24500");	// 700 tank shell * 35

	if(getCvar("scr_bas_damagedhealth") == "")	// health to switch to damage model
		setCvar("scr_bas_damagedhealth", getCvarInt("scr_bas_basehealth")/2);	//	half if undefined

	level.basehealth = getCvarInt("scr_bas_basehealth");
	level.basedamagedhealth = getCvarInt("scr_bas_damagedhealth");
}

precacheAlliesGfx()
{
		precacheShader(game["allies_ammo_large_dead"]);
		precacheShader(game["allies_fuel_large_dead"]);
		precacheShader(game["allies_hq_large_dead"]);
		precacheShader(game["allies_ammo_large_breached"]);
		precacheShader(game["allies_fuel_large_breached"]);
		precacheShader(game["allies_hq_large_breached"]);
		precacheShader(game["allies_ammo_large_blink"]);
		precacheShader(game["allies_fuel_large_blink"]);
		precacheShader(game["allies_hq_large_blink"]);
		precacheShader(game["allies_ammo_large"]);
		precacheShader(game["allies_fuel_large"]);
		precacheShader(game["allies_hq_large"]);
		precacheShader(game["allies_ammo"]);
		precacheShader(game["allies_ammo"]+ "_up");
		precacheShader(game["allies_ammo"]+ "_down");
		precacheShader(game["allies_fuel"]);
		precacheShader(game["allies_fuel"]+ "_up");
		precacheShader(game["allies_fuel"]+ "_down");
		precacheShader(game["allies_hq"]);
		precacheShader(game["allies_hq"]+ "_up");
		precacheShader(game["allies_hq"]+ "_down");
		precacheShader(game["allies_ammo_blink"]);
		precacheShader(game["allies_fuel_blink"]);
		precacheShader(game["allies_hq_blink"]);
		precacheShader(game["allies_ammo_blink"] + "_up");
		precacheShader(game["allies_fuel_blink"] + "_up");
		precacheShader(game["allies_hq_blink"] + "_up");
		precacheShader(game["allies_ammo_blink"] + "_down");
		precacheShader(game["allies_fuel_blink"] + "_down");
		precacheShader(game["allies_hq_blink"] + "_down");
		precacheShader(game["allies_ammo_breached"]);
		precacheShader(game["allies_fuel_breached"]);
		precacheShader(game["allies_hq_breached"]);
		precacheShader(game["allies_ammo_breached"] + "_up");
		precacheShader(game["allies_fuel_breached"] + "_up");
		precacheShader(game["allies_hq_breached"] + "_up");
		precacheShader(game["allies_ammo_breached"] + "_down");
		precacheShader(game["allies_fuel_breached"] + "_down");
		precacheShader(game["allies_hq_breached"] + "_down");
		//	ALLIED
}

// ----------------------------------------------------------------------------------
// CALLBACKS
// ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------
//	Callback_StartGameType
//
// 		Gets called automatically when the game starts
// ----------------------------------------------------------------------------------
Callback_StartGameType() // Setup the game.
{
	// if this is a fresh map start, set nationalities based on cvars, otherwise leave game variable nationalities as set in the level script
	if(!isDefined(game["gamestarted"]))
	{
		// defaults if not defined in level script
		if(!isDefined(game["allies"]))
			game["allies"] = "american"; // If not defined, set the global game["allies"] to american.
		if(!isDefined(game["axis"]))
			game["axis"] = "german"; // If not defined, set the global game["axis"] to german.

		if(!isDefined(game["bas_layoutimage"])) // If not defined, set the game["layoutimage"] to default. usually this is set in the mapname.gsc
			game["bas_layoutimage"] = "default";

		layoutname = "levelshots/layouts/hud@layout_" + game["bas_layoutimage"];
		precacheShader(layoutname); // Precache the layoutimage.

		setCvar("scr_layoutimage", layoutname); // Setup the scr_layoutimage cvar to be layoutname.
		makeCvarServerInfo("scr_layoutimage", ""); // Set the cvar with the scr_layoutimage.

		// server cvar overrides
		if(getCvar("scr_allies") != "")
			game["allies"] = getCvar("scr_allies");	
		if(getCvar("scr_axis") != "")
			game["axis"] = getCvar("scr_axis");

		if (!isdefined(game["bas_allies_complete"]))
			game["bas_allies_complete"] 	= "xmodel/mp_bunker_foy";
		if (!isdefined(game["bas_allies_damaged"]))
			game["bas_allies_damaged"] 	= "xmodel/mp_bunker_foy_predmg";
		if (!isdefined(game["bas_allies_destroyed"]))
			game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";
		if (!isdefined(game["bas_allies_rubble"]))
			game["bas_allies_rubble"] 	= "xmodel/mp_bunker_foy_rubble";

		if (!isdefined(game["bas_axis_complete"]))
			game["bas_axis_complete"] 	= "xmodel/mp_bunker_foy";
		if (!isdefined(game["bas_axis_damaged"]))
			game["bas_axis_damaged"] 	= "xmodel/mp_bunker_foy_predmg";
		if (!isdefined(game["bas_axis_destroyed"]))
			game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";
		if (!isdefined(game["bas_axis_rubble"]))
			game["bas_axis_rubble"] 	= "xmodel/mp_bunker_foy_rubble";

		precacheModel(game["bas_allies_complete"]);
		precacheModel(game["bas_allies_damaged"]);
		precacheModel(game["bas_allies_destroyed"]);
		precacheModel(game["bas_allies_rubble"]);
		precacheModel(game["bas_axis_complete"]);
		precacheModel(game["bas_axis_damaged"]);
		precacheModel(game["bas_axis_destroyed"]);
		precacheModel(game["bas_axis_rubble"]);

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

		precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_SKIP");
		precacheString(&"MPSCRIPT_KILLCAM");
		precacheString(&"MPSCRIPT_ALLIES_WIN");
		precacheString(&"MPSCRIPT_AXIS_WIN");
		// GMI STRINGS
		precacheString(&"GMI_MP_CEASEFIRE");
		precacheString(&"GMI_DOM_MATCHSTARTING");
		precacheString(&"GMI_DOM_MATCHRESUMING");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_AN_NEXT");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_A_NEXT");
		precacheString(&"GMI_DOM_WAIT_TILL_MATCHSTART");
		precacheString(&"num_0");
		precacheString(&"num_1");
		precacheString(&"num_2");
		precacheString(&"num_3");
		precacheString(&"num_4");
		precacheString(&"num_5");
		precacheString(&"num_6");
		precacheString(&"num_7");
		precacheString(&"num_8");
		precacheString(&"num_9");
		precacheString(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
		precacheString(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
		precacheString(&"SD_EXPLOSIVESPLANTED");
		precacheString(&"SD_EXPLOSIVESDEFUSED");

		precacheString(&"GMI_BAS_AXIS_DEFEND");
		precacheString(&"GMI_BAS_ALLIES_DEFEND");

		precacheString(&"GMI_BAS_AXIS_DEFEND_DEFUSE");
		precacheString(&"GMI_BAS_ALLIES_DEFEND_DEFUSE");

		precacheString(&"GMI_BAS_DIFFUSING_BOMB");
		precacheString(&"GMI_BAS_PLANTING_BOMB");
		precacheString(&"GMI_BAS_BOMB_UNARMED");
		precacheString(&"GMI_BAS_USE_TO_DEFUSE");
		precacheString(&"GMI_BAS_USE_TO_PLANT");

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

		precacheShader("gfx/hud/hud@health_bar.dds");
		precacheShader("black");
		precacheShader("white");
		precacheShader("hudScoreboard_mp");
		precacheShader("gfx/hud/hud@mpflag_spectator.tga");
		precacheStatusIcon("gfx/hud/hud@status_dead.tga");
		precacheStatusIcon("gfx/hud/hud@status_connecting.tga");

		game["hud_axis_flag"] = "gfx/hud/headicon@axis_flag.dds";
		game["hud_allies_flag"] = "gfx/hud/headicon@allies_flag.dds";
		game["hud_neutral_flag"] = "gfx/hud/headicon@allies_flag.dds";
		game["headicon_allies"] = "gfx/hud/headicon@allies.tga";
		game["headicon_axis"] = "gfx/hud/headicon@axis.tga";
		game["headicon_carrier"] = "gfx/hud/headicon@re_objcarrier.tga";

		precacheHeadIcon(game["headicon_allies"]);
		precacheHeadIcon(game["headicon_axis"]);
		precacheHeadIcon(game["headicon_carrier"]);

		precacheStatusIcon(game["headicon_carrier"]);

		// set up team specific variables
		switch( game["allies"])
		{
		case "british":
			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "uk_victory";
			game["sound_allies_bomb_diffused"] = "uk_bomb_diffused";
			game["sound_allies_bomb_planted"] = "uk_bomb_planted";
			game["sound_allies_base_underattack"] = "uk_gen_underattack";
			game["sound_allies_base_breached"] = "uk_gen_breached";
			game["sound_allies_base_destroyed"] = "uk_gen_destroyed";

			game["allies_ammo"] 		= "ba_o_b1";
			game["allies_fuel"] 		= "ba_o_b2";
			game["allies_hq"] 		= "ba_o_b3";
			game["allies_ammo_blink"] 	= "ba_o_b1_bl";
			game["allies_fuel_blink"] 	= "ba_o_b2_bl";
			game["allies_hq_blink"]   	= "ba_o_b3_bl";
			game["allies_ammo_breached"] 	= "ba_o_b1_br";
			game["allies_fuel_breached"] 	= "ba_o_b2_br";
			game["allies_hq_breached"]   	= "ba_o_b3_br";
			game["allies_ammo_large"] 	= "ba_b1";
			game["allies_fuel_large"] 	= "ba_b2";
			game["allies_hq_large"] 	= "ba_b3";
			game["allies_ammo_large_blink"] = "ba_b1_l_bl";
			game["allies_fuel_large_blink"] = "ba_b2_l_bl";
			game["allies_hq_large_blink"]   = "ba_b3_l_bl";
			game["allies_ammo_large_breached"]= "ba_b1_l_br";
			game["allies_fuel_large_breached"]= "ba_b2_l_br";
			game["allies_hq_large_breached"]  = "ba_b3_l_br";
			game["allies_ammo_large_dead"]= "ba_b1_l_dead";
			game["allies_fuel_large_dead"]= "ba_b2_l_dead";
			game["allies_hq_large_dead"]  = "ba_b3_l_dead";

			break;
		case "russian":
			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "ru_victory";
			game["sound_allies_bomb_diffused"] = "ru_bomb_diffused";
			game["sound_allies_bomb_planted"] = "ru_bomb_planted";
			game["sound_allies_base_underattack"] = "ru_gen_underattack";
			game["sound_allies_base_breached"] = "ru_gen_breached";
			game["sound_allies_base_destroyed"] = "ru_gen_destroyed";

			game["allies_ammo"] 		= "ba_o_r1";
			game["allies_fuel"] 		= "ba_o_r2";
			game["allies_hq"] 		= "ba_o_r3";
			game["allies_ammo_blink"] 	= "ba_o_r1_bl";
			game["allies_fuel_blink"] 	= "ba_o_r2_bl";
			game["allies_hq_blink"]   	= "ba_o_r3_bl";
			game["allies_ammo_breached"] 	= "ba_o_r1_br";
			game["allies_fuel_breached"] 	= "ba_o_r2_br";
			game["allies_hq_breached"]   	= "ba_o_r3_br";
			game["allies_ammo_large"] 	= "ba_r1";
			game["allies_fuel_large"] 	= "ba_r2";
			game["allies_hq_large"] 	= "ba_r3";
			game["allies_ammo_large_blink"] = "ba_r1_l_bl";
			game["allies_fuel_large_blink"] = "ba_r2_l_bl";
			game["allies_hq_large_blink"]   = "ba_r3_l_bl";
			game["allies_ammo_large_breached"]= "ba_r1_l_br";
			game["allies_fuel_large_breached"]= "ba_r2_l_br";
			game["allies_hq_large_breached"]  = "ba_r3_l_br";
			game["allies_ammo_large_dead"]= "ba_r1_l_dead";
			game["allies_fuel_large_dead"]= "ba_r2_l_dead";
			game["allies_hq_large_dead"]  = "ba_r3_l_dead";

			break;
		default:		// default is american
		
			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "us_victory";
			game["sound_allies_bomb_diffused"] = "us_bomb_diffused";
			game["sound_allies_bomb_planted"] = "us_bomb_planted";
			game["sound_allies_base_underattack"] = "us_gen_underattack";
			game["sound_allies_base_breached"] = "us_gen_breached";
			game["sound_allies_base_destroyed"] = "us_gen_destroyed";

			game["allies_ammo"] 		= "ba_o_usa1";
			game["allies_fuel"] 		= "ba_o_usa2";
			game["allies_hq"] 		= "ba_o_usa3";
			game["allies_ammo_blink"] 	= "ba_o_usa1_bl";
			game["allies_fuel_blink"] 	= "ba_o_usa2_bl";
			game["allies_hq_blink"]   	= "ba_o_usa3_bl";
			game["allies_ammo_breached"] 	= "ba_o_usa1_br";
			game["allies_fuel_breached"] 	= "ba_o_usa2_br";
			game["allies_hq_breached"]   	= "ba_o_usa3_br";
			game["allies_ammo_large"] 	= "ba_usa1";
			game["allies_fuel_large"] 	= "ba_usa2";
			game["allies_hq_large"] 	= "ba_usa3";
			game["allies_ammo_large_blink"] = "ba_usa1_l_bl";
			game["allies_fuel_large_blink"] = "ba_usa2_l_bl";
			game["allies_hq_large_blink"]   = "ba_usa3_l_bl";
			game["allies_ammo_large_breached"]= "ba_usa1_l_br";
			game["allies_fuel_large_breached"]= "ba_usa2_l_br";
			game["allies_hq_large_breached"]  = "ba_usa3_l_br";
			game["allies_ammo_large_dead"]= "ba_usa1_l_dead";
			game["allies_fuel_large_dead"]= "ba_usa2_l_dead";
			game["allies_hq_large_dead"]  = "ba_usa3_l_dead";

			break;
		}



		game["sound_axis_victory_vo"] = "MP_announcer_axis_win";
		game["sound_axis_victory_music"] = "ge_victory";
		game["sound_axis_bomb_diffused"] = "ge_bomb_diffused";
		game["sound_axis_bomb_planted"] = "ge_bomb_planted";
		game["sound_axis_base_underattack"] = "ge_gen_underattack";
		game["sound_axis_base_breached"] = "ge_gen_breached";
		game["sound_axis_base_destroyed"] = "ge_gen_destroyed";
	
		game["sound_round_draw_vo"] = "MP_announcer_round_draw";

		// victory images
		if ( !isDefined( game["hud_allies_victory_image"] ) )
			game["hud_allies_victory_image"] = "gfx/hud/allies_win";
		if ( !isDefined( game["hud_axis_victory_image"] ) )
			game["hud_axis_victory_image"] = "gfx/hud/axis_win";
		
		// GMI FLAG MATCH IMAGES:
		precacheShader("hudStopwatch");
		precacheShader("hudStopwatchNeedle");

		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);


		precacheAlliesGfx();

		//	AXIS
	
		game["axis_ammo"] 		= "ba_o_g1";
		game["axis_fuel"] 		= "ba_o_g2";
		game["axis_hq"] 		= "ba_o_g3";
		game["axis_ammo_blink"] 	= "ba_o_g1_bl";
		game["axis_fuel_blink"] 	= "ba_o_g2_bl";
		game["axis_hq_blink"]   	= "ba_o_g3_bl";
		game["axis_ammo_breached"] 	= "ba_o_g1_br";
		game["axis_fuel_breached"] 	= "ba_o_g2_br";
		game["axis_hq_breached"]   	= "ba_o_g3_br";
		game["axis_ammo_large"] 	= "ba_g1";
		game["axis_fuel_large"] 	= "ba_g2";
		game["axis_hq_large"] 		= "ba_g3";
		game["axis_ammo_large_blink"] 	= "ba_g1_l_bl";
		game["axis_fuel_large_blink"] 	= "ba_g2_l_bl";
		game["axis_hq_large_blink"]   	= "ba_g3_l_bl";
		game["axis_ammo_large_breached"]= "ba_g1_l_br";
		game["axis_fuel_large_breached"]= "ba_g2_l_br";
		game["axis_hq_large_breached"]  = "ba_g3_l_br";
		game["axis_ammo_large_dead"]= "ba_g1_l_dead";
		game["axis_fuel_large_dead"]= "ba_g2_l_dead";
		game["axis_hq_large_dead"]  = "ba_g3_l_dead";

		precacheShader(game["axis_ammo_large_dead"]);
		precacheShader(game["axis_fuel_large_dead"]);
		precacheShader(game["axis_hq_large_dead"]);
		precacheShader(game["axis_ammo_large_breached"]);
		precacheShader(game["axis_fuel_large_breached"]);
		precacheShader(game["axis_hq_large_breached"]);
		precacheShader(game["axis_ammo_large_blink"]);
		precacheShader(game["axis_fuel_large_blink"]);
		precacheShader(game["axis_hq_large_blink"]);
		precacheShader(game["axis_ammo_large"]);
		precacheShader(game["axis_fuel_large"]);
		precacheShader(game["axis_hq_large"]);
		precacheShader(game["axis_ammo"]);
		precacheShader(game["axis_ammo"]+ "_up");
		precacheShader(game["axis_ammo"]+ "_down");
		precacheShader(game["axis_fuel"]);
		precacheShader(game["axis_fuel"]+ "_up");
		precacheShader(game["axis_fuel"]+ "_down");
		precacheShader(game["axis_hq"]);
		precacheShader(game["axis_hq"]+ "_up");
		precacheShader(game["axis_hq"]+ "_down");
		precacheShader(game["axis_ammo_blink"]);
		precacheShader(game["axis_fuel_blink"]);
		precacheShader(game["axis_hq_blink"]);
		precacheShader(game["axis_ammo_blink"] + "_up");
		precacheShader(game["axis_fuel_blink"] + "_up");
		precacheShader(game["axis_hq_blink"] + "_up");
		precacheShader(game["axis_ammo_blink"] + "_down");
		precacheShader(game["axis_fuel_blink"] + "_down");
		precacheShader(game["axis_hq_blink"] + "_down");
		precacheShader(game["axis_ammo_breached"]);
		precacheShader(game["axis_fuel_breached"]);
		precacheShader(game["axis_hq_breached"]);
		precacheShader(game["axis_ammo_breached"] + "_up");
		precacheShader(game["axis_fuel_breached"] + "_up");
		precacheShader(game["axis_hq_breached"] + "_up");
		precacheShader(game["axis_ammo_breached"] + "_down");
		precacheShader(game["axis_fuel_breached"] + "_down");
		precacheShader(game["axis_hq_breached"] + "_down");
			
		//	AXIS

		maps\mp\gametypes\_teams::precache(); // Precache weapons.
		maps\mp\gametypes\_teams::scoreboard(); // Precache scoreboard menu.
	}
	
	maps\mp\gametypes\_teams::modeltype(); // Precache player models.
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons(); // Restrict certain weapons, if they exist. Cvar dependant.
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_teams::updateWeaponCvars();

	game["gamestarted"] = true; // Set the global flag of "gamestarted" to be true.
	
	setClientNameMode("auto_change");


	if ( getcvar("fs_copyfiles") == "1")
	{
		precacheModel("xmodel/mp_bunker_foy");
		precacheModel("xmodel/mp_bunker_foy_predmg");
		precacheModel("xmodel/mp_bunker_foy_dmg");
		precacheModel("xmodel/mp_bunker_foy_rubble");
		precacheModel("xmodel/mp_bunker_italy");
		precacheModel("xmodel/mp_bunker_italy_predmg");
		precacheModel("xmodel/mp_bunker_italy_dmg");
		precacheModel("xmodel/mp_bunker_italy_rubble");
		precacheModel("xmodel/mp_bunker_rhinevalley");
		precacheModel("xmodel/mp_bunker_rhinevalley_predmg");
		precacheModel("xmodel/mp_bunker_rhinevalley_dmg");
		precacheModel("xmodel/mp_bunker_rhinevalley_rubble");
		precacheModel("xmodel/mp_bunker_kursk");
		precacheModel("xmodel/mp_bunker_kursk_predmg");
		precacheModel("xmodel/mp_bunker_kursk_dmg");
		precacheModel("xmodel/mp_bunker_kursk_rubble");

		game["allies_ammo"] 		= "ba_o_b1";
		game["allies_fuel"] 		= "ba_o_b2";
		game["allies_hq"] 		= "ba_o_b3";
		game["allies_ammo_blink"] 	= "ba_o_b1_bl";
		game["allies_fuel_blink"] 	= "ba_o_b2_bl";
		game["allies_hq_blink"]   	= "ba_o_b3_bl";
		game["allies_ammo_breached"] 	= "ba_o_b1_br";
		game["allies_fuel_breached"] 	= "ba_o_b2_br";
		game["allies_hq_breached"]   	= "ba_o_b3_br";
		game["allies_ammo_large"] 	= "ba_b1";
		game["allies_fuel_large"] 	= "ba_b2";
		game["allies_hq_large"] 	= "ba_b3";
		game["allies_ammo_large_blink"] = "ba_b1_l_bl";
		game["allies_fuel_large_blink"] = "ba_b2_l_bl";
		game["allies_hq_large_blink"]   = "ba_b3_l_bl";
		game["allies_ammo_large_breached"]= "ba_b1_l_br";
		game["allies_fuel_large_breached"]= "ba_b2_l_br";
		game["allies_hq_large_breached"]  = "ba_b3_l_br";
		game["allies_ammo_large_dead"]= "ba_b1_l_dead";
		game["allies_fuel_large_dead"]= "ba_b2_l_dead";
		game["allies_hq_large_dead"]  = "ba_b3_l_dead";
		precacheAlliesGfx();

		game["allies_ammo"] 		= "ba_o_r1";
		game["allies_fuel"] 		= "ba_o_r2";
		game["allies_hq"] 		= "ba_o_r3";
		game["allies_ammo_blink"] 	= "ba_o_r1_bl";
		game["allies_fuel_blink"] 	= "ba_o_r2_bl";
		game["allies_hq_blink"]   	= "ba_o_r3_bl";
		game["allies_ammo_breached"] 	= "ba_o_r1_br";
		game["allies_fuel_breached"] 	= "ba_o_r2_br";
		game["allies_hq_breached"]   	= "ba_o_r3_br";
		game["allies_ammo_large"] 	= "ba_r1";
		game["allies_fuel_large"] 	= "ba_r2";
		game["allies_hq_large"] 	= "ba_r3";
		game["allies_ammo_large_blink"] = "ba_r1_l_bl";
		game["allies_fuel_large_blink"] = "ba_r2_l_bl";
		game["allies_hq_large_blink"]   = "ba_r3_l_bl";
		game["allies_ammo_large_breached"]= "ba_r1_l_br";
		game["allies_fuel_large_breached"]= "ba_r2_l_br";
		game["allies_hq_large_breached"]  = "ba_r3_l_br";
		game["allies_ammo_large_dead"]= "ba_r1_l_dead";
		game["allies_fuel_large_dead"]= "ba_r2_l_dead";
		game["allies_hq_large_dead"]  = "ba_r3_l_dead";
		precacheAlliesGfx();

		game["allies_ammo"] 		= "ba_o_usa1";
		game["allies_fuel"] 		= "ba_o_usa2";
		game["allies_hq"] 		= "ba_o_usa3";
		game["allies_ammo_blink"] 	= "ba_o_usa1_bl";
		game["allies_fuel_blink"] 	= "ba_o_usa2_bl";
		game["allies_hq_blink"]   	= "ba_o_usa3_bl";
		game["allies_ammo_breached"] 	= "ba_o_usa1_br";
		game["allies_fuel_breached"] 	= "ba_o_usa2_br";
		game["allies_hq_breached"]   	= "ba_o_usa3_br";
		game["allies_ammo_large"] 	= "ba_usa1";
		game["allies_fuel_large"] 	= "ba_usa2";
		game["allies_hq_large"] 	= "ba_usa3";
		game["allies_ammo_large_blink"] = "ba_usa1_l_bl";
		game["allies_fuel_large_blink"] = "ba_usa2_l_bl";
		game["allies_hq_large_blink"]   = "ba_usa3_l_bl";
		game["allies_ammo_large_breached"]= "ba_usa1_l_br";
		game["allies_fuel_large_breached"]= "ba_usa2_l_br";
		game["allies_hq_large_breached"]  = "ba_usa3_l_br";
		game["allies_ammo_large_dead"]= "ba_usa1_l_dead";
		game["allies_fuel_large_dead"]= "ba_usa2_l_dead";
		game["allies_hq_large_dead"]  = "ba_usa3_l_dead";
		precacheAlliesGfx();
	}


	level.basehealth = getCvarInt("scr_bas_basehealth");
	level.basedamagedhealth = getCvarInt("scr_bas_damagedhealth");

	thread GameRoundThink();
	thread startGame();
	thread updateGametypeCvars();

	thread BaseAssault_GMI();
}

// ----------------------------------------------------------------------------------
//	Callback_PlayerConnect
//
// 		Gets called automatically when a player joins
// ----------------------------------------------------------------------------------
Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";
	if (!isdefined (self.pers["teamTime"]))
		self.pers["teamTime"] = 1000000;
	self.objs_held = 0;
	self.droptimer = 0;
	self.planting = 0;
	self.defusing = 0;
	self.lastattacktime = 0;
	
	if(!isDefined(self.pers["score"]))
		self.pers["score"] = 0;

	if(!isDefined(self.pers["team"]))
		iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	logPrint("J;" + lpselfguid + ";" + lpselfnum + ";" + self.name + "\n");

	// set the cvar for the map quick bind
	self setClientCvar("g_scriptQuickMap", game["menu_viewmap"]);
	
	if(game["state"] == "intermission")
	{
		SpawnIntermission();
		return;
	}
	
	level endon("intermission");

	// make sure that the rank variable is initialized
	if ( !isDefined( self.pers["rank"] ) )
		self.pers["rank"] = 0;

	//JS setup teamkiller tracking
	if(!isDefined(self.teamkiller) || self.teamkiller != 0)
		self.teamkiller = 0;
	if(!isDefined(self.teamkillertotal) || self.teamkillertotal != 0)
		self.teamkillertotal = 0;
	if(!isDefined(self.wereteamkilled))
		self.wereteamkilled = 0;
		
	if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("ui_weapontab", "1");

		if(self.pers["team"] == "allies")
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
		else
			self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);

		if(isDefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			self.sessionteam = "spectator";

			SpawnSpectator();

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

		SpawnSpectator();
	}

	// start the vsay thread
	self thread maps\mp\gametypes\_teams::vsay_monitor();

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
			
		if(menu == game["menu_team"] ) // && self.teamkiller != 1)	//JS check to make sure they're not trying to switch teams while in TK limbo

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
					
						if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator" || player == self)
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
				
				if(response == self.pers["team"] && self.sessionstate == "playing")
					break;
				
				
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
				self.pers["teamTime"] = (gettime() / 1000);
				self.pers["weapon"] = undefined;
				self.pers["weapon1"] = undefined;
				self.pers["weapon2"] = undefined;
				self.pers["spawnweapon"] = undefined;
				self.pers["savedmodel"] = undefined;
				self.nextroundweapon = undefined;
				
				self thread printJoinedTeam(self.pers["team"]);

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
					if(isAlive(self))
						self suicide();
					
					self stopwatch_delete("spectator");
	
					self.pers["team"] = "spectator";
					self.pers["teamTime"] = 1000000;
					self.pers["weapon"] = undefined;
					self.pers["weapon1"] = undefined;
					self.pers["weapon2"] = undefined;
					self.pers["spawnweapon"] = undefined;
					self.pers["savedmodel"] = undefined;
					
					self.sessionteam = "spectator";
					self setClientCvar("g_scriptMainMenu", game["menu_team"]);
					self setClientCvar("ui_weapontab", "0");

					SpawnSpectator();

					level thread CheckMatchStart();
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
			
			if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;

			weapon = self maps\mp\gametypes\_teams::restrict(response);

			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}
			
			self.pers["selectedweapon"] = weapon;

			if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon && !isDefined(self.pers["weapon1"]))
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

// ----------------------------------------------------------------------------------
//	Callback_PlayerDisconnect
//
// 		Gets called automatically when a player disconnects
// ----------------------------------------------------------------------------------
Callback_PlayerDisconnect()
{
	iprintln(&"MPSCRIPT_DISCONNECTED", self);
	
	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	logPrint("Q;" + lpselfguid + ";" + lpselfnum + ";" + self.name + "\n");

	self notify("death");

	if(game["matchstarted"])
		level thread updateTeamStatus();
}

// ----------------------------------------------------------------------------------
//	Callback_PlayerDamage
//
// 		Gets called automatically when a player gets damaged
// ----------------------------------------------------------------------------------
Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if(self.sessionteam == "spectator")
		return;

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// dont take damage during ceasefire mode
	// but still take damage from ambient damage (water, minefields, fire)
	if(level.ceasefire && sMeansOfDeath != "MOD_EXPLOSIVE" && sMeansOfDeath != "MOD_WATER" && sMeansOfDeath != "MOD_TRIGGER_HURT")
		return;
		
	// check for completely getting out of the damage
//	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(level.friendlyfire == "1" )
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
		lpselfguid = self getGuid();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackguid = self getGuid();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isDefined(friendly))
		{  
			lpattacknum = lpselfnum;
			lpattackname = lpselfname;
			lpattackguid = lpselfguid;
		}

		logPrint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

// ----------------------------------------------------------------------------------
//	Callback_PlayerKilled
//
// 		Gets called automatically when a player dies
// ----------------------------------------------------------------------------------
Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	self endon("spawned");

	if(self.sessionteam == "spectator")
		return;

	// reset the progress bar stuff
	self.progresstime = 0;
	self.view_bar = 0;

	self Player_ClearHud();
	
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
	if (!isdefined (self.autobalance) && level.roundstarted)
	{
		self.pers["deaths"]++;
		self.deaths = self.pers["deaths"];
	}
	
	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	lpselfname = self.name;
	lpselfteam = self.pers["team"];
	lpattackerteam = "";

	attackerNum = -1;

	doKillcam = true;
	
	if(isPlayer(attacker))
	{
		// check to see if they were killed in the process of capping the flag
		
		if(attacker == self ) // killed himself
		{
			doKillcam = false;

			if ( !level.roundended && !isdefined (self.autobalance) )
			{
				attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetSuicidePoints();
			}
			
			if(isDefined(attacker.friendlydamage))
				clientAnnouncement(attacker, &"MPSCRIPT_FRIENDLY_FIRE_WILL_NOT"); 
		}
		else
		{
			attackerNum = attacker getEntityNumber();

			if (!level.roundended)
			{
				if(self.pers["team"] == attacker.pers["team"]) // killed by a friendly
				{
					attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetTeamKillPoints();

					// mark the teamkiller as such, punish him next time he dies.
					attacker.teamkiller = 1;
					attacker.teamkillertotal ++;
					self.wereteamkilled = 1;
				}
				else
				{
					lpselfnum = attacker getEntityNumber();
					lpselfguid = attacker getGuid();
					
					// 1. we were planting a bomb so give out defense points
					// 2. if they attacked a base recently
					// 3. if they are close to the base give them points
					if (		(self.planting == true)
						||	((self.lastattacktime + 10000) > gettime())
						||	(close_to_an_enemy_base(self, 1000)) )	
					{
						attacker.pers["score"] += getCvarInt("scr_bas_defend_score");
						attacker.score = attacker.pers["score"];

						if (attacker.pers["team"] == "axis")
							iprintln(&"GMI_BAS_DEFENDED_AXIS_BASE", attacker);
						else
							iprintln(&"GMI_BAS_DEFENDED_ALLIES_BASE", attacker);

						logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + attacker.pers["team"] + ";" + attacker.name + ";" + "bas_defend" + "\n");
					}

					attacker.pers["score"] += 1;
					attacker.score = attacker.pers["score"];
				}
			}
		}
		
		attacker.pers["score"] = maps\mp\gametypes\_scoring_gmi::ValidateScore(attacker.pers["score"]);
		attacker.score = attacker.pers["score"];
		
		lpattacknum = attacker getEntityNumber();
		lpattackguid = attacker getGuid();
		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;

		if ( !isdefined(eInflictor) )
			self.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetNoAttackerKillPoints();

		// make sure the score is in an accepatable range
		self.pers["score"] = maps\mp\gametypes\_scoring_gmi::ValidateScore(self.pers["score"]);
					
		self.score = self.pers["score"];
		
		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
		lpattackerteam = "world";
	}

	logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Make the player drop his weapon
	if (!isdefined (self.autobalance))
		self dropItem(self getcurrentweapon());

	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;

	//Remove HUD text if there is any
	for(i = 1; i < 16; i++)
	{
		if((isdefined(self.hudelem)) && (isdefined(self.hudelem[i])))
			self.hudelem[i] destroy();
	}

	if (!isdefined (self.autobalance))
	{
		body = self cloneplayer();
		
		// Make the player drop health
		self dropHealth();
	}
	self.autobalance = undefined;

	updateTeamStatus();

	if((getCvarInt("scr_killcam") <= 0) || !level.exist[self.pers["team"]]) // If the last player on a team was just killed, don't do killcam
		doKillcam = false;

	delay = 2;	// Delay the player becoming a spectator till after he's done dying
	wait delay;	// ?? Also required for Callback_PlayerKilled to complete before killcam can execute

	// start the kill cam if it is turned on
	if(doKillcam && !level.roundended)
	{	
		who_to_watch = attackerNum;
		time_to_respawn = level.respawn_timer[self.pers["team"]] - 1;
		
		self thread maps\mp\gametypes\_killcam_gmi::DisplayKillCam(who_to_watch, time_to_respawn, delay);	
	}
	else
	{
		currentorigin = self.origin;
		currentangles = self.angles;

		self thread spawnSpectator(currentorigin + (0, 0, 60), currentangles);
	}
	
	self thread respawn();	
}

// ----------------------------------------------------------------------------------
//	menu_spawn
//
// 		called from the player connect to spawn the player
// ----------------------------------------------------------------------------------
menu_spawn(weapon)
{
	if(!game["matchstarted"])
	{
		self.pers["weapon"] = weapon;
		self.spawned = undefined;
		self SpawnPlayer();
		level CheckMatchStart();
	}
	else if(!level.roundstarted && !self.usedweapons)
	{
		if(isDefined(self.pers["weapon"]))
		{
	 		self.pers["weapon"] = weapon;
			self maps\mp\gametypes\_loadout_gmi::PlayerSpawnLoadout();
			self switchToWeapon(weapon);
		}
		else
		{
			self.pers["weapon"] = weapon;
			if(!level.exist[self.pers["team"]])
			{
				self.spawned = undefined;
				self spawnPlayer();
				level CheckMatchStart();
				self thread printJoinedTeam(self.pers["team"]);
			}
			else
			{
				self thread respawn();
			}
		}
	}
	//JS If the player is alive and playing during a round, don't give the new weapon for now.  We'll give it to the player next time he spawns.
	else if((self.sessionteam == self.pers["team"] || self.pers["team"] == "spectator" ) && game["matchstarted"] == true && level.roundstarted == true && self.health > 0)
	{
		if(isDefined(self.pers["weapon"]))
		{
			self.nextroundweapon = weapon;
		}
			
		weaponname = maps\mp\gametypes\_teams::getWeaponName(weapon);
		if(maps\mp\gametypes\_teams::useAn(weapon))
		{
			self iprintln(&"GMI_MP_YOU_WILL_SPAWN_WITH_AN_NEXT", weaponname);
		}
		else
		{
			self iprintln(&"GMI_MP_YOU_WILL_SPAWN_WITH_A_NEXT", weaponname);
		}
	}
	else
	{
		if(isDefined(self.pers["weapon"]))
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
			self spawnPlayer();
		}		
		else if(!level.didexist[self.pers["team"]] && !level.roundended)
		{
			self.spawned = undefined;
			self thread  respawn();
			level CheckMatchStart();
		}
		else
		{
			self notify("switched team");
			self.spawned = undefined;
			self thread respawn();
			level CheckMatchStart();				
		}
	}			
	self thread maps\mp\gametypes\_teams::SetSpectatePermissions();
	if (isdefined (self.autobalance_notify))
		self.autobalance_notify destroy();
}

// ----------------------------------------------------------------------------------
// VICTORY FUNCTION
// ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------
//	Victory_PlaySounds
//
// 		Plays the victory sounds with an appropriate delay in each
// ----------------------------------------------------------------------------------
Victory_PlaySounds( announcer, music )
{			
	self playLocalSound(music);
	wait 2.0;
	self playLocalSound(announcer);
}

// ----------------------------------------------------------------------------------
//	Victory_DisplayImage
//
// 		Displays the victory hud image
// ----------------------------------------------------------------------------------
Victory_DisplayImage( image )
{			
	level.victory_image = newHudElem();		
	level.victory_image.alignX = "center";
	level.victory_image.alignY = "top";
	level.victory_image.x = 320;
	level.victory_image.y = 10;
	level.victory_image.alpha = 0.75;
	level.victory_image.sort = 0.5;
	level.victory_image setShader(image, 256, 128);
}

// ----------------------------------------------------------------------------------
// SPAWNING
// ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------
//	Respawn
//
// 		Sets up the countdown clock and then waits for the respawn wave
// ----------------------------------------------------------------------------------
Respawn()
{

	self endon ("end_respawn");
	self endon ("spawned");
	firsttime = 0;
	while(!isDefined(self.pers["weapon"])) {
		
		wait 3;
		
		//self iprintln(&"");	// TODO: tell them they need to select a weapon in order to spawn
		
		if (isDefined(self.pers["weapon"]))
			break;
		
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

	self stopwatch_start("respawn", level.respawn_timer[self.pers["team"]] );
	level thread respawn_pool(self.pers["team"]);
	
	level waittill("respawn_" + self.pers["team"]);
	
	self thread spawnPlayer();
}

// ----------------------------------------------------------------------------------
//	respawn_pool
//
// 		Gets called for every guy that dies.  Starts the next wave timer if 
//		is not already started.  Sends out a notification when 
//		done.
// ----------------------------------------------------------------------------------
respawn_pool(team)
{
	if(level.respawn_timer[team] < level.respawn_wave_time)
		return;
		
	for(i=level.respawn_wave_time;i>0;i--)
	{
		level.respawn_timer[team] = i;
		wait 1;
	}
	level.respawn_timer[team] = level.respawn_wave_time;	
	level notify("respawn_" + team);
}

// ----------------------------------------------------------------------------------
//	SpawnPlayer
//
// 		spawns the player
// ----------------------------------------------------------------------------------
SpawnPlayer()
{
	self endon ("end_respawn");
	self notify("spawned");

	self.toldme = 0;

	resettimeout();

	// clear any hud elements
	self Player_ClearHud();

	self.sessionteam = self.pers["team"];
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	self.lastattacktime = 0;
	
	//JS reset all progress bar stuff
	self.progresstime = 0;
	self.view_bar = 0;
	self.pers["capture_process_thread"] = 0;

	//JS reset teamkiller flag
	self.teamkiller = 0;

	// make sure that the client compass is at the correct zoom specified by the level
	self setClientCvar("cg_hudcompassMaxRange", game["compass_range"]);

	self.sessionstate = "playing";
	
	// pick the appropriate spawn point
	if(self.pers["team"] == "allies")
	{
		base_spawn_name = "mp_gmi_bas_allies_spawn";
		secondary_spawn_name = "mp_gmi_bas_allied_secondary_spawn";
	}
	else 
	{
		base_spawn_name = "mp_gmi_bas_axis_spawn";
		secondary_spawn_name = "mp_gmi_bas_axis_secondary_spawn";
	}	
	// get the base spawnpoints
	spawnpoints = getentarray(base_spawn_name, "classname");
	
	// now add to the array any spawnpoints that are related to held bases
	secondary_spawns =  getentarray(secondary_spawn_name, "classname");

	for ( i = 0; i < secondary_spawns.size; i++ )
	{
		// only get the ones for the current team
		if ( secondary_spawns[i].classname != secondary_spawn_name )
			continue;
			
		spawnpoints = maps\mp\_util_mp_gmi::add_to_array(spawnpoints, secondary_spawns[i]);
	}

	// now add any secondary spawnpoints
	array = maps\mp\gametypes\_secondary_gmi::GetSecondaryTriggers(self.pers["team"]);
	for ( i = 0; i < array.size; i++ )
	{
		if ( !isDefined( array[i].target ) )
			continue;
			
		secondary_spawns =  getentarray(array[i].target, "targetname");
	
		for ( j = 0; j < secondary_spawns.size; j++ )
		{
			// only get the ones for the current team
			if ( secondary_spawns[j].classname != secondary_spawn_name )
				continue;
				
			spawnpoints = maps\mp\_util_mp_gmi::add_to_array(spawnpoints, secondary_spawns[j]);
		}
	}

	// now pick a spawn point
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);

	// this is somewhat redundant now because we verify when the game starts that the spawn points are in
	// but what the hey it does not hurt
	if(isDefined(spawnpoint))
		spawnpoint maps\mp\gametypes\_spawnlogic::SpawnPlayer(self);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	
	self.spawned = true;
	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;
	
	updateTeamStatus();
	
	if(!isDefined(self.pers["score"]))
		self.pers["score"] = 0;
	self.score = self.pers["score"];
	
	self.pers["rank"] = maps\mp\gametypes\_rank_gmi::DetermineBattleRank(self);
	self.rank = self.pers["rank"];
	
	if(!isDefined(self.pers["deaths"]))
		self.pers["deaths"] = 0;
	self.deaths = self.pers["deaths"];
	
	if(!isDefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);
	
	self setClientCvar("cg_objectiveText", game["bas_obj_text"]);
		
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

	// Check to see if the player changed weapon class during round.
	if(isDefined(self.nextroundweapon))
	{
		self.pers["weapon"] = self.nextroundweapon;
		self.nextroundweapon = undefined;
	}

	// setup all the weapons
	self maps\mp\gametypes\_loadout_gmi::PlayerSpawnLoadout();
	
	self.usedweapons = false;
	thread maps\mp\gametypes\_teams::watchWeaponUsage();

	// setup the hud rank indicator
	self thread maps\mp\gametypes\_rank_gmi::RankHudInit();
}

// ----------------------------------------------------------------------------------
//	SpawnSpectator
//
// 		spawns a spectator
// ----------------------------------------------------------------------------------
SpawnSpectator(origin, angles)
{
	self notify("spawned");

	resettimeout();

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	self.lastattacktime = 0;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";

	maps\mp\gametypes\_teams::SetSpectatePermissions();

	if(isDefined(origin) && isDefined(angles))
		self spawn(origin, angles);
	else
	{
		spawnpointname = "mp_gmi_bas_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}

	self.usedweapons = false;

	updateTeamStatus();

	self setClientCvar("cg_objectiveText", game["bas_obj_text"]);
}

// ----------------------------------------------------------------------------------
//	SpawnIntermission
//
// 		spawns an intermission player (kinda like a spectator but different)
// ----------------------------------------------------------------------------------
SpawnIntermission()
{
	self notify("spawned");
	
	resettimeout();

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;

	spawnpointname = "mp_gmi_bas_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
		
}

// ----------------------------------------------------------------------------------
//	startGame
//
// 		starts the game
// ----------------------------------------------------------------------------------

startGame()
{
	seconds = 0;

	level.starttime = getTime();

	thread startRound();
		
	if ( (level.teambalance > 0) && (!game["BalanceTeamsNextRound"]) )
		level thread maps\mp\gametypes\_teams::TeamBalance_Check_Roundbased();
		
	for(;;)
	{
		checkTimeLimit();
		
		if (!level.roundstarted && (!level.roundended))
		{
			if (seconds > 60)
			{	// we havent even started, so count down the timelimit so the map rotation continues
				game["timepassed"] += 1;		// add a minute to the timer
				seconds -= 60;						// dec the seconds
			}
		} else
		{
			seconds = 0;	// round is playing, so prevent idle counter
		}
		
		wait 1;
		seconds++;
	}
}

// ----------------------------------------------------------------------------------
//	startRound
//
// 		Starts the round.  Initializes all of the players
// ----------------------------------------------------------------------------------
startRound()
{	
	// round does not start until the match starts
	if ( !game["matchstarted"] )
		return;
		
	level.roundstarted = true;
	
	thread maps\mp\gametypes\_teams::sayMoveIn();
	
	level.roundstarttime = getTime();

	// if the round length is zero then no clock or timer
	if ( level.roundlength == 0 )
		return;
		
	if (isDefined(level.clock))
		level.clock destroy();
		
	level.clock = newHudElem();
	level.clock.x = 56;
	level.clock.y = 365;
	level.clock.alignX = "center";
	level.clock.alignY = "middle";
	level.clock.font = "bigfixed";
	level.clock setTimer(level.roundlength * 60);

	level.clock.color = (1, 1, 1);
	level.clock.alpha = 0.6;
	wait(level.roundlength * 60);
	
	if(level.roundended)
		return;

	announcement(&"GMI_DOM_TIMEEXPIRED");

	level.bases = getentarray("gmi_base","targetname");
	axis = 0;
	allies = 0;

	for (q=0;q<level.bases.size;q++)
	{
		if (level.bases[q].script_team=="axis")
			axis = axis + 1;
		if (level.bases[q].script_team=="allies")
			allies = allies + 1;
	}

	if (axis < allies)
	{
		announcement(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
		level thread endRound("allies");
	}
	else
	if (axis > allies)
	{
		announcement(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
		level thread endRound("axis");
	}
	else
	{
		level thread endRound("draw");
	}
		

}

// ----------------------------------------------------------------------------------
//	CheckMatchStart
//
// 		Checks to see if the round is ready to start.  Starts round if ready.
// ----------------------------------------------------------------------------------
CheckMatchStart()
{
	updateTeamStatus();

	oldvalue["teams"] = level.exist["teams"];
	level.exist["teams"] = false;

	// If teams currently exist
	if(getCvarInt("scr_debug_bas") != 1) // MikeD: So 1 person can play.
	{
		if(level.exist["allies"] && level.exist["axis"])
			level.exist["teams"] = true;
	}
	else
	{
		level.exist["teams"] = true;
	}

	// If teams previously did not exist and now they do
	if(!oldvalue["teams"] && level.exist["teams"] && !level.roundstarted)
	{
		if(!game["matchstarting"])
		{
			level notify("kill_endround");
			level.roundended = false;
			thread endRound("reset");
		}

		return;
	}
}

// ----------------------------------------------------------------------------------
//	resetScores
//
// 		Resets all of the scores
// ----------------------------------------------------------------------------------
resetScores()
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		player.pers["score"] = 0;
		player.pers["deaths"] = 0;
	}

	if (level.battlerank)
	{
		maps\mp\gametypes\_rank_gmi::ResetPlayerRank();
	}
}

// ----------------------------------------------------------------------------------
//	Player_ClearHud
//
// 		Destroys all player hud elemets
// ----------------------------------------------------------------------------------
Player_ClearHud()
{
	if(isDefined(self.progressbackground))	
	{
		self.progressbackground destroy();
	}
	if(isDefined(self.progressbar))
	{
		self.progressbar destroy();
	}
	if(isDefined(self.progresstext))
	{					
		self.progresstext destroy();
	}

	if (isdefined(self.defuseicon))
	{
		self.defuseicon destroy();
	}
	if (isdefined(self.planticon))
	{
		self.planticon destroy();
	}
}

// ----------------------------------------------------------------------------------
//	endRound
//
// 		Ends the round
// ----------------------------------------------------------------------------------
endRound(roundwinner)
{
	level endon("kill_endround");

	if(level.roundended )
		return;
	
	if ( game["matchstarted"] )
		level.roundended = true;
	
	// End threads and remove related hud elements and objectives
	level notify("round_ended");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		player Player_ClearHud();
	}

 	if (roundwinner == "abort")
		game["matchstarted"] = false;
	level.roundstarted = false;
	 
	if(roundwinner == "allies")
	{		
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			players[i] thread Victory_PlaySounds(game["sound_allies_victory_vo"],game["sound_allies_victory_music"]);
		}
		level thread Victory_DisplayImage(game["hud_allies_victory_image"]);
	}
	else if(roundwinner == "axis")
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			players[i] thread Victory_PlaySounds(game["sound_axis_victory_vo"],game["sound_axis_victory_music"]);
		}
		level thread Victory_DisplayImage(game["hud_axis_victory_image"]);
	}
	else if(roundwinner == "draw" || roundwinner == "abort")
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
			players[i] playLocalSound(game["sound_round_draw_vo"]);
	}

	if (roundwinner != "reset")
	{
		time = getCvarint("scr_bas_endrounddelay");
		
		if ( time < 1 )
			time = 1;
		wait(time);
	}

	winners = "";
	losers = "";

	if(roundwinner == "allies" && !level.mapended)
	{
		//game["alliedscore"]++;
		//setTeamScore("allies", game["alliedscore"]);
		
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			lpGuid = players[i] getGuid();
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				winners = (winners + ";" + lpGuid + ";" + players[i].name);
			else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
				losers = (losers + ";" + lpGuid + ";" + players[i].name);
		}
		logPrint("W;allies" + winners + "\n");
		logPrint("L;axis" + losers + "\n");
	}
	else if(roundwinner == "axis" && !level.mapended)
	{
		//game["axisscore"]++;
		//setTeamScore("axis", game["axisscore"]);

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			lpGuid = players[i] getGuid();
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
				winners = (winners + ";" + lpGuid + ";" + players[i].name);
			else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				losers = (losers + ";" + lpGuid + ";" + players[i].name);
		}
		logPrint("W;axis" + winners + "\n");
		logPrint("L;allies" + losers + "\n");
	}

	if(game["matchstarted"])
	{
		game["roundsplayed"]++;
		
		if ( !level.mapended )
			checkRoundLimit();
	}

	game["timepassed"] = game["timepassed"] + ((getTime() - level.starttime) / 1000) / 60.0;

	// call these checks before calling the score resetting
	checkTimeLimit();
	checkScoreLimit();
	
	if(!game["matchstarted"] && roundwinner == "reset")
	{
		thread resetScores();
		game["roundsplayed"] = 0;
	}
//	else if ( getCvarint("scr_bas_clearscoreeachround") == 1 && !level.mapended)
//	{
//		thread resetScores();
//	}
	
	if(level.mapended)
		return;
	
	// if the teams are not full then abort
	if ( !(level.exist["axis"] && level.exist["allies"]) && !getcvarint("scr_debug_bas") )
	{
		if (isDefined(level.clock))
			level.clock destroy();

		level.clock = undefined;
		return;
	}
		
	
	thread RestartMap();
}

// ----------------------------------------------------------------------------------
//	RestartMap
//
// 		Displays the match starting message and a timer.  Then when the timer
//		is done the map is restarted.
// ----------------------------------------------------------------------------------
RestartMap( )
{
	level endon("kill_startround");

	if ( game["matchstarting"] == true || level.mapended)
		return;
		
	game["matchstarting"] = true;
	
	level thread maps\mp\_util_mp_gmi::make_permanent_announcement(&"GMI_DOM_MATCHSTARTING", "cleanup match starting");			
	
	time = getCvarInt("scr_bas_startrounddelay");
	
	if ( time < 1 )
		time = 1;

	if ( isDefined(level.victory_image) )
	{
		level.victory_image destroy();
	}
	
	// give all of the players clocks to count down until the round starts
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		// clear any hud elements again
		player Player_ClearHud();

		if ( isDefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;
			
		player stopwatch_start("match_start", time);
	}
	
	wait (time);
	
	if ( level.mapended )
		return;

	game["matchstarted"] = true;
	game["matchstarting"] = false;

	if ( getCvarint("scr_bas_clearscoreeachround") == 1 && !level.mapended )
	{
		thread resetScores();
	}

	level notify("cleanup match starting");
	map_restart(true);
}

// ----------------------------------------------------------------------------------
//	endMap
//
// 		Ends the map
// ----------------------------------------------------------------------------------
endMap()
{
	game["state"] = "intermission";
	level notify("intermission");
	level notify("kill_startround");
	
	if(game["alliedscore"] == game["axisscore"])
	{
		endRound("draw");
		text = &"MPSCRIPT_THE_GAME_IS_A_TIE";
	}
	else if(game["alliedscore"] > game["axisscore"])
	{
		endRound("allies");
		text = &"MPSCRIPT_ALLIES_WIN";
	}
	else
	{
		endRound("axis");
		text = &"MPSCRIPT_AXIS_WIN";
	}

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");
		player setClientCvar("cg_objectiveText", text);
		player SpawnIntermission();
	}

	wait 10;
	exitLevel(false);
}

// ----------------------------------------------------------------------------------
//	checkTimeLimit
//
// 		Checks to see if the time limit has been hit and ends the map.
// ----------------------------------------------------------------------------------
checkTimeLimit()
{
	if(level.timelimit <= 0)
		return;

	// never abruptly end a round in progress
	if (level.roundstarted)
		return;

	if(game["timepassed"] < level.timelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_TIME_LIMIT_REACHED");
	level thread endMap();
	// dont return immediatly need time for the calling loop to be killed
	wait(1);
}

// ----------------------------------------------------------------------------------
//	checkScoreLimit
//
// 		Checks to see if the score limit has been hit and ends the map.
// ----------------------------------------------------------------------------------
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
	level thread endMap();
	// dont return immediatly need time for the calling loop to be killed
	wait(1);
}

// ----------------------------------------------------------------------------------
//	checkRoundLimit
//
// 		Checks to see if the round limit has been hit and ends the map.
// ----------------------------------------------------------------------------------
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
	thread endMap();
	// dont return immediatly need time for the calling loop to be killed
	wait(1);
}

// ----------------------------------------------------------------------------------
//	updateGametypeCvars
//
// 		Checks for changes in various cvars
// ----------------------------------------------------------------------------------
updateGametypeCvars()
{
	for(;;)
	{
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

		timelimit = getCvarFloat("scr_bas_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_bas_timelimit", "1440");
			}

			level.timelimit = timelimit;
			setCvar("ui_bas_timelimit", level.timelimit);
		}

		scorelimit = getCvarInt("scr_bas_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_bas_scorelimit", level.scorelimit);

			if(game["matchstarted"])
				checkScoreLimit();
		}

		roundlimit = getCvarInt("scr_bas_roundlimit");
		if(level.roundlimit != roundlimit)
		{
			level.roundlimit = roundlimit;
			setCvar("ui_bas_roundlimit", level.roundlimit);

			if(game["matchstarted"])
				checkRoundLimit();
		}

		level.roundlength = getCvarFloat("scr_bas_roundlength");
		if(level.roundlength > 60)
			setCvar("scr_bas_roundlength", "60");

		allowvote = getCvarint("g_allowvote");
		if(level.allowvote != allowvote)
		{
			level.allowvote = allowvote;
			setCvar("scr_allow_vote", allowvote);
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
				level thread maps\mp\gametypes\_teams::TeamBalance_Check_Roundbased();
		}

		if (level.teambalance > 0)
		{
			level.teambalancetimer++;
			if (level.teambalancetimer >= 60)
			{
				level thread maps\mp\gametypes\_teams::TeamBalance_Check();
				level.teambalancetimer = 0;
			}
		}
		wait 1;
	}
}

// ----------------------------------------------------------------------------------
//	updateTeamStatus
//
// 		Sets up the variables which keep track of the teams.
// ----------------------------------------------------------------------------------
updateTeamStatus()
{
	wait 0;	// Required for Callback_PlayerDisconnect to complete before updateTeamStatus can execute
	
	resettimeout();

	oldvalue["allies"] = level.exist["allies"];
	oldvalue["axis"] = level.exist["axis"];
	level.exist["allies"] = 0;
	level.exist["axis"] = 0;
	level.exist["teams"] = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && isDefined(player.pers["weapon"]))
		{
			level.exist[player.pers["team"]]++;
		}
	}

	if (getCvarInt("scr_debug_bas")=="1") return;
	
	// if one team is empty then abort the round
	if((oldvalue["allies"] && !level.exist["allies"]) || (oldvalue["axis"] && !level.exist["axis"]))
	{
		level notify("kill_startround");
		level notify("cleanup match starting");
		game["matchstarting"] = false;

		// level may be starting
		if(level.roundended || !level.roundstarted)
		{
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				player Player_ClearHud();
			}
			
			return;
		}
			
		announcement(&"GMI_DOM_ROUND_DRAW");
		level thread endRound("abort");
		return;
	}
}

// ----------------------------------------------------------------------------------
//	SetupFlagIcon
//
// 		Sets up a flag icon
// ----------------------------------------------------------------------------------
SetupBaseIcon(base)
{
	game["showicons"] = false;

	if (!getCvarint("scr_showicons"))
		return;

	game["showicons"] = true;
	
	// Flag icons at top of screen
	if(!isDefined(base.icon))
	{
		base.icon = newHudElem();
		base.blink_icon = newHudElem();
		base.health_bar = newHudElem();
	}


	base.icon.alignX = "left";
	base.icon.alignY = "top";


	if (base.id < 3)
		base.icon.x =(game["flag_icons_x"] - game["flag_icons_w"]/2) + (base.id * (game["flag_icons_w"]+4)) - game["flag_icons_w"];
	else
		base.icon.x =(game["flag_icons_x"] + game["flag_icons_w"]/2) + (base.id * (game["flag_icons_w"]+4)) - game["flag_icons_w"];

	base.icon.y = game["flag_icons_y"];
	base.icon.sort = 0.0; // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!

	base.blink_icon.alignX = "left";
	base.blink_icon.alignY = "top";
	base.blink_icon.x =base.icon.x;
	base.blink_icon.y = 480;
	base.blink_icon.sort = 0.0; // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!


	base.health_bar.x = base.icon.x;
	base.health_bar.y = base.icon.y + 32;
	base.health_bar.alignX = "left";
	base.health_bar.alignY = "top";
	base.health_bar.sort = 0.0;
	base.health_bar setShader("gfx/hud/hud@health_bar.dds", 32, 4);			

}

// ----------------------------------------------------------------------------------
//	InitProgressbar
//
// 		Sets up the flag capture progress bar on the passed in player
// ----------------------------------------------------------------------------------
InitProgressbar(player, text)
{
	if(isdefined(player.progressbackground))
	{					
		player.progressbackground destroy();
	}
	if(isdefined(player.progressbar))
	{					
		player.progressbar destroy();
	}
	if(isdefined(player.progresstext))
	{					
		player.progresstext destroy();
	}
	
	player.progresstext = maps\mp\_util_mp_gmi::get_progressbar_text(player,text);
		
	// background
	player.progressbackground=  maps\mp\_util_mp_gmi::get_progressbar_background(player);

	// foreground
	player.progressbar = maps\mp\_util_mp_gmi::get_progressbar(player);
	player.view_bar = 1;	
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
			player.pers["score"] += points;
			player.score = player.pers["score"];
		}
	}
}

// ----------------------------------------------------------------------------------
//	GivePointsToCappers
//
// 		Gives points to everyone in the flag zone at the end of the cap1
// ----------------------------------------------------------------------------------
GivePointsToCappers( team, main_name )
{
	players = getentarray("player", "classname");
	
	// give points to everyone in the cap area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isAlive(player) && player.pers["team"] == team && player istouching(self))
		{
			// if this is the first player they get the cap points
			if(player.name == main_name.name)
			{
				player.pers["score"] += game["br_points_cap"];
			}
			// everyone else gets assist points
			else					
			{
				player.pers["score"] += game["br_points_assist"];
			}
			
			player.score = player.pers["score"];
		}
	}
	
}

// ----------------------------------------------------------------------------------
//	GameRoundThink
//
// 	This checks for possible end round conditions.  Also displays round messages.
// ----------------------------------------------------------------------------------
GameRoundThink()
{
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
			
		// check to see if we hit the score limit
		scorelimit = getCvarint("scr_bas_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;

			if(game["matchstarted"])
				checkScoreLimit();
		}

		// end the round if there are not enough people playing
		if (game["matchstarted"] == true && level.roundstarted == true)
		{
			debug = getCvarint("scr_debug_bas");
			
			players_on_allies = 0;
			players_on_axis = 0;
			
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				switch(player.pers["team"])
				{
					case "allies":
					{
						players_on_allies++;
						break;
					}
					case "axis":
					{
						players_on_axis++;
						break;
					}
				}
				
				// if we are in debug mode and we have found one person on a team then we are good
				if ( debug && (players_on_allies || players_on_axis) )
				{
					players_on_allies = 1;
					players_on_axis = 1;
					break;
				}			
		
				// if there is at least one player on each team then we are good.
				if (players_on_allies && players_on_axis )
				{
					break;
				}
			}
			
			// if one of these is zero then we only have one team
			if ( !players_on_allies || !players_on_axis )
			{
				updateTeamStatus();
			}
			
		}
			
		
		wait 0.5;
	}
}

// ----------------------------------------------------------------------------------
//	printJoinedTeam
//
// 	Displays a joined team message.
// ----------------------------------------------------------------------------------
printJoinedTeam(team)
{
	if(team == "allies")
		iprintln(&"MPSCRIPT_JOINED_ALLIES", self);
	else if(team == "axis")
		iprintln(&"MPSCRIPT_JOINED_AXIS", self);
}


// ----------------------------------------------------------------------------------
//	clock_start
//
// 	 	starts the hud clock for the player if the reason is good enough
// ----------------------------------------------------------------------------------
stopwatch_start(reason, time)
{
	make_clock = false;

	// if we are not waiting for a match start or another match start comes in go ahead and make a new one
	if ( !isDefined( self.stopwatch_reason ) || reason == "match_start" )
	{
		make_clock = true;
	}
	
	if ( make_clock )
	{
		if(isDefined(self.stopwatch))
		{
			stopwatch_delete("do_it");
		}
		
		self.stopwatch = newClientHudElem(self);
		maps\mp\_util_mp_gmi::InitClock(self.stopwatch, time);
		self.stopwatch.archived = false;
		
		self.stopwatch_reason = reason;
		
		self thread stopwatch_cleanup(reason, time);
		
		// if this is a match start
		if ( reason == "match_start" )
		{
			self thread stopwatch_waittill_killrestart(reason);
		}
	}
}

// ----------------------------------------------------------------------------------
//	stopwatch_delete
//
// 	 	destroys the hud stopwatch for the player if the reason is good enough
// ----------------------------------------------------------------------------------
stopwatch_delete(reason)
{
	self endon("stop stopwatch cleanup");

	if(!isDefined(self.stopwatch))
		return;
	
	delete_it = false;
	
	if (reason == "spectator" || reason == "do_it" || reason == self.stopwatch_reason)
	{
		self.stopwatch_reason = undefined;
		self.stopwatch destroy();
		self notify("stop stopwatch cleanup");
	}
}

// ----------------------------------------------------------------------------------
//	stopwatch_cleanup_respawn
//
// 	 	should only be called by stopwatch_start
// ----------------------------------------------------------------------------------
stopwatch_cleanup(reason, time)
{
	self endon("stop stopwatch cleanup");
	wait (time);

	stopwatch_delete(reason);
}

// ----------------------------------------------------------------------------------
//	stopwatch_cleanup_respawn
//
// 	 	should only be called by stopwatch_start
// ----------------------------------------------------------------------------------
stopwatch_waittill_killrestart(reason)
{
	self endon("stop stopwatch cleanup");
	level waittill("kill_startround");

	stopwatch_delete(reason);
}



BaseAssault_get_objective()
{
	objective = undefined;
	if (isdefined(self.attachedThings))
	{
		for (q=0;q<self.attachedThings.size;q++)	
		{
			thing = self.attachedThings[q];

			//	old way soon to be removed

			if ((thing.classname=="trigger_use") || (thing.classname=="trigger_lookat"))
			{
				objective = thing;

				if (isdefined(thing.target))
				{
					self.objectivemodel = getent(thing.target,"targetname");
				}
				else
				{
					self.objectivemodel = spawn("script_model", thing.origin);
					self.objectivemodel.angles = thing.angles;
					self.objectivemodel setmodel("xmodel/mp_bomb1");
				}
			}
		}
	}
	return(objective);
}

Baseassault_Check_Bombzone(trigger)
{
	self notify("kill_check_bombzone");
	self endon("death");
	self endon("kill_check_bombzone");

	while(isdefined(trigger) && !isdefined(trigger.planting) && self istouching(trigger) && isalive(self))
		wait 0.05;

	if(isdefined(self.planticon))
		self.planticon destroy();
}

BaseAssault_check_bomb(trigger)
{
	self notify("kill_check_bomb");
	self endon("kill_check_bomb");
	self endon("death");
	
	while(isdefined(trigger) && !isdefined(trigger.defusing) &&  isalive(self))
		wait 0.05;

	if(isdefined(self.defuseicon))		self.defuseicon destroy();
}

BaseAssault_bomb_think()
{
	self endon ("bomb_exploded");
	
	barsize = maps\mp\_util_mp_gmi::get_progressbar_maxwidth();
	
	level.barincrement = (barsize / (20.0 * level.defusetime));

	for(;;)
	{
		self.objective waittill("trigger", other);
		self.objective.other = undefined;
	
		if(game["matchstarted"] == false || level.roundstarted == false || level.roundended == true)
		{
			count -= 1;
			if(count == 0)
			{
				who iprintln(&"GMI_DOM_WAIT_TILL_MATCHSTART");
				count = 100;
			}
			wait 0.05;
			continue;
		}

		self.objective.other = other;
	
		//	we must be the planter 
		if (other.pers["team"] != self.script_team)
		{
			//	defend this area
			if (self.script_team == "axis")
				other tellhim(&"GMI_BAS_ALLIES_DEFEND_DEFUSE");
			else
				other tellhim(&"GMI_BAS_AXIS_DEFEND_DEFUSE");
			continue;
		}

		if (distance(self.objectivemodel.origin,other.origin)>150) continue;

		if (other.pers["team"] == self.script_team)
		{
			//	plant the bomb
			other tellhim(&"GMI_BAS_USE_TO_DEFUSE");
		}

		// check for having been triggered by a valid player
		if(isPlayer(other) && other isOnGround() && other useButtonPressed())	//	we don't check the teams yet 
		{
			if(!isdefined(other.defuseicon))
			{
				other.defuseicon = newClientHudElem(other);				
				other.defuseicon.alignX = "center";
				other.defuseicon.alignY = "middle";
				other.defuseicon.x = 320;
				other.defuseicon.y = 345;
				other.defuseicon setShader("ui_mp/assets/hud@defusebomb.tga", 64, 64);			
			}

			other linkTo(self);
			other disableWeapon();
			while(isAlive(other) && other useButtonPressed())
			{
				other notify("kill_check_bomb");
				other.defusing = true;

				InitProgressbar( other, &"GMI_BAS_DIFFUSING_BOMB" );
				other.progressbar setShader("white", 0, maps\mp\_util_mp_gmi::get_progressbar_height());			
				other.progressbar scaleOverTime(level.defusetime, barsize, maps\mp\_util_mp_gmi::get_progressbar_height());

				other playsound("MP_bomb1_defuse");
				self.status = "bomb_defusing";
				self.progresstime = 0;
				while(isalive(other) && other useButtonPressed() && (self.progresstime < level.defusetime) && (distance(self.objectivemodel.origin,other.origin)<155) )
				{
					self.progresstime += 0.05;
					wait 0.05;
				}
	
				if(isdefined(other.defuseicon))
					other.defuseicon destroy();
				other Player_ClearHud();

				if(self.progresstime >= level.defusetime)
				{
					self.status = "destroyed";
					if (isalive(other)) other.defusing = false;

					self notify ("bomb_defused");
					self.objectivemodel setmodel("xmodel/mp_bomb1");
					self.objectivemodel stopLoopSound();

					self thread BaseAssault_ObjectiveZone_think();

					level thread hud_announce(&"SD_EXPLOSIVESDEFUSED");

					if (isdefined(self.stopwatch))
						self.stopwatch destroy();

					if (isdefined(other))
					{
						other.pers["score"] += getCvarInt("scr_bas_defuse_score");
						other.score = other.pers["score"];
						lpselfnum = other getEntityNumber();
						lpselfguid = other getGuid();
						logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + other.pers["team"] + ";" + other.name + ";" + "bas_defused" + "\n");
					}

					players = getentarray("player", "classname");
					for(i = 0; i < players.size; i++)
					{
						if ( other.pers["team"] == "allies" )
							players[i] playLocalSound(game["sound_allies_bomb_diffused"]);
						else
							players[i] playLocalSound(game["sound_axis_bomb_diffused"]);
					}

					other unlink();
					other enableWeapon();
				
					return;	//TEMP, script should stop after the wait .05
				}
				else
				{
					self.status = "bomb_planted";	//	NORMAL ?
					other unlink();
					other enableWeapon();
					if (isalive(other)) other.defusing = false;
				}
				
				wait .05;
			}
			self.defusing = undefined;
			other thread BaseAssault_check_bomb(self);
		}
	}
}

BaseAssault_notify_team(sound,option)
{
	if (!isdefined(option))
		option = "any";

	players = getentarray("player", "classname");
	
	for(i = 0; i < players.size; i++)
	{
		shouldplay = 0;
		if (players[i].pers["team"] == option)
		{
			shouldplay = 1;
		}
		else if (option=="any")
		{
			shouldplay = 1;
		}
		if (shouldplay == 1)
		{
			players[i] playLocalSound(sound);
		}
	}
}

hud_announce(text)
{
	level notify("kill_hud_announce");
	level endon("kill_hud_announce");

	if(!isdefined(level.announce))
	{
		level.announce = newHudElem();
		level.announce.alignX = "center";
		level.announce.alignY = "middle";
		level.announce.x = 320;
		level.announce.y = 176;
	}	
	level.announce setText(text);

	wait 4;
	level.announce fadeOverTime(1);

	wait .9;

	if(isdefined(level.announce))
		level.announce destroy();	
}


BaseAssault_Compass()
{

	level.bases = getentarray("gmi_base","targetname");

	timer = 0;
	for(;;)
	{
		timer = timer + 1;
		if (timer >= 2) 
			timer = 0;
		//	draw bases
		level.bases = getentarray("gmi_base","targetname");

		for(q=0;q<level.bases.size;q++)
		{
			base = level.bases[q];
			objective_delete(base.id);


			gfx = "";
			origin = base.origin;

			if (base.script_team == "allies")
				gfx = "allies";
			if (base.script_team == "axis")
				gfx = "axis";

			if (isdefined(base.script_noteworthy))
			{
				if (	(base.script_noteworthy == "ammo") ||
					(base.script_noteworthy == "fuel") ||
					(base.script_noteworthy == "hq"))
				gfx = gfx + "_" + base.script_noteworthy;
		
			}
			else
			{
				switch(base.id)
				{
					case	0:	gfx = gfx + "_hq";	break;
					case	1:	gfx = gfx + "_fuel";	break;
					case	2:	gfx = gfx + "_ammo";	break;

					case	4:	gfx = gfx + "_ammo";	break;
					case	3:	gfx = gfx + "_fuel";	break;
					case	5:	gfx = gfx + "_hq";	break;
				}
			}

			if (base.status != "bomb_exploded")
			{
				if (base.status != "under_attack")
				{
					if (base.health > 0)
						ogfx = game[gfx];
					else
						ogfx = game[gfx] +"_br";
				}				
				else	
					ogfx = game[gfx] + "_bl";
				

				objective_add(base.id, "current",origin, ogfx);
			}

			gfx = gfx +"_large";

			if (base.status == "under_attack")
			{
				gfx = game[gfx +"_blink" ];
			}
			else if (base.health <= 0)
			{

				if (base.status == "bomb_exploded")
					gfx = game[gfx +"_dead" ];
				else
					gfx = game[gfx +"_breached" ];
			}
			else
			{
				gfx = game[gfx];
			}


			if (base.status == "under_attack")
			{
				if (isdefined(base.status_counter))
				{
					base.status_counter = base.status_counter - 1;
					if (base.status_counter==0)
					{
						base.status = "safe";
					}
				}
			}


			if (gfx!="")
				base.icon setShader(gfx, game["flag_icons_w"], game["flag_icons_h"]);

			if ((base.status == "bomb_planted") && (!isdefined(base.stopwatch)))
			{
				base.stopwatch = newHudElem();
//				maps\mp\_util_mp_gmi::InitClock(base.stopwatch, level.objective_countdown);
				base.stopwatch.x = base.icon.x;
				base.stopwatch.y = base.icon.y;
				base.stopwatch.alignX = "left";
				base.stopwatch.alignY = "top";
				base.stopwatch.sort = 0;
				base.stopwatch setClock(level.objective_countdown, 60, "baseassault_clockface", 32, 32); // count down for 5 of 60 seconds, size is 32x32
			}

			gfx = "";
			if (base.status == "bomb_planting")
			{
				if (timer==0)
					gfx = "gfx/hud/baseassault/hud@ba_bomb.dds";
		
			}
			if (base.status == "bomb_planted")
			{
				gfx = "gfx/hud/baseassault/hud@ba_bomb.dds";
				if (base.countdowntime < 10)
					gfx = "gfx/hud/baseassault/bomb_blink.dds";
			}

			if (base.status == "bomb_defusing")
			{
				if (timer==0)
					gfx = "gfx/hud/baseassault/hud@ba_tool.dds";
		
			}

			if (gfx!="")
			{
				base.blink_icon.y = base.icon.y;
				base.blink_icon setShader(gfx, game["flag_icons_w"], game["flag_icons_h"]);
			}
			else
			{
				base.blink_icon.y = 480;
			}
		}
		wait 0.5;
	}
}


BaseAssault_KillBase()
{
	self notify("kill_check_bomb");
	self notify("kill_check_bombzone");
	self.attachedThings = getentarray(self.target, "targetname");

	self.rubble = spawn("script_model",self.origin);
	self.rubble.angles = self.angles;
	if (self.team=="axis")
		self.rubble setmodel(game["bas_axis_rubble"]);
	else
		self.rubble setmodel(game["bas_allies_rubble"]);

	self.alive = 0;

	if (self.script_team == "allies")
	{
		game["axisscore"]++;
		setTeamScore("axis", game["axisscore"]);
		level notify("announcer","allies",game["sound_allies_base_destroyed"]);
	}
	else
	{
		game["alliedscore"]++;
		setTeamScore("allies", game["alliedscore"]);
		level notify("announcer","axis",game["sound_axis_base_destroyed"]);
	}


	self.attachedThings = getentarray(self.target, "targetname");

	if (isdefined(self.attachedThings))
	{
		for (q=0;q<self.attachedThings.size;q++)
		{
			if (isdefined(self.attachedThings[q]))
			{
				thing = self.attachedThings[q];
				if (isdefined(thing.script_noteworthy))
				{
					if (thing.script_noteworthy=="rubble")
						thing.origin = thing.origin + (0,0,-1000);
					continue;
				}
	
				if((thing.classname == "script_model") ||
				   (thing.classname == "script_brushmodel") ||
				   (thing.classname == "script_origin") ||
				   (thing.classname == "mp_gmi_bas_allies_spawn") ||
				   (thing.classname == "mp_gmi_bas_axis_spawn"))
				{
					thing hide();
					if(thing.classname == "script_brushmodel")
						thing notsolid();

					thing delete();
				}
			}
		}
	}

	objective_delete(self.id);
	self triggerOn();

	playfx(self.fx,self.origin + (0,0,100));
	self playSound("explo_rock");	

	if (isdefined(self.objective))
		self.objective delete();
}

distance_sort(point,array)
{
	//	first we calculate how far each one is from point
	for(i=0;i<array.size;i++)
	{
		if (isdefined(array[i].origin))
			array[i].distance = distance(array[i].origin,point);
		else
		{
			return;			
		}
	}
	// Sort them in order
	for(i = 0; i < array.size; i++)
	{
		for(j = i; j < array.size; j++)
		{
			if(array[i].distance > array[j].distance)
			{
				temp = array[i];
				array[i] = array[j];
				array[j] = temp;
			}
		}
	}
}

tellhim(message)
{
	if (!isdefined(self.lastmessage))
		self.lastmessage = &"MPSCRIPT_PRESS_ACTIVATE_TO_SKIP";

	if (gettime() > self.toldme + 8000)
	{
		self.toldme = gettime();
		clientAnnouncement(self,message);
		self.lastmessage = message;
	}
}

BaseAssault_bomb_countdown()	//	stolen from Search & Destroy
{
	self endon ("bomb_defused");
	self.status = "bomb_planted";

	self.objectivemodel playLoopSound("bomb_tick");
	// set the countdown time
	self.countdowntime = level.objective_countdown;
	while(self.countdowntime!=0)
	{
		self.countdowntime = self.countdowntime - 1;
		wait 1;
	}
	// bomb timer is up
	self notify ("bomb_exploded");


	if (isdefined (self.objective.other))
	{
		other = self.objective.other;
		other Player_ClearHud();
	}
	// trigger exploder if it exists
	if(isdefined(level.objectiveexploder))
		maps\mp\_utility::exploder(level.objectiveexploder);

	if (isdefined(self.planter))
	{
		self.planter.pers["score"] += getCvarInt("scr_bas_destroyed_score");	//	change this
		self.planter.score = self.planter.pers["score"];
		lpselfnum = self.planter getEntityNumber();
		lpselfguid = self.planter getGuid();
		logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + self.planter.pers["team"] + ";" + self.planter.name + ";" + "bas_destroyed" + "\n");
	}

	if (self.team=="axis")
		GivePointsToTeam( "allies", getCvarInt("scr_bas_destroyed_score"));
	else
		GivePointsToTeam( "axis", getCvarInt("scr_bas_destroyed_score"));

	// explode bomb
	range = 2500;
	maxdamage = 4000;
	mindamage = 3000;
		
	self.objectivemodel stopLoopSound();
	self.objectivemodel delete();

	playfx(level._effect["bombexplosion"], self.objectivemodel.origin);

	range = 250;
	maxdamage = 1000;
	mindamage = 300;

	//	lets grab a list of players's 
	
	guys = getentarray("player", "classname");

	distance_sort(self.objectivemodel.origin,guys);

	for(i=0;i<guys.size;i++)
	{
		if (guys[i].distance < 500)
		{
			radiusDamage(guys[i].origin, range, maxdamage, mindamage);
		}
	}

	self.status = "bomb_exploded";

	self playSound("explo_rock");	

	if (isdefined(self.stopwatch))
		self.stopwatch destroy();

	wait(0.5);

	self thread BaseAssault_KillBase();
}

BaseAssault_ObjectiveZone_think()
{
	barsize = maps\mp\_util_mp_gmi::get_progressbar_maxwidth();
	level.barincrement = (barsize / (20.0 * level.planttime));

	while(1)
	{
		self.objective waittill("trigger",other);
		self.objective.other = undefined;
	
		if (other.pers["team"] == self.script_team)
		{
			//	defend this area
			if (self.script_team == "axis")
				other tellhim(&"GMI_BAS_AXIS_DEFEND");
			else
				other tellhim(&"GMI_BAS_ALLIES_DEFEND");
			continue;
		}

		if (distance(self.objectivemodel.origin,other.origin)>150) continue;


		if (other.pers["team"] != self.script_team)
		{
			other tellhim(&"GMI_BAS_USE_TO_PLANT");
		}

		self.objective.other = other;

		if (self.health > 0)
		{
			continue;
		}


		if(isPlayer(other) && other isOnGround() && other useButtonPressed())	//	we don't check the teams yet 
		{

			while(isAlive(other) && other useButtonPressed())
			{
				if(!isdefined(other.planticon))
				{
					other.planticon = newClientHudElem(other);				
					other.planticon.alignX = "center";
					other.planticon.alignY = "middle";
					other.planticon.x = 320;
					other.planticon.y = 345;
	//				this line can be objective specific soon 
					other.planticon setShader("ui_mp/assets/hud@plantbomb.tga", 64, 64);			
				}
				other linkTo(self);
				other disableWeapon();

				self.planting = true;
				other.planting = true;

				InitProgressbar( other, &"GMI_BAS_PLANTING_BOMB" );
				other.progressbar setShader("white", 0, maps\mp\_util_mp_gmi::get_progressbar_height());
				other.progressbar scaleOverTime(level.planttime, barsize, maps\mp\_util_mp_gmi::get_progressbar_height());

//				Objective Specific SOUND 
				other playsound("MP_bomb_plant");

				self.progresstime = 0;
				self.status = "bomb_planting";


				while(isalive(other) && other useButtonPressed() && (self.progresstime < level.planttime) && (distance(self.objectivemodel.origin,other.origin)<155))
				{
					self.progresstime += 0.05;
					wait 0.05;
				}
	
		
//				if(isdefined(other.planticon))
//					other.planticon destroy();
				other Player_ClearHud();
	
				if(self.progresstime >= level.planttime)
				{
					//	objective model and sound 

					if (isdefined(other))
					{
						self.planter = other;
						if (isalive(other))
							other.planting = false;

						other.pers["score"] += getCvarInt("scr_bas_plant_score");
						other.score = other.pers["score"];

						lpselfnum = self.planter getEntityNumber();
						lpselfguid = self.planter getGuid();
						logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + self.planter.pers["team"] + ";" + self.planter.name + ";" + "bas_planted" + "\n");

						if (other.pers["team"] == "allies")
							level notify("announcer","any",game["sound_allies_bomb_planted"]);
						else
							level notify("announcer","any",game["sound_axis_bomb_planted"]);
					}

					self.objectivemodel setmodel("xmodel/mp_bomb1_defuse");
					self.objectivemodel playSound("Explo_plant_no_tick");
	
					self thread BaseAssault_bomb_countdown();
					self thread BaseAssault_bomb_think();

					other unlink();
					other enableWeapon();
		
					level thread hud_announce(&"SD_EXPLOSIVESPLANTED");
					return;	//TEMP, script should stop after the wait .05
				}
				else
				{
					self.status = "destroyed";	//	NORMAL ?

					other unlink();
					other enableWeapon();
					other Player_ClearHud();
		
					if (isalive(other))
					{
						other.planting = false;
					}
				}
				self.planting = false;
				wait .05;
			}
			if (isalive(other))
				other thread BaseAssault_check_bombzone(self);
		}
	}
}


triggerOff()
{
	if (self.origin == self.realOrigin)
		self.origin += (0, 0, -10000);
}

triggerOn()
{
	if (!isdefined (self.realOrigin))
		self.origin = self.realOrigin;
}

BaseAssault_base_health()
{
	while(1)
	{
		w = 32.0 / level.basehealth;//getcvarint("scr_bas_basehealth");
		
		w = self.health * w;
	
		if (isdefined(self.health_bar))
		{
			self.health_bar.color =(1.0,1.0,1.0);

			if (w<=16) 
				self.health_bar.color =(1.0,0.5,0.0);
			if (w<=8) 
				self.health_bar.color =(1.0,0.0,0.0);
			if (w<=1) 
			{
				self.health_bar destroy();
				return;
			}
			else
				self.health_bar setShader("gfx/hud/hud@health_bar.dds", w , 4);			

		}
		wait(0.5);
	}
}

BaseAssault_base_think()
{
	self.alive = 1;

	last_attacker = undefined;
	self.planter = undefined;
	self settakedamage(true);
	self.status = "safe";
	count = 1;
	self.countdowntime = level.objective_countdown;
	self.realOrigin = self.origin;

	self.status_counter = 0;


	//	if we have an effect defined use that

	if (isdefined(self.script_fx))
	{
		self.fx = loadfx (self.script_fx);
	}
	else
	{
		self.fx = level._effect["buildingexplosion"];
	}


	if (isdefined(self.target))
	{
		self.attachedThings = getentarray(self.target, "targetname");
	}	

	self.objective = self BaseAssault_get_objective();

	if (isdefined(self.objective))
		self thread BaseAssault_ObjectiveZone_think();


	if (isdefined(self.script_team))
	{
		if (self.script_team=="axis")
			base_hud_tex = game["hud_axis_base"] + ".dds";
		if (self.script_team=="allied")
		{
			self.script_team = "allies";
			base_hud_tex = game["hud_allies_base"] + ".dds";
		}
		if (self.script_team=="allies")
			base_hud_tex = game["hud_allies_base"] + ".dds";
	}
	else
	{
		base_hud_tex = game["hud_axis_base"] + ".dds";
		self.script_team = "NULL";
		//	could be a none team specific base 
	}

	self.team = self.script_team;

	if (self.team == "axis")
		self setmodel(game["bas_axis_complete"]);
	else
		self setmodel(game["bas_allies_complete"]);

	if (isdefined(self.target))
	{
		self.attachedThings = getentarray(self.target, "targetname");
		if (isdefined(self.attachedThings))
		{
			for (q=0;q<self.attachedThings.size;q++)
			{
				if (isdefined(self.attachedThings[q].script_noteworthy))
				{
					if (self.attachedThings[q].script_noteworthy == "rubble")
					{
						self.attachedThings[q].origin = self.attachedThings[q].origin + (0,0,1000);
					}
				}
			}
		}
	}

	self.damaged_model = 0;

	while(self.health>0)
	{
		self waittill ("damage", dmg, who, dir, point, mod, inflictor);

		if (!isplayer(who))	continue;

		if (isdefined(inflictor.vehicletype) && ((inflictor.vehicletype == "flak88_mp") || (inflictor.vehicletype == "Flak88_MP"))) continue;

		if(game["matchstarted"] == false || level.roundstarted == false)
		{
			count -= 1;
			if(count == 0)
			{
				who iprintln(&"GMI_DOM_WAIT_TILL_MATCHSTART");
				count = 100;
			}
			wait 0.05;
			continue;
		}

		if (getCvar("scr_debug_bas")!="1")
		{
			if (who.pers["team"] == self.script_team)
				continue;
		}

		if (       (mod == "MOD_PROJECTILE") || (mod == "MOD_PROJECTILE_SPLASH") 
			|| (mod == "MOD_GRENADE") || (mod == "MOD_GRENADE_SPLASH") 	
			|| (mod == "MOD_ARTILLERY") || (mod == "MOD_ARTILLERY_SPLASH") )
		{
			
			last_attacker = who;
			last_attacker.lastattacktime = gettime();
			
			lpselfnum = last_attacker getEntityNumber();
			lpselfguid = last_attacker getGuid();
			logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + last_attacker.pers["team"] + ";" + last_attacker.name + ";" + "bas_attacked" + "\n");

			if ((self.status == "safe") && (self.status_counter==0))
			{

				self.status = "under_attack";
				self.status_counter = level.announcer_time;
			}	

			if ((self.status == "under_attack") && (self.status_counter==level.announcer_time))
			{
				if (self.script_team == "allies")
					level notify("announcer","allies",game["sound_allies_base_underattack"]);
				else
					level notify("announcer","axis",game["sound_axis_base_underattack"]);
			}	

			self.health -= dmg;	
		}

		if (self.damaged_model == 0)
		{
			if (self.health <= level.basedamagedhealth) //getCvarInt("scr_bas_damagedhealth")
			{
				if (self.team == "axis")
					self setmodel(game["bas_axis_damaged"]);
				else
					self setmodel(game["bas_allies_damaged"]);

				self.damaged_model = 1;
			}
		}
	}

	if (isdefined(last_attacker))
	{
		last_attacker.pers["score"] += getCvarInt("scr_bas_breach_score");	//	change this
		last_attacker.score = last_attacker.pers["score"];

		lpselfnum = last_attacker getEntityNumber();
		lpselfguid = last_attacker getGuid();
		logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + last_attacker.pers["team"] + ";" + last_attacker.name + ";" + "bas_breached" + "\n");
	}

	if (self.team=="axis")
		GivePointsToTeam( "allies", getCvarInt("scr_bas_breach_score"));
	else
		GivePointsToTeam( "axis", getCvarInt("scr_bas_breach_score"));

	playfx(self.fx,self.origin + (0,0,100));
	self playSound("explo_rock");	

	self.status = "destroyed";

	if (self.script_team == "allies")
		level notify("announcer","allies",game["sound_allies_base_breached"]);
	else
		level notify("announcer","axis",game["sound_axis_base_breached"]);

	if (isdefined(self.target))
	{
		self.attachedThings = getentarray(self.target, "targetname");
		for (q=0;q<self.attachedThings.size;q++)
		{
			if (isdefined(self.attachedThings[q]))
			{
				if (!isdefined(self.attachedThings[q].script_idnumber))	continue;

				if (	(self.attachedThings[q].classname == "mp_gmi_bas_allies_spawn") ||
					(self.attachedThings[q].classname == "mp_gmi_bas_axis_spawn"))
				{
					//	we could enable a spawn for the other team if we wanted to here 
					//	or swap the spawn team 
					self.attachedThings[q] delete();
				}
				thing = self.attachedThings[q];
				
				if((thing.classname == "script_model") ||
				   (thing.classname == "script_brushmodel") ||
				   (thing.classname == "script_origin"))
				{
					thing hide();
					if(thing.classname != "script_model")
						thing notsolid();
					thing delete();
				}
			}
		}
	}

	//	here for the destroyed model

	if (self.team == "axis")
		self setmodel(game["bas_axis_destroyed"]);
	else
		self setmodel(game["bas_allies_destroyed"]);
}

BaseAssault_Announcer()
{
	message_time["axis"] = gettime();
	message_time["allies"] = gettime();
	play = 0;
	while(1)
	{
		level waittill("announcer",team,message);
		play = 1;
		if ((message == game["sound_allies_base_underattack"]) ||
		    (message == game["sound_axis_base_underattack"]))
		{
			play = 0;
			if (message_time[team] < gettime())
			{
				play = 1;
				message_time[team] = gettime() + 10000;
			}
		}
		if (play == 1)
		{
			self thread BaseAssault_notify_team(message,team);	
		}
		wait(0.5);
	}
}

BaseAssault_GMI()
{
	level thread BaseAssault_Announcer();

	level endon("round_ended");

	level._effect["bombexplosion"] 		= loadfx("fx/map_mp/mp_bas_bombexp.efx");
	level._effect["buildingexplosion"]    	= loadfx ("fx/map_mp/mp_bas_bunkerexp.efx");

	precacheShader("ui_mp/assets/hud@plantbomb.tga");
	precacheShader("ui_mp/assets/hud@defusebomb.tga");

	precacheModel("xmodel/mp_bomb1_defuse");
	precacheModel("xmodel/mp_bomb1");

	level.bases = getentarray("gmi_base","targetname");

	if ( !isDefined(level.bases) )
	{
		maps\mp\_utility::error("NO BASE'S IN MAP");
		return;
	}

	for (q=0;q<level.bases.size;q++)
	{
		base = level.bases[q];
		base.id = q;
		base.health = level.basehealth;//getCvarInt("scr_bas_basehealth");
		base thread BaseAssault_base_health();

		if (isdefined(base.script_team))
		{
			if (base.script_team == "axis")
			{
				if (isdefined(base.script_noteworthy))	
				{
					if (base.script_noteworthy == "hq") base.id = 3;
					if (base.script_noteworthy == "ammo") base.id = 5;
					if (base.script_noteworthy == "fuel") base.id = 4;
				}
			}
			else
			{
				if (isdefined(base.script_noteworthy))	
				{
					if (base.script_noteworthy == "hq") base.id =2;
					if (base.script_noteworthy == "ammo") base.id = 0;
					if (base.script_noteworthy == "fuel") base.id = 1;
				}
			}
		}

		base.status_counter = 0;

		SetupBaseIcon(base);

		base thread BaseAssault_base_think();
	}

	level thread BaseAssault_Compass();

	while(1)
	{
		if(level.roundended)
			return;

		level.bases = getentarray("gmi_base","targetname");
		axis = 0;
		allies = 0;

		for (q=0;q<level.bases.size;q++)
		{
			if (level.bases[q].script_team=="axis")
				axis = axis + level.bases[q].alive;
			if (level.bases[q].script_team=="allies")
				allies = allies + level.bases[q].alive;
		}
		wait(1);

		if ((axis == 0) && (allies==0))
		{
			level thread endRound("draw");
			return;
		}
		if (axis == 0)
		{
			announcement(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
			level thread endRound("allies");
			return;
		}
		if (allies == 0)
		{
			announcement(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
			level thread endRound("axis");
			return;
		}
	}
}

drawHealth()
{
	while(1)
	{
		ents = getentarray("gmi_base","targetname");
		if (isdefined(ents))
		{
			for (q=0;q<ents.size;q++)
			{
				if (isdefined(ents[q].health))
				{
					if (isdefined(ents[q].origin))
					{
						print3d(ents[q].origin + (0,0,250),ents[q].health,(1,1,1),4);
					}
				}
			}
		}
		wait(0.05);
	}
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

// ----------------------------------------------------------------------------------
//	close_to_an_enemy_base
//
// 		returns true if the opposite teams base is within a given radius
// ----------------------------------------------------------------------------------
close_to_an_enemy_base(player, radius)
{
	radius_squared = radius * radius;
	
	for (q=0;q<level.bases.size;q++)
	{
		// only alive bases of the opposite team count
		if (level.bases[q].script_team != player.pers["team"] && level.bases[q].status != "bomb_exploded")
		{
			if (distancesquared( level.bases[q].origin, player.origin ) < radius_squared )
			{
				return true;
			}
		}
	}
	
	return false;
}