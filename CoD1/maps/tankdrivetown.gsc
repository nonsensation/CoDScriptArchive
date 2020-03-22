main()
{
//	setCullFog(0, 2000, .34, .33, .31, 0);

	maps\tankdrivetown_fx::main();


	maps\_load::main();
	maps\tankdrivetown_sound::main();
	println("level.scrsound is ", level.scr_sound["coolaidmanbrick"]);
	maps\_flak::main();
	maps\_panzer::main();
	maps\_panzeriv::main_camo();
	maps\_t34::main();
	maps\_tiger::main_snow();
	maps\airfield::trigger_scattertriggers_setup(); // guys runaway!!
	//setup tank that spawns at the end//
	tank = getent("sanchorescue","targetname");
	maps\_vehiclespawn::spawner_setup(tank);
	/////////////////////////////////////

	maps\_tankdrive::main();
	level.flak_burst = loadfx ("fx/muzzleflashes/flaktemp_nolight.efx");

	// special triggers that hide and show stuff to make the level faster I hope
//	thread hiders();

	// mortar setup
	level.mortar = loadfx ("fx/surfacehits/mortarImpact_snow_nolight2.efx");
	thread maps\_mortar::script_mortargroup_style();

	//falling trees
	maps\_treefall::main();

	//stuff

	setExpFog(.0000722,  .77, .78,.90 , 0);
//	setExpFog(.000022,  .78, .79,.80 , 0);
	ambientPlay("ambient_tankdrive_town");

	getflaks();
	thread objective_waits();
	thread objectives();
	thread removers();
//	thread halfway_autosave();

	thread endfriend();
//	maps\_utility::autosave(1);
	thread musicloop();

}

musicloop()
{
	wait .05;
	musicplay("tankdrive_b");

	while(1)
	{
		wait 1;
		musicplay("tankdrive_b");
	}
}


halfway_autosave()
{
	eventcount = 0;
	trigger = getent("savewhentanksdie","targetname");
	trigger thread halfway_triggernotify();
	eventcount++;

	targeters = getentarray(trigger.target, "targetname");
	for(i=0;i<targeters.size;i++)
	{
		if(isdefined(targeters[i].target))
		{
			tank = getent(targeters[i].target, "targetname");
			if(isdefined (tank))
			{
				eventcount++;
				tank thread halfway_tanknotify(trigger);
			}
		}
	}
	while (eventcount > 0)
	{
		trigger waittill ("eventcount");
		eventcount--;
	}
	maps\_utility::autosave(1);
}

halfway_tanknotify(trigger)
{
	self waittill ("death");
	trigger notify ("eventcount");
}

halfway_triggernotify()
{
	self waittill ("trigger");
	self notify ("eventcount");
}

hiders()
{
	unhiders = getentarray ("unhide","targetname");
	for(i=0;i<unhiders.size;i++)
		unhiders[i] thread  unhiders_start();
}

unhiders_start()
{
	self thread hide_targeters();
	hider = gethider();
	while(1)
	{
		self waittill ("trigger");
		self thread show_targeters();
		hider waittill ("trigger");

		hider thread hide_targeters();
	}
}

gethider()
{
	hidetargs = getentarray("hide","targetname");
	for(i=0;i<hidetargs.size;i++)
		if(hidetargs[i].target == self.target)
			return hidetargs[i];
}

hide_targeters()
{
	hidetargs = getentarray(self.target,"targetname");
	for(i=0;i<hidetargs.size;i++)
		hidetargs[i] hide_targeted();
}

hide_targeted()
{

	hidetargs = getentarray(self.target,"targetname");
	for(i=0;i<hidetargs.size;i++)
		hidetargs[i] hide();

}

show_targeters()
{
	hidetargs = getentarray(self.target,"targetname");
	for(i=0;i<hidetargs.size;i++)
		hidetargs[i] show_targeted();
}

show_targeted()
{
	hidetargs = getentarray(self.target,"targetname");
	for(i=0;i<hidetargs.size;i++)
		hidetargs[i] show();
}

removers()
{
	removers = getentarray("remover","targetname");
	for(i=0;i<removers.size;i++)
		removers[i] thread remove_trigger_wait();

}

remove_trigger_wait()
{
	self waittill ("trigger");
//	level notify ("fireextinguish");
	saveai = getent("saveai","targetname");
	ai = getaiarray();
	for(i=0;i<ai.size;i++)
	{
		if(!(ai[i] istouching(saveai)))
			ai[i] delete();

	}
	stuff = getentarray(self.target,"targetname");
	for(i=0;i<stuff.size;i++)
		stuff[i] thread remove_stuff();

}

remove_stuff()
{
	stuff = getentarray(self.target,"targetname");
	level notify ("fireextinguish"+self.target);
	if(isdefined(stuff))
	for(i=0;i<stuff.size;i++)
	{

		if(stuff[i].classname == "script_vehicle")
		{
			println("removing live tank");
			level.tanks = maps\_utility::array_remove(level.tanks,stuff[i]);
		}

		stuff[i] delete();

	}
}

getflaks()
{
	level.flakpanzers_remaining = 0;
	level.flaks_remaining = 0;
	models = getentarray("script_model","classname");
	for(i=0;i<models.size;i++)
	{
		if(isdefined(models[i].script_objective))
		if(models[i].script_objective == "obj1")
		{

			level.flaks_remaining++;
			level.flak1 = models[i];
		}
		else
		if(models[i].script_objective == "obj2")
		{

			level.flaks_remaining++;
			level.flak2 = models[i];
		}
		else
		if(models[i].script_objective == "obj3")
		{

			level.flakpanzers_remaining++;
			level.flak3 = models[i];
		}
	}
}

objective_waits()
{
	thread objective_wait("obj1");
	thread objective_wait("obj2");
	thread objective_wait("obj3");
}

objective_wait(obj)
{
	level waittill (obj);
	level notify ("objective", obj);
}

objectives()
{
//    objective_add(1, "active", "Destroy the flak panzers", (607, -15101, -73));

	org1 =  level.flak1.origin;
	org2 = level.flak2.origin;

	objective_add(1, "active", "", (org1));
	objective_string(1, &"TANKDRIVETOWN_OBJ_DESTROYFLAKCANNONS", level.flaks_remaining);
	objective_current(1);
	objective_add(2, "active", &"TANKDRIVETOWN_OBJ_DESTROYFLAKPANZER", (level.flak3.origin));

	obj1items = 0;
	while (1)
	{
		level waittill ("objective",other);

		if (other == "obj1")
		{
			level.flaks_remaining--;
			if(level.flaks_remaining > 0)
			{
				objective_add(1, "active", "", (org2));
				objective_string(1, &"TANKDRIVETOWN_OBJ_DESTROYFLAKCANNONS", level.flaks_remaining);
			}
		}
		else
		if (other == "obj2")
		{
			level.flaks_remaining--;
			if(level.flaks_remaining > 0)
			{
				objective_add(1, "active", "", (org1));
				objective_string(1, &"TANKDRIVETOWN_OBJ_DESTROYFLAKCANNONS", level.flaks_remaining);
			}
		}
		else
		if (other == "obj3")
		{
			level.flakpanzers_remaining--;
			objective_add(2, "active", &"TANKDRIVETOWN_OBJ_DESTROYFLAKPANZER", (level.flak3.origin));
			objective_state(2, "done");

		}
		else
			break;

		if(level.flaks_remaining == 0)
		{
			objective_add(1, "active", "" , (0,0,0));
			objective_string(1, &"TANKDRIVETOWN_OBJ_DESTROYFLAKCANNONS", level.flaks_remaining);
			objective_state(1, "done");
			if(level.flakpanzers_remaining > 0)
				objective_current(2);
		}
		else
			objective_current(1);
		if(level.flaks_remaining == 0 && level.flakpanzers_remaining == 0)
			break;

	}

	trigger = getent("endleveltrigger","targetname");
	objective_add(3, "active", &"TANKDRIVETOWN_OBJ_GETOUTOFHERE", trigger getorigin());
	objective_current(3);
	wait 3;

	trigger waittill ("trigger");
	objective_state(3, "done");
	wait 1;

	setcvar("ui_campaign","american");
	missionsuccess("allied_start", false);
}

endfriend()
{
	friendtrig = getent("endfriend","targetname");
	friendtrig waittill ("trigger");
	ftank = maps\_vehiclespawn::vehicle_spawn(friendtrig.target);
	ftank thread maps\_tankdrive::friendly_tanks_think();
}