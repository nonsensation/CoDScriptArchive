main()
{
	precacheFX();
    spawnRailFX();

	// thread all one shot sound triggers
	initSoundTriggers();

	// setup triggers to turn off sound emmiters 
	// on a per area basis
	initAreaSFXTriggers();
}

precacheFX()
{
	// used by script_exploders throughout the level
    level._effect["stone"]	= loadfx ("fx/cannon/stone.efx");
    level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
	level._effect["wood"]	= loadfx ("fx/cannon/wood.efx");

	// for the Railstation Panzerfaust event
	level._effect["rockettrail"]				= loadfx ("fx/smoke/smoke_trail_panzerfaust.efx");
	level._effect["rocketexplosion_dirt"]		= loadfx ("fx/weapon/explosions/rocket_dirt.efx");
	level._effect["rocketexplosion_metal"]		= loadfx ("fx/weapon/explosions/rocket_metal.efx");
	level._effect["blow_mg42_nest"]				= loadfx ("fx/map_trenches/sand_bagsA.efx");
	
	// watertower approach and explosions
	level._effect["mortar"]						= loadfx ("fx/impacts/newimps/dirthit_mortar2day.efx");
	level._effect["watertower"]					= loadfx ("fx/pi_fx/watertower2.efx");

	// --- ambient effects ---

	// burining tank
	level._effect["tank_smoke_hi"]				= loadfx ("fx/pi_fx/medium_smoulder_high");

	// boiler room fires
	level._effect["boiler_fire"]				= loadfx ("fx/pi_fx/boiler_fire_small");

	// boiler stack steam
	level._effect["chimney_steam"]				= loadfx ("fx/pi_fx/factory_steam");

	// house fires and smoke
	level._effect["house_fire_hi"]				= loadfx ("fx/pi_fx/house_fire_high");
	level._effect["small_rubble_smk"]			= loadfx ("fx/pi_fx/small_rubble_smk");
	level._effect["medium_rubble_smk"]			= loadfx ("fx/pi_fx/medium_rubble_smk");
	level._effect["small_wall_smk"]				= loadfx ("fx/pi_fx/small_wall_smk");
	level._effect["heavy_smoulder"]				= loadfx ("fx/pi_fx/heavy_smoulder");

	// Water drips
	level._effect["water_drip"]					= loadfx ("fx/pi_fx/fast_drip");

}

spawnRailFX()
{

	// Search script origins for specific targetnames 
	// to denote effects

	// --- CONTINUOUS PARTICLES ---

	println("^5 spawnRailFX: starting up FX");
	// large house fire
	startVfxGroup( "vfx_house_fire", "house_fire_hi", "house_fire_hi", undefined, undefined, 2000, "stop_rail_FX");
	startVfxGroup( "vfx_small_rubble_smk", "small_rubble_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
	startVfxGroup( "vfx_medium_rubble_smk", "medium_rubble_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
	startVfxGroup( "vfx_small_wall_smk", "small_wall_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
	startVfxGroup( "vfx_heavy_smoulder", "heavy_smoulder", undefined, undefined, undefined, 2000, "stop_rail_FX");
}

spawnPlatformFX()
{
	println("^5 spawnPlatformFX: starting up FX");
	startVfxGroup( "vfx_small_wall_smk_platform", "small_wall_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
}

spawnStationFX()
{
	println("^5 spawnStationFX: starting up FX");
	startVfxGroup( "vfx_small_rubble_smk_station", "small_rubble_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
	startVfxGroup( "vfx_small_wall_smk_station", "small_wall_smk", undefined, undefined, undefined, 2000, "stop_rail_FX");
}

spawnPostRailFX()
{
	println("^5 spawnPostRailFX: starting up FX");
	startVfxGroup( "vfx_house_fire_post_rail", "house_fire_hi", "house_fire_hi", undefined, undefined, 2000, "stop_wt_fx");
	startVfxGroup( "vfx_small_rubble_smk_post_rail", "small_rubble_smk", undefined, undefined, undefined, 2000, "stop_wt_fx");
	startVfxGroup( "vfx_medium_rubble_smk_post_rail", "medium_rubble_smk", undefined, undefined, undefined, 2000, "stop_wt_fx");
}

// for factory interior effects
spawnFactoryFX()
{
	println("^5 spawnFactoryFX: starting up FX");
	// boiler/fireplace fire
	startVfxGroup( "vfx_boiler_fire", "boiler_fire", "boiler_fire", undefined, undefined, 2000);

	// water drips in top level of the factory
	startVfxGroup( "vfx_pipe_drip", "water_drip", "water_drip", undefined, undefined, 2000);
}

// for the smoke and stuff inside the school
spawnSchoolFX()
{
	println("^5 spawnSchoolFX: starting up FX");
	startVfxGroup( "vfx_small_wall_smk_school", "small_wall_smk", undefined, undefined, undefined, 2000, "stop_school_fx");
}

// for post-school stuff (factory approach and factory exterior effects)
spawnFappFX()
{
	println("^5 spawnFappFX: starting up FX");
	startVfxGroup( "vfx_house_fire_fapp", "house_fire_hi", "house_fire_hi", undefined, undefined, 2000, "stop_fapp_fx");
	startVfxGroup( "vfx_small_rubble_smk_fapp", "small_rubble_smk", undefined, undefined, undefined, 2000, "stop_fapp_fx");
	startVfxGroup( "vfx_medium_rubble_smk_fapp", "medium_rubble_smk", undefined, undefined, undefined, 2000, "stop_fapp_fx");
	startVfxGroup( "vfx_small_wall_smk_fapp", "small_wall_smk", undefined, undefined, undefined, 2000, "stop_fapp_fx");
	startVfxGroup( "vfx_heavy_smoulder_fapp", "heavy_smoulder", undefined, undefined, undefined, 2000, "stop_fapp_fx");

	// factory - chimney steam
	startVfxGroup( "vfx_stack_steam", "chimney_steam", "chimney_steam", undefined, undefined, 2000);
}

// find all script origins with 'targetname' and start an effect

startVfxGroup( targetName, hi_fxId, low_fxId, frequency, duration,  lod_dist, stop_notifcation)
{
	matched = false;

	// default parameters
	if (!isdefined(frequency)) 
		frequency = 0.3;

	if (!isdefined(lod_dist))
		lod_dist = 2000;

	// find all targets
	fx_array = getentarray ( targetName, "targetname" );

	// start all target emmiters
	if(isdefined (fx_array) )
	{
		for ( x = 0; x < fx_array.size; x++)
		{
			if(isdefined(fx_array[x]))
			{
				//			  loopfx(fxId,     fxPos,              waittime,  fxPos2,    fxStart,   fxStop,            timeout, low_fxId, lod_dist)
				maps\_fx_gmi::LoopFx( hi_fxId, fx_array[x].origin, frequency, undefined, undefined, stop_notifcation, duration, low_fxId, lod_dist);
				matched = true;
			}
		}
	}

	if(matched == false)
		println("^4 WARNING: startVfxGroup could not find a script_origin using fx "+targetName+"!");
}

// find all script origins with 'targetname' and start sound loop

startSfxGroup(targetName, filename)
{
	matched = false;

	sfx_array = getentarray ( targetName, "targetname" );

	// start all target sound emmiters
	if(isdefined (sfx_array) )
	{
		for ( i = 0; i < sfx_array.size; i++)
		{
			if(isdefined(sfx_array[i]))
			{
				sfx_array[i] playloopsound( filename );
				matched = true;
			}
		}
	}	

	if(matched == false)
		println("^4 WARNING: startSfxGroup could not find a script_origin using fx "+targetName+"!");
}

// find all script origins with 'targetname' and kill sound loop

stopSfxGroup(targetName, filename)
{

	sfx_array = getentarray ( targetName, "targetname" );

	// start all target sound emmiters
	if(isdefined (sfx_array) )
	{
		for ( i = 0; i < sfx_array.size; i++)
		{
			if(isdefined(sfx_array[i])) {
				sfx_array[i] stoploopsound( filename );
			}
		}
	}	
}

// For the sound events, the trigger will point to a script origin
// as the target. The script origin will store the sound alias name
// in its target.

// run a thread for all sound event triggers

initSoundTriggers()
{

	trigArray = getentarray("trig_sound_event", "targetname");

	// thread all one shot sound event triggers
	if(isdefined (trigArray) )
	{
		for ( i = 0; i < trigArray.size; i++)
		{
			if(isdefined(trigArray[i])) {
				thread initSoundEvent( trigArray[i] );
			}
		}
	}	
}

// take a single sound event trigger wait to play its sound

initSoundEvent( triggerEnt )
{

	if ( !isdefined(triggerEnt) ) {
//		println("^1Undefined trigger passed to initSoundEvent().");
		return;
	}

	triggerEnt waittill( "trigger" );

	// script origin is the trigger target
	origin = getent( triggerEnt.target, "targetname");

	if ( !isdefined(origin) ) {
//		println("^1Sound origin not found in initSoundEvent().");
		return;
	}

	// sound alias is the script origin target
	origin playsound( origin.target );

}

// area triggers will toggle specified effects
// such as sounds or particles that need to be 
// shut off/on to cure sounds bleeding into undesired areas
// or high processor cost due to overdraw.

initAreaSfxTriggers()
{

	areaTrigArray = getentarray("trig_area_fx", "targetname");

	// thread all area sound management triggers
	if(isdefined (areaTrigArray) )
	{
		for ( i = 0; i < areaTrigArray.size; i++)
		{
			if(isdefined(areaTrigArray[i])) {
				// wait for this area to become active
				thread manageAreaSfx( areaTrigArray[i], true );
			}
		}
	}	
}

// manageAreaSfx() 
//
// - primarily designed for interior spaces with walls
// or mulitple floors. This will keeps sounds from being
// audible in undesired areas (i.e. hearing the load radio 2 floors up)

// resetAreaFlag = true is used for initing the trigger
// resetAreaFlag = false is used for recursing when hitting duplicate
//	area triggers while the area is already active

manageAreaSfx( areaTrigger, resetAreaFlag )
{

	if (!isdefined(areaTrigger) ) {
//		println("^1Undefined trigger passed to initAreaFX().");
		return;
	}

	// add a global flag for each area trigger
	// use the target name for a unique flag name

	if ( resetAreaFlag == true ) {
		level.flags[areaTrigger.target] = false;
	}

	// wait to enter the area

	areaTrigger waittill( "trigger" );

	// Since multiple triggers will point to the same emitters,
	// protect against multiple sound starts. This should be happening
	// since all triggers that share the same targets are turned off.

	if (level.flags[areaTrigger.target] == true) {

		// restart the thread
		thread manageAreaSfx( areaTrigger, false );
//		println("^1Recursing in initAreaFX().");
		return;

	} else {
		// set the level flags
		setActiveAreaSfx(areaTrigger);

		// turn off all triggers that share targets
		triggerOffByTarget(areaTrigger.target);
	}

//	println("^1Started area trigger.");

	// Find all sound emitters that are attached to
	// this area trigger.

	areaSFXArray = getentarray( areaTrigger.target, "targetname" );

	// start the associated looping sounds

	if(isdefined (areaSFXArray) )
	{
		for ( i = 0; i < areaSFXArray.size; i++)
		{
			if(isdefined(areaSFXArray[i])) {

				// Each sound emitter stores its
				// related sound alias as the target name

				areaSFXArray[i] playloopsound( areaSFXArray[i].target );
			}
		}
	}

	// wait for the active flag to go false

	while ( level.flags[areaTrigger.target] == true )
	{
		wait(0.25);
	}

	// enterd a new area, kill all associated sounds

	if(isdefined (areaSFXArray) )
	{
		for ( i = 0; i < areaSFXArray.size; i++)
		{
			if(isdefined(areaSFXArray[i])) {

				areaSFXArray[i] stoploopsound( areaSFXArray[i].target );
			}
		}
	}

	// re-activate the triggers

	triggerOnByTarget( areaTrigger.target );

}

// reset all areaSfx flags, only activating the current area

setActiveAreaSfx( activeArea )
{

	areaTrigArray = getentarray("trig_area_fx", "targetname");

	// set all areas to false

	if( isdefined(areaTrigArray) ) {

		for ( i = 0; i < areaTrigArray.size; i++) {

			if(isdefined(areaTrigArray[i])) {
				// negate all flags
				level.flags[areaTrigArray[i].target] = false;
			}
		}
	}

	// set the active area
	if ( isdefined(activeArea) )
	{
		level.flags[ activeArea.target ] = true;
	}


}

// triggerOffByTarget()
//
// -turn off all triggers that share this target

triggerOffByTarget(triggerTarget) 
{

	areaTrigArray = getentarray("trig_area_fx", "targetname");

	if(isdefined (areaTrigArray) )
	{
		for ( i = 0; i < areaTrigArray.size; i++)
		{
			if(isdefined(areaTrigArray[i])) {

				if ( areaTrigArray[i].target == triggerTarget ) {
					// trigger is the same, turn it off
					areaTrigArray[i] maps\_utility_gmi::triggerOff();
//					println("^1Turned off area trigger.");		
				}
			}
		}
	}
}

// triggerOnByTarget()
//
// -turn on all triggers that share this target

triggerOnByTarget(triggerTarget) 
{

	areaTrigArray = getentarray("trig_area_fx", "targetname");

	// thread all area sound management triggers
	if(isdefined (areaTrigArray) )
	{
		for ( i = 0; i < areaTrigArray.size; i++)
		{
			if(isdefined(areaTrigArray[i])) {

				if ( areaTrigArray[i].target == triggerTarget ) {
					// trigger is the same, turn it off
					areaTrigArray[i] maps\_utility_gmi::triggerOn();
//					println("^1Turned on area trigger.");		
				}
			}
		}
	}
}
