main()
{
	precacheFX();
}

precacheFX()
{
	level._effect["gigantor"]	= loadfx ("fx/smoke/gigantor.efx");
	level._effect["column"]		= loadfx ("fx/cannon/demolition_2sml_tame.efx");
	level._effect["brick"]		= loadfx ("fx/cannon/brick.efx");
	level._effect["smoke"]		= loadfx ("fx/cannon/dust.efx");
	level._effect["reichstag"]	= loadfx ("fx/cannon/buildingpop.efx");
}