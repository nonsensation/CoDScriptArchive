//bomber map dummies


main()
{
	precacheModel("xmodel/bomber_dummies_ambienta");
	precacheModel("xmodel/bomber_dummies_ambientb");
	precacheModel("xmodel/bomber_dummies_ambientc");
}

#using_animtree("bomber_dummies_path");

dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, anim_wait)
{
	s_fast = getcvar("scr_gmi_fast");

	if(s_fast == "2")
	{
		println("^1Low optimal settings detected! Aborting drones!");
		return;
	}

	if(!isdefined(level.dummy_count))
	{
		level.dummy_count = 0;
	}

	loops = 0;
	while(1)
	{	
		//println("^5DUMMY PATH SPAWNED!");
		dummies_path = spawn ("script_model",(pos));
		dummies_path setmodel (model);
		dummies_path.num = 0;
		dummies_path.total_tags = total_tags;

		if(isdefined(angle_offset))
		{
			dummies_path.angles = (angle_offset);
		}
		else
		{
			dummies_path.angles = (0,0,0);
		}
		dummies_path hide();
		dummies_path UseAnimTree(#animtree);

		dummies_path thread dummies_path_think( path_anim, anim_wait );

		if(isdefined(loop_time))
		{
			loops++;

			if(loop_time == "random")
			{
				wait (1 + randomfloat(3));
			}
			else
			{
				wait loop_time;
			}

			if(isdefined(loop_num) && loops == loop_num)
			{
				break;
			}
		}
		else
		{
			break;
		}
	}

	while(dummies_path.num > 0)
	{
		//println("DUMMIES PATH NUM : ",dummies_path.num);
		wait 0.5;
	}

}

dummies_path_think(path_anim, anim_wait )
{
	self setFlaggedAnimKnobRestart("animdone", path_anim);

	for (i=0;i<self.total_tags;i++)
	{
		if (i < 10)
		{
			tag_num = ("tag_guy0" + i);
		}
		else
		{
			tag_num = ("tag_guy" + i);
		}

		//println("^5DUMMY ",anim_name," Spawned! Num: ", i);
		dummy = spawn ("script_model",(self.origin));

		dummy setmodel ("xmodel/v_ge_air_me-109");

		dummy hide();

		level.dummy_count++;
		self.num++;
		dummy.targetname = "dummy";
		dummy.tag = tag_num;
		dummy.num = i;
		dummy.died = false;
		dummy.animname = anim_name;

		dummy thread dummy_think( self, anim_wait );
	}

	while(self.num > 0)
	{
		wait 0.5;
	}
	wait 1;

	self delete();
}

dummy_think( dummies_path, anim_wait )
{
	self endon("death");

	self show();

	self UseAnimTree(#animtree);
	self.origin = dummies_path gettagorigin (self.tag);
	self linkto (dummies_path, self.tag, (0,0,0), (0,0,0));
	
	//println("^5Position ",self.origin);

	if(isdefined(anim_wait))
	{
//		if(anim_wait.size == 1)
//		{
//			wait level.anim_wait[0];
//		}
//		else
//		{
			//println("^5WAITING : ",anim_wait[self.num]);
	wait level.anim_wait[self.num];
//		}
	}
	else
	{
		println(self.num, " IS DOING RANDOM WAIT CRAP");
		if (self.num < 10)
		{
			wait (5 + randomfloat (5)) ;
		}
		else if (self.num >= 10 )
		{
			wait (10 + randomfloat (5));
		}
	}

	self unlink();

	self.died = true;
	dummies_path.num--;
	level.dummy_count--;
	self delete();
}
