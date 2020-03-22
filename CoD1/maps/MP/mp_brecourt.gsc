main()
{
	setCullFog (0, 13500, .32, .36, .40, 0);
	ambientPlay("ambient_mp_brecourt");
	
	maps\mp\_load::main();
	maps\mp\mp_dawnville_fx::main();
	
	game["allies"] = "american";
	game["axis"] = "german";

	game["american_soldiertype"] = "airborne";
	game["american_soldiervariation"] = "normal";
	game["german_soldiertype"] = "fallschirmjagergrey";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_brecourt";

	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_BRECOURT_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_BRECOURT_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_BRECOURT_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_BRECOURT_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_BRECOURT_SPAWN_DEFENDER");
}
