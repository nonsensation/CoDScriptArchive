#using_animtree( "panzerIV" );

// precaching, includes both camo and non-camo
main()
{
	precachemodel( "xmodel/vehicle_tank_t34_camo_destroyed" );
	precachemodel( "xmodel/vehicle_tank_t34_destroyed" );
	precachevehicle( "T34" );
	precacheturret( "sg43_t34_tank" );
	loadfx( "fx/explosions/vehicles/t34_complete.efx" );
	loadfx( "fx/smoke/oneshotblacksmokelinger.efx" );
}

// precaching, noncamo only
mainnoncamo()
{
	precachemodel( "xmodel/vehicle_tank_t34_destroyed" );
	precachevehicle( "T34" );
	precacheturret( "sg43_t34_tank" );
	loadfx ( "fx/explosions/vehicles/t34_complete.efx" );
	loadfx( "fx/smoke/oneshotblacksmokelinger.efx" );
}

init(optionalMachinegun)
{
	maps\_tank_gmi::setteam("allies");
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_pi::stun(1); //stun( stuntime );
	thread maps\_tank_pi::avoidtank();
	if (isDefined(optionalMachinegun) )
		thread maps\_tank_pi::turret_attack_think_Kursk(optionalMachinegun);
	else
		thread maps\_tank_pi::turret_attack_think_Kursk("sg43_t34_tank");
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_pi::main();
	thread maps\_treads_pi::main();
}


init_noattack()
{
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
	thread maps\_tank_pi::avoidtank();
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_pi::main();
	thread maps\_treads_pi::main();

}

init_mg_think_only(optionalMachinegun)
{
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
	thread maps\_tank_pi::avoidtank();

	if (isDefined(optionalMachinegun) )
	{
		thread maps\_tankgun_gmi::mginit(optionalMachinegun);
	}
	else
	{
		thread maps\_tankgun_gmi::mginit("sg43_t34_tank");
	}

	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_pi::main();
	thread maps\_treads_pi::main();

}


init_player() // self is intended to be level.playertank
{
	self useAnimTree( #animtree );
	self player_life();
	self thread player_kill();
	self thread player_shoot();

	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_pi::main();
	thread maps\_treads_pi::main();

}

init_friendly()
{
	self useAnimTree( #animtree );
	thread init();
//	friend_life();
//	thread kill();
//	thread shoot();
//
//	thread maps\_tank_gmi::avoidtank();
//	thread maps\_tank_gmi::turret_attack_think();
}

player_life()
{
	skill = getdifficulty();
	println("skill is ",skill);
	if(skill == ("easy"))
		self.health  = 9500; // 6500;
	else if(skill == ("medium"))
		self.health = 8000; // 5500;
	else if(skill == ("hard"))
		self.health = 7500; // 5000;
	else if(skill == ("fu"))
		self.health = 4750; // 3500;
	else if(skill == ("gimp"))
		self.health = 11000; // 7500;
	else
		self.health = 7500; // 5000;
	println("Player tank health is ", self.health);
	thread maps\_tank_pi::conechecksamples(); // completely uncommented IW/GMI function
}

life()
{
	self.health  = (randomint(1000)+500);
	thread maps\_tank_pi::conechecksamples(); // completely uncommented IW/GMI function
}

//	sets up proper tank death model and effect, waits until tankkilled is received  
//	added an endon condition for Kursk for when the player exits the tank
player_kill()
{
	level endon("exit_tank");

	self UseAnimTree(#animtree);
	
	// green T34s
	if((self.model == "xmodel/vehicle_tank_t34") || (self.model == "xmodel/vehicle_tank_t34_green_viewmodel_p") || (self.model == "xmodel/MP_vehicle_tank_t34"))
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	}
	else
	{
		// winter camoflage T34s
		if((self.model == "xmodel/vehicle_tank_t34_camo") || (self.model == "xmodel/vehicle_tank_t34_viewmodel"))
		{
			self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
		}
		else
		{
			println("Player T34 using unknown model: ",self.model," -- no deathmodel assigned.");
		}
	}

	self.deathfx    = loadfx ("fx/explosions/vehicles/t34_complete.efx");
	self.deathsound = "explo_metal_rand";

	self waittill( "death", attacker );
	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self setAnimKnobRestart( %PanzerIV_d );
	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
}


//	sets up proper tank death model and effect, waits until tankkilled is received  
kill()
{	
	self UseAnimTree(#animtree);
	
	// green T34s
	if(self.model == "xmodel/vehicle_tank_t34")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	}
	else
	{
		if(self.model == "xmodel/vehicle_tank_t34_camo")
		{
			self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
		}
		else
		{
			println("T34 using unknown model: ",self.model," -- no deathmodel assigned.");
		}
	}

	self.deathfx    = loadfx( "fx/explosions/vehicles/t34_complete.efx" );
	self.deathsound = "explo_metal_rand";

	thread maps\_tank_pi::kill();

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

//	added an endon condition for Kursk for when the player exits the tank
player_shoot()
{
	level endon("exit_tank");
//	self endon("exit_tank");

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
