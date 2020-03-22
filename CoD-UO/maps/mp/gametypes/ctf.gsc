
/*
	CTF
	Objective: Get the other teams flag and return it to your own base.  Your flag must be in the base to capture.
	Round ends:	Roundlength time is reached.
	Map ends:	When one team reaches the score limit, or time limit or round limit is reached
	Respawning:	Players will respawn after a short wait.

	Level requirements
	------------------
		Allied Spawnpoints:
			classname		mp_uo_spawn_allies
			Allied players spawn from these. Place at least 16 of these relatively close together.

		Axis Spawnpoints:
			classname		mp_uo_spawn_axis
			Axis players spawn from these. Place at least 16 of these relatively close together.

		Spectator Spawnpoints:
			classname		mp_ctf_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

		Flag Item:
			classname		script_model
			targetname		ctf_flag_allies or ctf_flag_axis
			target			<Each must target their own pick up trigger, and one item spawn location.>
			script_gameobjectname	ctf
			There can only be one of these for each team.

		Mobile Flag Item:
			classname		script_model
			targetname		ctf_flag_allies_mobile or ctf_flag_axis_mobile
			target			<Each must target their own pick up trigger>
			script_gameobjectname	ctf
			There can only be one of these for each team.

		Flag Pick Up Trigger:
			classname		trigger_multiple
			script_gameobjectname	ctf
			This trigger is used to pick up a flag. This trigger should be made up of brushes that fairly represent
			the mobile flag model with an origin brush placed so that it's center lies on the bottom plane of the trigger.
			Must be in the level somewhere. It is automatically moved to the position of the flag targeting it.

		Mobile Flag Pick Up Trigger:
			classname		trigger_multiple
			script_gameobjectname	ctf
			This trigger is used to pick up a flag. This trigger should be made up of brushes that fairly represent
			the flag model with an origin brush placed so that it's center lies on the bottom plane of the trigger.
			Must be in the level somewhere. It is automatically moved to the position of the flag targeting it.


		Flag Spawn Location:
			classname		mp_gmi_ctf_flag
			script_gameobjectname	ctf
			targetname		<should be the same as the target specified in the script_model for this flag>
			target			<This must target the opposite teams flag goal trigger>
			An flag item targeting this will spawn at this location.  There should be one of these for each team.
		
		Flag Goal Trigger(s):
			classname		trigger_multiple
			script_gameobjectname	ctf
			targetname 		<should be the same as the target specified by the opposite teams mp_gmi_ctf_flag entity>
			This is the area the team must return the enemy flag to. Must contain an origin brush.  This should be 
			in the same position as the opposite teams flag location.

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
			game["ctf_layoutimage"] = "yourlevelname";  (or use game["layoutimage"] if no special map for this gametype is needed)
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.

		Objective Text:
			game["ctf_attackers_obj_text"] = "Capture the flags NOW!!!  DO IT!!";
			game["ctf_spectator_obj_text"] = "Go home to mommy dirty guy";
			These set custom objective text. Otherwise default text is used.

	Note
	----
		Setting "script_gameobjectname" to "ctf" on any entity in a level will cause that entity to be removed in any gametype that
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

/*QUAKED mp_ctf_intermission (1.0 0.0 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/

/*QUAKED mp_gmi_ctf_flag (0.0 0.5 1.0) (-8 -8 -8) (8 8 8)
This is the flag location.  There needs to be one for each team
*/

main() // Starts when map is loaded.
{
	// init the spawn points first because if they do not exist then abort the game
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_allies", 1) )
		return;
	// Set up the spawnpoints of the "axis"
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_axis", 1) )
		return;

	// Set up the spawnpoints of the "axis"
	if ( !maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_ctf_intermission", 1, 1) )
		return;

	// set up secondary spawn points but don't abort if they are not there
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_allies_secondary");
	maps\mp\gametypes\_spawnlogic_gmi::InitSpawnPoints("mp_uo_spawn_axis");
	
	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();

	level.callbackStartGameType = ::Callback_StartGameType; // Set the level to refer to this script when called upon.
	level.callbackPlayerConnect = ::Callback_PlayerConnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect; // Set the level to refer to this script when called upon.
	level.callbackPlayerDamage = ::Callback_PlayerDamage; // Set the level to refer to this script when called upon.
	level.callbackPlayerKilled = ::Callback_PlayerKilled; // Set the level to refer to this script when called upon.

	maps\mp\gametypes\_callbacksetup::SetupCallbacks(); // Run this script upon load.

	allowed[0] = "ctf"; 
	maps\mp\gametypes\_gameobjects::main(allowed); // Take the "allowed" array and apply it to this script. which just deletes all of the objects that do not have script_objectname set to any of the allowed arrays. Ex. allowed[0].

	if(getCvar("scr_ctf_timelimit") == "")		// Time limit per map
		setCvar("scr_ctf_timelimit", "0");
	else if(getCvarFloat("scr_ctf_timelimit") > 1440)
		setCvar("scr_ctf_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_ctf_timelimit");
	setCvar("ui_ctf_timelimit", level.timelimit);
	makeCvarServerInfo("ui_ctf_timelimit", "0");

	if(getCvar("scr_ctf_roundlength") == "")		// Time length of each round
		setCvar("scr_ctf_roundlength", "30");
	else if(getCvarFloat("scr_ctf_roundlength") > 60)
		setCvar("scr_ctf_roundlength", "60");
	level.roundlength = getCvarFloat("scr_ctf_roundlength");
	setCvar("ui_ctf_roundlength", getCvar("scr_ctf_roundlength"));
	makeCvarServerInfo("ui_ctf_roundlength", "0");

	if(getCvar("scr_ctf_scorelimit") == "")		// Score limit per map
		setCvar("scr_ctf_scorelimit", "5");
	level.scorelimit = getCvarint("scr_ctf_scorelimit");
	setCvar("ui_ctf_scorelimit", getCvar("scr_ctf_scorelimit"));
	makeCvarServerInfo("ui_ctf_scorelimit", "0");
		
	if(getCvar("scr_friendlyfire") == "")		// Friendly fire
		setCvar("scr_friendlyfire", "1");	//default is ON

	if(getCvar("scr_showicons") == "")		// flag icons on or off
		setCvar("scr_showicons", "1");

	if(getCvar("scr_ctf_startrounddelay") == "")	// Time to wait at the begining of the round
		setCvar("scr_ctf_startrounddelay", "15");
	if(getCvar("scr_ctf_endrounddelay") == "")		// Time to wait at the end of the round
		setCvar("scr_ctf_endrounddelay", "10");

	if(getCvar("scr_ctf_clearscoreeachround") == "")	// clears everyones score between each round if true
		setCvar("scr_ctf_clearscoreeachround", "1");
	setCvar("ui_ctf_clearscoreeachround", getCvar("scr_ctf_clearscoreeachround"));
	makeCvarServerInfo("ui_ctf_clearscoreeachround", "0");

	if(getCvar("scr_drawfriend") == "")		// Draws a team icon over teammates, default is on.
		setCvar("scr_drawfriend", "1");
	level.drawfriend = getCvarint("scr_drawfriend");

	if(getCvar("scr_battlerank") == "")		// Draws the battle rank.  Overrides drawfriend.
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");

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
	
	if(getCvar("scr_death_wait_time") == "")	// Made up cvar, for the allies_deat_wait_time. This controls the delay for respawning reinforcement waves.
		setCvar("scr_death_wait_time", "5");
	level.death_wait_time = getCvarint("scr_death_wait_time");
	
	if(getCvar("scr_ctf_roundlimit") == "")		// Round limit per map
		setCvar("scr_ctf_roundlimit", "5");
	level.roundlimit = getCvarInt("scr_ctf_roundlimit");
	setCvar("ui_ctf_roundlimit", level.roundlimit);
	makeCvarServerInfo("ui_ctf_roundlimit", "0");

	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	if(!isDefined(game["ctf_attacker_obj_text"]))		
		game["ctf_attacker_obj_text"] = (&"GMI_CTF_ATTACKER_OBJECTIVE");
	
	if(!isDefined(game["ctf_spectator_obj_text"]))		
		game["ctf_spectator_obj_text"] = (&"GMI_CTF_SPECTATOR_OBJECTIVE");
	
	if(getCvar("scr_ctf_showoncompass") == "")
		setCvar("scr_ctf_showoncompass", "0");
	level.showoncompass = getCvarInt("scr_ctf_showoncompass");

	if(getCvar("scr_ctf_positiontime") == "")
		setCvar("scr_ctf_positiontime", "6");
	level.PositionUpdateTime = getCvarInt("scr_ctf_positiontime");

	if (!isdefined (game["BalanceTeamsNextRound"]))
		game["BalanceTeamsNextRound"] = false;
	
	level.ROUNDSTARTED = false;			// Set up level.roundstarted to be false, until both teams have 1 person.
	level.roundended = false;			// Set up level.roundended to be false, until the round has ended, this will be taken out, since there will not be a timelimit to rounds.
	level.mapended = false;				// Set up level.mapended to be false, until the overall timelimit is finished.
	
	level.exist["allies"] = 0; 	// This is a level counter, used when clients choose a team.
	level.exist["axis"] = 0; 	// This is a level counter, used when clients choose a team.
	level.exist["teams"] = false;
	level.didexist["allies"] = false;
	level.didexist["axis"] = false;
	level.death_pool["allies"] = 0; // Sets the allies death pool to 0.
	level.death_pool["axis"] = 0; // Sets the axis death pool to 0.
	level.allies_cap_count = 0;  // how many times the allies capped in the current round
	level.axis_cap_count = 0;  // how many times the axis capped in the current round
	
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
	level.deepwater = getentarray("deepwater", "targetname");
	if (!isdefined (level.deepwater))
		level.deepwater = [];

	if(!isDefined(game["allies"]))
		game["allies"] = "american"; // If not defined, set the global game["allies"] to american.
	if(!isDefined(game["axis"]))
		game["axis"] = "german"; // If not defined, set the global game["axis"] to german.

	level.axis_held_flag = "xmodel/o_ctf_flag_g";
	level.held_tag_flag = "TAG_HELMETSIDE";
	level.healthqueue = [];
	level.healthqueuecurrent = 0;

	switch( game["allies"])
	{
		case	"british":	level.allies_held_flag = "xmodel/o_ctf_flag_b";
					break;
		case	"russian":	level.allies_held_flag = "xmodel/o_ctf_flag_r";
					break;
		default:		level.allies_held_flag = "xmodel/o_ctf_flag_us";
					break;
	}

	// 
	// DEBUG
	//
	if(getCvar("scr_debug_ctf") == "")
		setCvar("scr_debug_ctf", "0"); 
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

		if(!isDefined(game["ctf_layoutimage"])) // If not defined, set the game["layoutimage"] to default. usually this is set in the mapname.gsc
			game["ctf_layoutimage"] = "default";

		layoutname = "levelshots/layouts/hud@layout_" + game["ctf_layoutimage"]; // Set layoutname to be hud@layout_"whatever game["layoutimage"]" is.

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
		precacheString(&"GMI_CTF_MATCHSTARTING");
		precacheString(&"GMI_CTF_MATCHRESUMING");
		precacheString(&"GMI_CTF_OBJECTIVE");
		precacheString(&"GMI_CTF_ALLIES_CAP_FLAG");
		precacheString(&"GMI_CTF_AXIS_CAP_FLAG");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_AN_NEXT");
		precacheString(&"GMI_MP_YOU_WILL_SPAWN_WITH_A_NEXT");
		precacheString(&"GMI_CTF_ATTACKER_OBJECTIVE");
		precacheString(&"GMI_CTF_SPECTATOR_OBJECTIVE");
		precacheString(&"GMI_CTF_TIMEEXPIRED");
		precacheString(&"GMI_CTF_ROUND_DRAW");
		precacheString(&"GMI_CTF_AXIS_PICKED_UP_FLAG");
		precacheString(&"GMI_CTF_ALLIES_PICKED_UP_FLAG");
		precacheString(&"GMI_CTF_ALLIES_FLAG_RETURNED");
		precacheString(&"GMI_CTF_AXIS_FLAG_RETURNED");
		precacheString(&"GMI_CTF_PLAYER_RETURNED_FLAG_AXIS");
		precacheString(&"GMI_CTF_PLAYER_RETURNED_FLAG_ALLIES");
		precacheString(&"GMI_CTF_AXIS_CAPTURED_FLAG");
		precacheString(&"GMI_CTF_ALLIES_CAPTURED_FLAG");
		precacheString(&"GMI_CTF_PLAYER_CAPTURED_FLAG_AXIS");
		precacheString(&"GMI_CTF_PLAYER_CAPTURED_FLAG_ALLIES");
		precacheString(&"GMI_CTF_FLAG_INMINES");
		precacheString(&"GMI_CTF_AXIS_FLAG_DROPPED");
		precacheString(&"GMI_CTF_ALLIES_FLAG_DROPPED");
		precacheString(&"GMI_CTF_AXIS_FLAG_TIMEOUT_RETURNING");
		precacheString(&"GMI_CTF_ALLIES_FLAG_TIMEOUT_RETURNING");
		precacheString(&"GMI_CTF_U_R_CARRYING_AXIS");
		precacheString(&"GMI_CTF_U_R_CARRYING_ALLIES");
		precacheString(&"GMI_CTF_DEFENDED_AXIS_FLAG");
		precacheString(&"GMI_CTF_DEFENDED_ALLIES_FLAG");
		precacheString(&"GMI_CTF_ASSISTED_AXIS_FLAG_CARRIER");
		precacheString(&"GMI_CTF_ASSISTED_ALLIES_FLAG_CARRIER");
		precacheString(&"GMI_DOM_ALLIEDMISSIONACCOMPLISHED");
		precacheString(&"GMI_DOM_AXISMISSIONACCOMPLISHED");
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

		//	all silly stuff
		precacheShader("gfx/hud/ctf_stance_crouch.dds");
		precacheShader("gfx/hud/ctf_stance_stand.dds");
		precacheShader("gfx/hud/ctf_stance_prone.dds");
		precacheShader("gfx/hud/ctf_stance_sprint.dds");

		// GMI FLAG MATCH IMAGES:
		precacheShader("gfx/hud/headicon@german.dds");
		precacheShader("hudStopwatch");
		precacheShader("hudStopwatchNeedle");

		// set up team specific variables
		switch( game["allies"])
		{
		case "british":
			game["headicon_carrier_axis"] = "gfx/hud/headicon@ctf_british.dds";
			game["statusicon_carrier_axis"] = "gfx/hud/hud@ctf_british.dds";

			game["hud_allies_base_with_flag"] = "gfx/hud/hud@objective_british";
			game["hud_allies_base"] = "gfx/hud/hud@b_flag_nobase2";

			game["hud_allies_flag"] 	= "gfx/hud/ctf_flag_b_1.dds";
			game["hud_allies_flag_taken"] 	= "gfx/hud/ctf_flag_b_0.dds";
			
			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "uk_victory";
			game["sound_allies_we_have_enemy_flag"] = "uk_grabbed_enemy_flag";
			game["sound_allies_enemy_has_our_flag"] = "uk_our_flag_taken";
			game["sound_allies_enemy_has_captured"] = "uk_our_flag_captured";  
			game["sound_allies_we_captured"] = "uk_captured_flag";  
			game["sound_allies_flag_has_been_returned"] = "uk_flag_returned";  
			break;
		case "russian":
			game["headicon_carrier_axis"] = "gfx/hud/headicon@ctf_russian.dds";
			game["statusicon_carrier_axis"] = "gfx/hud/hud@ctf_russian.dds";

			game["hud_allies_base_with_flag"] = "gfx/hud/hud@objective_russian";
			game["hud_allies_base"] = "gfx/hud/hud@r_flag_nobase";

			game["hud_allies_flag"] 	= "gfx/hud/ctf_flag_r_1.dds";
			game["hud_allies_flag_taken"] 	= "gfx/hud/ctf_flag_r_0.dds";

			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "ru_victory";
			game["sound_allies_we_have_enemy_flag"] = "ru_grabbed_enemy_flag";
			game["sound_allies_enemy_has_our_flag"] = "ru_our_flag_taken";
			game["sound_allies_we_captured"] = "ru_captured_flag";  
			game["sound_allies_enemy_has_captured"] = "ru_our_flag_captured";  
			game["sound_allies_flag_has_been_returned"] = "ru_flag_returned";  
			break;
		default:		// default is american
			game["headicon_carrier_axis"] = "gfx/hud/headicon@ctf_american.dds";
			game["statusicon_carrier_axis"] = "gfx/hud/hud@ctf_american.dds";

			game["hud_allies_base_with_flag"] = "gfx/hud/hud@objective_american";
			game["hud_allies_base"] = "gfx/hud/hud@a_flag_nobase";

			game["hud_allies_flag"] 	= "gfx/hud/ctf_flag_us_1.dds";
			game["hud_allies_flag_taken"] 	= "gfx/hud/ctf_flag_us_0.dds";


			game["sound_allies_victory_vo"] = "MP_announcer_allies_win";
			game["sound_allies_victory_music"] = "us_victory";
			game["sound_allies_we_have_enemy_flag"] = "us_grabbed_enemy_flag";
			game["sound_allies_enemy_has_our_flag"] = "us_our_flag_taken";
			game["sound_allies_we_captured"] = "us_captured_flag";  
			game["sound_allies_enemy_has_captured"] = "us_our_flag_captured";  
			game["sound_allies_flag_has_been_returned"] = "us_flag_returned";  
			break;
		}

							 
		game["sound_axis_victory_vo"] = "MP_announcer_axis_win";
		game["sound_axis_victory_music"] = "ge_victory";
		game["sound_axis_we_have_enemy_flag"] = "ge_grabbed_enemy_flag";
		game["sound_axis_enemy_has_our_flag"] = "ge_our_flag_taken";
		game["sound_axis_we_captured"] = "ge_captured_flag";  
		game["sound_axis_enemy_has_captured"] = "ge_our_flag_captured";  	
		game["sound_axis_flag_has_been_returned"] = "ge_flag_returned";  

		game["sound_round_draw_vo"] = "MP_announcer_round_draw";

		game["hud_axis_base_with_flag"] = "gfx/hud/hud@objective_german";
		game["hud_axis_base"] = "gfx/hud/hud@g_flag_nobase3";


		precacheShader(game["hud_allies_base_with_flag"]+ ".dds");
		precacheShader(game["hud_allies_base_with_flag"]+ "_up.dds");
		precacheShader(game["hud_allies_base_with_flag"]+ "_down.dds");
		precacheShader(game["hud_allies_base"]+ ".dds");
		precacheShader(game["hud_allies_base"]+ "_up.dds");
		precacheShader(game["hud_allies_base"]+ "_down.dds");
		precacheShader(game["hud_axis_base_with_flag"]+ ".dds");
		precacheShader(game["hud_axis_base_with_flag"]+ "_up.dds");
		precacheShader(game["hud_axis_base_with_flag"]+ "_down.dds");
		precacheShader(game["hud_axis_base"]+ ".dds");
		precacheShader(game["hud_axis_base"]+ "_up.dds");
		precacheShader(game["hud_axis_base"]+ "_down.dds");
		precacheShader("gfx/hud/hud@objective_bel.tga");
		precacheShader("gfx/hud/hud@objective_bel_up.tga");
		precacheShader("gfx/hud/hud@objective_bel_down.tga");

		// set up the hud flag icons

		game["hud_axis_flag"] 		= "gfx/hud/ctf_flag_g_1.dds";
		game["hud_axis_flag_taken"] 	= "gfx/hud/ctf_flag_g_0.dds";
		
		// victory images
		if ( !isDefined( game["hud_allies_victory_image"] ) )
			game["hud_allies_victory_image"] = "gfx/hud/allies_win";
		if ( !isDefined( game["hud_axis_victory_image"] ) )
			game["hud_axis_victory_image"] = "gfx/hud/axis_win";

		precacheShader(game["hud_axis_flag"]);
		precacheShader(game["hud_axis_flag_taken"]);
		precacheShader(game["hud_allies_flag"]);
		precacheShader(game["hud_allies_flag_taken"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);

		// set some values for the icon positions
		game["flag_icons_w"] = 64;
		game["flag_icons_h"] = 32;
		game["flag_icons_spacing"] = 128;
		game["flag_icons_x"] = 190;
		game["flag_icons_y"] = 440;
				
		// the head icon should actually be the opposite teams flag
		game["headicon_carrier_allies"] = "gfx/hud/headicon@ctf_german.dds";
		game["statusicon_carrier_allies"] = "gfx/hud/hud@ctf_german.dds";

		precacheHeadIcon(game["headicon_carrier_allies"]);
		precacheHeadIcon(game["headicon_carrier_axis"]);
		precacheStatusIcon(game["statusicon_carrier_axis"]);
		precacheStatusIcon(game["statusicon_carrier_allies"]);

		maps\mp\gametypes\_teams::precache(); // Precache weapons.
		maps\mp\gametypes\_teams::scoreboard(); // Precache scoreboard menu.

		precacheItem("item_health");

		precachemodel("xmodel/o_ctf_flag_b");
		precachemodel("xmodel/o_ctf_flag_r");
		precachemodel("xmodel/o_ctf_flag_us");
		precachemodel("xmodel/o_ctf_flag_g");
	
		// if fs_copyfiles is set then we are building paks and cache everything
		if ( getcvar("fs_copyfiles") == "1")
		{
			precacheHeadIcon("gfx/hud/headicon@american.dds");
			precacheHeadIcon("gfx/hud/headicon@british.dds");
			precacheHeadIcon("gfx/hud/headicon@russian.dds");
			precacheStatusIcon("gfx/hud/headicon@american.dds");
			precacheStatusIcon("gfx/hud/headicon@british.dds");
			precacheStatusIcon("gfx/hud/headicon@russian.dds");
			
			precacheShader("gfx/hud/hud@objective_british");
			precacheShader("gfx/hud/hud@objective_british_up");
			precacheShader("gfx/hud/hud@objective_british_down");
			precacheShader("gfx/hud/hud@b_flag_nobase2");
			precacheShader("gfx/hud/hud@b_flag_nobase2_up");
			precacheShader("gfx/hud/hud@b_flag_nobase2_down");
			precacheShader("gfx/hud/hud@b_cenflag.dds");
			precacheShader("gfx/hud/hud@b_cenflag_cap.dds");
			precacheShader("gfx/hud/hud@objective_russian");
			precacheShader("gfx/hud/hud@objective_russian_up");
			precacheShader("gfx/hud/hud@objective_russian_down");
			precacheShader("gfx/hud/hud@r_flag_nobase");
			precacheShader("gfx/hud/hud@r_flag_nobase_up");
			precacheShader("gfx/hud/hud@r_flag_nobase_down");
			precacheShader("gfx/hud/hud@r_cenflag.dds");
			precacheShader("gfx/hud/hud@r_cenflag_cap.dds");
			precacheShader("gfx/hud/hud@objective_american");
			precacheShader("gfx/hud/hud@objective_american_up");
			precacheShader("gfx/hud/hud@objective_american_down");
			precacheShader("gfx/hud/hud@a_flag_nobase");
			precacheShader("gfx/hud/hud@a_flag_nobase_up");
			precacheShader("gfx/hud/hud@a_flag_nobase_down");
			precacheShader("gfx/hud/hud@a_cenflag.dds");
			precacheShader("gfx/hud/hud@a_cenflag_cap.dds");
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

	thread ctf();

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
	self.hudelem = [];
	
	if(!isDefined(self.pers["score"]))
		self.pers["score"] = 0;

	if(!isDefined(self.pers["team"]))
		iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	logPrint("J;" + lpselfguid + ";" + lpselfnum + ";" + self.name + "\n");

	self.flag_held = 0;

	// make sure that the rank variable is initialized
	if ( !isDefined( self.pers["rank"] ) )
		self.pers["rank"] = 0;

	// setup teamkiller tracking
	if(!isDefined(self.teamkiller) || self.teamkiller != 0)
		self.teamkiller = 0;
	if(!isDefined(self.teamkillertotal) || self.teamkillertotal != 0)
		self.teamkillertotal = 0;
	if(!isDefined(self.wereteamkilled))
		self.wereteamkilled = 0;		

	// set the cvar for the map quick bind
	self setClientCvar("g_scriptQuickMap", game["menu_viewmap"]);
	
	if(game["state"] == "intermission")
	{
		SpawnIntermission();
		return;
	}
	
	level endon("intermission");

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
			
		if(menu == game["menu_team"] ) // && self.teamkiller != 1)	// check to make sure they're not trying to switch teams while in TK limbo

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

	// make sure the flag gets dropped
	if(isdefined(self.hasflag))
	{
		self.hasflag drop_flag(self);
	}

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

	// make sure the flag gets dropped
	if(isdefined(self.hasflag))
	{
		self.hasflag drop_flag(self);
	}

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
		if(attacker == self) // killed himself
		{
			doKillcam = false;

			if ( !level.roundended && !isdefined (self.autobalance) )
			{
				attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( -1, game["br_points_suicide"]);
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
					attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( -1, game["br_points_teamkill"]);

					// mark the teamkiller as such, punish him next time he dies.
					attacker.teamkiller = 1;
					attacker.teamkillertotal ++;
					self.wereteamkilled = 1;
				}
				else 
				{
					gave_points = false;
					
					// if the dead person was close to the flag then give the killer a defense bonus
					if ( self is_near_flag() )
					{
						// let everyone know
						if ( attacker.pers["team"] == "axis" )
							iprintln(&"GMI_CTF_DEFENDED_AXIS_FLAG", attacker);
						else
							iprintln(&"GMI_CTF_DEFENDED_ALLIES_FLAG", attacker);
						
						attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( 3, 3);
						gave_points = true;
						lpattacknum = attacker getEntityNumber();
						lpattackguid = attacker getGuid();
						logPrint("A;" + lpattackguid + ";" + lpattacknum + ";" + attacker.pers["team"] + ";" + attacker.name + ";" + "ctf_defended" + "\n");
					}
					
					// if the dead person was close to the flag carrier then give the killer a assist bonus
					if ( self is_near_carrier(attacker) )
					{
						// let everyone know
						if ( attacker.pers["team"] == "axis" )
							iprintln(&"GMI_CTF_ASSISTED_AXIS_FLAG_CARRIER", attacker);
						else
							iprintln(&"GMI_CTF_ASSISTED_ALLIES_FLAG_CARRIER", attacker);
						
						attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( 3, 3);
						gave_points = true;
						lpattacknum = attacker getEntityNumber();
						lpattackguid = attacker getGuid();
						logPrint("A;" + lpattackguid + ";" + lpattacknum + ";" + attacker.pers["team"] + ";" + attacker.name + ";" + "ctf_assist" + "\n");
					}
					
					// if they were not given assist or defense points then give normal points
					if ( !gave_points )
					{
						attacker.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( 1, game["br_points_kill"]);
					}
				}
			}
		}
		
		// make sure the score is in an accepatable range
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

		// check for inflictor as well
		if ( !isdefined(eInflictor) )
			self.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( -1, 0 );

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
		killcam_time = level.death_wait_time - 1;
		
		self thread maps\mp\gametypes\_killcam_gmi::DisplayKillCam(who_to_watch, killcam_time, delay);	
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
				self thread printJoinedTeam(self.pers["team"]);
			}
		}
	}
	// If the player is alive and playing during a round, don't give the new weapon for now.  We'll give it to the player next time he spawns.
	else if((self.sessionteam == self.pers["team"] || self.pers["team"] == "spectator" ) && game["matchstarted"] == true && level.roundstarted == true && self.health > 0)
	{
		if(isDefined(self.pers["weapon"]))
			self.nextroundweapon = weapon;
			
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
	self playLocalSound(announcer);
	wait 2.0;
	self playLocalSound(music);
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
	self endon("spawned");
	self endon("end_respawn");
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

	if(self.pers["team"] != "allies" && self.pers["team"] != "axis")
	{
		maps\mp\_utility::error("Team not set correctly on spawning player " + self + " " + self.pers["team"]);
	}

	self thread stopwatch_start("respawn", level.death_wait_time);

	wait (level.death_wait_time);

	self thread spawnPlayer();
}

// ----------------------------------------------------------------------------------
//	SpawnPlayer
//
// 		spawns the player
// ----------------------------------------------------------------------------------
SpawnPlayer()
{
	self notify("spawned");

	resettimeout();

	self.sessionteam = self.pers["team"];
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.friendlydamage = undefined;
	
	// reset teamkiller flag
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
	spawnpoints = getentarray(base_spawn_name, "classname");
	
	// secondary spawn points are used after the first few seconds of the round
	if ( game["matchstarted"] && ((level.roundstarttime + 5000) < getTime()) )
	{
		secondary_spawns =  getentarray(secondary_spawn_name, "classname");
	
		for ( i = 0; i < secondary_spawns.size; i++ )
		{
			
			// if this is targeted by a trigger then it must be a objective spawn so do not just grab it unless that trigger is 
			// owned by this team
			if ( isdefined(secondary_spawns[i].targetname) )
			{
				targeter =  getent(secondary_spawns[i].targetname, "target");
				
				if ( isdefined( targeter ) && isdefined(targeter.team) && targeter.team != self.pers["team"] )
				{
					continue;
				}
			}
		
			spawnpoints = maps\mp\_util_mp_gmi::add_to_array(spawnpoints, secondary_spawns[i]);
		}
	}
	
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
	self.flag_held = 0;
	
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
	
	self setClientCvar("cg_objectiveText", game["ctf_attacker_obj_text"]);
		
	// setup the head and status icons
	self setPlayerIcons();
	
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
	{
		self spawn(origin, angles);
	}
	else
	{
		spawnpointname = "mp_ctf_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}

	updateTeamStatus();

	self.usedweapons = false;

	self setClientCvar("cg_objectiveText", game["ctf_spectator_obj_text"]);
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

	spawnpointname = "mp_ctf_intermission";
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

	announcement(&"GMI_CTF_TIMEEXPIRED");
	
	if(level.allies_cap_count == level.axis_cap_count)
	{
		level thread endRound("draw");
	}
	else if ( level.allies_cap_count > level.axis_cap_count )
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
	if(getCvarInt("scr_debug_ctf") != 1)
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

	game["alliedscore"] = 0;
	setTeamScore("allies", game["alliedscore"]);
	game["axisscore"] = 0;
	setTeamScore("axis", game["axisscore"]);
	
	if (level.battlerank)
	{
		maps\mp\gametypes\_rank_gmi::ResetPlayerRank();
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
 
 	if (roundwinner == "abort")
		game["matchstarted"] = false;
	level.roundstarted = false;
	
	// End threads and remove related hud elements and objectives
	level notify("round_ended");

	if(roundwinner == "allies")
	{
		announcement(&"GMI_CTF_ALLIEDMISSIONACCOMPLISHED");
		
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			players[i] thread Victory_PlaySounds(game["sound_allies_victory_vo"],game["sound_allies_victory_music"]);
		}
		level thread Victory_DisplayImage(game["hud_allies_victory_image"]);
	}
	else if(roundwinner == "axis")
	{
		announcement(&"GMI_CTF_AXISMISSIONACCOMPLISHED");
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
		{
			players[i] playLocalSound(game["sound_round_draw_vo"]);
		}
	}

	if (roundwinner != "reset")
	{
		time = getCvarInt("scr_ctf_endrounddelay");
		
		if ( time < 1 )
			time = 1;
			
		wait(time);		
	}

	winners = "";
	losers = "";

	if(roundwinner == "allies" && !level.mapended)
	{
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
	println("timepassed " + game["timepassed"]);
	
	// call these checks before calling the score resetting
	checkTimeLimit();
	checkScoreLimit();
	
	if(!game["matchstarted"] && roundwinner == "reset" )
	{
		thread resetScores();
		game["roundsplayed"] = 0;
	}
//	else if ( getCvarint("scr_ctf_clearscoreeachround") == 1 && !level.mapended )
//	{
//		thread resetScores();
//	}
	
	if(level.mapended)
		return;

	// if the teams are not full then abort
	if ( !(level.exist["axis"] && level.exist["allies"]) && !getcvarint("scr_debug_ctf") )
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
	
	// if the match is already starting then do not restart
	if (game["matchstarting"] || level.mapended)
		return;
		
	game["matchstarting"] = true;
	
	level thread maps\mp\_util_mp_gmi::make_permanent_announcement(&"GMI_CTF_MATCHSTARTING", "cleanup match starting");			
	
	time = getCvarInt("scr_ctf_startrounddelay");
	
	if ( time < 1 )
		time = 1;

	if ( isDefined(level.victory_image) )
	{
		level.victory_image destroy();
		level.victory_image = undefined;
	}
	
	// give all of the players clocks to count down until the round starts
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if ( isDefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;
			
		player stopwatch_start("match_start", time);
	}
	
	wait (time);

	if ( level.mapended )
		return;
		
	game["matchstarted"] = true;
	game["matchstarting"] = false;
	
	if ( getCvarint("scr_ctf_clearscoreeachround") == 1 && !level.mapended )
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
					
					// make sure we do not do this if the player is carrying the flag
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing" && !isDefined(player.hasflag))
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
					
					// make sure we do not do this if the player is carrying the flag
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing" && !isDefined(player.hasflag))
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
					
					// make sure we do not do this if the player is carrying the flag
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing" && !isDefined(player.hasflag))
					{
						player.headicon = "";
					}
				}
			}
		}

		timelimit = getCvarFloat("scr_ctf_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_ctf_timelimit", "1440");
			}
			
			level.timelimit = timelimit;
			setCvar("ui_ctf_timelimit", level.timelimit);
		}

		scorelimit = getCvarInt("scr_ctf_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_ctf_scorelimit", level.scorelimit);

			if(game["matchstarted"])
				thread checkScoreLimit();
		}

		roundlimit = getCvarInt("scr_ctf_roundlimit");
		if(level.roundlimit != roundlimit)
		{
			level.roundlimit = roundlimit;
			setCvar("ui_ctf_roundlimit", level.roundlimit);

			if(game["matchstarted"])
				checkRoundLimit();
		}

		showoncompass = getCvarInt("scr_ctf_showoncompass");
		if(level.showoncompass != showoncompass)
		{
			level.showoncompass = showoncompass;
			if ( level.axis_flag.moved )
				level.axis_flag update_objective();
			if ( level.allies_flag.moved )
				level.allies_flag update_objective();
		}

		level.roundlength = getCvarFloat("scr_ctf_roundlength");
		if(level.roundlength > 60)
			setCvar("scr_ctf_roundlength", "60");
	
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

	debug = getCvarint("scr_debug_ctf");
	
	// if one team is empty then abort the round
	if(!debug && (oldvalue["allies"] && !level.exist["allies"]) || (oldvalue["axis"] && !level.exist["axis"]))
	{
		level notify("kill_startround");
		level notify("cleanup match starting");
		game["matchstarting"] = false;

		// level may be starting so dont announce the round a draw
		if(level.roundended || !level.roundstarted)
		{		
			return;
		}
		
		announcement(&"GMI_CTF_ROUND_DRAW");
		level thread endRound("abort");
		return;
	}
}

// ----------------------------------------------------------------------------------
//	ctf
//
// 		starts the flags thinking
// ----------------------------------------------------------------------------------
ctf()
{
	level.allies_flag = getent("ctf_flag_allies", "targetname");
	
	if ( !isDefined(level.allies_flag) )
	{
		maps\mp\_utility::error("NO ALLIED FLAG IN MAP");
		return;
	}
	
	// get the mobile version of the flag
	level.allies_flag.mobile_model = getent("ctf_flag_allies_mobile", "targetname");
	if ( !isDefined(level.allies_flag.mobile_model) )
	{
		maps\mp\_utility::error("NO ALLIED MOBILE FLAG IN MAP");
		return;
	}
	level.allies_flag.mobile_model SetContents(0);
	
	level.allies_flag.icon = newHudElem();
	level.allies_flag.icon.alignX = "left";
	level.allies_flag.icon.alignY = "top";
	level.allies_flag.icon.x = game["flag_icons_x"];
	level.allies_flag.icon.y = game["flag_icons_y"];
	level.allies_flag.icon.sort = -50; // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!
	level.allies_flag.icon setShader(game["hud_allies_flag"], game["flag_icons_w"], game["flag_icons_h"]);

	level.allies_flag.mobile_model hide();	
	level.allies_flag.team = "allies";
	level.allies_flag.hudnum = 1;
	level.allies_flag thread ctf_spawn_flag();
	level.allies_flag thread flag_think();

	level.axis_flag = getent("ctf_flag_axis", "targetname");
	
	if ( !isDefined(level.axis_flag) )
	{
		maps\mp\_utility::error("NO AXIS FLAG IN MAP");
		return;
	}
	
	// get the mobile version of the flag
	level.axis_flag.mobile_model = getent("ctf_flag_axis_mobile", "targetname");
	level.axis_flag.mobile_model SetContents(0);

	if ( !isDefined(level.axis_flag.mobile_model) )
	{
		maps\mp\_utility::error("NO ALLIED MOBILE FLAG IN MAP");
		return;
	}

	level.axis_flag.icon = newHudElem();
	level.axis_flag.icon.alignX = "left";
	level.axis_flag.icon.alignY = "top";
	level.axis_flag.icon.x =game["flag_icons_x"]  + game["flag_icons_w"] + game["flag_icons_spacing"];
	level.axis_flag.icon.y = game["flag_icons_y"];
	level.axis_flag.icon.sort = -50; // To fix a stupid bug, where the first flag icon (or the one to the furthest left) will not sort through the capping icon. BAH!
	level.axis_flag.icon setShader(game["hud_axis_flag"], game["flag_icons_w"], game["flag_icons_h"]);

	level.axis_flag.mobile_model hide();	
	level.axis_flag.team = "axis";
	level.axis_flag.hudnum = 2;
	level.axis_flag thread ctf_spawn_flag();
	level.axis_flag thread flag_think();
}

flag_think()
{
	enemy_team = "allies";
	// add the flag base to the radar
	if ( self.team == "allies" )
	{
		objective_add(self.hudnum, "current", self.startorigin, game["hud_allies_base_with_flag"] + ".dds");
	}
	else
	{
		objective_add(self.hudnum, "current", self.startorigin, game["hud_axis_base_with_flag"] + ".dds");
		enemy_team = "axis";
	}
}

ctf_spawn_flag()
{
	targeted = getentarray(self.target, "targetname");
	for(i=0;i<targeted.size;i++)
	{
		if(targeted[i].classname == "mp_gmi_ctf_flag")
		{
			if ( isDefined(self.spawnloc) )
			{
				maps\mp\_utility::error("multiple mp_gmi_ctf_flag for the " + self.team + " team");
				return;
			}
			
			spawnloc = targeted[i];
		}
		else
		if(targeted[i].classname == "trigger_multiple")
		{
			if ( isDefined(self.trigger) )
			{
				maps\mp\_utility::error("to many flag triggers for the " + self.team + " team. There should be one.");
				return;
			}
			
			self.trigger = (targeted[i]);
		}
	}

	if((!isdefined(spawnloc)))
	{
		maps\mp\_utility::error( self.team + " flag does not target a mp_gmi_ctf_flag entity");
		return;
	}
	if(!isdefined(self.trigger))
	{
		maps\mp\_utility::error(self.team + " flag does not target a trigger_multiple");
		return;
	}

	targeted = getentarray(spawnloc.target, "targetname");
	for(i=0;i<targeted.size;i++)
	{
		if(targeted[i].classname == "trigger_multiple")
		{
			if ( isDefined(self.goal) )
			{
				maps\mp\_utility::error("to many goal triggers for the " + self.team + " team.  There should only be one");
				return;
			}
			
			self.goal = (targeted[i]);
		}
	}
	
	if(!isdefined(self.goal))
	{
		maps\mp\_utility::error(self.team + " mp_gmi_ctf_flag does not target a trigger_multiple");
		return;
	}
	
	// get the mobile version of the flag trigger
	targeted = getentarray(self.mobile_model.target, "targetname");
	for(i=0;i<targeted.size;i++)
	{
		if(targeted[i].classname == "trigger_multiple")
		{
			if ( isDefined(self.mobile_trigger) )
			{
				maps\mp\_utility::error("to many flag triggers for the " + self.team + " team. There should be one.");
				return;
			}
			
			self.mobile_trigger = (targeted[i]);
		}
	}
	
	if(!isdefined(self.mobile_trigger))
	{
		maps\mp\_utility::error(self.team + " mobile flag does not target a trigger_multiple");
		return;
	}
	
	
	//move flag to its base position
	self.origin = spawnloc.origin;
	self.startorigin = self.origin;
	self.startangles = self.angles;
	self.trigger.origin = self.origin;
	self.trigger.startorigin = self.trigger.origin;
	self.mobile_model.origin = self.origin;
	self.mobile_trigger.origin = self.origin;
	self.mobile_trigger.startorigin = self.trigger.origin;
	self.carried_by = undefined;

	// turn off the mobile parts
	self.mobile_trigger triggerOff();
	self.mobile_model hide();

	self.moved = false;
	
	self thread ctf_think();
	
	//Set hintstring on the objectives trigger
	wait 0;//required for level script to run and load the level.obj array
}

ctf_think() //each flag model runs this to find it's trigger and goal
{
	level endon("round_ended");
	self endon("timeout");
//	if(isdefined(self.hudnum))
//		objective_position(self.hudnum, self.origin);

	while(1)
	{
		if ( self.moved )
			self.mobile_trigger waittill ("trigger", other);
		else
			self.trigger waittill ("trigger", other);
		
		if(!game["matchstarted"]  )
			return;

		// do not allow people in vehicles to touch flag
		if (other isinvehicle())
			continue;
			
		if((isPlayer(other)) && isAlive(other) && (other.pers["team"] != self.team))
		{

			// let the player know they picked up the flag
			if ( other.pers["team"] == "axis" )
			{
				announcement(&"GMI_CTF_ALLIES_FLAG_TAKEN", other);
			}
			else
			{
				announcement(&"GMI_CTF_AXIS_FLAG_TAKEN", other);
			}

			// play the flag has been grabbed sound
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				
				if ( self.team == "allies" )
				{
					if(player.pers["team"] == "allies")
						player playLocalSound(game["sound_allies_enemy_has_our_flag"]);
					else
						player playLocalSound(game["sound_axis_we_have_enemy_flag"]);
				}
				else
				{
					if(player.pers["team"] == "allies")
						player playLocalSound(game["sound_allies_we_have_enemy_flag"]);
					else
						player playLocalSound(game["sound_axis_enemy_has_our_flag"]);
				}
			}
			
			// update the objective icon to the base but no flag there icon
			if ( self.team == "allies" )
			{
				level.allies_flag.icon setShader(game["hud_allies_flag_taken"], game["flag_icons_w"], game["flag_icons_h"]);
			}
			else
			{
				level.axis_flag.icon setShader(game["hud_axis_flag_taken"], game["flag_icons_w"], game["flag_icons_h"]);
			}
			
			lpselfnum = other getEntityNumber();
			lpselfguid = other getGuid();
			logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + other.pers["team"] + ";" + other.name + ";" + "ctf_take" + "\n");

			self.returned_by = undefined;
			
			self thread hold_flag(other);
			self thread update_objective();
			return;

		}
		// the team that owns the flag can only touch it if it has been moved
		else if((isPlayer(other)) && (other.pers["team"] == self.team) && self.moved)
		{
			if(other.sessionteam == "allies")
			{
				//announcement(&"GMI_CTF_ALLIES_FLAG_RETURNED");
				iprintln(&"GMI_CTF_PLAYER_RETURNED_FLAG_ALLIES",other);
			}
			else if(other.sessionteam == "axis")
			{
				//announcement(&"GMI_CTF_AXIS_FLAG_RETURNED");
				iprintln(&"GMI_CTF_PLAYER_RETURNED_FLAG_AXIS",other);
			}
			
			self.returned_by = other;
				
			lpselfnum = other getEntityNumber();
			lpselfguid = other getGuid();
			logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + other.pers["team"] + ";" + other.name + ";" + "ctf_returned" + "\n");

			// play the flag has been returned sound
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				temp_player = players[i];
				if(temp_player.pers["team"] == "allies" && self.team == "allies")
					temp_player playLocalSound(game["sound_allies_flag_has_been_returned"]);
				else if(temp_player.pers["team"] == "axis" && self.team == "axis")
					temp_player playLocalSound(game["sound_axis_flag_has_been_returned"]);
			}
			
			self reset_flag();
		}
		else
			wait(.5);
	}
}

GetVehicleFlagPos(flagname,flag)
{
	
	switch(self.vehicletype)
	{
		case	"t34_mp":
		case	"sherman_mp":
		case	"su152_mp":
		case	"panzeriv_mp":
		case	"elefant_mp":
			break;

		case	"horch_mp":
			break;
	}


	flag.vehiclemodel = spawn("script_model", self.origin + (0,0,160));
	flag.vehiclemodel.angles = self.angles + (0,0,0);
	flag.vehiclemodel setmodel(flagname);
	flag.vehiclemodel linkto(self,"tag_turret");
	flag.vehiclemodel setcontents(0);
	flag.vehiclemodel notsolid();
}

handle_change_flag()
{
	while(isdefined(self.carried_by))
	{
		wait(0.05);
	}

	self notify("dropped");
	if (isdefined(self.vehiclemodel))
		self.vehiclemodel delete();
}

handle_vehicle_flag()
{
	self thread handle_change_flag();
	self endon("dropped");
	self endon("completed");
	while(1)
	{
		if (isdefined( self.carried_by) && !(self.carried_by isinvehicle()))		
			self.carried_by waittill("vehicle_activated",pos,vehicle);

		vehicle GetVehicleFlagPos(self.holding_flag,self);
		
		if ( isdefined(self.carried_by) && isvalidplayer(self.carried_by) )
		{
			if ( self.carried_by.has_attached )
			{
				self.carried_by.has_attached = false;
				self.carried_by detach(self.holding_flag,level.held_tag_flag);
			}
	
			self thread handle_vehicle_flag_exited();

			// wait until the the guy gets out of the vehicle before continuing
			wait(0.001);
			self.carried_by waittill("vehicle_deactivated",vehicle);
		}
		else
		{
			if (isdefined(self.vehiclemodel))
				self.vehiclemodel delete();
		}
		
		wait(0.001);
	}

}

handle_vehicle_flag_exited()
{
	self.carried_by waittill("vehicle_deactivated",vehicle);
	
	// check for valid player
	if ( isvalidplayer(self.carried_by) )
	{
		self.carried_by.has_attached = true;
		self.carried_by attach(self.holding_flag,level.held_tag_flag, true);
	}
	
	if (isdefined(self.vehiclemodel))
		self.vehiclemodel delete();
}

hold_flag(player) //the objective model runs this to be held by 'player'
{
	self endon("completed");
	self endon("dropped");


	team = player.sessionteam;
	player.hasflag = self;
	self.carried_by = player;
	self.moved = true;
	self hide();
	self.origin = (self.origin[0], self.origin[1], self.origin[2] - 3000 );
	self.mobile_model hide();
	self.mobile_trigger triggerOff();
	self.trigger triggerOff();

	self thread handle_vehicle_flag();

	lpselfnum = player getEntityNumber();
	lpselfguid = player getGuid();
	logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + self.team + ";" + player.name + ";" + "ctf_pickup" + "\n");
	
	self notify("picked up");

	if ( team == "axis")
	{
		player.statusicon = game["statusicon_carrier_axis"];
		self.holding_flag = level.allies_held_flag;
	}
	else
	{
		player.statusicon = game["statusicon_carrier_allies"];
		self.holding_flag = level.axis_held_flag;
	}

	player.has_attached = true;
	player attach(self.holding_flag,level.held_tag_flag,true);
	
	self thread flag_carrier_atgoal_wait(player);
}

flag_carrier_atgoal_wait(player)
{
	level endon("round_ended");
	self endon("dropped");
	while(1)
	{
		self.goal waittill("trigger", other);

		if ( other isinvehicle() )
			continue;
			
		if((other == player) && (isPlayer(player)))
		{
			// make sure the other flag is there
			if ( self.team == "axis" && level.allies_flag.moved )
				continue;
			if ( self.team == "allies" && level.axis_flag.moved )
				continue;
				
			self notify("completed");
			other notify("dropped");

			// get rid of the flag model off the player
			if (player.has_attached == true)
			{
				player.has_attached = false;
				player detach(self.holding_flag,level.held_tag_flag);	
			}
		
			// announce the flag has been grabbed
			if ( other.pers["team"] == "axis" )
			{
				game["axisscore"]++;
				setTeamScore("axis", game["axisscore"]);
				
				announcement(&"GMI_CTF_AXIS_CAPTURED_FLAG");
				iprintln(&"GMI_CTF_PLAYER_CAPTURED_FLAG_AXIS",player);
			}
			else
			{
				game["alliedscore"]++;
				setTeamScore("allies", game["alliedscore"]);
	
				announcement(&"GMI_CTF_ALLIES_CAPTURED_FLAG");
				iprintln(&"GMI_CTF_PLAYER_CAPTURED_FLAG_ALLIES",player);
			}

			// play the flag has been captured sound
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				temp_player = players[i];
				if(player.pers["team"] == "allies")
				{
					if ( temp_player.pers["team"] == "allies")
					{
						temp_player playLocalSound(game["sound_allies_we_captured"]);
					}
					else
						temp_player playLocalSound(game["sound_axis_enemy_has_captured"]);
				}
				else
				{
					if ( temp_player.pers["team"] == "allies")
						temp_player playLocalSound(game["sound_allies_enemy_has_captured"]);
					else
						temp_player playLocalSound(game["sound_axis_we_captured"]);
				}
			}
			
			// set the team cap count up one
			if ( other.pers["team"] == "axis" )
			{
				level.axis_cap_count++;
			}
			else
			{
				level.allies_cap_count++;
			}
			
			// give the team points
			GivePointsToTeam( player.pers["team"],  maps\mp\gametypes\_scoring_gmi::GetPoints( 5, 5));

			// give out points to the capper
			if(isValidPlayer(player))
			{
				player.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( 8, 8 );
				player.score = player.pers["score"];
			}
			
			if ( self.team == "axis" )
				other_flag = level.allies_flag;
			else
				other_flag = level.axis_flag;

			lpselfnum = player getEntityNumber();
			lpselfguid = player getGuid();
			logPrint("A;" + lpselfguid + ";" + lpselfnum + ";" + player.pers["team"] + ";" + player.name + ";" + "ctf_captured" + "\n");

			// give assist points
			if (isDefined(other_flag.returned_by) && isValidPlayer(other_flag.returned_by) && other_flag.returned_by != player)
			{
				// let everyone know
				if ( other_flag.returned_by.pers["team"] == "axis" )
					iprintln(&"GMI_CTF_ASSISTED_AXIS_FLAG_CARRIER", other_flag.returned_by);
				else
					iprintln(&"GMI_CTF_ASSISTED_ALLIES_FLAG_CARRIER", other_flag.returned_by);
						
				other_flag.returned_by.pers["score"] += maps\mp\gametypes\_scoring_gmi::GetPoints( 3, 3);
				other_flag.returned_by = other_flag.returned_by.pers["score"];
			}
			
			self.returned_by = undefined;
			
			num = (16 - (self.hudnum));
			
			// remove the carrying flag message from the player
			if((isdefined(player.hudelem)) && (isdefined(player.hudelem[num])))
				player.hudelem[num] destroy();
				
			//move flag to its base position
			self reset_flag();
		
			// clean up the player
			if(isPlayer(player))
			{
				player.hasflag = undefined;
				player setPlayerIcons();
			}
						
			self thread ctf_think();
		
			// check the score to see if we need to end the round
			thread checkScoreLimit();
			return;
		}
		else
		{
			wait .05;
		}
	}
}

reset_flag()
{
	self notify("reset");
	
	//move flag to its base position
	self.trigger.origin = self.trigger.startorigin;
	self.origin = self.startorigin;
	self.angles = self.startangles;
	self.moved = false;
	self show();
	
	self.mobile_trigger.origin = self.trigger.startorigin;
	self.mobile_trigger triggerOff();
	self.mobile_model hide();

	self.carried_by = undefined;

	if ( level.showoncompass != 0 && isdefined(self.objnum) )
	{
		objective_delete( self.objnum );
		self.objnum = undefined;
	}
	// update the objective icon
	if ( self.team == "allies" )
	{
		objective_icon(self.hudnum,game["hud_allies_base_with_flag"] + ".dds");
		level.allies_flag.icon setShader(game["hud_allies_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	}
	else
	{
		objective_icon(self.hudnum,game["hud_axis_base_with_flag"] + ".dds");
		level.axis_flag.icon setShader(game["hud_axis_flag"], game["flag_icons_w"], game["flag_icons_h"]);
	}
	
}

drop_flag(player)
{
	if (isdefined(player))
	{
		if (player.has_attached == true)
		{
			player.has_attached = false;
			player detach(self.holding_flag,level.held_tag_flag);	
		}
	}

	if(isPlayer(player))
	{
		num = (16 - (self.hudnum));
		
		if((isdefined(player.hudelem)) && (isdefined(player.hudelem[num])))
			player.hudelem[num] destroy();
	}
	loc = (player.origin + (0, 0, 25));

	// get the drop position
	plant = player maps\mp\_utility::getPlant();
	end_loc = plant.origin;

	if(distance(loc, end_loc) > 0)
	{
		self.mobile_model.origin = loc;
		self.mobile_model.angles = plant.angles;
		self.mobile_model show();
		speed = (distance(loc, end_loc) / 250);
		if(speed > 0.4)
		{
			self.mobile_model moveto(end_loc, speed, 0.1, 0.1);
			self.mobile_model waittill("movedone");
			self.mobile_trigger.origin = end_loc;
		}
		else
		{
			self.mobile_model.origin = end_loc;
			self.mobile_model show();
			self.mobile_trigger.origin = end_loc;
		}
	}
	else
	{
		self.mobile_model.origin = end_loc;
		self.mobile_model show();
		self.mobile_trigger.origin = end_loc;
	}

	// check if its inside a vehicle
	vehicles = getentarray("script_vehicle","classname");

	for(i=0;i<vehicles.size;i++)
	{
		if ( self.mobile_model istouching(vehicles[i]) )
		{
			valid_origin =  vehicles[i] getdismountspot();
			
			self.mobile_model.origin = valid_origin;
			self.mobile_model.angles = plant.angles;  // just use the angles from the plant
			self.mobile_trigger.origin = valid_origin;
			break;
		}
	}
	
	self.mobile_model show();

	if(isPlayer(player))
	{
		player.hasflag = undefined;
		player setPlayerIcons();
	}

	for(i = 1; i < 16; i++)
	{
		if((isdefined(self.hudelem)) && (isdefined(self.hudelem[i])))
			self.hudelem[i] destroy();
	}

	//check if it's in a minefield
	In_Mines = 0;
	for(i = 0; i < level.minefield.size; i++)
	{
		if(self.mobile_model istouching(level.minefield[i]))
		{
			In_Mines = 1;
			break;
		}
	}

	In_Water = 0;
	for(i = 0; i < level.deepwater.size; i++)
	{
		if(self.mobile_model istouching(level.deepwater[i]))
		{
			In_Water = 1;
			break;
		}
	}
	if(In_Mines == 1)
	{
		if((!isdefined(level.lastdropper)) || (level.lastdropper != player))
		{
			level.lastdropper = player;
			iprintln(&"GMI_CTF_FLAG_INMINES", player);
		}
		
		self reset_flag();
	}
	else if(In_Mines == 1)
	{
		if((!isdefined(level.lastdropper)) || (level.lastdropper != player))
		{
			level.lastdropper = player;
			iprintln(&"GMI_CTF_FLAG_INWATER", player);
		}
		
		self reset_flag();
	}
	else
	{
		self thread flag_timeout();

		if ( self.team == "allies" )
			iprintln(&"GMI_CTF_ALLIES_FLAG_DROPPED");
		else
			iprintln(&"GMI_CTF_AXIS_FLAG_DROPPED");
	}

	self notify("dropped");
	self thread ctf_think();
}

flag_timeout()
{
	self endon("picked up");
	self endon("reset");
	flag_timeout = 20;
	wait flag_timeout;
	
	if ( self.team == "axis")
	{
		announcement(&"GMI_CTF_AXIS_FLAG_TIMEOUT_RETURNING");
	}
	else
	{
		announcement(&"GMI_CTF_ALLIES_FLAG_TIMEOUT_RETURNING");
	}
	
	// play the flag has been returned sound
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		temp_player = players[i];
		if(temp_player.pers["team"] == "allies" && self.team == "allies")
			temp_player playLocalSound(game["sound_allies_flag_has_been_returned"]);
		else if(temp_player.pers["team"] == "axis" && self.team == "axis")
			temp_player playLocalSound(game["sound_axis_flag_has_been_returned"]);
	}
	
	self.returned_by = undefined;

	self reset_flag();
	self notify("timeout");
	self thread ctf_think();
}

get_flag_position()
{
	origin = self.mobile_trigger.origin;
	
	// set the origin to be the carriers position if being carried
	if ( isdefined(self.carried_by) && isalive(self.carried_by))
	{
		origin = self.carried_by.origin;
	}
	return origin;
}

update_objective()
{
	self endon("completed");
	self endon("reset");
	count1 = 1;
	
	// 0 is off, 1 is immediatly, greater then 1 is the position will be shown after that time in secs goes by
	show_time = level.showoncompass;
	
	if(show_time == 0)
	{
		// make sure it was not on already
		if ( isDefined(self.objnum) && self.objnum )
		{
			objective_delete( self.objnum );
			self.objnum = undefined;
		}
		return;
	}
	
	// if show_time is greater then 0 then wait that number of seconds before displaying on radar for the first time	
	if ( show_time > 0 )
	{ 
		wait(show_time * 60);
	}		
	
	origin = get_flag_position();
	
	objnum = self.hudnum + 2;
	if ( !isDefined(self.objnum) )
	{
		self.objnum = objnum;
		objective_add(objnum, "current", origin, "gfx/hud/hud@objective_bel.tga");
		objective_icon(objnum,"gfx/hud/hud@objective_bel.tga");
		objective_team(objnum,"none");
	}
	objective_position(objnum, origin);
	lastobjpos = origin;
	newobjpos = origin;
	
	while(1)
	{
		wait(1);
		if(count1 != level.PositionUpdateTime)
			count1++;
		else
		{
			count1 = 1;
			origin = get_flag_position();
			lastobjpos = newobjpos;
			newobjpos = (((lastobjpos[0] + origin[0]) * 0.5), ((lastobjpos[1] + origin[1]) * 0.5), ((lastobjpos[2] + origin[2]) * 0.5));
			objective_position(objnum, newobjpos);
		}
	}
}

display_holding_flag(flag_ent)
{
	num = (16 - (flag_ent.hudnum));

	if(num > 16)
		return;
	
	offset = (150 + (flag_ent.hudnum * 15));
	
	self.hudelem[num] = newClientHudElem(self);
	self.hudelem[num].alignX = "right";
	self.hudelem[num].alignY = "middle";
	self.hudelem[num].x = 635;
	self.hudelem[num].y = (550 - offset);

	if ( self.sessionteam == "axis" )
	{
		self.hudelem[num] setText(&"GMI_CTF_U_R_CARRYING_AXIS");
	}
	else
	{
		self.hudelem[num] setText(&"GMI_CTF_U_R_CARRYING_ALLIES");		
	}

	self.stance_flag = newClientHudElem(self);
	self.stance_flag.alignX = "left";
	self.stance_flag.alignY = "top";
	self.stance_flag.x = 100;
	self.stance_flag.y = 434.375;
	self.color = (1,1,1);
	while(isDefined(self.hasflag))
	{
		x = self getstance();
		switch(x)
		{
			case	"sprint":	sName = "gfx/hud/ctf_stance_sprint.dds";
						break;
			case	"stand":	sName = "gfx/hud/ctf_stance_stand.dds";
						break;
			case	"crouch":	sName = "gfx/hud/ctf_stance_crouch.dds";
						break;
			case	"prone":	sName = "gfx/hud/ctf_stance_prone.dds";
						break;
		}

		
		if (self isinvehicle())
		{
			self.stance_flag.x = -64;
			self.stance_flag.y = -64;
		}
		else
		{
			self.stance_flag.x = 100;
			self.stance_flag.y = 434.375;
			self.stance_flag setShader(sName,40,40);
		}
		wait(0.5);
	}
	self.stance_flag destroy();

}

triggerOff()
{
	self.origin = (self.origin - (0, 0, 10000));
}

client_print(flag, text, s)
{
	num = (16 - flag.hudnum);

	if(num > 16)
		return;

	self notify("stop client print");
	self endon("stop client print");

	//if((isdefined(self.hudelem)) && (isdefined(self.hudelem[num])))
	//	self.hudelem[num] destroy();
	
	for(i = 1; i < 16; i++)
	{
		if((isdefined(self.hudelem)) && (isdefined(self.hudelem[i])))
			self.hudelem[i] destroy();
	}
	
	self.hudelem[num] = newClientHudElem(self);
	self.hudelem[num].alignX = "center";
	self.hudelem[num].alignY = "middle";
	self.hudelem[num].x = 320;
	self.hudelem[num].y = 200;

	if(isdefined(s))
	{
		self.hudelem[num].label = text;
		self.hudelem[num] setText(s);
	}
	else
		self.hudelem[num] setText(text);

	wait 3;
	
	if((isdefined(self.hudelem)) && (isdefined(self.hudelem[num])))
		self.hudelem[num] destroy();
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
		scorelimit = getCvarint("scr_ctf_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;

			if(game["matchstarted"])
				thread checkScoreLimit();
		}

		// end the round if there are not enough people playing
		if (game["matchstarted"] == true && level.roundstarted == true)
		{
			debug = getCvarint("scr_debug_ctf");
			
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
//	setPlayerIcons
//
// 	 	sets the appropriate icons for the player
// ----------------------------------------------------------------------------------
setPlayerIcons()
{
	if(level.drawfriend == 1)
	{
		// battle rank takes precidence
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
			else if(self.pers["team"] == "axis")
			{
				self.headicon = game["headicon_axis"];
				self.headiconteam = "axis";
			}
			else
			{
				self.headicon = "";
			}
			
			self.statusicon = "";
		}
	}
	else
	{
		if(level.battlerank)
		{
			self.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(self);
		}
		else
		{
			self.statusicon = "";
		}
		self.headicon = "";
		self.headiconteam = "none";
	}
}

// ----------------------------------------------------------------------------------
//	is_near_flag
//
// 	 	checks if the player is near the enemy flag
// ----------------------------------------------------------------------------------
is_near_flag()
{
	// determine the opposite teams flag
	if ( self.pers["team"] == "allies" )
		flag = level.axis_flag;
	else
		flag = level.allies_flag;	
		
	// if the flag is not at the base then return false
	if ( flag.moved )
		return false;
		
	dist = distance(flag.origin, self.origin);
	
	// if they were close to the flag then return true
	if ( dist < 750 )
		return true;
		
	return false;
}

// ----------------------------------------------------------------------------------
//	is_near_flag
//
// 	 	checks if the player is near the enemy flag carrier
// ----------------------------------------------------------------------------------
is_near_carrier(attacker)
{
	// determine the teams flag
	if ( self.pers["team"] == "axis" )
		flag = level.axis_flag;
	else
		flag = level.allies_flag;	
		
	// if the flag is at the base then return false
	if ( !flag.moved )
		return false;
	
	// if the attacker is the carrier then return false
	if ( attacker == flag.carried_by )
		return false;
		
	// if the attacker is the carrier then return false
	if ( !isdefined(flag.carried_by) || !isAlive(flag.carried_by) || !isValidPlayer(flag.carried_by) )
		return false;
		
	dist = distance(self.origin, flag.carried_by.origin);
	
	// if they were close to the flag carrier then return true
	if ( dist < 750 )
		return true;
		
	return false;
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

// ----------------------------------------------------------------------------------
//	adds a ent to the array
// ----------------------------------------------------------------------------------
merge_arrays(array1, array2)
{
	if(!isdefined(array2))
		return array1;
		
	if(!isdefined(array1))
		array1 = [];
	
	
	for ( i = 0; i < array2.size; i++ )
	{
		array1[array1.size] = array2[i];
	}
	
	return array1;	
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
