main()
{
	precacheFX();  
	spawnWorldFX();     
}

precacheFX()
{
	//explosion effects
	level._effect["stone"]		= loadfx ("fx/cannon/stone.efx");
	level._effect["wood"]		= loadfx ("fx/cannon/wood.efx");
	level._effect["brick"]		= loadfx ("fx/cannon/brick.efx");
	level._effect["glass"]		= loadfx ("fx/cannon/glass.efx");
	level._effect["house"]		= loadfx ("fx/cannon/buildingpop.efx");
	level._effect["tankdirt"]	= loadfx ("fx/impacts/largemortar_dirt.efx");
	
	//window breaking
	level._effect["shatter"]	= loadfx ("fx/impacts/glass_shatter.efx");
	
	//car treads
	level._effect["treads_sand"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_grass"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_dirt"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_rock"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	
	//fires & smoke
	level._effect["canfire"]	= loadfx ("fx/fire/barrelfire.efx");
	level._effect["tanksmoke"]	= loadfx ("fx/smoke/oneshotblacksmokelinger.efx");
}

spawnWorldFX()
{
	maps\_fx::loopfx("canfire", (12259, -43259, 722), 0.3);
}