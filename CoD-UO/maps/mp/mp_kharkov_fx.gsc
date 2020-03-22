main()
{
	precacheFX();
    	spawnWorldFX();

	// Distant lights
//	wait(0.5);
//	level.dist_light_min_delay = 5;
//	level.dist_light_max_delay = 15;
//	level thread Ambience_Setup();
}

precacheFX()
{
// SMOKE ==============================//
//	level._effect["smoke1"]			= loadfx ("fx/map_mp/mp_smoke_high.efx");
//	level._effect["smoke2"]			= loadfx ("fx/map_mp/mp_smoke_plume_debree.efx");

// FIRE ===============================//
	level._effect["building_fire_smoke4"]	= loadfx ("fx/map_mp/mp_building_fire_big_4ts.efx");

// Atmosphere ==========================//
//	level._effect["distant_light"]		= loadfx ("fx/map_mp/mp_mortar_mz.efx");
}

spawnWorldFX()
{
	wait(1);
// REF ==============================//
      	//     loopfxthread("name of effect", (x,y,z),    repeat time, (x,y,z), start,      stop,     timeout, cull dist);

// SMOKE ==============================//
//	wait(0.1);
//     	thread maps\mp\_fx::loopfxthread("smoke1", 		(4173, -6787, 639), 5, undefined, undefined, 6144);
//	wait(0.2);
//     	thread maps\mp\_fx::loopfxthread("smoke1", 		(768, -1472, 640), 5, undefined, undefined, 6144);
//	wait(0.3);
//     	thread maps\mp\_fx::loopfxthread("smoke1", 		(-1984, -8640, 576), 5, undefined, undefined, 6144);
//	wait(0.2);
//     	thread maps\mp\_fx::loopfxthread("smoke1", 		(4096, -1792, 576), 5, undefined, undefined, 6144);
//	wait(0.3);
//     	thread maps\mp\_fx::loopfxthread("smoke2", 		(1984, 3584, 0), 5, undefined, undefined, 4096);
//	wait(0.1);
//     	thread maps\mp\_fx::loopfxthread("smoke2", 		(-384, -5184, 0), 5, undefined, undefined, 4096);

// FIRE ===============================//
	wait(0.2);
      	thread maps\mp\_fx::loopfxthread("building_fire_smoke4", (1376, -1600, -32), 5, undefined, undefined, 2048);
	wait(0.3);
      	thread maps\mp\_fx::loopfxthread("building_fire_smoke4", (2048, 3392, 376), 5, undefined, undefined, 4096);
	wait(0.1);
      	thread maps\mp\_fx::loopfxthread("building_fire_smoke4", (-110, -4496, -42), 5, undefined, undefined, 4096);
	wait(0.2);
      	thread maps\mp\_fx::loopfxthread("building_fire_smoke4", (3776, -1024, -16), 5, undefined, undefined, 4096);
}


// Grabs all of distant lights and has them run the think function.
//Ambience_Setup()
//{
//	orgs = getentarray("distant_light","targetname");
//	for(i=0;i<orgs.size;i++)
//	{
//		orgs[i] thread Random_Distant_Light_Think();
//		wait 0.05;
//	}
//}

// Think function for distant_light script_origins.
// Randomly plays the lights in the sky.
//Random_Distant_Light_Think()
//{
//	level endon("stop_distant_lights");
//
//	while(1)
//	{
//		range = level.dist_light_max_delay - level.dist_light_min_delay;
//		wait level.dist_light_min_delay + randomfloat(range);
//		playfx(level._effect["distant_light"],self.origin);
//	}
//}