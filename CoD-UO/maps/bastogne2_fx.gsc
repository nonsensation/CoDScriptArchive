//
// Map: Bastogne2
//

main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{
// Events =================================//

	level._effect["event1_bmw_headlight"]		= loadfx ("fx/vehicle/bmw_headlight.efx");
	level._effect["event2_flare"]			= loadfx ("fx/map_bastogne2/flare_field.efx");
	level._effect["pak43_death"]			= loadfx( "fx/explosions/vehicles/generic_complete.efx" );
	level._effect["blast_powned"]			= loadfx( "fx/map_bastogne1/hit_snowbank.efx" );
	level._effect["blast_powned2"]			= loadfx( "fx/map_noville/basement_exp.efx" );
	//glass and explostion effect for window being blown out behind the guy in room
	level._effect["building2_glass"]		= loadfx ("fx/map_kharkov2/building2_glass.efx");

// Atmosphere =============================//
	level._effect["distant_light"]			= loadfx ("fx/map_trenches/mortar_mz.efx");

	level._effect["fog_west"]			= loadfx ("fx/atmosphere/snowgroundfog_n_up.efx");
	level._effect["fog_south"]			= loadfx ("fx/atmosphere/snowgroundfog_n_left.efx");
	level._effect["fog_north"]			= loadfx ("fx/atmosphere/snowgroundfog_n_right.efx");
	level._effect["fog_east"]			= loadfx ("fx/atmosphere/snowgroundfog_n_down.efx");


// Fire ===============================//

	level._effect["barreloil_fire"]			= loadfx ("fx/fire/barreloil_fire.efx");
}
spawnworldfx()
{
// REF ===================================//
//	west	(0, +, 0)
//	north	(+, 0, 0)
// =======================================//

// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////

	// In front of tent
//		maps\_fx_gmi::LoopFx("fog_west", (5100, -9172, 112), .3);
	// Barrel Fires
		maps\_fx_gmi::loopfx("barreloil_fire", (4500, -9067, 50), .3);
		maps\_fx_gmi::loopfx("barreloil_fire", (6509, 1987, -24), .3);
		maps\_fx_gmi::loopfx("barreloil_fire", (7475, 2990, 3), .3);
		maps\_fx_gmi::loopfx("barreloil_fire", (15485, 6187, 0), .3);
		maps\_fx_gmi::loopfx("barreloil_fire", (6075, 3001, 5), .3);
// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////

// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") == 0)
	{

// Fog ===================================//
		maps\_fx_gmi::LoopFx("fog_west", (5100, -9172, 112), .3);

	// on the ridge seen corssing the first field
		maps\_fx_gmi::LoopFx("fog_south", (7187, -5429, 279), .3);
	// none  behind the first mg42 nest
		maps\_fx_gmi::LoopFx("fog_south", (7717, -2237, 227), .3);
	// on the hill of the ravine to the right of the first mg42 nest
		maps\_fx_gmi::LoopFx("fog_west", (10460, -2234, 520), .3);
	// on hill top on ridge to left heading to the farmhouse
		maps\_fx_gmi::LoopFx("fog_south", (8605, -1255, 344), .3);
	// on hill top on ridge to right heading to the farmhouse
		maps\_fx_gmi::LoopFx("fog_south", (9776, 418, 275), .3);
	// on hill past farm house on right
		maps\_fx_gmi::LoopFx("fog_south", (7754, 4907, 304), .3);
	// on hill on right above the road
		maps\_fx_gmi::LoopFx("fog_east", (9686, 7587, 400), .3);
	// crossroads - to the behind the the houses
		maps\_fx_gmi::LoopFx("fog_west", (16527, 7059, 50), .3);
	// crossroads - to the right of, across the road
		maps\_fx_gmi::LoopFx("fog_north", (13879, 3221, 111), .3);
	// crossroads - to the right of the houses
		maps\_fx_gmi::LoopFx("fog_west", (15329, 3910, 170), .3);

//=======================================//
	}

// =====END FAST SECTION ====================================//
//////////////////////////////////////////////////////////////
}

spawnSoundfx()
{
	//wind blowing tent flap
	maps\_fx_gmi::loopSound("tent_flap_wind", (4475, -9008, 174));
	//Barrel fires
	maps\_fx_gmi::loopSound("barrelfire", (4500, -9067, 50));
	maps\_fx_gmi::loopSound("barrelfire", (6509, 1987, -24));
	maps\_fx_gmi::loopSound("barrelfire", (7475, 2990, 3));
	maps\_fx_gmi::loopSound("barrelfire", (15485, 6187, 0));
	maps\_fx_gmi::loopSound("barrelfire", (6075, 3001, 5));
	
}