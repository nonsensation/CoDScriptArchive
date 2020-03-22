main()
{
	maps\_load::main();

	maps\trainstation_fx::main();
	maps\trainstation_anim::main();

	setCullFog(0, 7000, .47, .47, .48, 0);

	level.ambient_track ["inside"] = "ambient_trainstation_int";
	level.ambient_track ["outside"] = "ambient_trainstation_ext";
	thread maps\_utility::set_ambient("inside");

	thread objectives();
	thread musicloop();

//	thread ai_guys("auto21");
//	thread ai_guys("auto36");
//	thread ai_guys("auto47");
	thread ai_guys("auto606");
//	thread ai_guys("auto610");
	thread ai_guys("auto622");
//	thread ai_guys("auto669");
	thread ai_guys("auto675");
	thread ai_guys("auto697");
	thread ai_guys("auto1224");
	thread ai_guys("auto1253");
}

objectives()
{
	objective_add(1, "active", &"TRAINSTATION_OBJ1",(1804,22574,82));
	objective_current(1);
	end_trigger = getent ("end_trigger", "targetname");
	spawner = getent ("endguy", "script_noteworthy");
        spawner waittill ("spawned",endguy);
	endguy.animname = "endguy";             
	end_trigger waittill ("trigger");
	
	if (!maps\_utility::spawn_failed(endguy))
	{
		endguy maps\_anim::anim_single_solo_debug (endguy, "over here");

	}
	
	objective_state(1, "done");
	missionSuccess ("sewer", false);

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
}

musicloop()
{
	wait .5;
	musicplay("redsquare_dark");

	while(1)
	{
		wait 66;
		musicplay("redsquare_dark");
	}
}