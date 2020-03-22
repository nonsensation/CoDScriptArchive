main()
{
	if (getcvar("debug_drawcone") == "")
		setcvar("debug_drawcone", "off");
	if (getcvar("debug_tankqueue") == "")
		setcvar("debug_tankqueue", "off");
	if (getcvar("debug_stundraw") == "")
		setcvar("debug_stundraw", "off");
	if (getcvar("debug_tanksamples") == "")
		setcvar("debug_tanksamples", "off");
	if (getcvar("debug_tankall") == "")
		setcvar("debug_tankall", "off");
	if (getcvar("debug_tanknone") == "")
		setcvar("debug_tanknone", "off");


	if(getcvar("debug_tankall") != "off")
	{
		setcvar("debug_stundraw", "on");
		setcvar("debug_tankqueue", "on");
		setcvar("debug_tanksamples", "on");
		setcvar("debug_tankall", "off");
	}
	if(getcvar("debug_tanknone") != "off")
	{
		setcvar("debug_stundraw", "off");
		setcvar("debug_tankqueue", "off");
		setcvar("debug_tanksamples", "off");

		setcvar("debug_tanknone", "off");
	}
	level.tanks = [];
}

treads()
{
	trightorg = self gettagorigin("tag_wheel_back_right");
//	trightang = self gettagorigin("tag_wheel_back_right");
	trightang = self.angles;

	tleftorg = self gettagorigin("tag_wheel_back_left");
//	tleftang = self gettagorigin("tag_wheel_back_left");
	tleftang = self.angles;

	right = spawn ("script_origin", trightorg);
	left = spawn ("script_origin", tleftorg);


	angoffset = (32,0,0);
//	right.origin = trightorg;
	right.angles = trightang + angoffset;
//	left.origin = tleftorg;
	left.angles = tleftang + angoffset;

//	right linkto (self,"tag_wheel_back_right");
//	left linkto (self,"tag_wheel_back_right");
	right linkto (self);
	left linkto (self);
	self thread tread(left);
	self thread tread(right);

}
tread(tread)
{
	accdist = 0.001;
	fullspeed = 1500.00;
	while(1)
	{
		oldorg = tread.origin;
		//waitframe();
		wait .15;
		dist = distance(oldorg,tread.origin);
		accdist += dist;
		treaddist = 24;
		if(self.speed > 1)
		{
			if(accdist > treaddist)
			{
				vectang = anglestoforward(tread.angles);
				speedtimes = self.speed/fullspeed;
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);

				playfx (level._effect["treads"], tread.origin,(0,0,0)-vectang);
				accdist -= treaddist;
			}
		}
	}
}
waitlongframe()
{
	wait .15;
}
waitframe()
{
	maps\_spawner_gmi::waitframe();
}


kursk_convoy_avoid()
{
//	if(getcvar("debug_tanksamples") != "off")
//		self thread drawchecker(self);

	self endon ("reached_end_node");
	self endon ("deadstop");
	while(1)
	{

		check = tank_check(level.convoyvehicle);
		if(check != 0)
		{
			if(check == 1)
			{

				self setspeed (0,25);
				while(check == 1)
				{
					self setspeed (0,25); //why twice I wonder.. should try it once and see what happens
					check = tank_check(level.convoyvehicle);

				}

//				println(self.targetname," resuming speed in kursk_convoy_avoid -- check == 1");
				self resumespeed(30);
			}
			else if(check == 2)
			{
				self setspeed(0,10000);
				while(check == 2)
				{
					self setspeed(0,10000); //why twice I wonder.. should try it once and see what happens
					check = tank_check(level.convoyvehicle);
				}
//				println(self.targetname," resuming speed in kursk_convoy_avoid -- check == 2");
				self resumespeed(30);
			}

		}
	}
}


avoidtank()
{
//	if(getcvar("debug_tanksamples") != "off")
//		self thread drawchecker(self);

	self endon ("reached_end_node");
	self endon ("deadstop");
	while(1)
	{

		check = tank_check(level.tanks);
		if(check != 0)
		{
			if(check == 1)
			{

				self setspeed (0,25);
				while(check == 1)
				{
					self setspeed (0,25); //why twice I wonder.. should try it once and see what happens
					check = tank_check(level.tanks);

				}

				self resumespeed(5);
			}
			else if(check == 2)
			{
				self setspeed(0,10000);
				while(check == 2)
				{
					self setspeed(0,10000); //why twice I wonder.. should try it once and see what happens
					check = tank_check(level.tanks);
				}
				self resumespeed(5);
			}

		}
	}
}

drawchecker(tank)
{
	tank endon ("death");
	tank.truecheck = 0;

	while(1)
	{
		print3d (self.origin, tank.truecheck, (0, 1, 0), 1);
		wait .05;

	}
}

drawcirclechecks(tank)
{
	tank endon ("death");
	tank.circlecheck = 0;

	while(1)
	{
		print3d (self.origin,tank.circlecheck, (1, 0, 1), 1);
		wait .05;

	}
}
conechecksamples()
{
	if(!isdefined(self.conevectordotnumber))
		self.conevectordotnumber = -0.927;
	if(!isdefined(self.coneradius))
		self.coneradius = 400;
	if(!isdefined(self.cosinedangle))
		self.cosinedangle = 22;


	level.tanks[level.tanks.size] = self;
	angle1 = anglestoright(self.angles);
	vector1 = maps\_utility_gmi::vectorMultiply(angle1,64);

	point1 = spawn("script_origin", (1,1,1));
	point2 = spawn("script_origin", (1,1,1));
	point3 = spawn("script_origin", (1,1,1));
	point4 = spawn("script_origin", (1,1,1));
	point5 = spawn("script_origin", (1,1,1));

	stoporg1 = spawn("script_origin", (1,1,1));
	stoporg2 = spawn("script_origin", (1,1,1));


	point1.origin =  self.origin+vector1;
	point2.origin =  self.origin-vector1;

	angles = anglestoforward(self.angles);
	vector1 = maps\_utility_gmi::vectorMultiply(angles,96);

	vector2 = maps\_utility_gmi::vectorMultiply(angles,84);
	vector3 = maps\_utility_gmi::vectorMultiply(angles,84);

	stoporg1.origin = self.origin+vector2;
	stoporg2.origin = self.origin-vector3;

	point1.origin = point1.origin+vector1;
	point2.origin = point2.origin+vector1;
	p3add = maps\_utility_gmi::vectorMultiply(vector1,2);
//	p3add = maps\_utility_gmi::vectorMultiply(vector1,2);
	point3.origin = point1.origin-(p3add);
	point4.origin = point2.origin-(p3add);

	point5.origin = self.origin+vector1;



	self.samplepoints[0] = point1;
	self.samplepoints[1] = point2;
	self.samplepoints[2] = point3;
	self.samplepoints[3] = point4;
	self.samplepoints[4] = point5;

	self.colidecircle[0] = stoporg1;
	self.colidecircle[1] = stoporg2;


	self.checkorg = point5;
//	self.checkorg linkto (self);

	for(i=0;i<self.colidecircle.size;i++)
	{
		self.colidecircle[i] linkto(self);
//		if(getcvar("debug_tanksamples") != "off")
//			self.colidecircle[i] thread drawcirclechecks(self);

	}

	for(i=0;i<self.samplepoints.size;i++)
	{
		self.samplepoints[i] linkto (self);
//		if(getcvar("debug_tanksamples") != "off")
//			self.samplepoints[i] thread drawchecker(self);
	}

//	if(getcvar("debug_drawcone") != "off")
//		self thread drawcone();


}
stopcheck(guy1,guy2,radius)
{
	org1 = flat_origin(guy1.checkorg.origin);  //old way was guy1.oriign
	org2 = flat_origin(guy2.origin);
	dist = distance(org1,org2);
	if(dist < radius)
	{
		if(guy1 != guy2)
		{
			//circle check
			if(isdefined(level.playertank))
			{
				for(j=0;j<level.playertank.colidecircle.size;j++)
				{
					if(distance(flat_origin(guy1.colidecircle[0].origin),flat_origin(level.playertank.colidecircle[j].origin)) < 240)
					{
//						if (getcvar("debug_tanksamples") != "off")
//							line (guy1.colidecircle[0].origin,level.playertank.colidecircle[j].origin, (1,0,1), 1);

						self.circlecheck = 1;
						return 2;
					}
				}
			}
			//  cone check
			forwardvec = anglestoforward(flat_angle(guy1.angles));
			for(i=0;i<guy2.samplepoints.size;i++)
			{
				org2 = flat_origin(guy2.samplepoints[i].origin);
				normalvec = vectorNormalize(org1-org2);
				vectordot = vectordot(forwardvec,normalvec);
				if(vectordot < self.conevectordotnumber)
				{
//					if (getcvar("debug_tanksamples") != "off")
//						line (guy1.origin,guy2.samplepoints[i].origin, (0,1,0), 1);
					self.truecheck = 1;
					return 1;
				}
			}
		}
	}
	else
	{
		self.circlecheck = 0;
		self.truecheck = 0;
		return 0;
	}
	self.truecheck = 0;
	self.circlecheck = 0;
	return 0;
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

tank_check(vehicles)
{
	for(i=0;i<vehicles.size;i++)
	{
		if(isdefined(vehicles[i]))
		{
			check = stopcheck(self,vehicles[i],self.coneradius);
			if(check != 0)
			{
				wait .1;
				//maps\_spawner_gmi::waitframe();
				return check;
			}
		}

	}
	wait .2;
	//maps\_spawner_gmi::waitframe();
	return 0;
}

queuecheck()
{
	if(isdefined(self.enemyqueue))
	{
		// This puts the player at the back of the queue. Why?  I don't know.
		if(isdefined(level.playertank) && self.enemyqueue[0] == level.playertank)
		{
			self.enemyqueue = queuetoback(self.enemyqueue);
		}
		return true;
	}
	return false;
}

queuecheck_Kursk()
{
	if(isdefined(self.enemyqueue))
	{
		// This puts the player at the back of the queue. Why?  I don't know. -- not doing it for Kursk
/*		if(isdefined(level.playertank) && self.enemyqueue[0] == level.playertank)
		{
			self.enemyqueue = queuetoback(self.enemyqueue);
		}
*/		return true;
	}
	return false;
}



allowedShoot(target)
{

	if (isdefined(self.stunned) && self.stunned == 1)
	{
		self waittill ("stundone");
	}

	// If our target isn't passed in, grab the first element of the enemyqueue
	if(!isdefined(target))
	{
		if(!queuecheck())
		{
			return false;
		}

		target = self.enemyqueue[0];

		if(!isdefined(target))
		{
			return false;
		}
		if(target.health <= 0)
		{
			return false;
		}
	}

	// if target is outside the attack range of this vehicle
	if (isdefined(self.attack_range))
	{
		if (distance (target.origin, self.origin) > self.attack_range)
		{
			return false;
		}
	}
	return true;
}

allowedShoot_Kursk(target)
{

	if (isdefined(self.stunned) && self.stunned == 1)
	{
		self waittill ("stundone");
	}

	// If our target isn't passed in, grab the first element of the enemyqueue
	if(!isdefined(target))
	{
		if(!queuecheck_Kursk())
		{
			return false;
		}

		target = self.enemyqueue[0];

		if(!isdefined(target))
		{
			return false;
		}
		if(target.health <= 0)
		{
			return false;
		}
	}

	// if target is outside the attack range of this vehicle
	if (isdefined(self.attack_range))
	{
		if (distance (target.origin, self.origin) > self.attack_range)
		{
			return false;
		}
	}
	return true;
}


turret_attack_think(optionalTurret)
{
	thread maps\_tankgun_gmi::mginit(optionalTurret);
	self endon ("death");
	if(isdefined(self.script_team) && self.script_team == "axis")
		self.enemyqueue[0] = level.playertank;
	if(isdefined(self.triggeredthink))
	{
		self waittill ("triggeredthink");
	}
	shotcount = 0;
	while (1)
	{

		while(1)
		{
			if(!queuecheck())
				break;
			if (!allowedShoot())
				break;
			//self.script_accuracy = 1000;
			if(isdefined(self.script_accuracy))
			{
				dist = distance(self.origin,self.enemyqueue[0].origin);
				distacc = self.script_accuracy*(dist/5000);
				randx = randomint(distacc*.85)+(distacc*.15);
				randy = randomint(distacc*.85)+(distacc*.15);
				randz = randomint(distacc*.85)+(distacc*.15);
				accuracy = (randx,randy,randz);
			}
			else
				accuracy = (0,0,0);
			self setTurretTargetEnt(self.enemyqueue[0], ((0, 0, 64) + (accuracy)) );
			self.turretonvistarg = 0;
			self thread turret_on_vistarget();
			while(allowedShoot() && self.turretonvistarg == 0)
				wait .2;
//				waitframe();
			self notify ("novistarget");
			self.turretonvistarg = 0;
			if (!allowedShoot())
				break;
			self clearTurretTarget();
			if(isdefined(level.turretfiretime))
			{
				timer = gettime() + (level.turretfiretime*1000);
				while(gettime() < timer && allowedshoot())
					wait .2;
//					waitframe();

			}
			if (!allowedShoot())
				break;
			self notify( "turret_fire" );

			timer = gettime()+1000;
			while(gettime() < timer && allowedShoot())
				waitframe();

			if (!allowedShoot())
				break;
			self setTurretTargetEnt(self.enemyqueue[0], (0, 0, 64) );
			delay = randomint( 2000 ) + 1500;
			timer = gettime()+delay;
			while(gettime() < timer && allowedShoot())
				wait .3;
//				waitframe();
			shotcount++;
			if(shotcount > 1)
			{
				shotcount = 0;
				break;
			}
		}
		shotcount = 0;
		if(isdefined(self.enemyqueue))
		{
//			thread queueupdate(self.enemyqueue);
			if (!allowedShoot())
				queueremove(self.enemyqueue[0]);
			else
			{
				if(!isdefined(self.killcommit))
				{
					self notify ("turretidle");
//					thread queueupdate(self.enemyqueue);
//					waitframe();
					self waittill ("attackernow");

				}

			}
		}
		else
		{
			self notify ("turretidle");

		}
//		thread queupdate(self.enemyqueue);
		wait .3;
//		waitframe();
	}

}

turret_attack_think_Kursk(optionalTurret)
{
	thread maps\_tankgun_gmi::mginit(optionalTurret);
	self endon ("death");
	self endon("stopthink");
//	if(isdefined(self.script_team) && self.script_team == "axis")
//		self.enemyqueue[0] = level.playertank;
	if(isdefined(self.triggeredthink) && (self.triggeredthink == true))
	{
		self waittill ("triggeredthink");
	}
	shotcount = 0;

	target_select_max_duration = 5000; // max time allotted to a single target -- prevents tank from sitting forever not firing at a target that it might not have line-of-sight to
	target_select_start = gettime();
	while (1)
	{
		while(1)
		{
			if(!queuecheck_Kursk())
			{
//				println("queuecheck returned false");
				break;
			}
			if (!allowedShoot_Kursk())
			{
//				println(self.targetname," breaking out of shoot loop at 1");
				break;
			}
			//self.script_accuracy = 1000;
			if(isdefined(self.script_accuracy))
			{
//				println(self.targetname," using script_accuracy of ", self.script_accuracy);
				dist = distance(self.origin,self.enemyqueue[0].origin);
				distacc = self.script_accuracy*(dist/5000);
				random = distacc*.85;
				fixed = distacc*.15;
				if(random < 1)
				{
					random = 1;
				}
				randx = randomint(random)+(fixed);
				randy = randomint(random)+(fixed);
				randz = randomint(random)+(fixed);
				randz += 64;			
				accuracy = (randx,randy,randz);
			}
			else
			{
				accuracy = (0,0,64);
			}
			if(isdefined(level.playertank) && (self.enemyqueue[0] == level.playertank) && isdefined(level.playertank_z_adjust))
			{
				// drastically cut inaccuracy when firing at the player
				accuracy = maps\_utility_gmi::vectorScale(accuracy,0.5);
				accuracy = accuracy + (0,0,level.playertank_z_adjust);
			}

//			println(self.targetname," first setTurretTargetEnt on ",self.enemyqueue[0].targetname);
			self setTurretTargetEnt(self.enemyqueue[0], accuracy);
			self.turretonvistarg = 0;
			self thread turret_on_vistarget();
			while(allowedShoot_Kursk() && self.turretonvistarg == 0 && (gettime() < (target_select_start + target_select_max_duration)))
			{
/*
				if(level.clearingphase > 1)
				{
					println("gettime: ",gettime()," -- target_select_start + target_select_max_duration : ",target_select_start + target_select_max_duration);
				}
*/
//				println(self.targetname," in while loop 1");
				wait .2;
//				waitframe();
			}
			self notify ("novistarget");
			self.turretonvistarg = 0;
			if (!allowedShoot_Kursk())
			{
	//			println(self.targetname," breaking out of shoot loop at 2");
				break;
			}
//			self clearTurretTarget();
			if(isdefined(level.turretfiretime))
			{
				timer = gettime() + (level.turretfiretime*1000);
				while(gettime() < timer && allowedshoot_Kursk())
				{
//					println(self.targetname," in while loop 2");
					wait .2;
//					waitframe();
				}

			}
			if (!allowedShoot_Kursk())
			{
//				println(self.targetname," breaking out of shoot loop at 3");
				break;
			}
//			println(self.targetname," firing");
			self notify( "turret_fire" );

			timer = gettime()+1000;
			while(gettime() < timer && allowedShoot_Kursk())
			{
//				println(self.targetname," in while loop 3");
				waitframe();
			}

			if (!allowedShoot_Kursk())
			{
//				println(self.targetname," breaking out of shoot loop at 4");
				break;
			}
			// note this second targetting doesn't have the inaccuracy
//			println(self.targetname," second setTurretTargetEnt");
//			self setTurretTargetEnt(self.enemyqueue[0], (0, 0, 0) );
			self setTurretTargetEnt(self.enemyqueue[0], (0, 0, 64) );
			delay = randomint( 2000 ) + 1500;
			timer = gettime()+delay;
			while(gettime() < timer && allowedShoot_Kursk())
			{
//				println(self.targetname," in while loop 4");
				wait .3;
//				waitframe();
			}
			shotcount++;
			if(shotcount > 1)
			{
				shotcount = 0;
//				println(self.targetname," breaking out, shotcount > 1");
				break;
			}
		}
		shotcount = 0;
		if(isdefined(self.enemyqueue))
		{
//			thread queueupdate(self.enemyqueue);
			if (!allowedShoot_Kursk())
			{
//				println("Removed element 0 from self.enemyqueue for ",self.targetname);
				queueremove(self.enemyqueue[0]);
			}
			else if(gettime() > (target_select_start + target_select_max_duration))
			{
				// move to the back of the queue
				queuetoback(self.enemyqueue);
			}
			else
			{
				if(!isdefined(self.killcommit))
				{
//					println(self.targetname," going idle because killcommit not defined");
					self notify ("turretidle");
//					thread queueupdate(self.enemyqueue);
//					waitframe();
					self waittill ("attackernow");

				}

			}
		}
		else
		{
//			println(self.targetname," going idle because enemyqueue not defined");
			self notify ("turretidle");
		}
//		thread queupdate(self.enemyqueue);
		wait .3;
//		println(self.targetname," in outer while loop");
	}

}


stun(stuntime)
{
	while(self.health > 0)
	{
		self.stunned = 0;

		self waittill ("damage");
		self.stunned = 1;
//		thread stundraw();
		timer = gettime()+(stuntime*1000);
		while(gettime()<timer)
		{

			wait .1;
//			thread queupdate(self.enemyque);
		}

	//	wait stuntime;
		self notify ("stundone");
	}
}


kill()
{
	self waittill( "death", attacker );
	if(isdefined(attacker) && (attacker == level.playertank)) 
	{
		println("^6CALLING NICE SHOT");
		thread maps\kursk_sound::play_nice_shot();
	}

	if(isdefined(self.nospawning))
	{
		self.tankgetout = 0;
	}

	if(isdefined(self.mgturret))
	{
		self.mgturret delete();
	}

	level.tanks = maps\_utility_gmi::array_remove(level.tanks,self);
	if(!isdefined(level.tanks))
	{
		level.tanks = [];
	}
	self playsound( self.deathsound );
	self notify ("tankkilled");  //plays animation under the proper anim tree as set in whatever script called this thread.

	self clearTurretTarget();
	playfxonTag ( self.deathfx, self, "tag_body" );
//	playfx( self.deathfx, self.origin );
	lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	earthquake( 0.25, 3, self.origin, 1050 );

	//roll out of the way of incoming tanks

	level thread maps\_utility_gmi::blend_upanddown_sound(self,35,"truckfire_low","truckfire_high");

	if(!isdefined(self.rollingdeath))
	{
		self setspeed(0,25);
	}
	else
	{
		if(self.speed < 8)
		{
			self setspeed(8,25);
		}

		self waittill ("deathrolloff");
		self setspeed(0,25);
	}

	wait 0.1;

	self setmodel( self.deathmodel );
	wait 0.3;
	self setspeed(0,10000);
	self notify ("deadstop");
	self disconnectpaths();

	playfxOnTag ( lingerfx, self, "tag_body" );
//	playfx( lingerfx, self.origin );

	if(isdefined(self.tankgetout))
	{
		self waittill ("animsdone");
	}

	self freevehicle();
	self.dead = true;
}

kill_convoy()
{
	self waittill( "convoy_death" );

	if(isdefined(self.nospawning))
	{
		self.tankgetout = 0;
	}

	self playsound( self.deathsound );
	self notify ("tankkilled");  //plays animation under the proper anim tree as set in whatever script called this thread.

	self clearTurretTarget();
	playfxonTag ( self.deathfx, self, "tag_body" );

	lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	earthquake( 0.25, 3, self.origin, 1050 );

	//roll out of the way of incoming tanks

	if(!isdefined(self.rollingdeath))
	{
		self setspeed(0,25);
	}
	else
	{
		if(self.speed < 8)
		{
			self setspeed(8,25);
		}

		self waittill ("deathrolloff");
		self setspeed(0,25);
	}

	wait 0.1;

	self setmodel( self.deathmodel );
	wait 0.3;
	self setspeed(0,10000);
	self notify ("deadstop");

	playfxOnTag ( lingerfx, self, "tag_body" );

	if(isdefined(self.tankgetout))
	{
		self waittill ("animsdone");
	}
}

drawthing(id,num,lineto,offset,color)
{

	self.drawingthing = 1;
	if(!isdefined(offset))
		offset = (0,0,0);
	if(!isdefined(color))
		color = (1, 1, 1);

	print3d (self.origin + (offset), id+num, color, 1);
	if(isdefined(lineto))
		line ((self.origin + offset + (0,0,-8)),lineto.origin, color, 1);
}

//removes target from self.enemyqueue
queueremove(target)
{
	if(!isdefined(self.enemyqueue))
	{
//		println("self.enemyqueue not defined in queueremove before array remove");
		return;
	}

	self.enemyqueue = maps\_utility_gmi::array_remove(self.enemyqueue,target);
//	thread queueupdate(self.enemyqueue);

}

//adds target to enemyqueue if it's not already in there
queue_add(target)
{
	if(!isdefined(target))
		println("tried to add undefined to queue");
	if(target.health > 0)
	{
		self.enemyqueue = add_to_array_if_not_in_array( self.enemyqueue, target );

//		thread queueupdate(self.enemyqueue);
	}
//	else
//	{
//		thread queueupdate(self.enemyqueue);
//	}
}

//adds target to front of enemyqueue
queue_add_to_front(target)
{
	if(!isdefined(target))
		println("tried to add undefined to queue");
	if(target.health > 0)
	{
		self.enemyqueue = add_to_front_array( self.enemyqueue, target );

//		thread queueupdate(self.enemyqueue);
	}
	else
	{
//		thread queueupdate(self.enemyqueue);
	}
}

//adds ent to front of array
add_to_front_array(array,ent)
{
	newarray[0] = ent;
	if(isdefined(array))
	{
//		if(getcvar("debug_tankqueue") != "off")
//			println("queue_add_to_front array size is ", array.size);
		for(i=0;i<array.size;i++)
		{
			if(ent != array[i])
				newarray[newarray.size] = array[i];
		}

	}
//	if(getcvar("debug_tankqueue") != "off")
//		println("queue_add_to_front newarray size is ", newarray.size);
	return newarray;
}

// move the first element of 'array' to the last element
queuetoback(array)
{
	newarray = [];
	count = 0;
	if(array.size > 1)
	{
		for(i=1;i<array.size;i++)
		{
			newarray[count] = array[i];
			count++;
		}
		newarray[count] = array[0];
//		if(getcvar("debug_tankqueue") != "off")
//			iprintlnbold("queuetoback");
		return newarray;
	}
	else
	{
		return array;
	}
}
/*
queueupdate(array)
{
	self endon ("death");
	self notify ("newupdate");
	self endon ("newupdate");

	if(getcvar ("debug_tankqueue") != "off" && isdefined(array))
	while(self.health > 0)
	{
		for(i=0;i<array.size;i++)
		{
			if(self.script_team == "allies")
			{
				if(i == 0)
					color = (1,0,0);
				else
					color = (1,1,0);
			}
			else
			{
				if(i == 0)
				{
					if(array[i] == level.playertank)
						color = (1,1,1);
					else
						color = (0,1,0);
				}
				else
					color = (0,0,1);
			}
			drawthing("enemyqueue",i,array[i],(0,0,96)+(0,0,i*24),color);
		}
		waitframe();
	}

}


stundraw()
{
	if(getcvar("debug_stundraw") != "off")
	while(self.health > 0 && self.stunned == 1)
	{
		print3d (self.origin +(0,0,32), "stuned", (1,0,0), 1);
		waitframe();
	}
}
*/

turret_on_vistarget()
{
	self endon ("novistarget");
	self waittill ("turret_on_vistarget");
	self.turretonvistarg = 1;
}

// adds ent to back of array if ent is not already in array
add_to_array_if_not_in_array(array,ent)
{
	doadd = 1;
	if(isdefined(array))
	{
		for(i=0;i<array.size;i++)
		{
			if(array[i] == ent)
				doadd = 0;
		}
	}

	if(doadd == 1)
	{
		array = maps\_utility_gmi::add_to_array (array, ent);
	}

	return array;
}

drawcone()
{
	while(1)
	{
		a = self.angles;
		angles = (a[0],a[1]+self.cosinedangle,a[2]);
		rightvector = anglesToForward(angles);
		rightvector = maps\_utility_gmi::vectorMultiply(rightvector,self.coneradius);
		line (self.checkorg.origin,self.checkorg.origin+rightvector, (0,1,0), 1);

		a = self.angles;
		angles = (a[0],a[1]-self.cosinedangle,a[2]);
		leftvector = anglesToForward(angles);
		leftvector = maps\_utility_gmi::vectorMultiply(leftvector,self.coneradius);
		line (self.checkorg.origin,self.checkorg.origin+leftvector, (0,1,0), 1);
		waitframe();
	}
}

setteam(team)
{
	if(isdefined(self.script_team))
	{
		if(self.script_team == "friendly")
		{
			println("script_team on tank at " + self.origin+ " is friendly, should be allies");
			self.script_team = "allies";
			return;
		}
		else if(self.script_team == "enemy")
		{
			println("script_team on tank at " + self.origin+ " is enemy, should be axis");
			self.script_team = "axis";
			return;
		}
		else if(self.script_team == "axis" || self.script_team == "allies")
			return;
	}
	if(team == "axis")
	{
		self.script_team = "axis";
		return;
	}
	else if(team == "allies")
	{
		self.script_team = "allies";
		return;
	}
	else if(team == "neutral")
	{
		self.script_team = "neutral";
		return;
	}
}
