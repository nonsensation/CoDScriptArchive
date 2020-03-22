
#using_animtree( "panzerIV" );

main()
{

	htracks = getentarray("script_vehicle","classname");
	for(i=0;i<htracks.size;i++)
	{

		if(htracks[i].model == "xmodel/v_ge_lnd_halftrack")
		{
			println("^5HALFTRACK");
			htracks[i].deathmodel = "xmodel/v_ge_lnd_halftrack_d";
			htracks[i].health = 50;
			htracks[i].guys = [];
			precachemodel(htracks[i].deathmodel);
			precachemodel("xmodel/w_ge_lmg_mg42_nopod");
			precachevehicle("HalfTrack");
			precacheturret("mg42_bipod_stand");
			loadfx ("fx/explosions/vehicles/panzerIV_complete.efx");
			loadfx("fx/smoke/oneshotblacksmokelinger.efx");
			if (isdefined (htracks[i].script_squadname))
			{
			}
//"reached_end_node"
//			htracks[i] thread init("reached_end_node");
			if (isdefined(htracks[i].target))
			{
				path = getvehiclenode(htracks[i].target,"targetname");
				if (isdefined(path))
				{
					htracks[i] attachpath(path);
				}
				else
				{
					println("^6 WARNING the halftrack wasn't auto attached");
				}
				
			}
		}
	}
}

precache()
{
	precachemodel("xmodel/v_ge_lnd_halftrack_d");
	precachevehicle("HalfTrack");
	precachemodel("xmodel/w_ge_lmg_mg42_nopod");
	precacheturret("mg42_bipod_stand");
}

#using_animtree ("generic_human");
init(ender)
{
//	thread maps\_treads_gmi::main();
	maps\_tank_gmi::setteam("axis");

	if(self.model == "xmodel/v_ge_lnd_halftrack")
	{
		self.deathmodel = "xmodel/v_ge_lnd_halftrack_d";
	}

	self.mgturret = spawnTurret("misc_turret", (0,0,0), "mg42_bipod_stand");
	self.mgturret setturretteam("axis");
	self.mgturret linkto(self, "tag_secondary_gun", (0, 0, 0), (0, 0, 0));
	self.mgturret.angles = self.angles;
	self.mgturret setmode("auto_nonai");
	self.mgturret setmodel("xmodel/w_ge_lmg_mg42_nopod");
	self.mgturret maketurretunusable();

	//	setup the anim names and tags
	positions[0]["getoutanim"] = %c_ge_halftrack_dismount1;
	positions[1]["getoutanim"] = %c_ge_halftrack_dismount2;
	positions[2]["getoutanim"] = %c_ge_halftrack_dismount3;
	positions[3]["getoutanim"] = %c_ge_halftrack_dismount5;
	positions[4]["getoutanim"] = %c_ge_halftrack_dismount6;

	positions[0]["exittag"] = "tag_guy1";
	positions[1]["exittag"] = "tag_guy2";
	positions[2]["exittag"] = "tag_guy3";
	positions[3]["exittag"] = "tag_guy5";
	positions[4]["exittag"] = "tag_guy6";

	positions[0]["delay"] = 0; 	//tag1
	positions[1]["delay"] = 0; 	//tag1
	positions[2]["delay"] = 0; 	//tag2
	positions[3]["delay"] = 0; 	//tag3
	positions[4]["delay"] = 0;	//tag5


	self thread kill();

	vehiclegroup = self.script_squadname;

	if(!isdefined(vehiclegroup))
	{
		vehiclegroup = "";
	}

	if(!isdefined(self.guys))
	{
		self.guys = [];
	}

	spawner = getspawnerarray();
	for(i=0;i<spawner.size;i++)
	{
		if(isdefined (spawner[i].script_squadname))
		{
			println("spawner ",spawner[i].script_squadname," ",spawner[i].count);
			if(spawner[i].script_squadname == vehiclegroup && spawner[i].count > 0)
			{
				println(spawner[i].script_squadname);

				if(isdefined(spawner[i].script_stalingradspawn) && spawner[i].script_stalingradspawn)
				{
					spawned = spawner[i] stalingradspawn();
				}
				else
				{
					spawned = spawner[i] dospawn();
				}
				if(isdefined(spawned))
				{
					if(isdefined(starthealth))
						spawned.health = starthealth;
					self.guys[self.guys.size] = spawned;
				}
				else
				{
					println("spawned truck guy at failed to spawn at ",spawner[i].origin);
					spawned = undefined;
				}
			}
		}
	}	


	//	this is the actual assigning and so forth 
	self thread __doors_open();

	println("^6 Halftrack Debug SIZE ,",self.guys.size);
	
	for(i=0;i<self.guys.size;i++)
	{
		guy = self.guys[i];
		if (isdefined(guy))
		{
			guy.exittag = positions[i]["exittag"];
			guy.getoutanim = positions[i]["getoutanim"];
			guy.delay = positions[i]["delay"];
			guy.climb_tag = i;
			if (self.guys.size == 1)
				guy.climb_tag = 4;
			guy.allowdeath = true;
			println("original ",guy.origin);
			if (guy.climb_tag != 4)
			{
				org= self gettagorigin(guy.exittag);
				println("teleport guy ",org);
				guy teleport(org);
				guy linkto(self,guy.exittag,(0,0,0),(0,0,0));
				guy thread __anim(self, (0,0,0));  // sicily2 needs to have guys shooting out of the back of the halftrack.
				self thread wait_jump_out(guy);
			}
			else
			{
				guy.mgturret = self.mgturret;
				org = self.mgturret gettagorigin("tag_player");
				println("DRIVER teleport guy ",org);
				guy teleport(org + (0,0,-50));
				guy thread __man_turret();
				if(!(isdefined(self.script_notewothy) && self.script_notewothy == "gunnerstay"))
					self thread wait_jump_out(guy);
				
	
			}
			self thread handle_death(guy);
			//	set the guys specific anims and stuff 
			//	tell the tank to wait for the unload message 
			//	then throw them out
			
		
		}
	}



	if (isdefined(ender))
	{
		self waittill(ender);

		self notify("unload");
		rr = 0;
		for(i=0;i<self.guys.size;i++)
		{
			if (isalive(self.guys[i]))
			if (isdefined(self.guys[i].target))
			{
				goal = getnode(self.guys[i].target,"targetname");
				self.guys[i] setgoalnode(goal);
//				self.guys[i].goalradius=128; // MikeD: Use script_radius on the spawner to change the AI's goalradius.
			}
		}
	}
}

explode()
{
	org = self.origin;
	check = 0;
	bounce = 0;
	range = 800;

	vVel = (randomIntRange(-50, 50), randomIntRange(-50, 50), randomIntRange(range,range+200));
	self moveGravity (vVel, 3);
//	self rotateroll((1500 + randomfloat (2500)) * -1, 2,0,0);

	while(1)
	{	
		if (distance(org,self.origin)>200)
		{
			check = 1;
		}

		vec1 = self.origin;
		vec2 = vec1 + (0,0,-1000);
		trace_result = bulletTrace(vec1, vec2,false,self);
		line(vec1, trace_result["position"]);

		if (distance(trace_result["position"],self.origin)<20) 
		{
			if (check==1)
			{
				range = range - 200;
				println(self.origin);

				org = (self.origin[0],self.origin[1],org[2]);
				self moveto(org,0.01,0.0,0.0);
				self waittill("movedone");
		
				vVel = (randomIntRange(-50, 50), randomIntRange(-50, 50), randomIntRange(range,range+200));
				self moveGravity (vVel, 3);
				check = 0;
				bounce++;
				earthquake( 0.25, 3, self.origin, 1050 );

				if (bounce>=3) break;
				println("bounce ",bounce);
			}
		}

		wait(0.05);
	}
	org = self.origin;
	while(1)
	{
		self moveto(org,0.01,0.0,0.0);
		self waittill("movedone");
	}
	println("done");
}


kill()
{
	self waittill( "death", attacker );
	
	for(i=0;i<self.guys.size;i++)
	{
		if (isalive(self.guys[i]))
		{
			org = self.guys[i].origin;

			if (isdefined(self.guys[i].mgturret))
			{
				self.guys[i] notify ("dismounted");
				self.guys[i] teleport(org);
				self.guys[i] stopuseturret(self.guys[i].mgturret);
				//self.guys[i].mgturret delete();

			
			}
			self.guys[i] unlink();
			//self.guys[i] delete();
		}
	}

	earthquake( 0.25, 3, self.origin, 1050 );
	radiusDamage (self gettagorigin("tag_player"), 245, 200, 100);
	
	org = self.origin;
	real_org = self.origin;

	angles = self.angles;
//	self setspeed(0,10000);
	self notify ("deadstop");
	self disconnectpaths();

	level thread maps\_utility_gmi::blend_upanddown_sound(self,35,"truckfire_low","truckfire_high");
	//tempmodel = spawn ("script_model", org);

	self setmodel (self.deathmodel);
	self.deathfx = loadfx ("fx/explosions/vehicles/panzerIV_complete.efx");
	playfxonTag ( self.deathfx, self, "tag_body" );
	//tempmodel.angles = self.angles;
	//self delete();
//	tempmodel thread explode();
}

animatemoveintoplace(guy,org,angles,movetospotanim)
{
	guy animscripted("movetospot", org, angles, movetospotanim);
	guy waittillmatch ("movetospot","end");
	guy notify ("doanimscript");
}

handle_death(guy)
{
	if (isdefined(guy))
	{
		guy endon ("jumpout");
		guy endon ("end");

		guy.dropweapon = 0;

		while(guy.health>1)
		{
			wait(0.05);
			if (!isdefined(guy)) return;
		}
		println("died");
		guy waittill("animdone");
		guy unlink();
		guy stopanimscripted();
		guy delete();
	}				
}

wait_jump_out(guy,driverguy)
{
	if (isdefined(guy.mgturret))
	{
		return;
/*
		guy notify ("dismounted");
		println("^2removing from turret");
		guy teleport(org);
		guy.mgturret setmode("auto_nonai");
		guy stopuseturret(guy.mgturret);
*/
	}

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
	guy.dropweapon = 1;

	//JoeC: restore original animname after jumping off.
	if(isdefined(guy.original_animname))
	{
		guy.animname = guy.original_animname;
	}
}

__man_turret()
{
	self endon ("unload");
	self endon ("death");
	self endon ("dismounted");

	if(isalive(self))
	{
		self animscripts\shared::PutGunInHand("none");
	}

	nextburst = gettime() + 1;	//	connect soon 
	firing = 0;


//	mg42 settargetentity(targ_org);
//	mg42 startfiring();
//	mg42_gunner thread maps\_mg42::mg42_firing(mg42);
//	mg42 notify ("startfiring");

	self.mgturret settargetentity(level.player);
	self.mgturret.script_delay_min = 2;
	self.mgturret.script_delay_max = 3;
	self.mgturret.script_burst_min = 0.5;
	self.mgturret.script_burst_max = 1.2;
	self.mgturret setmode("manual_ai"); // auto, auto_ai, manual
	self.mgturret notify ("startfiring");
	self useturret(self.mgturret);
	self thread maps\_mg42_gmi::burst_fire(self.mgturret);

}

__anim(vehicle, angle_offset)
{
	self endon ("unload");
	self endon ("death");

	//JoeC: If ai has animname to begin with, store for later. (MikeD supervised, so see me Jed! :P)
	if (isdefined(self.animname))
	{
		self.original_animname = self.animname;
	}

	self.animname = "halftrack";
	positions = [];

	positions[0]["idle"] = %c_ge_halftrack_idle1;
	positions[1]["idle"] = %c_ge_halftrack_idle2;
	positions[2]["idle"] = %c_ge_halftrack_idle3;
	positions[3]["idle"] = %c_ge_halftrack_idle5;
	positions[4]["idle"] = %c_ge_halftrack_idle6;

	positions[0]["pain"] = %flinchA;
	positions[1]["pain"] = %flinchA;
	positions[2]["pain"] = %flinchA;
	positions[3]["pain"] = %flinchA;
	positions[4]["pain"] = %stand_pain_front_rshoulder;
 

	level.scr_anim[self.animname][("idle" + self.climb_tag)][0] = positions[self.climb_tag]["idle"];
	level.scr_face[self.animname][("idle" + self.climb_tag)][0] = (%facial_fear01);
	level.scr_anim[self.animname][("deathanim" + self.climb_tag)] = %death_stand_dropinplace;
	level.scr_face[self.animname][("deathanim" + self.climb_tag)] = (%facial_fear01);

	if(isalive(self))
		self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "finished", undefined, vehicle);

}


#using_animtree( "halftrack" );

__doors_open()
{
	self endon ("death");
	self waittill ("unload");
	if(isalive(self))
	{
		self useAnimTree( #animtree );
		self setAnimKnobRestart( %v_ge_lnd_halftrack_doors_open );
	}
}

