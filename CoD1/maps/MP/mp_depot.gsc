main()
{
	setCullFog (0, 7500, .32, .36, .40, 0);
	ambientPlay("ambient_mp_depot");

	maps\mp\_load::main();
	maps\mp\mp_depot_fx::main();

	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "airborne";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_depot";

	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_DEPOT_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_DEPOT_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_DEPOT_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_DEPOT_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_DEPOT_SPAWN_DEFENDER");
}
