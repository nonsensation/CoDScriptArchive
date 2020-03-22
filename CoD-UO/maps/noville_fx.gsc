//
// Map: Noville
// Edited by: JoeC

main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{
	// GENERIC
	level._effect["mortar_explosion"]		= loadfx ("fx/explosions/artillery/pak88.efx");       	//temp till get noville.
	level._effect["bell_tower_exp"]			= loadfx ("fx/map_foy/belltower_exp.efx");		//is this being used?
	level._effect["88_building1"]			= loadfx ("fx/map_foy/88_building1.efx");		//is this being used?
	level._effect["ceiling_dust"]			= loadfx ("fx/maP_noville/basement_ceiling_dust.efx");

	//EVENTS
	level._effect["street_wall"]			= loadfx ("fx/maP_noville/street_wall.efx");		
	level._effect["stairs"]				= loadfx ("fx/maP_noville/stairs.efx");			
	level._effect["ceiling_trap"]			= loadfx ("fx/maP_noville/ceiling_trap.efx");		
	level._effect["basement"]			= loadfx ("fx/maP_noville/basement_exp.efx");		
	level._effect["building_corner"]		= loadfx ("fx/maP_noville/building_corner.efx");	
	level._effect["chateau_front"]			= loadfx ("fx/maP_noville/chateau_front.efx");	 	
	level._effect["chateau_corner"]			= loadfx ("fx/maP_noville/chateau_corner.efx");		

	// ATMOSPHERE
	level._effect["fog_right"]			= loadfx ("fx/atmosphere/snowfog_right.efx");
	level._effect["fog_left"]			= loadfx ("fx/atmosphere/snowfog_left.efx");
	level._effect["fog_left_air"]			= loadfx ("fx/atmosphere/snowfog_left_air.efx");
	level._effect["fog_left_light"]			= loadfx ("fx/atmosphere/snowfog_left_light.efx");
	level._effect["fog_left_distant"]		= loadfx ("fx/atmosphere/snowfog_left_distant.efx");
	level._effect["fog_left_skinny"]		= loadfx ("fx/atmosphere/snowfog_left_skinny.efx");
	level._effect["fog_right_singleseed"]		= loadfx ("fx/atmosphere/snowfog_right_singleseed.efx");
	level._effect["fog_rooftop_left"]		= loadfx ("fx/atmosphere/snowfog_rooftop_left.efx");
	level._effect["v_light_100_235_blu"]		= loadfx ("fx/atmosphere/v_light_100_235_blu.efx");

	// FIRE
	level._effect["distant_fire_smoke"]		= loadfx ("fx/fire/building_fire_bigs.efx");
	level._effect["distant_fire"]			= loadfx ("fx/fire/building_fire_big.efx");
	level._effect["distant_smoke"]			= loadfx ("fx/smoke/tank_med_long_high.efx");
	level._effect["distant_smoke_low"]		= loadfx ("fx/smoke/tank_med_long_low.efx");
	level._effect["fire_small_local"]		= loadfx ("fx/fire/fire_small_local.efx");
	level._effect["fire_tiny_local"]		= loadfx ("fx/fire/fire_tiny_local.efx");
	level._effect["fireplace_fire"]			= loadfx ("fx/fire/fireplace_fire_small.efx");
	level._effect["barreloil_fire"]			= loadfx ("fx/fire/barreloil_fire.efx");
}

spawnworldfx()
{
// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////

// SMOKE											
	//behind tank ride									
	maps\_fx_gmi::LoopFx("distant_smoke_low", (-740, -6380, 188), .75);
	//distant smoke on left side past first blockade						
	maps\_fx_gmi::LoopFx("distant_smoke", (-2573, -2311, 282), .75);
	//distant square bldg on left--- past steeple--- before alamo				
	maps\_fx_gmi::LoopFx("distant_smoke_low", (-1999, 3251, 350), .75);
// FIRE												
	// first building on left on tank ride							
	maps\_fx_gmi::LoopFx("distant_fire_smoke", (-230, -2604, 100), .2);
	// german jeep on main street near blockade						
	maps\_fx_gmi::LoopFx("fire_small_local", (168, 359, 110), .4);
	// fire in hotel
	maps\_fx_gmi::LoopFx("distant_fire", (-538, 4167, 350), .3);
	// fireplace alamo 1st floor								
	maps\_fx_gmi::loopfx("fireplace_fire", (417, 6470, 212), .3);		
	// fireplace alamo 2nd floor right							
	maps\_fx_gmi::loopfx("fireplace_fire", (125, 6944, 406), .3);		
	// fireplace alamo 2nd floor left							
	maps\_fx_gmi::loopfx("fireplace_fire", (-766, 6475, 406), .3);
	// barrel fire in front of chateau
	maps\_fx_gmi::loopfx("barreloil_fire", (-33, 6129, 110), .3);
	maps\_fx_gmi::loopfx("barreloil_fire", (-561, 6058, 92), .3);
// FOG												
	// rooftop of first house								
	maps\_fx_gmi::LoopFx("fog_rooftop_left", (400, -350, 250), .4);
	// roof top opposite tiger blockade by chatau						
	maps\_fx_gmi::LoopFx("fog_rooftop_left", (750, 4730, 550), .3);
	// back alamo right center roof								
	maps\_fx_gmi::LoopFx("fog_rooftop_left", (256, 8661, 235), .4);

// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////

// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") < 2)
	{
// FOG												

	// behind tanks on initial tank ride							
	maps\_fx_gmi::LoopFx("fog_right", (-570, -3624, 175), .3);
	// behind tanks on initial tank ride initial seeding					
	maps\_fx_gmi::OneShotfx("fog_right_singleseed", (-270, -3924, 75), 0.0 );
	// back house on right of tank ride by water tower					
	maps\_fx_gmi::LoopFx("fog_left", (2079, -3925, 143), .4);	
	// right of initial tank ride								
	maps\_fx_gmi::LoopFx("fog_left", (575, -2280, 50), .2);	
	// left of tank rest at blockade with flak tank						
	maps\_fx_gmi::LoopFx("fog_left_air", (-466, -1530, 150), .6);
	// right of tank rest at blockade at first house					
	maps\_fx_gmi::LoopFx("fog_left", (1365, -1040, 150), .2);
	// alley outside first house								
	maps\_fx_gmi::LoopFx("fog_left_skinny", (1285, 300, 250), .5);
	// on top of house with blown out inside wall						
	maps\_fx_gmi::LoopFx("fog_rooftop_left", (800, 1200, 400), .3);
	// opposite side of street at blockade where truck is overturned			
	maps\_fx_gmi::LoopFx("fog_right", (-821, 2302, 200), .75);	
	// tiger blockade by chatau								
	maps\_fx_gmi::LoopFx("fog_right", (-1467, 5583, 200), 7);
	// alamo front wall									
	maps\_fx_gmi::LoopFx("fog_left_light", (320, 5345, 175), .5);
	// first right turn at alamo past fence							
	maps\_fx_gmi::LoopFx("fog_left", (1750, 5700, 100), .3);
	// back alamo right right								
	maps\_fx_gmi::LoopFx("fog_left", (1405, 8611, 141), .4);
	// back alamo right distant								
	maps\_fx_gmi::LoopFx("fog_left_distant", (1430, 10250, 134), .4);
	// back alamo left distant								
	maps\_fx_gmi::LoopFx("fog_left_distant", (-2018, 11036, 188), .4);
	// back alamo left field coverage							
	maps\_fx_gmi::LoopFx("fog_left", (-919, 8554, 150), .4);		

// V Light											

	//alamo center room									
	maps\_fx_gmi::OneShotfx("v_light_100_235_blu", 	(-183, 6661, 532), 0, (-183, 6661, 000));	

// FIRE												
	
	// burning truck on right of initial tank ride						
	maps\_fx_gmi::LoopFx("distant_fire_smoke", (2040, -2788, 165), .3);	
	// burning jeep past first blockade on right next to tiger				
	maps\_fx_gmi::LoopFx("fire_small_local", (1716, -771, 175), .4);
	// blown wall in busted building							
	maps\_fx_gmi::LoopFx("fire_tiny_local", (738, 1122, 135), .3);	
	// alamo left behind "shed"								
	maps\_fx_gmi::LoopFx("distant_fire_smoke", (-2942, 8937, 145), .4);

// SMOKE											
		
	//down street past first blockade on right						
	maps\_fx_gmi::LoopFx("distant_smoke", (4360, 1865, 450), .75);
	//steeple type bldg on left side map							
	maps\_fx_gmi::LoopFx("distant_smoke_low", (-1730, 40, 380), .75);
	//right past steeple house with opened wall						
	maps\_fx_gmi::LoopFx("distant_smoke_low", (-643, 1300, 50), .75);
	//alamo left side distant building							
	maps\_fx_gmi::LoopFx("distant_smoke_low", (-2820, 7385, 145), .75);

	}

// =====END FAST SECTION ====================================//
//////////////////////////////////////////////////////////////
}

spawnSoundFX()
{
	// fires
	maps\_fx_gmi::loopSound("roadside_fire", (-231, -2593, 156));
	maps\_fx_gmi::loopSound("smallfire", (160, 350, 154));
	maps\_fx_gmi::loopSound("smallfire", (740, 1124, 147));
	maps\_fx_gmi::loopSound("big_smoldering_fire", (-653, 1273, 156));
	maps\_fx_gmi::loopSound("barrelfire", (-33, 6129, 127));
	maps\_fx_gmi::loopSound("barrelfire", (-561, 6058, 106));
	// fireplaces
	maps\_fx_gmi::loopSound("fireplace", (397, 6464, 240));
	maps\_fx_gmi::loopSound("fireplace", (142, 6943, 440));
	maps\_fx_gmi::loopSound("fireplace", (-762, 6473, 440));
}