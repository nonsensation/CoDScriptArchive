/*
	- each trigger_use has the same target name
	trigger_use must have origin brush or it will be usable even if activate_notify is set
	also needs that so the use icon goes away after use
	- each trigger_use targets the script_model of the objective_incomplete_explosivepack
	- each script_model explosivepack targets the script_model of the thing which is going to blow up
	- add script call, example script call:
	thread maps\_bombs_gmi::main(1, "Destroy the quad barreled AA guns [", " remaining]", "bomb_trigger");
	The "objective_number" parameter is the number of this objective,
	the "array_targetname" parameter is the target name of the trigger_use(s)
	The "activate_notify" parameter is the notify the bombs wait for before becoming usable
	If you want the bombs to explode at a specific time set .script_noteworthy values on the trigger_use(s)
	They will wait until that get a notify equal to .script_noteworthy before exploding
*/

init()
{
	//precacheShader("textures/hud/hud@stopwatch.tga");
	//precacheShader("textures/hud/hud@stopwatchneedle.tga");
	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");
	maps\_utility_gmi::precache ("xmodel/explosivepack");
}

main(objective_number, objective_text, array_targetname, activate_notify)
{
	bombs = getentarray (array_targetname, "targetname");
	//println (array_targetname, " bombs.size: ", bombs.size);
	level.timersused = 0;
	for (i=0;i<bombs.size;i++)
	{
		bombs[i].bomb = getent(bombs[i].target, "targetname");

		if(isdefined(bombs[i].bomb.target))
		{
			bombs[i].object = getentarray(bombs[i].bomb.target, "targetname");

			for (p=0;p<bombs[i].object.size;p++)
			{
				//println ("bomb target models: ", bombs[i].object[p].model);
				switch (bombs[i].object[p].model)
				{
				case "xmodel/artillery_flakvierling":
					bombs[i].object[p].d_model = "xmodel/artillery_flakvierling_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					maps\_utility_gmi::precache ("xmodel/artillery_flakvierling_d");
					break;
				case "xmodel/v2rocket":
					bombs[i].object[p].d_model = "delete";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					bombs[i].exp_sound = "Explo_V2_Rocket";
					break;
				case "xmodel/v2stand":
					bombs[i].object[p].d_model = "xmodel/v2stand_destroyed";
					bombs[i].object[p].d_fx = loadfx("fx/explosions/v2_exlosion.efx");
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/turret_flak88":
					if ( isdefined (bombs[i].object[p].script_flaktype) )
					{
						if (bombs[i].object[p].script_flaktype == "flakairlow")
						{
							bombs[i].object[p].d_model = "xmodel/turret_flak88_static_antiairlow_d";
							bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
						}

						// added 01/29/03 jeremy
						if (bombs[i].object[p].script_flaktype == "flaktank")
						{
							//bombs[i].object[p].d_model = "xmodel/turret_flak88_static_antiairlow_d";
							bombs[i].object[p].d_model = "xmodel/turret_flak88_d";
							bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
						}
					}
					else
					{
						bombs[i].object[p].d_model = "xmodel/panlarge";
						bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					}
					break;
				case "xmodel/turret_flak88_static_antiair":
					bombs[i].object[p].d_model = "xmodel/turret_flak88_static_antiair_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/turret_flak88_static_antiairlow":
					bombs[i].object[p].d_model = "xmodel/turret_flak88_static_antiairlow_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/vehicle_tank_tiger":
					bombs[i].object[p].d_model = "xmodel/vehicle_tank_tiger_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/vehicle_tank_tiger_camo":
					bombs[i].object[p].d_model = "xmodel/vehicle_tank_tiger_camo_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/turret_flak88_static_antitank":
					bombs[i].object[p].d_model = "xmodel/turret_flak88_static_antitank_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				case "xmodel/static_vehicle_tank_tiger_camo":
					bombs[i].object[p].d_model = "xmodel/vehicle_tank_tiger_camo_d";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				default:
					bombs[i].object[p].d_model = "xmodel/panlarge";
					bombs[i].d_fx = loadfx("fx/explosions/vehicles/generic_complete.efx");
					break;
				}
				//println ("bomb destroyed model: ", bombs[i].object[p].d_model);
				if (bombs[i].object[p].d_model != "delete")
					maps\_utility_gmi::precache (bombs[i].object[p].d_model);
			}
		}
		bombs[i].used = 0;
		bombs[i] thread bomb_think(activate_notify, array_targetname);
	}

	if (bombs.size != 0)
	{
		remaining_bombs = bombs.size;
		closest = get_closest_bomb (bombs);
		if (isdefined (closest))
		{
			objective_add(objective_number, "active", objective_text, (closest.bomb.origin));
			objective_string(objective_number, objective_text, remaining_bombs);
		}

		while (1)
		{
			level waittill (array_targetname + " planted");

			remaining_bombs --;
			objective_string(objective_number, objective_text, remaining_bombs);

			closest = get_closest_bomb (bombs);
			if (isdefined (closest))
			{
				objective_position(objective_number, (closest.bomb.origin));
				objective_ring(objective_number);
			}
			else
			{
				objective_state(objective_number, "done");
				temp = ("objective_complete" + objective_number);
				//println (temp);
				level notify (temp);
			}
		}
	}
}

get_closest_bomb(array)
{
	range = 500000000;
	for (i=0;i<array.size;i++)
	{
		if (!array[i].used)
		{
			newrange = distance (level.player getorigin(), array[i].bomb.origin);
			if (newrange < range)
			{
				range = newrange;
				ent = i;
			}
		}
	}
	if (isdefined (ent) )
		return array[ent];
	else
		return;
}

bomb_think (activate_notify, array_targetname)
{

//	println ("waittill trigger");

	self setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");

	if (isdefined (activate_notify))
	{
		self maps\_utility_gmi::triggerOff();
		self.bomb hide();

		level waittill (activate_notify);

		self.bomb show();
		self maps\_utility_gmi::triggerOn();
	}
	self waittill("trigger");
	//println ("triggered");

	self.used = 1;
	//iprintlnbold (&"SCRIPT_EXPLOSIVESPLANTED");
	self.bomb setModel("xmodel/explosivepack");
	level notify (array_targetname + " planted");
	if (isdefined (self.target))
		level notify (self.target + " planted");
	self maps\_utility_gmi::triggerOff();
	
	self.bomb playsound ("explo_plant_no_tick");
	
	if (isdefined (self.script_noteworthy))
		self waittill (self.script_noteworthy);
	else
	{
		self.bomb playloopsound ("bomb_tick");
		if (isdefined (level.bombstopwatch))
			level.bombstopwatch destroy();
		level.bombstopwatch = newHudElem();
		level.bombstopwatch.x = 36;
		level.bombstopwatch.y = 240;
		level.bombstopwatch.alignX = "center";
		level.bombstopwatch.alignY = "middle";
		level.bombstopwatch setClock(5, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
		level.timersused++;
		wait 5;
		self.bomb stoploopsound ("bomb_tick");
		level.timersused--;
		if (level.timersused < 1)
		{
			if (isdefined (level.bombstopwatch))
				level.bombstopwatch destroy();
		}
	}

	//BEGIN EXPLOSION
	if (isdefined (self.exp_sound))
	{
		//println ("z:          playing sound: ", self.exp_sound);
		self.bomb playsound (self.exp_sound);
	}
	else
	{
		self.bomb playsound ("explo_metal_rand");
	}

	//origin, range, max damage, min damage
	radiusDamage (self.bomb.origin, 350, 600, 50);

	earthquake(0.25, 3, self.bomb.origin, 1050);

	if ( isdefined (self.d_fx) )
		playfx (self.d_fx, self.bomb.origin );
	if(isdefined(self.object))
	{
		for(i = 0; i < self.object.size; i++)
		{
			if ( isdefined (self.object[i].d_fx) )
				playfx (self.object[i].d_fx, self.object[i].origin);
		}
	}

	//NOTIFY THE SCRIPT
	level notify (array_targetname + " exploded");
	if (isdefined (self.target))
	{
		level notify (self.target + " exploded");
		level notify (self.target);
	}

	//WAIT .3 BEFORE MODEL SWAP

	wait (.5);

	if(isdefined(self.object))
	{
		for(i = 0; i < self.object.size; i++)
		{
			if (self.object[i].d_model == "delete")
				self.object[i] hide();
			else
				self.object[i] setModel(self.object[i].d_model);
		}
	}
	self.bomb hide();
}