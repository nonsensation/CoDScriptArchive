//
// Map: Foy
//

main()
{
	precacheFX();
    	spawnWorldFX();
	spawnSoundFX();
}

precacheFX()
{

// Events ===============================//

	level._effect["haystackexplosion"]	= loadfx ("fx/map_foy/haystack_explode.efx");
	level._effect["bell_tower_exp"]		= loadfx ("fx/map_foy/belltower_exp.efx");
	level._effect["88_building1"]		= loadfx ("fx/map_foy/88_building1.efx");
	level._effect["tanksmokeshot"]		= loadfx ("fx/smoke/smoke_grenade.efx");										// bridge_exp
	level._effect["bridge_explo1"]		= loadfx ("fx/map_foy/bridge_exp.efx");
	level._effect["bridge_explo2"]		= loadfx ("fx/weapon/explosions/tank_concrete.efx");
	level._effect["lamp_fall"]		= loadfx ("fx/map_foy/lamp_fall.efx");

// Fire ===============================//

	level._effect["barreloil_fire"]		= loadfx ("fx/fire/barreloil_fire.efx");
	level._effect["fireplace_fire"]		= loadfx ("fx/fire/fireplace_fire.efx");

	level._effect["building_inside_medium"]	= loadfx ("fx/fire/building_inside_medium_s.efx");

	level._effect["bldgfire_stage1a"]	= loadfx ("fx/map_foy/bldg_fire_stage1a.efx");
	level._effect["bldgfire_stage1b"]	= loadfx ("fx/map_foy/bldg_fire_stage1b.efx");
	level._effect["bldgfire_stage1c"]	= loadfx ("fx/map_foy/bldg_fire_stage1c.efx");
	level._effect["bldgfire_stage1d"]	= loadfx ("fx/map_foy/bldg_fire_stage1d.efx");
	level._effect["bldgfire_stage2"]	= loadfx ("fx/map_foy/bldg_fire_stage2.efx");
	level._effect["bldgfire_stage3"]	= loadfx ("fx/map_foy/bldg_fire_stage3.efx");
	level._effect["bldgfire_stage4"]	= loadfx ("fx/map_foy/bldg_fire_stage4.efx");

// V Lights ===============================//

	level._effect["v_light_100_235_blu"]	= loadfx ("fx/atmosphere/v_light_100_235_blu.efx");
	level._effect["v_light_40_216_blu"]	= loadfx ("fx/atmosphere/v_light_40_216_blu.efx");
	level._effect["v_light_40_80_org"]	= loadfx ("fx/atmosphere/v_light_40_216_blu.efx");
}


spawnworldfx()
{
// =====START ALL SPEC SECTION ===============================//
////////////////////////////////////////////////////////////////

	// 2nd story of blown out building
		maps\_fx_gmi::loopfx("building_inside_medium", (427, -2186, 165), .3);

// =====END ALL SPEC SECTION ==================================//
/////////////////////////////////////////////////////////////////

// =====START FAST SECTION ====================================//
/////////////////////////////////////////////////////////////////

	if(getcvarint("scr_gmi_fast") < 2)
	{

// Fire ===============================//

		//maps\_fx_gmi::loopfx("barreloil_fire", (-1111, -2399, 0), .3);
		//maps\_fx_gmi::loopfx("fireplace_fire", (-1622, -1153, 12), .3);

// V Lights ===============================//

	//win e
		maps\_fx_gmi::OneShotfx("v_light_40_80_org", 	(833, -1721, 132), 0, (833, -1600, -72));
	//win f	
		maps\_fx_gmi::OneShotfx("v_light_40_80_org", 	(964, -1721, 132), 0, (964, -1600, -72));
	//win g	
		maps\_fx_gmi::OneShotfx("v_light_40_80_org", 	(1119, -1721, 132), 0, (1119, -1600, -72));
	//win h	
		maps\_fx_gmi::OneShotfx("v_light_40_80_org", 	(1247, -1721, 132), 0, (1247, -1600, -72));
	//roof big
		maps\_fx_gmi::OneShotfx("v_light_100_235_blu", 	(913, -1510, 375), 0, (913, -1610, 75));
	//roof	
		maps\_fx_gmi::OneShotfx("v_light_40_216_blu", 	(847, -1628, 341), 0, (847, -1528, 145));
	//roof	
		maps\_fx_gmi::OneShotfx("v_light_40_216_blu", 	(1175, -1594, 377), 0, (1175, -1494, 175));

	}

// =====END FAST SECTION ====================================//
///////////////////////////////////////////////////////////////
}

spawnSoundFX()
{
	maps\_fx_gmi::loopSound("barrelfire", (-1108, -2392,60));
	maps\_fx_gmi::loopSound("fireplace", (-1623, -1150,30));
	maps\_fx_gmi::loopSound("fireplace", (427, -2186, 199));
	maps\_fx_gmi::loopSound("radio_german", (975, -1694,70));
	maps\_fx_gmi::loopSound("german_radio", (-1374, 6708, 40));
}
