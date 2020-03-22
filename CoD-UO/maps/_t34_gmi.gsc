#using_animtree( "panzerIV" );

main()
{
//	precachemodel("xmodel/vehicle_tank_t34_camo_destroyed");
	precachemodel("xmodel/vehicle_tank_t34_destroyed");
	precachevehicle("T34");
	precacheturret("sg43_t34_tank");
	loadfx ("fx/explosions/vehicles/t34_complete.efx");
	loadfx("fx/smoke/oneshotblacksmokelinger.efx");


}
mainnoncamo()
{
	precachemodel("xmodel/vehicle_tank_t34_destroyed");
	precachevehicle("T34");
	precacheturret("sg43_t34_tank");
	loadfx ("fx/explosions/vehicles/t34_complete.efx");
	loadfx("fx/smoke/oneshotblacksmokelinger.efx");
}

init(optionalMachinegun)
{
	maps\_tank_gmi::setteam("allies");
	self useAnimTree( #animtree );
	life();
	thread kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
	thread maps\_tank_gmi::avoidtank();
	if (isDefined(optionalMachinegun) )
		thread maps\_tank_gmi::turret_attack_think(optionalMachinegun);
	else
		thread maps\_tank_gmi::turret_attack_think("sg43_t34_tank");
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
	if(self.model == "xmodel/vehicle_tank_t34" || self.model == "xmodel/v_rs_lnd_t34")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	}
	else
	if(self.model == "xmodel/vehicle_tank_t34_camo")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	}
	else
	if(self.model == "xmodel/vehicle_tank_t34_viewmodel")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	}
	else
	{
		println("^3T34 does not have a matching Death Model @ ",self.origin);
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

kill()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/vehicle_tank_t34" || self.model == "xmodel/v_rs_lnd_t34")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_destroyed";
	}
	else
	if(self.model == "xmodel/vehicle_tank_t34_camo")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	}
	else
	if(self.model == "xmodel/vehicle_tank_t34_viewmodel")
	{
		self.deathmodel = "xmodel/vehicle_tank_t34_camo_destroyed";
	}
	else
	{
		println("^3T34 does not have a matching Death Model @ ",self.origin);
	}
	self.deathfx    = loadfx( "fx/explosions/vehicles/t34_complete.efx" );
	self.deathsound = "explo_metal_rand";
	thread maps\_tank_gmi::kill();
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

#using_animtree ("generic_human");

attach_guys(tank, guys, offset)
{
	//	setup the anim names and tags
	positions[1]["getoutanim"] = %c_us_sherman_dismount1;
	positions[2]["getoutanim"] = %c_us_sherman_dismount2;
	positions[3]["getoutanim"] = %c_us_sherman_dismount3;
	positions[4]["getoutanim"] = %c_us_sherman_dismount4;
	positions[5]["getoutanim"] = %c_us_sherman_dismount5;
	positions[6]["getoutanim"] = %c_us_sherman_dismount6;
	positions[7]["getoutanim"] = %c_us_sherman_dismount7;
	positions[8]["getoutanim"] = %c_us_sherman_dismount8;

	positions[1]["exittag"] = "tag_guy01";
	positions[2]["exittag"] = "tag_guy02";
	positions[3]["exittag"] = "tag_guy03";
	positions[4]["exittag"] = "tag_guy04";
	positions[5]["exittag"] = "tag_guy05";
	positions[6]["exittag"] = "tag_guy06";
	positions[7]["exittag"] = "tag_guy07";
	positions[8]["exittag"] = "tag_guy08";

	positions[1]["delay"] = 0; 	//tag1
	positions[2]["delay"] = 0; 	//tag2
	positions[3]["delay"] = 0; 	//tag3
	positions[4]["delay"] = 0;	//tag4
	positions[5]["delay"] = 0;	//tag5
	positions[6]["delay"] = 0;	//tag6
	positions[7]["delay"] = 0;	//tag7
	positions[8]["delay"] = 0;	//tag8

	//	how this works 
	//	if the designer puts a script_noteworthy on the guy 
	//	that guy will be assigned to tag number contained in script noteworthy 

	//	first we fill the tags with either -1 for no guy 
	//	or guys index
	

	tags = [];
	for(i=0;i<8;i++)
	{
		tag = -1;
		for(u=0;u<guys.size;u++)
		{
			if (isdefined(guys[u].script_noteworthy))
			{
				if (guys[u].script_noteworthy == (i+1))
				{
					tag = u;
					guys[u].climb_tag = i+1;
					println("guys[",u,",",guys[u].name,"] = ",i);
				}
			}
 		}
		tags[i] = tag;
	}

	//	here we shoot through the guy list 
	//	finding those that didn't get assigned to a tag , just above
	//	and for each one we find an unused tag and attach him to it


	println("guys ",guys.size);

	for(u=0;u<guys.size;u++)
	{
		if (!isdefined(guys[u].climb_tag))
		{
			for(i=0;i<tags.size;i++)
			{
				if (tags[i]==-1)
				{
					tags[i] = u;
					guys[u].climb_tag = i+1;
					println("guys[",u,"] = ",i);
					break;
				}
			}
		}
	}

	//	this is the actual assigning and so forth 

	for(i=0;i<guys.size;i++)
	{
		if (!isdefined(guys[i].climb_tag))	continue;
		
		println("tag_guy0",guys[i].climb_tag);
		println(i," ",guys[i].name);
		//	we label each fellow with an ID number 
		//	and link him to the matching tag on the tank
		guys[i] linkto(tank,"tag_guy0"+(guys[i].climb_tag),(0,0,0),(0,0,0));
		org = tank gettagorigin("tag_guy0" + (guys[i].climb_tag));
		guys[i] teleport(org);

		//	set the guys specific anims and stuff 

		guys[i].exittag = positions[guys[i].climb_tag]["exittag"];
		guys[i].getoutanim = positions[guys[i].climb_tag]["getoutanim"];
		guys[i].delay = positions[guys[i].climb_tag]["delay"];
		//	tell the tank to wait for the unload message 
		//	then throw them out
		tank thread wait_jump_out(guys[i]);

		guys[i] thread sherman_tank_anim(tank, (0,0,0));
	}
/*
	while(1)
	{
		for (i=0;i<8;i++)
		{
			org = tank gettagorigin("tag_guy0" + (i+1));
			print3d(org,(i+1));
	
		}
		wait(0.05);
	}
*/
}

animatemoveintoplace(guy,org,angles,movetospotanim)
{
	guy animscripted("movetospot", org, angles, movetospotanim);
	guy waittillmatch ("movetospot","end");
	guy notify ("doanimscript");
}

wait_jump_out(guy,driverguy)
{
	guy endon ("death");
	self waittill ("unload");
	if (!(isalive (guy)))
		return;
	guy.hasweapon = true;
	guy animscripts\shared::PutGunInHand("right");
	wait (guy.delay);

	if (!(isalive (guy)))
		return;

	org = self gettagOrigin (guy.exittag);
	angles = self gettagAngles (guy.exittag);

	guy animscripted("jumpout", org, angles, guy.getoutanim);
	guy waittillmatch ("jumpout","end");
	if(isalive(guy))
	{
		guy unlink();
		guy allowedstances("stand","crouch","prone");
	}
	guy notify ("jumpedout");

	//JoeC: restore original animname after jumping off.
	if(isdefined(guy.original_animname))
	{
		guy.animname = guy.original_animname;
	}
}

sherman_tank_anim(tank, angle_offset)
{
	//JoeC: If ai has animname to begin with, store for later. (MikeD supervised, so see me Jed! :P)
	if (isdefined(self.animname))
	{
		self.original_animname = self.animname;
	}

	self.animname = "sherman_tank";
	positions = [];

	positions[1]["idle"] = %c_us_sherman_idle1;
	positions[2]["idle"] = %c_us_sherman_idle2;
	positions[3]["idle"] = %c_us_sherman_idle3;
	positions[4]["idle"] = %c_us_sherman_idle4;
	positions[5]["idle"] = %c_us_sherman_idle5;
	positions[6]["idle"] = %c_us_sherman_idle6;
	positions[7]["idle"] = %c_us_sherman_idle7;
	positions[8]["idle"] = %c_us_sherman_idle8;

	level.scr_anim[self.animname][("idle" + self.climb_tag)][0] = positions[self.climb_tag]["idle"];
	level.scr_face[self.animname][("idle" + self.climb_tag)][0] = (%facial_fear01);
	level.scr_anim[self.animname][("deathanim" + self.climb_tag)] = %death_stand_dropinplace;
	level.scr_face[self.animname][("deathanim" + self.climb_tag)] = (%facial_fear01);

	self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "death", undefined, tank);

}