main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
//	level._effect["chateau_rain"]		= loadfx ("fx/atmosphere/chateau_rain.efx");
 	level._effect["canfire"]				= loadfx ("fx/fire/barrelfire.efx"); 
	level._effect["chimney"] 	 			= loadfx ("fx/smoke/chimneysmoke.efx");
	level._effect["mechanical explosion"] 	= loadfx ("fx/misc/sparker.efx");
//	level._effect["bomb explosion"] 		= loadfx ("fx/explosions/explosion1_nolight.efx");
	level._effect["bomb explosion"]			= loadfx ("fx/explosions/pathfinder_explosion.efx");
//	level._effect["bomb explosion"] 		= loadfx ("fx/explosions/metal_b.efx");
	
}
spawnWorldFX()
{
//	maps\_fx::loopfx("chateau_rain", (-200, 7147, -469), 0.3);
//	maps\_fx::loopfx("chateau_rain", (-102, 6144, -125), 0.3);
//	maps\_fx::loopfx("chateau_rain", (-1588, 4787, -113), 0.3);
//	maps\_fx::loopfx("chateau_rain", (-1788, 3765, -140), 0.3);
//	maps\_fx::loopfx("chateau_rain", (-520, 1147, -211), 0.3);
	maps\_fx::loopfx("canfire", (-1885, 4618, -122), 0.3);
	maps\_fx::loopfx("chimney", (1984, -210, 512), 0.2);

}


