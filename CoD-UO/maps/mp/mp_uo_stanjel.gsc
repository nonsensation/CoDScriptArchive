main()
{
	setCullFog (1500, 10000, 0.78, 0.84, 0.86, 0);
	ambientPlay("ambient_stanjel");

	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	maps\mp\_load::main();
	level thread maps\mp\mp_uo_stanjel_fx::main();
	maps\mp\_noprone::main();
	maps\mp\_rotate::main();
	maps\mp\_birdbush::main();

	game["allies"] = "russian";
	game["axis"] = "german";

	game["russian_soldiertype"] = "veteran";
	game["russian_soldiervariation"] = "normal";
	game["german_soldiertype"] = "fallschirmjagercamo";
	game["german_soldiervariation"] = "normal";

	game["layoutimage"] = "mp_stanjel.dds";
	game["dom_layoutimage"] = "mp_stanjel_dom.dds";
	game["ctf_layoutimage"] = "mp_stanjel_ctf.dds";

	game["hud_allies_victory_image"] = "gfx/hud/hud@mp_victory_stanjel_r.dds";
	game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_stanjel_g.dds";


	game["attackers"] = "allies";
	game["defenders"] = "axis";

	

	//wait 0.1;
	setcvar("scr_allow_allied_secondary", "1");
	setcvar("scr_allow_axis_secondary", "1");


	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
      game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_SICILY_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_SICILY_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_SICILY_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_SICILY_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_SICILY_SPAWN_DEFENDER");
	

	//retrival settings
	//level.obj["losbook"] = (&"RE_OBJ_CODE_BOOK");					//script_game_objective 
	//game["re_attackers"] = "allies";
	//game["re_defenders"] = "axis";
	//game["re_attackers_obj_text"] = "Capture the code book, eliminate all resistance.";
	//game["re_defenders_obj_text"] = "Defend the code book at all cost.";
	//game["re_spectator_obj_text"] = "Allies: Must capture the code book";
	//game["re_attackers_intro_text"] = "Capture the code book to help foil any German counter attacks.";
	//game["re_defenders_intro_text"] = "Defend the code book from falling into allied hands.\nThe future of the Third Reich depends upon it.";

	//hq settings
	if (getcvar("g_gametype") != "hq")
	{
		radios = getentarray ("hqradio","targetname");
		for (i=0;i<radios.size;i++)
			//radios[i] hide();
			radios[i] delete();
	}

//thread flag_def();
//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	if (isdefined(flag1))
	{
		flag1.script_timer = 5;					// how many seconds a capture takes with one player
		flag1.description = (&"GMI_DOM_FLAG1_MP_STANJEL");	// the name of the flag (localized in gmi_mp.str)
	}

      	flag2 = getent("flag2","targetname");

	if (isdefined(flag2))
	{
		flag2.script_timer = 5;
		flag2.description = (&"GMI_DOM_FLAG2_MP_STANJEL");
	}
	flag3 = getent("flag3","targetname");

	if (isdefined(flag3))
	{
		flag3.script_timer = 5;
		flag3.description = (&"GMI_DOM_FLAG3_MP_STANJEL");
	}
      	flag4 = getent("flag4","targetname");
	if (isdefined(flag4))
	{
		flag4.script_timer = 5;
		flag4.description = (&"GMI_DOM_FLAG4_MP_STANJEL");
	}
      	flag5 = getent("flag5","targetname");
	if (isdefined(flag5))
	{
		flag5.script_timer = 5;
		flag5.description = (&"GMI_DOM_FLAG5_MP_STANJEL");
	}


	// FOR BUILDING PAK FILES ONLY
	if (getcvar("fs_copyfiles") == "1")
	{
		precacheShader(game["dom_layoutimage"]);
		precacheShader(game["ctf_layoutimage"]);
//		precacheShader(game["bas_layoutimage"]);
		precacheShader(game["layoutimage"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
	}
}

//flag_def()
//{
	//flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	//flag1.script_timer = 3;					// how many seconds a capture takes with one player
	//flag1.description = (&"GMI_DOM_FLAG1_MP_ITALY");	// the name of the flag (localized in gmi_mp.str)

	//flag2 = getent("flag2","targetname");
	//flag2.script_timer = 5;
	//flag2.description = (&"GMI_DOM_FLAG2_MP_ITALY");

	//flag3 = getent("flag3","targetname");
	//flag3.script_timer = 7;
	//flag3.description = (&"GMI_DOM_FLAG3_MP_KURSK");

	//flag4 = getent("flag4","targetname");
	//flag4.script_timer = 5;
	//flag4.description = (&"GMI_DOM_FLAG4_MP_ITALY");

	//flag5 = getent("flag5","targetname");
	//flag5.script_timer = 3;
	//flag5.description = (&"GMI_DOM_FLAG5_MP_ITALY");
//}
