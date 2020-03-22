#using_animtree( "willyjeep" );

main()
{
	precachevehicle("willyjeep");
	precacheturret("mg50cal_tank");
	precachemodel("xmodel/v_us_lnd_willysjeep_d");
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_treadfx_gmi::main();

	loadfx("fx/smoke/blacksmokelinger.efx");
//	loadfx("fx/explosions/vehicles/willyjeep_complete.efx");
	loadfx("fx/explosions/vehicles/willyjeep_complete_low.efx");
}

init()
{
	maps\_tank_gmi::setteam("allies");
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
	thread maps\_tank_gmi::avoidtank();
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_gmi::main();
	thread maps\_treads_gmi::main();
}

init_noattack()
{
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
}

init_player()
{
	self useAnimTree( #animtree );
	player_life();
	thread player_kill();
	thread player_shoot();

}
player_life()
{
	skill = getdifficulty();
	println("skill is ",skill);
	if(skill == ("easy"))
		self.health  = 6500;
	else if(skill == ("medium"))
		self.health = 5500;
	else if(skill == ("hard"))
		self.health = 5000;
	else if(skill == ("fu"))
		self.health = 3500;
	else if(skill == ("gimp"))
		self.health = 7500;
	else
		self.health = 5000;
	println("jeep health is ", self.health);
	thread maps\_tank_gmi::conechecksamples();
}

life()
{

	self.health  = (randomint(1000)+500);
	thread maps\_tank_gmi::conechecksamples();
}


player_kill()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/v_us_lnd_willysjeep")
		self.deathmodel = "xmodel/v_us_lnd_willysjeep_d";
	else
	if(self.model == "xmodel/v_us_lnd_willysjeep_snow")
		self.deathmodel = "xmodel/v_us_lnd_willysjeep_d";
	else
	{
		println("model doesn't match something blahe blahblabh");
	}
	//self.deathfx    = loadfx ("fx/explosions/vehicles/willyjeep_complete.efx");
	self.deathfx    = loadfx("fx/explosions/vehicles/willyjeep_complete_low.efx");
	self.deathsound = "explo_metal_rand";
	self waittill( "death", attacker );
	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
//	self setAnimKnobRestart( %PanzerIV_d );
	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
}

kill()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/v_us_lnd_willysjeep")
	{
		self.deathmodel = "xmodel/v_us_lnd_willysjeep_d";
	}
	else
	if(self.model == "xmodel/v_us_lnd_willysjeep_snow")
	{
		self.deathmodel = "xmodel/v_us_lnd_willysjeep_d";
	}
//	self.deathfx    = loadfx( "fx/explosions/vehicles/willyjeep_complete.efx" );
	self.deathfx    = loadfx("fx/explosions/vehicles/willyjeep_complete_low.efx");
	self.deathsound = "explo_metal_rand";

	thread maps\_tank_gmi::kill();
	self waittill ("tankkilled");
//	self setAnimKnobRestart( %PanzerIV_d );
}

shoot()
{
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
		self fire();
	}
}

player_shoot()
{
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
		self fire();
		
	}
}

fire()
{
	if(self.health <= 0)
		return;

	// fire the turret
	self FireTurret();

	// play the fire animation
//	self setAnimKnobRestart( %PanzerIV_fire );
}
