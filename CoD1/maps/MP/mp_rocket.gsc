main()
{
	setCullFog (0, 4500, .32, .36, .40, 0);
	ambientPlay("ambient_mp_rocket");

	maps\mp\_load::main();
	maps\mp\mp_rocket_fx::main();

	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "commando";
	game["british_soldiervariation"] = "winter";
	game["german_soldiertype"] = "waffen";
	game["german_soldiervariation"] = "winter";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_rocket";

	//retrival settings
	level.obj["Artillery Map"] = (&"RE_OBJ_ARTILLERY_MAP");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"RE_OBJ_ROCKET_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_ROCKET_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_ROCKET_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_ROCKET_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_ROCKET_SPAWN_DEFENDER");
}





