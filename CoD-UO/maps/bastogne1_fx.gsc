//
// Map: Bastogne1
// Edited by: Jesse
//

main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{

// Atmosphere ===================//
	level._effect["jeep_snow"]			= loadfx ("fx/map_bastogne1/hood_snoweffect.efx");
	level._effect["fog_west"]			= loadfx ("fx/atmosphere/snowgroundfog_left.efx");
	level._effect["fog_north"]			= loadfx ("fx/atmosphere/snowgroundfog_up.efx");

	level._effect["fog2_south"]			= loadfx ("fx/atmosphere/snowgroundfogb_left.efx");

// Events =======================//
	level._effect["snow_bank_hit"]			= loadfx ("fx/map_bastogne1/hit_snowbank.efx");

// MISC =========================//
	level._effect["haystackexplosion"]		= loadfx ("fx/map_foy/haystack_explode.efx");
	level._effect["barn_dust"]			= loadfx ("fx/map_bastogne1/barn_dust.efx");
	level._effect["orange_smoke"]			= loadfx ("fx/smoke/smoke_grenade_orange.efx");
	level._effect["gray_smoke"]			= loadfx ("fx/smoke/smoke_grenade.efx");
}

spawnworldfx()
{
// REF =========================//

	// Map Orientation
	// North	(0, +, 0)
	// East		(+, 0, 0)

// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////
	
// FOG ===================//

	//opening scene
		maps\_fx_gmi::LoopFx("fog2_south", (3678, 15900, 247), .5);

// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////

// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") < 2)
	{
// FOG ===================//

	// 1st rigde,  far right by mg34 gunner
		maps\_fx_gmi::LoopFx("fog_west", (2531, -4843, 240), .5);
	// 1st rigde,  mid right and center a
		maps\_fx_gmi::LoopFx("fog_west", (1824, -4650, 168), .5);
	// 1st rigde,  mid right and center b
		maps\_fx_gmi::LoopFx("fog_west", (1213, -4517, 113), .5);
	// 1st rigde,  center by mg34 gunner
		maps\_fx_gmi::LoopFx("fog_west", (29, -4453, 200), .5);
	// 1st rigde,  left by mg34 gunner
		maps\_fx_gmi::LoopFx("fog_west", (-1117, -4400, 270), .5);
	// 2nd ridge, looking out on field at first bazzoka point, by hastack
		maps\_fx_gmi::LoopFx("fog_west", (4826, -6692, 43), .5);
	// 2nd ridge, looking out on field at first bazzoka point, at woodsedge
		maps\_fx_gmi::LoopFx("fog_west", (5357, -5453, 150), .5);
	// 2nd ridge, opposite tractor right side
		maps\_fx_gmi::LoopFx("fog_west", (7089, -5515, 255), .5);
	// 2nd ridge, sherman spawn point closets to player by woods
		maps\_fx_gmi::LoopFx("fog_west", (6817, -7782, 140), .5);
	// 2nd ridge, sherman spawn point north cut a
		maps\_fx_gmi::LoopFx("fog_north", (7320, -7545, 125), .5);
	// 2nd ridge, sherman spawn point north cut b
		maps\_fx_gmi::LoopFx("fog_north", (7290, -6500, 95), .5);
	// 2nd ridge, sherman spawn point north cut c (mid)
		maps\_fx_gmi::LoopFx("fog_north", (7147, -7014, 80), .5);
	// 2nd ridge, opposite tractor
		maps\_fx_gmi::LoopFx("fog_west", (6054, -5403, 225), .5);

	}

// =====END FAST SECTION ====================================//
//////////////////////////////////////////////////////////////

}

spawnSoundfx()
{
	
}