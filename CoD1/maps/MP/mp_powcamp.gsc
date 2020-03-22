main()
{
	setCullFog (0, 8000, .32, .36, .40, 0);
	ambientPlay("ambient_mp_powcamp");
	
	maps\mp\_load::main();
	maps\mp\mp_powcamp_fx::main();
	
	game["allies"] = "russian";
	game["axis"] = "german";

	game["russian_soldiertype"] = "conscript";
	game["russian_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_powcamp";

	//retrival settings
	level.obj["Camp Records"] = (&"RE_OBJ_CAMP_RECORDS");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_POWCAMP_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_POWCAMP_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_POWCAMP_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_POWCAMP_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_POWCAMP_SPAWN_DEFENDER");
}



