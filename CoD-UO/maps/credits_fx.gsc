main()
{
	precacheFX();
	spawnWorldFX();    
}


precacheFX()
{
     
	//level._effect["smallbon"]			= loadfx ("fx/fire/smallbon.efx"); 
	level._effect["smoke"]				= loadfx ("fx/smoke/underlitsmoke.efx");
	level._effect["smoke_window"]			= loadfx ("fx/smoke/windowsmoke_col1.efx");
	level._effect["medfire"]			= loadfx ("fx/fire/tinybon.efx"); 
	level._effect["fireWall1"]			= loadfx ("fx/fire/firewallfacade_1.efx");
	level._effect["tree_burst"]			= loadfx("fx/explosions/treeburst_a.efx");
	level._effect["tree_burst_snow"] 		= loadfx("fx/explosions/tree_burst_snow.efx");
	level._effect["bmw_headlight"]			= loadfx ("fx/vehicle/bmw_headlight.efx");
	level._effect["bastogne2_flare"]		= loadfx ("fx/map_bastogne2/flare.efx");
	level._effect["foy_bridge_explo1"]		= loadfx ("fx/map_foy/bridge_exp.efx");
	level._effect["foy_bridge_explo2"]		= loadfx ("fx/weapon/explosions/tank_concrete.efx");

	level._effect["snow_mortar"] 			= loadfx ("fx/explosions/artillery/pak88_snow_low.efx");
}

spawnWorldFX()
{   
}

