//
// Map: Trenches
// Edited by: Mike
//

main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{
// TREADS! ======================//
	level._effect["treads_grass"]			= loadfx ("fx/vehicle/wheelspray_gen_grass.efx");
	level._effect["treads_sand"] 			= loadfx ("fx/vehicle/wheelspray_gen_sand.efx");
	level._effect["treads_dirt"] 			= loadfx ("fx/vehicle/wheelspray_gen_dirt.efx");

// Atmosphere ===================//
	level._effect["ceiling_dust"]			= loadfx ("fx/map_trenches/ceiling_dust.efx");
	level._effect["fog_distant"]			= loadfx ("fx/atmosphere/fog_d_sz400_sp100_a.efx");
	level._effect["fog_close"]			= loadfx ("fx/atmosphere/fog_c_sz400_sp100_a.efx");
	level._effect["distant_artillery"]		= loadfx ("fx/map_trenches/mortar_mz.efx");
	level._effect["antiair_tracers"]		= loadfx ("fx/atmosphere/antiair_tracers.efx");
	//level._effect["distant_artillery"]		= loadfx ("fx/atmosphere/distant88s.efx");

// fire =========================//
	level._effect["bigfire1"]			= loadfx ("fx/fire/tank_med_long_high.efx");
	level._effect["bigfire1_low"]			= loadfx ("fx/fire/tank_med_long_low.efx");
	level._effect["fire_small_local"]		= loadfx ("fx/fire/fire_small_local.efx");
	level._effect["building_fire_bigs"]		= loadfx ("fx/fire/building_fire_bigs.efx");

// Smoke=========================//
	level._effect["distant_smoke"]			= loadfx ("fx/smoke/tank_med_long_high.efx");
	level._effect["distant_smoke_low"]		= loadfx ("fx/smoke/tank_med_long_low.efx");


// Water =========================//
	level._effect["w_spray_trench_r_5"]		= loadfx ("fx/water/w_spray_trench_r_5.efx");
	//level._effect["w_wallseep_muddy"]		= loadfx ("fx/water/w_wallseep_muddy.efx");

	if(getcvarint("scr_gmi_fast") < 2)
	{
		level._effect["w_drip_r_5"]			= loadfx ("fx/water/w_drip_r_5.efx");
		level._effect["w_drip_r_50"]			= loadfx ("fx/water/w_drip_r_50.efx");
		level._effect["w_drip_l_20_e"]			= loadfx ("fx/water/w_drip_l_20_e.efx");
		level._effect["w_drip_l_20_s"]			= loadfx ("fx/water/w_drip_l_20_s.efx");
		level._effect["w_drip_l_75_n"]			= loadfx ("fx/water/w_drip_l_75_n.efx");
		level._effect["w_drip_l_130_n"]			= loadfx ("fx/water/w_drip_l_130_n.efx");
		level._effect["w_drip_l_130_e"]			= loadfx ("fx/water/w_drip_l_130_e.efx");
		level._effect["w_drip_l_150_n"]			= loadfx ("fx/water/w_drip_l_150_n.efx");
	}

// Scripted =====================//
	level._effect["bunker_exit_dust"]		= loadfx ("fx/map_trenches/bunker_exit.efx");
	level._effect["bunker_explosion"]		= loadfx ("fx/map_trenches/bunker_explode.efx");
	level._effect["stuka_engine_fire"]		= loadfx ("fx/fire/fire_engine_stuka.efx");
	level._effect["stuka_hitground"]		= loadfx ("fx/map_trenches/stuka_hitground.efx");
	level._effect["stuka_air_explosion"]		= loadfx ("fx/map_trenches/stuka_wing.efx");
	level._effect["blow_mg42_nest"]			= loadfx ("fx/map_trenches/sand_bagsA.efx");
	level._effect["train_smoke"]			= loadfx ("fx/vehicle/exhaust_train_idle.efx");
// End Scripted =================//

	// For fake firing on the elefants.
	level.fake_turret_fx 				= loadfx ("fx/muzzleflashes/turretfire.efx");
}

spawnworldfx()
{
// Reference=====================//
	//loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout, low_fxId, lod_dist)
	//gunfireloopfx(fxId, fxPos, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax, wait_till)
	
	//map orientation
	// north	(+, 0, 0)
	// west		(0, +, 0)

// Smoke=========================//
	// Optimization... less on the screen
	if(getcvarint("scr_gmi_fast") < 2)
	{
		//far left of train station                                                                 
		maps\_fx_gmi::LoopFx("distant_smoke", (-15234.00, 318.00, 180.00), 0.3, undefined, undefined, "event1", undefined, "distant_smoke_low", 2000);
		//on hill at first bend on truck path                                                       
		maps\_fx_gmi::LoopFx("distant_smoke", (-11316.00, -5374.00, 253.00), 0.3, undefined, undefined, "village", undefined, "distant_smoke_low", 2000);
		//distant tank hill past first bend                                                         
		maps\_fx_gmi::LoopFx("distant_smoke", (-7898.00, -12995.00, 571.00), 0.3, undefined, undefined, "village", undefined, "distant_smoke_low", 2000);
		//busted tiger on by house before the village                                               
		maps\_fx_gmi::LoopFx("distant_smoke", (-6471.00, -7325.00, 218.00), 0.3, undefined, undefined, "village", undefined, "distant_smoke_low", 2000);	
		//house before the village on the hill                                                       
		maps\_fx_gmi::LoopFx("distant_smoke", (-5645.00, -3709.00, 326.00), 0.3, undefined, undefined, "village", undefined, "distant_smoke_low", 2000);
		//distant west of main trench                                                                
		maps\_fx_gmi::LoopFx("distant_smoke", (2304.00, 4992.00, 144.00), 0.3, undefined, undefined, undefined, undefined, "distant_smoke_low", 2000);
		//ouside 1st bunker exit                                                                     
		maps\_fx_gmi::LoopFx("distant_smoke", (-434.00, -2078.00, 78.00), 0.3, undefined, undefined, undefined, undefined, "distant_smoke_low", 2000);
		//east battlefield of main trench past t34                                                   
		maps\_fx_gmi::LoopFx("distant_smoke", (790.00, -3271.00, 92.00), 0.3, undefined, undefined, undefined, undefined, "distant_smoke_low", 2000);
	}

	//dead tank on path                                                                         
	maps\_fx_gmi::LoopFx("distant_smoke", (-13580, -4729, 37), 0.3, undefined, undefined, "event1", undefined, "distant_smoke_low", 2000);
	//village at bend                                                                            
	maps\_fx_gmi::LoopFx("distant_smoke", (-7966.00, 1398.00, 132.00), 0.3, undefined, undefined, "village", undefined, "distant_smoke_low", 2000);
	//on top of first bunker                                                                     
	maps\_fx_gmi::LoopFx("distant_smoke", (-29.00, 267.00, 116.00), 0.3, undefined, undefined, undefined, undefined, "distant_smoke_low", 2000);
	
// Fire=========================//
	//flakgun at trainstop                                                                          
	//maps\_fx_gmi::LoopFx("building_fire_bigs", (-16779, -4565, -30), 0.3, undefined, undefined, undefined, undefined, undefined, undefined);

	if(getcvarint("scr_gmi_fast") < 2)
	{
		//tiger tank opposite main fighting trench                                                      
		maps\_fx_gmi::LoopFx("bigfire1", (4104.00, -1824.00, 152.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);
		//east of main trench on hill (past t34)                                                        
		maps\_fx_gmi::LoopFx("bigfire1", (1345.00, -4694.00, 129.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);
	}

	//Near Train Stop.  east bush                                                                   
	maps\_fx_gmi::LoopFx("bigfire1", (-17932.00, -6200.00, 109.00), 0.3, undefined, undefined, "event1", undefined, "bigfire1_low", 2000);
	//behind house in front of train                                                                
	maps\_fx_gmi::LoopFx("bigfire1", (-15080.00, -4992.00, -21.00), 0.3, undefined, undefined, "event1", undefined, "bigfire1_low", 2000);	
	//2nd truck on path                                                                             
	maps\_fx_gmi::LoopFx("fire_small_local", (-13530, -4716, 23), 0.3, undefined, undefined, "event1", undefined, undefined, undefined);
	//In Village first building on left                                                             
	maps\_fx_gmi::LoopFx("bigfire1", (-10060.00, -93.00, 232.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);
	//west side near mg42 nest past 2nd bunker                                                      
	maps\_fx_gmi::LoopFx("bigfire1", (1776.00, 3752.00, 180.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);
	//west side battlefield behind fence                                                            
	maps\_fx_gmi::LoopFx("bigfire1", (3858.00, 855.00, 242.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);
	//panzer in distant battlefield                                                                 
	maps\_fx_gmi::LoopFx("bigfire1", (7551.00, -1045.00, 354.00), 0.3, undefined, undefined, undefined, undefined, "bigfire1_low", 2000);	
	//start of mian trenches                                                                        
	//maps\_fx_gmi::LoopFx("help", (236.00, 2228.00, 0.00), 0.3, undefined);

// Fog==========================//

	if(getcvarint("scr_gmi_fast") < 2)
	{
		//truck ride first bend                                                                         
		maps\_fx_gmi::LoopFx("fog_close", (-11006, -6851, 90), 0.3);
		//truck ride approaching trenches                                                               
		maps\_fx_gmi::LoopFx("fog_close", (-1873.00, 2870.00, 64.00), 0.3, undefined);

		//battlefield                                                                                   
		maps\_fx_gmi::LoopFx("fog_distant", (2849.00, -1519.00, 64.00), 0.6, (2888,-2145,64));
		maps\_fx_gmi::LoopFx("fog_distant", (2819.00, -933.00, 64.00), 0.6, (2775.00, -1349.00, 64));
		maps\_fx_gmi::LoopFx("fog_distant", (2911.00, -2415.00, 64.00), 0.6, (2565,-3067,64));
		//battlefield                                                                                   
		maps\_fx_gmi::LoopFx("fog_distant", (2819.00, -404.00, 64.00), 0.6, (2775.00, -879.00, 64));
		maps\_fx_gmi::LoopFx("fog_distant", (2598.00, 652.00, 64.00), 0.6, (2598, 248, 64));
	}
	//maps\_fx_gmi::LoopFx("fog_distant", (372.00, -3169.00, 92.00), 0.3, undefined);               

// Water========================//
	//=======lines=drips====//
	if(getcvarint("scr_gmi_fast") < 2)
	{
		//village first house left side (north)                                                         
		maps\_fx_gmi::LoopFx("w_drip_l_130_n", (-9422, -251, 326), 0.01, (-10000, -251, 326));
		//village first house front side (east)                                                         
		maps\_fx_gmi::LoopFx("w_drip_l_130_e", (-9285, 20, 230), 0.01, (-9285, 1000, 230));
		//village hous overhange (north)                                                                
		maps\_fx_gmi::LoopFx("w_drip_l_150_n", (-7081, -228, 240), 0.02, (-10000, -228, 240));
		//trenches, first cubby hole medkit pickup   (north)                                            
		maps\_fx_gmi::LoopFx("w_drip_l_75_n", (-8, 1168, 40), 0.05,(-1000, 1168, 40));
		//trenches, first bunker entrance    (east)                                                     
		maps\_fx_gmi::LoopFx("w_drip_l_20_e", (-32, 855, 62), 0.05,(-32, 1000, 62));
		//trenches, 2nd bunker exit  (east)                                                             
		maps\_fx_gmi::LoopFx("w_drip_l_20_e", (855, 419, 61), 0.05,(855, 1000, 61));
		//trenches,  bunker exit going onto battle field    (south                                      
		maps\_fx_gmi::LoopFx("w_drip_l_20_s", (2181, -332, 63), 0.05, (3000, -332, 63));

		//exit first bunker
		maps\_fx_gmi::LoopFx("w_drip_r_5", (150, -372, 60), .5);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (165, -375, 60), .1);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (175, -380, 60), 0.4);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (197, -393, 60), 0.3);
		//entrance 2nd bunker
		maps\_fx_gmi::LoopFx("w_drip_r_5", (535, -742, 60), 0.3);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (550, -757, 60), 0.1);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (557, -765, 60), 0.5);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (564, -772, 60), 0.2);
		//entrance 3rd bunker
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1772, -468, 60), 0.7);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1787, -488, 50), 0.1);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1796, -495, 50), 0.3);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1808, -504, 50), 0.4);
		//entrance 4th bunker
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1942, -1913, 60), 0.4);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1938, -1923, 60), 0.2);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1933, -1934, 60), 1);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (1923, -1954, 60), 0.3);
		//exit 5th bunker
		maps\_fx_gmi::LoopFx("w_drip_l_20_s", (2333, -2018, 63), 0.1, (10000, -2018, 63));

		//entrance 6th bunker far north
		maps\_fx_gmi::LoopFx("w_drip_r_5", (-244, -3205, 60), 0.4);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (-254, -3197, 60), 0.2);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (-261, -3190, 60), 0.4);
		maps\_fx_gmi::LoopFx("w_drip_r_5", (-281, -3184, 60), 0.1);
		//exit 6th bunker far north
		maps\_fx_gmi::LoopFx("w_drip_l_20_e", (-354, -3594, 60), 0.1, (-354, 10000, 60));
		//trenchline storage overhang
		maps\_fx_gmi::LoopFx("w_drip_l_75_n", (1255, -1580, 40), 0.1,(10000, -1580, 40));


		//trenches, first bunker exit-- this is an angled dirrection and isn't lining up right                                                                  
		//maps\_fx_gmi::LoopFx("w_drip_l_20_90", (168, -377, 55), 0.1);		
	}

	//radial drips==================//
	//1st bunker ceiling                                                                             
	maps\_fx_gmi::LoopFx("w_drip_r_50", (-71, 311, 60), 1);
	//1st bunker ceiling lamp                                                                        
	maps\_fx_gmi::LoopFx("w_drip_r_50", (258, -100, 60), 0.5);
	//2nd bunker ceiling lamp                                                                        
	maps\_fx_gmi::LoopFx("w_drip_r_50", (721, -354, 60), 1);
	//2nd bunker ceiling barrels                                                                     
	maps\_fx_gmi::LoopFx("w_drip_r_50", (985, 12, 60), 0.75);

	//water flows===================//
	//outside exit of first bunker                                                                   
//	maps\_fx_gmi::LoopFx("w_spray_trench_r_5", (202, -408, 53), 0.3, (119, -418, 53));
	//outside exit of first bunker further down                                                      
//	maps\_fx_gmi::LoopFx("w_spray_trench_r_5", (127, -685, 22), 0.3, (55, -756, 22));
	//entrance 2nd bunker                                                                            
//	maps\_fx_gmi::LoopFx("w_spray_trench_r_5", (506, -724, 55), 0.3, (493, -791, 55));
	//exit 2nd bunker                                                                                
//	maps\_fx_gmi::LoopFx("w_spray_trench_r_5", (808, 426, 60), 0.3, (879, 464, 60));
	//exit battlefield bunker                                                                        
//	maps\_fx_gmi::LoopFx("w_spray_trench_r_5", (2183, -286, 57), 0.3, (2218, -353, 57));

	//====water seepage=============//
	//main trench   -- this is an angled dirrection and isn't lining up right                                                                                 
	//maps\_fx_gmi::LoopFx("w_wallseep_muddy", (1378, -1204, 5), 0.3, (1329, -1220, 5));

// AntiAir=====================//
	maps\_fx_gmi::gunfireLoopfx("antiair_tracers", (-13448, -2048, 200), 3, 7, 5.2, 3.4, 2, 3, "stop_anti_air_fx");
	maps\_fx_gmi::gunfireLoopfx("antiair_tracers", (-4098, -9993, 100), 3, 7, 5.2, 3.4, 2, 3, "stop_anti_air_fx");
	maps\_fx_gmi::gunfireLoopfx("antiair_tracers", (-12717, -8944, 200), 3, 7, 5.2, 3.4, 2, 3, "stop_anti_air_fx");
	maps\_fx_gmi::gunfireLoopfx("antiair_tracers", (-22306, -538, 150), 3, 7, 5.2, 3.4, 2, 3, "stop_anti_air_fx");
}

spawnSoundfx()
{
	// first (radio) bunker
	maps\_fx_gmi::loopSound("rain_gutter", (-48, 746, 64));
	maps\_fx_gmi::loopSound("rain_local", (-23, 873, 64));
	maps\_fx_gmi::loopSound("rain_gutter", (231, -232, 64));
	maps\_fx_gmi::loopSound("rain_local", (174, -342, 64));
	
	// Hospital bunker
	maps\_fx_gmi::loopSound("rain_gutter", (657, -648, 64));
	maps\_fx_gmi::loopSound("rain_local", (461, -812, 64));
	maps\_fx_gmi::loopSound("rain_gutter", (885, 297, 64));
	maps\_fx_gmi::loopSound("rain_local", (849, 477, 64));
	
	// mini-bunker right
	maps\_fx_gmi::loopSound("rain_gutter", (-343, -3504, 64));
	maps\_fx_gmi::loopSound("rain_local", (-356, -3644, 64));
	maps\_fx_gmi::loopSound("rain_gutter", (-313, -3296, 64));
	maps\_fx_gmi::loopSound("rain_local", (-243, -3123, 64));
	
	// mini-bunker center
	maps\_fx_gmi::loopSound("rain_gutter", (2032, -1969, 64));
	maps\_fx_gmi::loopSound("rain_local", (1879, -1896, 64));
	maps\_fx_gmi::loopSound("rain_gutter", (2262, -2018, 64));
	maps\_fx_gmi::loopSound("rain_local", (2397, -2016, 64));
	
	// mini-bunker left
	maps\_fx_gmi::loopSound("rain_gutter", (2082, -336, 64));
	maps\_fx_gmi::loopSound("rain_local", (2253, -334, 64));
	maps\_fx_gmi::loopSound("rain_gutter", (1855, -428, 64));
	maps\_fx_gmi::loopSound("rain_local", (1731, -532, 64));
	
	// metal drums
	maps\_fx_gmi::loopSound("rain_metal", (-39, 1995, 64));
	maps\_fx_gmi::loopSound("rain_metal", (149, -1349, 64));
	maps\_fx_gmi::loopSound("rain_metal", (769, 903, 64));
	maps\_fx_gmi::loopSound("rain_metal", (887, 1353, 64));
	maps\_fx_gmi::loopSound("rain_metal", (806, 1934, 64));
	maps\_fx_gmi::loopSound("rain_metal", (666, 2268, 64));
	maps\_fx_gmi::loopSound("rain_metal", (319, 1415, 64));
 	// wrecked car
	maps\_fx_gmi::loopSound("rain_metal", (-3745, -2924, 40));

 	// tin silo
	maps\_fx_gmi::loopSound("rain_metal_wide", (-8570, -208, 200));
	
	// overhead netting
	maps\_fx_gmi::loopSound("rain_netting", (319, 1415, 64));
	maps\_fx_gmi::loopSound("rain_netting", (814, 2595, 64));
	maps\_fx_gmi::loopSound("rain_netting", (719, -1756, 180));
	
	//Looping Radio
	maps\_fx_gmi::loopSound("russian_radio01", (-293, 391, 64));

	// Puddle Sounds
	maps\_fx_gmi::loopSound("rain_puddle", (61, -912, 25));
	maps\_fx_gmi::loopSound("rain_puddle", (1430, -1304, 64));
	maps\_fx_gmi::loopSound("rain_puddle", (790, 1291, 25));
	maps\_fx_gmi::loopSound("rain_puddle", (782, 2243, 25));

	// burning house on road
	maps\_fx_gmi::loopSound("housefire", (-9943, -71, 250));
	// fire on hillside
	maps\_fx_gmi::loopSound("medfire", (1399, -4711, 253));
	// metal drums near tin silo
	maps\_fx_gmi::loopSound("rain_metal", (-8252, -169, 200));
	// burning tank near elephants
	maps\_fx_gmi::loopSound("truckfire", (4089, -1856, 238));
	// front porch, village entrance
	maps\_fx_gmi::loopSound("rain_local", (-8770, 325, 198));
	// Flamethrower Bunker
	maps\_fx_gmi::loopSound("rain_trickle", (979, 15, 17));
	// doorways and windows in village
	maps\_fx_gmi::loopSound("rain_local", (-8770, 325, 198));
	maps\_fx_gmi::loopSound("rain_gutter", (-8486, 154, 181));
	maps\_fx_gmi::loopSound("rain_gutter", (-7105, -90, 193));
	maps\_fx_gmi::loopSound("rain_local", (-7100, 203, 195));
	maps\_fx_gmi::loopSound("rain_local", (-9403, -184, 203));
	maps\_fx_gmi::loopSound("rain_local", (-7192, 386, 196));
	maps\_fx_gmi::loopSound("rain_local", (-7133, 450, 196));
	maps\_fx_gmi::loopSound("rain_local", (-6954, 629, 196));
	maps\_fx_gmi::loopSound("rain_local", (-6888, 695, 196));
	maps\_fx_gmi::loopSound("rain_local", (-6679, 471, 196));
	maps\_fx_gmi::loopSound("rain_local", (-6739, 411, 196));
	maps\_fx_gmi::loopSound("rain_local", (-7020, 515, 288));
	maps\_fx_gmi::loopSound("rain_local", (-9094, -58, 189));
	maps\_fx_gmi::loopSound("rain_local", (-8483, 502, 196));
	maps\_fx_gmi::loopSound("rain_local", (-8732, 502, 196));
}