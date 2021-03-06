#using_animtree("generic_human");
patrol()
{
	self.old_walkdist = self.walkdist;
	self.walkdist = 9999;
	self thread waittill_combat();
	self endon("combat");
	self.goalradius = 0;
	self allowedStances("stand");

	patrolwalk[0] = %patrolwalk_bounce;
	patrolwalk[1] = %patrolwalk_tired;
	patrolwalk[2] = %patrolwalk_swagger;
	self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
	
	//NOTE add combat call back and force patroller to walk

	targetnode = getnode(self.target, "targetname");
	if(!isdefined(targetnode))
	{
		println("patroller ", self.origin, " has no target or target is not a node");
	}
	else
	{
		while(isalive(self))
		{
			self setgoalnode(targetnode);
			self waittill("goal");

			if(isdefined(targetnode.script_animation))
			{
				patrolstand[0] = %patrolstand_twitch;
				patrolstand[1] = %patrolstand_look;
				patrolstand[2] = %patrolstand_idle;
				self.patrolstand = maps\_utility_gmi::random(patrolstand);	

				self animscripted("scripted_animdone", self.origin, self.angles, self.patrolstand);
				self waittill("scripted_animdone");
			}

			if(isdefined(targetnode.target))
				targetnode = getnode(targetnode.target, "targetname");
			else
				break;
		}
	}
}

waittill_combat()
{
	self waittill("combat");
	self.walkdist = self.old_walkdist;
}
