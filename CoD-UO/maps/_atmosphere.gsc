/*
	simple atmosphere particles get spawned in front of the player 
 */
_spawner()
{
	//	force a default value if not defined for speed
	

	if (!isdefined(level.atmosphere_speed))
		level.atmosphere_speed = 0.05;
	if (!isdefined(level.atmosphere_fx))
			level.atmosphere_fx = loadfx ("fx/atmosphere/rain_medium.efx");
	//level.atmosphere_fx =loadfx("fx/atmosphere/rainjed.efx");
	
	level endon("stop_atmosphere");
	while(1)
	{
		player = getent("player","classname");
		if (!isalive(player))
			return;

		playfxonplayer(player,level.atmosphere_fx);

		wait(level.atmosphere_speed);
	}

}

