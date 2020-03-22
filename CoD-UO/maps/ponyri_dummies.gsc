#using_animtree("ponyri_dummies");
main()
{
	if(!isdefined(level.dummy_count))
	{
		level.dummy_count = 0;
	}

	// dummy character precache
	character\wehrmacht_soldier::precache();
	character\wehrmacht_nco::precache();
	character\RussianArmy::precache();

	level.flags["stop_church_dummy_fight"] = false;

	level.scr_fx["german"]						= "fx/muzzleflashes/german_mg.efx";
	level.scr_fx["russian"]						= "fx/muzzleflashes/russian_mg.efx";
	level.scr_anim["covershoot1"]["idle"][0]			= (%hideLowWall_1);
	level.scr_anim["covershoot1"]["shoot"][0]			= (%hideLowWall2crouch);
	level.scr_anim["covershoot1"]["shoot"][1]			= (%crouch_alert2aim_A);
	level.scr_anim["covershoot1"]["shoot"][2]			= (%crouch_shoot_straight);
	level.scr_anim["covershoot1"]["shoot"][3]			= (%crouch_aim2alert_A);
	level.scr_anim["covershoot1"]["shoot"][4]			= (%crouch_alert_A_idle);

	loadfx(level.scr_fx["german"]);
	loadfx(level.scr_fx["russian"]);

	// dummy weapon precache
	precacheModel("xmodel/weapon_mosinnagant");
	precacheModel("xmodel/weapon_panzerfaust");
	precacheModel("xmodel/weapon_panzerfaust_empty");
	precacheModel("xmodel/weapon_panzerfaust_rocket");
	precacheModel("xmodel/weapon_mp44");

	// thread the dummy managers
//	thread Church_Charge_Dummies();
}

church_dummy_fight()
{
//	println("^5 church_dummy_fight: starting");

	spots = getentarray ( "church_dummy_rus", "groupname" );
	if(isdefined(spots))
	{
//		println("^5 church_dummy_fight: found some russian dummy spots (" + spots.size + ")");
		for(x=0;x<spots.size;x++)
		{
			dummy = spawn_dummy(spots[x], "russian", "dummy", "xmodel/weapon_mosinnagant");
			dummy.target = spots[x].target;
			dummy.nationality = "russian";
			dummy.animname = "covershoot1";
			dummy thread dummy_crouch_shoot_think(false);

			church_dummies = maps\_utility_gmi::add_to_array(church_dummies, dummy);
//			println("^5 church_dummy_fight: russian dummy");
		}

		spots = getentarray ( "church_dummy_ger", "groupname" );
		if(isdefined(spots))
		{
//			println("^5 church_dummy_fight: found some german dummy spots (" + spots.size + ")");
			for(x=0;x<spots.size;x++)
			{
				dummy = spawn_dummy(spots[x], "german", "dummy", "xmodel/weapon_mp44");
				dummy.target = spots[x].target;
				dummy.nationality = "german";
				dummy.animname = "covershoot1";
				dummy thread dummy_crouch_shoot_think(true);

				church_dummies = maps\_utility_gmi::add_to_array(church_dummies, dummy);
//				println("^5 church_dummy_fight: german dummy");
			}

			if(	level.flags["stop_church_dummy_fight"] == false)
				level waittill ("stop_church_dummy_fight");

//			println("^5 church_dummy_fight: shutting down!");
			for(x=0;x<church_dummies.size;x++)
			{
				church_dummies[x] dummy_die();
			}

			for(x=0;x<church_dummies.size;x++)
			{
				church_dummies[x] delete();
			}

		}
		else println("^5 church_dummy_fight: no german spots");
	}
	else println("^5 church_dummy_fight: no russian spots");
}

dummy_crouch_shoot_think (is_automatic_weapon)
{
	level endon ("stop_church_dummy_fight");
	self UseAnimTree(#animtree);

	fx = loadfx(level.scr_fx[self.nationality]);

	targ = getent ( self.target, "targetname" );

	while ( 1 )
	{
		wait (randomfloat ( 3 ));

		self dummy_animate(level.scr_anim[self.animname]["shoot"][0]);

		for(x = 0; x < 10; x++)
		{
			self dummy_animate(level.scr_anim[self.animname]["shoot"][1]);

			fx_org = self gettagorigin("tag_weapon_right");
			fx_fwd = vectornormalize ( targ.origin - fx_org );
			fx_org = fx_org + maps\_utility_gmi::vectorScale(fx_fwd, 29);

			count = randomint(2) + 1;
			for( y=0; y<count;y++)
			{
				if(is_automatic_weapon == true)
				{
					self thread fake_gunshot(fx, "weap_mp44_fire", fx_org, fx_fwd);
					wait(0.1);
					self thread fake_gunshot(fx, "weap_mp44_fire", fx_org, fx_fwd);
					wait(0.1);
					self thread fake_gunshot(fx, "weap_mp44_fire", fx_org, fx_fwd);
				}
				else
				{
					self thread fake_gunshot(fx, "weap_kar98k_fire", fx_org, fx_fwd);	
				}
				self dummy_animate(level.scr_anim[self.animname]["shoot"][2]);
				wait(0.1);
			}

			self dummy_animate(level.scr_anim[self.animname]["shoot"][3]);
		}

		self dummy_animate(level.scr_anim[self.animname]["shoot"][4]);
	}

	self dummy_die();
}

fake_gunshot ( muzzleflash_fx, gunshot_sound, fx_origin, fx_forward )
{
	org = spawn ("script_origin", fx_origin);
	org playsound (gunshot_sound, fx_origin);
	playfx( muzzleflash_fx, fx_origin, fx_forward );

	endpoint = fx_origin + maps\_utility_gmi::vectorScale(fx_forward, 1000);
	bulletTracer (fx_origin, endpoint);

	wait(1);
	org delete();
}

/*
Panzerfaust_Guy()
{
	level waittill("Panzerfaust_Guy_Go");

	wait 5; // maybe trigger this extra delay off something this isn't harcoded eventually

	dummy_origin = getent( "rail_pfguy", "targetname" );
	dummy = spawn_dummy(dummy_origin, "german", "dummy", "xmodel/weapon_panzerfaust");
	dummy thread rail_pfguy_think("rail_pfguy_start");
}
*/

// launch a panzerfaust from startPos to targetPos.
// provide an effect alias for the explosion and a smoulder effect

launch_Panzerfaust(startPos, targetPos, flightTime, explosionFX, smoulderFX) {

	// no guy, just the panzerfaust releasing from the back side of the church

	attackdir = vectornormalize (targetPos.origin - startPos.origin);

	rocket = spawn("script_model", startPos.origin);
	rocket setmodel ("xmodel/weapon_panzerfaust_rocket");
	rocket.angles = vectorToAngles ( attackdir );
	playFxonTag(level._effect["rockettrail"], rocket, "tag_exhuast"); // (sic)
 	rocket thread maps\_utility_gmi::playSoundOnTag("weap_panzerfaust_fire", "tag_exhuast");// (sic)
	rocket moveTo(targetPos.origin, flightTime, 0.2, 0);

	wait flightTime;

	//Boom!
	rocket thread maps\_utility_gmi::playSoundOnTag("rocket_explode_grass", "tag_exhuast");// (sic)
//	playFxonTag(level._effect["rocketexplosion"], rocket, "tag_origin"); // (sic)
	rocket hide();

	// start the desired effects

	// explosion
	if(isdefined(explosionFX))
		playfx( level._effect[explosionFX], targetPos.origin );

	// smoulder
	if(isdefined(smoulderFX))
		maps\_fx_gmi::LoopFx( smoulderFX, targetPos.origin, 0.3, undefined, undefined, undefined, 120.0, undefined, 2000);

	wait 2;
	rocket delete();

}
/*
Panzerfaust_Church()
{
	level waittill("Church_Blast_1");

	// no guy, just the panzerfaust releasing from the back side of the church

	rockettarget = getent("target_church_1", "targetname");
	rocketlaunch = getent("origin_church_1", "targetname");

	launch_Panzerfaust(rocketlaunch, rockettarget, 2.0, "exp_church", "house_fire_hi");

	// Fire 2nd panzerfaust while going up the stairs in the school
	// This will need a guy...

	level waittill("Church_Blast_2");

	// no guy, just the panzerfaust releasing from the back side of the church

	rockettarget = getent("target_church_2", "targetname");
	rocketlaunch = getent("origin_church_2", "targetname");

	launch_Panzerfaust(rocketlaunch, rockettarget, 2.0, "exp_church", "house_fire_hi");

}
*/
Rail_Assault()
{
	level waittill("Rail_Assault_Go");
	level.flags["Rail_Assault_Dummies"] = true;
	dummy_origins = getentarray("rail_assaultguy","targetname");

	if(isdefined(dummy_origins) && (dummy_origins.size > 0))
	{
		while(level.flags["Rail_Assault_Dummies"] == true)
		{
			squadsize = randomint(4) + 3; // 3 - 6
	//		println("^2SENDING SQUAD, SIZE:  ",squadsize);

			for(i=0;i<squadsize;i++)
			{
				squadpos = randomint(dummy_origins.size);
				dummy[i] = spawn_dummy(dummy_origins[squadpos], "russian", "dummy", "xmodel/weapon_mosinnagant");
				dummy[i] thread rail_assault_think(dummy_origins[squadpos].target);
				randwait = randomfloat(0.2);
				wait(randwait);
			}
			randwait = randomfloat(3) + 2;
			wait (randwait);
		}
	}
}

// run a group of dummies
// targetname - of the dummy spawn points
// passes - indicates how many soldoers will emit from each spawn point

// troopType - what kind of dummy
// - GR_Gun
// - RU_Gun
/*
run_dummies(targetname, passes, troopType, attack_origin, no_death) {

	dumArray = getentarray(targetname,"targetname");

	if (isdefined(dumArray)) {

		for (passIndex = 0; passIndex < passes; passIndex++) {
			squadsize = dumArray.size;

			wait_base = 0;

			// spawn one at a time
			for(i=0;i<squadsize;i++)
			{
				// determine the typeof dummy to spawn
				switch (troopType)
				{
					case "GR_Gun":
						dummy[i] = spawn_dummy(dumArray[i], "german", "dummy", "xmodel/weapon_MP40");
						break;
					case "RU_Gun":
						dummy[i] = spawn_dummy(dumArray[i], "russian", "dummy", "xmodel/weapon_mosinnagant");
						break;
				}

				// if no attack origin, just die off
				if (!isdefined(attack_origin)) {
					dummy[i] thread rail_assault_think(dumArray[i].target, no_death);
				} else {
					// force 5 seconds so the guy will die before respawned
					wait_base = 5;
					dummy[i] thread factory_assault_think(dumArray[i].target, attack_origin, no_death);
				}

				randwait = randomfloat(0.2);
				wait(randwait) + wait_base;
			}
		}

	} else {
		println("^3Dummy Targetname -", targetname, "- not found in run_dummies().");
	}

}
*/

// Dummy encounter in route to enter the church.
/*
Church_Charge_Dummies() {

	trig = getent( "south_church1_dummies", "targetname" );

	if (isdefined(trig)) {

		trig waittill( "trigger" );

		thread run_dummies("south_church_charge", 4, "RU_Gun");
		thread run_dummies("south_church_hide", 4, "RU_Gun");

	} else {
		println("^3Missing TRIGGER in Church_Charge_Dummies.");
	}
}
*/
#using_animtree("ponyri_dummies");
/*
rail_pfguy_think(path_targetname)
{
	// first follow our path
	dummy_run_think(path_targetname);

	// now the crouch and aim
	rockettarget = getent("rail_pfguy_target", "targetname");
	attackdir = vectornormalize (rockettarget.origin - self.origin);
	self.angles = vectorToAngles ( attackdir );
	self dummy_animate(level.scr_anim["dummy"]["pfstand2crouch"][0]);

	wait 3;

	// Fire!
	// swap out the full Pzf for an empty one
	self detach("xmodel/weapon_panzerfaust", "tag_weapon_right");
	self attach("xmodel/weapon_panzerfaust_empty", "tag_weapon_right");

	rocket = spawn("script_model", self.origin+(0,0,40));
	rocket setmodel ("xmodel/weapon_panzerfaust_rocket");
	rocket.angles = vectorToAngles ( attackdir );
	playFxonTag(level._effect["rockettrail"], rocket, "tag_exhuast"); // (sic)
	rocket thread maps\_utility_gmi::playSoundOnTag("weap_panzerfaust_fire", "tag_exhuast");// (sic)
	rocket moveTo(rockettarget.origin, 1, 0.2, 0);

	wait 1;

	//Boom!
	rocket thread maps\_utility_gmi::playSoundOnTag("rocket_explode_grass", "tag_exhuast");// (sic)
	playFxonTag(level._effect["rocketexplosion"], rocket, "tag_origin"); // (sic)
	rocket hide();

	// Ack!  I Die!
	wait 1;
	self thread maps\_utility_gmi::playSoundOnTag("generic_death_german_1", "bip01 head");

	rocket delete();
	self dummy_die();
	self delete();
}
*/
rail_assault_think(path_targetname, no_death)
{
	dummy_run_think(path_targetname);

	if (!isdefined(no_death)) 
		no_death = false;

	if (no_death) {
		self delete();
		return;
	} else {
		self dummy_die();
	}

	wait 5;
	self delete();
}
/*
factory_assault_think(path_targetname, target_origin, no_death)
{
	dummy_run_think(path_targetname);
	attackdir = vectornormalize (target_origin - self.origin);
	self.angles = vectorToAngles ( attackdir );
	self dummy_animate(level.scr_anim["dummy"]["pfstand2crouch"][0]);
	wait 5;

	if (!isdefined(no_death)) 
		no_death = false;

	if (no_death) {
		self delete();
		return;
	} else {
		self dummy_die();
	}
	self delete();
}
*/

// ====================================
// ====================================
//		factory panzerfaust dummy
// ====================================
// ====================================

factory_pf_guy()
{
	dummy_origin = getent( "factory_pf_guy_start", "targetname" );
	dummy = spawn_dummy(dummy_origin, "russian", "dummy", "xmodel/weapon_panzerfaust");
	dummy thread factory_pfguy_think("factory_pfguy_path","factory_pf_dummy_target");
}

#using_animtree("ponyri_dummies");
factory_pfguy_think(path_targetname, enemy_targetname)
{
	// first follow our path
	dummy_run_think(path_targetname);

	// now the crouch and aim
	rockettarget = getent(enemy_targetname, "targetname");
	rocketdest = rockettarget.origin + (0,0,48);
	attackdir = vectornormalize (rocketdest - self.origin);
	self.angles = vectorToAngles ( attackdir );
	self dummy_animate(level.scr_anim["dummy"]["pfstand2crouch"][0]);

	wait 0.3;

	// Fire!
	// swap out the full Pzf for an empty one
	self detach("xmodel/weapon_panzerfaust", "tag_weapon_right");
	self attach("xmodel/weapon_panzerfaust_empty", "tag_weapon_right");

	rocket = spawn("script_model", self.origin+(0,0,40));
	rocket setmodel ("xmodel/weapon_panzerfaust_rocket");
	rocket.angles = vectorToAngles ( attackdir );
	playFxonTag(level._effect["rockettrail"], rocket, "tag_exhuast"); // (sic)
	rocket thread maps\_utility_gmi::playSoundOnTag("weap_panzerfaust_fire", "tag_exhuast");// (sic)
	rocket moveTo(rocketdest, 1.5, 0.2, 0);

	wait 1.3;

	//Boom!
	rocket thread maps\_utility_gmi::playSoundOnTag("rocket_explode_grass", "tag_exhuast");// (sic)
	playFxonTag(level._effect["rocketexplosion_metal"], rocket, "tag_origin"); // (sic)
	rocket hide();

	// kill the tank!
	level notify ( "fact_pf_boom" );

	// Ack!  I Die!
	wait 1;
	self thread maps\_utility_gmi::playSoundOnTag("generic_death_german_1", "bip01 head");

	rocket delete();
	self dummy_die();
	self delete();
}



/**********************************************************************************************************************/
/* dummy_run_think attaches a dummy to path_targetname, and has him run to the end of a string of stuff via targets
/**********************************************************************************************************************/
dummy_run_think(path_targetname)
{
	self endon("death");
	self UseAnimTree(#animtree);

	self.runtarget = path_targetname;
	runanim = randomint(3);

	while (isdefined (self.runtarget))
	{
		// find the next ent to run to
		runent = getnode(self.runtarget, "targetname");
		if(isdefined(runent))
		{
			// find the ground point beneath it
			self.rundest = groundPoint(runent);

			dir = vectornormalize (self.rundest - self.origin);
			dist = distance (self.rundest, self.origin);
//			println("dir: ", dir, "  dist: ", dist);

			self.angles = vectorToAngles ( dir );


			// run until we're "close enough" run towards that point
			while(dist > 64)
			{
				self dummy_animate(level.scr_anim["dummy"]["run"][runanim]);
				// recalculate the distance
				dist = distance (self.rundest, self.origin);
			}
			self.runtarget = runent.target;
		}
	}
}

dummy_die()
{
	// Wait for this to finish before playing death anim.
	// Make sure you add a "top" delay of 2 seconds to the above anim_wait;
//	self thread bloody_death();

	if(isdefined(level.scr_anim["dummy"]["death"]))
	{
		deathanim = randomArrayElement (level.scr_anim["dummy"]["death"]);
		self notify("stop_anim");
		self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
		self.died = true;
		wait 4;
		self movez (-100, 3, 2, 1);
		wait 3;
	}
	else
	{
		self.died = true;
	}

	level.dummy_count--;
}

// -- Dummy Utility ---------------

dummy_think_death()
{
	self endon("death");

	self waittill("explosion death");
	if(self.died)
	{
		return;
	}

	wait randomfloat(0.25);
	self unlink();
	self notify("stop_anim");

	deathanim = randomArrayElement (level.scr_anim["dummy"]["exp_death"]);
	self notify("stop_anim");
	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");

	self.died = true;

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3 + randomfloat(5);

	level.dummy_count--;
	self delete();
}

spawn_dummy(spawnloc, nationality, animname, weapon)
{
	dummy = spawn ("script_model", spawnloc.origin );
	level.dummy_count++;
	dummy.angles = spawnloc.angles;
	dummy.targetname = "dummy";
	dummy.died = false;
	dummy.animname = animname;
	dummy.nationality = nationality;
	dummy.dummy_number = level.dummy_count;

	dummy.origin = groundPoint(dummy);

	dummy [[randomArrayElement(level.scr_character[nationality])]]();
	dummy attach(weapon, "tag_weapon_right");
	dummy thread dummy_think_death();

	return dummy;
}

dummy_animate(animation)
{
	// create a custom notify string so each dummy has it's own
	notifystring = "dummyanim" + self.dummy_number;
	self animscripted(notifystring, self.origin, self.angles, animation);
	self waittill (notifystring);
}

//Random Arrays
randomArrayElement (array)
{
	return array [randomint (array.size)];
}

groundPoint (targEnt)
{
	trace_result = bulletTrace ( targEnt.origin, targEnt.origin - (0, 0, 256), false, undefined);
	return trace_result["position"];
}