main()
{
	precacheFX();   
}

precacheFX()
{
	level._effect["brick"]	= loadfx ("fx/cannon/brick.efx");
	level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
}