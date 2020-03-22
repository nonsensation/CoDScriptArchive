//
// TO USE:
//
// Add a script model, either xmodel/treeburst_winter_firhighbranch_a or xmodel/treeburst_winter_firhighbranch_b. Give the
// script model a "script_noteworthy" of "a_a," "a_b," or "a_c" if using the xmodel/treeburst_winter_firhighbranch_a. If
// using xmodel/treeburst_winter_firhighbranch_b, use "b_a," "b_b," or "b_c" as values for the script_noteworthy. Create a
// trigger, target the tree script_model you'd like to blow up. Give the trigger a targetname of "treeburst." That should
// be it.
//

#using_animtree("generic_human");
main()
{	
	level._effect["tree_burst"] = loadfx("fx/explosions/treeburst_a.efx");
	level._effect["tree_burst_snow"] = loadfx("fx/explosions/tree_burst_snow.efx");
	level thread tree_burst_setup();
}

#using_animtree("tree_burst_anim");
tree_burst_setup()
{
	trigs = getentarray("tree_burst", "targetname");
	num = 0;
	for(i=0;i<trigs.size;i++)
	{
		trigs[i].tree_num = num;
		trigs[i] thread tree_burst_init();
		trigs[i] thread tree_burst_think();
		num++;
	}
}

tree_burst_init()
{
	targets = getentarray(self.target,"targetname");
	
	if (isdefined(self.target))
	{
		for(i=0;i<targets.size;i++)
		{
			treeswap = spawn("script_model", targets[i].origin);
			treeswap setmodel("xmodel/tree_winter_firhighbranch");
			treeswap.targetname = self.tree_num + "tree_to_die_" + i;
			treeswap.angles = targets[i].angles;
						
			targets[i].target = self.tree_num + "tree_to_die_" + i;
			println (targets[i].target);
			targets[i] hide();
		}
	}
}

tree_burst_think()
{	
	self waittill("trigger");


	if (isdefined(self.target))
	{
		targets = getentarray(self.target,"targetname");

		for(i=0;i<targets.size;i++)
		{
			if (!isdefined(targets[i].script_noteworthy))
			{
				anim_type = %treeburst_winter_firhighbranch_a;
				println ("^1Using default tree burst animation. Add script_noteworthy to script_model tree that will burst");
				offset = (0,0,300);
			}
			else if (isdefined(targets[i].script_noteworthy))
			{
				if (targets[i].script_noteworthy == "a_a")
				{
					anim_type = %treeburst_winter_firhighbranch_a; 
					offset = (0,0,300);
				}
				else if (targets[i].script_noteworthy == "a_b")
				{
					anim_type = %treeburst_winter_firhighbranch_b;
					offset = (0,0,300);
				}
				else if (targets[i].script_noteworthy == "a_c")
				{
					anim_type = %treeburst_winter_firhighbranch_c;
					offset = (0,0,300);
				}
				else if (targets[i].script_noteworthy == "b_a")
				{
					anim_type = %treeburst_winter_firhighbranch_b_a;
					offset = (0,0,20);
				}
				else if (targets[i].script_noteworthy == "b_b")
				{
					anim_type = %treeburst_winter_firhighbranch_b_b;
					offset = (0,0,20);
				}
				else if (targets[i].script_noteworthy == "b_c")
				{
					anim_type = %treeburst_winter_firhighbranch_b_c;
					offset = (0,0,20);	
				}
				else
				{
				 	anim_type = %treeburst_winter_firhighbranch_a;
					println ("^1Using default tree burst animation. Add proper script_noteworthy type to script_model tree that will burst.");
					offset = (0,0,300);
				}
			}
			
			targets[i] show();
			tohide = getent(targets[i].target, "targetname");
			tohide hide();
			
			// Put check for script model here
			targets[i] UseAnimTree(#animtree);
			playfx(level._effect["tree_burst"], (targets[i].origin + offset) );
			targets[i] thread play_snow_fx();
			targets[i] playSound ("treeburst");
			targets[i] animscripted( "single anim", targets[i].origin, targets[i].angles, (anim_type));
			wait (randomfloat(0.5));
			//playfxontag(level._effect["tree_burst_snow"], targets[i], "tag_snow");
			targets[i] playsound ("tankdrive_treefall");
		}
	}
	else
	{
		println("^1Trigger for tree burst needs a target.");
	}
}

play_snow_fx()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	
	for (i=0;i<10;i++)
	{
		playfxontag(level._effect["tree_burst_snow"], self, "tag_snow");
		wait 0.15;
	}
}