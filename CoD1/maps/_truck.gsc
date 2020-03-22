#using_animtree ("generic_human");

main()
{
	precachemodel("xmodel/vehicle_german_truck_d");
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_treadfx::main();
	loadfx("fx/explosions/explosion1.efx");
	loadfx("fx/smoke/blacksmokelinger.efx");
}
init()
{


	if(self.model == ("xmodel/vehicle_halftrack"))
	{
		life("nodeath");
		thread maps\_treads::main();
		return;
	}
	life();
	thread kill();
	thread bulletregenpercent();
	thread maps\_treads::main();

}

init_factory()
{
	life();
	thread kill_factory();
	thread bulletregenpercent();
	thread maps\_treads::main();
}

init_rocket()
{
	life();
	thread kill();
	thread maps\_treads::main();
}


handle_attached_guys(guys,nodriverunload)
{

	positions[0]["getoutanim"] = %germantruck_driver_climbout;
	positions[1]["getoutanim"] = %germantruck_guy1_jumpout;
	positions[2]["getoutanim"] = %germantruck_guy2_jumpout;
	positions[3]["getoutanim"] = %germantruck_guy3_jumpout;
	positions[4]["getoutanim"] = %germantruck_guy4_jumpout;
	positions[5]["getoutanim"] = %germantruck_guy5_jumpout;
	positions[6]["getoutanim"] = %germantruck_guy6_jumpout;
	positions[7]["getoutanim"] = %germantruck_guy7_jumpout;
	positions[8]["getoutanim"] = %germantruck_guy8_jumpout;

	positions[0]["idleanimstop"] = %germantruck_driver_sitidle_loop;
	positions[0]["idleanim"] = %germantruck_driver_drive_loop;
//	positions[1]["idleanim"] = %germantruck_guy1_jumpout; //non of this stuff is used
//	positions[2]["idleanim"] = %germantruck_guy2_jumpout;
//	positions[3]["idleanim"] = %germantruck_guy3_jumpout;
//	positions[4]["idleanim"] = %germantruck_guy4_jumpout;
///	positions[5]["idleanim"] = %germantruck_guy5_jumpout;
//	positions[6]["idleanim"] = %germantruck_guy6_jumpout;
//	positions[7]["idleanim"] = %germantruck_guy7_jumpout;
//	positions[8]["idleanim"] = %germantruck_guy8_jumpout;

	positions[0]["closedooranim"] = %germantruck_driver_closedoor;

	positions[0]["exittag"] = "tag_driver";
	positions[1]["exittag"] = "tag_guy01";
	positions[2]["exittag"] = "tag_guy02";
	positions[3]["exittag"] = "tag_guy03";
	positions[4]["exittag"] = "tag_guy04";
	positions[5]["exittag"] = "tag_guy05";
	positions[6]["exittag"] = "tag_guy06";
	positions[7]["exittag"] = "tag_guy07";
	positions[8]["exittag"] = "tag_guy07";

	positions[0]["delay"] = 0; 	//driver
	positions[1]["delay"] = 0; 	//tag1
	positions[2]["delay"] = .2; 	//tag2
	positions[3]["delay"] = .3;	//tag3
	positions[4]["delay"] = 0;	//tag4
	positions[5]["delay"] = .4;	//tag5
	positions[6]["delay"] = .2;	//tag6
	positions[7]["delay"] = .5;	//tag7
	positions[8]["delay"] = .8;	//tag8

//	positions[0]["deathanim"] = %death_stand_dropinplace;
	positions[1]["deathanim"] = %death_stand_dropinplace;
	positions[2]["deathanim"] = %death_stand_dropinplace;
	positions[3]["deathanim"] = %death_stand_dropinplace;
	positions[4]["deathanim"] = %death_stand_dropinplace;
	positions[5]["deathanim"] = %death_stand_dropinplace;
	positions[6]["deathanim"] = %death_stand_dropinplace;
	positions[7]["deathanim"] = %death_stand_dropinplace;
	positions[8]["deathanim"] = %death_stand_dropinplace;

	positions[0]["exittag"] = "tag_driver";

	climbnode [0] = "tag_climbnode";
	climbanim [0] = %germantruck_guyC_climbin;

	for(i=0;i<climbnode.size;i++)
		self.climbnode[i] = climbnode[i];
	for(i=0;i<climbanim.size;i++)
		self.climbanim[i] = climbanim[i];
	movetospotanim = %stand_alert_1;
	pos = 0;
	if(!isdefined(nodriverunload))
		thread jumpoutdoor();  // truck plays open door animation for the driver

	while(self.health > 0)
	{
		if (isdefined(guys))
		{
			guysarray = guys;
		}
		else
		{
			guysarray = undefined;

			self waittill ("guyenters" , other);

			guysarray[0] = other;
		}
		guys = undefined;


		for(i=0;i<guysarray.size;i++)
		{
			guy = guysarray[i];


			guy.exittag = positions[pos]["exittag"];
			guy.getoutanim = positions[pos]["getoutanim"];
			guy.delay = positions[pos]["delay"];
			guy.fakedeathanim = positions[pos]["deathanim"];


			org = self gettagorigin(guy.exittag);
			angles = self gettagAngles(guy.exittag);
			if(pos != 0)
			{
//				thread deathremove(guy);
				if(level.script == "truckride" || level.script == "airfield")
				{
					guy thread dothecustomanimation();

//					thread wackamolestance(guy);

				}
				if(isdefined (guy.animatein))
				{
					self thread animatemoveintoplace(guy,org,angles,movetospotanim);
				}
				else
				{
					guy teleport (org,angles);
			//		self thread animatemoveintoplace(guy,org,angles,movetospotanim);
				}
				guy linkto (self, guy.exittag);
				self thread animatemoveintoplace(guy,org,angles,movetospotanim);
				self thread wait_jump_out(guy);
			}
			if(pos == 0)
			{
				guy.hasweapon = false;
				guy animscripts\shared::PutGunInHand("none");
				guy.closedooranim = positions[pos]["closedooranim"];
				guy.allowdeath = 0;
				guy.idleanimstop = positions[pos]["idleanimstop"];
				guy.idleanim = positions[pos]["idleanim"];
				self.driver = guy; //so I can do driver guy stuff whereever I do truck stuff! cause the driver is soooo special. he gets to close the door
				guy teleport (org);
				guy linkto (self, guy.exittag, (0, 0, 0), (0, 0, 0));
				self thread driver_idle(guy,nodriverunload);
				if(!isdefined(nodriverunload))
					self thread wait_jump_out(guy,"driver");
			}
			pos++;
		}

	}
}

dothecustomanimation()
{
	self waittill ("doanimscript");
	self animcustom (animscripts\scripted\truckride_backoftruck::main);
}

spam()
{
	println("******_truck.gsc*****");
}
driverwait(driver,waittime)
{
	self waittill ("driverclosedoor");
	driver.idling = 0;
	driver notify ("driverstartidledone","end");
}
driver_reidle(driver,nodriverunload)
{
	driver endon("death");
	driver waittill ("idlereturn");
	thread driver_idle(driver,nodriverunload);
}
driver_idle (driver,nodriverunload)
{
	if(!isdefined(nodriverunload))
		self endon ("unload");
	thread driver_reidle(driver,nodriverunload);
	driver endon ("idlestop");
	driver endon ("death");
	driver.idling = 1;
	if(isdefined (self.drivertriggered))
	{

		driver.idling = 1;
		self thread opendoor();
		org = self gettagOrigin (driver.exittag);
		angles = self gettagAngles (driver.exittag);
		thread driverwait(driver,self.script_delay);
		while(driver.idling == 1)
		{
			if(self getspeedmph() == 0)
				driver animscripted("driverstartidledone", org, angles, driver.idleanimstop);  //to be replaced with driver hanging his legs out the door
			else
				driver animscripted("driverstartidledone", org, angles, driver.idleanim);  //to be replaced with driver hanging his legs out the door

			driver waittillmatch ("driverstartidledone","end");
		}
		self thread closedoor();
		org = self gettagOrigin (driver.exittag);
		angles = self gettagAngles (driver.exittag);
		driver animscripted("germantruck_driver_closedoor", org , angles, driver.closedooranim);
		driver waittillmatch ("germantruck_driver_closedoor","end");
		driver notify ("gotime"); // why this here twice? I dun know....
	}
//	self thread showtag("tag_driver");


	while (1)
	{
		driver notify ("gotime"); //
		org = self gettagOrigin (driver.exittag);
		angles = self gettagAngles (driver.exittag);
		if(self getspeedmph() == 0)
			driver animscripted("driveranimdone", org, angles, driver.idleanimstop);
		else
			driver animscripted("driveranimdone", org, angles, driver.idleanim);

		driver waittillmatch ("driveranimdone","end");
	}
}

showtag(tag)
{
	while(1)
	{

	org = self gettagOrigin (tag);

	print3d (org + (0,0,0), ("tag here"), (1, 1, 1), 1);
	wait .001;
	}

}


animatemoveintoplace(guy,org,angles,movetospotanim)
{
	guy animscripted("movetospot", org, angles, movetospotanim);
	guy waittillmatch ("movetospot","end");
	guy notify ("doanimscript");

}

wait_jump_out(guy,driverguy)
{
	thread deathremove(guy,driverguy);
	guy endon ("fakedeathhappening"); // don't jump out if you've faked your death
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
}

getinvehicle(vehicle)
{
	self.ownvehicle = vehicle; //so I can know which truck a guy is in
	vehicle notify ("guyenters", self);
}

attach_guys(name,driver,nodriverunload,starthealth)
{
	if(!(isdefined(self.script_vehiclegroup)))
	{
		println("vehicle group is not defined on called vehicle");
		return;
	}
	vehiclegroup = self.script_vehiclegroup;
	spawner = getspawnerarray();
	count = 0;
	guys = [];
	if(isdefined(driver))
	{
		driver.imtehdriver = 1;
		if (isdefined (name))
		{
			spawned = driver dospawn(name);
		}
		else
		{
			spawned = driver dospawn();
		}
		if(isdefined(spawned))
		{
			if(isdefined(starthealth))
				spawned.health = starthealth;
			guys[count] = spawned;
			count++;
		}
		else
		{
			println("spawned truck guy failed to spawn at ",driver.origin);
			spawned = undefined;
		}

		if(level.script == "factory")
			spawned.DrawOnCompass = false;
	}



	for(i=0;i<spawner.size;i++)
	{
		if(isdefined (spawner[i].script_vehiclegroup))
		if(spawner[i].script_vehiclegroup == vehiclegroup && spawner[i].count > 0)
		{
			if (isdefined (name))
			{
				spawned = spawner[i] dospawn(name);
			}
			else
			{
				spawned = spawner[i] dospawn();
			}
			if(isdefined(spawned))
			{
				if(isdefined(starthealth))
					spawned.health = starthealth;
				guys[count] = spawned;
				count++;
			}
			else
			{
				println("spawned truck guy at failed to spawn at ",spawner[i].origin);
				spawned = undefined;
			}

			if(level.script == "factory")
				spawned.DrawOnCompass = false;

		}
	}
	if(!isdefined(guys[0]))
		guys = undefined;
	self thread maps\_truck::handle_attached_guys(guys,nodriverunload);
}

deathremoveremove(guy)
{
	//guy endon("fakedeathhappening");
	//self waittill ("unload");
	guy waittill ("jumpedout");
	if(isalive(guy))
	{
		if(guy.health > guy.healthbuffer)
		{
			println ("^2deathremoveremove doing healthbuffer stuff");
			guy.health -= guy.healthbuffer;
		}
		else
		{
			println("^2guy.health is less than health buffer.. he should be dead.");
			//guy.health = 300;
			guy dodamage((guy.health + 50), (0,0,0));
		}
	}
}

deathremove(guy,driverguy)
{
	//self endon ("unload");
	guy endon ("jumpedout");

	if(!isdefined(guy.fakedeathanim) || isdefined(driverguy))
	{
		println("no deathanim on guy for death remove");
		return;
	}
	guy.healthbuffer = 2000;
	guy.health += guy.healthbuffer;
	thread deathremoveremove(guy);
	while(1)
	{
		guy waittill ("damage");
		if(guy.health<guy.healthbuffer)
			break;

	}
	guy notify ("fakedeathhappening");
	if (!isalive(guy))
	{
		guy unlink();
		guy stopanimscripted();
		return;
	}

	guy animscripted("fakedeath", guy.origin, guy.angles, guy.fakedeathanim);
	guy waittillmatch ("fakedeath","end");
	if (isdefined (guy))
		guy delete();
}

#using_animtree ("germantruck");

life(nodeath)
{
	self.health = 600;
	if(isdefined(nodeath))
		thread nodeath();
}

nodeath()
{
	self.health = 6000;
	while(1)
	{
		self waittill ("damage");
		self.health = 6000;
	}
}
kill()
{
	fx = loadfx("fx/explosions/explosion1.efx");
	self UseAnimTree(#animtree);
	self.deathmodel =("xmodel/vehicle_german_truck_d");
	self waittill( "death", attacker );
	self setmodel(self.deathmodel);

	self playsound ("explo_metal_rand");
	playfx (fx, self.origin );
	earthquake(0.25, 3, self.origin, 1050);
	radiusDamage (self gettagorigin("tag_player"), 245, 200, 100);
	
	enginesmoke = spawn("script_origin",self gettagorigin("tag_engine_left"));
	enginesmoke linkto(self, "tag_engine_left");

	thread enginesmoke(enginesmoke);
	if(self getspeedmph() > 8)
	{

		self setanim(%germantruck_truck_losecontrol);
		self setwaitspeed(8);
		self waittill("reached_wait_speed");
		thread killswerve();
	}

	self notify ("unload");

}

kill_factory()
{
	fx = loadfx("fx/explosions/explosion1.efx");
	self UseAnimTree(#animtree);

	level waittill( "unloadtruck");

	self notify ("unload");

	self waittill( "death", attacker );

	self playsound ("explo_metal_rand");
	playfx (fx, self.origin );
	earthquake(0.25, 3, self.origin, 1050);
}

opendoor()
{
	self useanimtree (#animtree);
//	self animscripted ("opendoor",self.origin,self.angles,%germantruck_truck_closedoor_startpose);
//	self setanimknob(%germantruck_truck_closedoor_startpose, 0, .1);
	self setanim(%germantruck_truck_closedoor_startpose);
}

/*
killswerveonspeed()
{
	self endon ("stopped");
	self setwaitspeed(8);
	self waittill("reached_wait_speed");
	self thread killswerve();
}
killswerveonend()
{
	self endon ("stopped");
	self waittill ("reached_end_node");
	self thread killswerve();
}

*/

killswerve()
{
	self useanimtree (#animtree);
	self setanim(%germantruck_truck_losecontrol, 0, .4);
//	self notify ("stopped");
}

closedoor()
{
	self useanimtree (#animtree);
	self setanimknobrestart(%germantruck_truck_closedoor);
}



jumpoutdoor()
{
	self useanimtree (#animtree);
	self waittill ("unload");
	println("openning door");
	self setanimknobrestart(%germantruck_truck_climbout);
	origin = self gettagorigin("tag_driver");
	maps\_utility::playsoundinspace("truck_door_open",origin);

}

/*

regen()
{
	basehealth = self.health;
	while(self.health > 0)
	{
		self waittill ("damage");
		if(self.health > 0)
			self.health = basehealth;
	}
}

*/

waitframe()
{
	maps\_spawner::waitframe();
}


enginesmoke(engine)
{

	enginesmoke = loadfx("fx/smoke/blacksmokelinger.efx");
	accdist = 0.001;
	fullspeed = 1000.00;


	timer = gettime()+10000;
	while(self.speed > 100 && timer > gettime())
	{
		oldorg = engine.origin;
		waitframe();
		dist = distance(oldorg,engine.origin);
		accdist += dist;
		enginedist = 48;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (enginesmoke, engine.origin);
				accdist -= enginedist;
			}
		}
	}
	while(timer > gettime())
	{
		playfx (enginesmoke, engine.origin);
		wait randomfloat(.3)+.1;
	}

}

bulletregenpercent()
{
	self endon ("death");

	while(1)
	{
		self waittill ("damage",amount);
		amtfraction = amount*.88;
		if(self.health > 0 && amount<900)  // rockets do 1000 damage most of the time
			self.health += amtfraction;
	}

}

wackamolestance(guy)
{
	self endon ("death");
	self endon ("unload");
	guy endon ("death");
	guy allowedStances ("stand","crouch");
	while(1)
	{
		guy allowedStances ("stand");
		wait (randomfloat(2)+4);
		guy allowedStances ("crouch");
		wait (randomfloat(2)+2);

	}
}


