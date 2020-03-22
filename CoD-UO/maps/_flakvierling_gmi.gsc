/////////////////////////////////////////////////////////////////////////////
// Flak Vierling
/////////////////////////////////////////////////////////////////////////////
#using_animtree( "artillery_flakvierling" );

main()
{
	precachemodel("xmodel/artillery_flakvierling_d");
	loadfx( "fx/explosions/vehicles/flakvierling_complete.efx" );
}


init(flak_fx_dist)
{
	self UseAnimTree( #animtree );

	self.health = 1000;
	if(isdefined(flak_fx_dist))
	{
		if(flak_fx_dist < 4096)
		{
			flak_fx_dist = 4096;
		}

		self.flak_fx_dist = flak_fx_dist;
	}

	thread kill();
	thread shoot();
}

kill()
{
	self.deathmodel = "xmodel/artillery_flakvierling_d";
	self.deathfx    = loadfx( "fx/explosions/vehicles/flakvierling_complete.efx" );
	self.deathsound = "explo_metal_rand";

	maps\_utility_gmi::precache( self.deathmodel );

	self waittill( "death", attacker );

	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self clearTurretTarget();

	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );

	self freeVehicle();
}

shoot()
{
	barrel = 1;
	while( self.health > 0 )
	{
		self waittill( "turret_fire" );
		self FireTurret();

		//MikeD: Added this to play fx in the distance when shooting this weapon
		if(isdefined(self.flak_fx_dist))
		{
			level thread shot_fx(self);
		}

		earthquake(0.2, .1, self.origin, 2250);

		playbackrate = 0.3 + randomfloat(0.25);
		if( barrel == 1 )
		{
			self setAnimKnobAllRestart( %artillery_flakvierling_fire1, %root, 1, 0.1, playbackrate );
			barrel = 2;
		}
		else
		{
			self setAnimKnobAllRestart( %artillery_flakvierling_fire2, %root, 1, 0.1, playbackrate );
			barrel = 1;
		}
	}
}

shot_fx(flak)
{
	if(!isdefined(level._effect["flak_air_exp"]))
	{
		println("^1level._effect['flak_air_exp'] is not defined!!!");
		return;
	}

	tag_origin = flak gettagorigin("tag_flash");
	tag_angles = flak gettagangles("tag_flash");

	vec = anglesToForward(tag_angles);
	fx_origin = tag_origin + maps\_utility_gmi::vectorScale(vec, flak.flak_fx_dist);

	trace_result = bulletTrace(tag_origin, fx_origin, false, flak);

	dist = distance(trace_result["position"],tag_origin);

	if(trace_result["surfacetype"] == "default")
	{
		dist = distance(fx_origin,tag_origin);
		the_origin = fx_origin;
	}
	else if(dist < 512)
	{
		return;
	}
	else if(dist < flak.flak_fx_dist)
	{
		the_origin = trace_result["position"];
	}
	else
	{
		dist = distance(fx_origin,tag_origin);
		the_origin = fx_origin;
	}

	println("Surfacetype: ", trace_result["surfacetype"]);

	wait (dist * .00005);

	playfx(level._effect["flak_air_exp"], the_origin);
	wait randomfloat(0.25);
	playfx(level._effect["flak_air_exp"], (the_origin + ((-256 + randomint(512)), (-256 + randomint(512)), (-256 + randomint(512)))) );
}

