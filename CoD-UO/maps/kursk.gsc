/********************************************
	KURSK.GSC -- Pi Studios
*********************************************/
main()
{
	maps\_load_gmi::main();
	maps\_treefall_gmi::main();
	maps\_tiger_pi::main_camo();
	maps\_panzerIV_pi::main_camo();
	maps\_t34_pi::mainnoncamo();
	maps\_pak43_pi::main();
	maps\_elefant_pi::main();
	maps\_truck_gmi::main(); // fx/model precaching

	maps\kursk_fx::main();
	maps\kursk_sound::main();
	maps\kursk_tankdrive::main();
	maps\kursk_infantry::main();
	maps\kursk_progress::main();

	// objective
	level thread objective_init();
	level thread manage_objectives();
	level thread maps\kursk_tank::main();

	// Tank Autosaves
	thread autosave_manage();
	
	// set environment fog values
	setCullFog (50, 17000, .35, .37, .45, 0 );

	// Pre-Cache - move this either to the truck script or kursk_tank.gsc
	precachemodel("xmodel/vehicle_german_truck_d");

	// anything that need to be deleted or changed for 
	// the min-spec machine can be done here

	if ( getcvar("scr_gmi_fast") != "0" ) {

		// reduce some of the active threads in the end battle

	}

}

// return the index for the targetname that has the specified target value
get_active_index(trig_array, target) {

	for (i=0;i<trig_array.size;i++) {

		if (isdefined(trig_array[i])) {
			// return the index of the trigger with
			if ( trig_array[i].target == target) {
				return i;
			}
		}
	}

	println("^6SAVE NOT FOUND");
}

autosave_manage() {

	triggers = getentarray ("autosave","targetname");
	println("^6TRIGGER COUNT: ", triggers.size);

	// find the index of the next autosave trigger
	current_index = get_active_index(triggers, "1");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

	current_index = get_active_index(triggers, "2");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

	current_index = get_active_index(triggers, "3");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

	current_index = get_active_index(triggers, "4");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

	current_index = get_active_index(triggers, "5");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

	current_index = get_active_index(triggers, "6");
	println("^6ACTIVE INDEX: ", current_index);
	level maps\_autosave_pi::autosaves_think(triggers[current_index]);

}

// temporary trigger-based objectives

objective_init()
{

	level.objective_text[1] = &"PI_KURSK_OBJECTIVE1";
	level.objective_text[2] = &"PI_KURSK_OBJECTIVE2";
	level.objective_text[3] = &"PI_KURSK_OBJECTIVE3";
	level.objective_text[4] = &"PI_KURSK_OBJECTIVE4";
	level.objective_text[5] = &"PI_KURSK_OBJECTIVE5";
	level.objective_text[6] = &"PI_KURSK_OBJECTIVE6";
	level.objective_text[7] = &"PI_KURSK_OBJECTIVE7";
	level.objective_text[8] = &"PI_KURSK_OBJECTIVE8";
	level.objective_text[9] = &"PI_KURSK_OBJECTIVE9";
	level.objective_text[10] = &"PI_KURSK_OBJECTIVE10";

}

objective(objective_num)
{
	tempname = "objective" + objective_num;

	trigger = getent ( tempname, "targetname" );
	if(isdefined ( trigger ))
	{
		trigger waittill ( "trigger" );

		tempname = "objective" + objective_num + "_target";

		objective_spot = getent ( tempname, "targetname" );

		if(isdefined (objective_spot))
			objective_add(objective_num, "active", level.objective_text[objective_num], objective_spot.origin );
		else
			objective_add(objective_num, "active", level.objective_text[objective_num], ( 0,0,0 ) );

		objective_current(objective_num);
	}
}

// there is MUCH more to this than objectives...
// In attempt to reduce the active thread count, many function calls
// are called in-line with the objectives.

manage_objectives() {

	// set the FOLLOW objective (default when there is no combat 
	// or immediate target)
	primary_obj_index = 0;
	current_objective = 1;


	// --- FIRST --- Get the player moving in the right direction.

	level waittill("level start tanks");

	// start the initial tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("convoy_flash", "river_flash", "hillflash2", "amb_comp_flak2");

	primary_obj_index = current_objective;

	// set the player's first objective
	objective_spot = getent("objective1_target","targetname");
	objective_add(current_objective, "active", level.objective_text[1], objective_spot.origin );
	objective_current(current_objective);

	current_objective++;


	// --- SECOND --- Activate the pak counter.

	trig = getent("river_speech","targetname");
	if (isdefined(trig)) {
		trig waittill("trigger");
	}

	// start the second set of tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("river_flash", "ambush_flash", "hillflash2", "amb_comp_flak2");

	wait(1);

	// spawn the river infantry
	level thread maps\kursk_infantry::river_init();

	// watch all the paks for death
	river_paks = getentarray("river_paks","groupname");
	paks_dead = false;
	first_target = true;
	pack_count_org = river_paks.size;
	previous_target = 0;
	previous_pak_count = pack_count_org;
	text_index = 2;

	// keep tabs on the paks, showing the number remaining
	watch_group_objective_count(river_paks, current_objective, text_index, pack_count_org);

	// Done with the paks
	objective_state(current_objective, "done");
	objective_string(current_objective, level.objective_text[2], 0);

	current_objective++;

	// Make sure all of the infantry is gone
	// These guys are spawned in when we first start watching the paks

	text_index = 3;
	river_ai = getentarray("river_ai","groupname");

	// wait for the entire array to die
	// also play vo if any of the infantry is actually alive

	infantry_alive = false;
	for (i = 0; i < river_ai.size; i++) {
		if (isalive(river_ai[i])) {
			infantry_alive = true;
		}
	}

	// keep the time since the last speech
	speech_time = gettime();

	if(infantry_alive) {
		infantry_alive = false;
		speech_time = gettime();
		level.playertank playsound("kursk_cmdr_hint_building");
	} else {
		speech_time = 0;
	}

	watch_group_objective(river_ai, current_objective, text_index);

	objective_state(current_objective, "done");

	// notification for cleanup routines
	level notify("river_end");

	// spawn the farm infantry
	level thread maps\kursk_infantry::manage_farm_infantry();


	// Return to the default objective, heading to the ambush
	objective_current(primary_obj_index);

	// start the third set of tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("ambush_flash", "barrier_flash", "hillflash2", "amb_comp_flak2");

	// check the time since the infantry speech
	current_time = gettime();
	speech_delta = (current_time - speech_time)/1000;
	println("^6TIME: ", speech_delta);

	if ((speech_delta) < 5.0) {
		wait(5.0 - speech_delta);
	}

	// "keep moving..."
	level.playertank playsound("kursk_cmdr_cont1");


	// --- THIRD --- Ambush

	trig = getent("farm_start","targetname");
	if (isdefined(trig)) {
		trig waittill("trigger");
	}

	thread maps\ponyri_sound::playMusicTrack( "music_ambush", undefined, 80, 10 );

	// clean house
	thread clean_river();

	wait(3.0);

	first_target = true;
	targets_left = true;


	// Watch the 1ST group of tanks
	text_index = 4;
	watch_group_objective(level.farmpanzers, current_objective, text_index);

	level.playertank playsound("tankdrive_sighted_eastA");
	level.vo_played = gettime();

	// Watch the 2ND group of tanks
	text_index = 4;
	watch_group_objective(level.farmpanzers2, current_objective, text_index, true);

	// Done with the tanks
	objective_state(current_objective, "done");
	current_objective++;

	// Now check for remaining troups in the farm area
	farm_ai = getentarray("farm_ai_1", "groupname");

	// keep a timer on the guys so knuckle tanks have time to spawn
	infantry_time = gettime();

	// play vo if any of the infantry is alive in the house
	println("^2FARM COUNT 1 ", farm_ai.size); 
	infantry_alive = false;
	for (i = 0; i < farm_ai.size; i++) {
		if (isalive(farm_ai[i])) {
			infantry_alive = true;
		}
	}

	if(infantry_alive) {
		infantry_alive = false;
		level.playertank playsound("kursk_cmdr_hint_pfbuilding");
		level.vo_played = gettime();
	}

	text_index = 5;
	watch_group_objective(farm_ai, current_objective, text_index);

	farm_ai = undefined;
	farm_ai = getentarray("farm_ai_2", "groupname");

	// play vo if any of the infantry is alive in the rubble
	infantry_alive = false;
	println("^2FARM COUNT 2 ", farm_ai.size); 
	for (i = 0; i < farm_ai.size; i++) {
		if (isalive(farm_ai[i])) {
			infantry_alive = true;
		}
	}

	if(infantry_alive) {
		infantry_alive = false;
		level.playertank playsound("kursk_cmdr_hint_pfrubble");
		level.vo_played = gettime();
	}

	text_index = 5;
	watch_group_objective(farm_ai, current_objective, text_index, true);

	// done with the infantry
	objective_state(current_objective, "done");

	current_objective++;

	// notification for cleanup routines
	level notify("farm_end");

	current_time = gettime();
	delta_time = (current_time - infantry_time)/1000;
	println("^6TIME: ", delta_time );


	// give the knuckle panzers time to generate if the player
	// takes out the infantry first
	if (delta_time < 7.0) {
		wait (7.0 - delta_time);
	}

	// --- FOURTH --- Eliminate resistance in your path around the barrier

	println("^6START KNUCKLE");
	
	// Watch the tanks at the knuckle
	knuckle_tanks = getentarray("knucklepanzers", "groupname");
	text_index = 6;
	watch_group_objective(knuckle_tanks, current_objective, text_index);

	if (isdefined(level.combat_active)) {
		// drop the combat gate in kursk_progress.gsc
		level.combat_active = false;	
	}

	// kill the correct battle index
	level.indexed_combat_active[level.ambush_index] = false;

	// kill the music if it is still going
	thread maps\kursk_sound::killmusic(8);

	// send the player past the knuckle, if they aren't already..
	obj_trigger = getent("objective4_trig_3", "targetname");
	obj_target = getent("objective4_target_3","targetname");

	if (isdefined(obj_trigger)) {
		obj_trigger waittill( "trigger");
	}

	objective_position(primary_obj_index, obj_target.origin);
	objective_current(primary_obj_index);

	// start the fourth set of tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("barrier_flash", "duckshoot_flash", "hillflash2", "amb_comp_flak2");

	// clean house
	thread clean_ambush();

	// we have a timed nice shot here. Ignore the system
	level.ignore_nice_shot = true;

	// now get the player to follow the tank that passes the barrier
	// put the target directly on the pak, since it is not moving
	// we will check for the tank afterward
	obj_trigger = getent("barrier_panzer_start","targetname");
	if (isdefined(obj_trigger)) {
		obj_trigger waittill( "trigger");
		level.playertank playsound("tankdrive_sighted_panzerB");
		level.vo_played = gettime();
	}


	ent = [];
	barrier_target = getent("barrier_pak", "targetname");
	ent[0] = barrier_target;
	watch_group_objective(ent, current_objective, text_index);

	// play "nice shot" VO 
	wait (1.0);
	level.playertank playsound("kursk_crew_shout1");
	level.vo_played = gettime();

	level.ignore_nice_shot = false;


	// now check for the tank, since it is probably in place by now
	barrier_target = getent("barrier_panzer", "targetname");
	ent[0] = barrier_target;
	watch_group_objective(ent, current_objective, text_index, true);

	// now find the infantry in the area
	ai_array = getentarray("barrier_ai", "groupname");
	watch_group_objective(ai_array, current_objective, text_index, true);
	
	if (isdefined(level.combat_active)) {
		// drop the combat gate in kursk_progress.gsc
		level.combat_active = false;	
	}

	// kill the correct battle index
	level.indexed_combat_active[level.barrier_index] = false;



	// done with the barrier area
	objective_state(current_objective, "done");

	current_objective++;


	// --- FIFTH --- Eliminate Germans at the crossroad

	// Put the player back on path
	obj_target = getent("objective4_target_5", "targetname");
	objective_position(primary_obj_index, obj_target.origin);
	objective_current(primary_obj_index);

	// start the fifth set of tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("duckshoot_flash", "clearing_flash", "hillflash2", "amb_comp_flak2");

	// wait for the tigers to roll in and start fighting
	trig = getent("start_duckshoot_t34s","targetname");
	if (isdefined(trig)) {
		trig waittill("trigger");
	}

	// clear out the knuckle and barrier ents
	thread clean_barrier();

	// we have a timed nice shot here. Ignore the system
	level.ignore_nice_shot = true;

	thread maps\ponyri_sound::playMusicTrack( "music_duckshoot", undefined, 40, 4 );

	// now target the tanks as the objective
	clearing_tanks = getentarray("duckshoottigers", "groupname");
	text_index = 7;
	watch_group_objective(clearing_tanks, current_objective, text_index);

	if (isdefined(level.combat_active)) {
		// drop the combat gate in kursk_progress.gsc
		level.combat_active = false;	
	}

	// kill the correct battle index
	level.indexed_combat_active[level.duckshoot_index] = false;



	// done with the crossroads
	objective_state(current_objective, "done");
	level.playertank playsound("kursk_crew_shout2");
	level.vo_played = gettime();
	level.ignore_nice_shot = false;

	current_objective++;


	// --- SIXTH --- Eliminate the Germans in the clearing

	// Put the player back on the path
	obj_target = getent("objective4_target_6", "targetname");
	objective_position(primary_obj_index, obj_target.origin);
	objective_current(primary_obj_index);

	// start the sixth set of tree-line blasts
	thread maps\kursk_fx::activate_gunfire_loops("clearing_flash", "final_flash", "hillflash2", "amb_comp_flak2");

	// wait for the Fritz speech
	trig = getent("clearing_start","targetname");
	if (isdefined(trig)) {
		trig waittill("trigger");
	}
	
	// "Press On..."
	level.playertank playsound("kursk_cmdr_cont2");
	level.vo_played = gettime();

	wait(1.0);

	// now target the tanks as the objective
	clearing_tanks = getentarray("clearingpanzers", "groupname");
	text_index = 8;
	watch_group_objective(clearing_tanks, current_objective, text_index);

	// now target the second round of tanks
	clearing_tanks = getentarray("clearingpanzers2", "groupname");
	watch_group_objective(clearing_tanks, current_objective, text_index, true);

	if (isdefined(level.combat_active)) {
		// drop the combat gate in kursk_progress.gsc
		level.combat_active = false;	
	}

	// kill the correct battle index
	level.indexed_combat_active[level.clearing_index] = false;


	wait(2.0);

	// "not done yet..."
	level.playertank playsound("kursk_crew_notdone");
	level.vo_played = gettime();


	// "press on..."
//	level.playertank playsound("kursk_cmdr_cont3");
//	level.vo_played = gettime();

	// done with the clearing
	objective_state(current_objective, "done");

	current_objective++;

	// load the infantry in the tunnel area
	level thread maps\kursk_infantry::tunnel_init();
	level thread maps\kursk_infantry::manage_tunnel_infantry();

	wait(0.5);
	thread maps\kursk_sound::death_sound("tankdrive_kill_infantry", "tunnel_ai_1", 1.0);

	// --- SEVENTH --- Tunnel Roadblock

	// Put the player back on track
	obj_target = getent("objective_1_target_3", "targetname");
	objective_position(primary_obj_index, obj_target.origin);
	objective_current(primary_obj_index);

	thread clean_duckshoot();

	// one more bread crumb
	obj_trigger = getent("objective_1_trig_4", "targetname");
	if (isdefined(obj_trigger)) {
		obj_trigger waittill ("trigger");
	}

	// clean out the clearing tanks
	thread clean_clearing();

	// Put the player back on track
	obj_target = getent("objective_1_target_4", "targetname");
	objective_position(primary_obj_index, obj_target.origin);
	//objective_current(primary_obj_index);


	// wait for the player to enter the tunnel area
	obj_trigger = getent("tunnel_tiger_trigger","targetname");
	if (isdefined(obj_trigger)) {
		obj_trigger waittill( "trigger");
	}

	thread maps\ponyri_sound::playMusicTrack( "music_finalbattle", "stage1_vulnerable", 40, 4 );

	// Thread - "Kill Them...!"
	thread maps\kursk_sound::vo_wait("kursk_cmdr_fireatwill", "stage1_vulnerable");


	// target the tank first
	tunnel_tank = getent("tunnel_elefant", "targetname");
	ent[0] = tunnel_tank;
	text_index = 9;
	watch_group_objective(ent, current_objective, text_index);

	// "destroy them!!"
	level.playertank playsound("kursk_cmdr_rally2");
	level.vo_played = gettime();

	// now target the infantry
	ai_array = getentarray("tunnel_guys", "groupname");
	watch_group_objective(ai_array, current_objective, text_index, true);
	
	// done with the tunnel area
	objective_state(current_objective, "done");
	current_objective++;

	objective_state(primary_obj_index, "done");

	// --- FINAL BATTLE ---


	// --- STAGE 1 ---
	
	// stage 1 panzers
	panzer_array = getentarray("stage1_panzers", "groupname");
	text_index = 10;
	watch_group_objective(panzer_array, current_objective, text_index);

	tiger_array = getentarray("stage1_tigers", "groupname");
	text_index = 10;
	watch_group_objective(panzer_array, current_objective, text_index, true);

	// "more than I expected..."
	level.playertank playsound("kursk_crew_mutter1");
	level.vo_played = gettime();


	// --- STAGE 2 ---

	// PGM
	if(level.flags["stage2_enemies_spawned"] == false)
	{
		println("^5 waiting for stage2 enemies to spawn");
		level waittill ("stage2_enemies_spawned");
		println("^5 stage2 enemies spawned!");
	}
	// PGM

	// stage 2 tanks
	tank2_array = getentarray("stage2_tanks", "groupname");
	text_index = 10;
	watch_group_objective(tank2_array, current_objective, text_index, true);

	// stage 2 elephants
	elephant_array = getentarray("stage2_elefants", "groupname");

	tank_alive = false;
	for (i = 0; i < elephant_array.size; i++) {
		if (isalive(elephant_array[i])) {
			tank_alive = true;
		}
	}

	if(tank_alive) {
		tank_alive = false;
		level.playertank playsound("tankdrive_sighted_northA");
		level.vo_played = gettime();
	}
	
	text_index = 10;
	watch_group_objective(elephant_array, current_objective, text_index, true);


	// --- STAGE 3 ---

	level.playertank playsound("tankdrive_sighted_westA");
	level.vo_played = gettime();

	// PGM
	if(level.flags["stage3_enemies_spawned"] == false)
	{
		println("^5 waiting for stage3 enemies to spawn");
		level waittill ("stage3_enemies_spawned");
		println("^5 stage3 enemies spawned!");
	}
	// PGM

	// stage 3 elephants
	elephant3_array = getentarray("stage3_elefants", "groupname");
	text_index = 10;
	watch_group_objective(elephant3_array, current_objective, text_index, true);

	// kill all of the battle field blasts, the war is over
	level notify ("kill_gunfire_loop");

	// stage 3 tigers
	tiger3_array = getentarray("stage3_tigers", "groupname");
	text_index = 10;
	watch_group_objective(tiger3_array, current_objective, text_index, true);

	objective_state(current_objective, "done");

	wait(2);

	// play the final speech
	level.playertank playsound("kursk_cmdr_outro");
	level.vo_played = gettime();

	wait(16);

	// Mission End
	missionSuccess("kharkov1", false);


	// --- DONE!!! ---


	return;
}

// watch an array of ents, keeping the objective
// star on one of the living ents in the array.
//
// no_update (bool): skips the first_target, just updating the position

watch_group_objective(ent_array, objective_index, text_index, no_update) {

	first_target = true;
	targets_left = true;

	if (isdefined(no_update) && no_update == true) {
		println("^6NOT FIRST TARGET");
		first_target = false;
	}

	if (!isdefined(ent_array)) {
		// add the objective since it will either be marked completed
		// or the next watch_group will use this text, just without an update
//		if (!isdefined(no_update) || no_update == false) {
//
//			objective_add(objective_index, "active", level.objective_text[text_index]);
//			objective_current(objective_index);
//		}

		println("^5 WARNING: watch_group_objective couldn't find ent_array! obj_ind: " + objective_index + " text_index: " + text_index + "");
		return;
	}

	while(targets_left == true) {

		targets_left = false;
		for(i=0;i<ent_array.size;i++) {

			if(isdefined(ent_array[i]) && isalive(ent_array[i])) {
				
				targets_left = true;
				if(first_target == true) {

					first_target = false;
					objective_add(objective_index, "active", level.objective_text[text_index], ent_array[i].origin );
					objective_current(objective_index);

				} else {

					objective_position(objective_index, ent_array[i].origin );
				}
				wait(2);
				break;
			} else {

				// If all of our targets are dead from the start...
				// add the objective since it will either be marked completed
				// or the next watch_group will use this text, just without an update
				if(first_target == true) {

					first_target = false;
					objective_add(objective_index, "active", level.objective_text[text_index]);
					objective_current(objective_index);
				}
			}

		}
	}
}

// watch an array of ents, keeping count of the remaining targetsw

watch_group_objective_count(ent_array, objective_index, text_index, count_org) {

	// watch all the paks for death
	array_dead = false;
	first_target = true;
	previous_target = 0;
	previous_count = count_org;

	while(array_dead == false) {
			
		ent_count = 0;
		first_living = true; 
		array_dead = true;

		for(i=0;i<ent_array.size;i++) {

			if( isdefined(ent_array[i]) && 
			    isalive(ent_array[i]) && 
			    ( isdefined(ent_array[i].disabled) && 
				  ent_array[i].disabled == false)) {

				ent_count++;
				array_dead = false;

				// First time init
				if(first_target == true) {

					first_target = false;
					objective_add(objective_index, "active", level.objective_text[text_index], ent_array[0].origin );
					objective_string(objective_index, level.objective_text[text_index], count_org);
					objective_current(objective_index);
					println("^6OBJECTIVE ADD");

				} else {

					// inspect the first living ent, it should be the current target
					if (first_living == true) {

						// check to see if we lost the previous target (should be first living)
						if (previous_target != i) {

							objective_position(objective_index, ent_array[i].origin );
							//objective_ring(objective_index);
						}
						first_living = false;
						previous_target = i;
					}
				}
			}
		}

		// now handle general pak loss for updating the counter
		if (previous_count != ent_count) {
			objective_string(objective_index, level.objective_text[text_index], ent_count);
			previous_count = ent_count;
		}

		wait(2.0);
	}
}

// Area specific cleanup routines

clean_river() {

	println("^6 CLEARING RIVER ENTS");

	// start by killing all thrads related to exploders
	level notify ("killexplodertriggers101");
	level notify ("killexplodertriggers102");
	level notify ("killexplodertriggers103");
	level notify ("killexplodertriggers104");
	level notify ("killexplodertriggers113");
	level notify ("killexplodertriggers12321");

	// take out the paks from the river
	pak43_1 = getent("pak43_1","targetname");
	stopattachedfx( pak43_1 );

	pak43_2 = getent("pak43_2","targetname");
	stopattachedfx( pak43_2 );

	// explodable trucks
	truck1 = getent("river_truck1","targetname");
	stopattachedfx( truck1 );

	truck2 = getent("river_truck2","targetname");
	stopattachedfx( truck2  );

	truck3 = getent("river_truck3","targetname");
	stopattachedfx( truck3  );

	// give the fx time to die off
	wait (5);

	pak43_1 delete();
	pak43_2 delete();
	truck1 delete();
	truck2 delete();
	truck3 delete();

}


clean_ambush() {

	println("^6 CLEARING AMBUSH ENTS");

	// kill all threads related to exploders
	level notify ("killexplodertriggers105");
	level notify ("killexplodertriggers110");
	level notify ("killexplodertriggers108");
	level notify ("killexplodertriggers107");
	level notify ("killexplodertriggers111");
	level notify ("killexplodertriggers109");
	level notify ("killexplodertriggers214");
	level notify ("killexplodertriggers114");
	level notify ("killexplodertriggers115");
	level notify ("killexplodertriggers112");

	// take out the 2 waves of tanks (not the knukle panzers)

	tank1 = getent("dkramer847","targetname");
	stopattachedfx( tank1 );

	tank2 = getent("dkramer848","targetname");
	stopattachedfx( tank2 );
	
	tank3 = getent("farmpanzer_4","targetname");
	stopattachedfx( tank3 );

	//farmpanzers2
	tank4 = getent("farmpanzer_1","targetname");
	stopattachedfx( tank4 );
	
	tank5 = getent("farmpanzer_2","targetname");
	stopattachedfx( tank5 );
	
	tank6 = getent("farmpanzer_3","targetname");
	stopattachedfx( tank6 );

	tank7 = getent("farmpanzer_5","targetname");
	stopattachedfx( tank7 );

	// give the fx time to die off
	wait (5);

	tank1 delete();
	tank2 delete();
	tank3 delete();
	tank4 delete();
	tank5 delete();
	tank6 delete();
	tank7 delete();

}


clean_barrier() {

	println("^6 CLEAN BARRIER ENTS");

	// this includes both the knuckle and barrier

	// take out the pak at the barrier
	pak = getent("barrier_pak","targetname");
	stopattachedfx( pak );

	// explodable trucks
	truck1 = getent("barrier_truck","targetname");
	stopattachedfx( truck1 );

	// now the tanks
	tank1 = getent("dkramer862","targetname");
	stopattachedfx( tank1 );

	tank2 = getent("dkramer873","targetname");
	stopattachedfx( tank2 );

	tank3 = getent("barrier_panzer","targetname");
	stopattachedfx( tank3 );


	// give the fx time to die off
	wait (5);

	pak delete();
	truck1 delete();
	tank1 delete();
	tank2 delete();
	tank3 delete();

}



clean_duckshoot() {

	println("^6 CLEAN DUCKSHOOT ENTS");

	// take out both the tigers and dead t34s (not the t34s in the player's party)
	tiger1 = getent("duckshoot_tiger_1","targetname");
	stopattachedfx( tiger1 );

	tiger2 = getent("duckshoot_tiger_2","targetname");
	stopattachedfx( tiger2 );

	tiger3 = getent("duckshoot_tiger_3","targetname");
	stopattachedfx( tiger3 );

	t34_1 = getent("convoy_t34_1","targetname");
	stopattachedfx( t34_1 );

	t34_2 = getent("convoy_t34_2","targetname");
	stopattachedfx( t34_2 );

	t34_3 = getent("convoy_t34_3","targetname");
	stopattachedfx( t34_3 );


	// give the fx time to die off
	wait (5);

	tiger1 delete();
	tiger2 delete();
	tiger3 delete();
	t34_1 delete();
	t34_2 delete();
	t34_3 delete();

}

clean_clearing() {

	println("^6 CLEARING CLEARING ENTS");

	// kill all threads related to exploders
	level notify ("killexplodertriggers117");
	level notify ("killexplodertriggers116");

	// take out the 2 waves of tanks (not the knukle panzers)

	tank1 = getent("clear_panzer_1","targetname");
	stopattachedfx( tank1 );

	tank2 = getent("clear_panzer_2","targetname");
	stopattachedfx( tank2 );
	
	tank3 = getent("clear_panzer_3","targetname");
	stopattachedfx( tank3 );

	tank4 = getent("clear_panzer_4","targetname");
	stopattachedfx( tank4 );
	
	tank5 = getent("clear_tiger_2","targetname");
	stopattachedfx( tank5 );


	// give the fx time to die off
	wait (5);

	tank1 delete();
	tank2 delete();
	tank3 delete();
	tank4 delete();
	tank5 delete();

}

