main()
{
	precacheFX();
}

precacheFX()
{
	level._effect["morsecode_dot_boat"]	= loadfx ("fx/misc/morsecode_dot_boat.efx");
	level._effect["morsecode_dash_boat"]	= loadfx ("fx/misc/morsecode_dash_boat.efx");
	level._effect["morsecode_dot_ship"]	= loadfx ("fx/misc/morsecode_dot_ship.efx");
	level._effect["morsecode_dash_ship"]	= loadfx ("fx/misc/morsecode_dash_ship.efx");
	level._effect["explosion_grenade"]	= loadfx ("fx/explosions/grenade1.efx");
}
