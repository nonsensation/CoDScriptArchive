main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
	level._effect["bridgelinger_small"]	= loadfx ("fx/smoke/bridgelinger_small.efx");
	level._effect["bridgelinger"]	= loadfx ("fx/smoke/bridgelinger.efx");
	level._effect["bridgepoper"]	= loadfx ("fx/explosions/explosion1_nolight.efx");
	level._effect["waterfallrocksplash"]	= loadfx ("fx/water/rocksplashes.efx");
//	level._effect["waterfallsplash"]	= loadfx ("fx/water/rocksplashes_large.efx");
	level._effect["waterfallsplash"]	= loadfx ("fx/water/nice_one.efx");
	level._effect["truckwatersplash"]	= loadfx ("fx/water/rocksplashes_large.efx");


}


spawnWorldFX()
{
//	maps\_fx::loopfx("blacksmoke", (-3986, -4319, 339), 0.6);
}
