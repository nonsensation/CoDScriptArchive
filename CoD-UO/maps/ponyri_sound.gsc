main() {

	// start the music manager
	thread music();

	// declare our static ambient variables
	level.flakTimeMin = 4.0;
	level.flakTimeMax = 8.0;
	level.mgSprayTimeMin = 2.0;
	level.mgSprayTimeMax = 4.0;
	level.mp1TimeMin = 2.0;
	level.mp1TimeMax = 4.0;
	level.mp2TimeMin = 4.0;
	level.mp2TimeMax = 8.0;
	level.gerTauntMin = 10.0;
	level.gerTauntMax = 15.0;
	level.rusTauntMin = 10.0;
	level.rusTauntMax = 15.0;

	level.ambient_sound_distance_base = 0.0;

	thread amb_sound_manage();

}

playMusicTrack( soundAlias, triggerName, playTime, fadeTime ) {

	// if there is no trigger, skip straight to the music

	if (isdefined(triggerName)) {
		trig = getent(triggerName, "targetname");
		trig waittill("trigger");
	}

	// start the music
//	println("^3MUSIC: Playing ", soundAlias, " for ", playTime);
	musicplay(soundAlias);
	wait(playTime);

	// fade out after playTime
//	println("^3MUSIC: Stopping ", soundAlias, " in ", fadeTime);
	musicstop(fadeTime);

}


// Manage the music cues

music() {

	// start threaded music first

	// the initial path to the railyard
//	thread playMusicTrack("rail_approach", "music_rail_approach", 45, 5);
	
	// entering the rail station
//	thread playMusicTrack("rail_takeover", "music_rail_takeover", 45, 5);
	
	// heading to the school
//	thread playMusicTrack("school_approach", "music_school_approach", 45, 5);

	// going up the stairs to the nest gunner
//	thread playMusicTrack("school_upstairs", "music_school_upstairs", 45, 5);

	// sneaking around the back to take out the first panzer
//	thread playMusicTrack("factory_approach", "music_factory_approach", 45, 5);

	// entering the factory basement
	thread playMusicTrack("factory_enter", "music_factory_enter", 45, 5);

	// heading to the school
//	thread playMusicTrack("factory_takeover", "music_factory_takeover", 45, 5);


	// handle non-threaded music events next

}

// an ambient sound manager for generated ambient sounds
// these sounds are in addition to the true ambient track

amb_sound_manage() {

	while(1) {

		// init all of the ambient component managers

		// a deeper flak sound
		min = level.flakTimeMin;
		max = level.flakTimeMax;
		rmin = 240;
		rmax = 380;
		thread amb_component_think("amb_comp_flak", min, max, rmin, rmax);

		// heavy machine gun
		min = level.mgSprayTimeMin;
		max = level.mgSprayTimeMax;
		rmin = 180;
		rmax = 240;
		thread amb_component_think("amb_comp_heavyMG", min, max, rmin, rmax);

		// single shot mg
		min = level.mp1TimeMin;
		max = level.mp1TimeMax;
		rmin = 160;
		rmax = 240;
		thread amb_component_think("amb_comp_lightMG1", min, max, rmin, rmax);

		// multiple shot mg
		min = level.mp2TimeMin;
		max = level.mp2TimeMax;
		rmin = 160;
		rmax = 240;
		thread amb_component_think("amb_comp_lightMG2",min, max, rmin, rmax);

		// random voices from germans and russians
		
		// german
		rmin = 180;
		rmax = 360;
		min = level.gerTauntMin;
		max = level.gerTauntMax;
//		thread amb_component_think("amb_comp_gerTaunt", min, max, rmin, rmax);

		// russian
		min = level.rusTauntMin;
		max = level.rusTauntMax;
//		thread amb_component_think("amb_comp_rusTaunt", min, max, rmin, rmax);

		// start over if the ambient parameters have been changed
		level waittill( "refresh_ambient" );

		// kill all of the current ambient manager threads
		level notify ( "kill_amb_thread" );

	}
}

//-----------------------------------
//
// amb_component_think()
//
// manage an ambient sound component
//
// sound_alias:
// min_wait: Min time between sounds
// max_wait: Max time between sounds
// min_rad: Minimum (Inner) Radius for sound offset
// max_rad: Max (Outer) Radius for sound offset
// target_obj_name: Optional, forces the sound to stick to an object
//				other than the player.
//
//-----------------------------------


amb_component_think(sound_alias, min_wait, max_wait, min_rad, max_rad, target_obj_name) 
{
	level endon("kill_amb_thread");

	rad_range = max_rad - min_rad;
	wait_range = max_wait - min_wait;

	player_center = true;

	if ( isdefined(target_obj_name) )
	{
		target_ent = getent(target_obj_name, "targetname");
		if(isdefined (target_ent))
		{
			player_center = false;
		}
	}

	while (1)
	{
		// randomly place the sound somewhere around the player
		playPos = level.player.origin;

		// use an offset if using the player
		if (player_center)
		{
			// This method really just picks from the 4 corners around the player
			x_offset = (randomint( rad_range ) + min_rad) + level.ambient_sound_distance_base;
			y_offset = (randomint( rad_range ) + min_rad) + level.ambient_sound_distance_base;

			// pick a quadrant...
			if (randomint(1)) 
				x_offset *= -1;
			if (randomint(1)) 
				y_offset *= -1;

			// apply the offset
			offset = (x_offset, y_offset, 0);
			playPos = level.player.origin + offset;
		}
		else
		{
			// get the direction between the player and the sound location
			offset = vectorNormalize(target_ent.origin - level.player.origin);
			radius = (randomint( rad_range ) + min_rad) + level.ambient_sound_distance_base;
			playPos = level.player.origin + maps\_utility_gmi::vectorScale(offset, radius);
		}

		// make the object to play from
		playOrigin = spawn ("script_origin",playPos);
		if( isdefined(playOrigin))
		{
	//		if (player_center) {
				// link to player so the sound will travel
				playOrigin linkto (level.player);
	//		}
			
			playOrigin playsound (sound_alias, "sounddone");
			//println("^6SOUND:", sound_alias);

			playOrigin waittill("sounddone");
			playOrigin delete();
		}
		else
			println("^6SOUND: Origin NOT defined...");

		// wait for a random time period before launching the 
		// next ambient sound component
		wait(min_wait + randomint(wait_range));
	}

}


// general check for ent definitions, returns true if ent is defined.
// returns false a prints an error message if the ent is not found.
/*
defineCheck(ent_object, targetname) {

	if (isdefined(ent_object)) {
		// ent was found
		return true;
	} else {
		// print error and return false
		println("^3ENT DEFINED: ", targetname, " ^3 is not defined.");
		return false;
	}
}
*/