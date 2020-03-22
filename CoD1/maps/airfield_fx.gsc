main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
	level._effect["cratesmash"]	= loadfx ("fx/cannon/woodcrate.efx");
	level._effect["stukabomb"]	= loadfx ("fx/explosions/explosion1_nolight.efx");
}


spawnWorldFX()
{
//	maps\_fx::loopfx("blacksmoke", (-3986, -4319, 339), 0.6);
}
