/*
	Domination
	Objective: 	Each team needs to try and capture all of the flags.  Multiple people capturing a flag will make the capture
			happen quicker.
	Round ends:	When one team captures all of the flags, or roundlength time is reached
	Map ends:	When one team reaches the score limit, or time limit or round limit is reached
	Respawning:	Players will respawn in waves after a given time.  As flags are captured by a team they can open up new
			spawn points.  As flags are lost a team can lose spawn points.

	Level requirements
	------------------
		Allied Spawnpoints:
			classname		mp_uo_spawn_allies
			Allied players spawn from these. Place near the main allied base/side.

			classname		mp_uo_spawn_allies_secondary
			Allied players spawn from these as the related flags are captured. Place near the associated flags.
			The flag trigger that these are associated with should target the spawn.

		Axis Spawnpoints:
			classname		mp_uo_spawn_axis
			Axis players spawn from these. Place near the main allied base/side.

			classname		mp_uo_spawn_axis_secondary
			Axis players spawn from these as the related flags are captured. Place near the associated flags.
			The flag trigger that these are associated with should target the spawn.

		Spectator Spawnpoints:
			classname		mp_uo_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

		Capture Area(s):
			classname		trigger_multiple
			targetname		flag# (where # is the number of the flag)
			target			Optionally can target spawn points.  When this flag is held then the spawn points will
						be available.
			script_gameobjectname	dom
			There should be one of these for each of the flags.

		Neutral Flag Model(s):
			classname		script_model
			script_gameobjectname	dom
			model			Model file for the neutral flag.
			targetname		flag#_neutral.  The number should be the same as the trigger_multiple it is associtated with

		Allies Flag Model(s):
			classname		script_model
			script_gameobjectname	dom
			model			Model file for the neutral flag.
			targetname		flag#_allies.  The number should be the same as the trigger_multiple it is associtated with

		Axis Flag Model(s):
			classname		script_model
			script_gameobjectname	dom
			model			Model file for the neutral flag.
			targetname		flag#_axis.  The number should be the same as the trigger_multiple it is associtated with

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
			game["dom_layoutimage"] = "yourlevelname";  (or use game["layoutimage"] if no special map for this gametype is needed)
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.

		Objective Text:
			game["dom_allies_obj_text"] = "Defeate the axis.";
			game["dom_axis_obj_text"] = "Defeate the allies.";
			game["dom_spectator_obj_text"] = "Help a team defeat the other";
			These set custom objective text. Otherwise default text is used.

	Note
	----
		Setting "script_gameobjectname" to "dom" on any entity in a level will cause that entity to be removed in any gametype that
		does not explicitly allow it. This is done to remove unused entities when playing a map in other gametypes that have no use for them.
*/

/*QUAKED mp_uo_spawn_allies (0.0 1.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/airborne"
Allied players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_uo_spawn_allies_secondary (0.0 1.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/airborne"
Allied players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_uo_spawn_axis (1.0 0.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/wehrmacht_soldier"
Axis players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_uo_spawn_axis_secondary (1.0 0.0 0.0) (-16 -16 0) (16 16 72)
defaultmdl="xmodel/wehrmacht_soldier"
Axis players spawn randomly at one of these positions at the beginning of a round.
*/

/*QUAKED mp_dom_intermission (1.0 0.0 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/



main() // Starts when map is loaded.
{
	// init the spawn points first because if they do not exist then abort the game
	// Set up the spawnpoints of the "allies"
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_allies", 1) )
		return;
	// Set up the spawnpoints of the "axis"
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_axis", 1) )
		return;

	// Make sure the intermission spawn is there
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_dom_intermission", 1, 1) )
		return;

	// set up secondary spawn points but don't abort if they are not there
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_allies_secondary");
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_axis_secondary");

	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();
	
	// set some values for the icon positions
	game["flag_icons_w"] = 32;
	game["flag_icons_h"] = 32;
	game["flag_icons_x"] = 320 - ( game["flag_icons_w"] * 2.5 );  // defaults to five flags changed later for actual flag count
	game["flag_icons_y"] = 480 - game["flag_icons_h"];
	
	level.callbackStartGameType = ::Callback_StartGameType; // Set the level to refer to this script when called upon.
	level.callbackPlayerConnect = ::Callback_PlayerConnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDamage = ::Callback_PlayerDamage; // Set the level to refer to this script when called upon.
	level.callbackPlayerKilled = ::Callback_PlayerKilled; // Set the level to refer to this script when called upon.

	maps\mp\gametypes\_callbacksetup::SetupCallbacks(); // Run this script upon load.

	allowed[0] = "flag_cap"; 
	allowed[1] = "dom"; 	
	maps\mp\gametypes\_gameobjects::main(allowed); // Take the "allowed" array and apply it to this script. which just deletes all of the objects that do not have script_objectname set to any of the allowed arrays. Ex. allowed[0].

	if(getCvar("scr_dom_timelimit") == "")		// Time limit per map
		setCvar("scr_dom_timelimit", "0");
	else if(getCvarFloat("scr_dom_timelimit") > 1440)
		setCvar("scr_dom_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_dom_timelimit");
	setCvar("ui_dom_timelimit", level.timelimit);
	makeCvarServerInfo("ui_dom_timelimit", "0");

	if(getCvar("scr_dom_roundlength") == "")		// Time length of each round
		setCvar("scr_dom_roundlength", "30");
	else if(getCvarFloat("scr_dom_roundlength") > 60)
		setCvar("scr_dom_roundlength", "60");
	level.roundlength = getCvarFloat("scr_dom_roundlength");
	setCvar("ui_dom_roundlength", getCvar("scr_dom_roundlength"));
	makeCvarServerInfo("ui_dom_roundlength", "0");

	if(getCvar("scr_dom_scorelimit") == "")		// Score limit per map
		setCvar("scr_dom_scorelimit", "3");
	level.scorelimit = getCvarint("scr_dom_scorelimit");
	setCvar("ui_dom_scorelimit", getCvar("scr_dom_scorelimit"));
	makeCvarServerInfo("ui_dom_scorelimit", "0");
		
	if(getCvar("scr_friendlyfire") == "")		// Friendly fire
		setCvar("scr_friendlyfire", "1");	//default is ON

	if(getCvar("scr_dom_startrounddelay") == "")	// Time to wait at the begining of the round
		setCvar("scr_dom_startrounddelay", "15");
	if(getCvar("scr_dom_endrounddelay") == "")		// Time to wait at the end of the round
		setCvar("scr_dom_endrounddelay", "10");

	if(getCvar("scr_drawfriend") == "")		// Draws a team icon over teammates, default is on.
		setCvar("scr_drawfriend", "1");
	level.drawfriend = getCvarint("scr_drawfriend");

	if(getCvar("scr_battlerank") == "")		// Draws the battle rank.  Overrides drawfriend.
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");

	if(getCvar("scr_dom_clearscoreeachround") == "")	// clears everyones score between each round if true
		setCvar("scr_dom_clearscoreeachround", "1");
	setCvar("ui_dom_clearscoreeachround", getCvar("scr_dom_clearscoreeachround"));
	makeCvarServerInfo("ui_dom_clearscoreeachround", "0");

	if(getCvar("scr_shellshock") == "")		// controls whether or not players get shellshocked from grenades or rockets
		setCvar("scr_shellshock", "1");
	setCvar("ui_shellshock", getCvar("scr_shellshock"));
	makeCvarServerInfo("ui_shellshock", "0");
			
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

	if(getCvar("scr_drophealth") == "")		// Free look spectator
		setCvar("scr_drophealth", "1");

	if(getCvar("scr_showicons") == "")		// flag icons on or off
		setCvar("scr_showicons", "1");

	if(getCvar("scr_dom_domination_points") == "")		// ammount of points the team gets for capping all flags
		setCvar("scr_dom_domination_points", "2");
		
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
	
	// This controls the delay for respawning reinforcement waves.
	if(getCvar("scr_dom_respawn_wave_time") == "")	
		setCvar("scr_dom_respawn_wave_time", "10");
	else if(getCvarFloat("scr_dom_respawn_wave_time") < 1)
		setCvar("scr_dom_respawn_wave_time", "1");
	level.respawn_wave_time = getCvarint("scr_dom_respawn_wave_time");
	level.respawn_timer["axis"] = level.respawn_wave_time;
	level.respawn_timer["allies"] = level.respawn_wave_time;
	
	if(getCvar("scr_dom_roundlimit") == "")		// Round limit per map
		setCvar("scr_dom_roundlimit", "0");
	level.roundlimit = getCvarInt("scr_dom_roundlimit");
	setCvar("ui_dom_roundlimit", level.roundlimit);
	makeCvarServerInfo("ui_dom_roundlimit", "0");

	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	if(!isDefined(game["dom_allies_obj_text"]))		
		game["dom_allies_obj_text"] = (&"GMI_DOM_OBJ_ALLIES");
	if(!isDefined(game["dom_axis_obj_text"]))		
		game["dom_axis_obj_text"] = (&"GMI_DOM_OBJ_AXIS");
	if(!isDefined(game["dom_spectator_obj_text"]))		
		game["dom_spectator_obj_text"] = (&"GMI_DOM_OBJ_SPECTATOR");
	
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
	level.flagcount = 1; // Used to count how many flags are in the level.
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
	if(getCvar("scr_debug_dom") == "")
		setCvar("scr_debug_dom", "0"); 
	if(getCvar("scr_debug_dom") != "0")
	{		
		setCvar("scr_dom_startrounddelay", "5");
		setCvar("scr_dom_respawn_wave_time", "10");
	}
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

		if(!isDefined(game["dom_layoutimage"])) // If not defined, set the game["layoutimage"] to default. usually this is set in the mapname.gsc
			game["dom_layoutimage"] = "default";

		layoutname = "levelshots/layouts/hud@layout_" + game["dom_layoutimage"]; // Set layoutname to be hud@layout_"whatever game["layoutimage"]" is.

		precacheShader(layoutname); // Precache the layoutimage.
		setCvar("scr_layoutimage", layoutname); // Setup the scr_layoutimage cvar to be layoutname.
		makeCvarServerInfo("scr_layoutimage", ""); // Set the cvar with the scr_layoutimage.

		// server cvar overrides
		if(getCvar("scr_allies") != "")
			game["allies"] = getCvar("scr_allies");	
		if(getCvar("scr_axis") != "")
			game["axis"] = getCvar("scr_axis");

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
		precacheString(&"GMI_DOM_OBJ_SPECTATOR_ALLIES");
		precacheString(&"GMI_DOM_OBJ_SPECTATOR_AXIS");
		precacheString(&"GMI_DOM_ALLIES_CAP_FLAG_SOLO");
		precacheString(&"GMI_DOM_ALLIES_CAP_FLAG_TEAM");
		precacheString(&"GMI_DOM_AXIS_CAP_FLAG_SOLO");
		precacheString(&"GMI_DOM_AXIS_CAP_FLAG_TEAM");
		precacheString(&"GMI_DOM_OBJ_ALLIES");
		precacheString(&"GMI_DOM_OBJ_AXIS");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_AN_NEXT");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_A_NEXT");
		precacheString(&"GMI_DOM_WAIT_TILL_MATCHSTART");
		precacheString(&"GMI_DOM_CAPTURING_FLAG");
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
		precacheString(&"GMI_DOM_UNNAMED_FLAG0");
		precacheString(&"GMI_DOM_UNNAMED_FLAG1");
		precacheString(&"GMI_DOM_UNNAMED_FLAG2");
		precacheString(&"GMI_DOM_UNNAMED_FLAG3");
		precacheString(&"GMI_DOM_UNNAMED_FLAG4");
		precacheString(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
		precacheString(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
		
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
		precacheShader("hudScoreboard_mp");
		precacheShader("gfx/hud/hud@mpflag_spectator.tga");
		precacheStatusIcon("gfx/hud/hud@status_dead.tga");
		precacheStatusIcon("gfx/hud/hud@status_connecting.tga");

		game["hud_ring"] = "gfx/hud/hudadd@dom_ring.dds";
		game["hud_axis_flag"] = "gfx/hud/hud@dom_g.dds";
		game["hud_neutral_flag"] = "gfx/hud/hud@dom_n.dds";
		
		// set up team specific variables
		switch( game["allies"])
		{
		case "british":
			game["hud_allies_radar"] = "gfx/hud/hud@objective_british";
			game["hud_allies_flag"] = "gfx/hud/hud@dom_b.dds";
			
			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "uk_victory";
			game["sound_allies_area_secure"] = "uk_area_secured";
			game["sound_allies_ground_taken"] = "uk_ground_taken";
			game["sound_allies_enemy_has_taken_flag"] = "uk_lost_ground";
			game["sound_allies_enemy_is_taking_flag"] = "uk_losing_ground";
			break;
		case "russian":
			game["hud_allies_radar"] = "gfx/hud/hud@objective_russian";
			game["hud_allies_flag"] = "gfx/hud/hud@dom_r.dds";

			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "ru_victory";
			game["sound_allies_area_secure"] = "ru_area_secured";
			game["sound_allies_ground_taken"] = "ru_ground_taken";
			game["sound_allies_enemy_has_taken_flag"] = "ru_lost_ground";
			game["sound_allies_enemy_is_taking_flag"] = "ru_losing_ground";
			break;
		default:		// default is american
			game["hud_allies_radar"] = "gfx/hud/hud@objective_american";
			game["hud_allies_flag"] = "gfx/hud/hud@dom_us.dds";

			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "us_victory";
			game["sound_allies_area_secure"] = "us_area_secured";
			game["sound_allies_ground_taken"] = "us_ground_taken";
			game["sound_allies_enemy_has_taken_flag"] = "us_lost_ground";
			game["sound_allies_enemy_is_taking_flag"] = "us_losing_ground";
			break;
		}

		game["sound_axis_victory_vo"] = "MP_announcer_axis_win";
		game["sound_axis_victory_music"] = "ge_victory";
		game["sound_axis_area_secure"] = "ge_area_secured";
		game["sound_axis_ground_taken"] = "ge_ground_taken";
		game["sound_axis_enemy_has_taken_flag"] = "ge_lost_ground";
		game["sound_axis_enemy_is_taking_flag"] = "ge_losing_ground";
	
		game["sound_round_draw_vo"] = "MP_announcer_round_draw";

		game["hud_neutral_radar"] = "gfx/hud/hud@objective_gray";
		game["hud_capping_radar"] = "gfx/hud/objective_yellow";
		game["hud_axis_radar"] = "gfx/hud/hud@objective_german";
		
		// victory images
		if ( !isDefined( game["hud_allies_victory_image"] ) )
			game["hud_allies_victory_image"] = "gfx/hud/allies_win";
		if ( !isDefined( game["hud_axis_victory_image"] ) )
			game["hud_axis_victory_image"] = "gfx/hud/axis_win";
		
		precacheShader(game["hud_axis_flag"]);
		precacheShader(game["hud_allies_flag"]);

		precacheShader(game["hud_neutral_radar"]);
		precacheShader(game["hud_neutral_radar"]+ "_up");
		precacheShader(game["hud_neutral_radar"]+ "_down");
		precacheShader(game["hud_capping_radar"]);
		precacheShader(game["hud_capping_radar"]+ "_up");
		precacheShader(game["hud_capping_radar"]+ "_down");
		precacheShader(game["hud_allies_radar"]);
		precacheShader(game["hud_allies_radar"]+ "_up");
		precacheShader(game["hud_allies_radar"]+ "_down");
		precacheShader(game["hud_axis_radar"]);
		precacheShader(game["hud_axis_radar"]+ "_up");
		precacheShader(game["hud_axis_radar"]+ "_down");

		// GMI FLAG MATCH IMAGES:
		precacheShader(game["hud_ring"]);
		precacheShader(game["hud_axis_flag"]);
		precacheShader(game["hud_allies_flag"]);
		precacheShader(game["hud_neutral_flag"]);
		precacheShader("hudStopwatch");
		precacheShader("hudStopwatchNeedle");
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
		precacheItem("item_health");
			
	
		maps\mp\gametypes\_teams::precache(); // Precache weapons.
		maps\mp\gametypes\_teams::scoreboard(); // Precache scoreboard menu.
		
		// if fs_copyfiles is set then we are building paks and cache everything
		if ( getcvar("fs_copyfiles") == "1")
		{
			precacheShader("gfx/hud/hud@dom_b.dds");
			precacheShader("gfx/hud/hud@dom_r.dds");
			precacheShader("gfx/hud/hud@dom_us.dds");
			precacheShader("gfx/hud/hud@dom_g.dds");

			precacheShader("gfx/hud/hud@objective_british");
			precacheShader("gfx/hud/hud@objective_british_up");
			precacheShader("gfx/hud/hud@objective_british_down");
			precacheShader("gfx/hud/hud@objective_russian");
			precacheShader("gfx/hud/hud@objective_russian_up");
			precacheShader("gfx/hud/hud@objective_russian_down");
			precacheShader("gfx/hud/hud@objective_american");
			precacheShader("gfx/hud/hud@objective_american_up");
			precacheShader("gfx/hud/hud@objective_american_down");
		}

	}
	
	maps\mp\gametypes\_teams::modeltype(); // Precache player models.
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_teams::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons(); // Restrict certain weapons, if they exist. Cvar dependant.
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_teams::updateWeaponCvars();

	game["gamestarted"] = true; // Set the global flag of "gamestarted" to be true.
	
	setClientNameMode("auto_change"); 

	Flag_InitTriggers();
	Flag_StartThinking(); // Start the Flag_StartThinking thread. This sets up the flags for primetime.

	thread Flag_AllCapturedThink();
	thread drawFlagsOnCompass();
	thread maps\mp\gametypes\_secondary_gmi::SetupSecondaryObjectives();

	thread GameRoundThink();
	thread startGame();
	thread updateGametypeCvars();
	
//	thread checkEvenTeams();
	
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
					
					self thread stopwatch_delete("spectator");
	
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

//			if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon && !isDefined(self.pers["weapon1"]))
//				continue;

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
		lpselfguid = self getGuid();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackguid = eAttacker getGuid();
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
		capping = Capture_CheckCappingFlag(self);
		
		if(attacker == self) // killed himself
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
				// if the dead person was capping then give the killer a defense bonus
				else if ( capping )
				{
					attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetDefensePoints();
				}
				else
				{
					attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetKillPoints();;
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
	else if( (self.sessionteam == self.pers["team"] || self.pers["team"] == "spectator" ) && game["matchstarted"] == true && level.roundstarted == true && self.health > 0)
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
// FLAG FUNCTIONS
// ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------
//	Flag_Initialize
//
// 		Sets up a flag
// ----------------------------------------------------------------------------------
Flag_Initialize(flag)
{
	flag.team = "neutral";
	flag.allies = 0;
	flag.axis = 0;
	flag.progresstime = 0;
	flag.axis_capping = 0;
	flag.allies_capping = 0;
	flag.capping = 0;
	flag.last_capping = 0;
	flag.scale = 0;
	flag.radarupdated = 0;
	flag.beingcapped = false;
	
	// now see if we can find any props that need to be turned off 
	props = getentarray("flag" + flag.id + "stuff_allies", "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray("flag" + flag.id + "stuff_axis", "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray("flag" + flag.id + "stuff_neutral", "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] show();
	}
	
	// start special flag sounds playing if there are any
	sound_maker = getent("flag"+ flag.id + "radio" ,"targetname");
	if (isDefined(sound_maker) && isDefined(game["neutralradio"]))
	{
		sound_maker playloopsound( game["neutralradio"]);
	}	
}

// ----------------------------------------------------------------------------------
//	Flag_InitTriggers
//
// 		Sets up all of the flag triggers with an id and a description
// ----------------------------------------------------------------------------------
Flag_InitTriggers()
{
	// Setting up the flag TRIGGERS
	for(q=1;q<level.max_flag_count;q++) // Makes the flag limit of 15, then searches for all of the flags in the map.
	{
		current_flag = getent("flag" + q,"targetname");
		if(!isDefined(current_flag)) // If the flag exists, then proceed. Which then tells all of the allies and axis flag to be hidden.
		{
			continue;
		}
		level.flagcount++;

		getent("flag" + q + "_allies","targetname") hide();
		getent("flag" + q + "_axis","targetname") hide();

		if(!isDefined(current_flag.script_idnumber) || current_flag.script_idnumber == 0)
		{
			current_flag.script_idnumber = q;
		}

		if(!isDefined(current_flag.description)) // If a flag has no description set, randomly pick something silly.
		{
			n = randomint(5);
			switch(n)
			{
				case 0:
					current_flag.description = (&"GMI_DOM_UNNAMED_FLAG0");
					break;
				case 1:
					current_flag.description = (&"GMI_DOM_UNNAMED_FLAG1");
					break;
				case 2:
					current_flag.description = (&"GMI_DOM_UNNAMED_FLAG2");
					break;
				case 3:
					current_flag.description = (&"GMI_DOM_UNNAMED_FLAG3");
					break;
				case 4:
					current_flag.description = (&"GMI_DOM_UNNAMED_FLAG4");
					break;
			}
								
		}
	}

	if (level.flagcount == 1) // If no flags are found, then error out.
	{
		maps\mp\_utility::error("THERE ARE NO FLAGS IN MAP");
	}
	
	// set the x position of the first flag icon
	game["flag_icons_x"] = 320 - ( game["flag_icons_w"] * (level.flagcount - 1 ) * 0.5 );  

}

// ----------------------------------------------------------------------------------
//	Flag_StartThinking
//
// 		Sets up the flags and then starts the think loop for each one
// ----------------------------------------------------------------------------------
Flag_StartThinking()
{
	for(q=1;q<level.flagcount;q++)
	{
		flag = getent("flag"+q,"targetname");
		
		flag.id = q;
		Flag_Initialize(flag);
				
		if(flag.script_idnumber < 0 || flag.script_idnumber > level.flagcount )
		{
			maps\mp\_utility::error("Bad script_idnumber " + script_idnumber + " for flag " + q);
		}
		
		SetupFlagIcon(flag);
		flag thread Flag_ZoneThink();
	}
}

// ----------------------------------------------------------------------------------
//	Flag_ZoneThink
//
// 		This is continually called for each flag.  This lets the flag determine
//		if it is being captured
// ----------------------------------------------------------------------------------
Flag_ZoneThink()
{
	level endon("round_ended");

	if(!isDefined(self.script_timer))
		self.script_timer = 10;

	name = "blah";
	count = 1;
	
	for(;;)
	{
		if(self.capping == 0 || level.roundended)
		{
			self Capture_Canceled();
			self waittill("trigger", other);		
		}

		if(game["matchstarted"] == false || level.roundstarted == false)
		{
			count -= 1;
			if(count == 0)
			{
				other iprintln(&"GMI_DOM_WAIT_TILL_MATCHSTART");
				count = 100;
			}
			wait 0.05;
			continue;
		}

		// zero out the flag capping count
		self.capping = 0;
		self.allied_capping = 0;
		self.axis_capping = 0;
		
		players = getentarray("player", "classname");
		
		// count up the people in the flag area
		for(i = 0; i < players.size; i++)
		{
			player = players[i];

			if(isAlive(player) && (player istouching(self)) && !(player isinvehicle()) )
			{
				if(player.pers["team"] == "allies")
				{
					self.allied_capping++;
				}
				else if(player.pers["team"] == "axis")					
				{
					self.axis_capping++;		
				}
			}
		}
		
		self.capping = self.allied_capping - self.axis_capping;	
	
		// set this variable if only one team is currently trying to cap
		one_team = 0;
		if ( self.allied_capping == 0 || self.axis_capping == 0 )
		{ 
			if ( self.allied_capping != 0 && self.team != "allies" )
			{
				one_team = 1;
			}
			else if ( self.axis_capping != 0 && self.team != "axis" )
			{
				one_team = 1;
			}
		}
		
		// is only one team trying to cap?
		if ( one_team )
		{
			// now each player need to have their flag progress bar started
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
	
				if(isAlive(player) && player istouching(self))
				{
					if(!isDefined(player.pers["capture_process_thread"]))
						player.pers["capture_process_thread"] = 0;
	
					// if this flag is set then the player is currently already displaying the flag info
					if (player.pers["capture_process_thread"] == 1)
						continue;
						
					player.pers["capture_process_thread"] = 1;
					player thread Capture_PlayerCappingFlag(self);
				}
			}
	
			// if this just started being capped then update the radar
			if ( !self.beingcapped )
			{
				self.radarupdated = false;
			}
			self.beingcapped = true;
			
			if (self.capping > 0)
			{
				self.progresstime += (0.05) * ((1 + (self.capping - 1) * 0.5 ));
				if(self.capping == 1)
				{
					name = other;
				}
			}
			else if (self.capping < 0)
			{
				self.progresstime +=  (0.05) * ((1 + (-1 * self.capping - 1) * 0.5 ));
				if(self.capping == -1)
				{
					name = other;
				}
			}

			self.scale = (self.progresstime / self.script_timer);
		}
		else
		{
			self Capture_Canceled();
			wait 0.05;
		}	

//			self.blinking_icon.x  =-64;	//	move off
//			self.blinking_icon.y = -64;
		
		// display the screen icons
		if (game["showicons"] && self.scale > 0.00001)
		{
			if(!isDefined(self.capping_icon))
			{
				self.capping_icon = newHudElem();
				self.capping_icon.alignX = "left";
				self.capping_icon.alignY = "top";
				self.capping_icon.x =game["flag_icons_x"] + (self.script_idnumber * game["flag_icons_w"]) - game["flag_icons_h"];
				self.capping_icon.y = game["flag_icons_y"];
				self.capping_icon.sort = 0.5;  // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!
			}

			if (!isDefined(self.blinking_icon))
			{
				self.blinking_icon = newHudElem();
				self.blinking_icon.alignX ="left";
				self.blinking_icon.alignY ="top";
				self.blinking_icon.x =game["flag_icons_x"] + (self.script_idnumber * game["flag_icons_w"]) - game["flag_icons_h"];
				self.blinking_icon.y = game["flag_icons_y"];
				self.blinking_icon.sort = 0.7;  // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!
			}

			if(self.scale * game["flag_icons_w"] >= 1)
			{

				//	we need to clamp this to int values and back to float 
				//	this is because just using float values is TOOO smooth 
				capping_int	= (int)(self.scale * 32);

			
				capping_float = (float)capping_int / 32.0;
			
				switch((capping_int/2) % 2)
				{
					case	0:	self.blinking_icon.color = (1,1,0);
							break;
					case	1:	self.blinking_icon.color = (0,0,0);
							break;
				}
				self.blinking_icon setShader(game["hud_ring"], 32,32);

				if(self.capping > 0)
				{
					self.capping_icon setShader(game["hud_allies_flag"], game["flag_icons_w"], self.scale * game["flag_icons_h"],1.0,capping_float);
				}
				else
				{
					self.capping_icon setShader(game["hud_axis_flag"], game["flag_icons_w"], self.scale * game["flag_icons_h"],1.0,capping_float);
				}
			}

		}

		self.last_capping = self.capping;
		if(self.scale >= 0.999999)
		{
			cappers = self.capping;
			
			if(self.capping > 0)
			{
				self thread Capture_AlliesCappedFlag(cappers,name);
			}
			else
			{
				self thread Capture_AxisCappedFlag(cappers,name);
			}
			
			other.score = other.pers["score"];
			
			self Capture_Canceled();
		}
		wait 0.05;
	}


}

// ----------------------------------------------------------------------------------
//	Flag_AllCapturedThink
//
// 	Continually checks to see if all of the flags have been captured.
// ----------------------------------------------------------------------------------
Flag_AllCapturedThink()
{
	for(;;)
	{
		flag_count_allied = 0;
		flag_count_axis = 0;
		for(q=1;q<level.flagcount;q++)
		{
			flag = getent("flag"+q,"targetname");
			
			if(flag.team == "allies" && !flag.beingcapped)
			{
				flag_count_allied++;
			}
			else if(flag.team == "axis" && !flag.beingcapped)
			{
				flag_count_axis++;
			}
		}

		if(flag_count_allied == (level.flagcount - 1))
		{
			thread endRound("allies");
			
			// give the allies points
			println("giving allies points");
			game["alliedscore"] += getcvarint("scr_dom_domination_points");
			setTeamScore("allies", game["alliedscore"]);
			
			return;
		}
		if(flag_count_axis == (level.flagcount - 1))
		{
			thread endRound("axis");

			// give the allies points
			game["axisscore"] += getcvarint("scr_dom_domination_points");
			setTeamScore("axis", game["axisscore"]);
			return;
		}
		
		wait .5;
	}
}

// ----------------------------------------------------------------------------------
// CAPTURE FUNCTION
// ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------
//	Capture_AlliesCappedFlag
//
// 		Gets called when the allies cap a flag.  Displays the appropriate flag.
//		Also displays the cap messages.
// ----------------------------------------------------------------------------------
Capture_AlliesCappedFlag(cappers,name)
{
	self notify("captured");
	
	old_team = self.team;
	self.team = "allies";
	self.radarupdated = 0;	

	game["alliedscore"]++;
	setTeamScore("allies", game["alliedscore"]);
	
	//play the flag taken vo on all players.  
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(player.pers["team"] == "allies")
		{
			if ( old_team != "axis" )
				player playLocalAnnouncerSound(game["sound_allies_area_secure"]);
			else
				player playLocalAnnouncerSound(game["sound_allies_ground_taken"]);
		}
		else
			player playLocalAnnouncerSound(game["sound_axis_enemy_has_taken_flag"]);
	}
	
	getent((self.targetname + "_axis"),"targetname") hide();
	getent((self.targetname + "_neutral"),"targetname") hide();
	getent((self.targetname + "_allies"),"targetname") show();	
	
	if (game["showicons"])
		self.icon setShader(game["hud_allies_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	
	// if the flag is capped from the other teamgive them all the reverse penalty
	if ( old_team == "axis" )
	{
		GivePointsToTeam( "axis", game["br_points_reversal"] );
	}
	
	// give the team points out
	GivePointsToTeam( self.team, game["br_points_teamcap"] );
	
	// give out points to the cappers
	self GivePointsToCappers( "allies" );

	names = self GetCappers("allies");

	// display the cap message
	if(cappers > 1)
	{
		// this will cause an unlocalized string warning if you are running in developer mode because of the names
		PrintCappedMessage(&"GMI_DOM_ALLIES_CAP_FLAG_TEAM",self.description,names);
	}
	else
	{
		// this will cause an unlocalized string warning if you are running in developer mode because of the names
		iprintln(&"GMI_DOM_ALLIES_CAP_FLAG_SOLO",names[0],self.description);
	}
	
	// now see if we can find any props that need to be turned off 
	props = getentarray("flag" + self.script_idnumber + "stuff_" + old_team, "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray("flag" + self.script_idnumber + "stuff_allies", "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] show();
	}
	
	// start special flag sounds playing if there are any
	sound_maker = getent("flag" + self.script_idnumber + "radio","targetname");
	if (isDefined(sound_maker) && isDefined(game[self.team + "radio"]))
	{
		sound_maker playloopsound(game[self.team + "radio"]);
	}
}

// ----------------------------------------------------------------------------------
//	Capture_AxisCappedFlag
//
// 		Gets called when the axis cap a flag.  Displays the appropriate flag.
//		Also displays the cap messages.
// ----------------------------------------------------------------------------------
Capture_AxisCappedFlag(cappers,name)
{
	self notify("captured");

	old_team = self.team;
	self.team = "axis";
	self.radarupdated = 0;	
	
	game["axisscore"]++;
	setTeamScore("axis", game["axisscore"]);

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(player.pers["team"] == "allies")
			player playLocalAnnouncerSound(game["sound_allies_enemy_has_taken_flag"]);
		else
		{
			if ( old_team != "allies" )
				player playLocalAnnouncerSound(game["sound_axis_area_secure"]);
			else
				player playLocalAnnouncerSound(game["sound_axis_ground_taken"]);
		}
	}
	
	getent((self.targetname + "_allies"),"targetname") hide();
	getent((self.targetname + "_neutral"),"targetname") hide();
	getent((self.targetname + "_axis"),"targetname") show();

	if (game["showicons"])
		self.icon setShader(game["hud_axis_flag"], game["flag_icons_w"], game["flag_icons_h"]);

	// if the flag is capped from the other teamgive them all the reverse penalty
	if ( old_team == "allies" )
	{
		GivePointsToTeam( "allies", game["br_points_reversal"] );
	}
	
	// give the team points out
	GivePointsToTeam( self.team, game["br_points_teamcap"] );
	
	// give out points to the cappers
	self GivePointsToCappers( "axis" );

	names = self GetCappers("axis");

	// display the cap message
	if(cappers < -1)
	{
		// this will cause an unlocalized string warning if you are running in developer mode because of the names
		PrintCappedMessage(&"GMI_DOM_AXIS_CAP_FLAG_TEAM",self.description,names);
	}
	else
	{
		// this will cause an unlocalized string warning if you are running in developer mode because of the names
		iprintln(&"GMI_DOM_AXIS_CAP_FLAG_SOLO",names[0],self.description);
	}
	
	// now see if we can find any props that need to be turned off 
	props = getentarray("flag" + self.script_idnumber + "stuff_" + old_team, "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray("flag" + self.script_idnumber + "stuff_axis", "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] show();
	}
	
	// start special flag sounds playing if there are any
	sound_maker = getent("flag" + self.script_idnumber + "radio","targetname");
	if (isDefined(sound_maker )&& isDefined(game[self.team + "radio"]))
	{
		sound_maker playloopsound( game[self.team + "radio"]);
	}
		
}

// ----------------------------------------------------------------------------------
//	Capture_PlayerCappingFlag
//
// 		Gets called when a player starts capping a flag.  This displays the 
//		progress bar.
// ----------------------------------------------------------------------------------
Capture_UpdateProgressBar(flag)
{
	self endon("death");
	level endon("round_ended");
	flag endon("capture_canceled");
	flag endon("captured");

	barsize = maps\mp\_util_mp_gmi::get_progressbar_maxwidth();
	height = maps\mp\_util_mp_gmi::get_progressbar_height();
	InitProgressbar(self, &"GMI_DOM_CAPTURING_FLAG");
		
	// loop until done displaying the progress bar
	// dump out if:
	//	1: Not touching the flag anymore
	//	2: Your team is the same as the flag team.
	//	3: You are a spectator
	while(	((flag.axis_capping == 0) || (flag.allied_capping == 0))
		&& self.pers["team"] != flag.team 
		&& self.pers["team"] != "spectator")
	{
		if (flag.scale > 0)
		{
			self.progressbar setShader("white", flag.scale * barsize,  height);
		}
		wait .01;
	}
}

// ----------------------------------------------------------------------------------
//	Capture_PlayerCappingFlag
//
// 		Gets called when a player starts capping a flag.  This displays the 
//		progress bar.
// ----------------------------------------------------------------------------------
Capture_PlayerCappingFlag(flag)
{
	if ( !isAlive(self) )
		return;
		
	if(flag.capping != 0)
	{
		getent((flag.targetname + "_neutral"),"targetname") playloopsound("start_flag_capture");
	}
	
	self thread Capture_UpdateProgressBar(flag);
	
	flag waittill("capture_canceled");
	
	// we are done so destroy the progress bars
	if (isDefined(self.progressbar))
	{
		self.progressbar destroy();
	}
	if (isDefined(self.progressbackground))
	{
		self.progressbackground destroy();
	}
	if(isDefined(self.progresstext))
	{					
		self.progresstext destroy();
	}
	
	getent((flag.targetname + "_neutral"),"targetname") stoploopsound("start_flag_capture");
	self.view_bar = 0;
	self.pers["capture_process_thread"] = 0;
}

// ----------------------------------------------------------------------------------
//	Capture_Canceled
//
// 		Called on a flag when the capture is ended for any reason
// ----------------------------------------------------------------------------------
Capture_Canceled()
{
	self notify("capture_canceled");
	
	self.beingcapped = false;
	self.radarupdated = 0;

	self.progresstime = 0;
	self.scale = 0;

	if(isDefined(self.capping_icon))
	{
		self.capping_icon destroy();
	}
	if(isDefined(self.blinking_icon))
	{
		self.blinking_icon destroy();
	}
	
	getent((self.targetname + "_neutral"),"targetname") stoploopsound("start_flag_capture");

}

// ----------------------------------------------------------------------------------
//	Capture_CheckCappingFlag
//
// 	Checks to see if the player is currently capping the flag and returns true.
// ----------------------------------------------------------------------------------
Capture_CheckCappingFlag(player)
{
	opposing_team = "allies"; 
	if ( player.pers["team"] == "allies") 
		opposing_team = "axis" ; 
	
	// loop through all the flags and see if the player is in one
	for(q=1;q<level.flagcount;q++)
	{
		flag = getent("flag"+q,"targetname");

		// we only need to check the ones held by the other team
		if(flag.team == opposing_team && player istouching(flag))
		{
			return true;
		}
	}
	
	return false;
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
	self playLocalAnnouncerSound(announcer);
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

	wait(0.01);
	
	if(self.pers["team"] != "allies" && self.pers["team"] != "axis")
	{
		maps\mp\_utility::error("Team not set correctly on spawning player " + self + " " + self.pers["team"]);
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

	resettimeout();

	// clear any hud elements
	self Player_ClearHud();

	self.sessionteam = self.pers["team"];
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	
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
		base_spawn_name = "mp_uo_spawn_allies";
		secondary_spawn_name = "mp_uo_spawn_allies_secondary";
	}
	else if(self.pers["team"] == "axis")
	{
		base_spawn_name = "mp_uo_spawn_axis";
		secondary_spawn_name = "mp_uo_spawn_axis_secondary";
	}	
	else
	{
		maps\mp\_utility::error("Team not set correctly on spawning player " + self);
	}
	
	// get the base spawnpoints
	spawnpoints = getentarray(base_spawn_name, "classname");
	
	// now add to the array any spawnpoints that are related to held flags
	for(q=1;q<level.flagcount;q++)
	{
		flag_trigger = getent("flag" + q,"targetname");
		
		if ( !isDefined( flag_trigger.target ) )
			continue;
			
		// only get spawnpoints from flags that are held by this team	
		if ( self.pers["team"] != flag_trigger.team )
			continue;
			
		secondary_spawns =  getentarray(flag_trigger.target, "targetname");
	
		for ( i = 0; i < secondary_spawns.size; i++ )
		{
			// only get the ones for the current team
			if ( secondary_spawns[i].classname != secondary_spawn_name )
				continue;
				
			spawnpoints = maps\mp\_util_mp_gmi::add_to_array(spawnpoints, secondary_spawns[i]);
		}
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

	// if we could not get a spawn point then fall back to random
	if(!isDefined(spawnpoint))
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	// this is somewhat redundant now because we verify when the game starts that the spawn points are in
	// but what the hey it does not hurt
	if(isDefined(spawnpoint))
		spawnpoint maps\mp\gametypes\_spawnlogic::SpawnPlayer(self);
	else
		maps\mp\_utility::error("NO " + base_spawn_name + " SPAWNPOINTS IN MAP");
	
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
	
	if(self.pers["team"] == "allies")
		self setClientCvar("cg_objectiveText", game["dom_allies_obj_text"]);
	else if(self.pers["team"] == "axis" )
		self setClientCvar("cg_objectiveText", game["dom_axis_obj_text"]);
		
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

	if(self.pers["team"] == "spectator")
		self.statusicon = "";

	maps\mp\gametypes\_teams::SetSpectatePermissions();
	if(isDefined(origin) && isDefined(angles))
		self spawn(origin, angles);
	else
	{
		spawnpointname = "mp_dom_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
					
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}

	self.usedweapons = false;

	updateTeamStatus();

	if( "allies" == self.pers["team"])
		self setClientCvar("cg_objectiveText", game["dom_allies_obj_text"]);
	else if("axis" == self.pers["team"])
		self setClientCvar("cg_objectiveText", game["dom_axis_obj_text"]);
	else 
		self setClientCvar("cg_objectiveText", game["dom_spectator_obj_text"]);
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

	spawnpointname = "mp_dom_intermission";
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

	level.allies_cap_count = 0;
	level.axis_cap_count = 0;
	
	level.roundstarttime = getTime();
	level.allies_cap_count = 0;  
	level.axis_cap_count = 0;  

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
	
	flag_count_allied = 0;
	flag_count_axis = 0;
	for(q=1;q<level.flagcount;q++)
	{
		flag = getent("flag"+q,"targetname");
		
		if(flag.team == "allies")
		{
			flag_count_allied++;
		}
		else if(flag.team == "axis")
		{
			flag_count_axis++;
		}
	}
	
	if(flag_count_allied == flag_count_axis)
	{
		level thread endRound("draw");
	}
	else if ( flag_count_allied > flag_count_axis )
	{
		level thread endRound("allies");
	}
	else
	{
		level thread endRound("axis");
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
	if(getCvarInt("scr_debug_dom") != 1) // MikeD: So 1 person can play.
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

//	game["alliedscore"] = 0;
//	setTeamScore("allies", game["alliedscore"]);
//	game["axisscore"] = 0;
//	setTeamScore("axis", game["axisscore"]);
	
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
}

// ----------------------------------------------------------------------------------
//	endRound
//
// 		Ends the round
// ----------------------------------------------------------------------------------
endRound(roundwinner)
{
	level endon("kill_endround");

	if(level.roundended)
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

	for(q=1;q<level.flagcount;q++)
	{
		flag = getent("flag"+q,"targetname");
		flag Capture_Canceled();
	}

 	if (roundwinner == "abort")
		game["matchstarted"] = false;
	level.roundstarted = false;
	 
	if(roundwinner == "allies")
	{		
		announcement(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			players[i] thread Victory_PlaySounds(game["sound_allies_victory_vo"],game["sound_allies_victory_music"]);
		}
		level thread Victory_DisplayImage(game["hud_allies_victory_image"]);
	}
	else if(roundwinner == "axis")
	{
		announcement(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
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
			players[i] playLocalAnnouncerSound(game["sound_round_draw_vo"]);
	}

	if (roundwinner != "reset")
	{
		time = getCvarInt("scr_dom_endrounddelay");
		
		if ( time < 1 )
			time = 1;
		wait(time);
	}

	winners = "";
	losers = "";

	if(roundwinner == "allies" && !level.mapended)
	{
//		game["alliedscore"]++;
//		setTeamScore("allies", game["alliedscore"]);
		
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
//		game["axisscore"]++;
//		setTeamScore("axis", game["axisscore"]);

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
//	else if ( getCvarint("scr_dom_clearscoreeachround") == 1 && !level.mapended)
//	{
//		thread resetScores();
//	}
	
	if(level.mapended)
		return;
	
	// if the teams are not full then abort
	if ( !(level.exist["axis"] && level.exist["allies"]) && !getcvarint("scr_debug_dom") )
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
	
	time = getCvarint("scr_dom_startrounddelay");

	if (time < 1)
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

	if ( getCvarint("scr_dom_clearscoreeachround") == 1 && !level.mapended )
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
	level notify("kill_startround");
	game["state"] = "intermission";
	level notify("intermission");
	
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
	
	level thread endMap();
	
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

		timelimit = getCvarFloat("scr_dom_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_dom_timelimit", "1440");
			}

			level.timelimit = timelimit;
			setCvar("ui_dom_timelimit", level.timelimit);
		}

		scorelimit = getCvarInt("scr_dom_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_dom_scorelimit", level.scorelimit);

			if(game["matchstarted"])
				checkScoreLimit();
		}

		roundlimit = getCvarInt("scr_dom_roundlimit");
		if(level.roundlimit != roundlimit)
		{
			level.roundlimit = roundlimit;
			setCvar("ui_dom_roundlimit", level.roundlimit);

			if(game["matchstarted"])
				checkRoundLimit();
		}

		level.roundlength = getCvarFloat("scr_dom_roundlength");
		if(level.roundlength > 60)
			setCvar("scr_dom_roundlength", "60");

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
			level.exist[player.pers["team"]]++;
	}

	if(level.exist["allies"])
		level.didexist["allies"] = true;
	if(level.exist["axis"])
		level.didexist["axis"] = true;

	debug = getCvarint("scr_debug_dom");

	// if one team is empty then abort the round
	if(!debug && (oldvalue["allies"] && !level.exist["allies"]) || (oldvalue["axis"] && !level.exist["axis"]))
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
SetupFlagIcon(flag)
{
	game["showicons"] = false;

	if (!getCvarint("scr_showicons"))
		return;

	game["showicons"] = true;
	
	// Flag icons at top of screen
	if(!isDefined(flag.icon))
	{
		flag.icon = newHudElem();
	}
	flag.icon.alignX = "left";
	flag.icon.alignY = "top";
	flag.icon.x =game["flag_icons_x"] + (flag.script_idnumber * game["flag_icons_w"]) - game["flag_icons_w"];
	flag.icon.y = game["flag_icons_y"];
	flag.icon.sort = 0.0; // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!

	if(flag.team == "allies")
	{
		flag.icon setShader(game["hud_allies_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	}
	else if(flag.team == "axis")
	{
		flag.icon setShader(game["hud_axis_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	}
	else
	{
		flag.icon setShader(game["hud_neutral_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	}
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
GivePointsToCappers( team )
{
	players = getentarray("player", "classname");
	
	// give points to everyone in the cap area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isAlive(player) && player.pers["team"] == team && player istouching(self))
		{
			player.pers["score"] += game["br_points_cap"];		
			player.score = player.pers["score"];

			lpselfnum = player getEntityNumber();
			lpselfguid = player getGuid();
			logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + player.pers["team"] + ";" + player.name + ";" + "dom_captured" + "\n");
		}
	}
}

// ----------------------------------------------------------------------------------
//	GetCappers
//
// 		Makes a string of everyone who is in the cap area
// ----------------------------------------------------------------------------------
GetCappers( team )
{
	players = getentarray("player", "classname");
	
	names = [];
	
	// give points to everyone in the cap area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isAlive(player) && player.pers["team"] == team && player istouching(self))
		{
			names[names.size] = player;
		}
	}
	return names;
}

// ----------------------------------------------------------------------------------
//	PrintCappedMessage
//
// 		Prints out a capped message for a variable amount of cappers
// ----------------------------------------------------------------------------------
PrintCappedMessage( text, flag, cappers )
{
	size = cappers.size;
	if ( size >= 7 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1],"^7, ",cappers[2],"^7, ",cappers[3],"^7, ",cappers[4],", "^7,cappers[5],"^7, ",cappers[6]);
	else if ( size == 6 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1],"^7, ",cappers[2],"^7, ",cappers[3],"^7, ",cappers[4],", "^7,cappers[5]);
	else if ( size == 5 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1],"^7, ",cappers[2],"^7, ",cappers[3],"^7, ",cappers[4]);
	else if ( size == 4 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1],"^7, ",cappers[2],"^7, ",cappers[3]);
	else if ( size == 3 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1],"^7, ",cappers[2]);
	else if ( size == 2 )
		iprintln(text,flag,"^7 ",cappers[0],"^7, ",cappers[1]);
	else if ( size == 1 )
		iprintln(text,flag,"^7 ",cappers[0]);
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
		scorelimit = getCvarint("scr_dom_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;

			if(game["matchstarted"])
				checkScoreLimit();
		}

		// end the round if there are not enough people playing
		if (game["matchstarted"] == true && level.roundstarted == true)
		{
			debug = getCvarint("scr_debug_dom");
			
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
//	checkEvenTeams
//
//	JS 1/14/04
// 	Displays a message in the center of screen if teams are uneven by more than
//	one player.
// ----------------------------------------------------------------------------------
checkEvenTeams()
{
	for(;;)
	{
		if(!isDefined(level.messagedisplayed) || level.messagedisplayed == 0)	//Test to see if a message is already on-screen so we don't spam
		{
			//Count the players on each team			
			numonteam["allies"] = 0;
			numonteam["axis"] = 0;
	
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
			
				if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator")
					continue;
		
				numonteam[player.pers["team"]]++;
			}
	
			//If Allies have 2 or more players than Axis, display the message			
			if(numonteam["allies"] > numonteam["axis"] && (numonteam["allies"] - numonteam["axis"]) >= 2)
			{
				level.messagedisplayed = 1;
				iprintlnbold(&"GMI_MP_ALLIES_TOO_MANY_PLAYERS");
			}
	
			//If Axis have 2 or more players than Allies, display the message			
			else if(numonteam["axis"] > numonteam["allies"] && (numonteam["axis"] - numonteam["allies"]) >= 2)
			{
				level.messagedisplayed = 1;
				iprintlnbold(&"GMI_MP_AXIS_TOO_MANY_PLAYERS");
			}
				
			wait 8.0;	//Eight seconds between messages... should be annoying enough at that interval.
			level.messagedisplayed = 0;
		}
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
//	drawFlagsOnCompass
//
// 	Draws all of the compass flags and objectives
// ----------------------------------------------------------------------------------
drawFlagsOnCompass()
{
	for(;;)
	{
		for(q=1;q<level.flagcount;q++)
		{
			current_flag = getent("flag" + q + "_neutral","targetname");
			flag_trigger = getent("flag" + q,"targetname");
			
			if (!isDefined(current_flag))
				maps\mp\_utility::error("Could not find the flag entity flag" + q + "_neutral"); 
			if (!isDefined(flag_trigger))
				maps\mp\_utility::error("Could not fine the flag trigger flag" + q ); 

			if ( !isDefined(flag_trigger.team) )
				continue;
				
			if ( flag_trigger.radarupdated )
				continue;		
		
			flag_trigger.radarupdated = true;
			
			if(flag_trigger.beingcapped)
			{
				objective_add(flag_trigger.id, "current", current_flag.origin, game["hud_capping_radar"]);
				objective_onEntity(flag_trigger.id, current_flag);
				flag_trigger.yellow = 1;	//JS - this is to keep the shader from starting over every 0.5 seconds

				//play the flag lost sound based on team
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					switch(player.pers["team"])
					{
						case "allies":
						{
							if( flag_trigger.team == "allies")
							{
								player playLocalAnnouncerSound(game["sound_allies_enemy_is_taking_flag"]);
								player iprintln(&"GMI_DOM_AXIS_FLAG_OVERRUN", flag_trigger.description);
							}
							break;
						}
						case "axis":
						{
							if( flag_trigger.team== "axis" )
							{
								player playLocalAnnouncerSound(game["sound_axis_enemy_is_taking_flag"]);
								player iprintln(&"GMI_DOM_ALLIES_FLAG_OVERRUN", flag_trigger.description);
							}
						}
					}
				}
			}
			else if(flag_trigger.team == "allies")
			{
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_axis_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_neutral_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_capping_radar"]);
				objective_add(flag_trigger.id, "current", current_flag.origin, game["hud_allies_radar"]);
			}
			else if(flag_trigger.team == "axis")
			{
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_allies_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_neutral_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_capping_radar"]);
				objective_add(flag_trigger.id, "current", current_flag.origin, game["hud_axis_radar"]);
			}
			else if(flag_trigger.team == "neutral")
			{
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_allies_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_axis_radar"]);
				objective_delete(flag_trigger.id, "current", current_flag.origin, game["hud_capping_radar"]);
				objective_add(flag_trigger.id, "current", current_flag.origin, game["hud_neutral_radar"]);
			}
		}
	wait 0.5;
	}
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
			thread stopwatch_delete("do_it");
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

	thread stopwatch_delete(reason);
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

	thread stopwatch_delete(reason);
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
