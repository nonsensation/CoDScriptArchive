main() {

	// start the music manager
	//thread music();

	// declare our static ambient variables
	level.flakTimeMin = 3.0;
	level.flakTimeMax = 5.0;
	level.heavyFireMin = 3.0;
	level.heavyFireMax = 4.0;
	level.mgSprayTimeMin = 2.0;
	level.mgSprayTimeMax = 4.0;
	level.mp1TimeMin = 2.0;
	level.mp1TimeMax = 4.0;
	level.mp2TimeMin = 4.0;
	level.mp2TimeMax = 8.0;
	level.ambient_sound_distance_base = 0.0;

	// start with a large number, so we will definitely play a vo
	// on the first shot
	level.nice_shot_time = gettime();
	level.vo_played = gettime();
	level.ignore_nice_shot = false;

	// keep a count so we can have unique aliases
	// with each kill
	level.nice_shot_count = 0;

	// start the ambient sound manager
	thread amb_sound_manage();

	// triggered VO
	thread triggered_VO_manage();

	// wait to play a sound on an ents death
//	thread death_sound("kursk_crew_shout1", "barrier_pak", 1.0);

}

// run only one thread at a time

triggered_VO_manage() {

	vo_wait("kursk_eyes_open", "vo_eyes_open");
	vo_wait("kursk_fire1", "vo_roadblock");
	vo_wait("kursk_clearing", "vo_fritz_fight");
}

play_nice_shot() {

	// get the time since the last 'nice shot' vo
	// gettime reports in milliseconds
	nice_shot_delta = (gettime() - level.nice_shot_time)/1000;
	vo_delta = (gettime() - level.vo_played)/1000;
	current_time = gettime();

	if (level.ignore_nice_shot == true) {
		return;
	}

	if (vo_delta < 5.0) {
		println("^6OVERLAPPING VO");
		return;
	}

	if (nice_shot_delta < 10.0) {
		println("^6TOO SHORT FOR NICE SHOT");
		return;
	}


	// only 8 aliases...don't repeat
	vo_max = 8;

	if (level.nice_shot_count >= vo_max) {
		level.nice_shot_count = 0;
	}

	level.nice_shot_count++;

	println("^6TANK KILL # ",level.nice_shot_count);
	level.playertank playsound("tankdrive_kill"+level.nice_shot_count);
	level.nice_shot_time = gettime();
}


// wait to play a sound when an ent dies

death_sound(sound_alias, ent_name, delay_time) {

	ent = getent(ent_name, "targetname");

	println("^6DEATH SOUND: Enter.");

	if (!isdefined(ent)) {
		println("^6DEATH SOUND: Ent not defined.");
		return;
	}

	ent waittill("death");
	wait (delay_time);
	level.playertank playsound(sound_alias);
	level.vo_played = gettime();
}

// wait to play a sound when a trigger is hit

vo_wait(sound_alias, trig_name) {

	trigger = getent(trig_name, "targetname");

	if (!isdefined(trigger)) {
		println("^6NO TRIGGER: ", sound_alias);
		return;
	}

	trigger waittill("trigger");
	level.playertank playsound(sound_alias);
	level.vo_played = gettime();
}

amb_sound_manage() {

	while(1) {

		// init all of the ambient component managers

		// a deeper flak sound
		min = level.flakTimeMin;
		max = level.flakTimeMax;
		rmin = 140;
		rmax = 240;
		thread maps\ponyri_sound::amb_component_think("amb_comp_flak", min, max, rmin, rmax);

		// larger artillery sounds
		min = level.heavyFireMin;
		max = level.heavyFireMax;
		rmin = 140;
		rmax = 240;
		thread maps\ponyri_sound::amb_component_think("amb_comp_hvy_gun", min, max, rmin, rmax);

		// heavy machine gun
		min = level.mgSprayTimeMin;
		max = level.mgSprayTimeMax;
		rmin = 220;
		rmax = 260;
		thread maps\ponyri_sound::amb_component_think("amb_comp_heavyMG", min, max, rmin, rmax, "local_sfx_1");

		// single shot mg
		min = level.mp1TimeMin;
		max = level.mp1TimeMax;
		rmin = 400;
		rmax = 450;
		thread maps\ponyri_sound::amb_component_think("amb_comp_lightMG1", min, max, rmin, rmax, "local_sfx_1");

		// multiple shot mg
		min = level.mp2TimeMin;
		max = level.mp2TimeMax;
		rmin = 400;
		rmax = 450;
		thread maps\ponyri_sound::amb_component_think("amb_comp_lightMG2",min, max, rmin, rmax, "local_sfx_1");

		// start over if the ambient parameters have been changed
		level waittill( "refresh_ambient" );

		// kill all of the current ambient manager threads
		level notify ( "kill_amb_thread" );

	}
}

// watch the tank health for damage VO

tank_crew_damage_chatter() {

	current_health = level.playertank.health;
	previous_health = level.playertank.health;
	max_health = level.playertank.maxhealth;

	// Change in health since last VO
	delta_health = (previous_health - current_health) / max_health;

	// The percentage of health loss inwhich we should start VO
	pct_to_notify = 0.07;

	while (1) {

		level.playertank waittill ("damage");

		current_health = level.playertank.health;
		delta_health = (float)(previous_health - current_health) / (float)max_health;

		// play vo if we have lost significant health
		// but not if we are down to zero health.
		if ((delta_health > pct_to_notify) &&
			(current_health > 0)
		) {
			level.playertank playsound("tankdrive_damaged");
			level.vo_played = gettime();
			previous_health = level.playertank.health;
		}
	}

}

killmusic(delay) {

	musicstop(delay);
}
