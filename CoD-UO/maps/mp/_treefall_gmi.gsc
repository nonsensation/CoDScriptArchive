main()
{
	if (getcvar("hurtgentrees") == "")
		setcvar("hurtgentrees", "off");
	
	if (!isdefined(game["treefall_sound"]))
		game["treefall_sound"] = "tankdrive_treefall";
		
	// this wait is necessary otherwise if there are to many trees then the game crashes 
	// with all sorts of odd client/server connection problems.  There may still be a problem
	// and this just masks it so if there are any problems in the future we may need to revisit this
	wait (1);

	// Alex, Maybe we should change this to some other way of signifying a tree (such as "targetname knockover")
	// incase we need to add script_models that we do not want to knock over.
	// RF, testing pushing over bushes without need for a trigger
	script_models = getentarray ("script_model","classname");

	
	for(i=0;( i<script_models.size);i++)
	{
		if (script_models[i].spawnflags & 1)
		{
			script_models[i] thread treefall_notrigger();
			script_models[i] thread treefall_checkdamage();
		}
	}
}

treefall_notrigger()
{
	self endon("treefell");
	tree = self;

	if(isdefined(tree.target))
	{
		treecol = getent(tree.target,"targetname");
	}
	else
	{
		// we need to give the tree a bounding box
		tree setbounds( (-6,-6,0), (6,6,128) );
		tree setcontents( 1 );
	}
	self waittill ("trigger", triggerer);

	tree playsound(game["treefall_sound"]);

	//self delete();
	treeorg = spawn("script_origin", tree.origin);
	treeorg.origin = tree.origin;
	treeorg.angles = triggerer.angles;
//	treeorg playsound (game["treefall_sound"]);
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
	else
		tree setcontents(0);
	treeorg rotatepitch(-90,1.1,.05,.2);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(5,.21,.05,.15);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(-5,.26,.15,.1);
	treeorg waittill("rotatedone");
	tree unlink();
	treeorg delete();
	
	tree thread sink_and_delete();
	tree notify("treefell");
}

treefall_checkdamage()
{
	self endon("treefell");
	
	// turn on the damage notifies
	self settakedamage(true);
	
	// set the base health
	health = 100;
	
	for(;;)
	{
		self waittill ("damage", dmg, who, dir, point, mod);

		// only take damage from certain types of damage
		if ( mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH"
			|| mod == "MOD_ARTILLERY" || mod == "MOD_ARTILLERY_SPLASH")
		{
			// half damage for splash
			if ( mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_ARTILLERY_SPLASH" )
			{
				health = health - (dmg * 0.5);
			}
			else
			{
				health = health - dmg;
			}
			
			if (health <= 0)
			{
				treeorg = spawn("script_origin", self.origin);
				treeorg.origin = self.origin;
				self playsound (game["treefall_sound"]);
	
				dir = (dir[0] * -1, dir[1] * -1, dir[2] * -1);
				treeorg.angles = vectortoangles(dir);
	
				self linkto(treeorg);
				if(isdefined(treecol))
					treecol delete();
				else
					self setcontents(0);
				treeorg rotatepitch(-90,1.1,.05,.2);
				treeorg waittill("rotatedone");
				treeorg rotatepitch(5,.21,.05,.15);
				treeorg waittill("rotatedone");
				treeorg rotatepitch(-5,.26,.15,.1);
				treeorg waittill("rotatedone");
				self unlink();
				treeorg delete();
				
				self thread sink_and_delete();
				self notify("treefell");
				return;
			}
		}
		
		wait (0.1);
	}
}

sink_and_delete()
{
	wait(20);
	
	treeorg = spawn("script_origin", self.origin);
	treeorg.origin = self.origin;

	self linkto(treeorg);

	sink_to = ( self.origin[0], self.origin[1], self.origin[2] -  200);

	timer = 20;
	treeorg moveto(sink_to, timer,timer * 0.95,timer * 0.05);
	wait(timer);
	self unlink();
	treeorg delete();
	
	// now delete the tree
	self delete();
}