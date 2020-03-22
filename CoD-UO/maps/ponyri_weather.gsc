main()
{
	level.flags["weather_thread_active"] = false;

	cacheWeather();

	level thread weather();
	level thread wind();
}

cacheWeather()
{
	// precipitation
	level._effect["light_rain"] = loadfx ("fx/pi_fx/rain_light");
	level._effect["medium_rain"] = loadfx ("fx/pi_fx/rain_medium");
	level._effect["heavy_rain"] = loadfx ("fx/pi_fx/rain_heavy");
	level._effect["no_rain"] = loadfx ("fx/pi_fx/null");
	
	// sky dome effects
	level._effect["lightning"] = loadfx ( "fx/pi_fx/lightning_sky" );
}

wind()
{
	startTrig = getent( "wind_active", "targetname" );
	startTrig waittill( "trigger" );

	// start the wind with random power
	level.windActive = true;

	thread startRandomWind();

	// check all triggers that will kill the wind

	wind_stop_array = getentarray("wind_inactive", "targetname");

	if ( isdefined(wind_stop_array) ) 
	{

		for ( i = 0; i < wind_stop_array.size; i++)
		{
			if(isdefined(wind_stop_array[i])) 
			{
				wind_stop_array[i] thread stop_wind_think();
			}
		}
	}
}


// handle trigger(s) for halting the wind

stop_wind_think() 
{
	self waittill( "trigger" );

	level.windActive = false;

	// ambient stop/fade does appear to work as expected
	// play a null track to force an actual fade
	ambientPlay("ambient_null",4);
}


// adjusted based on trenches script

startRandomWind() 
{
	// variable strength
	old_strength = 0;

	// constant wind direction
	angle = (0,90,0);

	ambientPlay("ambient_strong_wind",4);

	while( level.windActive == true )
	{
		strength = (175 + randomint(50));

		difference = strength - old_strength;

		// adjust the wind by one step every wait interval

		adjustPeriod = 0.1;

		if(difference < 0)
		{
			for(i=0;i>difference;i--)
			{
				setwind(angle, old_strength + i);			
				wait adjustPeriod;
			}
		}
		else
		{
			for(i=0;i<difference;i++)
			{
				setwind(angle, old_strength + i);			
				wait adjustPeriod;
			}
		}

		old_strength = strength;
		wait (2 + randomfloat(3));
	}

	// reset the wind to zero
	setwind ( (0,0,0), 0 );
}

weather() 
{
	level.atmosphere_fx = level._effect["no_rain"];

	// this should be more dynamic rather than a one time start
	thread startSkyEffects();

//	startWeather(undefined);

	// in school, have a blast of thunder and start raining
	trig1 = getent( "school_enter_rain", "targetname" );
	if(isdefined(trig1)) 
	{
		trig1 waittill ( "trigger" );

		level.atmosphere_fx = level._effect["medium_rain"];
		if(	level.flags["weather_thread_active"] == false)
		{
			level.flags["weather_thread_active"] = true;
			level thread maps\_atmosphere::_spawner(); 
		}

//		startWeather("medium_rain");
		trig1 playsound( "thunder_loud" );
		ambientPlay("ambient_medium_rain",2);
	}

	// entering the shelled house just before the 1st panzer
	trig2 = getent( "factory_clear_sky", "targetname" );

	if (isdefined(trig2)) 
	{
		trig2 waittill ( "trigger" );

		level.atmosphere_fx = level._effect["light_rain"];
		if(	level.flags["weather_thread_active"] == false)
		{
			level.flags["weather_thread_active"] = true;
			level thread maps\_atmosphere::_spawner(); 
		}

//		startWeather("light_rain");
		ambientPlay("ambient_light_rain",2);
	}

	// running to the factory gate
	trig3 = getent( "factory_heavy_rain", "targetname" );

	if(isdefined (trig3)) 
	{
		trig3 waittill ( "trigger" );

		level.atmosphere_fx = level._effect["heavy_rain"];
		if(	level.flags["weather_thread_active"] == false)
		{
			level.flags["weather_thread_active"] = true;
			level thread maps\_atmosphere::_spawner(); 
		}

//		startWeather("heavy_rain");
		trig3 playsound( "thunder_loud" );
		ambientPlay("ambient_heavy_rain",2);
	}

}

// weather sky dome effects
startSkyEffects()
{

	sky_fx_array = getentarray("vfx_lightning", "targetname");
	while(1)
	{
		wait (1 + randomfloat(2));
		fxNum = randomint (sky_fx_array.size);
		playfx( level._effect["lightning"], sky_fx_array[fxNum].origin );

		// play random thunder 
		rand = randomint(20);
		if (rand == 1) {
			level.player playsound( "thunder" );
		}
	}
}

stopWeather()
{
	level notify ("stop_atmosphere");
	level.flags["weather_thread_active"] = false;
	level.atmosphere_fx = level._effect["no_rain"];
}
