main()
{
	precacheFX();
//	spawnWorldFX();
}

precacheFX()
{
	level._effect["blacksmoke"]	= loadfx ("fx/smoke/whitesmoke.efx");
    	level._effect["stone"]	= loadfx ("fx/cannon/buildingpop.efx");
    	level._effect["wood"]	= loadfx ("fx/cannon/buildingpop.efx");
  	level._effect["dust"]	= loadfx ("fx/cannon/buildingpop.efx");
	level._effect["glass"]	= loadfx ("fx/cannon/glass_tame.efx");
	level._effect["brick"]	= loadfx ("fx/cannon/buildingpop.efx");
	level._effect["coolaidmanbrick"]	= loadfx ("fx/impacts/coolaidmanbrick.efx");
	level._effect["coolaidmanconcrete"]	= loadfx ("fx/impacts/coolaidmanconcrete.efx");
	level._effect["concrete"]	= loadfx ("fx/cannon/buildingpop.efx");
}


spawnWorldFX()
{
//	maps\_fx::loopfx("blacksmoke", (-3986, -4319, 339), 0.6);
//    maps\_fx::loopSound("medfire", (-701, -18361, 148), 7.7);
//    maps\_fx::loopfx("medFireTop", (222, -16778, 234), 0.5);
//    maps\_fx::loopSound("medfire", (222, -16778, 234), 7.7);

}
