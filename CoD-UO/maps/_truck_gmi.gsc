#using_animtree ("generic_human");

main()
{
	if(getcvar("truck_drawtags") == "")
		setcvar("truck_drawtags","off");
	trucks = getentarray("script_vehicle","classname");
	for(i=0;i<trucks.size;i++)
	{
		if(trucks[i].model == "xmodel/vehicle_german_truck")
		{
			println("^5TRUCK IS GERMAN");
			precachemodel("xmodel/vehicle_german_truck_d"); // For when it blows up.

		}
		if(trucks[i].model == "xmodel/v_ge_lnd_truck_lowbed")
		{
			println("^5TRUCK IS GERMAN");
			precachemodel("xmodel/vehicle_german_truck_d"); // For when it blows up. // maybe need a lowbed version?

		}
		if(trucks[i].model == "xmodel/v_rs_lnd_gazaaa")
		{
			println("^5TRUCK IS RUSSIAN");
			precachemodel("xmodel/v_rs_lnd_gazaaa(d)"); // For when it blows up.
		}
	}
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
	{
		println("^3TREADS ARE NOT DEFINED!");
		maps\_treadfx_gmi::main();
	}
	loadfx("fx/explosions/vehicles/truck_complete.efx");
	loadfx("fx/smoke/blacksmokelinger.efx");
}

init()
{
	if(self.model == ("xmodel/vehicle_halftrack"))
	{
		life("nodeath");
		thread maps\_treads_gmi::main();
		return;
	}

	self.beddoor_open = false;
	life();
	if(self.model == "xmodel/v_rs_lnd_gazaaa")
	{
		self thread gazaaa_kill();
	}
	else
	{
		self thread kill();
	}
	thread bulletregenpercent();
	thread maps\_treads_gmi::main();

}

init_factory()
{
	life();
	thread kill_factory();
	thread bulletregenpercent();
	thread maps\_treads_gmi::main();
}

init_rocket()
{
	life();
	thread kill();
	thread maps\_treads_gmi::main();
}


handle_attached_guys(guys,nodriverunload, angle_offset)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "manual_order")
	{
		self.manual_order = 1;
		self.norandom = 1;
	}
	else
	{
		self.manual_order = 0;
		self.norandom = 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "norandom")  //pile the guys in original order
	{
		self.norandom = 1;
	}

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
	positions[8]["exittag"] = "tag_guy08";
	
	if(getcvar("truck_drawtags") != "off")
	for(i=0;i<positions.size;i++)
	{
		self thread drawtag(positions[i]["exittag"],i);
	}
	
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
	
	if(!(self.norandom))  //stupid double negatives.. heheh
	{
		count = 0;
		array = [];
		for(i=1;i<positions.size;i++)
		{
			array[count] = positions[i];
			count++;
		}
		array = maps\_utility_gmi::array_randomize(array);
		count = 1;
		for(i=0;i<array.size;i++)
		{
			positions[count] = array[i];
			count++;
		}
	}
	if(self.manual_order)
	{
		neworder = [];
		for(i=0;i<level.truckguypositions[self.script_vehiclegroup].size;i++)
		{
			neworder[i]=positions[level.truckguypositions[self.script_vehiclegroup][i]];
		}
		positions = neworder;
	}
	
	climbnode [0] = "tag_climbnode";
	climbanim [0] = %germantruck_guyC_climbin;

	for(i=0;i<climbnode.size;i++)
		self.climbnode[i] = climbnode[i];
	for(i=0;i<climbanim.size;i++)
		self.climbanim[i] = climbanim[i];
	movetospotanim = %stand_alert_1;
	pos = 0;
	if(!isdefined(nodriverunload))
	{
		if(self.model == "xmodel/v_rs_lnd_gazaaa")
		{
			self thread gazaaa_jumpoutdoor();
		}
		else
		{
			self thread jumpoutdoor();
		}
	}

	while(self.health > 0)
	{
		if (isdefined(guys))
		{
			guysarray = guys;
//			println("^4Guys Array ",guysarray.size);
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

			//This is to manually set the guy's exit / attached tag
			if(isdefined(guy.truck_pos))
			{
				guy.exittag = positions[guy.truck_pos]["exittag"];
				guy.getoutanim = positions[guy.truck_pos]["getoutanim"];
				guy.delay = positions[guy.truck_pos]["delay"];
				guy.fakedeathanim = positions[guy.truck_pos]["deathanim"];
			}
			else
			{
				guy.exittag = positions[pos]["exittag"];
				guy.getoutanim = positions[pos]["getoutanim"];
				guy.delay = positions[pos]["delay"];
				guy.fakedeathanim = positions[pos]["deathanim"];
			}				

			org = self gettagorigin(guy.exittag);

			if(isdefined(angle_offset))
			{
				angles = (self gettagAngles(guy.exittag)) + angle_offset;
			}
			else
			{
				angles = self gettagAngles(guy.exittag);
			}

			if(pos != 0)
			{
//				thread deathremove(guy);
				if(level.script == "truckride" || level.script == "airfield" || level.script == "sicily2")
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
	self animcustom (animscripts\scripted\truckride_backoftruck_gmi::main);
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

		if(self.model == "xmodel/v_rs_lnd_gazaaa")
		{
			self thread gazaaa_opendoor();
		}
		else
		{
			self thread opendoor();
		}

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

		if(self.model == "xmodel/v_rs_lnd_gazaaa")
		{
			self thread gazaaa_closedoor();
		}
		else
		{
			self thread closedoor();
		}

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

	guy notify("stop anim"); // Stop the AI from playing their looping anims.

	if (!(isalive (guy)))
		return;
	guy.hasweapon = true;
	guy animscripts\shared::PutGunInHand("right");
	wait (guy.delay);
	if (!(isalive (guy)))
		return;

	org = self gettagOrigin (guy.exittag);
	angles = self gettagAngles (guy.exittag);
//MikeD: Angle offsets for the gazaa truck, since Dom modified it for the guys when they climb in.
	if(self.model == "xmodel/v_rs_lnd_gazaaa" && guy.exittag != "tag_driver")
	{
		if(guy.exittag == "tag_guy01" || guy.exittag == "tag_guy03" || guy.exittag == "tag_guy05" || guy.exittag == "tag_guy07")
		{
			angles = self.angles + (0,-90,0);
		}
		else if(guy.exittag == "tag_guy08")
		{
			angles = self.angles + (0,105,0);
		}
		else
		{
			angles = self.angles + (0,90,0);
		}
	}

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
	self thread maps\_truck_gmi::handle_attached_guys(guys,nodriverunload);
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
//			println ("^2deathremoveremove doing healthbuffer stuff");
			guy.health -= guy.healthbuffer;
		}
		else
		{
//			println("^2guy.health is less than health buffer.. he should be dead.");
			//guy.health = 300;
			guy dodamage((guy.health + 50), (0,0,0));
		}
	}
}

deathremove(guy,driverguy)
{
	//self endon ("unload");
	guy endon ("jumpedout");

	guy notify("stop anim");

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
	fx = loadfx("fx/explosions/vehicles/truck_complete.efx");
	
	self UseAnimTree(#animtree);

	self.deathmodel =("xmodel/vehicle_german_truck_d"); // For when it blows up.

	self waittill( "death", attacker );
	self setmodel(self.deathmodel);

	self playsound ("explo_metal_rand");

	playfxOnTag ( fx, self, "tag_origin" );

	earthquake(0.25, 3, self.origin, 1050);
	radiusDamage (self gettagorigin("tag_player"), 245, 200, 100);
	
	enginesmoke = spawn("script_origin",self gettagorigin("tag_engine_left"));
	enginesmoke linkto(self, "tag_engine_left");

	thread enginesmoke(enginesmoke);
	level thread maps\_utility_gmi::blend_upanddown_sound(self,24,"truckfire_low","truckfire_high");

	if(self getspeedmph() > 8 && (isdefined(self.no_deathanim) && !self.no_deathanim))
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
	fx = loadfx("fx/explosions/vehicles/truck_complete.efx");
	self UseAnimTree(#animtree);

	level waittill( "unloadtruck");

	self notify ("unload");

	self waittill( "death", attacker );

	self playsound ("explo_metal_rand");
	playfx (fx, self.origin );
	level thread maps\_utility_gmi::blend_upanddown_sound(self,24,"truckfire_low","truckfire_high");

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

	self notify("stop anim");

	println("openning door");
	self setanimknobrestart(%germantruck_truck_climbout);
	origin = self gettagorigin("tag_driver");
	maps\_utility_gmi::playsoundinspace("truck_door_open",origin);

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
	maps\_spawner_gmi::waitframe();
}


enginesmoke(engine)
{
	if(self.model == "xmodel/v_rs_lnd_gazaaa")
	{
		return;
	}
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

////////////////////////////////////////
//         GAZAAA SECTION             //
////////////////////////////////////////

#using_animtree ("gazaaa");
gazaaa_kill()
{
	fx = loadfx("fx/explosions/vehicles/gazaaa.efx");
	
	self UseAnimTree(#animtree);

	self.deathmodel =("xmodel/v_rs_lnd_gazaaa(d)"); // For when it blows up.

	self waittill( "death", attacker );
	self setmodel(self.deathmodel);

	self playsound ("explo_metal_rand");

	playfxOnTag ( fx, self, "tag_origin" );

	earthquake(0.25, 3, self.origin, 1050);
	radiusDamage (self gettagorigin("tag_player"), 245, 200, 100);
	
	enginesmoke = spawn("script_origin",self gettagorigin("tag_engine_left"));
	enginesmoke linkto(self, "tag_engine_left");
	level thread maps\_utility_gmi::blend_upanddown_sound(self,24,"truckfire_low","truckfire_high");

	thread enginesmoke(enginesmoke);
	if(self getspeedmph() > 8 && (isdefined(self.no_deathanim) && !self.no_deathanim))
	{
		self setanim(%germantruck_truck_losecontrol);
		self setwaitspeed(8);
		self waittill("reached_wait_speed");
		self thread gazaaa_killswerve();
	}

	self notify ("unload");
}

gazaaa_opendoor()
{
	self useanimtree (#animtree);
	self setanim(%germantruck_truck_closedoor_startpose);
}

gazaaa_killswerve()
{
	self useanimtree (#animtree);
	self setanim(%germantruck_truck_losecontrol, 0, .4);
}

gazaaa_closedoor()
{
	self useanimtree (#animtree);
	self setanimknobrestart(%germantruck_truck_closedoor);
}

gazaaa_jumpoutdoor()
{
	self useanimtree (#animtree);
	self waittill ("unload");
	println("openning door");
	self setanimknobrestart(%germantruck_truck_climbout);
	origin = self gettagorigin("tag_driver");
	maps\_utility_gmi::playsoundinspace("truck_door_open",origin);

}

toggle_beddoor()
{
	if(!isdefined(self.beddoor_open))
	{
		self.beddoor_open = false;
	}

	if(!self.beddoor_open)
	{
		println("^3TRUCK BED OPEN!");
		self setanimknobrestart(%v_rs_lnd_gazaaa_beddoor_open);
		self.beddoor_open = true;
	}
	else if(self.beddoor_open)
	{
		println("^3TRUCK BED CLOSE!");
		self setanimknobrestart(%v_rs_lnd_gazaaa_beddoor_close);
		self.beddoor_open = false;		
	}
}

climb_in_truck_setup(guys, delay_notify, skip)
{
	self.guy_count = guys.size;
	self.guy_counter = 0;

	for(i=0;i<guys.size;i++)
	{
		closest_guy = 0;
		tag_org = self gettagorigin("TAG_CLIMB0" + (8 - i));
		tag_dist = 10000;

		for(q=0;q<guys.size;q++)
		{
			if(isdefined(guys[q].climb_tag))
			{
				continue;
			}

			dist = distance(guys[q].origin, tag_org);

			if(dist < tag_dist)
			{

				tag_dist = dist;
				closest_guy = q;
			}
		}

		guys[closest_guy].climb_tag = 8 - i;

		guys[closest_guy] thread go_to_climb_tag(self, delay_notify, skip, guys);
	}
}

go_to_climb_tag(truck, delay_notify, skip, guys, wait_till, offset)
{
	if(!isdefined(skip))
	{
//		println(self);
//		println("^2TAG_CLIMB0" + self.climb_tag);
		self maps\_anim_gmi::anim_reach_solo(self,"run to truck", ("TAG_CLIMB0" + self.climb_tag), undefined, truck);
	}

	if(!isdefined(truck.guy_counter))
	{
		truck.guy_count = guys.size;
		truck.guy_counter = 0;
	}

	truck.guy_counter++;

//	if(truck.targetname == "truck1")
//		println(truck.targetname,"^3 Guy Counter: ",truck.guy_counter, " " , truck.guy_count);

	if(truck.guy_counter == truck.guy_count)
	{
		if(isdefined(delay_notify))
		{
			wait delay_notify;
		}
		else
		{
			wait 1;
		}

		if(isdefined(wait_till))
		{
//println(truck.targetname, " WAIT TILL, WAITING...");
			truck waittill(wait_till);
		}

		for(i=0;i<guys.size;i++)
		{
			guys[i] thread climb_in_truck(delay, truck, offset);
		}
	}

}

#using_animtree ("generic_human");
climb_in_truck(delay, truck, offset)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	// Switch 1, 4, 5, 6 to use the smoother sicily climb in truck anim.
	positions[0]["climb_in_anim"] = 0;
	positions[1]["climb_in_anim"] = %c_br_sicily1_climbtruck_guy1;
	positions[2]["climb_in_anim"] = %trenches_climbingontruck2;
	positions[3]["climb_in_anim"] = %trenches_climbingontruck3;
	positions[4]["climb_in_anim"] = %c_br_sicily1_climbtruck_guy4;
	positions[5]["climb_in_anim"] = %c_br_sicily1_climbtruck_guy5;
	positions[6]["climb_in_anim"] = %c_br_sicily1_climbtruck_guy6;
	positions[7]["climb_in_anim"] = %trenches_climbingontruck7;
	positions[8]["climb_in_anim"] = %trenches_climbingontruck8;

	// Special case for Trenches
	if(level.script == "trenches")
	{
		positions[2]["climb_in_anim"] = %trenches_climbingontruck2faster;
	}
	else
	{
		positions[2]["climb_in_anim"] = %trenches_climbingontruck2;
	}


	org = truck gettagOrigin (("tag_climb0" + self.climb_tag));
	angles = truck gettagAngles (("tag_climb0" + self.climb_tag));
	self.get_in_anim = positions[self.climb_tag]["climb_in_anim"];

	self animscripted("climb_in", org, angles, self.get_in_anim);
	self waittillmatch ("climb_in","end");

//	self maps\_anim_gmi::anim_single_solo(self, ("truck_climb_" + self.climb_tag), ("TAG_CLIMB0" + self.climb_tag), undefined, truck);
	self setgoalpos(self.origin);

	truck thread handle_climbed_guys(self, (0,0,0));
}

handle_climbed_guys(guy, angle_offset)
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

	positions[0]["closedooranim"] = %germantruck_driver_closedoor;

	positions[0]["exittag"] = "tag_driver";
	positions[1]["exittag"] = "tag_guy01";
	positions[2]["exittag"] = "tag_guy02";
	positions[3]["exittag"] = "tag_guy03";
	positions[4]["exittag"] = "tag_guy04";
	positions[5]["exittag"] = "tag_guy05";
	positions[6]["exittag"] = "tag_guy06";
	positions[7]["exittag"] = "tag_guy07";
	positions[8]["exittag"] = "tag_guy08";

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
	movetospotanim = %stand_alert_1;

	for(i=0;i<climbnode.size;i++)
		self.climbnode[i] = climbnode[i];
	for(i=0;i<climbanim.size;i++)
		self.climbanim[i] = climbanim[i];

	if(self.health > 0)
	{
		guy.exittag = positions[guy.climb_tag]["exittag"];
		guy.getoutanim = positions[guy.climb_tag]["getoutanim"];
		guy.delay = positions[guy.climb_tag]["delay"];
		guy.fakedeathanim = positions[guy.climb_tag]["deathanim"];

		org = self gettagorigin(guy.exittag);

		if(isdefined(angle_offset))
		{
			angles = (self gettagAngles(guy.exittag)) + angle_offset;
		}
		else
		{
			angles = self gettagAngles(guy.exittag);
		}


		if(isdefined(offset))
		{
			guy linkto(self, (guy.exittag + offset));
		}
		else
		{
			guy linkto (self, guy.exittag);
		}

		if(isdefined(self.original_animname))
		{
			self.animname = self.original_animname;
		}
//		self thread animatemoveintoplace(guy,org,angles,movetospotanim);
		self thread wait_jump_out(guy);

		if(isdefined(guy.climb_tag))
		{
			guy thread gazaaa_truck_anim(self, angle_offset);
		}
	}
}

gazaaa_truck_anim(truck, angle_offset)
{
//	self waittill("doanimscript");
	positions = [];
	positions[1]["idle"] = %trenches_truck_idle1;
	positions[2]["idle"] = %trenches_truck_idle2;
	positions[3]["idle"] = %trenches_truck_idle3;
	positions[4]["idle"] = %trenches_truck_idle4;
	positions[5]["idle"] = %trenches_truck_idle5;
	positions[6]["idle"] = %trenches_truck_idle6;
	positions[7]["idle"] = %trenches_truck_idle7;
	positions[8]["idle"] = %trenches_truck_idle8;

	positions_b = [];	
	positions_b[1]["idle"] = %trenches_truck_idleB1;
	positions_b[2]["idle"] = %trenches_truck_idleB2;
	positions_b[3]["idle"] = %trenches_truck_idleB3;
	positions_b[4]["idle"] = %trenches_truck_idleB4;
	positions_b[5]["idle"] = %trenches_truck_idleB5;
	positions_b[6]["idle"] = %trenches_truck_idleB6;
	positions_b[7]["idle"] = %trenches_truck_idleB7;
	positions_b[8]["idle"] = %trenches_truck_idleB8;

	level.scr_anim[self.animname][("idle" + self.climb_tag)][0] = positions[self.climb_tag]["idle"];
	level.scr_anim[self.animname][("idle" + self.climb_tag)][1] = positions_b[self.climb_tag]["idle"];

	org = truck gettagorigin(self.exittag);
	if(isdefined(angle_offset))
	{
		angles = (truck gettagAngles(self.exittag) + angle_offset);
		angles = (angles[0] * -1, angles[1], angles[2] * -1); // Use for the angled ground in trenches.
	}
	else
	{
		angles = (truck gettagAngles(self.exittag));
	}

//	while(1)
//	{
			org = truck gettagorigin(self.exittag);
			angles = truck gettagAngles(self.exittag);
//			angles = (truck gettagAngles(self.exittag) + angle_offset);
//			angles = (angles[0] * -1, angles[1], angles[2] * -1); // Use for the angled ground in trenches. Dom should fix the tag angles.

//			self animscripted( "looping anim", org, angles, positions[self.climb_tag]["idle"] );
//			self waittillmatch ("looping anim", "end");

//	anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
	self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "stop anim", undefined, truck);
//	}
}

drawtag(str_tag,int_position)
{
	ent_org = spawn("script_origin",self gettagorigin(str_tag));
	ent_org linkto (self,str_tag,(0,0,0),(0,0,0));
	while(1)
	{
		print3d(ent_org.origin,int_position+": "+str_tag, (1,1,1) , 1 , 1);
		wait .05;
	}
}

/*
tag positions are
**back of truck**
1	2
3	4
5	6
7	8
    0
*/