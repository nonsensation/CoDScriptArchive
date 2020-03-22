
// =======================
//  UTIL FUNCTIONS
// =======================

// mod (5, 2) = 1
mod (a, b)
{
	c = a;
	while(c >= b)
		c = c - b;

	return c;
}

LiveEntCount ( grp )
{
	count = 0;

	for ( x=0; x<grp.size; x++ )
	{
		if(isdefined( grp[x]) && issentient( grp[x] ) && isalive ( grp[x] ) )
			count = count + 1;
	}

	return count;
}

//Random Arrays
randomArrayElement (array)
{
	return array [randomint (array.size)];
}

DeleteEntArray(value, key)
{
	group = getentarray ( value, key );
	if(isdefined(group))
	{
		for(x=0;x<group.size;x++)
		{
			if(isdefined(group[x]))
			{
				group[x] delete();
			}
		}
	}
}

KillEntArray(value, key)
{
	group = getentarray ( value, key );
	if(isdefined(group))
	{
		for(x=0;x<group.size;x++)
		{
			if(isdefined(group[x]))
			{
				if(issentient(group[x]) && isalive(group[x]))
					group[x] dodamage(group[x].health+50,group[x].origin);
				else
					group[x] delete();
			}
		}
	}
}

// CullDead removes dead entities from the passed in array and returns the culled array
//

CullDead( array )
{
	if( !isdefined(array))
	{
		return undefined;
	}
	for(i=0;i<array.size;i++)
	{
		remove = false;
		if( isdefined(array[i]) )
		{
			if( !isalive(array[i]) )
			{
				remove = true;
			}
		}
		else
		{
			remove = true;
		}
		
		if( remove )
		{
			array = maps\_utility_gmi::array_remove(array,array[i]);
			if(!isdefined(array))
			{
				return undefined;
			}
			i--;
		}
	}
	return array;
}

// once the guy is sent off to die, make sure he doesn't thrash between targets
// take him out of the available pool of guys, wait til he's been at his goal for 10s, then
// put him back in the available pool
make_redshirt_available (reattach, pausetime)
{
	self endon("death");

	self.targetname = "friendlywave_guy_busy";
	self waittill ( "goal" );
	wait ( 10 );
	self.targetname = "friendlywave_guy";

	if(reattach == true)
		self setgoalentity (level.player);

//	println ( "^5make_redshirt_available: redshirt re-entering workforce");
}

send_redshirt_to_death ( targetname, mark_busy, reattach, pausetime )
{
	if(!isdefined(mark_busy))
		mark_busy = false;
	if(!isdefined(reattach))
		reattach = false;
	if(!isdefined(pausetime))
		pausetime = 10;

	redshirts = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined (redshirts) && (redshirts.size > 0))
	{
		goalnodes = getnodearray ( targetname, "targetname" );
		if(isdefined (goalnodes) && (goalnodes.size > 0))
		{
			goalnum = randomint ( goalnodes.size );
			guynum = randomint ( redshirts.size );

			if(isdefined(redshirts[guynum]) && isalive(redshirts[guynum]))
			{
				redshirts[guynum] setgoalnode ( goalnodes[goalnum] );

//				println ( "^5send_redshirt_to_death: guy to "+targetname+"@" + goalnodes[goalnum].origin + "!");

				if(mark_busy == true)
					redshirts[guynum] thread make_redshirt_available(reattach, pausetime);

				return redshirts[guynum];
			}
//			else println ( "^5send_redshirt_to_death: guy not defined/alive");
		}
//		else println ( "^5send_redshirt_to_death: no goals named" + targetname + "!");
	}
//	else println ( "^5send_redshirt_to_death: no redshirts found");

	return undefined;
}

// slightly different from ponyri_factory's version... eventually we should migrate to this
// version
fire_clown_car ( max_spawn, spawner_list, newtargname )
{
	already_spawned = getentarray ( newtargname, "targetname" );

	if(already_spawned.size < max_spawn)
	{
//		spawner_list = getentarray ( spawnername, "targetname" );
		if(isdefined (spawner_list) )
		{
			offset = randomint ( spawner_list.size );

			for(x=0;x<spawner_list.size;x++)
			{
				y = maps\_pi_utils::mod ( x + offset, spawner_list.size );

				if(isdefined (spawner_list[y]))
				{
					spawned = spawner_list[y] dospawn();

					if( isdefined ( spawned ))
					{
						spawned.targetname = newtargname;

						if(isdefined (spawner_list[y].target) )
						{
							targetnodes = getnodearray ( spawner_list[y].target, "targetname" );

							if(targetnodes.size < 1)
							{
								spawned delete();
							}
							else
							{
								spawned.target = spawner_list[y].target;
								spawned setgoalnode ( maps\_pi_utils::randomArrayElement(targetnodes) );
								return spawned;
							}
						}
					}
				}
			}
		}
	}

	return undefined;
}

turn_off_teamchain ( value, key )
{
	trig = getent ( value, key );
	if(isdefined(trig))
	{
		trig maps\_utility_gmi::triggerOff();
	}
//	else println ( "^5turn_off_teamchain: no ent with "+key+" - "+value+" found");
}

run_blindly_to_nodename ( value, key, temp_sight_dist)
{
	self endon("death");
	if(!isdefined(temp_sight_dist))
		temp_sight_dist = 10;

	if(isdefined(self))
	{
		self.maxsightdistsqrd = temp_sight_dist;	// make him blind
		self.suppressionwait = 0;
		self.pacifist = true;
		self.goalradius = 96;

		node = getnode ( value, key );
		if(isdefined (node))
			self setgoalnode (node);
		else
			println("^6 run_blindly_to_nodename: ERROR - couldn't match " + key + " of " + value + "");

		self waittill ("goal");

		self.maxsightdistsqrd = 9000000;	// restore sight to 3000
		self.suppressionwait = 1;
		self.pacifist = false;
		self.goalradius = 128;
	}
}

run_blindly_to_node ( node, temp_sight_dist)
{
	self endon("death");
	if(!isdefined(temp_sight_dist))
		temp_sight_dist = 10;

	if(isdefined(self))
	{
		self.maxsightdistsqrd = temp_sight_dist;	// make him blind
		self.suppressionwait = 0;
		self.pacifist = true;
		self.goalradius = 96;

		self setgoalnode (node);

		self waittill ("goal");

		self.maxsightdistsqrd = 9000000;	// restore sight to 3000
		self.suppressionwait = 1;
		self.pacifist = false;
		self.goalradius = 128;
	}
}

objective_tracker(obj_num, ent)
{
	level endon ("stop_objective_tracker");

	if(isdefined(ent))
	{
		tracking = true;

		while(tracking)
		{
			if(isdefined(ent) && isalive(ent))
				objective_position (obj_num, ent.origin );
			else
				tracking = false;

			wait(0.2);
		}
	}
}

wait_for_group_clear(groupname, threshold, notification_string)
{
	waiting = true;

	grp = getentarray(groupname, "groupname");
	if(isdefined(grp))
	{
		while(waiting)
		{
			german_count = maps\_pi_utils::LiveEntCount(grp);
			if(german_count < threshold)
				waiting = false;
			else
			{
//				println("^4 wait_for_group_clear: " + groupname + " at " + german_count + " / " + threshold + "");
				wait(1);
			}
		}
	}
	else
		println("^5>>>>>>>>>>>> wait_for_group_clear: group " + groupname + "not found!!!");

//	println("^4 wait_for_group_clear: "+groupname+" clear");
	level notify (notification_string);
}	

delayed_run_to_target(temp_sight_dist)
{
	if(isdefined(self.target))
	{
		self endon("death");
		wait(0.1);
		self maps\_pi_utils::run_blindly_to_nodename(self.target, "targetname", temp_sight_dist);
	}
}
