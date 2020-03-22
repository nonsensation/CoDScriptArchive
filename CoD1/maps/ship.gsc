main()
{
	setExpFog(0.00013, 0, 0, 0, 0);

	precacheModel("xmodel/ship_opening_light");
	precacheModel("xmodel/soldbuch");
	precacheModel("xmodel/explosivepack");
	precacheModel("xmodel/objective_bookopen");
	precacheItem("item_health");
	precacheItem("luger");

	maps\_load::main();
	maps\_music::main();
	maps\ship_fx::main();
	maps\ship_anim::main();
	maps\ship_anim::boat();
	maps\ship_anim::phone();

	level.ambient_track["exterior"] = "ambient_ship_ext";
	level.ambient_track["interior"] = "ambient_ship_int";
	thread maps\_utility::set_ambient("exterior");

//	thread maps\_adjustfog::adjustExpFog(); //temp

	level.price = getent("price", "targetname");
	level.price.walkdist = 512;
	level.price character\_utility::new();
	level.price character\price_disguised::main();
	level.price thread maps\_utility::magic_bullet_shield();
	level.price allowedStances("stand");	//needed?
	level.price.weapon = "none";
	level.price animscripts\shared::putGunInHand("none");
	level.price.animname = "price";
	level.price.walk_noncombatanim = level.scr_anim[level.price.animname]["unarmedwalk"];
	level.price.walk_noncombatanim2 = level.scr_anim[level.price.animname]["unarmedwalk"];
	level.price.run_noncombatanim = level.scr_anim[level.price.animname]["unarmedrun"];
	level.price.standanim = level.scr_anim[level.price.animname]["unarmedstand"];
	level.price.hack_groundtype = "metal";

	level.waters = getent("waters", "targetname");
	level.waters character\_utility::new();
	level.waters character\waters_disguised::main();
	level.waters thread maps\_utility::magic_bullet_shield();
	level.waters allowedStances("stand");	//needed?
	level.waters.weapon = "none";
	level.waters animscripts\shared::putGunInHand("none");
	level.waters.animname = "waters";

	level.deadgerman = getent("deadgerman", "targetname");
	level.deadgerman.weapon = "none";
	level.deadgerman animscripts\shared::putGunInHand("none");
	level.deadgerman.animname = "deadgerman";

	level.boat = getent("boat", "targetname");
	level.boat.animname = "boat";
	level.boat UseAnimTree(level.scr_animtree[level.boat.animname]);
	level.boat playsound("ship_boat_ride");
	
	level.boatrig = getent("boatrig", "targetname");
	level.boatrig.animname = "boatrig";
	level.boatrig UseAnimTree(level.scr_animtree["boat"]);

	level.shipdeck_officer = getent("shipdeck_officer", "targetname");
	level.shipdeck_officer.walkdist = 9999;
	level.shipdeck_officer.weapon = "none";
	level.shipdeck_officer animscripts\shared::putGunInHand("none");
	level.shipdeck_officer.animname = "shipdeck_officer";
	level.shipdeck_officer.walk_noncombatanim = level.scr_anim[level.shipdeck_officer.animname]["unarmedwalk"];
	level.shipdeck_officer.walk_noncombatanim2 = level.scr_anim[level.shipdeck_officer.animname]["unarmedwalk"];
	level.shipdeck_officer.run_noncombatanim = level.scr_anim[level.shipdeck_officer.animname]["unarmedrun"];
	level.shipdeck_officer.standanim = level.scr_anim[level.shipdeck_officer.animname]["unarmedstand"];

	level.shipdeck_soldier = getent("shipdeck_soldier", "targetname");
	level.shipdeck_soldier.animname = "shipdeck_soldier";

	level.mp40guy = getent("mp40guy", "targetname");
	level.mp40guy.animname = "mp40guy";
	level.mp40guy.deathanim = level.scr_anim[level.mp40guy.animname]["death"];

	level.pistolguy = getent("pistolguy", "targetname");
	level.pistolguy.weapon = "none";
	level.pistolguy animscripts\shared::putGunInHand("none");
	level.pistolguy.animname = "pistolguy";
	level.pistolguy.deathanim = level.scr_anim[level.pistolguy.animname]["death"];

	level.phone = getent("phone", "targetname");
	level.phone.animname = "phone";
	level.phone UseAnimTree(level.scr_animtree[level.phone.animname]);

	level.hangar_soldier1 = getent("hangar_soldier1", "targetname");
	level.hangar_soldier1.walkdist = 9999;
	level.hangar_soldier1.weapon = "none";
	level.hangar_soldier1 animscripts\shared::putGunInHand("none");
	level.hangar_soldier1.animname = "hangar_soldier1";
	level.hangar_soldier1.walk_noncombatanim = level.scr_anim[level.hangar_soldier1.animname]["unarmedwalk"];
	level.hangar_soldier1.walk_noncombatanim2 = level.scr_anim[level.hangar_soldier1.animname]["unarmedwalk"];
	level.hangar_soldier1.run_noncombatanim = level.scr_anim[level.hangar_soldier1.animname]["unarmedrun"];
	level.hangar_soldier1.standanim = level.scr_anim[level.hangar_soldier1.animname]["unarmedstand"];

	level.hangar_soldier2 = getent("hangar_soldier2", "targetname");
	level.hangar_soldier2.walkdist = 9999;
	level.hangar_soldier2.weapon = "none";
	level.hangar_soldier2 animscripts\shared::putGunInHand("none");
	level.hangar_soldier2.animname = "hangar_soldier2";
	level.hangar_soldier2.walk_noncombatanim = level.scr_anim[level.hangar_soldier2.animname]["unarmedwalk"];
	level.hangar_soldier2.walk_noncombatanim2 = level.scr_anim[level.hangar_soldier2.animname]["unarmedwalk"];
	level.hangar_soldier2.run_noncombatanim = level.scr_anim[level.hangar_soldier2.animname]["unarmedrun"];
	level.hangar_soldier2.standanim = level.scr_anim[level.hangar_soldier2.animname]["unarmedstand"];

	level.radars_done = false;
	level.navallog_done = false;

	thread pacify_ai();
	thread disable_spawner_triggers();
	thread delete_triggers();
//	thread disable_spawners();
//	thread enable_spawners();
	thread open_door1();
	thread move_radars();
	thread change_fog();
	thread flash_morsecode();
	thread unlink_player();
	thread price_past_magicdoor_trigger();
	thread kill_price_trigger();

	thread opening_sequence();
	thread boarding_sequence();
	thread hangar_sequence();
	thread armory_sequence();

	thread get_boilerbombs_objective();
	thread plant_boilerbombs_objective();
	thread destroy_radars_objective();
	thread get_navallog_objective();
	thread goto_boat_objective();

	thread init_anims();
	thread temp_dialog();
	
	thread music();
}

init_anims()
{
	node = getnode("boardnode", "targetname");

	shipdeck_officer[0] = level.shipdeck_officer;
	thread maps\_anim::anim_teleport(shipdeck_officer, "easeidle teleport", undefined, node);
	thread maps\_anim::anim_loop(shipdeck_officer, "easeidle", undefined, "endloop_shipdeck_officer", node);

	shipdeck_soldier[0] = level.shipdeck_soldier;
	thread maps\_anim::anim_teleport(shipdeck_soldier, "easeidle teleport", undefined, node);
	thread maps\_anim::anim_loop(shipdeck_soldier, "easeidle", undefined, "endloop_shipdeck_soldier", node);
	level.shipdeck_soldier setgoalpos(level.shipdeck_soldier.origin);

	node = getnode("armorynode", "targetname");

	mp40guy[0] = level.mp40guy;
	thread maps\_anim::anim_teleport(mp40guy, "easeidle teleport", undefined, node);
	thread maps\_anim::anim_loop(mp40guy, "easeidle", undefined, "endloop_mp40guy", node);

	pistolguy[0] = level.pistolguy;
	thread maps\_anim::anim_teleport(pistolguy, "easeidle teleport", undefined, node);
	thread maps\_anim::anim_loop(pistolguy, "easeidle", undefined, "endloop_pistolguy", node);
	
	phone[0] = level.phone;
	level.phone thread maps\_anim::anim_loop(phone, "idle", undefined, "endloop_phone", node);
}

pricearmory_fire()
{
	level.price waittillmatch("single anim", "attach_pistol = \"right\"");
	level.price.weapon = "luger";
	level.price animscripts\shared::putGunInHand("right");

	level.price waittillmatch("single anim", "fire");
	level.price shoot();

	level.price waittillmatch("single anim", "fire");
	level.price shoot();
}

kill()
{
	self waittillmatch("single anim", "end");
	self.allowdeath = true;
	self doDamage((self.health + 1), (0, 0, 0));
}

opening_sequence()
{
	objective_add(1, "active", &"SHIP_OBJ1", (4312, 43, 26));
	objective_current(1);

	level.boat linkTo(level.boatrig, "tag_boat", (0,0,0), (0,0,0));
	level.player linkTo(level.boat, "tag_player", (40,0,0), (0,0,0));
	level.price linkTo(level.boat, "tag_boat", (0,0,0), (0,0,0));
	level.waters linkTo(level.boat, "tag_boat", (0,0,0), (0,0,0));
	level.deadgerman linkTo(level.boat, "tag_boat", (0,0,0), (0,0,0));

	wait .5;
	level.deadgerman playsound("bodysplash");

	level waittill("starting final intro screen fadeout");

	boat[0] = level.boat;
	boatrig[0] = level.boatrig;

	boatnode = getnode("boatnode", "targetname");

	level.deadgerman thread delete_deadgerman();

	level.boatrig thread maps\_anim::anim_single(boat, "opening", "tag_boat");
	thread animate_price();
	thread animate_others();
	maps\_anim::anim_single(boatrig, "opening", undefined, boatnode);
	maps\_anim::anim_loop(boatrig, "opening_loop", undefined, undefined, boatnode);
}

animate_price()
{
	price[0] = level.price;

	level.boat maps\_anim::anim_single(price, "opening", "tag_boat");

	level.price unlink();
	level notify("begin_boarding_sequence");
}

animate_others()
{
	guys[0] = level.deadgerman;
	guys[1] = level.waters;

	level.boat maps\_anim::anim_single(guys, "opening", "tag_boat");

	waters[0] = level.waters;
	level.boat maps\_anim::anim_loop(waters, "opening_loop", "tag_boat", "endloop_waters");
}

unlink_player()
{
	level.price waittillmatch("single anim", "release player");
	level.player unlink();
}

delete_deadgerman()
{
	wait 5.75;
	self playsound("bodysplash");
	self waittillmatch("single anim", "end");
	self delete();
}

boarding_sequence()
{
	level waittill("begin_boarding_sequence");

	level notify("endloop_shipdeck_officer");
	level notify("endloop_shipdeck_soldier");

	thread shipdeck_soldier_sequence();

	paperguys[0] = level.price;
	paperguys[1] = level.shipdeck_officer;
	node = getnode("boardnode", "targetname");
	maps\_anim::anim_reach(paperguys, "papers", undefined, node);
	maps\_anim::anim_single(paperguys, "papers", undefined, node);

	maps\_utility::autosave(1);

	level notify("endloop_attentionidle");
	level.shipdeck_officer thread walkpath();

	objective_state(1, "done");
	objective_add(2, "active", &"SHIP_OBJ2", (4352, -229, -125));
	objective_current(2);

	level.price.followmin = 2; // atleast 2 nodes ahead
	level.price.followmax = 3; // no more than 3 nodes ahead
	level.price.goalradius = 256;
	level.price setgoalentity(level.player);
	
	level notify("ship_loop");
}

walkpath()
{
	targetnode = getnode(self.target, "targetname");

	while(isalive(self))
	{
		self setgoalnode(targetnode);
		self waittill("goal");

		if(isdefined(targetnode.target))
			targetnode = getnode(targetnode.target, "targetname");
		else
			break;
	}
}

shipdeck_soldier_sequence()
{
	node = getnode("boardnode", "targetname");

	shipdeck_soldier[0] = level.shipdeck_soldier;
	maps\_anim::anim_single(shipdeck_soldier, "easetrans", undefined, node);
	level thread maps\_anim::anim_loop(shipdeck_soldier, "attentionidle", undefined, "endloop_attentionidle", node);

	level waittill("endloop_attentionidle");
	
	maps\_anim::anim_single(shipdeck_soldier, "presentarms", undefined, node);
	maps\_anim::anim_loop(shipdeck_soldier, "attentionidle", undefined, undefined, node);
}

hangar_sequence()
{
	trigger = getent("hangar_sequence_trigger", "targetname");
	trigger waittill("trigger");

	level notify("temp_dialog1");

	hangar_soldier1 = getent("hangar_soldier1", "targetname");
	hangar_soldier1 setgoalnode(getnode("soldier1node", "targetname"));
	
	hangar_soldier2 = getent("hangar_soldier2", "targetname");
	hangar_soldier2 setgoalnode(getnode("soldier2node", "targetname"));

	hangardoor = getent("hangardoor", "targetname");
	hangardoor playsound("hanger_door");
	hangardoor moveY(320, 10);
	hangardoor update_paths();
	hangardoor waittill("movedone");
	hangardoor disconnectpaths();
}

update_paths()
{
	self endon("movedone");
	
	while(1)
	{
		self disconnectpaths();
		wait .5;
	}
}

price_past_magicdoor_trigger()
{
	level.price_past_magicdoor = 0;

	trigger = getent("price_past_magicdoor_trigger", "targetname");
	trigger waittill("trigger");

	level.price_past_magicdoor = 1;
}

kill_price_trigger()
{
	trigger = getent("kill_price_trigger", "targetname");
	trigger waittill("trigger");

	level.price notify ("stop magic bullet shield");
	level.price.allowdeath = true;

	if(isalive(level.price))
		level.price doDamage((level.price.health + 1), (0, 0, 0));

	thread maps\_spawner::kill_spawnerNum(7);
		
	nodekiller = getent("nodekiller", "targetname");
	nodekiller.origin += (0, 0, -10000);
	nodekiller disconnectpaths();
	nodekiller delete();

	getent("armorydoor", "targetname") thread swing_door(-90); // Open
}

armory_sequence()
{
	trigger = getent("armory_sequence_trigger", "targetname");
	trigger waittill("trigger");

	objective_state(2, "done");
	level notify("begin_get_boilerbombs_objective");

	while(!level.price_past_magicdoor)
		wait .5;
	
	getent("magicdoor", "targetname") thread swing_door(-90);
	thread pricearmory_fire();

	price[0] = level.price;
	maps\_anim::anim_reach(price, "armory", undefined, getnode("armorynode", "targetname"));

	level notify("endloop_mp40guy");
	level notify("endloop_pistolguy");
	level notify("endloop_phone");

	level.mp40guy thread kill();
	level.pistolguy thread kill();

	level.price.walk_noncombatanim = undefined;
	level.price.walk_noncombatanim2 = undefined;
	level.price.standanim = undefined; // Stop arm crossing stand anim since he has a weapon now

	thread ship_action_notify();
	
	all[0] = level.mp40guy;
	all[1] = level.pistolguy;
	all[2] = level.price;
	all[3] = level.phone;
	maps\_anim::anim_single(all, "armory", undefined, getnode("armorynode", "targetname"));

	thread delete_armoryblocker();

	level.price.goalradius = 0;
	level.price.walkdist = 16;
	level.price setgoalnode(getnode("getweaponnode", "targetname"));
	level.price waittill("goal");
	level.price.weapon = "mp40";

	level.price.run_noncombatanim = undefined;

	thread soundAlarm();

	level.price setgoalnode(getnode("pricefightnode", "targetname"));
	level.price waittill("goal");

	level.price.goalradius = 128;

	maps\_utility::autosave(2);
}

soundAlarm()
{
	wait 1;
	origin = spawn("script_origin", (3432, 64, 852));
	origin playloopsound("ship_alarm");
	
	wait 20;
	origin stoploopsound();
}

ship_action_notify()
{
	wait 4;
	musicStop(6);
	wait 13.5;
	level notify("ship_action");
}

delete_armoryblocker()
{
	wait 1;
	getent("armoryblocker", "targetname") delete();
}

get_boilerbombs_objective()
{
	getent("open_door1_trigger", "targetname") thread maps\_utility::triggerOff();

	level waittill("begin_get_boilerbombs_objective");

	get_boilerbombs_trigger = getent("get_boilerbombs_trigger", "targetname");

	objective_add(3, "active", &"SHIP_OBJ3", get_boilerbombs_trigger.origin);
	objective_current(3);

	get_boilerbombs_trigger setHintString(&"SCRIPT_HINTSTR_PICKUPEXPLOSIVES");
	get_boilerbombs_trigger waittill("trigger");

	objective_state(3, "done");

	// Delete get_boilerbombs_trigger and it's targeted models
	models = getentarray(get_boilerbombs_trigger.target, "targetname");
	for(i = 0; i < models.size; i++)
		models[i] delete();
	get_boilerbombs_trigger delete();

	// Turn on spawner_triggers
	thread enable_spawner_triggers();

	// Delete patrollers
	ai = getaiarray("axis");
	for(i = 0; i < ai.size; i++)
	{
		if(isdefined(ai[i].script_patroller))
		ai[i] delete();
	}
	level.shipdeck_officer delete();
	level.shipdeck_soldier delete();
	level.hangar_soldier1 delete();
	level.hangar_soldier2 delete();

	if(isalive(level.price))
		level.price.pacifist = false;

	// Enable open door1 trigger
	getent("open_door1_trigger", "targetname") thread maps\_utility::triggerOn();

	level notify("begin_plant_boilerbombs_objective");
}

plant_boilerbombs_objective()
{
	// Turn off plant_boilerbomb_triggers and hide their targeted models
	plant_boilerbomb_triggers = getentarray("plant_boilerbomb_trigger", "targetname");
	for(i = 0; i < plant_boilerbomb_triggers.size; i++)
	{
		plant_boilerbomb_triggers[i] thread maps\_utility::triggerOff();

		if(isdefined(plant_boilerbomb_triggers[i].target))
			getent(plant_boilerbomb_triggers[i].target, "targetname") hide();
	}

	level waittill("begin_plant_boilerbombs_objective");

	level.boilerbombs_count = plant_boilerbomb_triggers.size;
	objective_add(4, "active","", get_objective_position("plant_boilerbomb_trigger"));
	objective_string(4,&"SHIP_OBJ4" ,level.boilerbombs_count);
	objective_current(4);

	// Turn on plant_boilerbomb_triggers, show their targeted models, and run plant_boilerbombs_trigger threads
	for(i = 0; i < plant_boilerbomb_triggers.size; i++)
	{
		plant_boilerbomb_triggers[i] thread maps\_utility::triggerOn();

		if(isdefined(plant_boilerbomb_triggers[i].target))
			getent(plant_boilerbomb_triggers[i].target, "targetname") show();

		thread plant_boilerbomb_trigger(plant_boilerbomb_triggers[i]);
	}

	level waittill("boilerbombs_planted");

	objective_state(4, "done");

	triggers = getentarray("trigger_once", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "spawner_trigger_grenadeguy")
			triggers[i] thread maps\_utility::triggerOn();
	}

	triggers = getentarray("trigger_multiple", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "spawner_trigger_grenadeguy")
			triggers[i] thread maps\_utility::triggerOn();
	}

	getent("magicdoor", "targetname") thread swing_door(90); // Open
	getent("rightdoor", "targetname") thread swing_door(90); // Open
	getent("leftdoor", "targetname") thread swing_door(-90); // Open
	getent("middledoor", "targetname") thread swing_door(-90); // Open

	level notify("begin_destroy_radars_objective");
	level notify("begin_get_navallog_objective");
}

plant_boilerbomb_trigger(trigger)
{
	trigger setHintString(&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	trigger waittill("trigger");

	// Change model to planted version and delete trigger
	plantedmodel = getent(trigger.target, "targetname");
	plantedmodel setmodel("xmodel/explosivepack");
	plantedmodel playsound("explo_plant_no_tick");
	trigger delete();

	level.boilerbombs_count--;
	objective_string(4, &"SHIP_OBJ4", level.boilerbombs_count);

	if(level.boilerbombs_count > 0)
		objective_position(4, get_objective_position("plant_boilerbomb_trigger"));
	else
		level notify("boilerbombs_planted");
}

get_objective_position(targetname)
{
	triggers = getentarray(targetname, "targetname");

	chosen_trigger = triggers[0];

	for(i = 1; i < triggers.size; i++)
	{
		if(triggers[i].script_order < chosen_trigger.script_order)
			chosen_trigger = triggers[i];
	}

	return chosen_trigger.origin;
}

destroy_radars_objective()
{
	// Hide destroyed radars
	destroy_radar_triggers = getentarray("destroy_radar_trigger", "targetname");
	for(i = 0; i < destroy_radar_triggers.size; i++)
	{
		radar_brush_intact = getent(destroy_radar_triggers[i].target, "targetname");
		radar_brush_destroyed = getent(radar_brush_intact.target, "targetname");
		radar_brush_destroyed hide();
	}

	level waittill("begin_destroy_radars_objective");

	level.radars_count = destroy_radar_triggers.size;
	objective_add(5, "active","", get_objective_position("destroy_radar_trigger"));
	objective_string(5,&"SHIP_OBJ5",level.radars_count);
	objective_current(5);

	for(i = 0; i < destroy_radar_triggers.size; i++)
	{
		thread destroy_radar_trigger(destroy_radar_triggers[i]);
	}

	level waittill("radars_destroyed");
	objective_state(5, "done");
	level.radars_done = true;
	
	if(!level.navallog_done)
		objective_current(6);
}

destroy_radar_trigger(trigger)
{
	trigger waittill("trigger");

	// Swap to damaged version and delete trigger
	radar_brush_intact = getent(trigger.target, "targetname");
	radar_brush_intact hide();
	radar_brush_destroyed = getent(radar_brush_intact.target, "targetname");
	radar_brush_destroyed show();
	radar_brush_destroyed playsound("explo_radio");
	trigger delete();

	level.radars_count--;
	objective_string(5,&"SHIP_OBJ5", level.radars_count);

	if(level.radars_count > 0)
		objective_position(5, get_objective_position("destroy_radar_trigger"));
	else
		level notify("radars_destroyed");
}

get_navallog_objective()
{
	get_navallog_trigger = getent("get_navallog_trigger", "targetname");
	get_navallog_trigger thread maps\_utility::triggerOff();

	level waittill("begin_get_navallog_objective");

	// Enable the trigger and change to objective version of the model
	get_navallog_trigger thread maps\_utility::triggerOn();
	model = getent(get_navallog_trigger.target, "targetname");
	model setmodel("xmodel/objective_bookopen");

	objective_add(6, "active", &"SHIP_OBJ6", model.origin);
	objective_current(6);

	get_navallog_trigger setHintString(&"SCRIPT_HINTSTR_PICKUPPATROLLOGS");
	get_navallog_trigger waittill("trigger");
	get_navallog_trigger delete();
	model delete();
	level.player playsound("paper_pickup");

	objective_state(6, "done");
	level.navallog_done = true;
}

goto_boat_objective()
{
	goto_boat_trigger = getent("goto_boat_trigger", "targetname");
	goto_boat_trigger thread maps\_utility::triggerOff();

	while(!level.radars_done || !level.navallog_done)
		wait .5;
	maps\_utility::autosave(4);

	objective_add(7, "active", &"SHIP_OBJ7", level.waters.origin);
	objective_current(7);

	goto_boat_trigger = getent("goto_boat_trigger", "targetname");
	goto_boat_trigger thread maps\_utility::triggerOn();

	level.boat notify("endloop_waters");

	waters[0] = level.waters;
	level.boat thread maps\_anim::anim_loop(waters, "ending_loop", "tag_boat", "endloop_waters");
	level.waters thread animscripts\shared::LookAtEntity(level.player, 999999, "alert");

	goto_boat_trigger waittill("trigger");

	level.boat notify("endloop_waters");
	objective_state(7, "done");

	waters[0] = level.waters;
	level.boat thread maps\_anim::anim_single(waters, "lost", "tag_boat");
	wait 7;

	setCvar("ui_campaign", "russian");
	missionSuccess("ru_stalingrad", false);
}

open_door1()
{
	trigger = getent("open_door1_trigger", "targetname");
	trigger waittill("trigger");

	getent(trigger.target, "targetname") thread swing_door(-90); // Open
}

swing_door(degrees)
{
	self rotateYaw(degrees, .2, .1, .1);
	self waittill("rotatedone");
	self disconnectpaths();
}

pacify_ai()
{
	ai = getaiarray("axis", "allies");
	for(i = 0; i < ai.size; i++)
	{
		ai[i].pacifist = true;
	}
}

unpacify_ai()
{
	ai = getaiarray("axis", "allies");
	for(i = 0; i < ai.size; i++)
	{
		ai[i].pacifist = false;
	}
}

disable_spawner_triggers()
{
	triggers = getentarray("trigger_once", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && ((triggers[i].script_noteworthy == "spawner_trigger") || (triggers[i].script_noteworthy == "spawner_trigger_grenadeguy")))
			triggers[i] thread maps\_utility::triggerOff();
	}

	triggers = getentarray("trigger_multiple", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && ((triggers[i].script_noteworthy == "spawner_trigger") || (triggers[i].script_noteworthy == "spawner_trigger_grenadeguy")))
			triggers[i] thread maps\_utility::triggerOff();
	}
}

enable_spawner_triggers()
{
	triggers = getentarray("trigger_once", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "spawner_trigger")
			triggers[i] thread maps\_utility::triggerOn();
	}

	triggers = getentarray("trigger_multiple", "classname");
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "spawner_trigger")
			triggers[i] thread maps\_utility::triggerOn();
	}
}

// delete triggers when triggered, mostly for friendlychains
delete_triggers()
{
	triggers = getentarray ("trigger_friendlychain", "classname");

	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "delete_trigger")
			triggers[i] thread delete_trigger();
	}
}

delete_trigger()
{
	self waittill("trigger");
	self delete();
}

move_radars()
{
	radars = getentarray("spinning_radar", "targetname");
	for(i = 0; i < radars.size; i++)
	{
		radars[i] thread spin_radar();
	}

	radars = getentarray("oscillating_radar", "targetname");
	for(i = 0; i < radars.size; i++)
	{
		radars[i] thread oscillate_radar();
	}
}

spin_radar()
{
	wait(randomfloat(16));

	while(1)
	{
		// rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
		self rotateYaw(-360, 16);
		self waittill("rotatedone");
	}
}

oscillate_radar()
{
	wait(randomfloat(16));

	while(1)
	{
		// rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
		self rotateYaw(-90, 4, 0, 4);
		self waittill("rotatedone");
		self rotateYaw(180, 8, 4, 4);
		self waittill("rotatedone");
		self rotateYaw(-90, 4, 4, 0);
		self waittill("rotatedone");
	}
}

change_fog()
{
	fog_interior_trigger = getent("fog_interior_trigger", "targetname");
	fog_exterior_trigger = getent("fog_exterior_trigger", "targetname");

	while(1)
	{
		fog_interior_trigger waittill("trigger");
		setExpFog(0.0011, 0.1847, 0.1797, 0.20833, 2);

		fog_exterior_trigger waittill("trigger");
		setExpFog(0.00013, 0, 0, 0, 2);
	}
}

flash_morsecode()
{
	morsecode_dot_ship = getent("morsecode_dot_ship", "targetname");
	morsecode_dash_ship = getent("morsecode_dash_ship", "targetname");

	morsecode_dot_ship hide();
	morsecode_dash_ship hide();

	wait 45; // TEMP

	//-.-.
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//....
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//.-
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .5;

	//.-..
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//.-..
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//.
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//-..
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .333;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//--.
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dash_ship"], morsecode_dash_ship.origin );
	wait .666;
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );
	wait .5;

	//.
	playfx(level._effect["morsecode_dot_ship"], morsecode_dot_ship.origin );

	morsecode_dot_ship delete();
	morsecode_dash_ship delete();
}

music()
{
	musicPlay("ship_approach");

	level waittill("ship_loop");
	musicPlay("ship_loop");

	level waittill("ship_action");
	musicPlay("ship_action");

	wait level.musiclength["ship_action"];
	wait 3;
	//musicStop(6);
	musicPlay("redsquare_tense_loop");
}

temp_dialog()
{
//println("WAITING: price facial and dialogue");
	level.price waittillmatch("single anim", "facial and dialogue");
	wait 23;
	wait 38;
	wait 5;
	shipdeck_officer[0] = level.shipdeck_officer;
	level.shipdeck_officer maps\_anim::anim_single(shipdeck_officer, "granted");

	level waittill("endloop_shipdeck_officer");

	wait 2;
	wait 5;
	wait 2;
	wait 5;
	level waittill("temp_dialog1");

	wait 2;
	price[0] = level.price;
	level.price maps\_anim::anim_single(price, "hanger");

	level waittill("endloop_mp40guy");

	wait 2;
	wait 6;
	wait 4;
	wait 7;
	level.price maps\_anim::anim_single(price, "explosives");
}

//// Disable all spawners that have "script_noteworthy" set to "disable"
//disable_spawners()
//{
//	// disable spawners
//	spawners = getentarray("disable", "script_noteworthy");
//	for(i = 0; i < spawners.size; i++)
//	{
//		spawners[i] notify("disable");
//	}
//}
//
//// Run a thread for each trigger that
//enable_spawners()
//{
//	triggers = getentarray("trigger_once", "classname");
//	for(i = 0; i < triggers.size; i++)
//	{
//		triggers[i] blah();
//	}
//}
//
//blah()
//{
//	self waittill("trigger");
//	self.target notify("enable");
//}

//big_guns()
//{
//	big_gun3 = getent("big_gun3", "targetname");
//	while(1)
//	{
//		// rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
//		big_gun3 rotateYaw(90, 8, 1, 1);
//		big_gun3 waitTill("rotatedone");
//		big_gun3 rotateYaw(-90, 8, 1, 1);
//		big_gun3 waitTill("rotatedone");
//	}
//}
