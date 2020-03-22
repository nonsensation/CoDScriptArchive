main()
{
	setCullFog (0, 11000, 0.6, 0.6, 0.6, 0 );
	maps\_load::main();
	maps\sewer_fx::main();

	maps\_utility::array_thread(getentarray( "bobber", "targetname" ), ::bobber);

	level.player setReverb("stoneroom", .7, 3);

	thread objectives();
	thread speaker1();
	thread speaker2();
	thread speaker3();
	thread speaker4();
	thread jumpers();
	thread music();
	
	thread runners();
	thread fighters();
	thread enemy_fighter();

	thread ai_guys("auto102");
	thread ai_guys("auto110");
	thread ai_guys("auto124");
	thread ai_guys("auto127");
	thread ai_guys("auto134");
	thread ai_guys("auto142");
	thread ai_guys("auto155");
	thread ai_guys("auto163");
	thread ai_guys("auto166");
	thread ai_guys("auto170");
	
	thread end_guys("auto314");

	maps\_utility::array_thread(getentarray( "no prone", "targetname" ), ::no_prone);

	level.ambient_track ["inside"] = "ambient_sewer_int";
	level.ambient_track ["outside"] = "ambient_sewer_ext";
	thread maps\_utility::set_ambient("inside");

}


no_prone ()
{
	while (1)
	{
		self waittill ("trigger");
		level.player allowProne (false);
		while (level.player istouching (self))
			wait (0.05);

		level.player allowProne (true);
	}
}

bobber()
{
	wait (randomfloat (1.5));
	org = self.origin;
	timer = 3;
	while (1)
	{
		self moveto (org + (0,0,1), timer, timer*0.5, timer*0.5);
		wait (timer);
		self moveto (org + (0,0,-1), timer, timer*0.5, timer*0.5);
		wait (timer);
	}
}

objectives()
{
	end_trigger = getent ("end_trigger", "targetname");

	objective_add(1, "active", &"SEWER_OBJ1", (6264, -4768, -104));
	objective_current(1);
	end_trigger waittill ("trigger");
	objective_state(1, "done");
	missionSuccess ("pavlov", true);
}

//GERMAN PA SOUNDS#############################

speaker1()
{
	trigger = getent ("speaker1_trigger", "targetname");
	speaker1 = getent ("speaker1", "targetname");

	trigger waittill ("trigger");

	speaker1 playsound("sewer_propaganda1","sounddone");
	speaker1 waittill ("sounddone");
}

speaker2()
{
	trigger = getent ("speaker2_trigger", "targetname");
	speaker2 = getent ("speaker2", "targetname");

	trigger waittill ("trigger");

	speaker2 playsound("sewer_propaganda2","sounddone");
	speaker2 waittill ("sounddone");
}

speaker3()
{
	trigger = getent ("speaker3_trigger", "targetname");
	speaker3 = getent ("speaker3", "targetname");

	trigger waittill ("trigger");

	speaker3 playsound("sewer_propaganda3","sounddone");
	speaker3 waittill ("sounddone");
}

speaker4()
{
	trigger = getent ("speaker4_trigger", "targetname");
	speaker4 = getent ("speaker4", "targetname");

	trigger waittill ("trigger");

	speaker4 playsound("sewer_propaganda4","sounddone");
	speaker4 waittill ("sounddone");
}

jumpers()
{
	trigger = getent ("jumptrig", "targetname");
	trigger waittill ("trigger");
	spawners = getentarray ("jumpers", "targetname");
        maps\_utility::array_levelthread(spawners,::jumpers_think);
}

jumpers_think(spawners)
{
	while (1)
	{
		spawners.count = 1;
		jumpers = spawners doSpawn();
		if (maps\_utility::spawn_failed(jumpers))
		{
			wait 1;
			continue;
		}
		jumpers.team = "neutral";
		jumpers.goalradius = 16;
		jumpers.useable = false;
		jumpers.dontavoidplayer = true;

		deletenode = getnode (jumpers.target, "targetname");
		jumpers setgoalnode (deletenode);

		jumpers waittill ("goal");
		jumpers delete();
	}
}


ai_guys(msg)
{
	spawners = getentarray (msg, "targetname");
        maps\_utility::array_levelthread(spawners,::ai_think);
}
ai_think(spawners)
{
	spawners waittill ("spawned",guys);

	guys.goalradius = 32;

//	guys.interval = 0;
	guys endon ("death");

//	wait (randomfloat (1));

	node = guys;

	while (isdefined (node.target))
	{
		node = getnode (node.target, "targetname");
		guys setgoalnode(node);
		guys waittill ("goal");
		wait 1+ randomfloat (2);
	}
	if (isdefined (node.radius))
		guys.goalradius = node.radius;
	else
		guys.goalradius = 512;
}

end_guys(msg)
{
	spawners = getentarray (msg, "targetname");
        maps\_utility::array_levelthread(spawners,::endguys_think);
}
endguys_think(spawners)
{
	spawners waittill ("spawned",guys);

	guys.goalradius = 32;

//	guys.interval = 0;
	guys endon ("death");

//	wait (randomfloat (1));

	node = guys;

	while (isdefined (node.target))
	{
		node = getnode (node.target, "targetname");
		guys setgoalnode(node);
		guys waittill ("goal");
		wait 3+ randomfloat (2);
	}
}

music()
{
	musicPlay("datestamp");
	wait 12;
	musicplay("redsquare_dark");

	while(1)
	{
		wait 80;
		musicplay("redsquare_dark");
	}
}

runners()
{
	spawners = getentarray ("runners", "targetname");
        maps\_utility::array_levelthread(spawners,::runners_think);
}

runners_think(spawners)
{
	spawners waittill ("spawned",runners);
	wait .5;
	
	runners.team = "neutral";
	runners.goalradius = 4;
	runners.interval = 128;
//	runners thread maps\_utility::magic_bullet_shield();
	runners endon ("death");

	firstnode = getnode (runners.target, "targetname");
	runners setgoalnode (firstnode);
	runners waittill ("goal");
	
//	runners.goalradius = 4;
	
	deletenode = getnode (firstnode.target, "targetname");
	runners setgoalnode (deletenode);
	
	runners waittill ("goal");
	runners delete();
}

fighters()
{
	spawners = getentarray ("fighters", "targetname");
        maps\_utility::array_levelthread(spawners,::fighters_think);
}
fighters_think(spawners)
{
	spawners waittill ("spawned",fighters);
	wait .5;
	fighters.goalradius = 4;
	fighters.interval = 64;
	fighters.accuracy = 1;
//	fighters thread maps\_utility::magic_bullet_shield();
	fighters endon ("death");
	
	firstnode = getnode (fighters.target, "targetname");
	fighters setgoalnode (firstnode);

//	fighters waittill ("goal");
	level waittill ("enemy died");
	
//	fighters.goalradius = 4;

	secondnode = getnode (firstnode.target, "targetname");
	fighters setgoalnode (secondnode);
	
	fighters waittill ("goal");
	wait 2+ randomfloat (1);
	
	deletenode = getnode (secondnode.target, "targetname");
	fighters setgoalnode (deletenode);
	
	fighters waittill ("goal");
	fighters delete();
}

enemy_fighter()
{
	spawner = getent ("fighter_target", "targetname");
	spawner waittill ("spawned",enemy);
	enemy.health = 1;
	enemy waittill ("death");
	level notify ("enemy died");
}