main()
{
	setExpFog(0.00001, 0, 0, 0, 0);
	ambientPlay("ambient_mp_chateau");

	maps\mp\_load::main();
	//maps\mp\mp_chateau_fx::main();

	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "airborne";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_chateau";

	//retrival settings
	level.obj["Spy Records"] = (&"RE_OBJ_SPY_RECORDS");
	level.obj["Artillery Map"] = (&"RE_OBJ_ARTILLERY_MAP");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_CHATEAU_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_CHATEAU_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_CHATEAU_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_CHATEAU_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_CHATEAU_SPAWN_DEFENDER");
}
