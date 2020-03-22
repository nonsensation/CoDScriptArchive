main() {

	level.next_gate = false;
	level.combat_active = false;
	level.progress_warning = false;
	level.combat_warning = false;
	level.warning_active = false;

	// enumerate
	level.ambush_index = 0;
	level.barrier_index = 1;
	level.duckshoot_index = 2;
	level.clearing_index = 3;
	level.area_index = 4;
	
	// set all of the combat active triggers to true
	// we will turn them off as the specific battle ends
	level.indexed_combat_active[level.ambush_index] = true;
	level.indexed_combat_active[level.barrier_index] = true;
	level.indexed_combat_active[level.duckshoot_index] = true;
	level.indexed_combat_active[level.clearing_index] = true;



	thread progress_manager();

}

hide_brush_array(brush_name) {

	brush_array = getentarray(brush_name, "targetname");

	for (i = 0; i < brush_array.size; i++) {
		brush_array[i] hide();
		brush_array[i] notsolid();
	}

}

progress_manager() {

	level.combat_active = false;
	level.next_gate = false;

	// start by hiding specific script brush models
	hide_brush_array("tail_clip_intro");
	hide_brush_array("tail_clip_convoy");
	hide_brush_array("tail_clip_prebridge");
	hide_brush_array("tail_clip_bridge");
	hide_brush_array("tail_clip_ambush");
	hide_brush_array("tail_clip_barrier");
	hide_brush_array("tail_clip_duckshoot");
	hide_brush_array("tail_clip_clearing");
	hide_brush_array("tail_clip_tunnel");

	// --- GATE 1 --- The first gate behind the starting point.

	gate_wait_think("tail_clip_intro", 
					"tail_warn_intro_on", 
					"tail_warn_intro_off", 
					"tail_warn_convoy_off");

	// --- GATE 2 --- Just before the Russian convoy.

	gate_wait_think("tail_clip_convoy", 
					"tail_warn_convoy_on", 
					"tail_warn_convoy_off", 
					"tail_warn_prebridge_off");

	// --- GATE 3 --- After the Russian convoy.

	// FIX - Use the head gate once we have proper objective timing

	// prep the head combat gate
//	thread lift_combat_gate("tail_clip_ambush", 
//							"head_warn_bridge_on", 
//							"head_warn_bridge_off");

	gate_wait_think("tail_clip_prebridge", 
					"tail_warn_prebridge_on", 
					"tail_warn_prebridge_off", 
					"tail_warn_bridge_off");


	// --- GATE 4 --- Past the bridge.

	gate_wait_think("tail_clip_bridge", 
					"tail_warn_bridge_on", 
					"tail_warn_bridge_off", 
					"tail_warn_ambush_off");

	// --- GATE 5 --- Before the ambush.

	// we must let the previous combat gate drop

	// FIX - Use the head gate once we have proper objective timing

//	while (level.combat_active == true) {
//		wait(2);
//	}

	// prep the head combat gate
	thread lift_combat_gate("tail_clip_barrier", 
							"head_warn_ambush_on", 
							"head_warn_ambush_off",
							level.ambush_index);


	gate_wait_think("tail_clip_ambush", 
					"tail_warn_ambush_on", 
					"tail_warn_ambush_off", 
					"tail_warn_barrier_off");

	// --- GATE 6 --- Before the barrier.

	// prep the head combat gate so they do not leave the barrier area before 
	// both the tank and the PAK are dead.
	thread lift_combat_gate("tail_clip_duckshoot", 
							"head_warn_barrier_on", 
							"head_warn_barrier_off",
							level.barrier_index);

	gate_wait_think("tail_clip_barrier", 
					"tail_warn_barrier_on", 
					"tail_warn_barrier_off", 
					"tail_warn_duckshoot_off");


	// --- GATE 7 --- Before the duckshoot.

	// prep the head combat gate so they do not leave the duckshoot area before 
	// all tiger tanks are dead.
	thread lift_combat_gate("tail_clip_clearing", 
							"head_warn_duckshoot_on", 
							"head_warn_duckshoot_off",
							level.duckshoot_index);

	gate_wait_think("tail_clip_duckshoot", 
					"tail_warn_duckshoot_on", 
					"tail_warn_duckshoot_off", 
					"tail_warn_clearing_off");


	// --- GATE 8 --- Before the clearing.

	// prep the head combat gate so they do not leave the clearing before 
	// all 5 tanks are dead.
	thread lift_combat_gate("tail_clip_tunnel", 
							"head_warn_clearing_on", 
							"head_warn_clearing_off",
							level.clearing_index);

	gate_wait_think("tail_clip_clearing", 
					"tail_warn_clearing_on", 
					"tail_warn_clearing_off", 
					"tail_warn_tunnel_off" ); // this needs to be the next trigger that I create

	// --- GATE 8 --- Heading down the tunnel.

	gate_wait_think("tail_clip_tunnel", 
					"tail_warn_tunnel_on", 
					"tail_warn_tunnel_off", 
					"tail_warn_intro_on" ); // this needs to be the next trigger that I create


}

//----------------------
// gate_wait_think() -
//
//	clip_brush:		targetname for the player-clip script models.
//	trig_on:		trigger name to start the warning VO.
//	trig_off:		trigger name to stop the warning VO.
//	next_gate_trig:	trigger name to exit the routine (start routine for next gate).
 
gate_wait_think(clip_brush, trig_on, trig_off, next_gate_trig) 
{
	level.next_gate = false;

//	println("^6LOCKING PROGRESS GATE: ", clip_brush);

	// this will set "next gate" notify
	thread gate_flag_wait(next_gate_trig);

	// prepare the toggling warning triggers
	// this will toggle the "level.progress_warning" flag
	thread toggle_warning_think(trig_on, trig_off);

	// start by activating the clip brush and triggers
	collide_array = getentarray (clip_brush,"targetname");

	for (i = 0; i < collide_array.size; i++) {
		collide_array[i] solid();
	}

	while (level.next_gate == false) {
		
		// Do something with this flag...

		//level.progress_warning = true;

		wait(2);

		if (level.progress_warning == true) {
			thread process_warning();
		}

	}
}

gate_flag_wait(gate_trig) {

	end_trigger = getent(gate_trig, "targetname");
	end_trigger waittill( "trigger" );
	level.next_gate = true;
	level notify("next gate");

}

toggle_warning_think(trig_on, trig_off) {

	level endon("next gate");

	on_trigger = getent(trig_on, "targetname");
	off_trigger = getent(trig_off, "targetname");

	while (1) {

		// default start at off
		level.progress_warning = false;

		// Hide the warning off trigger until the warning is on.
		off_trigger thread maps\_utility::triggerOff();
		on_trigger thread maps\_utility::triggerOn();
//		println("^6--- WARNING TRIGGER OFF---");

		on_trigger waittill("trigger");

		// Set to on, toggle the triggers. 
		level.progress_warning = true;
		off_trigger thread maps\_utility::triggerOn();
		on_trigger thread maps\_utility::triggerOff();
//		println("^6--- WARNING TRIGGER ON---");

		off_trigger waittill("trigger");
	}

}


toggle_combat_think(trig_on, trig_off) {

	level endon("combat complete");

	on_trigger = getent(trig_on, "targetname");
	off_trigger = getent(trig_off, "targetname");

	while (1) {

		// default start at off
		level.combat_warning = false;

		// Hide the combat off trigger until the warning is on.
		off_trigger thread maps\_utility::triggerOff();
		on_trigger thread maps\_utility::triggerOn();
//		println("^6--- COMBAT WARNING TRIGGER OFF---");

		on_trigger waittill("trigger");

		// Set to on, toggle the triggers. 
		level.combat_warning = true;
		off_trigger thread maps\_utility::triggerOn();
		on_trigger thread maps\_utility::triggerOff();
//		println("^6--- COMBAT WARNING TRIGGER ON---");

		off_trigger waittill("trigger");
	}

}


//-----------------------
//
//	lift_combat_gate();
//
//	combat_head:	targetname for clip-brushes IN FRONT of the player.
//	combat_on:		trigger name to start the warning VO during combat. 
//	combat_off:		trigger name to stop the warning VO during combat.
//  combat_index:	index for the indexed_combat_active array that will be 
//					inactive if the area battle is complete.

lift_combat_gate( combat_head, combat_on, combat_off, combat_index) {

	// activate combat
	level.combat_active = true;

	println("^6LOCKING COMBAT GATE: ", combat_head);

	// prepare the toggling warning triggers
	// this will toggle the "level.progress_warning" flag
	thread toggle_combat_think(combat_on, combat_off);

	// start by activating the clip brush and triggers
	collide_array = getentarray (combat_head,"targetname");

	for (i = 0; i < collide_array.size; i++) {
		//collide_array[i] show();
		collide_array[i] solid();
	}

	while (level.indexed_combat_active[combat_index] == true) {

		wait(2);

		if (level.combat_warning == true) {
			println("^6--- COMBAT WARNING ---");
			thread process_warning();
		}
	}

	println("^6COMBAT GATE RELEASED");

	// tell the level we are done with this round of combat
	level notify("combat complete");

	// now hide them again since we are no longer in combat

	for (i = 0; i < collide_array.size; i++) {
		//collide_array[i] show();
		collide_array[i] notsolid();
	}

}

process_warning() {

	// bail if the sound has been played recently
	if (level.warning_active == true) {
		//println("^6BAILING ON WARNING");
		return;
	}

	// play a random warning 
	level.playertank playsound("kursk_cmdr_hint_wrongway");
	//println("^6PLAY WARNING");

	// clamp down on sounds
	level.warning_active = true;
	wait(15);

	// allow sounds to be played again
	level.warning_active = false;

}
