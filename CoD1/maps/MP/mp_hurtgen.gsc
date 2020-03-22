main()
{
	setCullFog (0, 5000, .32, .36, .40, 0 );
	ambientPlay("ambient_mp_hurtgen");

	maps\mp\_load::main();
	maps\mp\mp_hurtgen_fx::main();

	game["allies"] = "american";
	game["axis"] = "german";

	game["american_soldiertype"] = "airborne";
	game["american_soldiervariation"] = "winter";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "winter";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_hurtgen";

	//retrival settings
	level.obj["V-2 Rocket Schedule"] = (&"RE_OBJ_ROCKET_SCHEDULE");
	level.obj["Artillery Map"] = (&"RE_OBJ_ARTILLERY_MAP");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_HURTGEN_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_HURTGEN_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_HURTGEN_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_HURTGEN_SPAWN_ATTAKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_HURTGEN_SPAWN_DEFENDER");
}
