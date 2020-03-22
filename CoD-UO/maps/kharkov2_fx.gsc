main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{
		// Used for the fuelcars fire.
		level.scr_sound["distant_fire2_sound"] = "truckfire_high";
		level.scr_sound["distant_fire2_smoke_sound"] = "truckfire_high";

// TREADS ===============================//
		level._effect["treads_grass"]			= loadfx ("fx/vehicle/wheelspray_gen_grass.efx");
		level._effect["treads_sand"] 			= loadfx ("fx/vehicle/wheelspray_gen_sand.efx");
		level._effect["treads_dirt"] 			= loadfx ("fx/vehicle/wheelspray_gen_dirt.efx");

// Explosions ===========================//

	//cut?  Building Explosions in Event1
		level._effect["event1_building_1"] 		= loadfx ("fx/map_kharkov1/exp_concrete.efx");
		level._effect["event1_building_2"] 		= loadfx ("fx/map_kharkov1/exp_redbrick.efx");
	// Building1 Effects
		level._effect["building1_explosion"]		= loadfx ("fx/map_kharkov2/building1_explosion.efx");
	// Building2 Effects
		level._effect["building2_dust"]			= loadfx ("fx/map_kharkov2/building2_basement.efx");
		level._effect["building2_glass"]		= loadfx ("fx/map_kharkov2/building2_glass.efx");
	// Blockade explosion Effect
		level.blockade 					= loadfx ("fx/explosions/artillery/pak88.efx");
	// Mortar Effect
		level.mortar 					= loadfx ("fx/explosions/artillery/pak88.efx");
		level._effect["mortar"] 			= loadfx ("fx/explosions/artillery/pak88.efx");
		
	// Mortar Effect (Low)
		level.mortar_low				= loadfx ("fx/explosions/artillery/pak88_low.efx");
		level._effect["mortar_low"] 			= loadfx ("fx/explosions/artillery/pak88_low.efx");	
	// Precahce of the FlakVierling Explosion
		level._effect["flakvierling_death"]    		= loadfx( "fx/explosions/vehicles/flakvierling_complete.efx" );
	// Stuka Bomb Effect
		level.stuka_bomb 				= loadfx ("fx/explosions/vehicles/stuka_bomb.efx");
	//cut?  //Tiger tank blowing wall at end of map.
		level._effect["debris_trail_50"]		= loadfx ("fx/dirt/dust_trail_50.efx");
		level._effect["debris_trail_25"]		= loadfx ("fx/dirt/dust_trail_25.efx");
		level._effect["debris_trail_15"]		= loadfx ("fx/dirt/dust_trail_15.efx");
		level._effect["debris_trail_100"]		= loadfx ("fx/dirt/dust_trail_100.efx");
	// Carcruch
		level._effect["carcrush"]			= loadfx ("fx/map_kharkov2/carcrush.efx");

	// Flak air effects.
		level._effect["flak_air_exp"] 			= loadfx ("fx/explosions/artillery/flak_single_400_low.efx");

	// Trolley Explosion Effects
		level._effect["trolley_exp"]			= loadfx ("fx/map_kharkov2/exp_trolly.efx");

	// Water_Tower_BASE Explosion Effects
		level._effect["watertower_base"]		= loadfx ("fx/map_kharkov2/exp_watertower_base.efx");

	// Water_Tower_Top Explosion Effects
		level._effect["watertower_top"]			= loadfx ("fx/map_kharkov2/exp_watertower_top.efx");

	// Exp_warehouse Explosion Effects
		level._effect["warehouse_exp"]			= loadfx ("fx/map_kharkov2/exp_warehouse.efx");

	// Exp_littlehouse Explosion Effects
		level._effect["littlehouse_exp"]		= loadfx ("fx/map_kharkov2/exp_littlehouse.efx");

	// Factory wall
		level._effect["factory_wall"]	 		= loadfx ("fx/map_kharkov1/exp_concrete.efx");

// Atmosphere ==========================//

	// Smoke Effect
		level._effect["distant_smoke"]			= loadfx ("fx/smoke/tank_med_long_high.efx");
		level._effect["distant_smoke_low"]		= loadfx ("fx/smoke/tank_med_long_low.efx");
		level._effect["train_smoke"]			= loadfx ("fx/map_kharkov2/exhaust_train_moving.efx");
		level._effect["smoke_smolder_med"]		= loadfx ("fx/smoke/smoke_plume_debree_med");
		level._effect["smoke_smolder_lrg"]		= loadfx ("fx/smoke/smoke_plume_debree_lrg.efx");

	// fire effect
		level._effect["distant_fire4"]			= loadfx ("fx/fire/building_fire_big_3.efx");
		level._effect["distant_fire2_smoke"]		= loadfx ("fx/fire/building_fire_big_2s.efx");
		level._effect["distant_fire_smoke"]		= loadfx ("fx/fire/building_fire_bigs.efx");
		level._effect["distant_fire2"]			= loadfx ("fx/fire/building_fire_big_2.efx");
		level._effect["distant_fire4tall_smoke"]	= loadfx ("fx/fire/building_fire_big_4ts.efx");
		level._effect["fire_small_local"]		= loadfx ("fx/fire/fire_small_local.efx");

	// ground fog
	if (getcvarint("scr_gmi_fast") < 2)
	{
		level._effect["ground_fog_north"]		= loadfx ("fx/atmosphere/fog_right.efx");
		level._effect["ground_fog_south"]		= loadfx ("fx/atmosphere/fog_left.efx");
		level._effect["ground_fog_west"]		= loadfx ("fx/atmosphere/fog_up.efx");
	}

	// Distant lights.
		//level._effect["distant_light"]			= loadfx ("fx/map_trenches/mortar_mz.efx");

// MISC ===============================//

	// Fake FX for tanks firing
		level.fake_turret_fx 				= loadfx ("fx/muzzleflashes/turretfire.efx");
	// AntiAir fx.
		//level._effect["antiair_tracers"]		= loadfx ("fx/atmosphere/antiair_tracers.efx");
	// He111 Impacts
		level._effect["he111_impact"]			= loadfx ("fx/weapon/impacts/impact_lowlod_umg.efx");
	// SAMPLE Effect
		level._effect["sample_name"]			= loadfx ("fx/smoke/tank_med_long_high.efx");

//		level._effect["svt40"]				= loadfx("fx/weapon/muzzleflash/mf_svt40.efx");

		level.flame_particle 				= loadfx("fx/fire/fire_trail_25");

	// Mainly for fuel cars
		level._effect["distant_fire2_sound"]		= loadfx ("fx/fire/building_fire_big_2.efx");
		level._effect["distant_fire2_smoke_sound"]	= loadfx ("fx/fire/building_fire_big_2s.efx");


	// END SEQUENCE
//the main crash spawned at the center of all that wood and stuff
	level._effect["train_impact"]				= loadfx ("fx/map_kharkov2/train_impact.efx");
//played where we want steam coming out--- right now has a forward vector,  you could point it or we could give it a absolute world vector.
	level._effect["train_side_steam"]				= loadfx ("fx/map_kharkov2/train_side_steam.efx");
//to be spawned on the side where the camera passes through--- probably pretty far ahead so it fades in ok----the life will need adjusted to make it work good
	level._effect["train_side_wind"]			= loadfx ("fx/map_kharkov2/train_side_wind.efx");
//a sparking affect with a forward vector
	level._effect["train_sparks"]				= loadfx ("fx/map_kharkov2/train_sparks.efx");

	level._effect["stuka_death"]				= loadfx ("fx/explosions/vehicles/stuka_complete.efx");
	
	if (getcvarint("scr_gmi_fast") < 1)
	{
		// Distant lights.
		level._effect["distant_light"]			= loadfx ("fx/map_trenches/mortar_mz.efx");
		level._effect["antiair_tracers"]		= loadfx ("fx/atmosphere/antiair_tracers.efx");
	}
}

spawnWorldFX()
{
// REF ===============================//
	//	North	( +, x, x)
	//	EAST	( x, -, x)


// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////

// FIRE ==============================//

	// inside spawn point building
		maps\_fx_gmi::LoopFx("distant_fire_smoke", (-1800, 325, 90), .35, undefined, undefined, undefined, undefined, "same", 1024);	
	//on 2nd street on left distant facade
	//	maps\_fx_gmi::LoopFx("distant_fire4", (-6850, 2800, 1340), .5, undefined, undefined, undefined, undefined, "same", 1024);
	// Train Yard, Derailed cars
		maps\_fx_gmi::LoopFx("distant_fire2_smoke", (2168,9423,-130), 0.4, undefined, undefined, "stop fuel fire", undefined, "same", 1024);
		maps\_fx_gmi::LoopFx("distant_fire2_smoke", (5343,9429,-110), 0.4, undefined, undefined, undefined, undefined, "same", 1024);

//		maps\_fx_gmi::LoopFx("distant_fire2_smoke", (2292,10006,-96), 0.4, undefined, undefined, undefined, undefined, "same", 2000);

	// In first building on Right on stairs.
		maps\_fx_gmi::LoopFx("distant_fire_smoke", (-1436, 1313, 0), .35, undefined, undefined, undefined, undefined, "same", 1024);	
	// In first building on Right, in busted hallway
		maps\_fx_gmi::LoopFx("distant_fire_smoke", (-1119, 1576, -92), .35, undefined, undefined, undefined, undefined, "same", 1024);	
	// In first building on Right, just before exiting the building
		maps\_fx_gmi::LoopFx("distant_fire_smoke", (-609, 1606, -89), .35, undefined, undefined, undefined, undefined, "same", 1024);	

	// In factory, in right corner
		maps\_fx_gmi::LoopFx("distant_fire_smoke", (3598, 8473, 54), .35, undefined, undefined, undefined, undefined, "same", 1024);	

	// On Crashed He111
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", (369, 8189, -98), 0.35, undefined, undefined, undefined, undefined, "same", 2000);

// SMOKE ============================//

	//distant facade to the left at spawn point
	//	maps\_fx_gmi::LoopFx("distant_smoke_low", (-2506, -4190, 1248), .5, undefined, undefined, undefined, undefined, "same", 1024);	
	//on 2nd street , near end car on right
	//	maps\_fx_gmi::LoopFx("smoke_smolder_med", (259, 2000, -150), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//main square facade,  if looking from the entrance to main square its to the back left
	//	maps\_fx_gmi::LoopFx("distant_smoke_low", (-1882, 6864, 539), .5, undefined, undefined, undefined, undefined, "same", 1024);
	// trainyard-- bldg behind warehouse
	//	maps\_fx_gmi::LoopFx("distant_smoke_low", (1904, 13517, 360), .75, undefined, undefined, undefined, undefined, "same", 1024);


// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////


// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") < 2)
	{	
	//on 2nd street on left distant facade
		maps\_fx_gmi::LoopFx("distant_fire4", (-6850, 2800, 1340), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//distant facade to the left at spawn point
		maps\_fx_gmi::LoopFx("distant_smoke_low", (-2506, -4190, 1248), .5, undefined, undefined, undefined, undefined, "same", 1024);	
	//on 2nd street , near end car on right
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (259, 2000, -150), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//main square facade,  if looking from the entrance to main square its to the back left
		maps\_fx_gmi::LoopFx("distant_smoke_low", (-1882, 6864, 539), .5, undefined, undefined, undefined, undefined, "same", 1024);
	// trainyard-- bldg behind warehouse
		maps\_fx_gmi::LoopFx("distant_smoke_low", (1904, 13517, 360), .75, undefined, undefined, undefined, undefined, "same", 1024);

// FOG ===============================//

	// start of map to the left
		maps\_fx_gmi::LoopFx("ground_fog_west", (-2351, -150, -85), .5, undefined, undefined, undefined, undefined);
	// second street left blocade
		maps\_fx_gmi::LoopFx("ground_fog_north", (-3731, 2279, 70), .75, undefined, undefined, undefined, undefined);	
	// second street on hill
		maps\_fx_gmi::LoopFx("ground_fog_north", (-500, 2313,-8), 1.25, undefined, undefined, undefined, undefined);
	// main square going into from right
		maps\_fx_gmi::LoopFx("ground_fog_south", (4398, 4690,60), 1, undefined, undefined, undefined, undefined);
	// main square going into from right
		maps\_fx_gmi::LoopFx("ground_fog_north", (-143, 4134,50), 1, undefined, undefined, undefined, undefined);
	// main square going connect
		maps\_fx_gmi::LoopFx("ground_fog_south", (3414, 7326, 180), 1, undefined, undefined, undefined, undefined);
	// main square statue
		maps\_fx_gmi::LoopFx("ground_fog_south", (2500, 4825, -80), 1, undefined, undefined, undefined, undefined);

// FIRE ==============================//

	// start of map in front of player on distant facade
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", (-3855, 1403, 1040), .5, undefined, undefined, undefined, undefined, "same", 1024);	
	//on 2nd street, overturned truck
		maps\_fx_gmi::LoopFx("fire_small_local", (-1892, 1985, -115), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//on 2nd street, distant building burning
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", (3225, 3078, 448), .3, undefined, undefined, undefined, undefined, "same", 1024);
	//main square entrance burning desk
		maps\_fx_gmi::LoopFx("fire_small_local", (2775, 2890, 160), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//main square trolly near front
		maps\_fx_gmi::LoopFx("fire_small_local", (2225, 4235, -150), .3, undefined, undefined, undefined, undefined, "same", 1024);
	//train yard---- far left facade
		maps\_fx_gmi::LoopFx("distant_fire4tall_smoke", (-5886, 13122, 700), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//main square-- bldg opposit trollys
	//	maps\_fx_gmi::LoopFx("distant_fire2", (3061, 6723, 700), .3, undefined, undefined, undefined, undefined);

// SMOKE ============================//
	
	//on 2nd street on left blocade
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (-3877, 2140, 100), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//on 2nd street , next to first exp buidling
		maps\_fx_gmi::LoopFx("smoke_smolder_lrg", (-435, 3000, 225), .5, undefined, undefined, undefined, undefined, "same", 1024);	
	//looking at second street on first street to the right of the hotel
		maps\_fx_gmi::LoopFx("distant_smoke_low", (-2095, 3332, 495), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//main square facade,  if looking from the entrance to main square its to the back right
		maps\_fx_gmi::LoopFx("distant_smoke_low", (5092, 7000, 1434), .5, undefined, undefined, undefined, undefined, "same", 1024);
	//mian square bookcase near front
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (2329, 3407, -50), .5, undefined, undefined, undefined, undefined, "same", 1024);		
	//mian square trolly on left side
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (446, 4773, 0), .5, undefined, undefined, undefined, undefined, "same", 1024);		
	//very distant smoke you can see shooting down the bombers on the flakverling gun, right now the cull distance turns it off though
		maps\_fx_gmi::LoopFx("distant_smoke_low", (-7355, 6235, 1140), .75, undefined, undefined, undefined, undefined, "same", 1024);
	//main square searchlight
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (904, 6557, -137), .5, undefined, undefined, undefined, undefined, "same", 1024);		
	//main square, springfield blgd
		maps\_fx_gmi::LoopFx("smoke_smolder_med", (742, 3417, -124), .5, undefined, undefined, undefined, undefined, "same", 1024);		
	// trainyard--  south woodline
		maps\_fx_gmi::LoopFx("distant_smoke_low", (-6019, 8550, 315), .75, undefined, undefined, undefined, undefined, "same", 1024);
	}

// =====END FAST SECTION ====================================//
//////////////////////////////////////////////////////////////
}

spawnSoundFX()
{
}