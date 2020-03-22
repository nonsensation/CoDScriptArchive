main()
{
	precacheFX();
	spawnWorldFX();    
}

precacheFX()
{
    //level._effect["medfire"]	= loadfx ("fx/fire/medFireLightSmoke.efx");
    //level._effect["gigantor"]	= loadfx ("fx/smoke/gigantor.efx"); 
    level._effect["coolaidmanbrick"]	= loadfx ("fx/impacts/coolaidmanconcrete.efx");
    //level._effect["berlin_explosion"]	= loadfx ("fx/explosion/berlin_explosion.efx");
    //level._effect["coolaidmanbrick"]	= loadfx ("fx/impacts/coolaidmanbrick.efx");

    
    level._effect["steam"]	= loadfx ("fx/smoke/slow_steam.efx");
    level._effect["stone"]	= loadfx ("fx/cannon/stone.efx");
    level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
    level._effect["dirt"]	= loadfx ("fx/impacts/stukastrafe_dirt.efx");
}

spawnWorldFX()
{
    /*
    maps\_fx::loopfx("gigantor", (284, 5274, 148), .3);
    maps\_fx::loopfx("gigantor", (7470, 7480, 335), .3);
    maps\_fx::loopfx("gigantor", (3439, 6069, 19), .3);
    maps\_fx::loopfx("gigantor", (1719, 11925, -25), .3);
    maps\_fx::loopfx("medfire", (5283, 2598, 99), .3);
    maps\_fx::loopfx("medfire", (5717, 3495, 32), .3);
    */
    maps\_fx::loopfx("steam", (986, -1575, 63), .3);
    maps\_fx::loopfx("steam", (959, -1591, 72), .3);
}
