main()
{
	if (getcvar("hurtgentrees") == "")
		setcvar("hurtgentrees", "off");
	treetrigs = getentarray ("treetrig","targetname");
	for(i=0;i<treetrigs.size;i++)
	{
		treetrigs[i] thread treefall();
		
		if (isdefined(treetrigs[i].script_noteworthy))
		{
			if (treetrigs[i].script_noteworthy != "bastogne1_treetrig")
			{
				treetrigs[i] thread treefall_checkdamage();
			}
			else
			{
				println("^1 This level is bastogne1, Damage off.");
			}
		}
	}
}

treefall()
{
//	println("treefallsetup");

	if(!isdefined (self.target))
	{
		println ("notarget for tree trigger at ",self getorigin());
		return;
	}
	tree = getent(self.target, "targetname");
	if (getcvar("hurtgentrees") != "off")
		tree setmodel ("xmodel/hurtgendeadtree");
	if(!isdefined (tree))
	{
		println("no tree");
		return;
	}
	if(isdefined(tree.target))
	{
		treecol = getent(tree.target,"targetname");
	}
	tree endon("treefell_checkdamage");

	self waittill ("trigger", triggerer);

	self delete();
	treeorg = spawn("script_origin", tree.origin);
	treeorg.origin = tree.origin;
	treeorg.angles = triggerer.angles;
	treeorg playsound ("tankdrive_treefall");
	if(triggerer.classname == "script_vehicle")
		triggerer joltbody((treeorg.origin + (0,0,64)),.3,.67,11);


	//joltBody (<vec_jolt_origin>, <intensity>, <speed_frac>, <decel>);
 	treeang = tree.angles;
	ang = treeorg.angles;
	org = triggerer.origin;
	pos1 = (org[0],org[1],0);
	org = tree.origin;
	pos2 = (org[0],org[1],0);
	treeorg.angles = vectortoangles(pos1 - pos2);
	tree linkto(treeorg);
	if(isdefined(treecol))
		treecol delete();
	treeorg rotatepitch(-90,1.1,.05,.2);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(5,.21,.05,.15);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(-5,.26,.15,.1);
	treeorg waittill("rotatedone");
	tree unlink();
	treeorg delete();

	tree notify("treefell");
}

treefall_checkdamage()
{
	self endon("death");
	
	// set the base health
	health = 100;
	
	if(!isdefined (self.target))
	{
		println ("notarget for tree trigger at ",self getorigin());
		return;
	}
	tree = getent(self.target, "targetname");
	if (getcvar("hurtgentrees") != "off")
		tree setmodel ("xmodel/hurtgendeadtree");
	if(!isdefined (tree))
	{
		println("no tree");
		return;
	}

	// turn on the damage notifies
	tree settakedamage(true);
	tree endon("treefell");
	
	for(;;)
	{
		println("waiting for damage");
		tree waittill ("damage", dmg, who, dir, point, mod);

		// only take damage from certain types of damage
		if ( mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH")
		{
			// half damage for splash
			if ( mod == "MOD_PROJECTILE_SPLASH" )
			{
				health = health - (dmg * 0.5);
			}
			else
			{
				health = health - dmg;
			}
			
			if (health <= 0)
			{
				self delete();
				treeorg = spawn("script_origin", tree.origin);
				treeorg.origin = tree.origin;
				treeorg playsound ("tankdrive_treefall");
	
				dir = (dir[0] * -1, dir[1] * -1, dir[2] * -1);
				treeorg.angles = vectortoangles(dir);
	
				tree linkto(treeorg);
				if(isdefined(treecol))
					treecol delete();
				treeorg rotatepitch(-90,1.1,.05,.2);
				treeorg waittill("rotatedone");
				treeorg rotatepitch(5,.21,.05,.15);
				treeorg waittill("rotatedone");
				treeorg rotatepitch(-5,.26,.15,.1);
				treeorg waittill("rotatedone");
				tree unlink();
				treeorg delete();
				
				tree notify("treefell_checkdamage");
				return;
			}
		}
		
		wait (0.1);
	}
}