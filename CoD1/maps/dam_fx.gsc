main()     
{
	precacheFX();
	spawnWorldFX();    
}

precacheFX()
{
	level._effect["mistwall"]		= loadfx ("fx/water/mist_wall.efx");
	level._effect["stone"]	= loadfx ("fx/cannon/stone.efx");
	level._effect["wood"]	= loadfx ("fx/cannon/wood.efx");
	level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
	level._effect["glass"]	= loadfx ("fx/cannon/glass.efx");
	level._effect["fire"]  = loadfx("fx/explosions/explosion1.efx");
	level._effect["froth"]  = loadfx("fx/water/dam_froth.efx");
}

spawnWorldFx()
{
//	maps\_fx::loopfx("froth", (-24420, 5056, -1690), 0.5);
//	moved to dam.gsc so i can turn it on and off when you go in and out.
}




//maps\_fx::LoopFx("froth", (-25279.00, 4353.00, -1770.00), 0.30, undefined);
//maps\_fx::LoopFx("froth", (-26287.00, 4074.00, -1770.00), 0.30, undefined);
//maps\_fx::LoopFx("froth", (-22767.00, 4378.00, -1770.00), 0.30, undefined);
//maps\_fx::LoopFx("froth", (-24031.00, 4433.00, -1770.00), 0.30, undefined);
//maps\_fx::LoopFx("froth", (-21735.00, 4122.00, -1770.00), 0.30, undefined);


