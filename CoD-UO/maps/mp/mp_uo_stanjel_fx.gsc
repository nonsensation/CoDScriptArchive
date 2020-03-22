main()
{
	precacheFX();
	spawnWorldFX(); 
}

precacheFX()
{
// Bombzone A =========================//
	// verkar ok
    		level._effect["explosion1"]	= loadfx ("fx/explosions/explosion1.efx");
	// kolla närmre på denna.
    		level._effect["fueltank"]	= loadfx ("fx/explosions/fueltank_ned.efx"); 
	// kanske för nedslagen eller för att blanda i huvud explosionen. 
    		level._effect["ground"]		= loadfx ("fx/explosions/ground.efx"); 
    		level._effect["dust"]		= loadfx ("fx/impacts/dusty_em.efx");

// Bombzone B =========================//
		level._effect["sparker"]	= loadfx ("fx/misc/sparker.efx");
    		level._effect["radio_smoke"]	= loadfx ("fx/misc/radio_smoke.efx");

// Smoke =========================//
		level._effect["smoke"]		= loadfx ("fx/map_mp/mp_smokemist_chimney.efx");

}

spawnWorldFX()
{
	wait(1);
	thread maps\mp\_fx::loopfx("smoke",(-654, 544, 675), 5);
	wait(0.3);
	thread maps\mp\_fx::loopfx("smoke",(-196, -720, 192), 5);
}