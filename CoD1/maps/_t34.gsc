#using_animtree( "panzerIV" );

main()
{
	precachemodel("xmodel/vehicle_tank_t34_camo_destroyed");
	precachevehicle("T34");
	precacheturret("mg42_panzerIV_tank");
	loadfx ("fx/explosions/metal_b.efx");
	loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	loadfx( "fx/explosions/explosion1_nolight.efx" );


}
mainnoncamo()
{
	precachemodel("xmodel/vehicle_tank_t34_destroyed");
	precachevehicle("T34");
	precacheturret("mg42_panzerIV_tank");
	loadfx ("fx/explosions/metal_b.efx");
	loadfx( "fx/explosions/explosion1_nolight.efx" );
	loadfx("fx/smoke/oneshotblacksmokelinger.efx");
}

init()
{
	maps\_tank::setteam("allies");
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank::stun(1); //stun( stuntime );
	thread maps\_tank::avoidtank();
	thread maps\_tank::turret_attack_think();
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx::main();
	thread maps\_treads::main();
}


init_noattack()
{
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank::stun(1); //stun( stuntime );
}

init_player()
{
	self useAnimTree( #animtree );
	player_life();
	thread player_kill();
	thread player_shoot();

}

init_friendly()
{
	self useAnimTree( #animtree );
	thread init();
//	friend_life();
//	thread kill();
//	thread shoot();
//
//	thread maps\_tank::avoidtank();
//	thread maps\_tank::turret_attack_think();
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
	println("tank health is ", self.health);
	thread maps\_tank::conechecksamples();
}

life()
{

	self.health  = (randomint(1000)+500);
	thread maps\_tank::conechecksamples();
}


player_kill()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/vehicle_tank_t34")
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	else
	if(self.model == "xmodel/vehicle_tank_t34_camo")
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	else
	if(self.model == "xmodel/vehicle_tank_t34_viewmodel")
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	else
	{
		println("model doesn't match something blahe blahblabh");
	}
	self.deathfx    = loadfx ("fx/explosions/metal_b.efx");
	self.deathsound = "explo_metal_rand";
	self waittill( "death", attacker );
	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self setAnimKnobRestart( %PanzerIV_d );
	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
}

kill()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/vehicle_tank_t34")
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	else
	if(self.model == "xmodel/vehicle_tank_t34_camo")
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	else
	if(self.model == "xmodel/vehicle_tank_t34_viewmodel")
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	self.deathfx    = loadfx( "fx/explosions/explosion1_nolight.efx" );
	self.deathsound = "explo_metal_rand";
	thread maps\_tank::kill();
	self waittill ("tankkilled");
	self setAnimKnobRestart( %PanzerIV_d );
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
	self setAnimKnobRestart( %PanzerIV_fire );
}
