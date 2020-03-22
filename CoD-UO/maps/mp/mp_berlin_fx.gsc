main()
{
	precacheFX();
	effects = getentarray ("effect","targetname");
	spawnWorldFX(effects);

	// Distant lights
	wait(0.5);
	level.dist_light_min_delay = 5;
	level.dist_light_max_delay = 15;
//	level thread Ambience_Setup();
	level thread Ambience_Setup2();

	// set the nighttime flag
	setcvar("sv_night", "1" );
}

precacheFX()
{
// SMOKE ================================//
	level._effect["gigantor"]			= loadfx ("fx/map_mp/mp_gigantor_night.efx");
//	level._effect["tanksmoke"]			= loadfx ("fx/map_mp/mp_smoke_tank_slow_long_high.efx");

// FIRE ================================//
	level._effect["car_fire"]			= loadfx ("fx/map_mp/mp_smoke_car_slow_long_high.efx");
	level._effect["distant_fire2tall_smoke"]	= loadfx ("fx/map_mp/mp_building_fire_big_2ts.efx");
	level._effect["distant_fire2"]			= loadfx ("fx/map_mp/mp_building_fire_big_2.efx");

// Atmosphere ==========================//
	level._effect["distant_light"]			= loadfx ("fx/map_mp/mp_mortar_mz.efx");
    	level._effect["antiair_tracers"]		= loadfx ("fx/atmosphere/antiair_tracers.efx");
    	level._effect["searchlight"]			= loadfx ("fx/atmosphere/v_light_searchlight.efx");
// Water ===============================//
    	level._effect["sewer_foam"]			= loadfx ("fx/map_mp/mp_sewer_foam.efx");

}

spawnWorldFX(effects)
{

	wait(1);

	if (isdefined (effects))
	{
		for (i=0;i<effects.size;i++)
		{
//			if (effects[i].script_noteworthy == "tanksmoke")
//			wait(0.3);
//				level thread maps\mp\_fx::loopfx(effects[i].script_noteworthy, effects[i].origin, 5);
//			}
			if (effects[i].script_noteworthy == "gigantor")
			{
			wait(0.3);
				level thread maps\mp\_fx::loopfx(effects[i].script_noteworthy, effects[i].origin, 5);
			}
			else if (effects[i].script_noteworthy == "car_fire")
			{
			wait(0.3);
				level thread maps\mp\_fx::loopfx(effects[i].script_noteworthy, effects[i].origin, 5);
			}
		}
	}

 //SMOKE ==============================//
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2tall_smoke", 		(-1961,4806,960), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2tall_smoke", 		(-6131,3360,761), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2tall_smoke", 		(-7143,584,628), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "gigantor", 				(-6994,2997,1726), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2tall_smoke", 		(-5409,5961,693), 5);


 //FIRE ===============================//
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-1979,1320,754), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-6994,2997,1726), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-4624,458,678), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-2756,3786,952), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-6721,3223,878), 5);
	wait(.1);
//	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(576,384,888), 5);
	wait(.1);
//	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(1470,3177,585), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "car_fire", 				(-320,2240,675), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-154,1566,715), 5);
	wait(.1);
//	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(1508,3171,645), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "car_fire", 			(997,4245,539), 5);
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "distant_fire2", 			(-2834,2740,675), 5);
 
 //WATER ===============================//
	wait(.1);
	level thread maps\mp\_fx::loopfxthread ( "sewer_foam", 				(-2677, 3139, 61), 5);
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

// Grabs all of tracers and has them run the think function.
Ambience_Setup2()
{
	orgs = getentarray("tracers","targetname");
	for(i=0;i<orgs.size;i++)
	{
		orgs[i] thread Random_tracers_Think();
		wait 0.05;
	}
}

// Think function for distant_light script_origins.
// Randomly plays the lights in the sky.
Random_tracers_Think()
{
	level endon("stop_tracers");

	while(1)
	{
		range = level.dist_light_max_delay - level.dist_light_min_delay;
		wait level.dist_light_min_delay + randomfloat(range);
		playfx(level._effect["antiair_tracers"],self.origin);
	}
}