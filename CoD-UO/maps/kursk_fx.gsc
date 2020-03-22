main()
{
	// load and spawn all fx
	precacheFX();
    spawnWorldFX();

	// run the scripted ambient visual fx manager
	thread manage_amb_vfx();

	// constant ambient
	//thread fieldBattle();

	// contact triggers for exploders
	thread contact_exploders();

	if (getcvar("debug_swapfx") == "") {
		setcvar("debug_swapfx", "off");
	}


}

precacheFX()
{
	// Barrier Explosion FX
	level._effect["barrier_explosion"]			= loadfx("fx/explosions/artillery/pak88.efx");

	if (getcvar("debug_swapfx") == "on") {
		// Pi building effect
		level._effect["coolaidmanconcrete"]	= loadfx ("fx/pi_fx/exp_building.efx");
	} else {
		// try different effect for performance
		level._effect["coolaidmanconcrete"]	= loadfx ("fx/impacts/coolaidmanconcrete.efx");
	}
	level._effect["watertank"]	= loadfx ("fx/pi_fx/exp_watertank.efx");
	level._effect["paknet"]	= loadfx ("fx/pi_fx/exp_paktent.efx");
	level._effect["concrete"]	= loadfx ("fx/cannon/buildingpop.efx");
	level._effect["fire"]		= loadfx("fx/fire/fireheavysmoke.efx");
	level._effect["fence"]	= loadfx ("fx/pi_fx/exp_fence2.efx");
	level._effect["fence_runover"]	= loadfx ("fx/pi_fx/exp_fence_runover.efx");

	// Scripted Panzerfaust Events
	level._effect["rockettrail"]				= loadfx ("fx/smoke/smoke_trail_panzerfaust.efx");

	// FIXME - switch panzerfaust explosions to use uo standard FX
	level._effect["rocketexplosion"]			= loadfx ("fx/explosions/pathfinder_explosion.efx");

	// temp explosions for the panzerfaust
//	level._effect["house_fire_hi"]				= loadfx ("fx/pi_fx/house_fire_high");
	level._effect["medium_rubble_smk"]			= loadfx ("fx/pi_fx/medium_rubble_smk");
	level._effect["medium_armor_smk"]			= loadfx ("fx/pi_fx/pak_rubble_smk");

	// smoke effects
	level._effect["medium_smoulder"]			= loadfx ("fx/pi_fx/medium_smoulder");
	level._effect["heavy_smoulder"]				= loadfx ("fx/pi_fx/heavy_smoulder");

	level._effect["mortar"]						= loadfx ("fx/impacts/newimps/dirthit_mortar2day.efx");
	level._effect["tank_smoke_hi"]				= loadfx ("fx/pi_fx/medium_tank_smoulder");

	// ambient one time shots
	level._effect["amb_fx_blast"]				= loadfx ("fx/explosions/artillery/pak88.efx"); // requested by ATVI
    level._effect["hillflash2"]					= loadfx ("fx/pi_fx/hill_flash_day.efx");
}

spawnworldfx()
{

	maps\ponyri_fx::startVfxGroup( "vfx_smoulder_med", "medium_rubble_smk", "medium_rubble_smk", undefined, undefined, 2000);
	maps\ponyri_fx::startVfxGroup( "vfx_smoulder_armor", "medium_armor_smk", "medium_armor_smk", undefined, undefined, 2000);

	maps\ponyri_fx::startVfxGroup( "vfx_tank_smoulder_med", "tank_smoke_hi", "tank_smoke_hi", 0.6, undefined, 2000);

}
 
//-------------------------------------------
// manage_amb_vfx()
//
// A manager for all ambient visual affects.
//-------------------------------------------

manage_amb_vfx() {


	// Hide all models for the tree-line exploders

	// amb_fx_blast is the only fx id that needs to be addressed here

	fx_array = getentarray ("script_model","classname");

	println("^6FX MODELS: ", fx_array.size);

	for (i=0;i<fx_array.size;i++) {

		if (isdefined (fx_array[i])) {

			if ( fx_array[i].model == "xmodel/fx") {

				fx_array[i] hide();
			}
		}
	}

	// --- FIRST --- Startup

	trig = getent("trig_amb_explode1", "targetname" );
	trig waittill( "trigger" );

	explode_ent = getent( "amb_fx_2a", "targetname" );

	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");


	// --- SECOND --- convoy across the river

	trig = getent( "trig_amb_explode2", "targetname" );
	trig waittill( "trigger" );

	explode_ent = getent( "amb_fx_1a", "targetname" );

	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");

	wait(2);

	// 3rd point
	explode_ent = getent( "amb_fx_1c", "targetname" );
	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");



	// --- THIRD --- Just before the bridge

	trig = getent( "trig_amb_explode2b", "targetname" );
	trig waittill( "trigger" );

	// 2nd point
	explode_ent = getent( "amb_fx_2d", "targetname" );

	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");

	wait(1);

	// 3rd point
	explode_ent = getent( "amb_fx_2f", "targetname" );
	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");


	// --- FOURTH --- start just after the first exploder house.

	trig = getent("trig_amb_explode3", "targetname" );
	trig waittill( "trigger" );

	explode_ent = getent( "amb_fx_3a", "targetname" );

	if (isdefined (explode_ent.target))
		org = (getent (explode_ent.target,"targetname")).origin;
	level thread maps\_fx_gmi::OneShotfx(explode_ent.script_fxid, explode_ent.origin, 0.0, org);
	explode_ent playsound("stuka_bomb");

	wait(2);

	return;


}


fieldBattle ()
{

	// skyline flak flash
	vfxarray = getentarray("vfx_hill_flash", "targetname");

	for (i = 0; i < vfxarray.size; i++) {

		shotwaitmin = randomfloat(6.0);
		shotwaitmax = shotwaitmin + randomfloat(6.0);
		setwaitmin = randomfloat(8.0);
		setwaitmax = setwaitmin + randomfloat(8.0);

		vfxarray[i] thread gunfireloopfxthread("hillflash2", vfxarray[i],
								1, 4,
								shotwaitmin, shotwaitmax,
								setwaitmin, setwaitmax, "amb_comp_flak2", "kill_convoy_flash");		
	}

}

// again, uber special kursk code...

// Pass in groupnames for 2 active areas. This function will kill all other 
// active threads of this function. This function chooses from one of the origins
// from the two fx_arrays to play the fx_alias at.

activate_gunfire_loops(current_groupname, next_groupname, fxId, soundalias) {

	println("^6 Starting Gunfire Loop: ", current_groupname);
	// only allow one instance of this routine to be active at a time
	level notify ("kill_gunfire_loop");
	wait(1.0);
	level endon ("kill_gunfire_loop");

	current_fx_array = getentarray(current_groupname, "groupname"); 
	next_fx_array = getentarray(next_groupname, "groupname"); 

	// we will be pulling from both of the arrays at once
	total_fx_array = maps\kursk_tankdrive::add_array_to_array( current_fx_array, next_fx_array );

    for (;;)
    {
		// randomly pick one of the orgins from the list
		index = randomint(total_fx_array.size);
		fxPos = total_fx_array[index].origin;

		// play the visual and the audio
		playfx ( level._effect[fxId], fxPos );
		total_fx_array[index] playsound(soundalias);

        wait (randomfloat(3.0));
    }

}


// taken from _fx.gsc ... now with optional soundalias
//					  ... and end condition...

gunfireloopfxthread (fxId, fxPos, shotsMin, shotsMax, shotdelayMin, shotdelayMax, 
					 betweenSetsMin, betweenSetsMax, soundalias, end_condition)
{
	if (isdefined(end_condition)) {
		level endon(end_condition);
	}

	maps\_spawner::waitframe();

	if (betweenSetsMax < betweenSetsMin)
	{
		temp = betweenSetsMax;
		betweenSetsMax = betweenSetsMin;
		betweenSetsMin = temp;
	}

	betweenSetsBase = betweenSetsMin;
	betweenSetsRange = betweenSetsMax - betweenSetsMin;

	if (shotdelayMax < shotdelayMin)
	{
		temp = shotdelayMax;
		shotdelayMax = shotdelayMin;
		shotdelayMin = temp;
	}

	shotdelayBase = shotdelayMin;
	shotdelayRange = shotdelayMax - shotdelayMin;

	if (shotsMax < shotsMin)
	{
		temp = shotsMax;
		shotsMax = shotsMin;
		shotsMin = temp;
	}

	shotsBase = shotsMin;
	shotsRange = shotsMax - shotsMin;

    for (;;)
    {
		shotnum = shotsBase + randomint (shotsRange);
		for (i=0;i<shotnum;i++)
		{
			playfx ( level._effect[fxId], fxPos );
			self playsound(soundalias);
			wait (betweenSetsBase + randomfloat(betweenSetsRange));
		}
        wait (shotdelayBase + randomfloat (shotdelayRange));
    }
}

// Change the fx alias if the object is contacted rather than fired upon

contact_exploders() {

	trig_array = getentarray("contact_fence", "targetname");

	if (!isdefined(trig_array)) {
		return;
	}

	// These are all fences
	for (i = 0; i < trig_array.size; i++) {
		println("^6--- THREAD SECONDARY FX --- : "+ i + "  org("+trig_array[i].origin+")");
		trig_array[i] thread watch_exploder("fence_runover", "fence_fall");
	}
}

watch_exploder(fx_alias, sound_alias) {

	level endon ("killexplodertriggers"+self.groupname);
	self waittill ("trigger");
	
	// bypass the normal trigger (damage trigger)
	println("^6--- SECONDARY FX ---");

	thread exploder_secondary(self.groupname, fx_alias, sound_alias);
	level notify ("killexplodertriggers"+self.groupname);

}

exploder_secondary (exploder_num, secondary_alias, sound_alias) {

	ents = level._script_exploders;

	// play the sound once, at the first brush that is deleted
	sound_played = false;

	for (i=0;i<ents.size;i++)
	{
		if (!isdefined (ents[i]))
			continue;

		if (ents[i].script_exploder != exploder_num)
			continue;

		if (isdefined (ents[i].script_fxid)) {

			// play the sound using the fx model. It has legitimate coordinates
			if ((sound_played == false) && isdefined(sound_alias)) {
				// spawn a script origin so we have a legitimate ent to
				// play the sound at.
				playOrigin = spawn ("script_origin",ents[i].origin);
				playOrigin playsound(sound_alias);
				sound_played = true;
			}

			level thread explode_effect(ents[i], secondary_alias);
		}

		if (!isdefined(ents[i].targetname)) {
			ents[i].targetname = "none";
		}

		if (ents[i].targetname == "exploder") {
			ents[i] show();
		} else if (!isdefined (ents[i].script_fxid)) {
			ents[i] delete();
		}
	}
}

explode_effect ( source, alias )
{
	if (!isdefined (source.script_delay))
		source.script_delay = 0;

	if ((isdefined (source.script_delay_min)) && (isdefined (source.script_delay_max)))
		source.script_delay = source.script_delay_min + randomfloat (source.script_delay_max - source.script_delay_min);

	if (isdefined (source.target))
		org = (getent (source.target,"targetname")).origin;

	level thread maps\_fx_gmi::OneShotfx(alias, source.origin, source.script_delay, org);
}


brush_throw()
{
	eye_ori = level.player.origin;

	self show();

	temp_vec = ( eye_ori );

	x = 0;//temp_vec[0];
	y = 0;//temp_vec[1];
	z = 30;//temp_vec[2] + 30;

	x2 = eye_ori[0];
	y2 = eye_ori[1];
	z2 = eye_ori[2];

	println("^6-- FROM: ", x2, " ", y2, " ", z2);
	println("^6-- TO  : ", x, " ", y, " ", z);

//	self rotateVelocity ((x,y,z), 12);
//	self moveGravity ((x, y, z), 12);
	self moveTo ((x, y, z), 12);
	wait (6);
	self delete();

}

