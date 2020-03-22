main()
{
	precacheFX();
	spawnWorldFX();				
}

precacheFX()
{
	// Atmosphere=========================//
	level._effect["clouds_lo"]		= loadfx ("fx/map_bomber/cloudlayer_2d_altocumulus");
	level._effect["clouds_hi"] 		= loadfx ("fx/map_bomber/cloudlayer_2d_cirrus");
	level._effect["clouds_3d"]		= loadfx ("fx/map_bomber/cloudlayer_3d_altocumulus");
	level._effect["clouds_levelstart"] 	= loadfx ("fx/map_bomber/clouds_levelstart");
	level._effect["ground_levelstart"] 	= loadfx ("fx/map_bomber/ground_levelstart");
	level._effect["ground_ocean"]		= loadfx ("fx/map_bomber/ground_ocean");
	level._effect["ground_coast"]		= loadfx ("fx/map_bomber/ground_coast");
	level._effect["ground_fields"]	 	= loadfx ("fx/map_bomber/ground_fields");
	level._effect["ground_city"]		= loadfx ("fx/map_bomber/ground_city");


	// Explosions=========================//
	level._effect["flak_field"]		= loadfx ("fx/map_bomber/flak_field_medium");
	level._effect["flak_many"]		= loadfx ("fx/map_bomber/flak_field_many");
	level._effect["b17engine_exp"] 		= loadfx ("fx/explosions/vehicles/b17_n/debree_exp_p");
	level._effect["b17_dis"] 		= loadfx ("fx/explosions/vehicles/b17_complete");
	level._effect["b17_rwing"] 		= loadfx ("fx/explosions/vehicles/b17_rwing");
	level._effect["distant_bombs"] 		= loadfx ("fx/map_bomber/ground_exp");
	level._effect["tail_event"]		= loadfx ("fx/map_bomber/tail_event");

	//single flak hit no metal debris
	level._effect["flak_hit_near"]		= loadfx ("fx/map_bomber/flak_single_400_pushed");

	//radio op hit
	level._effect["flak_hit_int"] 		= loadfx ("fx/explosions/artillery/flak_single_200");


	// Fires==============================//
	level._effect["engine_fire"] 		= loadfx ("fx/map_bomber/b17_enginefire_close");
	level._effect["b17flame1"] 		= loadfx ("fx/map_bomber/b17_enginefire_large");
	level._effect["b17flame2"] 		= loadfx ("fx/map_bomber/b17_enginefire_small");
	level._effect["firetrail"] 		= loadfx ("fx/map_bomber/fire_trail_fighter");	
	level._effect["bomber_enginefire1"]	= loadfx ("fx/map_bomber/b17_engineburst_close");	
	level._effect["bomber_enginefire2"]	= loadfx ("fx/map_bomber/b17_enginefire_close");
	level._effect["tail_fire"]		= loadfx ("fx/map_bomber/tail_fire");	


	// Smoke===============================//
	level._effect["smoketrail"] 		= loadfx ("fx/map_bomber/smoke_trail_fighter");     
	level._effect["bomber_enginesmoke"] 	= loadfx ("fx/map_bomber/b17_enginesmoke_close");
	level._effect["bomber_enginesmoke_end"]	= loadfx ("fx/map_bomber/b17_enginesmoke_end");    


	// Weapon FX==========================//
	level._effect["bullet_hit"] 		= loadfx ("fx/weapon/impacts/impact_lmg_metal");
	level._effect["b17_shoot"] 		= loadfx ("fx/weapon/muzzleflash/mf_50cal");
	level._effect["b17_shoot_view"] 	= loadfx ("fx/weapon/muzzleflash/mf_50cal_b17dorsaltail_v");

	//used for the waistgunners firing anims
	level._effect["waist_tracer"]		= loadfx ("fx/weapon/tracer/tracer_50cal_waistgun");

	//used for waist gunners' deaths
	level._effect["bullet_tracer"] 		= loadfx ("fx/weapon/tracer/tracer_50cal");		

	//used for waist gunners' deaths
	level._effect["bullet_tracer_view"] 	= loadfx ("fx/weapon/tracer/tracer_50cal_view");		


	// Misc =============================//
	level._effect["bomber_fuelleak"] 	= loadfx ("fx/vehicle/fuelleak_bomber");
	level._effect["crewbail"] 		= loadfx ("fx/map_bomber/bombercrew_bail_a");
	level._effect["o2_spray"] 		= loadfx ("fx/smoke/o2_spray");
	level._effect["contrail_bomber"] 	= loadfx ("fx/vehicle/contrail_bomber");
	level._effect["contrail_fighter"] 	= loadfx ("fx/vehicle/contrail_fighter");

	//player hit
	level._effect["blood_splat"] 		= loadfx ("fx/impacts/flesh_hit.efx");

	//sparking turret
	level._effect["turret_sparking"] 	= loadfx ("fx/map_bomber/turret_damaged");		
}

spawnWorldFX()
{
// Reference =======================//
//maps\_fx_gmi::OneShotfx( effectname, (x y z), predelay);

	//Check the "optimal settings" cvar and don't play some of the particles if it's on "low"

	s_fast = getcvar("scr_gmi_fast");

// Atmosphere =======================//
	
	if(s_fast != "2")
	{
		println("Playing full cloud fx");

		maps\_fx_gmi::loopfx("clouds_lo", (0, 0, 0), 60.0);	
		maps\_fx_gmi::loopfx("clouds_hi", (0, 0, 0), 70.0);
	}

	maps\_fx_gmi::loopfx("clouds_3d", (0, 0, 0), 5.0);
		
	maps\_fx_gmi::OneShotfx("clouds_levelstart", ( 0, 0, 0 ), 0.0 );
	maps\_fx_gmi::OneShotfx("ground_levelstart", ( 0, 0, 0 ), 0.0 );
}