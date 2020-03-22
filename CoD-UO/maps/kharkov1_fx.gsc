main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
	thread Delayed_FX();
}

precacheFX()
{
// Vehicles ==============================//
	level._effect["treads_grass"]			= loadfx ("fx/vehicle/wheelspray_gen_grass.efx");
	level._effect["treads_sand"] 			= loadfx ("fx/vehicle/wheelspray_gen_sand.efx");
	level._effect["treads_dirt"] 			= loadfx ("fx/vehicle/wheelspray_gen_dirt.efx");

	// Fake FX for tanks firing
	level.fake_turret_fx 				= loadfx ("fx/muzzleflashes/turretfire.efx");

	// Elefant Turret
	level.elefant_turret		 		= loadfx ("fx/vehicle/muzzleflash_elefant.efx");
	level.event1_turret_fx 				= loadfx ("fx/muzzleflashes/turretfire.efx");
	level.event1_fake_target			= loadfx ("fx/explosions/artillery/pak88.efx");
	level.event1_fake_target_low			= loadfx ("fx/explosions/artillery/pak88_low.efx");

// Events ==============================//
	level._effect["event1_building_1"] 		= loadfx ("fx/map_kharkov1/exp_concrete.efx");
	level._effect["event1_building_2"] 		= loadfx ("fx/map_kharkov1/exp_redbrick.efx");

	// Mortar Effect
	level.mortar 					= loadfx ("fx/explosions/artillery/pak88.efx");
	level.mortar_low				= loadfx ("fx/explosions/artillery/pak88_low.efx");

	// Blockade explosion Effect
	level.blockade 					= loadfx ("fx/explosions/artillery/pak88.efx");
	level.blockade_low				= loadfx ("fx/explosions/artillery/pak88_low.efx");

	//Tiger tank blowing wall at end of map.
	level._effect["event4_building_exp"] 		= loadfx ("fx/map_kharkov1/exp_redbrick_end.efx");
	level.scr_sound["tank_breakthrough"]		= "Tank_stone_breakthrough";

// Smoke ==============================//
	level._effect["distant_smoke"]			= loadfx ("fx/smoke/tank_med_long_high.efx");
	level._effect["distant_smoke_low"]		= loadfx ("fx/smoke/tank_med_long_low.efx");
//	level._effect["interior_smoke1"]		= loadfx ("fx/smoke/smoke_high.efx");
	level._effect["smk_corner_nw_150"]		= loadfx ("fx/smoke/smk_corner_nw_150.efx");
	level._effect["smk_corner_ne_100"]		= loadfx ("fx/smoke/smk_corner_ne_100.efx");
	level._effect["smk_corner_ne_150"]		= loadfx ("fx/smoke/smk_corner_ne_100.efx");
	level._effect["smk_corner_sw_150"]		= loadfx ("fx/smoke/smk_corner_sw_150.efx");
	level._effect["smk_hall_east_450"]		= loadfx ("fx/smoke/smk_hall_east_450.efx");
	level._effect["smk_hall_north_450"]		= loadfx ("fx/smoke/smk_hall_north_450.efx");
	level._effect["smk_hall_south_450"]		= loadfx ("fx/smoke/smk_hall_south_450.efx");
//	level._effect["smk_halllocal_ns_25"]		= loadfx ("fx/smoke/smk_halllocal_ns_25.efx");
	level._effect["smk_halllocal_ns_50"]		= loadfx ("fx/smoke/smk_halllocal_ns_50.efx");
//	level._effect["smk_halllocal_ew_25"]		= loadfx ("fx/smoke/smk_halllocal_ew_25.efx");
//	level._effect["smk_halllocal_ew_50"]		= loadfx ("fx/smoke/smk_halllocal_ew_50.efx");
	level._effect["smoke_plume_debree"]		= loadfx ("fx/smoke/smoke_plume_debree.efx");

// Fire ==============================//

	level.flame_particle 				= loadfx("fx/fire/fire_trail_25");

//	level._effect["tank_fire"]			= loadfx ("fx/fire/tank_slow_long_low.efx.efx");	//unused??
	level._effect["fire_small_local"]		= loadfx ("fx/fire/fire_small_local.efx");
	level._effect["fire_small_local_tall"]		= loadfx ("fx/fire/fire_small_local_tall.efx");
	level._effect["fire_tiny_local"]		= loadfx ("fx/fire/fire_tiny_local.efx");
	level._effect["distant_fire"]			= loadfx ("fx/fire/building_fire_big.efx");
	level._effect["distant_fire_smoke"]		= loadfx ("fx/fire/building_fire_bigs.efx");
	level._effect["distant_fire_tall"]		= loadfx ("fx/fire/building_fire_big_tall.efx");
	level._effect["distant_fire2"]			= loadfx ("fx/fire/building_fire_big_2.efx");
	level._effect["distant_fire2_smoke"]		= loadfx ("fx/fire/building_fire_big_2s.efx");
	level._effect["distant_fire2tall_smoke"]	= loadfx ("fx/fire/building_fire_big_2ts.efx");
	level._effect["distant_fire3"]			= loadfx ("fx/fire/building_fire_big_3.efx");
	level._effect["distant_fire4"]			= loadfx ("fx/fire/building_fire_big_4.efx");
	level._effect["distant_fire4_smoke"]		= loadfx ("fx/fire/building_fire_big_4s.efx");
	level._effect["distant_fire4tall_smoke"]	= loadfx ("fx/fire/building_fire_big_4ts.efx");

	level._effect["distant_fire2tall_smoke_sound"]	= loadfx ("fx/fire/building_fire_big_2ts.efx");
	level._effect["distant_fire2_sound"]		= loadfx ("fx/fire/building_fire_big_2.efx");
	level._effect["fire_small_local_tall_sound"]	= loadfx ("fx/fire/fire_small_local_tall.efx");
	level._effect["fire_tiny_local_sound"]		= loadfx ("fx/fire/fire_tiny_local.efx");
	level._effect["distant_fire_tall_sound"]	= loadfx ("fx/fire/building_fire_big_tall.efx");
	level._effect["fire_small_local_sound"]		= loadfx ("fx/fire/fire_small_local.efx");
	level._effect["distant_fire3_sound"]		= loadfx ("fx/fire/building_fire_big_3.efx");

	level._effect["window_fire_a"]			= loadfx ("fx/fire/window_fire_a.efx");
	level._effect["window_fire_b"]			= loadfx ("fx/fire/window_fire_b.efx");
	level._effect["building_inside_big"]		= loadfx ("fx/fire/building_inside_big.efx");
	level._effect["building_inside_small"]		= loadfx ("fx/fire/building_inside_small.efx");
	level._effect["building_inside_medium"]		= loadfx ("fx/fire/building_inside_medium.efx");
	level._effect["wall_fire_full_east"]		= loadfx ("fx/fire/wall_fire_full_east.efx");
	level._effect["wall_fire_btm_east"]		= loadfx ("fx/fire/wall_fire_btm_east.efx");
	level._effect["wall_fire_top_east"]		= loadfx ("fx/fire/wall_fire_top_east.efx");
	level._effect["wall_fire_top_south"]		= loadfx ("fx/fire/wall_fire_top_south.efx");
	level._effect["wall_fire_btm_south"]		= loadfx ("fx/fire/wall_fire_btm_south.efx");
	level._effect["wall_fire_full_south"]		= loadfx ("fx/fire/wall_fire_full_south.efx");
	level._effect["wall_fire_btm_west"]		= loadfx ("fx/fire/wall_fire_btm_west.efx");
	level._effect["wall_fire_top_west"]		= loadfx ("fx/fire/wall_fire_top_west.efx");
	level._effect["wall_fire_full_west"]		= loadfx ("fx/fire/wall_fire_full_west.efx");
	level._effect["wall_fire_full_north"]		= loadfx ("fx/fire/wall_fire_full_north.efx");

	level._effect["window_fire_a_sound"]		= loadfx ("fx/fire/window_fire_a.efx");
	level._effect["window_fire_b_sound"]		= loadfx ("fx/fire/window_fire_b.efx");
	level._effect["building_inside_big_sound"]	= loadfx ("fx/fire/building_inside_big.efx");
	level._effect["building_inside_small_sound"]	= loadfx ("fx/fire/building_inside_small.efx");
	level._effect["building_inside_medium_sound"]	= loadfx ("fx/fire/building_inside_medium.efx");
	level._effect["wall_fire_full_east_sound"]	= loadfx ("fx/fire/wall_fire_full_east.efx");
	level._effect["wall_fire_btm_east_sound"]	= loadfx ("fx/fire/wall_fire_btm_east.efx");
	level._effect["wall_fire_top_east_sound"]	= loadfx ("fx/fire/wall_fire_top_east.efx");
	level._effect["wall_fire_top_south_sound"]	= loadfx ("fx/fire/wall_fire_top_south.efx");
	level._effect["wall_fire_btm_south_sound"]	= loadfx ("fx/fire/wall_fire_btm_south.efx");
	level._effect["wall_fire_full_south_sound"]	= loadfx ("fx/fire/wall_fire_full_south.efx");
	level._effect["wall_fire_btm_west_sound"]	= loadfx ("fx/fire/wall_fire_btm_west.efx");
	level._effect["wall_fire_top_west_sound"]	= loadfx ("fx/fire/wall_fire_top_west.efx");
	level._effect["wall_fire_full_west_sound"]	= loadfx ("fx/fire/wall_fire_full_west.efx");
	level._effect["wall_fire_full_north_sound"]	= loadfx ("fx/fire/wall_fire_full_north.efx");

// Atmosphere ==============================//

	level._effect["ground_fog_right"]		= loadfx ("fx/atmosphere/fog_right.efx");
	level._effect["ground_fog_left"]		= loadfx ("fx/atmosphere/fog_left.efx");

	level._effect["distant_light"]			= loadfx ("fx/map_trenches/mortar_mz.efx");

	level._effect["debris_trail_50"]		= loadfx ("fx/dirt/dust_trail_50.efx");
	level._effect["debris_trail_25"]		= loadfx ("fx/dirt/dust_trail_25.efx");
	level._effect["debris_trail_100"]		= loadfx ("fx/dirt/dust_trail_100.efx");
}

spawnWorldFX()
{
// REF =================================================//

	// loopfx(fxId,	fxPos,  waittime, fxPos2,   fxStart,  fxStop, timeout, low_fxId, lod_dist)

// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////

// FIRE SOUNDS =========================================//
	level.scr_sound["building_inside_big_sound"] = "housefire02_high";
	level.scr_sound["building_inside_medium_sound"] = "housefire03_high";
	level.scr_sound["building_inside_small_sound"] = "housefire01_high";

	level.scr_sound["wall_fire_top_south_sound"] = "housefire01_high";
	level.scr_sound["wall_fire_top_west_sound"] = "housefire01_high";
	level.scr_sound["wall_fire_top_east_sound"] = "housefire01_high";

	level.scr_sound["wall_fire_full_east_sound"] = "housefire01_high";
	level.scr_sound["wall_fire_full_north_sound"] = "housefire01_high";
	level.scr_sound["wall_fire_full_west_sound"] = "housefire01_high";
	level.scr_sound["wall_fire_full_south_sound"] = "housefire01_high";

	level.scr_sound["fire_small_local_sound"] = "housefire01_high";
	level.scr_sound["distant_fire2tall_smoke_sound"] = "housefire04_high";
	level.scr_sound["distant_fire2_sound"] = "housefire03_high";

	level.scr_sound["fire_tiny_local_sound"] = "housefire01_high";
	level.scr_sound["fire_small_local_sound"] = "housefire01_high";
	level.scr_sound["distant_fire_tall_sound"] = "housefire02_high";
	level.scr_sound["distant_fire3_sound"] = "housefire03_high";

// FIRE EFFECTS  ======================================//                                                                                                                                                                                                  
	maps\_fx_gmi::LoopFx("distant_fire2_smoke", 		(-2950, -3829, 683), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire2tall_smoke", 	(-2925, -3406, 425), 0.6, undefined, undefined, "event4", undefined, "same", 2000);
	// Frontbuilding left           (left,right)                                                                                                         
	maps\_fx_gmi::LoopFx("distant_fire_smoke", 		(-1675, -3276, 325), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire_tall_sound", 	(-906, -3320, -115), 0.6, undefined, undefined, "event4", undefined, "same", 2000);
	//truck                                                                                                                             
	maps\_fx_gmi::LoopFx("fire_small_local_sound", 		(-875, -4425, -135), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	// Frontbuildingrt                                                                                                  
	maps\_fx_gmi::LoopFx("window_fire_a",     		(-280, -3550, 230), 0.3, (-280, -4000, 230), undefined, "event4", undefined, "same", 2000);
	//backbuilding with mg42                                                                                                                          
	maps\_fx_gmi::LoopFx("distant_fire2", 	      		(-2155, 850, 325), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
	//to right of mg42                                                                                                                             
	maps\_fx_gmi::LoopFx("distant_fire4", 	      		(-1325, 318, -143), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	//last building before street                                                                                                                       
	maps\_fx_gmi::LoopFx("distant_fire4", 	      		(-525, 300, 150), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	//corner house above elefant                                                                                                                       
	maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", 	(2822, -1672, 671), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	//backlit window in front of mg//courtyard area                                                                                                  
	maps\_fx_gmi::LoopFx("distant_fire2_sound", 		(900, 3829, 95), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
	//NEW FIRES
	maps\_fx_gmi::LoopFx("building_inside_small", 		(-1146, -2182, -89), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(-1018, -1088, -171), 0.3, undefined, undefined, "event4", undefined, "same", 2000);

	//Around the elefant tank                                                                                                                         
	maps\_fx_gmi::LoopFx("distant_fire2", 			(2328, -1180, -100), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("window_fire_a", 			(1970, -1350, 140), 0.3, (1900, -1348, 200), undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(1967, -1410, 225), 0.3, (1930, -1415, 259), undefined, undefined, undefined, "same", 2000);

//SMOKE============================================//
	//Big smoke                                                                                                                                                    
	maps\_fx_gmi::LoopFx("distant_smoke", 			(2659, -1150, 714), 0.3, undefined, undefined, "evetn4", undefined, "distant_smoke_low", 2000);
	maps\_fx_gmi::LoopFx("distant_smoke", 			(-2437, 4297, 562), 0.3, undefined, undefined, "evetn4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_smoke", 			(-1596, 7256, 785), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	//interior opening                                                                                                                                 
	maps\_fx_gmi::LoopFx("distant_smoke", 			(1767.00, -3350.00, -48.00), 0.3, undefined, undefined, "event4", undefined, "distant_smoke_low", 2000);
	maps\_fx_gmi::LoopFx("distant_smoke", 			(-2863.00, -479.00, 875.00), 0.3, (-2484.00, -648.00, 2000), undefined, "event4", undefined, "distant_smoke_low", 2000);

// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////

// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") < 2)
	{
	// FIRE EFFECTS=========================================//                                                                                                                                                                                                
			maps\_fx_gmi::LoopFx("distant_fire2_smoke", 		(-3339, -6800, 73), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire4_smoke", 		(-3744, -5400, 450), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire4tall_smoke",		(-3451, -1244, 245), 0.6, undefined, undefined, "event4", undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire2", 			(-4132, -260, 1310), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire2", 			(-3933, 153, 1055), 0.6, undefined, undefined, "event4", undefined, "same", 2000);	
		// map opening/	Fronthouse dresser	                                                                                                           
			maps\_fx_gmi::LoopFx("fire_tiny_local_sound", 		(-1177, -6435, -55), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
		// Fronthouse_right of player start
			maps\_fx_gmi::LoopFx("fire_small_local_tall_sound", 	(-411, -5562, -125), 0.6, undefined, undefined, "event4", undefined, "same", 2000);
		// secondhouse                                                                                                                                     
			maps\_fx_gmi::LoopFx("fire_small_local_sound", 		(-925, -5380, -125), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
		//in back of building                                                                                                                             
			maps\_fx_gmi::LoopFx("distant_fire_tall", 		(-375, -3175, -140), 0.4, undefined, undefined, undefined, undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire2", 			(2100, -1700, 400), 0.4, undefined, undefined, undefined, undefined, "same", 2000);
			maps\_fx_gmi::LoopFx("distant_fire4", 			(2100, -2000, 400), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
		//cork 
		//1st build inside left		
			maps\_fx_gmi::LoopFx("distant_fire4", 				(-1518, -3112, -151), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	//GROUND FOG============================================//                                                                                                	                                                                                          
		// secondhouse left                                                                                                                             
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-1118, -5474, -115), .5, undefined, undefined, "event4", undefined);
		// secondhouse front                                                                                                                  
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-1852, -6305, -100), .5, undefined, undefined, "event4", undefined);
		//mg42buildings                                                                                                                      
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-521, -4217, -125), 1, undefined, undefined, "event4", undefined);
		//sgt antanov GET BINOCS                                                                                                               
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(-1700, -2748, -137), .5, undefined, undefined, "event4", undefined);
		//backyard route
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(-999, -1601, -95), 1.5, undefined, undefined, "event4", undefined);
		//road block main srteet left	                                                                                                      
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(620, -2688, -13), 1.75, undefined, undefined, "event4", undefined);
		//second 88 street	                                                                                                              
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(-65, -601, -170), .75, undefined, undefined, "event4", undefined);
		//elephant                                                                                                                           
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(1914, -1490, 175), .75, undefined, undefined, "event4", undefined);
	}                                                                                                                             
// =====END FAST SECTION ==================================== //
}

// Since FX draw through PORTALS... I am trying to optimize the map the best I can...
Delayed_FX()
{
	level waittill("objective 4 start");
	println("^1FX: OBJECTIVE 4 START MET!");

	//behind windowfire//courtyard area                                                                                                              
	maps\_fx_gmi::LoopFx("distant_fire2tall_smoke_sound", 	(250, 4531, 100), 0.4, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(2623, 1711, -26), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4", 			(3192, -630, 146), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4", 			(2752, 1128, -16), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	//below mg42 nest past the blown out wall before te courtyard
	maps\_fx_gmi::LoopFx("distant_fire2_smoke", 		(-321, 4254, 700), 0.4, undefined, undefined, undefined, undefined, "same", 2000);
	//windowfire//courtyard area                                                                                                                     
	maps\_fx_gmi::LoopFx("window_fire_a",     		(338, 4492, 100), 0.3, (500, 4492, 144), undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire2_sound", 		(1402, 3750, 200), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(96, 5484, 374), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4_smoke", 		(-4632, 2501, 569), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4", 			(-2653, 6422, 377), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_medium_sound",  	(-960, 3854, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4_smoke", 		(-1393, 2917, 705), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("distant_fire4_smoke", 		(-770, 6515, 1075), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	//back right//left of courtyard above building you go in                                                                                           
	maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", 	(1637, 6866, 1144), 0.5, undefined, undefined, "event4", undefined, "same", 2000);
	//back courtyard window/upper floor//courtyard area                                                                                               
	maps\_fx_gmi::LoopFx("distant_fire2_sound", 	    	(867, 5665, 416), 0.5, undefined, undefined, "event4", undefined, "same", 2000);

	if(getcvarint("scr_gmi_fast") < 2)
	{
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", 	(3116, 1810, 800), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", 	(2816, 3228, 600), 0.3, undefined, undefined, undefined, undefined, "same", 2000);

		/// --- FOG --- ///
		//tiger spawn	                                                                                                                     
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(188, 2081, -104), 0.5, undefined, undefined, undefined, undefined);
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-468, 1982, 356), 1, undefined, undefined, undefined, undefined);
		//acrossfrom building copied directly out of red square:)                                                                         
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(2390, 412, 26), 1, undefined, undefined, "event4", undefined);
		//across from tiger spawn up`                                                                                                     
		maps\_fx_gmi::LoopFx("ground_fog_left", 		(2319, 2298, -140), 1, undefined, undefined, "event4", undefined);
		//end of far street                                                                                                                             
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-2844, 2396, -115), 1, undefined, undefined, "event4", undefined);
		
	}




	level waittill("objective 4 complete");
	println("^1FX: OBJECTIVE 4 COMPLETE MET!");

	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-446, 4380, 215), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-586, 4760, 215), 0.3, undefined, undefined, "event4", undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(-389, 3712, 275), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_medium", 		(-498, 3652, 253), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_medium_sound",  	(-652, 4178, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-720, 3193, 210), 0.3, undefined, undefined, undefined, undefined, "same", 2000);


	maps\_fx_gmi::LoopFx("distant_fire_smoke", 		(-144, 3336, 100), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small_sound", 	(-391, 4402, 210), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small_sound", 	(-389, 3712, 275), 0.3, undefined, undefined, undefined, undefined, "same", 2000);

	if(getcvarint("scr_gmi_fast") < 2)
	{
		///1st part                                                                                                                                      

		//desktable blockade                                                                                                                                       
		maps\_fx_gmi::LoopFx("wall_fire_top_south",     	(-1022, 4173, 268), 0.3, (-900, 4173, 268), undefined, undefined, undefined, "same", 2000);
		//desktable blockade                                                                                                                                       
		maps\_fx_gmi::LoopFx("wall_fire_full_east",     	(-445, 4337, 268), 0.3, (-445, 4500, 268), undefined, undefined, undefined, "same", 2000);
		//first left room                                                                                                                                          
		maps\_fx_gmi::LoopFx("wall_fire_btm_east",     		(-470, 4609, 268), 0.3, (-470, 4700, 268), undefined, undefined, undefined, "same", 2000);
		//first hall on left	                                                                                                                                   
		maps\_fx_gmi::LoopFx("wall_fire_btm_south",     	(-638, 4751, 268), 0.3, (-500, 4751, 268), undefined, undefined, undefined, "same", 2000);
		//first hall by fire                                                                                                                                       
		maps\_fx_gmi::LoopFx("wall_fire_btm_east",     		(-588, 4225, 268), 0.3, (-588, 4500, 268), undefined, undefined, undefined, "same", 2000);
		//opposite first hall by fire                                                                                                                             
		maps\_fx_gmi::LoopFx("wall_fire_btm_west",     		(-420, 4327, 268), 0.3, (-420, 4000, 268), undefined, undefined, undefined, "same", 2000);
		//wall facing debree                                                                                                                                       
		maps\_fx_gmi::LoopFx("wall_fire_btm_west",     		(-646, 4215, 268), 0.3, (-646, 4000, 268), undefined, undefined, undefined, "same", 2000);
		//small room                                                                                                                                               
		maps\_fx_gmi::LoopFx("wall_fire_btm_west",     		(-936, 3903, 268), 0.3, (-936, 3700, 268), undefined, undefined, undefined, "same", 2000);
		//desk room                                                                                                                                                 
		maps\_fx_gmi::LoopFx("wall_fire_full_south",    	(-1014, 3789, 268), 0.3, (-900, 3789, 268), undefined, undefined, undefined, "same", 2000);
		//desk room                                                                                                                                                 
		maps\_fx_gmi::LoopFx("wall_fire_full_north_sound",    	(-198, 3190, 268), 0.3, (-300, 3190, 268), undefined, undefined, undefined, "same", 2000);

		//post first mg room                                                                                                                                     
		maps\_fx_gmi::LoopFx("wall_fire_btm_south",     	(-687, 3299, 268), 0.3, (-500, 3299, 268), undefined, undefined, undefined, "same", 2000);
		//opposite post first mg room                                                                                                                             
		maps\_fx_gmi::LoopFx("smk_corner_nw_150",     		(-475, 4390, 268), 1, undefined, undefined, undefined, undefined, "same", 2000);
		//first left room                                                                                                                                  
		maps\_fx_gmi::LoopFx("smk_corner_ne_100",     		(-666, 4184, 268), 1, undefined, undefined, undefined, undefined, "same", 2000);
		//small room                                                                                                                                  
		maps\_fx_gmi::LoopFx("smk_corner_ne_150",     		(-968, 3854, 268), 1, undefined, undefined, undefined, undefined, "same", 2000);
		//desk room                                                                                                                                     
		maps\_fx_gmi::LoopFx("smk_hall_east_450", 		(-589, 4768, 268), 0.5, undefined, undefined, undefined, undefined, "same", 2000);
		//first main hall                                                                                                                                
		maps\_fx_gmi::LoopFx("smk_hall_south_450", 		(-112, 4655, 268), 0.5, undefined, undefined, undefined, undefined, "same", 2000);
		//courtyard exit                                                                                                                    
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(73, 4869, 226), .75, undefined, undefined, "event4", undefined);
	}





	level waittill("stop fx event4");
	//Blown Out building part                                                                                                                          
	maps\_fx_gmi::LoopFx("building_inside_big", 		(-2240, 3966, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000); 
	//across way                                                                                                                             
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-1713, 4525, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000); 
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-879, 3963, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_medium_sound",  	(-1735, 4915, 35), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-1380, 4045, 74), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-1990, 3780, 385), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-2056, 4632, 215), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_small", 		(-1190, 5005, 234), 0.3, undefined, undefined, undefined, undefined, "same", 2000);

	if(getcvarint("scr_gmi_fast") < 2)
	{
		//behind blocked way                                                                                                                             
		maps\_fx_gmi::LoopFx("smk_hall_east_450", 		(-1714, 4887, 268), 0.5, undefined, undefined, undefined, undefined, "same", 2000);
		//back pillar hall                                                                                                                                
		maps\_fx_gmi::LoopFx("smk_halllocal_ns_50", 		(-540, 4281, 268), 0.5, undefined, undefined, undefined, undefined, "same", 2000);
		//opposite side                                                                                                                             
		maps\_fx_gmi::LoopFx("smk_corner_nw_150",     		(-2251, 3954, 268), 1, undefined, undefined, undefined, undefined, "same", 2000);  
		//opposite side                                                                                                                                 
		maps\_fx_gmi::LoopFx("smk_corner_ne_150",     		(-2056, 4632, 268), 1, undefined, undefined, undefined, undefined, "same", 2000);  
		//behind piller                                                                                                                                
		//maps\_fx_gmi::LoopFx("wall_fire_btm_south",     	(-1766, 4917, 268), 0.3, (-1500, 4917, 268));	//past behindpiller               
		maps\_fx_gmi::LoopFx("fire_tiny_local", 		(-1658, 4370, 210), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
		//to right                                                                                                                                          
		maps\_fx_gmi::LoopFx("fire_tiny_local", 		(-1480, 4098, 235), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
		//opposite side room                                                                                                                                    
		maps\_fx_gmi::LoopFx("wall_fire_btm_south",     	(-1654, 4463, 268), 0.3, (-1500, 4463, 268), undefined, undefined, undefined,"same", 2000);	
		//piller                                                                                                                                                    
		maps\_fx_gmi::LoopFx("wall_fire_btm_east",     		(-1341, 4105, 268), 0.3, (-1341, 4300, 268), undefined, undefined, undefined, "same", 2000);	
		//to left                                                                                                                                                  
		maps\_fx_gmi::LoopFx("wall_fire_top_east",     		(-2118, 3905, 268), 0.3, (-2118, 4000, 268), undefined, undefined, undefined, "same", 2000);	
		//opposite side room                                                                                                                                    
		maps\_fx_gmi::LoopFx("smk_halllocal_ns_50", 		(-1671, 4926, 268), 0.5, undefined, undefined, undefined, undefined, "same", 2000); 
		//right backhall                                                                                                                                       
		maps\_fx_gmi::LoopFx("smk_halllocal_ns_50", 		(-1654, 4915, 93), 0.5, undefined, undefined, undefined, undefined, "same", 2000); 
		maps\_fx_gmi::LoopFx("smk_corner_nw_150",   		(-2015, 3759, 444), 1, undefined, undefined, undefined, undefined, "same", 2000);
		//opposite side upper level                                                                                                                             
		maps\_fx_gmi::LoopFx("wall_fire_top_south",     	(-2054, 3754, 425), 0.3, (-1900, 3754, 268), undefined, undefined, undefined, "same", 2000);	
		//outdoor courtyard under	                                                                                                                            
		maps\_fx_gmi::LoopFx("wall_fire_btm_south",     	(-1766, 4850, 92), 0.3, (-1600, 4850, 92), undefined, undefined, undefined, "same", 2000);	


		//right backroom bldg side                                                                                                                        
         	maps\_fx_gmi::LoopFx("smk_corner_sw_150", 		(-1191, 4844, 92), 1.0, undefined, undefined, undefined, undefined, "same", 2000);

		// Smoke plume coming up from Debris.                                                                                                             
		maps\_fx_gmi::LoopFx("smoke_plume_debree", 		(-1698, 4130, 40), .6, undefined, undefined, undefined, undefined, "same", 2000);

		//end of level                                                                                                                       
		maps\_fx_gmi::LoopFx("ground_fog_right", 		(-2396, 5792, 74), 0.5, undefined, undefined, undefined, undefined);
	}

	trigger = getent("event4_start_reinforcements","targetname");
	trigger waittill("trigger");

	//right backroom court side
	maps\_fx_gmi::LoopFx("building_inside_medium_sound",  	(-1191, 4844, 35), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_medium_sound",  	(-1445, 5150, 35), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-1488, 5377, 40), 0.3, undefined, undefined, undefined, undefined, "same", 2000); 
	maps\_fx_gmi::LoopFx("building_inside_big_sound", 	(-1621, 5987, 50), 0.3, undefined, undefined, undefined, undefined, "same", 2000); 
}

spawnSoundFX()
{
}