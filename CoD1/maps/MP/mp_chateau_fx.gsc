main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
 		level._effect["chimney"] 	= loadfx ("fx/smoke/chimneysmoke.efx");

}
spawnWorldFX()
{
	maps\mp\_fx::loopfx("chimney", (1984, -210, 512), 0.2);

}


