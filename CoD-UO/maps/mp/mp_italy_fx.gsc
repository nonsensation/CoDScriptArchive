main()
{
	precacheFX();
    	spawnWorldFX(); 
}

precacheFX()
{
// FIRE ===============================//
	level._effect["fireplace_fire"]	= loadfx ("fx/map_mp/mp_fireplace_fire.efx");
}

spawnWorldFX()
{
	wait(1);
      	thread maps\mp\_fx::loopfxthread("fireplace_fire", (5374, 5416, -64), 5, undefined, undefined, 6144);
      	thread maps\mp\_fx::loopfxthread("fireplace_fire", (5374, 5416, -216), 5, undefined, undefined, 6144);
}