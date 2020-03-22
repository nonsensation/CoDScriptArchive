main(buddy)  //self is the bike
{

	self.health = 50000;
	self thread bike_handle();
	thread driver(buddy);
//	thread linetoenemy(buddy);
	self thread maps\_vehiclechase_gmi::start();
	thread trigger_setup_attacktriggers();

	self notify ("groupedanimevent","idle");
	self waittill ("reached_end_node");
	level.player unlink();
	level.player allowStand(true);
	level.player allowCrouch(true);
	level.player allowProne(true);
	 
	

}


linetoenemy(guy)
{
	while(1)
	{
		while(isdefined(guy.enemy))
		{
			line(guy.origin, guy.enemy.origin, (0,1,1));
			wait .05;
		}
		wait .05;
	}
}

trigger_setup_attacktriggers()
{
	triggers  = getentarray("bikeattack","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_attacktriggers(self);
}

trigger_attacktriggers(bike)
{

	if(!isdefined(self.target))
	{
		iprintln("attack trigger without target here, ",self getorigin());
		return;
	}
	
	terminator = getent(self.target,"targetname");
	self waittill ("trigger");
	bike notify ("groupedanimevent","fire");
	terminator waittill ("trigger");
	bike notify ("stopfiring");
	bike.driver.idling = 1;
	bike notify ("groupedanimevent","idle");
}

#using_animtree ("generic_human");
driver(guy)
{
	guy.health = 100000;
	guy.weapon = "webley";
	guy.hasweapon = false;
	guy animscripts\shared::PutGunInHand("none");

	driveloop = %bmw_driver_idle;
	tag = "tag_driver";
	guy.sittag = tag;
	org = self gettagorigin(tag);
	ang = self gettagangles(tag);
	guy teleport(org,ang);
	guy linkto(self,tag);


	self.driver = guy; // access the driver from other randomplacesin the scirpt

	guy.attackanimforward = %c_gr_sicily2_driver_firing_straight;
	guy.attackanimright = %c_gr_sicily2_driver_firing_right;
	guy.attackanimleft = %c_gr_sicily2_driver_firing_left;
	
	guy.attackanim = guy.attackanimforward;
	guy.attackidle = %c_gr_sicily2_driver_aim_straight;

	guy.leftturn = %c_gr_sicily2_driver_turn_left;
	guy.rightturn = %c_gr_sicily2_driver_turn_right;
	guy.hardleft = %c_gr_sicily2_driver_corner_left;
	guy.hardright = %c_gr_sicily2_driver_corner_right;
	guy.baseidle =%c_gr_sicily2_driver_driving;
	
	guy.talkin =%c_gr_sicily2_driver_idle2talk;
	guy.talkout =%c_gr_sicily2_driver_talk2idle;
	guy.talk =%c_gr_sicily2_driver_talk;




  




//	guy.downstairs = %c_gr_sicily2_driver_driving;
	guy.downstairs = %c_gr_sicily2_driver_stairs;
	guy.attacktransition = [];
	
	guy.attacktransition[0]["forward"] = %c_gr_sicily2_driver_pivot_left2straight;
	guy.attacktransition[0]["back"] = undefined;
	guy.attacktransition[1]["forward"] = %c_gr_sicily2_driver_pivot_right;
	guy.attacktransition[1]["back"] = %c_gr_sicily2_driver_pivot_left;
	guy.attacktransition[2] = [];
	guy.attacktransition[2]["forward"] = undefined;
	guy.attacktransition[2]["back"] = %c_gr_sicily2_driver_pivot_right2straight;

	guy.drawweapon = %c_gr_sicily2_driver_raise;
	guy.holsterweapon = %c_gr_sicily2_driver_drop;
	
	guy.hunchin = %c_gr_sicily2_driver_hunch_in;
	guy.hunch = %c_gr_sicily2_driver_hunch;
	guy.hunchout = %c_gr_sicily2_driver_hunch_out;
	guy.crash = %c_gr_sicily2_driver_crash;
	guy.idle = guy.baseidle;
	
	guy.gunidle = undefined;
	
	guy thread fireing();
	guy thread fireingdirection(self); // get the firing direction/animation


	guy.idling = 1;
	guy endon ("stopdriveing");
	guy endon ("death");
	while (self.health > 0)
	{
		self waittill ("groupedanimevent",other);
		if(guy.idling)
		{
			guy.idling = 0;
			if(other == "idle")
				thread guy_idle(guy);
			else if(other == "fire")
				thread guy_weapondraw(guy);
			else if(other == "turnleft")
				thread guy_turnleft(guy);
			else if(other == "turnright")
				thread guy_turnright(guy);
			else if(other == "turnhardleft")
				thread guy_turnhardleft(guy);
			else if(other == "turnhardright")
				thread guy_turnhardright(guy);
			else if(other == "hunch")
				thread guy_hunch(guy);
			else if(other == "crash")
				thread guy_crash(guy);
			else if(other == "downstairs")
				thread guy_downstairs(guy);
			else if(other == "talk")
				thread guy_talk(guy);
			
		}
	}
}

guy_hunch(guy)
{
	animontag(guy,guy.sittag,guy.hunchin);
	guy_hunch_idle(guy);	
}

guy_hunch_idle(guy)
{
	timer = gettime()+4000;  // 4 seconds temp solution. 
	while(timer>gettime())
	{
		animontag(guy,guy.sittag,guy.hunch);	
	}
	guy_hunch_out(guy);
	
}

guy_hunch_out(guy)
{
	animontag(guy,guy.sittag,guy.hunchout);
	guy_idle(guy);
}

guy_crash(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
//	self notify("bikeanimevent","idle");// maybe the bike can drift or something
//	iprintlnbold("guy.angles ", self gettagangles(guy.sittag));
//	iprintlnbold("guy.origin ", self gettagorigin(guy.sittag));
//	359.47, 285.19, 3.99 // angles
//	15787.92, -11889.73, 1075.55 // origin

	guy unlink();
//	org = spawn ("script_origin",(15787.92, -11889.73, 1025.55));
	org = spawn ("script_origin",(15787.92, -11889.73, 1087.55));
	guy linkto(org);
//	org moveto((15733, -12559, 1084),1.5,0,0);
	org moveto((15850,-12634,1000),1.2,0,.2);  //magic numbers to make animation work.  was getting inconsitant results playing animation on the tag of the bike. sometimes the bike would be on top of some geometry so the guy would fly through things. now it's based on world coordinates! yay.
	guy thread stancer();
	guy animscripted("animontagdone", org.origin, (0, 260, 0), guy.crash);
	guy waittillmatch ("animontagdone","end");
	org delete();
//	iprintlnbold("guy.origin after anim ", level.player.origin);
	


//	animontag(guy,guy.sittag, guy.crash);
	
}

stancer()
{
	self allowedstances("crouch");
	wait 5;
	self allowedstances("stand","crouch","prone");
}

loopanim(guy)
{
	}

guy_idle(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		self notify("bikeanimevent","idle");
		animontag(guy,guy.sittag, guy.idle);
	}
}

guy_talk(guy)
{
	guy.idling = 1;
	self notify("bikeanimevent","idle");
	animontag(guy,guy.sittag, guy.talkin);
	timer = gettime()+2500;  
	while(gettime()<timer)
	{
		self notify("bikeanimevent","idle");
		animontag(guy,guy.sittag, guy.talk);
	}
	self notify("bikeanimevent","idle");
	animontag(guy,guy.sittag, guy.talkin);
	thread guy_idle(guy);

}

guy_downstairs(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;

	while(1)
	{
		self notify("bikeanimevent","downstairs");
		animontag(guy,guy.sittag, guy.downstairs);
	}
}


guy_turnleft(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		self notify("bikeanimevent","turnleft");
		animontag(guy,guy.sittag, guy.leftturn);
	}
}
guy_turnright(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		self notify("bikeanimevent","turnright");
		animontag(guy,guy.sittag, guy.rightturn);
	}
}
guy_turnhardleft(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		self notify("bikeanimevent","turnhardleft");
		animontag(guy,guy.sittag, guy.hardleft);
	}
}
guy_turnhardright(guy)
{
	self endon ("groupedanimevent");
	guy.idling = 1;
	while(1)
	{
		self notify("bikeanimevent","turnhardright");
		animontag(guy,guy.sittag, guy.hardright);
	}
}


fireingdirection(vehicle)
{
	vehicle endon ("death");
	lastdirection = "forward";
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
				aimdirection = "forward";
				if(lastdirection != aimdirection)
				{
					self.attackanim = self.attackanimforward;
					self.newposition = 1; // 0 = left 1 = forward 2 = right 3 = no update;
					self notify ("firing","end");  // cancels old animation
				}
				lastdirection = aimdirection;
			}
			else if(vectordotright > 0)
			{
				aimdirection = "right";
				if(lastdirection != aimdirection)
				{
					self.attackanim = self.attackanimright;
					self.newposition = 2; // 0 = left 1 = forward 2 = right 3 = no update;
					self notify ("firing","end");
				}
				lastdirection = aimdirection;

			}
			else if(vectordotright < 0)
			{
				aimdirection = "left";
				if(lastdirection != aimdirection)
				{
					self.attackanim = self.attackanimleft;
					self.newposition = 3; // 0 = left 1 = forward 2 = right 3 = no update;
					self notify ("firing","end");
				}
				lastdirection = aimdirection;

			}
		}
		wait .5;
	}
}

guy_weapondraw(guy)
{
	self endon ("stopfiring");
	animontag(guy,guy.sittag,guy.drawweapon); //todo, put notetrack in to tell when to put gun in hand
	guy.weapon = "webley";
	guy.hasweapon = true;
	guy animscripts\shared::PutGunInHand("left");
	guy_attack(guy);
}

guy_attack(guy)
{
	self endon ("stopfiring");
	guy.standing = 1;
	guy.idling = 0;
	mintime = 0;
	timer = gettime() + 500000;  // should probably make the shoot time better
		if (timer < mintime)
			timer = mintime;
	while (gettime() < timer)
	{
		timer2 = gettime() + 2000;
		while (gettime() < timer2)
		{
			lastposition = self.newposition;
			self notify("bikeanimevent","idle");
			animflaggedontag("firing",guy,guy.sittag,guy.attackanim);
			currentposition = lastposition;
			if(self.newposition != lastposition) // 0 = left 1 = forward 2 = right 3 = no update;
			{
				if((self.newposition-lastposition) > 0)
					direction = "forward";
				else
					direction = "back";
				while(currentposition !=self.newposition)
				{
					if(isdefined(guy.attacktransition[direction]))
						animontag(guy,guy.sittag,guy.attacktransition[direction]);
					if(direction == "forward")
						currentposition++;
					if(direction == "backward")
						currentposition--;
					
//guy.attacktransition[0]["forward"] = %c_gr_sicily2_driver_pivot_left2straight;
//guy.attacktransition[0]["back"] = undefined;	
				}
			}
		}

		rnum = randomint(5)+10;
		for(i=0;i<rnum;i++)
		{
			if(gettime() > timer)
				break;
			animontag(guy,guy.sittag,guy.attackidle);
		}

	}
	guy_weaponholster(guy);
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


guy_weaponholster(guy)
{
	animontag(guy,guy.sittag,guy.holsterweapon);
	guy.standing = 0;
	guy_idle(guy);

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


///////////////////////////////
///////////////////////////////
#using_animtree ("sicily_bike");
///////////////////////////////
///////////////////////////////

bike_handle(guy)
{
	self.attackanimforward = %v_ge_lnd_bmw_driving;
	self.attackanimright = %v_ge_lnd_bmw_driving;
	self.attackanimleft = %v_ge_lnd_bmw_driving;
	self.leftturn = %v_ge_lnd_bmw_turn_left;
	self.rightturn = %v_ge_lnd_bmw_turn_right;
	self.hardleft = %v_ge_lnd_bmw_corner_left;
	self.hardright = %v_ge_lnd_bmw_corner_right;
	self.baseidle =%v_ge_lnd_bmw_driving;
	self.idle = self.baseidle;
	self.gunidle = undefined;

	self.downstairs = %v_ge_lnd_bmw_stairs;
//	self.downstairs = self.baseidle;

	while (self.health > 0)
	{
		self waittill ("bikeanimevent",other);
		if(other == "idle")
			self thread bike_idle();
		else if(other == "fire")
			thread bike_fire();
		else if(other == "turnleft")
			thread bike_turnleft();
		else if(other == "turnright")
			thread bike_turnright();
		else if(other == "turnhardleft")
			thread bike_turnhardleft();
		else if(other == "turnhardright")
			thread bike_turnhardright();
		else if(other == "downstairs")
			thread bike_downstairs();
	}
}

bike_idle()
{
	self notify ("skidoff");
	self useanimtree (#animtree);
	self setanimknobrestart(self.idle);
}

bike_downstairs()
{
	self notify ("skidoff");
	self useanimtree (#animtree);
	self setanimknobrestart(self.downstairs);
}

bike_fire()
{
	self notify ("skidoff");	
	self useanimtree (#animtree);
	self setanimknobrestart(self.idle);
}
bike_turnleft()
{
	self notify ("skidoff");
	self useanimtree (#animtree);
	self setanimknobrestart(self.leftturn);
}
bike_turnright()
{
	self notify ("skidoff");
	self useanimtree (#animtree);
	self setanimknobrestart(self.rightturn);
}
bike_turnhardleft()
{
	self notify ("skidon");
	self useanimtree (#animtree);
	self setanimknobrestart(self.hardleft);
}
bike_turnhardright()
{
	self notify ("skidon");
	self useanimtree (#animtree);
	self setanimknobrestart(self.hardright);
}


