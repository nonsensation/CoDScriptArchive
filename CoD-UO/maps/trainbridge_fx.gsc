//note : have enviromental efx flushed out up until rail where truck gets hit

main()
{
	precacheFX();
	spawnWorldFX();
	spawnSoundFX();
}
precacheFX()
{
// Scripted Events ==========================//
	level._effect["truckRide_explosion"]		= loadfx ("fx/explosions/treeburst_a.efx");		// find where used
	level._effect["truckRide_fire"]			= loadfx ("fx/explosions/vehicles/truck_complete.efx"); // find where used
	level._effect["truckRide_sparks"]		= loadfx ("fx/misc/radio_spark.efx");			//havn't seen this yet
	level._effect["mortar_explosion"]		= loadfx ("fx/weapon/explosions/artillery_grass.efx");
	level._effect["house_wall_explode"]		= loadfx ("fx/weapon/explosions/rocket_plaster.efx");

// Smoke====================================//
	level._effect["chimney_smoke"]			= loadfx ("fx/smoke/smoke_chimney_night.efx");		

// Fire=====================================//
	level._effect["fireplace_fire"]			= loadfx ("fx/fire/fireplace_fire.efx");

// Fog======================================//

	level._effect["fog_500_0"]			= loadfx ("fx/atmosphere/fog_500_0_night.efx");
	level._effect["fog_500_90"]			= loadfx ("fx/atmosphere/fog_500_90_night.efx");
	level._effect["fog_1000_0"]			= loadfx ("fx/atmosphere/fog_1000_0_night.efx");
	level._effect["fog_1000_90"]			= loadfx ("fx/atmosphere/fog_1000_90_night.efx");

	level._effect["fog_locallit_a0"]		= loadfx ("fx/atmosphere/fog_locallit_a0_night.efx");
	level._effect["fog_locallit_a90"]		= loadfx ("fx/atmosphere/fog_locallit_a90_night.efx");
	level._effect["fog_locallit_a180"]		= loadfx ("fx/atmosphere/fog_locallit_a180_night.efx");

// Vlights=================================//
	level._effect["v_light_40_80_yel"]		= loadfx ("fx/atmosphere/v_light_40_80_yel.efx");

// Bugs ===================================//
	level._effect["fireflys_600x600"]		= loadfx ("fx/atmosphere/fireflys_600x600.efx");

// Bridge
	level._effect["bridge_bomb1"]			= loadfx ("fx/map_trainbridge/exp_bridge_01.efx");
	level._effect["bridge_bomb2"]			= loadfx ("fx/map_trainbridge/exp_bridge_02.efx");
	level._effect["bridge_bomb3"]			= loadfx ("fx/map_trainbridge/exp_bridge_03.efx");
	level._effect["bridge_bomb4"]			= loadfx ("fx/map_trainbridge/exp_bridge_04.efx");

	level._effect["bridge_fire_h"]			= loadfx ("fx/map_trainbridge/bridge_fire_h.efx");
	level._effect["bridge_fire_l"]			= loadfx ("fx/map_trainbridge/bridge_fire_l.efx");
	level._effect["bridge_fire_m"]			= loadfx ("fx/map_trainbridge/bridge_fire_m.efx");
	level._effect["bridge_fire_s"]			= loadfx ("fx/map_trainbridge/bridge_fire_s.efx");

	level._effect["bridge_smoke"]			= loadfx ("fx/map_trainbridge/bridge_smoke.efx");

	level._effect["train_trail_smoke"]              = loadfx ("fx/smoke/smoke_trail_100.efx");		
	level._effect["train_water_impact"]             = loadfx ("fx/map_trainbridge/bridge_water_impact.efx");		//temp
	level._effect["train_car_exp"]             	= loadfx ("fx/explosions/treeburst_a.efx");		//temp
	level._effect["train_car_steam"]             	= loadfx ("fx/map_trainbridge/train_exp_steam.efx");	

	level._effect["train_spark"]             	= loadfx ("fx/explosions/treeburst_a.efx");			

}
spawnWorldFX()
{
// REF=====================================================//

	// Map Orentation
	// North	(+, 0, 0)
	// East		(0, -, 0)

// Smoke==================================================//
	// Farm house chimney                                                                 
	maps\_fx_gmi::loopfx("chimney_smoke", 		(-4072, 6515, 720), .6);
// Fire==================================================//
	maps\_fx_gmi::loopfx("fireplace_fire", 		(-4028, 6473, 205), .3);		

	//don't play these efx on low end machines

	if (getcvar("scr_gmi_fast") != 2)
	{
	//volume lights
	// farm house------------------------------------//
	// east wall a
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3295, 6240, 270), 0, (-3295, 6146, 200));
	// east wall b
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3425, 6240, 270), 0, (-3425, 6146, 200));
	// east wall c
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3805, 6240, 270), 0, (-3805, 6146, 200));
//	// east top
//	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3395, 6259, 435), 0, (-3395, 6165, 365));
	// north a
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3193, 6312, 270), 0, (-3099, 6312, 200));
	// north b
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3206, 6443, 270), 0, (-3112, 6443, 200));
	// north c
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3206, 6631, 270), 0, (-3112, 6631, 200));
	// north top
//	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3206, 6528, 435), 0, (-3112, 6528, 365));
//	// west a
//	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3425, 6720, 270), 0, (-3425, 6814, 200));
//	// west b
//	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-3870, 6720, 270), 0, (-3870, 6814, 200));
	// south a
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-4091, 6630, 270), 0, (-4185, 6630, 200));
	// south top
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(-4097, 6575, 435), 0, (-4191, 6575, 365));
	
	// trainstation bldg right ----------------------//
	// win small a
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(1689, 16461, 1255), 0, (1610, 16535, 1175));
	// win big a
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(1767, 16489, 1255), 0, (1767, 16583, 1175));
	// win big b
	maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(1832, 16489, 1255), 0, (1832, 16583, 1175));

	// trainstation bldg left ----------------------//
	//a) THESE VALUES ARE BAD
	//B) I DONT THINK THIS BLDG WILL LOOK GOOD WITH THEM
	//going cc from tunnel to bridge
	// win left a
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3010, 17088, 1496), 0, (2910, 17088, 1396));//check
	// win left b
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3003, 17088, 1496), 0, (2903, 17088, 1396));//check
	// win corner
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3029, 16856, 1496), 0, (2927, 16753, 1396)); // may need 50,50 on north/east
	//win center
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3120, 16753, 1496), 0, (3120, 16653, 1396));//check
	//win corner
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3221, 16875, 1496), 0, (3322, 16672, 1396)); // may need 50,50 on north/east
	// win right a
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3010, 17088, 1496), 0, (3110, 17088, 1396));//check
	// win right b
	//maps\_fx_gmi::OneShotfx("v_light_40_80_yel", 	(3003, 17088, 1496), 0, (3103, 17088, 1396));//check

	// Ground fog==========================================//
	// east west is 0
	// north south is 0

	//STARTING PATH BY LIGHT                                                       
	maps\_fx_gmi::loopfx("fog_1000_90", 		(2411, 1689, 205), .5);
	// COMING OUT OF WOODS TO THE BARNS		                               
	maps\_fx_gmi::loopfx("fog_1000_0", 		(800, 5865, 380), .5);	
	// MEADOW BREAK OTHER SIDE 2ND TUNNEL	                                       
	maps\_fx_gmi::loopfx("fog_1000_90", 		(-5456, 2384, 200), .5);	
	// MEADOW BREAK TO WOOD PATH	                                       
	maps\_fx_gmi::loopfx("fog_500_90", 		(-5045, 10658, 450), 1);	
	// Top WOdd Path	                                       
	maps\_fx_gmi::loopfx("fog_500_90", 		(-2963, 13184, 1000), 1);	//check....
	// train depot running to woods	                                       
	maps\_fx_gmi::loopfx("fog_500_90", 		(679, 13417, 1205), 1);	
	// mid woods going toward house	                                       
	maps\_fx_gmi::loopfx("fog_1000_90", 		(-501, 11566, 1121), .5);
	// hillcrest going toward house	                                       
	maps\_fx_gmi::loopfx("fog_500_90", 		(-1220, 9681, 1019), 1);
	// wood breaking going toward house	                                       
	maps\_fx_gmi::loopfx("fog_500_90", 		(-2730, 8050, 515), 1);	
	// going into WOODS TO THE BARNS	                                       
	//maps\_fx_gmi::loopfx("fog_short_a0", 		(1532, 5164, 539), 1);

	// Lit fog lanterns---------------------------//
	// latern STARTING PATH     CUT                                        
	//maps\_fx_gmi::loopfx("fog_locallit_a90",	(2875, 1360, 240), .75);
	// latern midwood PATH		                                               
	//maps\_fx_gmi::loopfx("fog_locallit_a0",		(1420, 5650, 470), 1.5);		
	// latern next to barn--WO0D SIDE                                              
	//maps\_fx_gmi::loopfx("fog_locallit_a0", 	(10, 5435, 355), .75);			
	// latern next to barn-- HOUSE SIDE                                            
	//maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-1270, 5400, 355), .75);	
	// latern house wall                                                           
	//maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-2995, 5433, 245), .75);		
	// latern next animal pens                                                     
	//maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-2643, 4358, 230), .75);		

	// Lit fog tunnels-----------------------------//
	// FIRST TUNNEL PAST HOUSES                                                    
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-6811, 10065, 390), 1);
	// FIRST TUNNEL		                                                       
	maps\_fx_gmi::loopfx("fog_locallit_a90", 	(-190, -1880, 205), 1);	
	// 2ND TUNNEl		                                                       
	maps\_fx_gmi::loopfx("fog_locallit_a180", 	(-1440, 380, 205), 1);	
	// 2ND TUNNEL OTHER SIDE		                                       
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-3235, 385, 206), 1);	
	// TUNNEL LEFT SIDE TOP HILL		                                       
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-5733, 16768, 1440), 1);
	// TUNNEL RIGHT SIDE TOP HILL		                                       
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(-2044, 16768, 1440), 1);
	// TUNNEL DEPOT		                                                       
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(377, 16767, 1440), 1);	
	// TUNNEL FAR TRACKS		                                               
	maps\_fx_gmi::loopfx("fog_locallit_a0", 	(11040, 16770, 1440), 1);
	// TUNNEL SMALL BRIDGE		                                               
	maps\_fx_gmi::loopfx("fog_locallit_a90", 	(4032, 10415, 525), 1);	
	// TUNNEL SMALL BRIDGE other side		                               
	maps\_fx_gmi::loopfx("fog_locallit_a90", 	(3136, 6761, 520), 1);

	// Bugs==============================================//
	//Start                                                                        
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-187, 246, 85), .75);
	//Start     hiding spot                                                        
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-214, 1246, 175), .75);
	//STARTING PATH BY LIGHT                                                       
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(2307, 1769, 200), .75);
	// First woods path                                                            
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(1980, 5600, 490), .75);
	// farm house right                                                            
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-2050, 6836, 304), .75);
	// farm house pens                                                             
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-3158, 3794, 269), .75);
	// Wood path entrence                                                          
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-5389, 9396, 294), .5);
	// Wood path base                                                              
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-4987, 10590, 450), .3);
	// Wood path mid                                                               
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-4219, 11284, 510), .3);
	// Wood path top                                                               
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-3197, 11763, 644), .75);
	// wood path plateu before tunnels                                             
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-3160, 14231, 974), .75);
	// trainstation hub                                                            
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(1986, 15755, 1200), .75);
	// before plunger                                                              
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(3910, 17752, 1375), .75);
	// train depot running to woods	                                               
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-101, 12111, 1200), .75); 	
	// train depot running to woods	                                               
	maps\_fx_gmi::loopfx("fireflys_600x600", 	(-1346, 9585, 1030), .75); 		
	}
}

spawnSoundFX()
{
	// farmhouse fireplace
	maps\_fx_gmi::loopSound("fireplace", (-3977,6468,232));
	// river near road
	maps\_fx_gmi::loopSound("waterlap", (4628,2256,-19));
	maps\_fx_gmi::loopSound("waterlap", (4269,4601,-19));
	maps\_fx_gmi::loopSound("waterlap", (4871,6591,-19));
	// under bridge
	maps\_fx_gmi::loopSound("waterlap_bridge", (5272,16660,-50));
	maps\_fx_gmi::loopSound("waterlap_bridge", (6128,16839,-50));
	maps\_fx_gmi::loopSound("waterlap_bridge", (7226,16763,-50));
	maps\_fx_gmi::loopSound("waterlap_bridge", (7896,16744,-50));

}
