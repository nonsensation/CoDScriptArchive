main()
{

	level.wrongwaysmessage[0] = "We need to take out these tanks first";

	maps\tankdrivetown_fx::main();
	maps\_load::main();
	maps\_tiger::main_snow();
	maps\_panzeriv::main();
	maps\_panzeriv::main_camo();
	maps\_t34::main();
	
	maps\_flak::main();
	maps\_panzer::main();
	maps\_tankdrive::main("introscreen");
	level.flak_burst = loadfx ("fx/muzzleflashes/flaktemp_nolight.efx");
	
	maps\_treefall::main();
	
	//setExpFog(.0000722,  .77, .78,.90 , 0);
	setExpFog(.0000722,  (float)155/(float)255,(float)160/(float)255,(float)155/(float)255, 0);  //rgb values RED
	
	ambientPlay("ambient_tankdrive_country");
	thread planesflyby();
	thread objectives();

	thread threefirstguyaccuracy();
	thread trigger_setup_fillerguys();

	thread hintprints();
	thread musicloop();
	
	level.tankskilled = 0;
	level thread first3tanks_death_setup("auto265");
	level thread first3tanks_death_setup("auto1780");
	level thread first3tanks_death_setup("auto267");
}

first3tanks_death_setup(name)
{
	while (1)
	{
		tank = getent (name,"targetname");
		if (isdefined (tank))
		{
			tank thread first3tanks_death_wait();
			return;
		}
		else
		{
			wait 1;
		}
	}
}

first3tanks_death_wait()
{
	self waittill ("death");
	level.tankskilled++;
}

musicloop()
{
	wait .05;
	musicplay("tankdrive_a");

	while(1)
	{
		wait 1;
		musicplay("tankdrive_a");
	}
}

objectives()
{
	level thread objective_1();
	thread newobj1();
	
	objective_add(1, "active", &"TANKDRIVECOUNTRY_OBJ_GETTOTOWN", (15656,4408,920));
	objective_current(1);
	level waittill ("newobj1");
	level notify ("fireextinguish"); // puts out fire on first 3 tanks
	iprintlnbold(&"TANKDRIVECOUNTRY_MACHINEGUNHINT");
	tank = level.playertank;
	health = tank.health-tank.healthbuffer;
	maxhealth = tank.maxhealth-tank.healthbuffer;
	if(health/maxhealth>.5)
		maps\_utility::autosave(1);
	
	thread obj1floodguys();
	level waittill ("stopreenforce");

	tank = level.playertank;
	health = tank.health-tank.healthbuffer;
	maxhealth = tank.maxhealth-tank.healthbuffer;
	if(health/maxhealth>.5)
		maps\_utility::autosave(1);
	maps\_utility::autosave(2);

	blockers = getentarray("blocker1","targetname");
	for(i=0;i<blockers.size;i++)
		blockers[i] delete();

	thread newobj2();
	
	level waittill ("newobj2");
	
	blockers2 = getentarray("blocker2","targetname");
	for(i=0;i<blockers2.size;i++)
		blockers2[i] delete();

	endlevel = getent("endlevel","targetname");
	endlevel waittill ("trigger");
	
	objective_state(1,"done");


	wait 1.6;
	missionsuccess("tankdrivetown",false);
}

newobj1()
{
	moveenemyarrays = getentarray("moveenemyarray","targetname");
	for(i=0;i<moveenemyarrays.size;i++)
		if(moveenemyarrays[i].target == "objective1")
			thetrigger = moveenemyarrays[i];

	thetrigger waittill ("trigger");
	level notify ("newobj1");
}

newobj2()
{
	moveenemyarrays = getentarray("moveenemyarray","targetname");
	for(i=0;i<moveenemyarrays.size;i++)
		if(moveenemyarrays[i].target == "objective2")
			thetrigger = moveenemyarrays[i];

	thetrigger waittill ("trigger");
	level notify ("newobj2");
}

objective_1()
{
	getent ("count_objective1_tanks","targetname") waittill ("trigger");
	level.tankcount1 = 0;
	relays = getentarray("objective1","targetname");
	for(i=0;i<relays.size;i++)
	{
		if(isdefined(relays[i].target))
		{
			targtank = getent(relays[i].target,"targetname");
			if(isdefined(targtank))
			{
				level.tankcount1++;
				level thread tankdeath1(targtank);
			}
			targtank = undefined;
		}
	}
	println ("^2TANKS TO KILL: " + level.tankcount1);
}

obj1floodguys()
{
	ai = [];

	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
		ai[i] thread reenforce();
	level endon ("stopreenforce");
	level.cycle = 0;
	renforce = getentarray("rockspawner","targetname");
	maxcycle = 10;
	cycleall = 0;
	while(1)
	{
		ai = getaiarray("axis");
		if(ai.size < 3)
		{
			spawned = renforce[level.cycle] dospawn();
			if(isdefined(spawned))
			{
				spawned thread reenforce();
				println("reenforce spawned!!");
			}
			renforce[level.cycle].count = 1;
			cycleall++;
			level.cycle++;
			if(level.cycle >= renforce.size)
				level.cycle = 0;
		}
		else
		{
			break;
		}
		wait .5;
	}
	while(cycleall<maxcycle)
	{
		level waittill ("reenforce");
		ai = getaiarray("axis");
		if(ai.size < 10)
		{
			spawned = renforce[level.cycle] dospawn();
			if(isdefined(spawned))
			{
				spawned thread reenforce();
				println("reenforce spawned!!");
			}
			renforce[level.cycle].count = 1;
			level.cycle++;
			if(level.cycle >= renforce.size)
				level.cycle = 0;
		}
	}
}

reenforce()
{
	self.dropweapon = 0;
	self waittill ("death");
	level notify ("reenforce");
}

tankdeath1(tank)
{
	tank waittill ("death");
	//level notify ("tankdeath");
	level.tankcount1--;
	println ("^2TANK DIED!");
	println ("^2TANKS TO KILL: " + level.tankcount1);
	if (level.tankcount1 > 0)
		return;
	level notify ("stopreenforce");
}

threefirstguyaccuracy()
{
	trigs = getentarray("firstthreeguys","target");
	for(i=0;i<trigs.size;i++)
	{
		if(trigs[i].targetname == "moveenemyarray")
		{
			trig = trigs[i];
		}
	}
	trig waittill ("trigger");

	targs = getentarray(trig.target,"targetname");


	tanks = [];
	count = 0;
	
	//script accuracy is set in the map to be 1000 on these guys at first
	wait 10;
	for(i=0;i<targs.size;i++)
	{
		tanks[count] = getent(targs[i].target,"targetname");
		if(isdefined(tanks[count]))
			count++;
	}
	for(i=0;i<tanks.size;i++)
	{
		println("tanks[i] is ",tanks[i]);
		println("tanks[i].model i s",tanks[i].model);
		tanks[i].script_accuracy = 200;
	}

}

trigger_setup_fillerguys()
{

	triggers = getentarray("fillerguysrun","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_fillerguys();
	}
}

trigger_fillerguys()
{
	spawners = getentarray(self.target,"targetname");
	self waittill ("trigger");
	for(i=0;i<spawners.size;i++)
	{
		spawners[i] dospawn();
		spawners[i].count = 1;
	}
}

planesflyby()
{
	plane1 = getent("flyby1","targetname");
	plane2 = getent("flyby2","targetname");

	plane1path = getvehiclenode(plane1.target,"targetname");
	plane2path = getvehiclenode(plane2.target,"targetname");

	plane1 attachpath(plane1path);
	plane2 attachpath(plane2path);

	plane1 startpath();
	wait 5;
	plane2 startpath();

	plane1 thread endpathdelete();
	plane2 thread endpathdelete();

}

endpathdelete()
{
	self waittill ("reached_end_node");
	self delete();
}

hintprints()
{
	wait 2;
	iprintlnbold(&"TANKDRIVECOUNTRY_PRESSMOVEME");
	
	wait 7;
	//crazy here.. player can have like 4 buttons bound to jump I just choose one that is bound priority being on +gostand..
	key = getKeyBinding("+gostand");
	if(key["key1"] != &"KEY_UNBOUND")
	{
		maps\_utility::keyHintPrint(&"TANKDRIVECOUNTRY_PRESSTHEJUMPBUTTON", key);
		wait 7;
	}
	else
	{
		key = getkeybinding("+moveup");	
		if(key["key1"] != &"KEY_UNBOUND")
		{
			maps\_utility::keyHintPrint(&"TANKDRIVECOUNTRY_PRESSTHEJUMPBUTTON", key);
			wait 7;
		}
	}
	iprintlnbold(&"TANKDRIVECOUNTRY_GREENBAR");
}