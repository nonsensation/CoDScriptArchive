//	attrib["accuracy"] = 0; 		// Float
//	attrib["accuracystationarymod"] = 0; 	// Float
//	attrib["lookforward"] = 0; 		// Vector
//	attrib["lookright"] = 0; 		// Vector
//	attrib["lookup"] = 0; 			// Vector
//	attrib["fovcosine"] = 0; 		// Float
//	attrib["maxsightdistsqrd"] = 0; 	// Float
//	attrib["visibilitythreshold"] = 0; 	// Float
//	attrib["defaultsightlatency"] = 0; 	// Int
//	attrib["followmin"] = 0; 		// Int
//	attrib["followmax"] = 0; 		// Int
//	attrib["chainfallback"] = 0;		// Short
//	attrib["interval"] = 0; 		// Float
//	attrib["personalspace"] = 0; 		// Float
//	attrib["damagetaken"] = 0; 		// Int
//	attrib["damagedir"] = 0; 		// Vector
//	attrib["damageyaw"] = 0; 		// Int
//	attrib["damagelocation"] = 0; 		// String
//	attrib["proneok"] = 0; 			// Int
//	attrib["walkdist"] = 0; 		// Float
//	attrib["desiredangle"] = 0; 		// Float
//	attrib["bravery"] = 0; 			// Float
//	attrib["pacifist"] = 0; 		// Int
//	attrib["pacifistwait"] = 0; 		// Int
//	attrib["suppressionwait"] = 0; 		// Int
//	attrib["name"] = 0; 			// String
//	attrib["weapon"] = 0; 			// String
//	attrib["dontavoidplayer"] = 0; 		// Int
//	attrib["grenadeawareness"] = 0; 	// Float
//	attrib["grenade"] = 0; 			// Entity
//	attrib["grenadeweapon"] = 0; 		// Int
//	attrib["grenadeammo"] = 0; 		// Int
//	attrib["favoriteenemy"] = 0; 		// Sentinent
//	attrib["allowdeath"] = 0; 		// Int
//	attrib["useable"] = 0; 			// Byte
//	attrib["goalradiusonly"] = 0; 		// Byte
//	attrib["goalradius"] = 512;		// Int
//	attrib["dropweapon"] = 0; 		// Int
//	attrib["drawoncompass"] = 0; 		// Int
//	attrib["scriptstate"] = 0; 		// String
//	attrib["lastscriptstate"] = 0; 		// String
//	attrib["statechangereason"] = 0;	// String
//	attrib["groundtype"] = 0; 		// String
//	attrib["anim_pose"] = 0; 		// String

#using_animtree("generic_human");
respawner_setup(groupname, grouped, attributes, num_of_respawns, wait_till, last_goal)
{
	all = getspawnerarray();

	respawners = [];
	for(i=0;i<all.size;i++)
	{
		if(isdefined(all[i].groupname) && all[i].groupname == groupname)
		{
			respawners[respawners.size] = all[i];
		}
	}

	if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}

	if(isdefined(grouped))
	{
		respawn_manager = spawn("script_origin",(0,0,0));
		respawn_manager.groupname = (groupname + "_manager");
		respawn_manager.respawners_groupname = groupname;
		respawn_manager.num_of_respawns_counted = false;
		respawn_manager endon("stop respawning");
		respawn_manager.respawners = respawners;

		respawn_manager.grouped = grouped;
		respawn_manager.spawn_num = respawners.size;
		println("^3Group size is ",respawn_manager.spawn_num);
	}

	for(i=0;i<respawners.size;i++)
	{
		respawners[i] thread respawner_spawn_ai(respawn_manager, attributes, num_of_respawns, last_goal);
	}
}

respawner_spawn_ai(respawn_manager, attributes, num_of_respawns, last_goal)
{
	self.initialspawn = true;
	self.num_of_respawns_counted = false;
	if(isdefined(respawn_manager))
	{
		respawn_manager endon("stop respawning");
		respawn_manager.dead_num = 0;
		respawn_manager.alive_num = 0;
	}

	self endon("stop respawning");
	self.allow_spawn = true; // For a Fail-safe check.

	if(isdefined(respawn_manager) && isdefined(num_of_respawns))
	{
		if(!isdefined(respawn_manager.num_of_respawns))
		{
			respawn_manager.num_of_respawns = num_of_respawns;
		}
	}
	else if(isdefined(num_of_respawns))
	{
		self.num_of_respawns = num_of_respawns;
	}

	if(!isdefined(self.count))
	{
		self.count = 1;
	}

	while(1)
	{
		if(isdefined(self.new_count))
		{
			self.count = self.new_count;
			self notify("stop_death_track");
			self.new_count = undefined;
		}

		if(self.count < 1)
		{
			wait 1;
			continue;
		}

		// Delay the spawn if specified.
		// script_presapwn_delay is for the initial delay
		// Script_Delay is for any delay after the initial
		if(isdefined(self.script_prespawn_delay))
		{
			println("Using script_prespawn_delay of: ",self.script_prespawn_delay);
			wait self.script_prespawn_delay;
			self.script_prespawn_delay = undefined;
		}
		else if(!self.initialspawn)
		{
			if(isdefined(self.script_delay))
			{
				println("Using Script_Delay of: ",self.script_delay);
				wait (self.script_delay + randomfloat(self.script_delay));
			}
			else if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
			{
				range = self.script_delay_max - self.script_delay_min;
				delay = (self.script_delay_min + randomfloat(range));
				println("^3Respawn is waiting ", delay);
				wait delay;
			}
			else
			{
				println("^3No delay on Respawner!");
			}
		}

		self respawner_num_of_respawn_check(respawn_manager);

		if(!self.allow_spawn) // Fail Safe Check.
		{
			break;
		}

		if(!isdefined(self.using_respawner))
		{
			self.using_respawner = true;
		}

		// Spawn the AI
		if(isdefined(self.script_stalingradspawn) && self.script_stalingradspawn)
		{	
			spawned = self stalingradSpawn();
		}
		else
		{
			spawned = self dospawn();
		}

		// Setup the AI, grouped, attributes, etc.
		if(isdefined(spawned))
		{
			self.initialspawn = false;
			spawned waittill("finished spawning");

			if(isdefined(respawn_manager))
			{
				respawn_manager.alive_num++;
			}

			// Set the targetname of the AI, so it relates to it's spawner.
			spawned.targetname = (self.groupname + "_ai");

			println(spawned.groupname," ^3has spawned. ", spawned.classname, " ", spawned.targetname);


			if(isdefined(attributes))
			{
				spawned thread respawner_attribute_setup(attributes);
			}

			if(isdefined(self.target))
			{
				nodes = getnodearray(self.target,"targetname");
				if(nodes.size > 0)
				{
					num = randomint(nodes.size);
					spawned thread respawner_follow_nodes(nodes[num], last_goal);
				}
			}

			self thread respawner_death_tracker(respawn_manager, spawned);

			println("^5RESPAWNING! : ",self.groupname);

//			if(isdefined(respawn_manager))
//			{
//				respawn_manager.num_of_respawns_counted = false;
//			}
			self.num_of_respawns_counted = false;
		}
		else
		{
		}

		wait 0.5;
	}
}

respawner_num_of_respawn_check(respawn_manager)
{
	if(isdefined(respawn_manager) && isdefined(respawn_manager.num_of_respawns))
	{
		if(!self.num_of_respawns_counted)
		{
			self.num_of_respawns_counted = true;
			println("^5Number of respawns: ",respawn_manager.num_of_respawns);
			respawn_manager.num_of_respawns--;

			if(respawn_manager.num_of_respawns < 0)
			{
				respawn_manager notify("stop respawning");

				respawners = getentarray(respawn_manager.respawners_groupname,"groupname");
				for(i=0;i<respawners.size;i++)
				{
					respawners[i] notify("stop respawning");
				}

				self notify("stop respawning");
				self.allow_spawn = false; // Fail safe check.

				level notify(respawn_manager.respawners_groupname + "_stopped_respawning");
			}
		}
	}
	else if(isdefined(self.num_of_respawns))
	{
		if(!self.num_of_respawns_counted)
		{
			self.num_of_respawns_counted = true;
			println("^2Number of respawns: ",self.num_of_respawns);
			self.num_of_respawns--;
			if(self.num_of_respawns < 0)
			{
				self.allow_spawn = false; // Fail safe check.
			}
		}
	}

	return;
}

respawner_death_tracker(respawn_manager, ai)
{
//	println("^1Waiting for death");
	self endon("stop_death_track");
	ai waittill("death", attacker);

	if(isdefined(respawn_manager))
	{
		respawn_manager.dead_num++;
		println("GROUPED");
		respawn_manager thread respawner_group_tracker(self);
		respawn_manager notify("update_objective");
	}
	else
	{
		println("NOT GROUPED");
//		self notify("respawner go");
		self.count++;
	}
}

respawner_attribute_setup(attributes)
{
	wait 0.05; // Waitframe
	if(isdefined(attributes["health"]))
	{
		self.health = attributes["health"];
	}
	else if(isdefined(attributes["accuracy"]))
	{
		self.accuracy = attributes["accuracy"];
	}
	if(isdefined(attributes["accuracystationarymod"]))
	{
		self.accuracystationarymod = attributes["accuracystationarymod"];
	}
	if(isdefined(attributes["lookforward"]))
	{
		self.lookforward = attributes["lookforward"];
	}
	if(isdefined(attributes["lookright"]))
	{
		self.lookright = attributes["lookright"];
	}
	if(isdefined(attributes["lookup"]))
	{
		self.lookup = attributes["lookup"];
	}
	if(isdefined(attributes["fovcosine"]))
	{
		self.fovcosine = attributes["fovcosine"];
	}
	if(isdefined(attributes["maxsightdistsqrd"]))
	{
		self.maxsightdistsqrd = attributes["maxsightdistsqrd"];
	}
	if(isdefined(attributes["visibilitythreshold"]))
	{
		self.visibilitythreshold = attributes["visibilitythreshold"];
	}
	if(isdefined(attributes["defaultsightlatency"]))
	{
		self.defaultsightlatency = attributes["defaultsightlatency"];
	}
	if(isdefined(attributes["followmin"]))
	{
		self.followmin = attributes["followmin"];
	}
	if(isdefined(attributes["followmax"]))
	{
		self.followmax = attributes["followmax"];
	}
	if(isdefined(attributes["chainfallback"]))
	{
		self.chainfallback = attributes["chainfallback"];
	}
	if(isdefined(attributes["interval"]))
	{
		self.interval = attributes["interval"];
	}
	if(isdefined(attributes["personalspace"]))
	{
		self.personalspace = attributes["personalspace"];
	}
	if(isdefined(attributes["damagetype"]))
	{
		self.damagetype = attributes["damagetype"];
	}
	if(isdefined(attributes["damagetaken"]))
	{
		self.damagetaken = attributes["damagetaken"];
	}
	if(isdefined(attributes["damagedir"]))
	{
		self.damagedir = attributes["damagedir"];
	}
	if(isdefined(attributes["damageyaw"]))
	{
		self.damageyaw = attributes["damageyaw"];
	}
	if(isdefined(attributes["damagelocation"]))
	{
		self.damagelocation = attributes["damagelocation"];
	}
	if(isdefined(attributes["proneok"]))
	{
		self.proneok = attributes["proneok"];
	}
	if(isdefined(attributes["walkdist"]))
	{
		self.walkdist = attributes["walkdist"];
	}
	if(isdefined(attributes["desiredangle"]))
	{
		self.desiredangle = attributes["desiredangle"];
	}
	if(isdefined(attributes["bravery"]))
	{
		self.bravery = attributes["bravery"];
	}
	if(isdefined(attributes["pacifist"]))
	{
		self.pacifist = attributes["pacifist"];
	}
	if(isdefined(attributes["pacifistwait"]))
	{
		self.pacifistwait = attributes["pacifistwait"];
	}
	if(isdefined(attributes["suppressionwait"]))
	{
		self.suppressionwait = attributes["suppressionwait"];
	}
	if(isdefined(attributes["name"]))
	{
		self.name = attributes["name"];
	}
	if(isdefined(attributes["weapon"]))
	{
		self.weapon = attributes["weapon"];
	}
	if(isdefined(attributes["dontavoidplayer"]))
	{
		self.dontavoidplayer = attributes["dontavoidplayer"];
	}
	if(isdefined(attributes["grenadeawareness"]))
	{
		self.grenadeawareness = attributes["grenadeawareness"];
	}
	if(isdefined(attributes["grenade"]))
	{
		self.grenade = attributes["grenade"];
	}
	if(isdefined(attributes["grenadeweapon"]))
	{
		self.grenadeweapon = attributes["grenadeweapon"];
	}
	if(isdefined(attributes["grenadeammo"]))
	{
		self.grenadeammo = attributes["grenadeammo"];
	}
	if(isdefined(attributes["favoriteenemy"]))
	{
		self.favoriteenemy = attributes["favoriteenemy"];
	}
	if(isdefined(attributes["allowdeath"]))
	{
		self.allowdeath = attributes["allowdeath"];
	}
	if(isdefined(attributes["useable"]))
	{
		self.useable = attributes["useable"];
	}
	if(isdefined(attributes["goalradiusonly"]))
	{
		self.goalradiusonly = attributes["goalradiusonly"];
	}
	if(isdefined(attributes["goalradius"]))
	{
		self.goalradius = attributes["goalradius"];
	}
	if(isdefined(attributes["dropweapon"]))
	{
		self.dropweapon = attributes["dropweapon"];
	}
	if(isdefined(attributes["drawoncompass"]))
	{
		self.drawoncompass = attributes["drawoncompass"];
	}
	if(isdefined(attributes["scriptstate"]))
	{
		self.scriptstate = attributes["scriptstate"];
	}
	if(isdefined(attributes["lastscriptstate"]))
	{
		self.lastscriptstate = attributes["lastscriptstate"];
	}
	if(isdefined(attributes["statechangereason"]))
	{
		self.statechangereason = attributes["statechangereason"];
	}
	if(isdefined(attributes["groundtype"]))
	{
		self.groundtype = attributes["groundtype"];
	}
	if(isdefined(attributes["anim_pose"]))
	{
		self.anim_pose = attributes["anim_pose"];
	}
	if(isdefined(attributes["ignoreme"]))
	{
		self.ignoreme = attributes["ignoreme"];
	}
	if(isdefined(attributes["threatbias"]))
	{
		self.threatbias = attributes["threatbias"];
	}
	if(isdefined(attributes["allowedstances"]))
	{
		if(attributes["allowedstances"] == "crouch prone")
		{
			self allowedstances("crouch","prone");
		}
		else
		{
			self allowedstances(attributes["allowedstances"]);
		}
	}

	if(getcvar("debug_attrib") == "1")
	{
		self thread debug_attributes();
	}
}

respawner_group_tracker(spawner)
{
	if(self.grouped == "special")
	{
		spawner.count++;
	}
	else
	{
		println("GROUPED, Dead: ",self.dead_num," out of: ",self.alive_num);
		if(self.dead_num == self.alive_num)
		{
			self.alive_num = 0;
			self.dead_num = 0;
	//		self notify("group respawner go");
	
			for(i=0;i<self.respawners.size;i++)
			{
				self.respawners[i].count++;
			}
		}
	}
}

respawner_follow_nodes(node, last_goal)
{
	self endon("death");

	while (isdefined (node))
	{
		if (isdefined (node.target))
		{
			turret = getent (node.target, "targetname");
			if ((isdefined (turret)) && ((turret.classname == "misc_mg42") || (turret.classname == "misc_turret")))
			{
				turret thread maps\_spawner_gmi::flag_turret_for_use (self);
			}
		}

		if(isdefined(node.radius))
		{
			self.goalradius = node.radius;
		}

		self setgoalnode (node);
		self waittill ("goal");

		if(isdefined(node.script_delay))
		{
			wait node.script_delay;
		}

		if(isdefined(node.target))
		{
			nodes = getnodearray (node.target,"targetname");
			if(nodes.size > 1)
			{
				num = randomint(nodes.size);
				node = nodes[num];
			}
			else
			{
				node = nodes[0];
			}
		}
		else
		{
			break;
		}
	}

	if(isdefined(self.script_panzer) && self.script_panzer == 1)
	{
		if(isdefined(level.panzer_think_thread))
		{
			self thread [[level.panzer_think_thread]]();
		}
	}

	// We check to see if the node is defined cause sometimes a node could
	// target another type of entity. Like a MG42.
	if(isdefined(node) && isdefined(node.script_noteworthy))
	{
		if(node.script_noteworthy == "no_last_goal")
		{
			return;
		}
	}

	println("^5Last_GOAL = ",last_goal);
	if(isdefined(last_goal))
	{
		// Used for Kharkov2, to make the AI sometimes go to the player.
		if(!issentient(last_goal))
		{
			if(last_goal == "sometimes")
			{
				// 50% chance of going to the player.
				if(randomint(100) < 50)
				{
					return;
				}
		
				if(self.goalradius < 192)
				{		
					self.goalradius = 192;
				}
				self setgoalentity(level.player);
			}
			else if(last_goal == "kharkov2_special")
			{
				if(!level.flag["kharkov2_special"])
				{
					level waittill("kharkov2_special");
	
					if(self.goalradius < 192)
					{		
						self.goalradius = 192;
					}

					node = self GetClosestNode("kharkov2_node_rush");
					self setgoalnode(node);
				}
				else
				{
					// 50% chance of going to the player.
					if(randomint(100) < 50)
					{
						return;
					}
			
					if(self.goalradius < 192)
					{		
						self.goalradius = 192;
					}
					self setgoalentity(level.player);
				}
			}
		}
		else
		{
			if(self.goalradius < 128)
			{		
				self.goalradius = 128;
			}
			self setgoalentity(last_goal);
		}
	}

	self waittill("goal");
	self.goalradius = 512;
}

respawner_stop(groupname, grouped)
{
	if(isdefined(grouped))
	{
		respawn_manager = getent(groupname + "_manager","groupname");
		respawn_manager notify("stop respawning");

		respawners = getentarray(groupname,"groupname");
		for(i=0;i<respawners.size;i++)
		{
			respawners[i] notify("stop respawning");
		}

		respawn_manager delete();
	}
	else
	{
		respawners = getentarray(groupname,"groupname");
		for(i=0;i<respawners.size;i++)
		{
			respawners[i] notify("stop respawning");
		}
	}
}

debug_attributes()
{
	println("^2=============================");
	println("^2End ",self.targetname,"^2 Profile");
	println("^2=============================");

		println("");
		println("^2Start ",self.targetname,"^2 profile");
		println(self.targetname," health ", self.health);
		println(self.targetname," accuracy ", self.accuracy);
		println(self.targetname," accuracystationarymod ", self.accuracystationarymod);
		println(self.targetname," lookforward ", self.lookforward);
		println(self.targetname," lookright ", self.lookright);
		println(self.targetname," lookup ", self.lookup);
		println(self.targetname," fovcosine ", self.fovcosine);
		println(self.targetname," maxsightdistsqrd ", self.maxsightdistsqrd);
		println(self.targetname," visibilitythreshold ", self.visibilitythreshold);
		println(self.targetname," defaultsightlatency ", self.defaultsightlatency);
		println(self.targetname," followmin ", self.followmin);
		println(self.targetname," followmax ", self.followmax);
		println(self.targetname," chainfallback ", self.chainfallback);
		println(self.targetname," interval ", self.interval);
		println(self.targetname," personalspace ", self.personalspace);
		println(self.targetname," damagetaken ", self.damagetaken);
		println(self.targetname," damagedir ", self.damagedir);
		println(self.targetname," damageyaw ", self.damageyaw);
		println(self.targetname," damagelocation ", self.damagelocation);
		println(self.targetname," proneok ", self.proneok);
		println(self.targetname," walkdist ", self.walkdist);
		println(self.targetname," desiredangle ", self.desiredangle);
		println(self.targetname," bravery ", self.bravery);
		println(self.targetname," pacifist ", self.pacifist);
		println(self.targetname," pacifistwait ", self.pacifistwait);
		println(self.targetname," suppressionwait ", self.suppressionwait);
		println(self.targetname," name ", self.name);
		println(self.targetname," weapon ", self.weapon);
		println(self.targetname," dontavoidplayer ", self.dontavoidplayer);
		println(self.targetname," grenadeawareness ", self.grenadeawareness);
		println(self.targetname," grenade ", self.grenade);
		println(self.targetname," grenadeweapon ", self.grenadeweapon);
		println(self.targetname," grenadeammo ", self.grenadeammo);
		println(self.targetname," favoriteenemy ", self.favoriteenemy);
		println(self.targetname," allowdeath ", self.allowdeath);
		println(self.targetname," useable ", self.useable);
		println(self.targetname," goalradiusonly ", self.goalradiusonly);
		println(self.targetname," goalradius ", self.goalradius);
		println(self.targetname," dropweapon ", self.dropweapon);
		println(self.targetname," drawoncompass ", self.drawoncompass);
		println(self.targetname," scriptstate ", self.scriptstate);
		println(self.targetname," lastscriptstate ", self.lastscriptstate);
		println(self.targetname," statechangereason ", self.statechangereason);
		println(self.targetname," groundtype ", self.groundtype);
		println(self.targetname," anim_pose ", self.anim_pose);
		println(self.targetname," threatbias ", self.threatbias);

	println("^2End ",self.targetname,"^2 Profile");
	println("^2==============================");
}

respawner_count_modifier(groupname, new_count)
{
	if(!isdefined(groupname))
	{
		println("^1(respawner_count_modifier): Groupname not specified");
	}

	if(!isdefined(new_count))
	{
		println("^1(respawner_count_modifier): Count not specified");
	}

	all = getentarray(groupname,"groupname");

	respawners = [];
	for(i=0;i<all.size;i++)
	{
		if(!issentient(all[i]))
		{
			respawners[respawners.size] = all[i];
		}
	}

	if(respawners.size < 1)
	{
		println("^1(respawner_count_modifier): Spawners with GROUPNAME ", groupname, " ^1was not found.");
		return;
	}

	num = 0;
	for(i=0;i<new_count;i++)
	{
		println("Num = ",num);
		if(!isdefined(respawners[num].new_count))
		{
			respawners[num].new_count = 0;
		}
		respawners[num].new_count++;

		num++;

		println("Num + 1 = ",(num + 1)," respawners.size ",respawners.size);
		if(num >= respawners.size)
		{
			num = 0;
		}
	}
}

respawner_coordinator(groupnames, timer, wait_till, attributes, num_of_respawns)
{
	if(!isdefined(groupnames))
	{
		println("^1(respawner_phase_timer): Groupnames not specified (Aborting...)");
		return;
	}

	if(!isdefined(timer) && !isdefined(wait_till))
	{
		println("^1(respawner_phase_timer): Timer or Waittill was not specified (Aborting...)");
		return;
	}

	for(i=0;i<groupnames.size;i++)
	{
//		println("^5(respawner_coordinator): Trying to spawn in : ",groupnames[i]);

		if(!isdefined(groupnames[i]))
		{
			println("^1(respawner_phase_timer): Groupnames[" + i + "]^1 of groupname: "+ groupnames[i] + " ^1is not specified. (continuing...)");
			wait 0.05;
			continue;
		}

		// Validate that the spawners exist.
		all = getspawnerarray();
	
		respawners = [];
		for(q=0;q<all.size;q++)
		{
			if(!isdefined(groupnames[q]))
			{
				continue;
			}

			if(isdefined(all[q].groupname) && all[q].groupname == groupnames[q])
			{
				respawners[respawners.size] = all[q];
			}
		}

		if(respawners.size < 1)
		{
			println("^1(respawner_phase_timer): Groupnames[", i,"^1] of groupname: ", groupnames[i]," ^1were not found. (continuing...)");
			continue;
		}

		println("^5(respawner_coordinator): Starting a wave of AI (", groupnames[i],")");

		level thread respawner_setup(groupnames[i], undefined, attributes, num_of_respawns, undefined, undefined);

		if(isdefined(timer))
		{
			wait timer;
		}
		else if(isdefined(wait_till))
		{
			level waittill(wait_till);
		}
	}
	println("^5(respawner_phase_timer): Finished!");
}

respawner_objective_tracker(groupname, objective_num, string, num_of_guys, ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

	respawn_manager = getent(groupname + "_manager","groupname");

	objective_add(objective_num, "active", string);
	objective_string(objective_num, string, num_of_guys);
	objective_current(objective_num);

	level.flag["objective" + objective_num + "_tracker_complete"] = false;

	while(num_of_guys > 0)
	{
		respawn_manager waittill("update_objective");
		num_of_guys--;

		objective_string(objective_num, string, num_of_guys);
	}

	level.flag["objective" + objective_num + "_tracker_complete"] = true;
	level notify("objective" + objective_num + "_tracker_complete");
}

// Have NOT tested "GROUPED" yet.
// Also num_of_respawns is not working correctly.
random_respawner_setup(groupname, grouped, attributes, num_of_respawns, wait_till, last_goal, amount_of_ai)
{
	all = getspawnerarray();

	respawners = [];
	for(i=0;i<all.size;i++)
	{
		if(isdefined(all[i].groupname) && all[i].groupname == groupname)
		{
			respawners[respawners.size] = all[i];
		}
	}

	if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}

	if(isdefined(grouped))
	{
		respawn_manager = spawn("script_origin",(0,0,0));
		respawn_manager.groupname = (groupname + "_manager");
		respawn_manager.respawners_groupname = groupname;
		respawn_manager.num_of_respawns_counted = false;
		respawn_manager endon("stop respawning");
		respawn_manager.respawners = respawners;

		respawn_manager.grouped = grouped;
		respawn_manager.spawn_num = respawners.size;
//		println("^3Group size is ",respawn_manager.spawn_num);
	}

	for(i=0;i<respawners.size;i++)
	{
		respawners[i].alive_ai = 0;
		respawners[i] endon("stop respawning");
	}

	level.living_ai[groupname] = 0;
	level.amount_of_ai[groupname] = amount_of_ai;
	while(1)
	{
//		println("^2Total living AI of groupname: '", groupname,"^2' is: ", level.living_ai[groupname],"^2 Out of: ",amount_of_ai);
		while(level.living_ai[groupname] < amount_of_ai)
		{
			num = undefined;

			while(!isdefined(num))
			{
				test_num = randomint(respawners.size);

				if(respawners[test_num].alive_ai == 0)
				{
					num = test_num;
				}
				wait 0.05;
			}

//			println("^5NUM: ",num);
			respawners[num] thread random_respawner_spawn_ai(respawn_manager, attributes, num_of_respawns, last_goal);

			// Added so that I can change the amount_of_ai on the fly.
			if(level.amount_of_ai[groupname] != amount_of_ai)
			{
				amount_of_ai = level.amount_of_ai[groupname];
			}
			wait 0.5;
		}

		wait 1;

		// Added so that I can change the amount_of_ai on the fly.
		if(level.amount_of_ai[groupname] != amount_of_ai)
		{
			amount_of_ai = level.amount_of_ai[groupname];
		}
	}
}

random_respawner_spawn_ai(respawn_manager, attributes, num_of_respawns, last_goal)
{
	if(!isdefined(self.initialspawn))
	{
		self.initialspawn = true;
	}

	self.num_of_respawns_counted = false;

	level.living_ai[self.groupname]++;
	if(isdefined(respawn_manager))
	{
		respawn_manager endon("stop respawning");
		respawn_manager.dead_num = 0;
		respawn_manager.alive_num = 0;
	}

	self endon("stop respawning");
	self.allow_spawn = true; // For a Fail-safe check.

	if(isdefined(respawn_manager) && isdefined(num_of_respawns))
	{
		if(!isdefined(respawn_manager.num_of_respawns))
		{
			respawn_manager.num_of_respawns = num_of_respawns;
		}
	}
	else if(isdefined(num_of_respawns))
	{
		self.num_of_respawns = num_of_respawns;
	}

	if(!isdefined(self.count))
	{
		self.count = 1;
	}

	if(isdefined(self.new_count))
	{
		self.count = self.new_count;
		self notify("stop_death_track");
		self.new_count = undefined;
	}

	// Delay the spawn if specified.
	// script_presapwn_delay is for the initial delay
	// Script_Delay is for any delay after the initial
	if(isdefined(self.script_prespawn_delay))
	{
		println("Using script_prespawn_delay of: ",self.script_prespawn_delay);
		wait self.script_prespawn_delay;
		self.script_prespawn_delay = undefined;
	}
	else if(!self.initialspawn)
	{
		if(isdefined(self.script_delay))
		{
			println("Using Script_Delay of: ",self.script_delay);
			wait (self.script_delay + randomfloat(self.script_delay));
		}
		else if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
		{
			range = self.script_delay_max - self.script_delay_min;
			delay = (self.script_delay_min + randomfloat(range));
			println("^3Respawn is waiting ", delay);
			wait delay;
		}
		else
		{
			println("^3No delay on Respawner!");
		}
	}

	self respawner_num_of_respawn_check(respawn_manager);

	if(!self.allow_spawn) // Fail Safe Check.
	{
		return;
	}

	if(!isdefined(self.using_respawner))
	{
		self.using_respawner = true;
	}

	// Spawn the AI
	if(isdefined(self.script_stalingradspawn) && self.script_stalingradspawn)
	{	
		spawned = self stalingradSpawn();
	}
	else
	{
		spawned = self dospawn();
	}

	// Setup the AI, grouped, attributes, etc.
	if(isdefined(spawned))
	{
		self.initialspawn = false;

		if(!isdefined(self.alive_ai))
		{
			self.alive_ai = 0;
		}

		self.alive_ai++;

		spawned waittill("finished spawning");

		if(isdefined(respawn_manager))
		{
			respawn_manager.alive_num++;
		}

		// Set the targetname of the AI, so it relates to it's spawner.
		spawned.targetname = (self.groupname + "_ai");

//		println(spawned.groupname," ^3has spawned. ", spawned.classname, " ", spawned.targetname);


		if(isdefined(attributes))
		{
			spawned thread respawner_attribute_setup(attributes);
		}

		if(isdefined(self.target))
		{
			nodes = getnodearray(self.target,"targetname");
			if(nodes.size > 0)
			{
				num = randomint(nodes.size);
				spawned.goalradius = 32;
				spawned thread respawner_follow_nodes(nodes[num], last_goal);
			}
		}

		self thread respawner_death_tracker(respawn_manager, spawned);

//		println("^5RESPAWNING! : ",self.groupname);

		self.num_of_respawns_counted = false;

		spawned waittill("death");
		self.alive_ai--;
		level.living_ai[self.groupname]--;
	}
	else
	{
		level.living_ai[self.groupname]--;
	}
}

GetClosestNode(targetname)
{
	if(!isdefined(targetname))
	{
		nodes = getallnodes();
	}
	else
	{
		nodes = getnodearray(targetname,"targetname");
	}

	if (nodes.size == 0)
	{
		return undefined;
	}

	return maps\_utility_gmi::getClosest (self.origin, nodes);
}