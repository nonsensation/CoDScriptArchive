#using_animtree ("generic_human");
main()
{
	// put precache stuff here.
	precachemodel("xmodel/vehicle_german_bmw_bike_d");
	precacheItem("luger");
	
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_treadfx_gmi::main();
	loadfx("fx/explosions/vehicles/bmwbike_complete.efx");
}


init()
{
	life();
	thread maps\_treads_gmi::main();
	thread kill();
}

handle_attached_guys(guys)
{
//	positions[0]["getout"] = %germantruck_guy1_jumpout;
//	positions[1]["getout"] = %germantruck_guy1_jumpout;
//	positions[2]["getout"] = %germantruck_guy2_jumpout;

	positions[0]["idle"] = %bmw_driver_idle;
	positions[1]["idle"] = %bmw_passenger_idle;
	positions[2]["idle"] = %bmw_guy01_idle;

	positions[0]["fire"] = %c_gr_sicily2_driver_firing_straight;
	positions[1]["fire"] = %bmw_passenger_fire;
	positions[2]["fire"] = %bmw_guy01_fire;

	positions[0]["standattack"] = %c_gr_sicily2_driver_firing_straight;
	positions[1]["standattack"] = %bmw_passenger_fire;
	positions[2]["standattack"] = %bmw_guy01_fire;

	positions[0]["standattackforward"] = %c_gr_sicily2_driver_firing_straight;
	positions[1]["standattackforward"] = %bmw_passenger_fire;
	positions[2]["standattackforward"] = %bmw_guy01_fire;

	positions[0]["standattackleft"] = %c_gr_sicily2_driver_firing_left;
	positions[1]["standattackleft"] = %bmw_passenger_fire_left;
	positions[2]["standattackleft"] = %bmw_guy01_fire;

	positions[0]["standattackright"] = %c_gr_sicily2_driver_firing_right;
	positions[1]["standattackright"] = %bmw_passenger_fire_right;
	positions[2]["standattackright"] = %bmw_guy01_fire;

	positions[0]["firecount"] = 2;
	positions[1]["firecount"] = 30;
	positions[2]["firecount"] = 3;

	positions[0]["sittag"] = "tag_driver";
	positions[1]["sittag"] = "tag_passenger";
	positions[2]["sittag"] = "tag_guy01";


	positions[0]["death"] = %bmw_driver_death;
	positions[1]["death"] = %wagon_passenger_death;
	positions[2]["death"] = %wagon_passenger_death;

	positions[0]["deathloop"] = %bmw_driver_death;
//	positions[1]["deathloop"] = %wagon_passenger_death;
//	positions[2]["deathloop"] = %wagon_passenger_death;


	self thread wait_jump_out();

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
			guy.fire = positions[pos]["fire"];
			guy.firecount = positions[pos]["firecount"];
			guy.idle = positions[pos]["idle"];			//multiple idle anims
			guy.sittag = positions[pos]["sittag"];
			guy.getout = positions[pos]["getout"];
			guy.exitdelay = positions[pos]["exitdelay"];
			guy.standattack = positions[pos]["standattack"];
			guy.standattackforward = positions[pos]["standattackforward"];
			guy.standattackleft = positions[pos]["standattackleft"];
			guy.standattackright = positions[pos]["standattackright"];
			guy.pos = pos;

			guy.deathanim = positions[pos]["death"];
			guy.deathanimloop = positions[pos]["deathloop"];

			guy.allowdeath = 1;


			guy thread fireing();
			guy thread fireingdirection(self);
			if(pos == 0)
			{
//				guy.hasweapon = false;
				guy.weapon = "luger";
				guy animscripts\shared::PutGunInHand("left");
			}

			org = self gettagorigin(guy.sittag);
			angles = self gettagAngles(guy.sittag);
			guy linkto (self, guy.sittag, (0, 0, 0), (0, 0, 0));

			if(pos != 0)
			{
				if(pos == 2)
				{

					guy.weapon = "luger";
					guy animscripts\shared::putguninhand("right");
				}
				thread guy_deathroll(guy);

				guy teleport(org,angles);
				thread guy_handle(guy);
				thread guy_idle(guy);
			}
			if(pos == 0)
			{
				self.driver = guy;
				thread guy_handle(guy);
				thread guy_idle(guy);
				thread driverdeath(guy);
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


guy_handle (guy)
{
	guy.idling = 1;
	guy endon ("death");
	while (self.health > 0)
	{
		self waittill ("groupedanimevent",other);

		println("^1GROUPEDANIMEVENT SHOULD ******NOT****** HAVE BEEN TRIGGERED!!!!  = ",other);

		if(guy.idling)
		{
			guy.idling = 0;
			if(other == "idle")
			{
				self thread guy_idle(guy);
			}
			else if(other == "fire")
			{
				if(!isdefined(guy.standattack))
					thread guy_idle(guy);
				else
					thread guy_fire(guy);
			}
			else if(other == "unload")
			{
				if(!isdefined(guy.getout))
					thread guy_idle(guy);
				else
					thread guy_unload(guy);
			}
			else if(other == "stand")  // ghetto hack. stand means attack.
			{
				if(!isdefined(guy.standattack))
					thread guy_idle(guy);
				else
					thread guy_fire(guy);
			}

		}
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

guy_idle(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		animontag(guy,guy.sittag, guy.idle);
	}
}
guy_fire(guy)
{
	guy endon ("fakedeath");
	mintime = 0;
	timer = gettime() + 5000;
		if (timer < mintime)
			timer = mintime;
	while (gettime() < timer)
	{
			animflaggedontag("firing",guy,guy.sittag,guy.standattack);

	}
	guy_idle(guy);
}

guy_unload(guy)
{
	thread guy_idle(guy);
	return;
	guy endon ("fakedeath");
	guy endon ("death");
	wait (guy.exitdelay);
	animontag(guy,guy.sittag, guy.getout);
	guy unlink();
}

animontag(guy, tag , animation)
{
	guy endon ("fakedeath");
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	guy waittillmatch ("animontagdone","end");
}



wait_jump_out()
{
	self waittill ("unload");
	self notify ("groupedanimevent","unload");
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
			println("spawned bmwbike guy " + who + " failed to spawn at ",spawned.origin);
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
				println("spawned bmwbike guy " + who + " failed to spawn at ",spawned.origin);
				spawned = undefined;
			}
		}
	}
	if(!isdefined(guys[0]))
		guys = undefined;
	self thread maps\_bmwbike_gmi::handle_attached_guys(guys);
}



driverdeath(guy)
{
	guy waittill ("death");
	self.deaddriver = 1; // tells _vehiclechase.gsc to crash
}

guy_deathroll(guy)
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
	println("^1fastdeathroll ", self.targetname);

	guy.allowdeath = 0;
	org = self gettagOrigin (guy.sittag);
	angles = self gettagAngles (guy.sittag);
	guy.deathanim = %wagon_backleft_death_hit;
	guy notify ("fakedeath");
	guy animscripted("fastdeathdone", org, angles, guy.deathanim);
	guy.deathanim = %wagon_backleft_death_roll;
	guy waittillmatch ("fastdeathdone","end");
	guy unlink();
	guy.allowdeath = 1;
	guy dodamage(guy.health + 50,(0,0,0));
}

guy_slowdeathroll(guy)
{
	guy.allowdeath = 0;
	org = self gettagOrigin (guy.sittag);
	angles = self gettagAngles (guy.sittag);
	guy.deathanim = %wagon_backleft_slowdeath_hit;
	guy notify ("fakedeath");
	guy animscripted("slowdeathdone", org, angles, guy.deathanim);
	guy.deathanim = %wagon_backleft_slowdeath_roll;
	guy waittillmatch ("slowdeathdone","end");
	guy unlink();
	guy.allowdeath = 1;
	guy dodamage(guy.health + 50,(0,0,0));
}



///////////////////////////////
///////////////////////////////
#using_animtree ("bmwbike");
///////////////////////////////
///////////////////////////////
crashroll()
{
	self waittill ("crashpath");

	println("^1crashpath met ", self.targetname);

	if(self getspeedmph()>10)
	{
		self notify ("crasher");
		model = spawn("script_model",self.origin);
		model setmodel (self.model);
		model.angles = self.angles;
		model linkto(self);
		for(i=0;i<self.attachedguys.size;i++)
		{
			if(isdefined(self.attachedguys[i]))
			{
				if(isdefined(self.attachedguys[i].deathanimloop) || isalive(self.attachedguys[i]))
				{
					self.attachedguys[i] linkto (model,self.attachedguys[i].sittag, (0,0,0),(0,0,0));
				}
				if(isalive(self.attachedguys[i]))
					thread guy_fastdeathroll(self.attachedguys[i]);
			}
		}
		self hide();
		model UseAnimTree(#animtree);
		model playsound("car_roll");
		model setflaggedanimrestart("rollover",%bmw_crash);
		if(isdefined(self.enginesmoke))
		{
			self.enginesmoke unlink();
			self.enginesmoke linkto(model);
		}
		model waittillmatch ("rollover","one second");
		self setspeed (0,self getspeedmph());
		
	}

		self waittill ("reached_end_node");
		self playsound ("vehicle_impact");

}
life()
{
	self.health = 600;
	self thread kill();
}

kill()
{
	self thread crashroll();
	fx = loadfx("fx/explosions/vehicles/bmwbike_complete.efx");
	self.deathmodel = "xmodel/vehicle_german_bmw_bike_d";
	self UseAnimTree(#animtree);
	self waittill("death");
	radiusDamage (self.origin+(0,0,128), 128, 800, 400);
	self setmodel(self.deathmodel);
	self playsound ("explo_metal_rand");
	playfx(fx, self.origin );
	earthquake(0.25, 3, self.origin, 1050);
	level thread maps\_utility_gmi::blend_upanddown_sound(self,6,"truckfire_low","truckfire_high");

	if(self getspeedmph() > 8)
	{
		self setwaitspeed(7);
		self waittill("reached_wait_speed");
	}
	self notify ("unload");
}

checkevents(str,add,guy)
{
	if(add)
	{
		level.guyevent[guy.pos][level.guyevent[guy.pos].size] = str;

	}
	else
	{
		level.guyevent[guy.pos] = [];
	}
	if(level.guyevent[guy.pos].size > 1)
	{
		println("****coliding buddyevents ****");
		for(i=0;i<level.guyevent.size;i++)
		{
			println("buddyevent : ",level.guyevent[guy.pos][i]);
		}
	}


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
fireing()
{
	while(1)
	{
		self waittillmatch("firing","fire");
		self shoot();

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
	maps\_spawner_gmi::waitframe();
}

animflaggedontag(flag,guy, tag , animation, notetracks, sthreads)
{
	guy endon ("customdeath");
	guy endon ("death");
	guy endon ("fakedeath");
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
