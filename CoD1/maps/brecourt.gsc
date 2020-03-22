/**************************************************************************
Level: 		BRECORT MANOR
Campaign: 	American
Objectives: 	1. Destroy the Enemy Artillery Guns
		2. Secure All Enemy Maps and Documents
		3. Provide covering fire for Sergeant Moody
		4. Get the Explosives from Sergeant Moody
***************************************************************************/

main()
{
	setcvar("introscreen","1");
	setCullFog (0, 9500, 1, 1, 1, 0);
	
	maps\_load::main();
	maps\brecourt_fx::main();
	maps\brecourt_anim::main();
	maps\brecourt_anim::dialogue_body_anims();
	maps\brecourt_anim::dialogue_facial_anims();
	maps\_flak::main();
	maps\_mg42::main();
	character\moody::precache();
	character\elder::precache();
	maps\_bombs::init();
	
	level.flak1 = getent ("flak1", "targetname");
	level.flak2 = getent ("flak2", "targetname");
	level.mortar = loadfx ("fx/surfacehits/mortarImpact.efx");
	level.mortar_notify = "startmortars";
	level.bombfx = loadfx("fx/explosions/explosion1.efx");
	level.medic_node = getnode ("medic_node","targetname");
	bomb = getent ("flak1_explosives", "targetname");
	bomb2 = getent ("flak2_explosives", "targetname");
	getent ("friendchain2","targetname") thread maps\_utility::triggerOff();
	getent ("barnspawners_trigger1","targetname") thread maps\_utility::triggerOff();
	getent ("barnspawners_trigger2","targetname") thread maps\_utility::triggerOff();
	getent ("friendchain_crossfield","targetname") thread maps\_utility::triggerOff();
	getent ("friendchainatbarn","targetname") thread maps\_utility::triggerOff();
	
	level.moody_woundedsequence_health = (100);
	
	precacheModel("xmodel/turret_flak88_static_antiairlow_d");
	precacheModel("xmodel/german_field_radio_d");
	precacheModel("xmodel/german_radio2_d");
	precacheModel("xmodel/german_radio1_d");
	
	level.flags["moody1"] 		= false;
	level.flags["atmoodytalk"] 	= false;
	level.flags["movein_triggered"] = false;
	level.flags["moody2"] 		= false;
	level.flags["moodystay"] 	= false;
	level.flags["moodydied"] 	= false;
	level.flags["GetLoc"] 		= true;
	level.flags["goto_third_goal"]	= false;
	level.flags["MoodyCanDie"]	= false;
	level.flags["GotWounded"] 	= false;
	level.flags["Dragback"] 	= true;
	level.flags["onchain"]		= false;
	level.flags["GotDocs"]		= false;
	level.flags["GotDocs2"]		= false;
	
	level.ambient_track ["interior"] = "ambient_brecourt_int";
	level.ambient_track ["exterior"] = "ambient_brecourt_ext";
	
	thread maps\_utility::set_ambient("exterior");
	bomb hide();
	bomb2 hide();
	thread maps\_mortar::railyard_style();
	friends();
	thread objectives();
	thread Radio_Explode_Setup();
	thread Trench_Explode_Setup();
	thread Trench2_Explode_Setup();
	thread Moody_MoveIn_Trigger();
	thread Flak1_Explode();
	thread Flak2_Explode();
	thread Moody_Opening();
	thread mg42_autofire();
	thread Player_On_Chain();
	thread chain_after_flak2();
	
	level.dummybomb = getentarray("dummybomb","targetname");
	for (i=0;i<level.dummybomb.size;i++)
	{
		level.dummybomb[i].trigger = getent (level.dummybomb[i].target,"targetname");
		level.dummybomb[i].trigger setHintString (&"BRECOURT_NO_EXPLOSIVES");
	}
}

hintprint_wait()
{
	getent ("hintprint","targetname") waittill ("trigger");
	iprintlnbold (&"TRAINING_STAR_ABOVE");
}

friends_givegrenades()
{
	for (i=0;i<level.friends.size;i++)
	{
		if ( (isdefined (level.friends[i])) && (isalive (level.friends[i])) )
			level.friends[i].grenades = 3;
	}
}

friends()
{
	level.player.ignoreme = true;
	level.friends = getentarray ("friend", "targetname");
	level.moody = getent ("moody", "targetname");
	level.elder = getent ("elder", "targetname");
	
	level.moody character\_utility::new();
	level.moody character\moody::main();
	level.elder character\_utility::new();
	level.elder character\elder::main();
	
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive (level.friends[i]) )
		{
			level.friends[i].ignoreme = true;
			level.friends[i].health = 800;
			level.friends[i].followmax = -1;
			level.friends[i].followmin = 0;
			level.friends[i] setgoalentity (level.moody);
		}
	}
	
	level.moody thread Moody_Health();
	level.elder thread Elder_Health();
	level.moody thread maps\_utility::magic_bullet_shield();
	level.elder thread maps\_utility::magic_bullet_shield();
	
	level.elder.health = 1000000;
	level.moody.health = 1000000;
	
	level.moody.ignoreme = true;
	level.elder.ignoreme = true;
}

Moody_Health()
{
	self endon ("stop magic bullet shield");
	while (level.flags["MoodyCanDie"] == false)
	{
		self waittill ("damage");
		self.health = 9999999;
	}
}

Lieutenant_Health()
{
	self endon ("CanDie");
	self endon ("stop magic bullet shield");
	while (1)
	{
		self waittill ("damage");
		self.health = 9999999;
		self.ignoreme = true;
		wait 5;
		self.ignoreme = false;
	}
}

Elder_Health()
{
	self endon ("stop magic bullet shield");
	self endon ("CanDie");
	while (1)
	{
		self waittill ("damage");
		self.health = 1000000;
	}
}

objectives()
{
	thread maps\_documents::main(1, &"BRECOURT_OBJECTIVE_DOCUMENTS", "documents");
	objective_current(1);
	thread objective_wait();
}

objective_wait()
{
	thread Medic_Sequence_Spawners("off");
	
	//####################################
	//WAIT UNTIL FIRST DOCUMENTS ARE TAKEN
	level waittill ("documents gotten");
	level.flags["GotDocs"] = true;
	level thread autosave3();
	
	thread maps\_bombs::main(2, &"BRECOURT_OBJECTIVE_BOMBS", "bomb_trigger", "Has_Explosives");
	objective_position(2, (-3612,3763,20));
	objective_current(2);
	
	clip = getent ("player_notallowed_clip","targetname");
	clip notsolid();
	
	thread fake_german_gunshots();
	
	reinforcements = getentarray ("reinforcements","targetname");
	wounded = getent ("wounded","targetname");
	medic = getent ("medic","targetname");
	level.wounded = wounded dospawn("wounded");
	level.wounded.DrawOnCompass = false;
	level.wounded animscripts\shared::PutGunInHand("none");
	if ( (isalive (level.wounded)) && (isdefined (level.wounded)) )
	{
		level.wounded thread maps\_utility::magic_bullet_shield(undefined,undefined,undefined,20);
		level.wounded.ignoreme = true;
	}
	thread Wounded_Idle();
	level.medic = medic dospawn("medic");
	level.medic.health = (1000000);
	level.medic.DrawOnCompass = false;
	level.medic thread maps\_utility::cant_shoot();
	level.medic.ignoreme = true;
	level.medic animscripts\shared::PutGunInHand("none");
	
	level.medic thread medic_anim(1);
	
	for (i=0;i<reinforcements.size;i++)
	{
		spawner = reinforcements[i] dospawn();
		spawner.health = (600);
		if ( (isdefined (spawner.script_noteworthy)) && (spawner.script_noteworthy == "lieutenant") ) //this will be the lieutenant
		{
			level.reinforcement1 = spawner;
			level.lieutenant = spawner;
			level.lieutenant.health = (1000000);
			level.lieutenant thread maps\_utility::magic_bullet_shield();
			level.lieutenant thread igmoreme_ondamage();
			level.lieutenant thread Lieutenant_Health();
			
			level.lieutenant.followmax = 2;
			level.lieutenant.followmin = 0;
			level.lieutenant.goalradius = 8;
			level.lieutenant setgoalentity (level.player);
		}
		level.friends = [];
		level.friends[level.friends.size] = spawner;
	}
	
	level.moody thread Moody_KickDoor();
	level.moody.goalradius = (8);
	node = getnode("kickdoor","targetname");
	level.moody setgoalnode (node);
	level.moody waittill ("goal");
	
	level.moody.scripted_dialogue = ("brecourt_moody_075");
	level.moody.facial_animation = (level.scr_anim["face"]["getout"]);
	level.moody animscripted("kickdooranim", node.origin, node.angles, level.scr_anim["moody"]["kickdoor"]);
	
	getent ("friendchain2","targetname") thread maps\_utility::triggerOn();
	thread Moody_GetInjuredMan();
	thread German_Fallback1();
	thread flak3_badplace();
	thread flak4_badplace();
	thread flak5_badplace();
	
	//##################################
	//WAIT UNTIL FIRST FLAK IS DESTROYED
	level waittill ("bomb_trigger planted");
	
	if (level.flags["moodydied"] == false)
	{
		level thread Trench_Explode();
		level thread Trench2_Explode();
	}
	thread Cross_Field();
	
	//###################################
	//WAIT UNTIL SECOND FLAK IS DESTROYED
	level waittill ("bomb_trigger planted");
	
	//##################################
	//WAIT UNTIL THIRD FLAK IS DESTROYED
	level waittill ("bomb_trigger planted");
	level thread autosave_six();
	level thread hintprint_wait();
	level thread friends_givegrenades();
	
	getent ("barnspawners_trigger1","targetname") thread maps\_utility::triggerOn();
	getent ("barnspawners_trigger2","targetname") thread maps\_utility::triggerOn();
	getent ("friendchain_crossfield","targetname") thread maps\_utility::triggerOn();
	getent ("friendchainatbarn","targetname") thread maps\_utility::triggerOn();
	
	thread Friendlies_Chain(4, 0);
	thread open_barndoors();
	
	level thread Take_Buildings();
	level thread German_Retake_ManorHouse1();
	
	objective_current(1);
	
	//#####################################
	//WAIT UNTIL SECOND DOCUMENTS ARE TAKEN
	level waittill ("documents gotten");
	level.flags["GotDocs2"] = true;
	objective_state(1, "done");
	objective_current(2);
	
	maps\_utility::autosave(8);
	
	level notify ("Retake_Manor1");
	
	housedoor1 = getent ("housedoor1","targetname");
	housedoor2 = getent ("housedoor2","targetname");
	housedoor1 connectpaths();
	housedoor2 connectpaths();
	housedoor1 rotateyaw(90, 1,0.25,0.25);
	housedoor2 rotateyaw(-90, 1,0.25,0.25);
	thread Manor_Door_Spawners();
	
	//###################################
	//WAIT UNTIL FOURTH FLAK IS DESTROYED
	level waittill ("bomb_trigger exploded");
	earthquake(0.25, 3, (-12204, 10706, 16), 1050);
	
	//#####################################
	//END OF LEVEL, ALL OBJECTIVES COMPLETE
	objective_state(1, "done");
	level.guysleft = 0;
	germans = getaiarray ("axis");
	for (i=0;i<germans.size;i++)
	{
		if ( (isdefined (germans[i].script_noteworthy)) && (germans[i].script_noteworthy == "mustdie") )
		{
			level.guysleft++;
			germans[i] thread mustdie_think();
		}
	}
	
	level endon ("Time out ending");
	thread time_out_ending_failsafe();
	made_obj5 = false;
	if (level.guysleft > 0)
	{
		made_obj5 = true;
		objective_add(5, "active", &"BRECOURT_OBJECTIVE_KILLREMAINING", (0, 0, 0));
		objective_current(5);
		axis = get_closest_axis();
		if (isdefined (axis))
			level thread objective_onaxis(axis);
	}
	
	while (level.guysleft > 0)
		wait (1);
	
	if (made_obj5 == true)
		objective_state(5, "done");
	
	wait 3;
	if (isalive (level.player))
	{
		maps\_utility::save_friendlies();
		missionsuccess ("us_mid", false);
	}
}

open_barndoors()
{
	barndoor1 = getent ("barndoor1","targetname");
	barndoor1 connectpaths();
	barndoor1 rotateyaw(100, 1,0.25,0.25);
	
	barndoor2 = getent ("barndoor2","targetname");
	barndoor2 connectpaths();
	barndoor2 rotateyaw(90, 1,0.25,0.25);
}

autosave3()
{
	wait 2;
	maps\_utility::autosave(3);
}

igmoreme_ondamage()
{
	self endon ("death");
	while (1)
	{
		self waittill ("damage");
		self.ignoreme = true;
		wait 5;
		if (isdefined (self))
			self.ignoreme = false;
	}
}

time_out_ending_failsafe()
{
	wait 30;
	
	if (isalive (level.player))
	{
		objective_state(5, "done");
		level notify ("Time out ending");
		maps\_utility::save_friendlies();
		missionSuccess ("chateau", false);
	}
}

flak3_badplace()
{
	level waittill ("obj_flak1_explosives planted");
	badplace_node = getnode ("badplace3","targetname");
	badplace_cylinder("bpFlak3", -1, badplace_node.origin, badplace_node.radius, 300, "neutral");
	
	level waittill ("obj_flak1_explosives exploded");
	badplace_delete("bpFlak3");
}

flak4_badplace()
{
	level waittill ("obj_flak2_explosives planted");
	thread Medic_Sequence_Spawners("off");
	badplace_node = getnode ("badplace4","targetname");
	badplace_cylinder("bpFlak4", -1, badplace_node.origin, badplace_node.radius, 300, "neutral");
	
	level waittill ("obj_flak2_explosives exploded");
	badplace_delete("bpFlak4");
}

flak5_badplace()
{
	level waittill ("obj_flak3_explosives planted");
	thread Medic_Sequence_Spawners("off");
	badplace_node = getnode ("badplace5","targetname");
	badplace_cylinder("bpFlak5", -1, badplace_node.origin, badplace_node.radius, 300, "neutral");
	
	level waittill ("obj_flak3_explosives exploded");
	badplace_delete("bpFlak5");
}

mustdie_think2()
{
	while ( (isdefined (self)) && (isalive (self)) )
		wait .2;
	level.flakersleft--;
}

mustdie_think()
{
	while ( (isdefined (self)) && (isalive (self)) )
		wait .2;
	level.guysleft--;
}

objective_onaxis(axis)
{
	level thread axis_obj_dead(axis);
	axis endon ("death");
	while (1)
	{
		objective_position(5,axis.origin);
		wait .2;
	}
}

axis_obj_dead(axis)
{
	while ( (isdefined (axis)) && (isalive (axis)) )
		wait .2;
	axis = get_closest_axis();
	if (isdefined (axis))
		level thread objective_onaxis(axis);
}

get_closest_axis()
{
	range = 500000000;
	axis = getaiarray ("axis");
	for (i=0;i<axis.size;i++)
	{
		if (isalive (axis[i]))
		{
			newrange = distance (level.player getorigin(), axis[i].origin);
			if (newrange < range)
			{
				range = newrange;
				ent = i;
			}
		}
	}
	if (isdefined (ent) )
		return axis[ent];
	else
		return;
}

autosave_six()
{
	level waittill ("bomb_trigger exploded");
	wait 1;
	if (isalive (level.player))
		maps\_utility::autosave(6);
}

Moody_Opening_Notes(note)
{
	dlgcount = 0;
	while (1)
	{
		self waittill ("openanim", notetrack);
		if (notetrack == "dialogue")
		{
			if (dlgcount == 0)
				self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["thirdsquad"], "brecourt_moody_067", 1.0);
			else if (dlgcount == 1)
				self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["onmytail"], "brecourt_moody_068", 1.0);
			else if (dlgcount == 2)
			{
				self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["letsgo"], "brecourt_moody_069", 1.0, "3rd talk done");
				self waittill ("3rd talk done");
				self notify ("Dialogue Done");
				return;
			}
			dlgcount++;
		}
	}
}

Moody_Opening()
{
	level waittill ("starting final intro screen fadeout");
	thread Player_AtMoodyTalk();
	thread Moody_Opening2();
	
	node = getnode ("opening1_moody","targetname");
	level.moody thread Moody_Opening_Notes();
	level.moody animscripted("openanim", node.origin, node.angles, level.scr_anim["body"]["thirdsquad"]);
	level.moody waittill ("Dialogue Done");
	
	if (isalive (level.moody))
		level.moody setgoalnode (getnode("firstgoal", "targetname"));
	
	thread Friends_FollowMoody();
}

Friends_FollowMoody()
{
	wait .5;
	firstgoal2 = getnodearray ("firstgoal2","targetname");
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive (level.friends[i]) )
		{
			level.friends[i].goalradius = (8);
			level.friends[i] setgoalnode (firstgoal2[i]);
			level.friends[i] thread animscripts\shared::SetInCombat();
		}
	}
	if (isalive (level.elder))
	{
		level.elder.goalradius = (8);
		level.elder setgoalnode (getnode("elder_firstgoal", "targetname"));
		level.elder thread animscripts\shared::SetInCombat();
	}
	if (isalive (level.moody))
	{
		level.moody waittill ("goal");
		level.flags["moody1"] = true;
		level.moody thread animscripts\shared::SetInCombat();
	}
}

Player_AtMoodyTalk()
{
	getent ("moodytalk","targetname") waittill ("trigger");
	level.player.ignoreme = false;
	level.flags["atmoodytalk"] = true;
}

Moody_Opening2()
{
	while(1)
	{
		if (level.flags["atmoodytalk"] == true)
		if (level.flags["moody1"] == true)
		{
			
			dlgnode = getnode ("firstgoal","targetname");
			level.moody thread animscripts\shared::PutGunInHand("left");
			level.moody.scripted_dialogue = ("brecourt_moody_070");
			level.moody.facial_animation = (level.scr_anim["face"]["wegottwo"]);
			level.moody animscripted("animdone", dlgnode.origin, dlgnode.angles, level.scr_anim["body"]["wegottwo"]);
			level.moody waittillmatch ("animdone","end");
			
			prone1 = getnodearray ("prone1","targetname");
			
			level.moody.ignoreme = false;
			level.elder.ignoreme = false;
			for (i=0;i<level.friends.size;i++)
			{
				if (isalive (level.friends[i]) )
				{
					level.friends[i].goalradius = (8);
					level.friends[i] setgoalnode (prone1[i]);
					level.friends[i].threatbias = 50;
					level.friends[i].ignoreme = false;
				}
			}
			
			if (isalive (level.elder))
				level.elder thread Goto_Chained_Node(1,"elder_secondgoal");
			if (isalive (level.moody))
			{
				level.moody thread Goto_Chained_Node(1,"secondgoal");
				level.moody waittill ("goal");
			}
			
			wait 6;
			level.flags["moody2"] = true;
			
			thread Moody_MoveIn();
			
			while (level.flags["goto_third_goal"] == false)
				wait .5;
			
			wait 2;
			
			level.moody thread Goto_Chained_Node(1,"thirdgoal");
			level.elder thread Goto_Chained_Node(1,"thirdgoal2");
			level.moody waittill ("at_chained_node");
			Notify_AllGuys("StopChaining");
			
			friend_cover1 = getnodearray ("friend_cover1","targetname");
			for (i=0;i<level.friends.size;i++)
			{
				if (isalive (level.friends[i]) )
				{
					level.friends[i].followmax = 0;
					level.friends[i].followmin = -2;
					level.friends[i].goalradius = (8);
					level.friends[i] setgoalentity (level.player);
				}
			}
			
			level.elder.goalradius = 8;
			level.elder setgoalentity (level.player);
			
			node = getnode("moody_plant1","targetname");
			level.moody.goalradius = 8;
			level.moody setgoalnode (node);
			
			trig = getent ("flak1_guysdie","targetname");
			level maps\_utility::living_ai_wait(trig, "axis");
			
			level notify ("Flak1_Bomb");
			
			for (i=0;i<level.friends.size;i++)
			{
				if (isalive (level.friends[i]) )
					level.friends[i].threatbias = 0;
			}
			
			return;
		}
		wait 1;
	}
}

Notify_AllGuys(note)
{
	if (isalive (level.moody))
		level.moody notify (note);
	if (isalive (level.elder))
		level.elder notify (note);
	for (i=0;i<level.friends.size;i++)
		if (isalive (level.friends[i]))
			level.friends[i] notify (note);
}

Moody_MoveIn_Trigger()
{
	getent ("movein","targetname") waittill ("trigger");
	Notify_AllGuys("StopChaining");
	level.flags["movein_triggered"] = true;
}

Moody_MoveIn()
{
	while (1)
	{
		if (level.flags["movein_triggered"] == true)
		if (level.flags["moody2"] == true)
		{
			level.flags["goto_third_goal"] = true;
			return;
		}
		wait .5;
	}
}

Moody_BlowUpFlak2()
{
	getent ("moodyflak2","targetname") waittill ("trigger");
	
	level notify ("StopMG42_Fire");
	level.moody.goalradius = 8;
	level.moody setgoalnode (getnode("moodyflak2node", "targetname"));
	Notify_AllGuys("StopChaining");
	
	level.flakersleft = 0;
	germans = getaiarray ("axis");
	for (i=0;i<germans.size;i++)
	{
		if ( (isdefined (germans[i].script_noteworthy)) && (germans[i].script_noteworthy == "dietoplantbomb2") )
		{
			level.flakersleft++;
			germans[i] thread mustdie_think2();
		}
	}
	
	failsafe_timer = 0;
	while (level.flakersleft > 0)
	{
		wait (1);
		failsafe_timer++;
	}
	
	level notify ("StopMG42_Fire");
	level.moody.goalradius = 8;
	level.moody setgoalnode (getnode("moodyflak2node", "targetname"));
	level.moody waittill ("goal");
	
	Notify_AllGuys("StopChaining");
	
	level notify ("Flak2_Bomb");
}

Spawn_Flakdefenders()
{
	getent ("flakdefenders_trigger","targetname") waittill ("trigger");
	guys = getentarray ("auto1126","targetname");
	for (i=0;i<guys.size;i++)
		guys[i] dospawn("flakdefenders");
}

update_objective3()
{
	level endon ("objective 3 finished");
	while (1)
	{
		objective_position(3,level.moody.origin);
		wait 0.05;
	}
}

Moody_GetInjuredMan()
{
	level.moody setgoalnode(getnode("moody_talktomedic", "targetname"));
	level.moody waittill ("goal");
	
	level.flags["moodystay"] = true;
	
	getent ("medic_area","targetname") waittill ("trigger");
	level thread close_bunkerdoor();
	level.medic thread medic_anim(2);
	
	level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["medic"], "brecourt_moody_076", 1.0, "dialogue done");
	level.moody thread animscripts\shared::LookAtEntity(level.medic, .6, "alert");
	level.moody waittill ("dialogue done");
	
	level.medic.scripted_dialogue = ("brecourt_medic_sorry");
	level.medic.facial_animation = (level.scr_anim["face"]["sorry"]);
	level.medic notify ("Stop Anim");
	level.medic animscripted("animdone", level.medic_node.origin, level.medic_node.angles, level.scr_anim["body"]["sorrysarge"]);
	level.medic waittillmatch ("animdone","end");
	level.medic thread medic_anim(2);
	
	level.moody allowedstances ("crouch");
	level.moody thread animscripts\shared::LookAtEntity(level.medic, .5, "alert");
	level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["move"], "brecourt_moody_077_alt2", 1.0, "dialogue done");
	level.moody waittill ("dialogue done");
	
	level.medic.scripted_dialogue = ("brecourt_medic_norules");
	level.medic.facial_animation = (level.scr_anim["face"]["rules"]);
	level.medic notify ("Stop Anim");
	level.medic thread medic_death();
	level.medic.deathanim = (level.scr_anim["medic"]["death"]);
	level.medic.allowdeath = 1;
	level.medic animscripted("medicfinalanim", level.medic_node.origin, level.medic_node.angles, level.scr_anim["body"]["rules"]);
	level.medic waittillmatch ("medicfinalanim","end");
	level.medic.DropWeapon = false;
	level.medic doDamage ( level.medic.health + 50, (0,0,0) );
	
	thread Medic_Sequence_Spawners("on");
	level notify ("stop fake gunshots");
	
	
	level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["coverfire"], "brecourt_moody_079", 1.0, "dialogue done");
	level.moody.grenadeawareness = 0;
	level.moody.ignoreme = true;
	level.moody thread animscripts\shared::SetInCombat(false);
	level.moody thread maps\_utility::cant_shoot();
	level.moody allowedstances ("stand");
	
	objective_add(3, "active", &"BRECOURT_OBJECTIVE_COVERFIRE", (0, 0, 0));
	thread update_objective3();
	objective_current (3);
	
	thread First_Mortar();
	level.moody.health = 100000;
	thread moody_location();
	thread Moody_PickUp();
	
	level waittill ("MoodyIsDone");
	level notify ("objective 3 finished");
	
	level.moody thread maps\_utility::magic_bullet_shield(undefined,undefined,undefined,20);
	level.moody.threatbias = -1;
	
	if (level.flags["moodydied"] == false)
	{
		objective_state(3, "done");
		level.moody.goalradius = 8;
		lastnode = getnode("wounded_node2","targetname");
		level.moody allowedstances ("crouch");
		level.moody setgoalnode (lastnode);
		level notify ("startmortars");
		if (isdefined (level.moodyoldbravery))
			level.moody.bravery = level.moodyoldbravery;
		level.moody thread maps\_utility::cant_shoot();
		level.moody.ignoreme = true;
		
		level.moody waittill ("goal");
		
		objective_add(4, "active", &"BRECOURT_OBJECTIVE_GETEXPLOSIVES", (level.moodyloc));
		objective_current (4);
		level.flags["GetLoc"] = false;
		level.moody.grenadeawareness = 1;
		
		while (distance(level.player.origin, level.moodyloc) > 100)
			wait 1;
		
		level.moody.scripted_dialogue = ("brecourt_moody_080");
		level.moody.facial_animation = (level.scr_anim["face"]["takeexplosives"]);
		level.moody thread moody_give_explosives();
		level.moody thread animscripts\shared::SetInCombat(false);
		level.moody animscripted("explosivesanim", lastnode.origin, lastnode.angles, level.scr_anim["body"]["takeexplosives"]);
		level.moody waittillmatch ("explosivesanim","end");
		level.moody thread animscripts\shared::SetInCombat(false);
		level.moody notify ("STOP NOTES");
		thread got_explosives();
		
		level.elder notify ("stop magic bullet shield");
		level.elder notify ("CanDie");
		level.elder.health = 500;
		level.moody.DrawOnCompass = false;
		level.moody.ignoreme = false;
		level.moody thread maps\_utility::can_shoot();
	}
	else
	{	
		objective_state(3, "failed");
		level.moody attach("xmodel/explosivepack", "tag_weapon_left");
		trig = getent ("explosivetrigger","targetname");
		org = level.moody gettagOrigin ("tag_weapon_left");
		
		level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["sargedown"], "brecourt_elder_sargedown", 1.0, "dialogue done");
		level.elder waittill ("dialogue done");
		level.elder notify ("stop magic bullet shield");
		level.elder notify ("CanDie");
		level.elder.health = 500;
		
		thread Trench_Explode();
		thread Trench2_Explode();
		
		objective_add(4, "active", &"BRECOURT_OBJECTIVE_GETEXPLOSIVES", level.moody.origin);
		objective_current (4);
		level.flags["GetLoc"] = false;
		level thread explosives_objective_wait();
	}
}


moody_give_explosives()
{
	self endon ("STOP NOTES");
	while (1)
	{
		self waittill ("explosivesanim", notetrack);
		if (notetrack == "anim_gunhand = \"left\"")
			self animscripts\shared::PutGunInHand("left");
		else if (notetrack == "attach \"bomb\"")
			self attach("xmodel/explosivepack", "tag_weapon_right");
		else if (notetrack == "detach \"bomb\"")
			self detach("xmodel/explosivepack", "tag_weapon_right");
		else if (notetrack == "anim_gunhand = \"right\"")
			self animscripts\shared::PutGunInHand("right");
	}
}

explosives_objective_wait()
{
	if (isdefined (level.moody))
	{
		level.moody.useable = true;
		level.moody setHintString (&"SCRIPT_HINTSTR_PICKUPEXPLOSIVES");
		while (1)
		{
			level.moody waittill ("trigger",other);
			if (other == level.player)
			{
				level.moody.useable = false;
				level.moody detach("xmodel/explosivepack", "tag_weapon_left");
				thread got_explosives();
				return;
			}
			wait .1;
		}
	}
	else
	{//failsafe
		thread got_explosives();
	}
}

got_explosives()
{
	level notify ("Has_Explosives");
	
	for (i=0;i<level.dummybomb.size;i++)
	{
		level.dummybomb[i].trigger delete();
		level.dummybomb[i] delete();
	}
	
	maps\_utility::autosave(4);
	objective_state(4, "done");
	objective_current (2);
	obj_flak1_explosives = getent ("obj_flak1_explosives","targetname");
	objective_position(2,obj_flak1_explosives.origin);
}

moody_location()
{
	while ( (isalive (level.moody)) && (level.flags["GetLoc"] == true) )
	{
		level.moodyloc = level.moody.origin;
		wait .1;
	}
}

Take_Buildings()
{
	getent ("entering_buildings","targetname") waittill ("trigger");
	wait randomint(5);
	
	level.lieutenant thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["movein"], "brecourt_lieut_movein", 1.0);
	level.lieutenant thread lieutenant_more_dialogue();
}

lieutenant_more_dialogue()
{
	trig = getent ("getdocs2","targetname");
	trig waittill ("trigger");
	
	level.lieutenant.goalradius = 8;
	level.lieutenant setgoalnode (getnode("windowcover","targetname"));
	level.lieutenant waittill ("goal");
	
	if (level.flags["GotDocs2"] == false)
	{
		level.lieutenant thread animscripts\shared::LookAtEntity(level.player, .6, "alert");
		self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["grabdocs"], "brecourt_lieut_grabdocs", 1.0);
	}
	
	while (level.flags["GotDocs2"] == false)
		wait .5;
	
	level.lieutenant thread animscripts\shared::LookAtEntity(level.player, .6, "alert");
	level.lieutenant thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["headsup"], "brecourt_lieut_headsup", 1.0, "dialogue done");
	
	getent ("leavinghouse","targetname") waittill ("trigger");
	
	if ( (isdefined (level.lieutenant)) && (isalive (level.lieutenant)) )
		level.lieutenant setgoalentity (level.player);
}

Player_On_Chain()
{
	getent ("firstchain","targetname") waittill ("trigger");
	level.flags["onchain"] = true;
}

flak_dialogue(num)
{
	if (num == 1)
	{
		wait 2;
		level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["goboom"], "brecourt_moody_071", 1.0);
	}
	else if (num == 2)
	{
		wait 2;
		level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["headsup"], "brecourt_moody_072", 1.0);
	}
}

Flak1_Explode()
{
	level waittill ("Flak1_Bomb");
	thread flak_dialogue(1);
	level.moody thread maps\_scripted::main ("bomb", "flak", "moody_plant1", ::moodyplant1);
	badplace_node = getnode ("badplace1","targetname");
	badplace_cylinder("bpFlak1", -1, badplace_node.origin, badplace_node.radius, 300, "neutral");
	
	level waittill ("Flak1_Blow");
	wait 1;
	
	playfx (level.bombfx, level.flak1.origin );
	earthquake(0.25, 3, level.flak1.origin, 1050);
	level notify ("Remove Bomb");
	level.flak1 setmodel ("xmodel/turret_flak88_static_antiairlow_d");
	level.flak1 playsound ("explo_metal_rand");
	badplace_delete("bpFlak1");
	thread Moody_BlowUpFlak2();
	
	while (level.flags["onchain"] == false)
		wait (.5);
	
	if (isalive (level.moody) )
	{
		level.moody.followmax = 3;
		level.moody.followmin = 1;
		level.moody.goalradius = (8);
		level.moody setgoalentity (level.player);
	}
	if (isalive (level.elder) )
	{
		level.elder.followmax = 0;
		level.elder.followmin = -2;
		level.elder.goalradius = (8);
		level.elder setgoalentity (level.player);
	}
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive (level.friends[i]) )
		{
			level.friends[i].followmax = 0;
			level.friends[i].followmin = -2;
			level.friends[i].goalradius = (8);
			level.friends[i] setgoalentity (level.player);
		}
	}
	
	wait 1;
	level.moody.scripted_dialogue = ("brecourt_moody_071b");
	level.moody.facial_animation = (level.scr_anim["face"]["downtrench"]);
	level.moody animscripted("animdone", level.moody.origin, (0,180,0), level.scr_anim["body"]["downtrench"]);
	level.moody waittillmatch ("animdone","end");
}

chain_after_flak2()
{
	getent("nextchain","targetname") maps\_utility::triggerOff();
}

Flak2_Explode()
{
	level waittill ("Flak2_Bomb");
	
	Notify_AllGuys("StopChaining");
	thread flak_dialogue(2);
	level.moody thread maps\_scripted::main ("bomb", "flak", "moody_plant2", ::moodyplant2);
	
	badplace_node = getnode ("badplace2","targetname");
	badplace_cylinder("bpFlak2", -1, badplace_node.origin, badplace_node.radius, 300, "neutral");
	
	level waittill ("Flak2_Blow");
	wait 1;
	
	playfx (level.bombfx, level.flak2.origin );
	earthquake(0.25, 3, level.flak2.origin, 1050);
	level notify ("Remove Bomb");
	
	level.flak2 setmodel ("xmodel/turret_flak88_static_antiairlow_d");
	level.flak2 playsound ("explo_metal_rand");
	badplace_delete("bpFlak2");
	
	spawners = getentarray ("auto987", "targetname");
	for (i=0;i<spawners.size;i++)
	{
		spawners[i] dospawn();
	}
	
	getent("nextchain","targetname") thread maps\_utility::triggerOn();
	level.moody thread Moody_GetPapers_wait();
	
	thread Spawn_FlakDefenders();
	
	level.moody.followmax = 3;
	level.moody.followmin = 1;
	level.moody.goalradius = 8;
	level.moody setgoalentity (level.player);
	
	level.elder.followmax = 0;
	level.elder.followmin = -2;
	
	level.elder.goalradius = 8;
	level.elder setgoalentity (level.player);
	
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive (level.friends[i]) )
		{
			level.friends[i].followmax = 0;
			level.friends[i].followmin = -2;
			level.friends[i].goalradius = (8);
			level.friends[i] setgoalentity (level.player);
		}
	}
	
	thread open_bunkerdoor();
	thread stopmoody();
	
	wait (0.5);
	
	level.moody.scripted_dialogue = ("brecourt_moody_073");
	level.moody.facial_animation = (level.scr_anim["face"]["aintdone"]);
	level.moody thread gunnotes();
	level.moody animscripted("animdone", level.moody.origin, (0,240,0), level.scr_anim["body"]["aintdone"]);
	level.moody waittillmatch ("animdone","end");
	level.moody notify ("STOP GUN NOTES");
}

open_bunkerdoor()
{
	wait (1);
	level thread player_doorfailsafe();
	bunkerdoor = getent ("bunkerdoor","targetname");
	bunkerdoor connectpaths();
	bunkerdoor playsound ("wood_door_kick");
	bunkerdoor rotateyaw(-90, 1,0.1,0.1);
	wait 1;
	level notify ("DoorIsOpen");
	level.player unlink();
}

close_bunkerdoor()
{
	bunkerdoor = getent ("bunkerdoor","targetname");
	bunkerdoor disconnectpaths();
	bunkerdoor rotateyaw(90, 1,0.1,0.1);
}

stopmoody()
{
	trig = getent ("stopmoody_trig","targetname");
	clip = getent ("stopmoody","targetname");
	
	trig waittill ("trigger");
	
	german = getaiarray ("axis");
	level.stopmoodyguys = 0;
	for (i=0;i<german.size;i++)
	{
		if ( (isdefined (german[i])) && (isalive (german[i])) && (isdefined (german[i].script_noteworthy)) && (german[i].script_noteworthy == "stopmoody") )
		{
			level.stopmoodyguys++;
			german[i] thread wait_moody_stop_death();
		}
	}
	
	while (level.stopmoodyguys > 0)
		wait .5;
	
	clip connectpaths();
	clip delete();
}

wait_moody_stop_death()
{
	if (isalive (self))
		self waittill ("death");
	level.stopmoodyguys--;
}

Trench_Explode_Setup()
{
	explode_after = getentarray ("explode_after","targetname");
	for (i=0;i<explode_after.size;i++)
		explode_after[i] hide();
}

Trench2_Explode_Setup()
{
	explode_after2 = getentarray ("explode_after2","targetname");
	for (i=0;i<explode_after2.size;i++)
		explode_after2[i] hide();
}

Trench_Explode()
{
	before = getentarray ("explode_before","targetname");
	after = getentarray ("explode_after","targetname");
	explosion = getent("explode_mortar","targetname");
	clipplayer = getent("clipplayer", "targetname");
	
	wait randomint(10);
	
	while (distance(level.player.origin, explosion.origin) < 300)
		wait 1;
	
	explosion maps\_mortar::activate_mortar(0, 0, 0, undefined, undefined, undefined);
	
	for (i=0;i<after.size;i++)
		after[i] show();
	
	for (i=0;i<before.size;i++)
	{
		if (before[i].spawnflags & 1)
			before[i] connectpaths();
		before[i] delete();
	}
	
	clipplayer delete();
}

Trench2_Explode()
{
	before2 = getentarray ("explode_before2","targetname");
	after2 = getentarray ("explode_after2","targetname");
	explosion2 = getent("explode_mortar2","targetname");
	clip = getentarray ("explosion_trench2_clip","targetname");
	
	wait randomint(5);
	
	while (distance(level.player.origin, explosion2.origin) < 300)
		wait 1;
	
	explosion2 maps\_mortar::activate_mortar(0, 0, 0, undefined, undefined, undefined);
	
	for (i=0;i<after2.size;i++)
		after2[i] show();
	
	for (i=0;i<before2.size;i++)
	{
		if (before2[i].spawnflags & 1)
			before2[i] connectpaths();
		before2[i] delete();
	}
	
}

Medic_Sequence_Spawners(OnOrOff)
{
	spawners = getspawnerarray();
	german = [];
	for (i=0;i<spawners.size;i++)
	{
		if ( (isdefined (spawners[i].targetname)) && (spawners[i].targetname == "germanretake") )
			german[german.size] = spawners[i];
	}
	if (OnOrOff == "on")
		thread maps\_utility::array_notify(german,"enable");
	else if (OnOrOff == "off")
		thread maps\_utility::array_notify(german,"disable");
	else if (OnOrOff == "fast")
	{
		for (i=0;i<german.size;i++)
		{
			if (i < 3)
				german[i] notify ("enable");
		}
		wait .1;
		thread maps\_utility::array_notify(german,"disable");
	}
}

Cross_Field()
{
	thread Cross_Field_Chain();
	
	if ((isalive (level.reinforcement1)) && (isdefined (level.reinforcement1)) )
	{
		level.reinforcement1 setgoalnode (getnode("auto1080","targetname"));
		level.reinforcement1 waittill ("goal");
	}
	
	thread Friendlies_Chain(0, -2);
	wait 5;
	
	for (i=0;i<level.friends.size;i++)
		if ( (isalive (level.friends[i])) && (isdefined (level.friends[i])) )
			level.friends[i] notify ("stop magic bullet shield");
	if ( (isalive (level.reinforcement1)) && (isdefined (level.reinforcement1)) )
	{
		level.reinforcement1 notify ("stop magic bullet shield");
		level.reinforcement1.health = (400);
	}
}

Cross_Field_Chain()
{
	getent ("crossfield", "targetname") waittill ("trigger");
	thread Friendlies_Chain(1, -2);
}

German_Fallback1()
{
	trig = getent ("fallbackguys","targetname");
	trig waittill ("trigger");
	
	guys = getentarray ("auto1104", "targetname");
	for (i=0;i<guys.size;i++)
		guys2[i] = guys[i] dospawn("fallbackspawner1");
	
	getent ("fallback1","targetname") waittill ("trigger");
	
	count = 0;
	fallbacknode = getnodearray ("fallbacknode", "targetname");
	
	for (i=0;i<guys2.size;i++)
	{
		if ( ( isdefined(guys2[i]) ) && ( isalive(guys2[i]) ) )
		{
			count = (count + 1);
			oldbravery = guys2[i].bravery;
			guys2[i].bravery = 5000;
			guys2[i] thread Goto_Chained_Node(2, fallbacknode[randomint(fallbacknode.size)] );
			guys2[i].bravery = oldbravery;
		}
	}
}

German_Retake_ManorHouse1()
{
	spawners = getspawnerteamarray ("axis");
	guy = [];
	for (i=0;i<spawners.size;i++)
	{
		if ( (isdefined (spawners[i].targetname)) && (spawners[i].targetname == "germanretake2") )
			guy[guy.size] = spawners[i];
	}
	thread maps\_utility::array_notify(guy,"disable");
	level waittill ("Retake_Manor1");
	thread maps\_utility::array_notify(guy,"enable");
}

Manor_Door_Spawners()
{
	manor_leftdoor1	= getent ("manor_leftdoor1","targetname");
	manor_rightdoor1 = getent ("manor_rightdoor1","targetname");
	manor_leftdoor2	= getent ("manor_leftdoor2","targetname");
	manor_rightdoor2 = getent ("manor_rightdoor2","targetname");
	getent ("manor_doorspawners","targetname") waittill ("trigger");
	level.lieutenant thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["outtahere"], "brecourt_lieut_outtahere", 1.0);
	wait 1;
	manor_leftdoor1 connectpaths();
	manor_rightdoor1 connectpaths();
	manor_leftdoor1 rotateyaw(-90, 1,0.1,0.1);
	manor_rightdoor1 rotateyaw(90, 1,0.1,0.1);
	wait 4;
	manor_leftdoor2 connectpaths();
	manor_rightdoor2 connectpaths();
	manor_leftdoor2 rotateyaw(-90, 1,0.1,0.1);
	manor_rightdoor2 rotateyaw(90, 1,0.1,0.1);
}

Radio_Explode_Setup()
{
	radios = getentarray ("radio_exploder", "targetname");
	for (i=0;i<radios.size;i++)
	{
		if (i==3)
			radios[i] thread Radio_Explode_Wait((radios[i].model + "_d"),1);
		else
			radios[i] thread Radio_Explode_Wait((radios[i].model + "_d"));
	}
}
Radio_Explode_Wait(model_d, option)
{	
	trigger = getent (self.target, "targetname");
	
	if (isdefined(trigger.target))
	{
		fxmodel = getent (trigger.target,"targetname");
	}
	if (isdefined (fxmodel))
	{
		fxmodel hide();
	}
	
	if (isdefined (option))
		self playloopsound ("german_radio");
	
	trigger waittill ("trigger");
	
	if (isdefined(trigger.target))
		fxmodel = getent (trigger.target,"targetname");
	if (isdefined (fxmodel))
		fxmodel thread maps\_utility::cannon_effect(fxmodel);
	
	if (isdefined (option))
		self stoploopsound ("german_radio");
	
	self playsound ("explo_radio");
	
	self setmodel (model_d);
	trigger delete();
}

Goto_Chained_Node(option, node)
{
	if (option == 1)
		firstnode = getnode (node, "targetname");
	else
	if (option == 2)
		firstnode = node;
	else
	if ( (option != 1) && (option != 2) )
		return;
	
	self setgoalnode (firstnode);
	self endon ("StopChaining");
	self waittill ("goal");
	
	nextnode = getnode (firstnode.target, "targetname");
 	if ( !(isdefined (nextnode) ) )
  		return;
	
	while (isdefined (nextnode) && (isalive (self)) )
 	{
  		self setgoalnode(nextnode);
  		self endon ("StopChaining");
  		self waittill ("goal");
		
  		if (isdefined (nextnode.target))
  		{
  			nextnode = getnode (nextnode.target, "targetname");
  		}
  		else
  		{
  			self notify ("at_chained_node");
  			break;
  		}
	}
}

Friendlies_Chain(max, min)
{
	if (!isdefined (max))
	{
		max = 0;
	}
	if (!isdefined (min))
	{
		min = -2;
	}
	
	if (level.flags["moodystay"] == false)
	if (isalive (level.moody) )
	{
		level.moody.followmax = max;
		level.moody.followmin = min;
		level.moody.goalradius = (8);
		level.moody setgoalentity (level.player);
	}
	
	if (isalive (level.elder) )
	{
		level.elder.followmax = max;
		level.elder.followmin = min;
		level.elder.goalradius = (8);
		level.elder setgoalentity (level.player);
	}
	for (i=0;i<level.friends.size;i++)
	{
		if ( (isdefined (level.friends[i])) && (isalive (level.friends[i])) )
		{
			level.friends[i].followmax = max;
			level.friends[i].followmin = min;
			level.friends[i].goalradius = (8);
			level.friends[i] setgoalentity (level.player);
		}
	}
}

moodyplant1()
{
	level thread bomb_plant_sound();
	self animscripts\shared::PutGunInHand("none");
	self attach("xmodel/explosivepack", "tag_weapon_right");
	self animscripts\shared::DoNoteTracks("scriptedanimdone", ::Moody_Anim);
	bomb = getent ("flak1_explosives", "targetname");
	bomb playloopsound ("bomb_tick");
	self.goalradius = 8;
	self setgoalnode (getnode("moody_cover1","targetname"));
	self waittill ("goal");
	level notify ("Flak1_Blow");
}

bomb_plant_sound()
{
	org = level.moody.origin + (0,0,50);
	level thread maps\_utility::playSoundinSpace ("moody_plant", org);
	wait 1.5;
	level thread maps\_utility::playSoundinSpace ("explo_plant_no_tick", org);
}

moodyplant2()
{
	level thread bomb_plant_sound();
	self animscripts\shared::PutGunInHand("none");
	self attach("xmodel/explosivepack", "tag_weapon_right");
	self animscripts\shared::DoNoteTracks("scriptedanimdone", ::Moody_Anim2);
	bomb2 = getent ("flak2_explosives", "targetname");
	bomb2 playloopsound ("bomb_tick");
	self.goalradius = 8;
	self setgoalnode (getnode("moody_cover2","targetname"));
	self waittill ("goal");
	level notify ("Flak2_Blow");
}

Moody_Anim(note)
{
	switch (note)
	{
		case "release bomb from hands":
			self detach("xmodel/explosivepack", "tag_weapon_right");
			thread bomb_showhide1();
			return;
	}
}

bomb_showhide1()
{
	bomb = getent ("flak1_explosives", "targetname");
	bomb show();
	level waittill ("Remove Bomb");
	bomb stoploopsound ("bomb_tick");
	level thread maps\_utility::scriptedRadiusDamage(bomb.origin, 300);
	bomb delete();
}

Moody_Anim2(note)
{
	switch (note)
	{
		case "release bomb from hands":
			self detach("xmodel/explosivepack", "tag_weapon_right");
			thread bomb_showhide2();
			return;
	}
}

bomb_showhide2()
{
	bomb2 = getent ("flak2_explosives", "targetname");
	bomb2 show();
	level waittill ("Remove Bomb");
	bomb2 stoploopsound ("bomb_tick");
	level thread maps\_utility::scriptedRadiusDamage(bomb2.origin, 300);
	bomb2 delete();
}

medic_anim(num)
{
	self endon ("Stop Anim");
	if (num == 1)
	{
		while (1)
		{
			level.medic animscripted("animdone", level.medic_node.origin, level.medic_node.angles, level.scr_anim["medic"]["idle1"]);
			level.medic waittillmatch ("animdone", "end");
		}
	}
	else if (num == 2)
	{
		while (1)
		{
			level.medic animscripted("animdone", level.medic_node.origin, level.medic_node.angles, level.scr_anim["medic"]["idle2"]);
			level.medic waittillmatch ("animdone", "end");
		}
	}
}

First_Mortar()
{
	org = getent ("mortar_first_org","targetname");
	ground = getent ("mortar_first","targetname");
	
	level waittill ("FirstMortar");
	
	org maps\_mortar::activate_mortar(0, 0, 0, undefined, undefined, undefined);
	if (isdefined (ground))
		ground delete();
}

Wounded_Idle()
{
	wounded_node = getnode ("wounded_node", "targetname");
	if (isdefined (wounded_node))
	{
		level endon ("Wounded_StopIdle");
		while (1)
		{
			level.wounded animscripted("animdone", wounded_node.origin, wounded_node.angles, level.scr_anim["wounded"]["idle"]);
			level.wounded waittillmatch ("animdone", "end");
		}
	}
}

Wounded_Idle2()
{
	self endon ("death");
	level endon ("Wounded_StopIdle2");
	org = self.origin;
	ang = self.angles;
	while (1)
	{
		self animscripted("animdone", org, ang, level.scr_anim["wounded"]["idle"]);
		level.wounded.allowDeath = 0;
		self waittillmatch ("animdone", "end");
	}
}

moody_pickup_notes(note)
{
	self endon ("StopNotes");
	while (1)
	{
		self waittill ("moodypickup", notetrack);
		if (notetrack == "anim_gunhand = \"none\"")
			self animscripts\shared::PutGunInHand("none");
	}
}

Moody_PickUp()
{
	level.moody endon ("death");
	level.moody endon ("putdown");
	
	trig = getent ("wounded_area","targetname");
	wounded_node_moody = getnode ("wounded_node_moody","targetname");
	wounded_node = getnode ("wounded_node","targetname");
	climbout_node = getnode ("moody_climbout","targetname");
	
	level.moody thread maps\_utility::cant_shoot();
	level.moodyoldbravery = level.moody.bravery;
	level.moody.bravery = 1000000;
	level.moody.ignoreme = true;
	level.moody.goalradius = 2;
	level.moody setgoalnode (climbout_node);
	
	moody_climbup = getent ("moody_climbup","targetname");
	while ( (isalive(level.moody)) && (!(level.moody istouching (moody_climbup))) )
		wait .25;
	
	level.moody.desired_anim_pose = "crouch";
	level.moody animscripts\utility::UpdateAnimPose();
	level.moody.anim_movement = "walk";
	level.moody animscripted("climboutdone", (climbout_node.origin[0], climbout_node.origin[1], climbout_node.origin[2] + 10), climbout_node.angles, level.scr_anim["moody"]["getout"]);
	level.moody setgoalnode(wounded_node_moody);
	level.moody waittillmatch ("climboutdone", "end");
	
	while ( (isalive(level.moody)) && (!(level.moody istouching (trig))) )
		wait .5;
	
	level notify ("FirstMortar");
	level notify ("Wounded_StopIdle");
	
	level.moody thread moody_pickup_notes();
	level.moody animscripted("moodypickup", wounded_node_moody.origin, wounded_node_moody.angles, level.scr_anim["moody"]["pickup"]);
	level.wounded animscripted("scriptedanimdone", wounded_node.origin, wounded_node.angles, level.scr_anim["wounded"]["pickup"]);
	level.flags["GotWounded"] = true;
	level.moody.ignoreme = false;
	level.flags["MoodyCanDie"] = true;
	level.moody waittillmatch ("moodypickup", "end");
	level.moody notify ("StopNotes");
	
	level.moody thread Moody_WalkBack();
	level thread Moody_DeathwithWounded();
}

Moody_WalkBack()
{
	level.moody endon ("death");
	level.moody endon ("putdown");
	
	thread Moody_PutDown();
	
	allies = getaiarray ("allies");
	for (i=0;i<allies.size;i++)
	{
		if ( (isdefined (allies[i])) && (isalive (allies[i])) )
			allies[i].threatbias = 0;
	}
	allies = undefined;
	
	level.moody.threatbias = 50000;
	
	offset = (0, 0, 0);
	node = getnode ("wounded_node_moody","targetname");
	endtrig = getent ("moody_end","targetname");
	
	while ( (!(self istouching (endtrig))) && (isalive (self)) )
	{
		level.moody animscripted("scriptedanimdone", node.origin + offset, (node.angles[0], node.angles[1] + 180, node.angles[2]), level.scr_anim["moody"]["walkback"]);
		level.wounded animscripted("scriptedanimdone", node.origin + offset, (node.angles[0], node.angles[1] + 180, node.angles[2]), level.scr_anim["wounded"]["walkback"]);
		
		level.moody.allowDeath = 0;
		
		level.moody waittillmatch ("scriptedanimdone", "end");
		offset += getCycleOriginOffset((node.angles[0], node.angles[1] + 180, node.angles[2]), level.scr_anim["moody"]["walkback"]);
	}
}

Moody_PutDown()
{
	level.moody endon ("death");
	level.moody endon ("putdown");
	
	endtrig = getent ("moody_end","targetname");
	endnode = getnode ("moody_end_node","targetname");
	
	while (!(self istouching (endtrig)))
		wait .2;
	
	level.moody.threadbias = -1;
	
	if (level.flags["moodydied"] == false)
	{
		level.moody.health = 1000000;
		level.moody thread maps\_utility::magic_bullet_shield();
		level.flags["MoodyCanDie"] = false;
		level.moody thread Moody_Health();
		
		level.player thread player_notallowed();
		
		level.wounded.allowDeath = 0;
		level.moody.allowdeath = 0;
		
		level notify ("WoundedBack");
		level.moody notify ("putdown");
		
		level.moody animscripted("scriptedanimdone", endnode.origin, endnode.angles, level.scr_anim["moody"]["putdown"]);
		level.wounded animscripted("scriptedanimdone", endnode.origin, endnode.angles, level.scr_anim["wounded"]["putdown"]);
		
		level.moody animscripts\shared::DoNoteTracks("scriptedanimdone");
		level notify ("MoodyIsDone");
		clip = getent ("player_notallowed_clip","targetname");
		if (isdefined (clip))
			clip notsolid();
		level.wounded thread Wounded_Idle2();
	}
}

player_notallowed()
{
	level endon ("MoodyIsDone");
	area = getent ("player_notallowed","targetname");
	while (1)
	{
		if (self istouching (area))
		{
			clip = getent ("player_notallowed_clip","targetname");
			movetime = .35;
			dummy = spawn ("script_origin",(level.player.origin));
			self playerlinkto (dummy);
			dummy moveTo((-3584, self.origin[1], self.origin[2]), movetime, .05, .05);
			wait movetime;
			clip solid();
			self unlink();
			return;
		}
		else
		{
			wait (0.05);
		}
	}
}

player_doorfailsafe()
{
	level endon ("DoorIsOpen");
	area = getent ("doorfailsafe","targetname");
	while (1)
	{
		if (level.player istouching (area))
		{
			movetime = .35;
			dummy = spawn ("script_origin",(level.player.origin));
			level.player playerlinkto (dummy);
			dummy movex(64, movetime, .05, .05);
			wait movetime;
			return;
		}
		else
		{
			wait (0.05);
		}
	}
}

Moody_DeathwithWounded()
{
	level endon ("WoundedBack");
	wait 1.5;
	dmgtaken = 0;
	while (dmgtaken < level.moody_woundedsequence_health)
	{
		level.moody waittill ("damage",damage,attacker);
		if (attacker == level.player)
		{
			if ( (isdefined (ai.damagelocation)) && (ai.damagelocation == "none") )
				continue;
			level thread maps\_spawner::killfriends_missionfail();
			return;
		}
		level.moody.maxhealth = level.moody.health;
		dmgtaken = (dmgtaken + damage);
	}
	
	level.flags["moodydied"] = true;
	level notify ("MoodyIsDone");
	
	trace = bulletTrace((level.moody.origin + (0,0,25)), (level.moody.origin-(0,0,5000)), false, undefined);
	level.moodyfall_origin = trace["position"];
	level.moodyfall_angles = level.moody.angles;
	
	badplace_cylinder("moody", -1, level.moodyfall_origin, 75, 300, "neutral");
	
	level thread moody_dodeath_animloop();
	level thread wounded_dodeath_animloop();
}

moody_dodeath_animloop()
{	
	level.moody.health = 1000000;
	level.moody.maxhealth = (level.moody.health * 20);
	level.moody endon ("death");//failsafe
	level.moody.allowdeath = 0;
	level.moody animscripted("deathanim", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["moody"]["death"]);
	level.moody waittillmatch ("deathanim","end");
	level.moodyfall_origin = level.moody.origin;
	level.moodyfall_angles = level.moody.angles;
	while (1)
	{
		level.moody animscripted("deathanimloop", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["moody"]["deathidle"]);
		level.moody waittillmatch ("deathanimloop","end");
	}
}

wounded_dodeath_animloop()
{		
	level.wounded.health = 1000000;
	level.wounded thread maps\_utility::magic_bullet_shield();
	level.wounded.maxhealth = (level.wounded.health * 20);
	level.wounded endon ("death");//failsafe
	level.wounded.allowdeath = 0;
	level.wounded animscripted("deathanim", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["wounded"]["death"]);
	level.wounded waittillmatch ("deathanim","end");
	org = level.moody.origin;
	while (1)
	{
		level.wounded animscripted("deathanimloop", org, level.moodyfall_angles, level.scr_anim["wounded"]["deathidle"]);
		level.wounded waittillmatch ("deathanimloop","end");
	}
}

mg42_autofire()
{
	mg42_1 = getent ("auto1333","targetname");
	mg42_2 = getent ("auto1151","targetname");
	
	getent ("mg42_start","targetname") waittill ("trigger");
	
	if (isdefined (mg42_1))
		mg42_1 thread mg42_shoot();
	
	if (isdefined (mg42_2))
		mg42_2 thread mg42_shoot();
}

mg42_shoot()
{
	level endon ("StopMG42_Fire");
	targets = getentarray ("mg42_target","targetname");
	while (1)
	{
		self settargetentity ( targets[(randomint(targets.size))] );
		wait (1 + randomfloat (2.5));
	}
}


Moody_GetPapers_wait()
{
	level endon ("documents gotten");
	trig = getent ("moody_getpapers_trig","targetname");
	while (1)
	{
		trig waittill ("trigger",other);
		if (other == self)
			if (level.flags["GotDocs"] == false)
			{
				self thread Moody_GetPapers();
				return;
			}
	}
}

Moody_GetPapers()
{
	if (level.flags["GotDocs"] == false)
	{
		self thread Moody_GetPapers_Tracks();
		self animscripted("getpapersanim", self.origin, (0,180,0), level.scr_anim["body"]["getpapers"]);
		self waittillmatch ("getpapersanim","end");
	}
}

Moody_GetPapers_Tracks(note)
{
	while (1)
	{
		self waittill ("getpapersanim", notetrack);
		if (notetrack == "dialogue")
		{
			self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["getpapers"], "brecourt_moody_074", 1.0);
			self waittill ("getpapersdialogue");
			while (level.flags["GotDocs"] == false)
				wait (0.25);
			self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["getout"], "brecourt_moody_075", 1.0);
			return;
		}
	}
}

gunnotes(note)
{
	self endon ("STOP GUN NOTES");
	while (1)
	{
		self waittill ("animdone", notetrack);
		if (notetrack == "anim_gunhand = \"left\"")
			self animscripts\shared::PutGunInHand("left");
		else if (notetrack == "anim_gunhand = \"right\"")
			self animscripts\shared::PutGunInHand("right");
	}
}

Moody_KickDoor(note)
{
	bunkerdoor2 = getent ("bunkerdoor2","targetname");
	while (1)
	{
		self waittill ("kickdooranim", notetrack);
		if (notetrack == "kick")
		{
			bunkerdoor2 connectpaths();
			bunkerdoor2 playsound ("wood_door_kick");
			bunkerdoor2 rotateyaw(-90, .25,0.1,0.1);
			return;
		}
	}
}

medic_death(note)
{
	soundent = getent ("deathsound","targetname");
	start = getent ("medic_bullet","targetname");
	end = getent (start.target,"targetname");
	startloc = start.origin;
	endloc = end.origin;
	while (1)
	{
		self waittill ("medicfinalanim", notetrack);
		if (notetrack == "dialogue")
		{
			thread start_tracer(startloc,endloc,start);
		}
		else if (notetrack == "death")
		{
			self thread maps\brecourt_anim::popHelmet();
			thread maps\_fx::OneShotfx("blood", soundent.origin, 0);
			thread maps\_utility::playSoundinSpace("bullet_large_flesh", soundent.origin);
			self thread animscripts\face::SayGenericDialogue("death");
			return;
		}
	}
}

start_tracer(start,end,soundent)
{
	wait 2;
	for (i=0;i<14;i++)
	{	
		soundent playsound ("weap_mp44_fire");	
		bulletTracer(start, end);
		wait (0.0857);
	}
}

fake_german_gunshots()
{
	level endon ("stop fake gunshots");
	
	soundent1 = spawn ("script_origin",(-4744, 5096, 24));
	soundent2 = spawn ("script_origin",(-4552, 5272, 24));
	soundent3 = spawn ("script_origin",(-4104, 5384, 24));
	soundent4 = spawn ("script_origin",(-3800, 5480, 24));
	
	soundent1 thread fake_german_gunshots_go("mp40");
	soundent2 thread fake_german_gunshots_go("mp44");
	soundent3 thread fake_german_gunshots_go("kar98k");
	soundent4 thread fake_german_gunshots_go("mp40");
	
}

fake_german_gunshots_go(guntype)
{
	level endon ("stop fake gunshots");
	
	if (!isdefined (guntype))
		return;
	
	if (guntype == "mp40")
	{
		while (1)
		{
			wait (2 + randomfloat(2));
			shots = randomint(10);
			for (i=0;i<shots;i++)
			{
				self playsound ("weap_mp40_fire");
				wait (0.12);
			}
		}
	}
	else if (guntype == "mp44")
	{
		while (1)
		{
			wait (2 + randomfloat(2));
			shots = randomint(10);
			for (i=0;i<shots;i++)
			{
				self playsound ("weap_mp44_fire");
				wait (0.12);
			}
		}
	}
	else if (guntype == "kar98k")
	{
		while (1)
		{
			wait (2 + randomfloat(2));
			shots = randomint(3);
			for (i=0;i<shots;i++)
			{
				self playsound ("weap_kar98k_fire");
				wait (1);
			}
		}
	}
	
	
	
}