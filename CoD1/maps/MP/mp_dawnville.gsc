main()
{
	setCullFog (0, 8000, .32, .36, .40, 0);
	ambientPlay("ambient_mp_dawnville");

	maps\mp\_load::main();
	maps\mp\mp_dawnville_fx::main();
	
	game["allies"] = "american";
	game["axis"] = "german";

	game["american_soldiertype"] = "airborne";
	game["american_soldiervariation"] = "normal";
	game["german_soldiertype"] = "fallschirmjagercamo";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["layoutimage"] = "mp_dawnville";

	//retrival settings
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "axis";
	game["re_defenders"] = "allies";
	game["re_attackers_obj_text"] = (&"RE_OBJ_DAWNVILLE_OBJ_ATTACKER");
	game["re_defenders_obj_text"] = (&"RE_OBJ_DAWNVILLE_OBJ_DEFENDER");
	game["re_spectator_obj_text"] = (&"RE_OBJ_DAWNVILLE_OBJ_SPECTATOR");
	game["re_attackers_intro_text"] = (&"RE_OBJ_DAWNVILLE_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"RE_OBJ_DAWNVILLE_SPAWN_DEFENDER");
}
