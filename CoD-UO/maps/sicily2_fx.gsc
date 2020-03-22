main()
{
	//fog parameters are (fogdistances, r,g,b,0)
	// don't fog distance gets closer with a higher number. Earl explained the math to me once but I forgot
	// don't know what the zero means..
	
	setExpFog(.0000135, 0.50, 0.38, 0.35, 0); 


	precacheFX();
	spawnWorldFX();
//	if(level.script == "sicily2") // keep from getting script errors when I export sections of the map
		spawnSoundfx();
}

precacheFX()
{
	level._effect["watersplashbigguns"]	= loadfx ("fx/weapon/impacts/impact_ptboatturret_water.efx");
	level._effect["chicken"]		= loadfx ("fx/map_sicily2/chicken_explode.efx");
	level._effect["potsmash"]		= loadfx ("fx/map_sicily2/potsmash.efx");
	level._effect["biggunexplode"]		= loadfx ("fx/map_sicily2/biggun_exp.efx");
	level._effect["fencebreak"]		= loadfx ("fx/map_sicily2/fencebreak.efx");  
	level._effect["boatblow"]		= loadfx ("fx/explosions/vehicles/fishingboat_complete.efx");
	level._effect["windowkick"]		= loadfx ("fx/impacts/glass_shatter2.efx");
	level._effect["enemyboatspark"]		= loadfx ("fx/weapon/impacts/impact_ptboatturret_boat.efx"); 
	level._effect["boatsmoke"]		= loadfx ("fx/smoke/smoke_trail_15.efx"); 
	level._effect["boatdamage"]		= loadfx ("fx/explosions/vehicles/spitfire_n/base_exp.efx"); 
}


spawnWorldFX()
{
//	maps\_fx::loopfx("blacksmoke", (-3986, -4319, 339), 0.6);
}

spawnSoundfx()
{	
	maps\_fx_gmi::loopSound("waterlap", (10801, -9400,-95));
	maps\_fx_gmi::loopSound("dock_creeks", (10801, -9400,-95));
	maps\_fx_gmi::loopSound("boat_dock_rocking", (11617, -9613,-80));
}