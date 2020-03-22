#using_animtree ("generic_human");

main()
{
	precachemodel("xmodel/vehicle_german_kubelwagen_d");
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_treadfx::main();

	loadfx("fx/smoke/blacksmokelinger.efx");
	loadfx("fx/explosions/explosion1.efx");
}


init()
{
	life();
	thread kill();
	thread maps\_treads::main();
	thread bulletregenpercent();
}

handle_attached_guys(guys)
{
//	wagon_backleft_fire_left60
//	wagon_backleft_fire
//	wagon_backleft_fire_right60

	level.guyevent = [];
	positions[0]["getout"] = %wagon_driver_jumpout;
//positions[0]["getout"] = %wagon_passenger_jumpout;
	positions[1]["getout"] = %wagon_passenger_jumpout;
	positions[2]["getout"] = %wagon_backleft_jumpout;

	positions[0]["idle"][0] = %wagon_driver_idle;
	positions[1]["idle"][0] = %wagon_passenger_idle;
	positions[2]["idle"][0] = %wagon_backleft_idle;

	positions[0]["idleoccurrence"][0] = 500;
	positions[1]["idleoccurrence"][0] = 500;
	positions[2]["idleoccurrence"][0] = 1800;

	positions[0]["idle"][1] = %wagon_driver_idle_twitch1;
	positions[1]["idle"][1] = %wagon_passenger_idle_look;
	positions[2]["idle"][1] = %wagon_backleft_idle_look;

	positions[0]["idleoccurrence"][1] = 300;
	positions[1]["idleoccurrence"][1] = 300;
	positions[2]["idleoccurrence"][1] = 200;

	positions[0]["idle"][2] = %wagon_driver_point;
//	positions[1]["idle"][2] = %wagon_driver_point;
//	positions[2]["idle"][2] = %wagon_backleft_idle_look;

	positions[0]["idleoccurrence"][2] = 100;
//	positions[1]["idleoccurrence"][2] = 100;
//	positions[2]["idleoccurrence"][2] = 100;

	positions[0]["idle"][3] = %wagon_driver_look;
//	positions[1]["idle"][3] = %wagon_passenger_idle;
//	positions[2]["idle"][3] = %wagon_backleft_idle_look;

	positions[0]["idleoccurrence"][3] = 100;
//	positions[1]["idleoccurrence"][3] = 100;
//	positions[2]["idleoccurrence"][3] = 100;

	positions[0]["duckin"] = %wagon_driver_duck;
//	positions[1]["duckin"] = %wagon_passenger_idle;
//	positions[2]["duckin"] = %wagon_backleft_idle;

	positions[0]["duckout"] = %wagon_driver_duck_return;
//	positions[1]["duckout"] = %wagon_passenger_idle_look;
//	positions[2]["duckout"] = %wagon_backleft_idle_look;

	positions[0]["duckidle"][0] = %wagon_driver_duck_idle;
//	positions[1]["duckidle"][0] = %wagon_passenger_idle;
//	positions[2]["duckidle"][0] = %wagon_backleft_idle;

	positions[0]["duckidleoccurrence"][0] = 100;
//	positions[1]["duckidleoccurrence"][0] = 100;
//	positions[2]["duckidleoccurrence"][0] = 100;

	positions[0]["duckidle"][1] = %wagon_driver_duck_look;
//	positions[1]["duckidle"][1] = %wagon_driver_duck_look;
//	positions[2]["duckidle"][1] = %wagon_driver_duck_look;

	positions[0]["duckidleoccurrence"][1] = 100;
//	positions[1]["duckidleoccurrence"][1] = 100;
//	positions[2]["duckidleoccurrence"][1] = 100;

//	positions[0]["standup"] = %wagon_driver_idle;  //driver doesn't stand.
	positions[1]["standup"] = %wagon_passenger_up;
	positions[2]["standup"] = %wagon_backleft_up;

//	positions[0]["standdown"] = %wagon_driver_idle;  //driver doesn't stand.
	positions[1]["standdown"] = %wagon_passenger_down;
	positions[2]["standdown"] = %wagon_backleft_down;

//	positions[0]["standidle"] = %wagon_driver_idle;
	positions[1]["standidle"] = %wagon_passenger_idle_up;
	positions[2]["standidle"] = %wagon_backleft_idle_up;

//	positions[0]["standattack"] = %wagon_driver_idle;
	positions[1]["standattack"] = %wagon_passenger_fire;
	positions[2]["standattack"] = %wagon_backleft_fire;

//	positions[0]["standattackforward"] = %wagon_driver_idle;
	positions[1]["standattackforward"] = %wagon_passenger_fire;
	positions[2]["standattackforward"] = %wagon_backleft_fire;

//	positions[0]["standattackleft"] = %wagon_driver_idle;
	positions[1]["standattackleft"] = %wagon_passenger_fire;
	positions[2]["standattackleft"] = %wagon_backleft_fire_left60;

//	positions[0]["standattackright"] = %wagon_driver_idle;
	positions[1]["standattackright"] = %wagon_passenger_fire;
	positions[2]["standattackright"] = %wagon_backleft_fire_right60;

//	positions[0]["standattack"] = %wagon_driver_idle;
	positions[1]["standattack"] = %wagon_passenger_fire;
	positions[2]["standattack"] = %wagon_backleft_fire;

//	positions[0]["standattackthreads"][0] = ::fire;
	positions[1]["standattackthreads"][0] = ::fire;
	positions[2]["standattackthreads"][0] = ::fire;

//	positions[0]["standattacktracks"][0] = "end";  //todo
	positions[1]["standattacktracks"][0] = "end";
	positions[2]["standattacktracks"][0] = "end";

//	positions[0]["standidle"][2] = %wagon_driver_idle;
//	positions[1]["standidle"][2] = %wagon_driver_idle;
//	positions[2]["standidle"][2] = %wagon_backleft_fire;

//	positions[0]["standidleoccurrence"][2] = 500;
//	positions[1]["standidleoccurrence"][2] = 500;
//	positions[2]["standidleoccurrence"][2] = 500;

	positions[0]["closedoor"] = %germantruck_driver_closedoor;
	positions[1]["closedoor"] = %germantruck_driver_closedoor;
	positions[2]["closedoor"] = %germantruck_driver_closedoor;

	positions[0]["sittag"] = "tag_driver";
	positions[1]["sittag"] = "tag_passenger";
	positions[2]["sittag"] = "tag_guy02"; // back left
//	positions[3]["sittag"] = "tag_guy01";

//	positions[0]["exitdelay"] = 0;
//	positions[1]["exitdelay"] = 0;
//	positions[2]["exitdelay"] = .2;

	positions[0]["death"] = %wagon_driver_death;
	positions[1]["death"] = %wagon_passenger_death;
	positions[2]["death"] = %wagon_backleft_death_hit;

	positions[0]["deathloop"] = %wagon_driver_death;
	positions[1]["deathloop"] = %wagon_passenger_death;
//	positions[2]["deathloop"] = %wagon_backleft_death_hit;



	positions[0]["sittag"] = "tag_driver";

	climbnode [0] = "tag_climbnode";
	climbanim [0] = %germantruck_guyC_climbin;


//	movetospotanim = %stand_alert_1;

	for(i=0;i<climbnode.size;i++)
		self.climbnode[i] = climbnode[i];
	for(i=0;i<climbanim.size;i++)
		self.climbanim[i] = climbanim[i];
	if(!isdefined(self.standuptime))
		self.standuptime = 7;

	pos = 0;
	maxpos = 3;
	self.attachedguys = [];
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
			self.attachedguys[self.attachedguys.size] = guy;
			thread wait_jump_out(guy);
			thread guy_waitjumpout(guy);


			guy.orghealth = guy.health;
			guy.idle = positions[pos]["idle"];			//multiple idle anims
			guy.idleoccurrence = positions[pos]["idleoccurrence"];
			guy.duckidle = positions[pos]["duckidle"];			//multiple duck anims
			guy.duckidleoccurrence = positions[pos]["duckidleoccurrence"];

			guy.standidle = positions[pos]["standidle"];
			guy.standattack = positions[pos]["standattack"];

			guy.standattackforward = positions[pos]["standattackforward"];
			guy.standattackleft = positions[pos]["standattackleft"];
			guy.standattackright = positions[pos]["standattackright"];

			guy.standattackthreads = positions[pos]["standattackthreads"];
			guy.standattacktracks = positions[pos]["standattacktracks"];


			guy.sittag = positions[pos]["sittag"];
			guy.getout = positions[pos]["getout"];
			guy.exitdelay = positions[pos]["exitdelay"];
			guy.closedoor = positions[pos]["closedoor"];
			guy.duckin = positions[pos]["duckin"];
			guy.standup = positions[pos]["standup"];

			guy.standdown = positions[pos]["standdown"];
			guy.duckout =  positions[pos]["duckout"];
			guy.deathanim = positions[pos]["death"];
			guy.deathanimloop = positions[pos]["deathloop"];
			guy.standing = 0;
			guy thread fireing();
			guy thread fireingdirection(self);

			if(isdefined(guy.deathanim))
			{
				guy.allowdeath = 1;
			}

			org = self gettagorigin(guy.sittag);
			angles = self gettagAngles(guy.sittag);
			guy linkto (self, guy.sittag, (0, 0, 0), (0, 0, 0));

			if(pos != 0)
			{
				if(pos == 2)
				{
					thread guy_deathroll(guy,%wagon_backleft_death_roll);
				}
				guy teleport(org,angles);
				thread guy_handle(guy);
				thread guy_idle(guy);
			}

			if(pos == 0)
			{
				guy.hasweapon = false;
				guy animscripts\shared::PutGunInHand("none");
				self.driver = guy;
				thread driverdead(guy);
				thread guy_handle(guy);
				thread guy_idle(guy);
			}
			if(pos < (maxpos-1))
				pos++;
			else
			{

				break;
			}
		}
	}
}

driverdead(guy)
{
	guy waittill ("death");
	self.deaddriver = 1;  //vehiclechase crash
}

guy_deathroll(guy, animation)
{
	self endon("crasher");
	self endon ("unload");
	orghealth = guy.health;
	buffer = 3000;
	guy.health += buffer;
	while(1)
	{
		guy waittill ("damage",ammount,attacker);
		if(isSentient(attacker))
		if(isdefined(attacker) && isdefined(attacker.team) && isdefined(guy.team) && attacker.team == guy.team)
		{
			guy.health += ammount;
		}
		if(guy.health < buffer+orghealth)
			break;
	}
	if(self getspeedmph() > 20)
	{

		self thread guy_fastdeathroll(guy);
	}
	else
	{
		self thread guy_slowdeathroll(guy);

	}
}

guy_fastdeathroll(guy)
{
	guy notify ("customdeath");
	guy.deathanimloop = undefined;
	guy.allowdeath = 0;
	org = self gettagOrigin (guy.sittag);
	angles = self gettagAngles (guy.sittag);
	guy animscripted("animontagdone", org, angles, guy.deathanim);
	guy.deathanim = %wagon_backleft_death_roll;
	guy waittillmatch ("animontagdone","end");
	guy unlink();
	guy.allowdeath = 1;
	guy dodamage(guy.health + 50,(0,0,0));
}

guy_slowdeathroll(guy)
{
	guy notify ("customdeath");
	guy.deathanimloop = undefined;
	guy.allowdeath = 0;
	org = self gettagOrigin (guy.sittag);
	angles = self gettagAngles (guy.sittag);
	guy.deathanim = %wagon_backleft_slowdeath_hit;
	guy animscripted("animontagdone", org, angles, guy.deathanim);
	guy.deathanim = %wagon_backleft_slowdeath_roll;
	guy waittillmatch ("animontagdone","end");
	guy unlink();
	guy.allowdeath = 1;
	guy dodamage(guy.health + 50,(0,0,0));
}

guy_healthmonitor()
{
	while(1)
	{
		println("health is ", self.health);
		wait .2;
	}
}

guy_handle(guy)
{

	guy.buddyevent = [];
	guy.idling = 1;
	guy endon ("death");
	while (1)
	{
		self waittill ("groupedanimevent",other);
		if(guy.idling == 1)
		{
			guy.idling = 0;
			if(other == "idle")
			{
				self thread guy_idle(guy);
			}
			else if(other == "duck")
			{
				if(!isdefined(guy.duckin))
				{
					self thread guy_idle(guy);
				}
				else
				{
					self thread guy_duck(guy);
				}
			}
			else if(other == "stand")
			{

				if(!isdefined(guy.standup))
				{
					self thread guy_idle(guy);
				}
				else
				{
					self thread guy_stand(guy);
				}
			}
			else if(other == "unload")
			{

				if(!isdefined(guy.getout))
				{
					self thread guy_idle(guy);
				}
				else
				{
					self guy_unload(guy);
					break;
				}

			}
			else
			{
				println("leaaaaaaaaaaaaaak", other);
			}
		}
	}
}

guy_stand(guy)
{
	self endon ("death");
	guy endon ("customdeath");
//	checkevents("stand",1,guy);
	animontag(guy,guy.sittag,guy.standup);
//	checkevents("stand",0,guy);
	guy_stand_attack(guy);

}

guy_stand_attack(guy)
{
//	checkevents("standattack",1,guy);
	guy endon ("endstand");
	guy endon ("death");
	guy.standing = 1;
	mintime = 0;
	timer = gettime() + 5000;
		if (timer < mintime)
			timer = mintime;
	while (gettime() < timer)
	{
		timer2 = gettime() + 2000;
		while (gettime() < timer2)
		{
			animflaggedontag("firing",guy,guy.sittag,guy.standattack);
		}

		rnum = randomint(5)+10;
		for(i=0;i<rnum;i++)
		{
			if(gettime() > timer)
				break;
			animontag(guy,guy.sittag,guy.standidle);
		}

	}
//	checkevents("standattack",0,guy);
	guy_stand_down(guy);
}

guy_stand_down(guy)
{
	animontag(guy,guy.sittag,guy.standdown);
	guy.standing = 0;
	guy_idle(guy);

}

guy_idle(guy)
{
	guy endon ("jumpingout");
	self endon ("groupedanimevent");
	guy.idling = 1;
	guy notify ("gotime");
	while(1)
	{
		guy notify ("idle");
		theanim = randomoccurrance(guy,guy.idleoccurrence);
		animontag(guy,guy.sittag,guy.idle[theanim]);
	}
}

randomoccurrance(guy,occurrences)
{
	range = [];
	totaloccurrance = 0;
	for(i=0;i<occurrences.size;i++)
	{
		totaloccurrance += occurrences[i];
		range[i] = totaloccurrance;
	}
	pick = randomint(totaloccurrance);
	for(i=0;i<occurrences.size;i++)
	{
		if(pick < range[i])
		{
			return i;
		}
	}
}

guy_duck(guy)
{
//	checkevents("guy_duck",1,guy);
	animontag(guy,guy.sittag, guy.duckin);
//	checkevents("guy_duck",0,guy);
	thread guy_duck_idle(guy);

}

guy_duck_idle(guy)
{
//	checkevents("guy_duck_idle",1,guy);
	theanim = randomoccurrance(guy,guy.duckidleoccurrence);
	animontag(guy,guy.sittag, guy.duckidle[theanim]);
//	checkevents("guy_duck_idle",0,guy);
	thread guy_duck_out(guy);
}

guy_duck_out(guy)
{
	guy endon ("customdeath");
//	checkevents("guy_duck_out",1,guy);
	if(isdefined(guy.ducking) && guy.ducking == 1)
	{
		animontag(guy,guy.sittag, guy.duckout);
		guy.ducking = 0;
	}
//	checkevents("guy_duck_out",0,guy);
	thread guy_idle(guy);
}

guy_unload(guy)
{
	guy.health = guy.orghealth;
	guy endon ("customdeath");
//	checkevents("guy_unload",1,guy);
	guy endon ("death");
	animontag(guy,guy.sittag, guy.getout);
	guy unlink();
//	checkevents("guy_unload",0,guy);
}

animontag_old(guy, tag , animation)
{
	guy endon ("customdeath");
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(guy.deathanim))
		guy.allowdeath = 1;
	guy waittillmatch ("animontagdone","end");
}

animontag(guy, tag , animation, notetracks, sthreads)
{
	guy endon ("customdeath");
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(notetracks))
	{
		for(i=0;i<notetracks.size;i++)
		{
			if(!isdefined(notetracks[i]))
				println("notetrack is undefined");
			guy waittillmatch ("animontagdone",notetracks[i]);
			guy thread [[sthreads[i]]]();
		}

	}
	guy waittillmatch ("animontagdone","end");
}

animflaggedontag(flag,guy, tag , animation, notetracks, sthreads)
{
	guy endon ("customdeath");
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted(flag, org, angles, animation);
	if(isdefined(notetracks))
	{
		for(i=0;i<notetracks.size;i++)
		{
			if(!isdefined(notetracks[i]))
			{
				println("notetrack is undefined");

			}
			guy waittillmatch (flag,notetracks[i]);
			guy thread [[sthreads[i]]]();
		}

	}
	guy waittillmatch (flag,"end");
}


showtag(tag)
{
	while(1)
	{
		org = self gettagOrigin (tag);
		print3d (org + (0,0,0), ("tag here"), (1, 1, 1), 1);
		maps\_spawner::waitframe();
	}

}


animatemoveintoplace(guy,org,angles,movetospotanim)
{
	guy animscripted("movetospot", org, angles, movetospotanim);
	guy waittillmatch ("movetospot","end");
}


wait_jump_out(guy)
{
	guy endon ("death");
	self waittill ("unload");
	guy notify ("unload");
}

getinvehicle(vehicle)
{
	vehicle notify ("guyenters", self);
}


attach_guys(name,driver)
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
			guys[count] = spawned;
			count++;
		}
		else
		{
			println("spawned kubelwagon guy " + who + " failed to spawn at ",spawned.origin);
			spawned = undefined;
		}
	}



	for(i=0;i<spawner.size;i++)
	{
		if(isdefined (spawner[i].script_vehiclegroup))
		if(spawner[i].script_vehiclegroup == vehiclegroup && spawner[i].count > 0)//!(isdefined(driver) && spawner[i] != driver))
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
				guys[count] = spawned;
				count++;
			}
			else
			{
				println("spawned kubelwagon guy " + who + " failed to spawn at ",spawned.origin);
				spawned = undefined;
			}
		}
	}
	if(!isdefined(guys[0]))
		guys = undefined;
	self thread maps\_kubelwagon::handle_attached_guys(guys);
}

fire()
{
	self shoot();
}



guy_waitjumpout(guy)
{
	guy waittill ("unload");
	if(guy.standing)
	{
		guy notify ("endstand");
	}
	else if(!guy.idling)
		guy waittill ("idle");

	guy notify ("jumpingout");
	thread guy_unload(guy);
	guy.deathanim = undefined;
}

fireingdirection(vehicle)
{
	vehicle endon ("unload");
	while(1)
	{
		if(isdefined(self.enemy))
		{
			org1 = self.origin;
			org2 = self.enemy.origin;
			forwardvec = anglestoforward(flat_angle(vehicle.angles));
			rightvec = anglestoright(flat_angle(vehicle.angles));
			normalvec = vectorNormalize(org2-org1);
			vectordotup = vectordot(forwardvec,normalvec);
			vectordotright = vectordot(rightvec,normalvec);
			if(vectordotup > .866)
			{
				if(self.standattack != self.standattackforward)
				{
					self.standattack = self.standattackforward;
					self notify ("firing","end");  // cancels old animation
				}
			}
			else if(vectordotright > 0)
			{
				if(self.standattack != self.standattackright)
				{
					self.standattack = self.standattackright;
					self notify ("firing","end");
				}

			}
			else if(vectordotright < 0)
			{
				if(self.standattack != self.standattackleft)
				{
					self.standattack = self.standattackleft;
					self notify ("firing","end");
				}

			}
		}
		waitframe();
	}
}

flat_angle(angle)
{
	rangle = (0,angle[1],0);
	return rangle;
}

flat_origin(org)
{
	rorg = (org[0],org[1],0);
	return rorg;

}

waitframe()
{
	maps\_spawner::waitframe();
}

fireing()
{
	while(1)
	{
		self waittillmatch("firing","fire");
		self shoot();

	}
}

////////////////////////////////
////////////////////////////////
#using_animtree ("kubelwagon");
////////////////////////////////
////////////////////////////////

waittill_unload_speed()
{
	self setWaitSpeed(5);

	self waittill("reached_wait_speed");

	self notify ("unload");
}

life()
{
	self.health = 600;
}

kill()
{
	fx = loadfx("fx/explosions/explosion1.efx");
	self thread crashroll();
	self waittill( "death", attacker );
	radiusDamage (self.origin+(0,0,128), 128, 800, 400);
	self.deathmodel = ("xmodel/vehicle_german_kubelwagen_d");
	self setmodel (self.deathmodel);
	self playsound ("explo_metal_rand");
	playfx (fx, self.origin );
	earthquake(0.25, 3, self.origin, 1050);
	self.enginesmoke = spawn("script_origin",self gettagorigin("tag_engine_left"));
	self.enginesmoke linkto(self);
	self thread enginesmoke();
	if(self getspeedmph() < 1)
	{
		self notify ("unload");

	}
}

crashroll()
{
	self waittill ("crashpath");
	if(self getspeedmph()>20)
	{
		self notify ("crasher");

		model = spawn("script_model",self.origin);
		model.angles = self.angles;
		model setmodel (self.model);
		model linkto(self);
		self hide();
		for(i=0;i<self.attachedguys.size;i++)
		{
			if(isdefined(self.attachedguys[i]))
			{
				if(isdefined(self.attachedguys[i].deathanimloop) || isalive(self.attachedguys))
				{
					self.attachedguys[i] unlink ();
					self.attachedguys[i] linkto (model,"tag_body");
				}
				if(isalive(self.attachedguys[i]))
					thread guy_fastdeathroll(self.attachedguys[i]);
			}
		}

		model UseAnimTree(#animtree);
		model playsound("car_roll");
		model setflaggedanim("rollover",%wagon_crash1);
		model waittillmatch ("rollover","stop in one second");
		if(isdefined(self.enginesmoke))
		{
			self.enginesmoke unlink();
			self.enginesmoke linkto(model);
		}
		self setspeed (10,self getspeedmph() - 10);
		self setwaitspeed(5);
		self waittill ("reached_wait_speed");
		self setspeed (0,5);
	}
}

enginesmoke()
{
	self.enginesmokesmoke = loadfx("fx/smoke/blacksmokelinger.efx");
	accdist = 0.001;
	fullspeed = 1000.00;


	timer = gettime()+10000;
	while(self.speed > 100 && timer > gettime())
	{
		oldorg = self.enginesmoke.origin;
		waitframe();
		dist = distance(oldorg,self.enginesmoke.origin);
		accdist += dist;
		enginedist = 48;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (self.enginesmokesmoke, self.enginesmoke.origin);
				accdist -= enginedist;
			}
		}
	}
	while(timer > gettime())
	{
		playfx (self.enginesmokesmoke, self.enginesmoke.origin);
		wait randomfloat(.3)+.1;
	}
}

checkevents(str,add,guy)
{

	return;
	if(add)
	{
		guy.buddyevent[guy.buddyevent.size] = str;

	}
	else
	{
		guy.buddyevent = [];
	}

	if(guy.buddyevent.size > 1)
	{
		for(i=0;i<guy.buddyevent.size;i++)
		{
			println("buddyevent : ",guy.buddyevent[i]);
		}
	}
}

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
