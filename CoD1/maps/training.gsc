main()
{
	setCullFog (0, 11000, .42, .46, .50, 0 );
	maps\_load::main();
	maps\training_anim::main();

	musicplay("training_datestamp");

	level.player takeAllWeapons();

	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");

	precacheModel("xmodel/explosivepack");
	precacheModel("xmodel/character_moody");
	precacheModel("xmodel/head_moody");
	precacheModel("xmodel/character_elder");
	precacheModel("xmodel/head_elder");
	precacheModel("xmodel/character_foley");
	precacheModel("xmodel/head_foley");

	//level.ambient_track ["interior"] = "ambient_training";
	level.ambient_track ["exterior"] = "ambient_training";
	thread maps\_utility::set_ambient("exterior");

	thread foley();
	thread moody();
	thread elder();

	level.flags["signs"] = false;
	level.flags["compass"] = false;
	level.flags["got1carbine"] = false;
	level.flags["got2carbine"] = false;
	level.flags["carbine1"] = false;
	level.flags["carbine2"] = false;
	level.flags["nearsniper"] = false;
	level.flags["gotsniper"] = false;
	level.flags["sniper1"] = false;
	level.flags["sniper2"] = false;
	level.flags["nearsmg"] = false;
	level.flags["gotsmg"] = false;
	level.flags["smg1"] = false;
	level.flags["smg_ADShint"] = false;
	level.flags["switchedweapon"] = false;
	level.flags["smg2"] = false;
	level.flags["neargrenades"] = false;
	level.flags["gotgrenade"] = false;
	level.flags["threwgrenades"] = false;
	level.flags["athealth"] = false;
	level.flags["atbomb"] = false;
	level.flags["bomb_pickup"] = false;
	level.flags["bombplanted"] = false;
	level.flags["bombexploded"] = false;
	level.failing = false;

	level.starting_carbines = getentarray ("weapon_m1carbine", "classname");
	level.starting_smgs = getentarray ("weapon_thompson", "classname");
	level.starting_sniper_rifles = getentarray ("weapon_springfield", "classname");
	level.starting_grenades = getentarray ("weapon_fraggrenade", "classname");

	level.explo_fx = loadfx("fx/explosions/metal_b.efx");

	thread start();
	thread start_dialog();
	thread go_gate();
	thread obstacle_master();
	thread carbine_master();
	thread moody_dialog();
	thread sniper_rifle_master();
	thread smg_master();
	thread grenade_master();
	thread explosives_master();
	thread end_training();

	thread give_ammo();
	thread jumpers();
}



start()
{
	obj1 = getent ("obj1", "targetname");
	signs = getentarray ("sign", "targetname");
	level.remaining_signs = signs.size; //temp
//	obj_text = ("Read each sign. [" + signs.size + " remaining]");
	obj_text = &"TRAINING_OBJ1";
	objective_add(1, "active", "", (obj1.origin));
	objective_string(1,obj_text,signs.size);
	objective_current(1);
	
	obj2_trigger = getentarray ("obj2", "targetname");
	obj2_trigger = obj2_trigger[randomint (obj2_trigger.size)];
	objective_add(2, "active", &"TRAINING_OBJ2", (obj2_trigger.origin));
	
	level waittill ("finished intro screen");

	signs = getentarray ("sign", "targetname");
	for (i=0;i<signs.size;i++)
	{
		signs[i] thread sign_think();
	}

	level waittill ("objective1_complete");
	level.flags["signs"] = true;
	print ("z:          obj1 complete");
	objective_state(1, "done");
	objective_current(2);
	
	
	obj2_trigger waittill ("trigger");
	objective_state(2, "done");
	level.flags["compass"] = true;
	objective_current(3);
	level notify ("objective2_complete");
}

start_dialog()
{
	level waittill ("finished intro screen");
	wait .2;

	//anim_single (guy, anime, tag, node, tag_entity)
	level.foley thread maps\_anim::anim_single (level.foleyarray, "todayobstacle");
	level.foley playsound ("training_foley_start1", "sounddone");
	//"Private Martin, today you’ll be navigating the obstacle course and doing weapons training."

	level.foley waittill ("sounddone");

	wait 1;
	if (level.flags["signs"] == false)
	{
		level.foley thread maps\_anim::anim_single (level.foleyarray, "readsigns");
		level.foley playsound ("training_foley_start2", "sounddone");
		//"Before entering the obstacle course, read each of these important signs."
		iprintlnbold (&"TRAINING_FIVESIGNS");
		//Hint print: Use your mouse to look the four nearby signs.
		level.foley waittill ("sounddone");
	}
	println ("z:        here.");
	//thread move();
	
	if (level.flags["signs"] == false)
		level waittill ("objective1_complete");
	
	if (level.flags["compass"] == false)
	{	
		level.foley thread maps\_anim::anim_single (level.foleyarray, "nowcheck");
		level.foley playsound ("training_foley_move05", "sounddone");
		//That’s fine. Now check your objectives.
		//Hint print: Press your OBJECTIVES key (keybind) to view your objectives.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_OBJECTIVEKEY", getKeyBinding("+scores"));
		level.foley waittill ("sounddone");
	}

	if (level.flags["compass"] == false)
	{
		level.foley playsound ("training_foley_move06", "sounddone");
		level.foley animscripts\face::SaySpecificDialogue(level.scr_face["foley"]["readsigns"], undefined, "pain");
		//You’ll notice that your current objective is highlighted.
		level.foley waittill ("sounddone");
	}
	
	
	if (level.flags["compass"] == false)
	{
		level.foley playsound ("training_foley_move07", "sounddone");
		level.foley animscripts\face::SaySpecificDialogue(level.scr_face["foley"]["locationobjective"], undefined, "pain");
		//Also the location of your current objective is marked by the star on your compass.
		level.foley waittill ("sounddone");
	}
	
	
	if (level.flags["compass"] == false)
	{
		level.foley playsound ("training_foley_move08", "sounddone");
		level.foley animscripts\face::SaySpecificDialogue(level.scr_face["foley"]["approach"], undefined, "pain");
		//"As you approach your current objective, the star will move towards the center of the compass."
		level.foley waittill ("sounddone");
	}
	
	
	if (level.flags["compass"] == false)
	{
		level.foley playsound ("training_foley_move09", "sounddone");
		level.foley animscripts\face::SaySpecificDialogue(level.scr_face["foley"]["approachobjective"], undefined, "pain");
		//"Now, Approach your current objective."
		//iprintlnbold (&"TRAINING_FAROBJECTIVE");
		level.foley waittill ("sounddone");
	}
	
	if (level.flags["compass"] == false)
	{	
		wait 4;
	}
	
	if (level.flags["compass"] == false)
	{
		level.foley thread maps\_anim::anim_single (level.foleyarray, "stepleft");
		level.foley playsound ("training_foley_move01", "sounddone");
		//Now step five paces to the left.
		//Hint print: Press your STRAFE LEFT key (keybind) to move left.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_STRAFELEFT", getKeyBinding("+moveleft"));
	
		level.foley waittill ("sounddone");
	}
	if (level.flags["compass"] == false)
	{	
		wait 4;
	}	
	if (level.flags["compass"] == false)
	{
		level.foley thread maps\_anim::anim_single (level.foleyarray, "stepright");
		level.foley playsound ("training_foley_move02", "sounddone");
		//"Good, now Five paces to the right."
		//Hint print: Press your STRAFE RIGHT key (keybind) to move right.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_STRAFERIGHT", getKeyBinding("+moveright"));
	
		level.foley waittill ("sounddone");
	}
	if (level.flags["compass"] == false)
	{	
		wait 4;
	}	
	if (level.flags["compass"] == false)
	{	
		level.foley thread maps\_anim::anim_single (level.foleyarray, "forwards");
		level.foley playsound ("training_foley_move04", "sounddone");
		//Now five paces forwards.
		//Hint print: Press your MOVE FORWARD key (keybind) to move forwards.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_MOVEFORWARD", getKeyBinding("+forward"));
	
		level.foley waittill ("sounddone");
	}
	if (level.flags["compass"] == false)
	{	
		wait 4;
	}
	if (level.flags["compass"] == false)
	{	
		level.foley thread maps\_anim::anim_single (level.foleyarray, "backwards");
		level.foley playsound ("training_foley_move03", "sounddone");
		//Fine. Now five paces backwards.
		//Hint print: Press your MOVE BACK key (keybind) to move back.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_MOVEBACKWARD", getKeyBinding("+back"));
	
		level.foley waittill ("sounddone");
	}
	if (level.flags["compass"] == false)
	{	
		wait 4;
	}	
	if (level.flags["compass"] == false)
	{
		level.foley playsound ("training_foley_move09", "sounddone");
		level.foley animscripts\face::SaySpecificDialogue(level.scr_face["foley"]["approachobjective"], undefined, "pain");
		//"Now, Approach your current objective."
		//iprintlnbold (&"TRAINING_FAROBJECTIVE");
		level.foley waittill ("sounddone");
	}	
	
	
	if (level.flags["compass"] == false)
		level waittill ("objective2_complete");

	level.foley thread maps\_anim::anim_single (level.foleyarray, "checkedoff");
	level.foley playsound ("training_foley_move10", "sounddone");
	//Excellent. Now notice that objective is checked off and you have a new objective.
	//Hint print: Press your OBJECTIVES key (keybind) again to view your objectives.
	level.foley waittill ("sounddone");
	//wait 6;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_CHECKCURRENTOBJECTIVE", getKeyBinding("+scores"));

	level.foley thread maps\_anim::anim_single (level.foleyarray, "opengate");
	level.foley playsound ("training_foley_move11");
	//"Open the gate, Martin, and complete the obstacle course."
}



go_gate()
{
	start_gate_trigger = getent ("start_gate", "targetname");
	objective_add(3, "active", &"TRAINING_OBJ3", (start_gate_trigger.origin));
	start_gate_trigger thread maps\_utility::triggerOff();

	level waittill ("objective2_complete");

	start_gate_trigger thread maps\_utility::triggerOn();
	//start_gate_trigger setHintString ("Press [use] to open the gate.");

	start_gate_trigger waittill ("trigger");

	objective_state(3, "done");
	objective_current(4);
	start_gate_trigger thread gate_open();


	level.foley setgoalnode (getnode ("foley_node1", "targetname"));


	//ELDER GREETING
	level.started_run = false;
	level.elder animscripts\shared::lookatentity(level.player, 10, "casual");
	wait .2;

	level.elder animscripts\face::SaySpecificDialogue(level.scr_anim["elder"]["goodtosee"], "training_elder1", "pain", "dialog_done");
	//level.elder playsound ("training_elder1", "sounddone");
	level.elder waittill ("dialog_done");

	if (level.started_run != true)
	{
		level.elder animscripts\face::SaySpecificDialogue(level.scr_anim["elder"]["goodluck"], "training_elder2", "pain", "dialog_done");
		//level.elder playsound ("training_elder2", "sounddone");
		level.elder waittill ("dialog_done");
		level.elder animscripts\shared::lookatentity(level.foley, 3, "alert");
	}
	wait 1;
	level notify ("start_obstacle");
}

duckpipewait()
{
	duck_pipe_trigger = getent ("duck_pipes", "targetname");
	duck_pipe_trigger waittill ("trigger");
	level notify ("start_obstacle");
}

obstacle_master()
{

	obj3_trigger = getent ("obj3", "targetname");
	objective_add(4, "active", &"TRAINING_OBJ4", (obj3_trigger.origin));

	runners = getentarray ("runner", "targetname");
	for (i=0;i<runners.size;i++)
	{
		runners[i] setgoalpos (runners[i].origin);
	}
	thread duckpipewait();

	level waittill ("start_obstacle");

	level.started_run = true;

	//start_gate_trigger = getent ("start_gate", "targetname");
	//start_gate_trigger waittill ("trigger");

	level.foley notify ("look_at_all");

	level.foley thread maps\_anim::anim_single (level.foleyarray, "letsmove");
	level.foley playsound ("training_foley_obstacle01");
	//"Lets move gentlemen, this is not social function!"

	//Hint print: Hold down your CROUCH key (keybind) to crouch.
	if (level.player getstance() == "stand")
		thread hint_stand2crouch();
	if (level.player getstance() == "prone")
		thread hint_prone2crouch();

	for (i=0;i<runners.size;i++)
	{
		runners[i] thread run();
	}

	//level.foley waittill ("sounddone");
	//level.foley thread maps\_anim::anim_single (level.foleyarray, "crouchthru");
	//level.foley playsound ("training_foley_obstacle02");
	//Crouch through those concrete pipes and under that barrier. Move it Elder!

	jump_fence_trigger = getent ("jump_fence", "targetname");
	jump_fence_trigger waittill ("trigger");

	level.foley thread maps\_anim::anim_single (level.foleyarray, "nowjump");
	level.foley playsound ("training_foley_obstacle03");
	//Now jump over these barriers. Come on Elder.

	if (level.player getstance() == "crouch")
		thread hint_crouch2stand();
	if (level.player getstance() == "prone")
		thread hint_prone2stand();

	thread hint_jump();

      	prone_wire_trigger = getent ("prone_wire", "targetname");
	prone_wire_trigger waittill ("trigger");

	level.foley playsound ("training_foley_obstacle04");
	//Fine. Now drop to prone and crawl under this barbed wire.

	if (level.player getstance() == "crouch")
		thread hint_crouch2prone();
	if (level.player getstance() == "stand")
		thread hint_stand2prone();

      	prone_mgs_trigger = getent ("prone_mgs", "targetname");
	prone_mgs_trigger waittill ("trigger");


	level.foley setgoalnode (getnode ("foley_node2", "targetname"));

	level.foley playsound ("training_foley_obstacle05", "sounddone");
	//"Sgt, fire those machine guns."
	level.foley waittill ("sounddone");

	level.mg42_firing = true;
	mg42 = getent ("mg42", "targetname");
	mg42 thread mg42();

	wait 1;

	level.foley playsound ("training_foley_obstacle06", "sounddone");
	//Those are live rounds boys! Stay low!
	//wait 1;

	level.foley waittill ("sounddone");

	wait 1;

	level.foley playsound ("training_foley_obstacle07");
	//Stay low!
	//wait 1;

	ladder_trigger = getent ("ladder", "targetname");
	ladder_trigger waittill ("trigger");


	level.foley setgoalnode (getnode ("foley_node3", "targetname"));

	level.mg42_firing = false;

	if (level.player getstance() == "crouch")
		thread hint_crouch2stand();
	if (level.player getstance() == "prone")
		thread hint_prone2stand();

	level.foley playsound ("training_foley_obstacle08");
	//"Climb these ladders, Privates! Lets go! Lets go!"
	iprintlnbold (&"TRAINING_CLIMBLADDER");

	obj3_trigger = getent ("obj3", "targetname");
	obj3_trigger waittill ("trigger");

	objective_state(4, "done");
	objective_current(5);

	level.foley playsound ("training_foley_obstacle09");
	level.foley maps\_anim::anim_single (level.foleyarray, "gothrudoor");
	level.foley maps\_anim::anim_single (level.foleyarray, "ladiesstay");
	//"Private Martin, go through that door. Sgt Moody is going to take through Weapons training."
}


carbine_master()
{
	carbine_obj = getent ("carbine_obj", "targetname");
	objective_add(5, "active", &"TRAINING_OBJ5", (carbine_obj.origin));

	gate_sniper = getent ("gate_sniper", "targetname");
	gate_sniper thread maps\_utility::triggerOff();

	moody_tower_trigger = getent ("moody_tower", "targetname");
	moody_tower_trigger waittill ("trigger");

	thread close_door();
	while (1)
	{
		carbines = getentarray ("weapon_m1carbine", "classname");
		if (carbines.size < level.starting_carbines.size)
			break;
		wait .1;
	}
	level notify ("got1carbine");
	level.flags["got1carbine"] = true;
	maps\_utility::autosave(1);
	println ("z:        got1carbine");

	while (1)
	{
		carbines = getentarray ("weapon_m1carbine", "classname");
		if (carbines.size == 0)
			break;
		wait .1;
	}
	level notify ("got2carbine");
	level.flags["got2carbine"] = true;
	println ("z:        got2carbine");
	
	
	carbine_target = getent ("carbine_target", "targetname");
	thread target_counter(carbine_target, 6, "carbine1", false);
	
	level waittill ("carbine1");
	level.flags["carbine1"] = true;
	println ("z:       carbine1");
		
	thread target_counter(carbine_target, 6, "carbine2", false);
	level waittill ("carbine2");
	level.flags["carbine2"] = true;
	println ("z:        carbine2");

	objective_state(5, "done");
	objective_current(6);

	gate_sniper thread maps\_utility::triggerOn();
	//gate_sniper setHintString ("Press [use] to open the gate.");

	gate_sniper waittill ("trigger");

	level.moody setgoalnode (getnode ("moody_node1", "targetname"));

	gate_sniper thread gate_open();
}

sniper_rifle_master()
{
	sniper_obj = getent ("sniper_obj", "targetname");
	objective_add(6, "active", &"TRAINING_OBJ6", (sniper_obj.origin));

	gate_smg = getent ("gate_smg", "targetname");
	gate_smg thread maps\_utility::triggerOff();

	moody_sniper = getent ("moody_sniper", "targetname");
	moody_sniper waittill ("trigger");


	level.flags["nearsniper"] = true;
	level notify ("nearsniper");
	println ("z:        nearsniper");

	while (1)
	{
		sniper_rifles = getentarray ("weapon_springfield", "classname");
		if (sniper_rifles.size < level.starting_sniper_rifles.size)
		{
			//maps\_utility::keyHintPrint(&"SCRIPT_HINT_SWITCHTOSECONDWEAPON", getKeyBinding("weaponslot primaryb"));
			break;
		}
		wait 2;
	}
	level notify ("gotsniper");
	level.flags["gotsniper"] = true;
	println ("z:        gotsniper");

	sniper_target = getent ("sniper_target", "targetname");
	thread target_counter(sniper_target, 2, "sniper1", true);
	
	level waittill ("sniper1");
	level.flags["sniper1"] = true;
	println ("z:        sniper1");

	thread target_counter(sniper_target, 2, "sniper2", true);
	iprintlnbold (&"TRAINING_FARTARGETWICEAGAIN");

	level waittill ("sniper2");
	level.flags["sniper2"] = true;
	println ("z:        sniper2");
	objective_state(6, "done");
	objective_current(7);

	gate_smg thread maps\_utility::triggerOn();
	//gate_smg setHintString ("Press [use] to open the gate.");

	gate_smg waittill ("trigger");

	level.moody setgoalnode (getnode ("moody_node2", "targetname"));

	gate_smg thread gate_open();
}

smg_master()
{
	smg_obj = getent ("smg_obj", "targetname");
	objective_add(7, "active",&"TRAINING_OBJ7", (smg_obj.origin));
	objective_add(8, "active",&"TRAINING_OBJ7B", (smg_obj.origin));

	gate_finish_smg = getent ("gate_finish_smg", "targetname");
	gate_finish_smg thread maps\_utility::triggerOff();

	moody_smg = getent ("moody_smg", "targetname");
	moody_smg waittill ("trigger");

	level.flags["nearsmg"] = true;
	level notify ("nearsmg");

	while (1)
	{
		smgs = getentarray ("weapon_thompson", "classname");
		if (smgs.size < level.starting_smgs.size)
			break;
		wait 2;
	}
	level.flags["gotsmg"] = true;
	level notify ("gotsmg");

	smg_target = getent ("smg_target", "targetname");
	thread target_counter(smg_target, 10, "smg1", false);

	if (level.flags["smg1"] != true)
		level waittill ("smg1");

	objective_state(7, "done");
	objective_current(8);
	
	while (1)
	{
		current = level.player getCurrentWeapon();
		println ("z:      current weapon: ", current);
		if (current != "thompson")
			break;
		wait 2;
	}
	level.flags["switchedweapon"] = true;
	level notify ("switchedweapon");

	thread target_counter(smg_target, 3, "smg2", false);
	
	if (level.flags["smg2"] != true)
		level waittill ("smg2");

	objective_state(8, "done");
	objective_current(9);

	gate_finish_smg thread maps\_utility::triggerOn();
	//gate_finish_smg setHintString ("Press [use] to open the gate.");

	gate_finish_smg waittill ("trigger");

	gate_finish_smg thread gate_open();
}


grenade_master()
{
	//moody_grenade = getent ("moody_grenade", "targetname");
	objective_add(9, "active", &"TRAINING_OBJ8", (level.starting_grenades[0].origin));

	grenade_gate = getent ("grenade_gate", "targetname");
	grenade_gate thread maps\_utility::triggerOff();

	moody_grenade = getent ("moody_grenade", "targetname");
	moody_grenade waittill ("trigger");

	level.flags["neargrenades"] = true;
	level notify ("neargrenades");

	while (1)
	{
		grenades = getentarray ("weapon_fraggrenade", "classname");
		if (grenades.size < level.starting_grenades.size)
		{
			break;
		}
		wait 2;
	}
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_TRAINING_SWITCHTOGRENADE", getKeyBinding("weaponslot grenade"));
	level.flags["gotgrenade"] = true;
	level notify ("gotgrenade");

	grenade_targets = getentarray ("grenade_target", "targetname");
	for (i=0;i<grenade_targets.size;i++)
	{
		grenade_targets[i] thread grenade_waittill();
	}
	//hint

	level waittill ("grenade");
	level waittill ("grenade");
	level waittill ("grenade");
	level.flags["threwgrenades"] = true;
	level notify ("threwgrenades");

	objective_state(9, "done");
	objective_current(10);

	grenade_gate thread maps\_utility::triggerOn();
	//grenade_gate setHintString ("Press [use] to open the gate.");

	grenade_gate waittill ("trigger");

	grenade_gate thread gate_open();
}


explosives_master()
{
	bomb_table_trigger = getent ("bomb_table_trigger", "targetname");
	objective_add(10, "active", &"TRAINING_OBJ9", (bomb_table_trigger.origin));

	last_gate = getent ("last_gate", "targetname");
	last_gate thread maps\_utility::triggerOff();

	wall_broken = getent ("wall_broken", "targetname");
	wall_broken hide();
	wall_broken notsolid();

	bomb_table_trigger = getent ("bomb_table_trigger", "targetname");
	bomb_on_table = getent (bomb_table_trigger.target, "targetname");
	bomb_table_trigger maps\_utility::triggerOff();

	bomb_wall_trigger = getent ("bomb_wall_trigger", "targetname");
	bomb_wall_trigger.bomb = getent (bomb_wall_trigger.target, "targetname");
	//bomb_wall_trigger maps\_utility::triggerOff();
	//bomb_wall_trigger.bomb hide();
	bomb_wall_trigger setHintString (&"TRAINING_NO_EXPLOSIVES");

	moody_health = getent ("moody_health", "targetname");
	moody_health waittill ("trigger");
	
	level.flags["athealth"] = true;
	level notify ("athealth");
	maps\_utility::autosave(2);

	moody_explo = getent ("moody_explo", "targetname");
	moody_explo waittill ("trigger");
	
	level.flags["atbomb"] = true;
	level notify ("atbomb");
	thread bomb_pickup();
	level.moody setgoalnode (getnode ("moody_node3", "targetname"));

	if (level.flags["bomb_pickup"] != true)
		level waittill ("bomb_pickup");
	//bomb_wall_trigger setHintString (&"TRAINING_WAIT_INSTRUCTIONS");
	//bomb_wall_trigger.bomb show();
	//bomb_wall_trigger maps\_utility::triggerOn();
	bomb_wall_trigger setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	
	bomb_wall_trigger waittill ("trigger");
	
	level.flags["bombplanted"] = true;
	level notify ("bombplanted");
	bomb_wall_trigger thread bomb_think();

	level waittill ("bomb_exploded");
	
	level.flags["bombexploded"] = true;
	level notify ("activate_end");

	objective_state(10, "done");
	objective_current(11);


	last_gate thread maps\_utility::triggerOn();
	//last_gate setHintString ("Press [use] to open the gate.");

	last_gate waittill ("trigger");

	last_gate thread gate_open();
}

end_training()
{
	end_training = getent ("end_training", "targetname");
	objective_add(11, "active", "TRAINING_OBJ10", (end_training.origin));

	level waittill ("activate_end");

	end_training waittill ("trigger");
	if (level.failing != true)
	{
		objective_state(11, "done");
		missionsuccess ("us_intro", false);
	}
}

moody_dialog()
{
	moody_tower_trigger = getent ("moody_tower", "targetname");
	moody_tower_trigger waittill ("trigger");
	
	level.moody thread maps\_anim::anim_single (level.moodyarray, "eyesup");
	//level.moody animscripts\face::SaySpecificDialogue(facialanim, soundAlias, importance, notifyString);
	level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine01", "pain", "dialog_done");
	//level.moody playsound ("training_moody_carbine01", "dialog_done");
	//Private. You should be able to see me in this observation tower. Good.
	level.moody waittill ("dialog_done");
	
	if (level.flags["got1carbine"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk1");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine02", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine02", "dialog_done");
		//Pick up one of those M1A1 Carbines on the table Private.
		thread hint_pickup_weapons();
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["got1carbine"] == false)
		level waittill ("got1carbine");
	
	if (level.flags["got2carbine"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk2");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine09", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine09", "dialog_done");
		//You can get more ammo for your weapon by picking up more weapons of the same type.
		thread hint_pickup_ammo();
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["got2carbine"] == false)
	{	
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk4");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine08", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine08", "dialog_done");
		//The number of rounds in your weapon and the number of rounds you are carrying
		//are displayed in the lower right corner of your hud.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["got2carbine"] == false)
		level waittill ("got2carbine");
	
	if (level.flags["carbine1"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk7");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine03", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine03", "dialog_done");
		//Hit the target with the Carbine 6 times.
		iprintlnbold (&"TRAINING_TARGETSIX");
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["carbine1"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine04", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine04", "dialog_done");
		//Notice that your accuracy is defined by the inside circle of the crosshair.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["carbine1"] == false)
		level waittill ("carbine1");

	
	if (level.flags["carbine2"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk3");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine06", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine06", "dialog_done");
		//"Now hit the target 6 more times while in different stances, and while moving."
		iprintlnbold (&"TRAINING_TARGETSIX");
		level.moody waittill ("dialog_done");
	}

	if (level.flags["carbine2"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk9");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine05", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine05", "dialog_done");
		//"You are more accurate crouching or prone, and while not moving."
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["carbine2"] == false)
	{
		wait 1;
	}
	
	if (level.flags["carbine2"] == false)
	{		
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk5");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine07", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine07", "dialog_done");
		//Notice you automatically reload after empting your weapon.
		binding = getKeyBinding("+reload");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_RELOAD", binding);
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["carbine2"] == false)
		level waittill ("carbine2");


	if (level.flags["gotsniper"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk6");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_carbine10", "pain", "dialog_done");
		//level.moody playsound ("training_moody_carbine10");
		//Alright Private. Move on to the next area.	
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["nearsniper"] == false)
		level waittill ("nearsniper");
	
	if (level.flags["gotsniper"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk2");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["grabspringfield"], "training_moody_sniper01", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper01", "dialog_done");
		//Pick up one of the Springfield rifles on the table.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["gotsniper"] == false)
		level waittill ("gotsniper");
	
	if (level.flags["sniper1"] == false)
	{	
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["turntoleft"], "training_moody_sniper02", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper02");
		//Hit the target twice with your rifle.
		iprintlnbold (&"TRAINING_FARTARGET");
		level.moody waittill ("dialog_done");
	}

/*	
	if (level.flags["sniper1"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk7");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["nowADS"], "training_moody_sniper03", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper03", "dialog_done");
		//Fine. Now aim down the sight.
		level.moody waittill ("dialog_done");
	}
*/	
	
	if (level.flags["sniper1"] == false)
		level waittill ("sniper1");
	
	if (level.flags["sniper2"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk4");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["twomorerounds"], "training_moody_sniper06", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper06");
		//Now hit the target twice while aiming down the sight.
		thread hint_ADS();
		level.moody waittill ("dialog_done");
	}


/*	
	if (level.flags["sniper2"] == false)
	{	
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk5");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["youcandobusiness"], "training_moody_sniper04", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper04", "dialog_done");
		//Note that aiming down the sight of scoped weapons means looking through the scope.
		level.moody waittill ("dialog_done");
	}
*/	
	
	if (level.flags["sniper2"] == false)
		level waittill ("sniper2");
	
	if (level.flags["gotsmg"] == false)
	{		
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["moreaccurateADS"], "training_moody_sniper07", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper07", "dialog_done");
		//Good. Notice you are more accurate while aiming down the sight.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["gotsmg"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk9");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["moveon"], "training_moody_sniper08", "pain", "dialog_done");
		//level.moody playsound ("training_moody_sniper08");
		//Alright Private. Lets move on to the next area.
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["nearsmg"] == false)
		level waittill ("nearsmg");

	if (level.flags["gotsmg"] == false)
	{		
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk1");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["exchangespringfield"], "training_moody_smg01", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg01", "dialog_done");
		//"Grab one of the Thompson Submachine Guns, Private."
		thread hint_swap_weapons();
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["gotsmg"] == false)
		level waittill ("gotsmg");
	
	level.moody thread maps\_anim::anim_single (level.moodyarray, "talk3");
	level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["unlessyouvegot"], "training_moody_smg02", "pain", "dialog_done");
	//level.moody playsound ("training_moody_smg02", "dialog_done");
	//Note that you swapped your current weapon for the Thompson.
	//You can only carry two weapons besides a pistol and grenades.
	level.moody waittill ("dialog_done");
	
	if (level.flags["smg1"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk5");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["movetothefence"], "training_moody_smg05", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg05", "dialog_done");
		//Hit the target 10 times with your Thompson Private.
		//Compare your accuracy when aiming down the sight and when firing from the hip.
		iprintlnbold (&"TRAINING_TARGETTEN");
		thread hint_ADS(3);
		level.flags["smg_ADShint"] = true;
		level.moody waittill ("dialog_done");
	}
/*		
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk7");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_smg03", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg03", "dialog_done");
		//"Try aiming down the sight with the Thompson, Private."
		level.moody waittill ("dialog_done");
*/
	if (level.flags["smg1"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["youwillnotice"], "training_moody_smg04", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg04", "dialog_done");
		//You get a slight zoom effect when you aim down the sight with weapons that don’t have scopes.
		if (level.flags["smg_ADShint"] == false)
		{
			thread hint_ADS();
			level.flags["smg_ADShint"] = true;
		}	
		level.moody waittill ("dialog_done");
	}

	if (level.flags["smg1"] != true)
		level waittill ("smg1");
		
	level.moody thread maps\_anim::anim_single (level.moodyarray, "talk6");
	level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["moveslower"], "training_moody_sniper05", "pain", "dialog_done");
	//level.moody playsound ("training_moody_sniper05", "dialog_done");
	//Take a few steps while aiming down the sight. Notice that you move slower.
	if (level.flags["smg_ADShint"] == false)
	{
		thread hint_ADS();
		level.flags["smg_ADShint"] = true;
	}
	level.moody waittill ("dialog_done");
	
	wait 2;
		
	level.moody thread maps\_anim::anim_single (level.moodyarray, "talk3");
	level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["inclosequarters"], "training_moody_smg06", "pain", "dialog_done");
	//level.moody playsound ("training_moody_smg06", "dialog_done");
	//In close combat you can smack enemies with any of your weapons. Try your melee attack with the Thompson.
	thread hint_melee();
	level.moody waittill ("dialog_done");
	
	
	if (level.flags["switchedweapon"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk4");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["switchweapons"], "training_moody_smg07", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg07");
		//Now switch to your other weapon.
		thread hint_switch_weapons();
		level.moody waittill ("dialog_done");
	}	
	
	if (level.flags["switchedweapon"] != true)
		level waittill ("switchedweapon");
		
		
	if (level.flags["smg2"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk9");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["fire3more"], "training_moody_smg08", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg08", "dialog_done");
		//Hit the target 3 times with this weapon Private. Note that each weapon is good for different situations.
		iprintlnbold (&"TRAINING_TARGETTHREE");
		//hint
		level.moody waittill ("dialog_done");
	}

	if (level.flags["smg2"] != true)
		level waittill ("smg2");

	if (level.flags["gotgrenade"] == false)
	{		
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk1");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["outstanding"], "training_moody_smg09", "pain", "dialog_done");
		//level.moody playsound ("training_moody_smg09");
		//That’s good Private. Move on to the next area.
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["neargrenades"] != true)
		level waittill ("neargrenades");
	
	if (level.flags["gotgrenade"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk2");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["pickupgrenades"], "training_moody_grenade01", "pain", "dialog_done");
		//level.moody playsound ("training_moody_grenade01", "dialog_done");
		//"Martin, pick up some of those frag grenades on the table."
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["gotgrenade"] == false)
		level waittill ("gotgrenade");

	if (level.flags["threwgrenades"] == false)
	{	
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk3");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["throwgrenade"], "training_moody_grenade04", "pain", "dialog_done");
		//level.moody playsound ("training_moody_grenade04");
		//Now throw a grenade into each of those openings.
		iprintlnbold (&"TRAINING_GRENADEDOORWINDOW");
		level.moody waittill ("dialog_done");
	}

	if (level.flags["threwgrenades"] == false)
	{	
		wait 2;
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk7");
		level.moody animscripts\face::SaySpecificDialogue(undefined, "training_moody_grenade02", "pain", "dialog_done");
		//level.moody playsound ("training_moody_grenade02", "dialog_done");
		//Try standing behind the concrete post and lean out to the left and right.
		thread hint_lean();
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["threwgrenades"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["movebehind"], "training_moody_grenade03", "pain", "dialog_done");
		//level.moody playsound ("training_moody_grenade03", "dialog_done");
		//Leaning can help protect you from the enemy.
		level.moody waittill ("dialog_done");
	}

	if (level.flags["threwgrenades"] == false)
		level waittill ("threwgrenades");


	if (level.flags["athealth"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk4");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["moveon"], "training_moody_grenade05", "pain", "dialog_done");
		//level.moody playsound ("training_moody_grenade05");
		//Fine. Now move on to the next area.
		level.moody waittill ("dialog_done");
	}
	
	
	if (level.flags["athealth"] == false)
		level waittill ("athealth");
	
	if (level.flags["atbomb"] == false)
	{
		if (getcvarint("g_gameskill") != 3)
		{
			level.moody thread maps\_anim::anim_single (level.moodyarray, "talk5");
			level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["ifugethurt"], "training_moody_health01", "pain", "dialog_done");
			//level.moody playsound ("training_moody_health01", "dialog_done");
			//Private if you are hurt pick up one of those health kits.
			level.moody waittill ("dialog_done");
		}
	}
	
	if (level.flags["bomb_pickup"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk6");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["laststation"], "training_moody_explosives01", "pain", "dialog_done");
		//level.moody playsound ("training_moody_explosives01", "dialog_done");
		//Our last station is explosives.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["atbomb"] == false)
		level waittill ("atbomb");
	
	if (level.flags["bomb_pickup"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk9");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["pickemup"], "training_moody_explosives02a", "pain", "dialog_done");
		//level.moody playsound ("training_moody_explosives02a", "dialog_done");
		//"Pick up the explosives."
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["bomb_pickup"] == false)	
		level waittill ("bomb_pickup");

	if (level.flags["bombplanted"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk8");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["lotoffire"], "training_moody_explosives02b", "pain", "dialog_done");
		//level.moody playsound ("training_moody_explosives02b", "dialog_done");
		//"Feels good, doesn’t it?"
		level.moody waittill ("dialog_done");
	}
	//level.moody playsound ("training_moody_explosives03", "dialog_done");
	//Notice that a picture of the explosives has appeared in the upper right corner of your HUD.
	//level.moody waittill ("dialog_done");


	if (level.flags["bombplanted"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk7");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["explosives"], "training_moody_explosives04", "pain", "dialog_done");
		//level.moody playsound ("training_moody_explosives04", "dialog_done");
		//Now place the explosives on the cinder block wall.
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_USECINDERBLOCKWALL", getKeyBinding("+activate"));
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["bombplanted"] == false)
		level waittill ("bombplanted");
	
	if (level.flags["bombexploded"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk4");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["notestopwatch"], "training_moody_explosives05", "pain", "dialog_done");
		//level.moody playsound ("training_moody_explosives05", "dialog_done");
		//Notice that a stop watch has appeared. This will tell you how soon the explosives are going off. Stand well back.
		level.moody waittill ("dialog_done");
	}
	
	if (level.flags["bombexploded"] == false)
	{
		level.moody thread maps\_anim::anim_single (level.moodyarray, "talk2");
		level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["fireinthehole"], "training_moody_explosives06", "pain","dialog_done");
		//level.moody playsound ("training_moody_explosives06");
		//"fire in the hole!"
		level.moody waittill ("dialog_done");
	}
		
	if (level.flags["bombexploded"] == false)
		level waittill ("bomb_exploded");
	
	wait 3;
	
	level.moody thread maps\_anim::anim_single (level.moodyarray, "talk1");
	level.moody animscripts\face::SaySpecificDialogue(level.scr_anim["moody"]["goodjob"], "training_moody_explosives07", "pain");
	//level.moody playsound ("training_moody_explosives07");
	//You are dismissed Private. Well done.
	iprintlnbold (&"TRAINING_LASTGATE");
	iprintlnbold (&"TRAINING_BACKTRACK");
}





/////////////////////////////////
hint_stand2crouch()
{
	binding = getKeyBinding("gocrouch");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
	else
	{
		binding = getKeyBinding("togglecrouch");
		if(binding["count"])
		{
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHTOGGLEFROM", binding);
		}
		else
		{
			binding = getKeyBinding("+movedown");
			if(binding["count"])
			{
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNCROUCHKEY", binding);
			}
			else
			{
				binding = getKeyBinding("lowerstance");
				if(binding["count"])
				{
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
				}
			}
		}
	}

}

hint_prone2crouch()
{
	binding = getKeyBinding("gocrouch");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
	else
	{
		binding = getKeyBinding("togglecrouch");
		if(binding["count"])
		{
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
			iprintlnbold(&"SCRIPT_HINT_CROUCHTOGGLEFROM");
		}
		else
		{
			binding = getKeyBinding("+movedown");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNCROUCHKEY", binding);
			else
			{
				binding = getKeyBinding("raisestance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMPRONETOCROUCH", binding);
				else
				{
					binding = getKeyBinding("+moveup");
					if(binding["count"])
						maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMPRONETOCROUCH", binding);
				}
			}
		}
	}
}

hint_crouch2stand()
{
	binding = getKeyBinding("+gostand");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDKEY", binding);
	else
	{
		binding = getKeyBinding("+movedown");
		if(binding["count"])
		{
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDLETGOCROUCHKEY", binding);

			binding = getKeyBinding("+moveup");
//			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDLETGOSECONDKEY", binding);
		}
		else
		{
			binding = getKeyBinding("togglecrouch");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDFROMCROUCHKEY", binding);
			else
			{
				binding = getKeyBinding("raisestance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMCROUCHTOSTAND", binding);
				else
				{
					binding = getKeyBinding("+moveup");
					if(binding["count"])
						maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMCROUCHTOSTAND", binding);
				}
			}
		}
	}
}

hint_prone2stand()
{
	binding = getKeyBinding("+gostand");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDKEY", binding);
	else
	{
		binding = getKeyBinding("+prone");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDLETGOPRONEKEY", binding);
		else
		{
			binding = getKeyBinding("toggleprone");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_STANDFROMPRONEKEY", binding);
			else
			{
				binding = getKeyBinding("raisestance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_DOUBLETAPSTANDKEY", binding);
				else
				{
					binding = getKeyBinding("+moveup");
					if(binding["count"])
						maps\_utility::keyHintPrint(&"SCRIPT_HINT_DOUBLETAPSTANDKEY", binding);
				}
			}
		}
	}
}

hint_crouch2prone()
{
	binding = getKeyBinding("goprone");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_PRONEKEY", binding);
	else
	{
		binding = getKeyBinding("+prone");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNPRONEKEY", binding);
		else
		{
			binding = getKeyBinding("toggleprone");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_PRONEKEY", binding);
			else
			{
				binding = getKeyBinding("lowerstance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_PRONEKEY", binding);
			}
		}
	}
}

hint_stand2prone()
{
	binding = getKeyBinding("goprone");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_PRONEKEY", binding);
	else
	{
		binding = getKeyBinding("+prone");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNPRONEKEY", binding);
		else
		{
			binding = getKeyBinding("toggleprone");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_PRONEKEY", binding);
			else
			{
				binding = getKeyBinding("lowerstance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_DOUBLETAPPRONEKEY", binding);
			}
		}
	}
}


hint_ADS(delay)
{
	if (isdefined (delay))
		wait delay;
		
	binding = getKeyBinding("toggle cl_run");
	if(binding["count"])
	{
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_ADSKEY", binding);
		wait 3;
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_ADSSTOP", binding);
	}
	else
	{
		binding = getKeyBinding("+speed");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNADSKEY", binding);
	}
}



hint_melee()
{
	wait 4;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_MELEEATTACK", getKeyBinding("+melee"));
}


hint_switch_weapons()
{
	wait 4;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_FIRSTWEAPONKEY", getKeyBinding("weaponslot primary"));
	wait 1;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_SECONDWEAPONKEY", getKeyBinding("weaponslot primaryb"));
}


hint_swap_weapons()
{
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_SWAPWEAPONSKEY", getKeyBinding("+activate"));
}

hint_pickup_weapons()
{
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_PICKUPWEAPONKEY", getKeyBinding("+activate"));
}

hint_pickup_ammo()
{
	iprintlnbold (&"TRAINING_PICKUP_CARBINE");
	wait 2;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_PICKUPAMMOKEY", getKeyBinding("+activate"));
}

hint_jump()
{
	binding = getKeyBinding("+gostand");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_JUMPSTANDKEY", binding);
	else
	{
		binding = getKeyBinding("+moveup");
		if(binding["count"])
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_JUMPSTANDKEY", binding);
	}
}

hint_lean()
{
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_LEANLEFTKEY", getKeyBinding("+leanleft"));
	wait 5;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_LEANRIGHTKEY", getKeyBinding("+leanright"));
	//iprintlnbold (&"SCRIPT_HINT_LEANINGSLOWMOVE");
}

///////////////////////////
target_counter(target, hits, flag, beep)
{
	for (i=0;i<hits;i++)
	{
		target waittill ("trigger");
		//if (beep == true)
			level.player playsound ("training_good_grenade_throw");
	}
	level notify (flag);
	level.flags[flag] = true;
}


gate_open()
{
	self thread maps\_utility::triggerOff();

	right = getent (self.target, "targetname");
	left = getent (right.target, "targetname");

	left playsound ("gate_open");
	right playsound ("gate_open");

	left rotateyaw(90, 1,.3,0);
	right rotateyaw(-90, 1,.3,0);
}

grenade_waittill()
{
	self waittill ("trigger");

	level notify ("grenade");

	wait 1;

	level.player playsound ("training_good_grenade_throw");
}

bomb_think()
{
	iprintlnbold (&"TRAINING_EXPLOSIVESPLANTED");
	self.bomb setModel("xmodel/explosivepack");
	self.bomb playsound ("explo_plant_rand");
	self maps\_utility::triggerOff();

//	hdSinglePlayerTimer(level.player, getTime()+(10*1000)); //5 second stop watch timer
	stopwatch = newHudElem();
	stopwatch.x = 36;
	stopwatch.y = 240;
	stopwatch.alignX = "center";
	stopwatch.alignY = "middle";
	stopwatch setClock(10, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
	wait 10;
	stopwatch destroy();

	//BEGIN EXPLOSION
	self.bomb playsound ("explo_rock");

	radiusDamage (self.bomb.origin, 450, 2000, 400);

	earthquake(0.25, 3, self.bomb.origin, 1050);

	playfx (level.explo_fx, self.bomb.origin );

	level notify ("bomb_exploded");

	//WAIT .3 BEFORE MODEL SWAP
	wait (0.3);

	self.bomb hide();
	wall_broken = getent ("wall_broken", "targetname");
	wall_broken show();
	wall_whole = getent ("wall_whole", "targetname");
	wall_whole hide();
}


sign_think()
{
	self waittill ("trigger");
	level.remaining_signs --;
//	obj_text = ("Read each sign. [" + level.remaining_signs + " remaining]");
	obj_text = &"TRAINING_OBJ1";

	objective_string(1, obj_text,level.remaining_signs);
	level.player playsound ("training_good_grenade_throw");

	if (level.remaining_signs == 0)
		level notify ("objective1_complete");
}

foley()
{
	level.foley = getent ("foley", "targetname");
	level.foley endon ("death");

	level.foley character\_utility::new();
	level.foley character\Foley::main();
	level.foley.script_friendname = "Cpt. Foley";
	level.foley.name = "Cpt. Foley";

	level.foley.hasweapon = false;
	level.foley animscripts\shared::PutGunInHand("none");

	level.foley thread maps\_utility::magic_bullet_shield();

	level.foleyarray[0] = level.foley;
	level.foley.animname = "foley";

	level.foley.walk_noncombatanim = level.scr_anim["foley"]["unarmedwalk"];
	level.foley.walk_noncombatanim2 = level.scr_anim["foley"]["unarmedwalk"];
	level.foley.run_noncombatanim = level.scr_anim["foley"]["unarmedrun"];
	level.foley.standanim = level.scr_anim["foley"]["breathing"][0];


	//CONTROL FOLEYS LOOK ATS
	level.foley animscripts\shared::lookatentity(level.player, 3600, "casual");

	level.foley waittill ("look_at_all");

	runners = getentarray ("runner", "targetname");
	while (1)
	{
		num = randomint (6);
		wait_time = (randomint(4)+1);
		if (num >= runners.size)
			level.foley animscripts\shared::lookatentity(level.player, wait_time, "alert");
		else
			level.foley animscripts\shared::lookatentity(runners[num], wait_time, "alert");
		wait wait_time;
	}
}

moody()
{
	level.moody = getent ("moody", "targetname");
	level.moody character\_utility::new();
	level.moody character\Moody_training::main();
	level.moody.script_friendname = "Sgt. Moody";
	level.moody.name = "Sgt. Moody";

	level.moody.hasweapon = false;
	level.moody animscripts\shared::PutGunInHand("none");

	level.moody thread maps\_utility::magic_bullet_shield();

	level.moodyarray[0] = level.moody;
	level.moody.animname = "moody";

	level.moody.walk_noncombatanim = level.scr_anim["foley"]["unarmedwalk"];
	level.moody.walk_noncombatanim2 = level.scr_anim["foley"]["unarmedwalk"];
	level.moody.run_noncombatanim = level.scr_anim["foley"]["unarmedrun"];
	level.moody.standanim = level.scr_anim["moody"]["breathing"][0];
 
	moody_damage_trigger = getent ("moody_damage", "targetname");
	if (isdefined (moody_damage_trigger))
	{
		moody_damage_trigger waittill ("trigger");
		
		//iprintlnbold(&"TRAINING_SHOT_MOODY");
		level.failing = true;
		wait 1;
		setCvar("ui_deadquote", "@TRAINING_SHOT_MOODY");
		missionfailed();
	}
}

elder()
{

	runners = getentarray ("runner", "targetname");
	for (i=0;i<runners.size;i++)
	{
		if (isdefined (runners[i].script_friendname) )
			if (runners[i].script_friendname == "Pvt. Elder")
				level.elder = runners[i];
	}

	level.elder character\_utility::new();
	level.elder character\Elder::main();
	level.elder.script_friendname = "Pvt. Elder";
	level.elder.name = "Pvt. Elder";

	level.elder.animname = "elder";
}

jumpers()
{
	node = getnode ("jumpnode", "targetname");

	maps\training_anim::jump_wire();
	wire = spawn ("script_model", node.origin);
	wire.angles = node.angles;
	wire setmodel ("xmodel/training_jumprig_wire");
	wire.animname = "jump_wire";
	wire UseAnimTree(level.scr_animtree[wire.animname]);


	maps\training_anim::jump_gear();
	gear = spawn ("script_model", node.origin);
	gear.angles = node.angles;
	gear setmodel ("xmodel/training_jumprig_gear");
	gear.animname = "jump_gear";
	gear UseAnimTree(level.scr_animtree[gear.animname]);


	jumperSpawn = getent ("jumper", "targetname");
	jumperSpawn.animname = "jumper";
	jSpawner[0] = jumperSpawn;
	jSpawner[1] = gear;

	level endon ("weapons");
	
	disappear_node = getnode ("disappear_node", "targetname");

	while (1)
	{
		maps\_anim::anim_spawner_teleport (jSpawner, "training_jump", undefined, node);
		jumperSpawn.count = 1;
		jumper = jumperSpawn stalingradspawn ();
		jumper.animname = "jumper";
		jumper.hasweapon = false;
		jumper animscripts\shared::PutGunInHand("none");

		array[0] = jumper;
		array[1] = gear;
		array[2] = wire;

		gear playsound ("training_parachute_training");
		level thread maps\_anim::anim_single_solo (array[1], "training_jump", undefined, node);
		level thread maps\_anim::anim_single_solo (array[2], "training_jump", undefined, node);
		wait (0.05);
		maps\_anim::anim_single_solo (array[0], "training_jump", undefined, node);
		
		jumper.goalradius = 32;
		jumper setgoalnode (disappear_node);
		jumper waittill ("goal");
		
		jumper delete();
		wait (randomfloat (1));

	//	gear animscripted("jump", node.origin, node.angles, level.scr_anim["training_gear_practicejump"]["jump_gear"]);
	//	wire animscripted("jump", node.origin, node.angles, level.scr_anim["training_wire_practicejump"]["jump_wire"]);
	//	jumper animscripted("jump", node.origin, node.angles, level.scr_anim["training_guy_practicejump"]["jumper"]["animation"]);
	//	jumper waittill ("jump");
	}
}


run()
{
	self.interval = 0;
	self endon ("death");
	self.goalradius = 128;

	//if (isdefined (self.script_delay) )
	//	wait (self.script_delay);


	self allowedStances ("crouch");
	self.dontavoidplayer = true;

	wait (randomfloat (1));


	firstnode = getnode (self.target, "targetname");
	self setgoalnode (firstnode);

	self waittill ("goal");

	nextnode = getnode (firstnode.target, "targetname");
	if ( !(isdefined (nextnode) ) )
	{
		println ("runner ", self.origin, " has a run of one node");
		return;
	}

	while (isdefined (nextnode) && isalive (self) )
	{
		//println (self, nextnode);
		self setgoalnode(nextnode);
		self waittill ("goal");
		println (nextnode.targetname);
		if (nextnode.targetname == "prone1" || nextnode.targetname == "prone2" || nextnode.targetname == "prone3" || nextnode.targetname == "prone4")
			self allowedStances ("prone");
		if (nextnode.targetname == "stand1" || nextnode.targetname == "stand2" || nextnode.targetname == "stand3" || nextnode.targetname == "stand4")
			self allowedStances ("stand");

		if (isdefined (nextnode.target))
		{
			nextnode = getnode (nextnode.target, "targetname");
		}
		else
		{
			break;
		}
		if (isdefined (nextnode.script_delay) )
			wait (nextnode.script_delay);
	}

	if (isalive (self))
	{
		self.interval = 64;
		self allowedStances ("crouch");
	}
}

mg42()
{
	self setmode("manual"); // auto, auto_ai, manual

	self startfiring();

	target = getentarray ("mg42_targets", "targetname");

	while (1)
	{
		number = randomint( target.size);
		self settargetentity ( target[number] );
		wait (1 + randomfloat (2.5));

		if (level.mg42_firing != true)
			break;
	}

	self stopfiring();
}

give_ammo()
{
	temp = getentarray ("weapon_m1carbine", "classname");
	level.guns["m1carbine"] =  spawn ("script_origin", temp[0].origin);
	level.guns["m1carbine"].angles = temp[0].angles;

	temp = getentarray ("weapon_springfield", "classname");
	level.guns["springfield"] =  spawn ("script_origin", temp[0].origin);
	level.guns["springfield"].angles = temp[0].angles;

	temp = getentarray ("weapon_thompson", "classname");
	level.guns["thompson"] =  spawn ("script_origin", temp[0].origin);
	level.guns["thompson"].angles = temp[0].angles;

	temp = getentarray ("weapon_fraggrenade", "classname");
	level.guns["fraggrenade"] =  spawn ("script_origin", temp[0].origin);
	level.guns["fraggrenade"].angles = temp[0].angles;

	while (1)
	{
		currentweapon = level.player getCurrentWeapon();
		currentammo = level.player getFractionMaxAmmo(currentweapon);

		if (currentweapon == "fraggrenade")
			weapon_classname = "weapon_fraggrenade";
		if (currentweapon == "springfield")
			weapon_classname = "weapon_springfield";
		if (currentweapon == "thompson")
			weapon_classname = "weapon_thompson";
		if (currentweapon == "m1carbine")
			weapon_classname = "weapon_m1carbine";


		if (currentammo < .2)
		{
			temp = getentarray (weapon_classname, "classname");
			if (temp.size == 0)
			{
				new_weapon = spawn (weapon_classname, level.guns[currentweapon].origin);
				new_weapon.angles = level.guns[currentweapon].angles;
				if (currentweapon == "fraggrenade")
					new_weapon.count = 1;
			}
		}
		wait .2;
	}
}

bomb_pickup()
{
	bomb_table_trigger = getent ("bomb_table_trigger", "targetname");
	bomb_on_table = getent (bomb_table_trigger.target, "targetname");
	bomb_table_trigger maps\_utility::triggerOn();
	bomb_table_trigger setHintString (&"SCRIPT_HINTSTR_PICKUPEXPLOSIVES");

	bomb_table_trigger waittill ("trigger");

	bomb_wall_trigger = getent ("bomb_wall_trigger", "targetname");
	objective_position(10, (bomb_wall_trigger.origin));

	level notify ("bomb_pickup");
	level.flags["bomb_pickup"] = true;
	bomb_on_table hide();
	bomb_table_trigger maps\_utility::triggerOff();
}

close_door()
{
	while (1)
	{
		wait .1;
		carbines = getentarray ("weapon_m1carbine", "classname");
		if (carbines.size < level.starting_carbines.size)
			break;
	}

	weapon_training_door = getent ("weapon_training_door", "targetname");
	weapon_training_door rotateyaw(90, 1,.3,0);

	level notify ("weapons");

	friendlies = getaiarray ();
	for (i=0;i<friendlies.size;i++)
	{
		if (isdefined (friendlies[i].targetname))
		{
			if (friendlies[i].targetname != "moody")
				friendlies[i] delete();
		}
		else
			friendlies[i] delete();
	}
}

