//mp_sicily

main()
{
	//setCullFog (500, 7000, .61, .66, .68, 0 );
	ambientPlay("ambient_day");

	// sound for the lampposts.  Needs to be before calling _treefall_gmi
	game["treefall_sound"] = "streetlamp_fall";
	
	maps\mp\_load::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_treefall_gmi::main();

	game["allies"] = "american";
	game["axis"] = "german";

	game["british_soldiertype"] = "airborne";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_cassino.dds";

	game["sec_type"] = "destroy";				//What type of secondary objective

        //retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";

        game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_CASSINO_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_CASSINO_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_CASSINO_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_CASSINO_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_CASSINO_SPAWN_DEFENDER");

	game["hud_allies_victory_image"] = "gfx/hud/hud@mp_victory_cassino_us.dds";

        game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_cassino_g.dds";

	game["dom_layoutimage"] = "mp_cassino_dom.dds";

        game["ctf_layoutimage"] = "mp_cassino_ctf.dds";

	
	thread flag_def();
	
	// FOR BUILDING PAK FILES ONLY
	if (getcvar("fs_copyfiles") == "1")
	{
		precacheShader(game["dom_layoutimage"]);
		precacheShader(game["ctf_layoutimage"]);
		precacheShader(game["layoutimage"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
	}


}

flag_def()
{
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 3;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_CASSINO");	// the name of the flag (localized in gmi_mp.str)

	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_CASSINO");

	flag3 = getent("flag3","targetname");
	flag3.script_timer = 7;
	flag3.description = (&"GMI_DOM_FLAG3_MP_CASSINO");

	flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_CASSINO");

	flag5 = getent("flag5","targetname");
	flag5.script_timer = 3;
	flag5.description = (&"GMI_DOM_FLAG5_MP_CASSINO");
}
