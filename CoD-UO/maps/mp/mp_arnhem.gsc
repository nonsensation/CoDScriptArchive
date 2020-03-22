main()
{
	setCullFog (1000, 14555, 0.675, 0.75, 0.86, 0);
	ambientPlay("ambient_mp_carentan");

	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	maps\mp\_load::main();
	level thread maps\mp\mp_arnhem_fx::main();
//	maps\mp\_t34_gmi::mainnoncamo();
//	maps\mp\_tankdrive_gmi::main();

	thread precacheStrings();

	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "airborne";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["dom_layoutimage"] = "mp_arnhem_dom";
	game["ctf_layoutimage"] = "mp_arnhem_ctf";
	game["layoutimage"] = "mp_arnhem";


	//domination settings
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["cap_attackers_obj_text"] = (&"GMI_DOM_OBJ_ARNHEM_OBJ_ATTACKER");
	game["cap_defenders_obj_text"] = (&"GMI_DOM_OBJ_ARNHEM_OBJ_DEFENDER");
	game["cap_spectator_obj_text"] = (&"GMI_DOM_OBJ_ARNHEM_OBJ_SPECTATOR");
	game["cap_attackers_intro_text"] = (&"GMI_DOM_OBJ_ARNHEM_SPAWN_ATTACKER");
	game["cap_defenders_intro_text"] = (&"GMI_MP_OBJ_ARNHEM_SPAWN_DEFENDER");

	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_ARNHEM_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_ARNHEM_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_ARNHEM_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_ARNHEM_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_ARNHEM_SPAWN_DEFENDER");

	game["compass_range"] = 2816;				//How far the compass is zoomed in
	game["sec_type"] = "destroy";				//What type of secondary objective
	
	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_arnhem_b.dds";
	game["hud_axis_victory_image"] 	= "gfx/hud/hud@mp_victory_arnhem_g.dds";

	//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 3;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_ARNHEM");	// the name of the flag (localized in gmi_mp.str)

	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_ARNHEM");

	flag3 = getent("flag3","targetname");
	flag3.script_timer = 7;
	flag3.description = (&"GMI_DOM_FLAG3_MP_ARNHEM");

	flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_ARNHEM");

	flag5 = getent("flag5","targetname");
	flag5.script_timer = 3;
	flag5.description = (&"GMI_DOM_FLAG5_MP_ARNHEM");

	//Radios at flag2 and flag4
	game["neutralradio"] = ("radio_neutral");
	game["alliesradio"] = ("radio_british");
	game["axisradio"] = ("radio_german");
			
	// FOR BUILDING PAK FILES ONLY
	if (getcvar("fs_copyfiles") == "1")
	{
		precacheShader(game["dom_layoutimage"]);
		precacheShader(game["ctf_layoutimage"]);
		precacheShader(game["layoutimage"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
	}

	wait 0.5;
}

precacheStrings()
{
	//Retrieval
	precacheString(&"GMI_MP_RE_OBJ_ARNHEM_ATTACKER");
	precacheString(&"GMI_MP_RE_OBJ_ARNHEM_DEFENDER");
	precacheString(&"GMI_MP_RE_OBJ_ARNHEM_SPECTATOR");
	precacheString(&"GMI_MP_RE_OBJ_ARNHEM_SPAWN_ATTACKER");
	precacheString(&"GMI_MP_RE_OBJ_ARNHEM_SPAWN_DEFENDER");

	//Domination
	precacheString(&"GMI_DOM_OBJ_ARNHEM_OBJ_ATTACKER");
	precacheString(&"GMI_DOM_OBJ_ARNHEM_OBJ_DEFENDER");
	precacheString(&"GMI_DOM_OBJ_ARNHEM_OBJ_SPECTATOR");
	precacheString(&"GMI_DOM_OBJ_ARNHEM_SPAWN_ATTACKER");
	precacheString(&"GMI_DOM_OBJ_ARNHEM_SPAWN_DEFENDER");
}
