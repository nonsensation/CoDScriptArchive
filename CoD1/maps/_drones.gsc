#using_animtree("stalingrad_drones");
main()
{
	level.drone_mortar[0] = loadfx ("fx/impacts/beach_mortar.efx");
	level.drone_mortar[1] = loadfx ("fx/impacts/dirthit_mortar.efx");

	level.scr_sound ["exaggerated flesh impact"] = "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    level._effect["ground"]	= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"] = loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0] = "ground";
	level.scr_dyingguy["effect"][1] = "flesh small";
	level.scr_dyingguy["sound"][0] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] = "bip01 l thigh";
	level.scr_dyingguy["tag"][1] = "bip01 head";
	level.scr_dyingguy["tag"][2] = "bip01 l calf";
	level.scr_dyingguy["tag"][3] = "bip01 pelvis";
	level.scr_dyingguy["tag"][4] = "tag_breastpocket_right";
	level.scr_dyingguy["tag"][5] = "bip01 l clavicle";
	level.scr_anim["flag drone"]["run"][0] = (%stalingrad_flagrunner_idle);
	level.scr_anim["flag drone"]["walk"][0] = (%stalingrad_flagrunner_idle);
	level.scr_anim["flag drone"]["death"][0] = (%flagrun_drone_death);
	level.scr_character["flag drone"][0]	= character\RussianArmyOfficer_flagwave ::main;

	level.scr_character["drone"][0] 		= character\RussianArmy ::main;
	level.scr_character["drone"][1] 		= character\RussianArmy_nohat ::main;
	level.scr_character["drone"][2] 		= character\RussianArmy_pants ::main;

	level.scr_anim["drone"]["run"][0]		= (%pistol_crouchrun_loop_forward_1);
	level.scr_anim["drone"]["run"][1]		= (%pistol_crouchrun_loop_forward_2);
	level.scr_anim["drone"]["run"][2]		= (%pistol_crouchrun_loop_forward_3);
	//level.scr_anim["drone"]["run"][3]		= (%crouchrun_loop_forward_1);
	//level.scr_anim["drone"]["run"][4]		= (%crouchrun_loop_forward_2);
	//level.scr_anim["drone"]["run"][5]		= (%crouchrun_loop_forward_3);

	level.scr_anim["drone"]["walk"][0]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][1]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][2]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][3]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][4]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][5]		= (%stalingrad_flagrunner_idle);

	level.scr_anim["drone"]["death"][0]		= (%death_run_forward_crumple);
	level.scr_anim["drone"]["death"][1]		= (%crouchrun_death_drop);
	level.scr_anim["drone"]["death"][2]		= (%crouchrun_death_crumple);
	level.scr_anim["drone"]["death"][3]		= (%death_run_onfront);
	level.scr_anim["drone"]["death"][4]		= (%death_run_onleft);
	
	level.scr_anim["drone"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["drone"]["explode death back"] = %death_explosion_back13;			// Flies back 13 feet.
	level.scr_anim["drone"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["drone"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["drone"]["explode death right"] = %death_explosion_right13;
} 


#using_animtree("stalingrad_drones");
cliffguy_delete (group)
{
	self endon ("death");
	group waittill ("delete time");
	self delete();
}

cliffguy_run (animname)
{
	self endon ("death");
	while (1)
	{
		self waittill ("run");
//		self thread current_target(1500, "run");
		self.move_anim = level.scr_anim[animname]["run"][self.run_index];
		self thread cliffguy_animloop ();
	}	
}

cliffguy_walk (animname)
{
	self endon ("death");
	while (1)
	{
		self waittill ("walk");
//		self thread current_target(1500, "walk");
		self.move_anim = level.scr_anim[animname]["walk"][self.walk_index];
		self thread cliffguy_animloop ();
	}	
}

cliffguy_animloop ()
{
	self endon ("walk");
	self endon ("run");
	self endon ("death");

	while (self.origin[1] < self.stopline)
	{
		self setFlaggedAnimKnob("animdone", self.move_anim);
		self waittillmatch ("animdone", "end");
	}
	
	self notify ("finished animating");
}

cliffguy_think(group, stopline, stoptime, animname, live)
{
//	level thread add_totalguys(self);
	self.run_index = randomint (level.scr_anim[animname]["run"].size);
	self.walk_index = randomint (level.scr_anim[animname]["walk"].size);
	self.move_anim = level.scr_anim[animname]["run"][self.run_index];
	
	
	self thread cliffguy_delete(group);
	level thread cliffguy_mortar_death(self);
	self endon ("mortar death");
	self UseAnimTree(#animtree);
	self [[random(level.scr_character[animname])]]();
	self.origin = group gettagorigin (self.tag);
	wait (0.1);
	self.stopline = stopline;

	self linkto (group, self.tag, (0,0,0), (0,0,0));

	self thread cliffguy_run (animname);
	self thread cliffguy_walk (animname);

	self thread cliffguy_animloop ();
	self waittill ("finished animating");
			
	wait (randomfloat (stoptime));

	self unlink();
	
	deathanim = random (level.scr_anim[animname]["death"]);
	if (animname == "flag drone")
	{
		org = getStartOrigin (self.origin, self.angles, deathanim);
		ang = getStartAngles (self.origin, self.angles, deathanim);
		self moveto (org, 0.15);
		self rotateto (ang, 0.15);
		wait (0.15);
	}
	
	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
	self.died = true;
	self bloody_death();
	
	wait (4);
	self movez (-100, 3, 2, 1);
	wait (3);
	self delete();
}

cliffguy_mortar (delayer)
{
	wait (2);
	while (self.origin[1] < -250)
		wait (2);
		
	self playsound ("mortar_incoming", "sounddone");
	self waittill ("sounddone");
	playfx ( random(level.drone_mortar), self.origin );
	self playsound ("mortar_explosion");

	earthquake(0.3, 3, self.origin, 850); // scale duration source radius
	radiusDamage (self.origin, 150, 150, 0);

	ai = getentarray ("drone","targetname");
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].died))
			continue;
			
		dist = distance (ai[i].origin, self.origin);
		if (dist < 200)
		{	
			ai[i].died = true;
			ai[i].mortarDeath = getExplodeDeath("drone", self.origin, dist);
			ai[i] notify ("mortar death");
			ai[i] animscripted("death anim", ai[i].origin, ai[i].angles, ai[i].mortarDeath);
			ai[i] unlink();
		}
	}
}

cliffguy_mortar_death(guy)
{
	guy endon ("death");
	guy waittill ("mortar death");
	level thread cliffguy_mortar_sink (guy);
}
	
cliffguy_mortar_sink (guy)
{
	org = spawn ("script_origin",(0,0,3));
	org.origin = guy.origin;
	org.angles = guy.angles;
	guy linkto (org);
//	guy thread current_target(8000);
	if (guy.mortarDeath == level.scr_anim["drone"]["explode death up"])
	{
		upHeight = 200;
		downHeight = -500;
//		println ("^FLY SKY HIGH");
	}
	else
	{
		upHeight = 30;
		downHeight = -500;
	}
	
	org moveto (guy.origin + (0,0,upHeight), 0.3);
	wait (0.3);
	if (isdefined (guy))
		org moveto (guy.origin + (0,0,downHeight), 1.2, 1.2);
	wait (1.2);
//	self waittillmatch ("death anim", "end");
//	self bloody_death();
	org delete();
	if (isdefined (guy))
		guy delete();
}

#using_animtree("animation_rig_largegroup20");
large_group(groupnum, node, stopline, stoptime, ender, flagguy)
{
	if (isdefined (ender))
		level endon (ender);
	
	group = spawn ("script_model",(1,2,3));
	group.origin = node.origin;
	group.origin = node.origin + (0, 0, 0);
	group setmodel ("xmodel/largegroup_20");
	group hide();
	group UseAnimTree(#animtree);
	group.angles = (0,0,0);

	group setFlaggedAnimKnobRestart("animdone", level.large_group[groupnum]);
	mortarguy = randomint (20);
	guys = [];
	
	if (getcvar ("scr_redsquare_fast") == "1")
		fastmap = true;
	else
		fastmap = false;
		
	for (i=0;i<20;i++)
	{
		if ((i != flagguy) && (fastmap) && (randomint (100) > 40))
			continue;
		
		if (i < 10)
			msg = ("tag_guy0" + i);
		else
			msg = ("tag_guy" + i);

		guy = spawn ("script_model",(1,2,3));
		guy.targetname = "drone";
		guy.tag = msg;
		guy.num = i;
		guy makeFakeAI();

		if (i == mortarguy)
		{
			guy thread cliffguy_mortar (i);
			live = true;
		}
		else
			live = false;

		if (i == flagguy)
		{
			guy thread cliffguy_think(group, stopline, stoptime, "flag drone", live);
		}
		else
		{
			guy thread cliffguy_think(group, stopline, stoptime, "drone", live);
			//guy attach ("xmodel/weapon_mosinnagant", "tag_weapon_Right");
		}

		guys[guys.size] = guy;
	}

	while (1)
	{	
		group waittill ("animdone", notetrack);
		
		if (notetrack == "end")
			break;
		
		for (i=0;i<20;i++)
		{
			if (i < 10)
				msg = ("guy0" + i);
			else
				msg = ("guy" + i);
				
			if (!isdefined (guys[i]))
				continue;
				
			if (notetrack == msg + " walk")
				guys[i] notify ("walk");
			else
			if (notetrack == msg + " run")
				guys[i] notify ("run");
		}
	}
	
	group notify ("delete time");
	group delete();
}


bloody_death_waittill ()
{
	self waittill ("death");
	if (!isdefined (self))
		return;

	self bloody_death();
}

bloody_death()
{

	tag_array = level.scr_dyingguy["tag"];
	tag_array = maps\_utility::array_randomize(tag_array);
	tag_index = 0;
	waiter = false;

	for (i=0;i<3 + randomint (5);i++)
	{
		playfxOnTag ( level._effect [random (level.scr_dyingguy["effect"])], self, level.scr_dyingguy["tag"][tag_index] );
		thread maps\_utility::playSoundOnTag(random (level.scr_dyingguy["sound"]), level.scr_dyingguy["tag"][tag_index]);

		tag_index++;
		if (tag_index >= tag_array.size)
		{
			tag_array = maps\_utility::array_randomize(tag_array);
			tag_index = 0;
		}

		if (waiter)
		{
			wait (0.05);
			waiter = false;
		}
		else
			waiter = true;
//		wait (randomfloat (0.3));
	}
}

getExplodeDeath (msg, org, dist)
{
	if (isdefined (org))
	{
		if (dist < 50)
			return level.scr_anim[msg]["explode death up"];

		ang = vectornormalize ( self.origin - org );
		ang = vectorToAngles (ang);
		ang = ang[1];
		ang -= self.angles[1];
		if (ang <= -180)
			ang += 360;
		else
		if (ang > 180)
			ang -= 360;

		if ((ang >= 45) && (ang <= 135))
			return level.scr_anim[msg]["explode death forward"];
		if ((ang >= -135) && (ang <= -45))
			return level.scr_anim[msg]["explode death back"];
		if ((ang <= 45) && (ang >= -45))
			return level.scr_anim[msg]["explode death right"];

		return level.scr_anim[msg]["explode death left"];
	}

	randdeath = randomint(5);
	if (randdeath == 0)
		return level.scr_anim[msg]["explode death up"];
	else
	if (randdeath == 1)
		return level.scr_anim[msg]["explode death back"];
	else
	if (randdeath == 2)
		return level.scr_anim[msg]["explode death forward"];
	else
	if (randdeath == 3)
		return level.scr_anim[msg]["explode death left"];

	return level.scr_anim[msg]["explode death right"];
}


random (array)
{
	return array [randomint (array.size)];
}
