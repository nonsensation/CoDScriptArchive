main()
{
	precacheFX();
	spawnWorldFX();    
}

precacheFX()
{
// Explosions ===========================//
	level._effect["antitankgunexplosion"]	= loadfx("fx/map_mp/mp_exp_generic_complete.efx");

// FIRE ==============================//
	level._effect["fire"]			= loadfx ("fx/map_mp/mp_arnhem_fire.efx");
	level._effect["fire_smolder"]		= loadfx ("fx/map_mp/mp_arnhem_fire_smolder.efx");

// SMOKE ============================//

	level._effect["vehicle_smoke"]		= loadfx ("fx/map_mp/mp_arnhem_smoke.efx");

// Atmosphere ==========================//
	level._effect["ground_fog"]		= loadfx ("fx/map_mp/mp_arnhem_fog.efx");
	level._effect["ground_fog_sm"]		= loadfx ("fx/map_mp/mp_arnhem_fog_sm.efx");
}


spawnWorldFX()
{
	wait(1);

	//house near park
//     		thread maps\mp\_fx::loopfxthread("fire_smolder", 	(-1428, 348, 52), 5, undefined, undefined, 4096);
//     		thread loopsoundinspace((-1428, 348, 52),"smallfire");
	wait(0.1);
	//house near church
//      		thread maps\mp\_fx::loopfxthread("fire_smolder", 	(-900, 1604, 100), 5, undefined, undefined, 4096);
//     		thread loopsoundinspace((-900, 1604, 100),"smallfire");
	wait(0.2);
	//house @ end of middle street, by bridge road
      		thread maps\mp\_fx::loopfxthread("fire_smolder", 	(1916, 1092, 84), 5, undefined, undefined, 4096);
     		thread loopsoundinspace((1916, 1092, 84),"smallfire");
	wait(0.3);
	//house next to flag house, axis street	
     		thread maps\mp\_fx::loopfxthread("fire_smolder", 	(828, 2596, 140), 5, undefined, undefined, 4096);
     		thread loopsoundinspace((828, 2596, 140),"smallfire");
	wait(0.1);
	//house by axis spawn
//      		thread maps\mp\_fx::loopfxthread("fire_smolder", 	(-1724, 2268, 156), 5, undefined, undefined, 4096);
  //   		thread loopsoundinspace((-1724, 2268, 156),"smallfire");
	wait(0.2);
	//hole in roof near allies spawn area	
      		thread maps\mp\_fx::loopfxthread("fire", 		(780, 52, 316), 5, undefined, undefined, 4096);
     		thread loopsoundinspace((780, 52, 316),"medfire");
	wait(0.3);
	// ??
     		thread maps\mp\_fx::loopfxthread("fire", 		(-349, 1657, 610), 5, undefined, undefined, 4096);
     		thread loopsoundinspace((-349, 1657, 610),"medfire");
	wait(0.1);
	//church tower
      		thread maps\mp\_fx::loopfxthread("ground_fog_sm", 	(1550, 2755, 198), 5, undefined, undefined, 4096);
	wait(0.2);
	//First Allies Flag Building	
      		thread maps\mp\_fx::loopfxthread("ground_fog_sm", 	(652, 565, -128), 5, undefined, undefined, 4096);
	wait(0.3);
	//Bld, right side, Allied street, by Allied HQ	
      		thread maps\mp\_fx::loopfxthread("ground_fog_sm", 	(-882, -361, 51), 5, undefined, undefined, 4096);
	wait(0.1);
	//Double rubble blds across from Allied HQ	
      		thread maps\mp\_fx::loopfxthread("ground_fog", 	(-1299, 286, 77), 5, undefined, undefined, 4096);
	wait(0.2);
	//Rubble at end of middle stret by Allied HQ	
      		thread maps\mp\_fx::loopfxthread("ground_fog", 	(-3096, 869, 160), 5, undefined, undefined, 4096);
	wait(0.3);
	//Bld at bridge end of middle street
      		thread maps\mp\_fx::loopfxthread("ground_fog_sm", 	(1980, 1134, 93), 5, undefined, undefined, 4096);
	wait(0.1);
	//Blds by Axis main spawn
      		thread maps\mp\_fx::loopfxthread("ground_fog", 	(-1021, 2461, 165), 5, undefined, undefined, 4096);
}


loopsoundinspace(org,sound)
{
	soundorg = spawn("script_model",org);
	soundorg.origin = org+(0,0,15);
	soundorg playloopsound(sound);
}