main()
{
	precacheFX();   
}

precacheFX()
{
	level._effect["fueltank"]	= loadfx("fx/explosions/fueltank_ned.efx");
	level._effect["wood_close"]	= loadfx ("fx/cannon/wood_close.efx");
    	level._effect["wood"]		= loadfx ("fx/cannon/wood.efx");
    	level._effect["dust"]		= loadfx ("fx/cannon/dust.efx");
    	level._effect["dirt"]		= loadfx ("fx/cannon/dirt.efx");
    	
}