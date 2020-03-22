InitClock(clock, time)
{
	clock.x = 590; // 320;
	clock.y = 380; // 380;
	clock.alignX = "center";
	clock.alignY = "middle";
	clock.sort = 1;
	clock setClock(time, 60, "hudStopwatch", 64, 64); // count down for 5 of 60 seconds, size is 64x64
}

vectorMultiply (vec, dif)
{
	vec = (vec[0] * dif, vec[1] * dif, vec[2] * dif);
	return vec;
}

// ----------------------------------------------------------------------------------
//	adds a ent to the array
// ----------------------------------------------------------------------------------
add_to_array(array, ent)
{
	if(!isdefined(ent))
		return array;
		
	if(!isdefined(array))
		array[0] = ent;
	else
		array[array.size] = ent;
	
	return array;	
}

// ----------------------------------------------------------------------------------
//	make_permanent_announcement
// ----------------------------------------------------------------------------------
make_permanent_announcement(message, cleanup_notify, y_position, color)
{
	if ( !isdefined(y_position) )
	{
		y_position = 130;
	}
	
	text = newHudElem();
	text setText(message);
	text.alignX = "center";
	text.alignY = "middle";
	text.x = 320;
	text.y = y_position;
	text.sort = 0.0;
//	text.font = "bigfixed";
	text.fontscale = 2.0;
			
	if ( isdefined(color) )
	{
		text.color = color;
	}
	
	level waittill(cleanup_notify);
	
	text destroy();
}

// ----------------------------------------------------------------------------------
//	get_progressbar()
//
//	Returns a hud elem for a progress bar
// ----------------------------------------------------------------------------------
get_progressbar(entity)
{
	foreground= newClientHudElem( entity );
	foreground setShader("white", get_progressbar_maxwidth(), get_progressbar_height());
	foreground.alignX = "left";
	foreground.alignY = "top";
	foreground.x = get_progressbar_x() - get_progressbar_maxwidth()/2;
	foreground.y = get_progressbar_y() + 20;
	foreground.color = (1, 1, 1);
	foreground.sort = 0.1;
	
	return foreground;
}

// ----------------------------------------------------------------------------------
//	get_progressbar_background()
//
//	Returns a hud elem for a progress bar
// ----------------------------------------------------------------------------------
get_progressbar_background(entity)
{
	background = newClientHudElem( entity );
	background setShader("black", get_progressbar_maxwidth() + 2, get_progressbar_height() + 2);
	background.alignX = "left";
	background.alignY = "top";
	background.x = get_progressbar_x()- get_progressbar_maxwidth()/2 - 1;
	background.y = get_progressbar_y() + 19;
	background.alpha = 0.5;
	background.color = (1, 1, 1);
	background.sort = 0.0;
	return background;
}

// ----------------------------------------------------------------------------------
//	get_progressbar_text()
//
//	Returns a hud elem for a progress bar
// ----------------------------------------------------------------------------------
get_progressbar_text(entity, message)
{
	text = newClientHudElem( entity );
	text setText(message);
	text.alignX = "center";
	text.alignY = "top";
	text.x = get_progressbar_x();
	text.y = get_progressbar_y();
	
	return text;
}

// ----------------------------------------------------------------------------------
//	set_progressbar_width
//
//	sets the shader to the correct width
// ----------------------------------------------------------------------------------
set_progressbar_width(bar, width)
{
	bar setShader("white", width, get_progressbar_height());	
}

// ----------------------------------------------------------------------------------
//	get_progressbar_maxwidth
// ----------------------------------------------------------------------------------
get_progressbar_maxwidth()
{
	return 140;	
}

// ----------------------------------------------------------------------------------
//	get_progressbar_height
// ----------------------------------------------------------------------------------
get_progressbar_height()
{
	return 12;	
}

// ----------------------------------------------------------------------------------
//	get_progressbar_x
// ----------------------------------------------------------------------------------
get_progressbar_x()
{
	return 320;	
}

// ----------------------------------------------------------------------------------
//	get_progressbar_y
// ----------------------------------------------------------------------------------
get_progressbar_y()
{
	return 370;	
}

base_swapper()
{
        gametype = getcvar("g_gametype");
        if(gametype != "bas" && gametype != "bop")
        {
		if (!isdefined(game["bas_axis_destroyed"]))
			game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";
		if (!isdefined(game["bas_allies_destroyed"]))
			game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";


		precacheModel(game["bas_axis_destroyed"]);
		precacheModel(game["bas_allies_destroyed"]);

                level.base = getentarray("gmi_base","targetname");
                if (isdefined(level.base))
                {
                        for (b=0;b<level.base.size;b++)
                        {       
                                level.base[b] thread swap_in_base_dmg();
                        }       
                }
        }
}

swap_in_base_dmg()
{
	self.destroyedmodel = spawn("script_model", self.origin);
	self.destroyedmodel.angles = self.angles;
	if (isdefined(self.script_team))
	{
		println(self.script_team);
		if (self.script_team == "axis")
			self.destroyedmodel setmodel(game["bas_axis_destroyed"]);
		else
			self.destroyedmodel setmodel(game["bas_allies_destroyed"]);
	}
}

num_players_on_team(player)
{
	players = getentarray("player", "classname");
	
	// count up the people in the flag area
	count = 0;
	for(i = 0; i < players.size; i++)
	{
		if(player.pers["team"] == players[i].pers["team"])
			count++;
	}
	
	return count;
}

remove_vehicle_proc(vehicles)
{
	// for each vehicle, count the number within "close" range
	range_dist = 2000;
	for (i=0; i<vehicles.size; i++)
	{
		if (isdefined( vehicles[i].veh_removed ) && vehicles[i].veh_removed)
			continue;
		vehicles[i].vehicles_in_range = 0;
		vehicles[i].vehicles_in_range_closest = 99999;
		for (j=0; j<vehicles.size; j++)
		{
			if (isdefined( vehicles[j].veh_removed ) && vehicles[j].veh_removed)
				continue;
			if (i==j)
				continue;
			distance = distance( vehicles[i].origin, vehicles[j].origin );
			if (distance < range_dist)
			{
				vehicles[i].vehicles_in_range++;
				if (distance < vehicles[i].vehicles_in_range_closest)
					vehicles[i].vehicles_in_range_closest = distance;
			}
		}
	}
	
	// now find the vehicle with the highest range count, and the smallest "closest" distance
	for (i=1; i<vehicles.size; i++)
	{
		if (isdefined( vehicles[i].veh_removed ) && vehicles[i].veh_removed)
			continue;
		if (!isdefined( closest ))
			closest = vehicles[i];
		if (vehicles[i].vehicles_in_range > closest.vehicles_in_range)
		{
			closest = vehicles[i];
			continue;
		}
		if (vehicles[i].vehicles_in_range == closest.vehicles_in_range && vehicles[i].vehicles_in_range_closest < closest.vehicles_in_range_closest)
		{
			closest = vehicles[i];
			continue;
		}
	}

	if (!isdefined( closest ))
		return 0;

	closest.veh_removed = 1;
	closest delete();	
	
	return 1;
}

veh_count_valid( vehicles )
{
	c = 0;
	for (i=0; i<vehicles.size; i++)
	{
		if (isdefined( vehicles[i].veh_removed ) && vehicles[i].veh_removed)
			continue;
		c++;
	}
	
	return c;
}

restrict_vehicle_count(vehtype, limit)
{
	vehicles = getentarray(vehtype,"vehicletype");
	if (!isdefined( vehicles ))
		return;
		
	while (veh_count_valid( vehicles ) > limit)
	{
		// remove one
		if (!remove_vehicle_proc( vehicles ))
			break;	// nothing more to remove
	
		vehicles = getentarray(vehtype,"vehicletype");
		if (!isdefined( vehicles ))
			return;
	}
}

getPlantGMI()
{
	start = self.origin + (0, 0, 10);

	range = 11;
	forward = anglesToForward(self.angles);
	forward = maps\mp\_utility::vectorScale(forward, range);

	traceorigins[0] = start + forward;
	traceorigins[1] = start;

	trace = bulletTrace(traceorigins[0], (traceorigins[0] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1 && (!isdefined(trace["entity"]) || trace["entity"].classname != "script_vehicle"))
	{
		//println("^6Using traceorigins[0], tracefraction is", trace["fraction"]);
		
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
		return temp;
	}

	trace = bulletTrace(traceorigins[1], (traceorigins[1] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1 && (!isdefined(trace["entity"]) || trace["entity"].classname != "script_vehicle"))
	{
		//println("^6Using traceorigins[1], tracefraction is", trace["fraction"]);

		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
		return temp;
	}

	traceorigins[2] = start + (16, 16, 0);
	traceorigins[3] = start + (16, -16, 0);
	traceorigins[4] = start + (-16, -16, 0);
	traceorigins[5] = start + (-16, 16, 0);

	for(i = 0; i < traceorigins.size; i++)
	{
		trace = bulletTrace(traceorigins[i], (traceorigins[i] + (0, 0, -1000)), false, undefined);

		if(isdefined(trace["entity"]) && trace["entity"].classname == "script_vehicle")
		{
			continue;
		}

		//ent[i] = spawn("script_model",(traceorigins[i]+(0, 0, -2)));
		//ent[i].angles = (0, 180, 180);
		//ent[i] setmodel("xmodel/105");

		//println("^6trace ", i ," fraction is ", trace["fraction"]);

		if(!isdefined(besttracefraction) || (trace["fraction"] < besttracefraction))
		{
			besttracefraction = trace["fraction"];
			besttraceposition = trace["position"];

			//println("^6besttracefraction set to ", besttracefraction, " which is traceorigin[", i, "]");
		}
	}

	if(!isdefined(besttracefraction))
		return undefined;
	
	if(besttracefraction == 1)
		besttraceposition = self.origin;
	
	temp = spawnstruct();
	temp.origin = besttraceposition;
	temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
	return temp;
}

canPlantGMI()
{
	start = self.origin + (0, 0, 10);

	range = 11;
	forward = anglesToForward(self.angles);
	forward = maps\mp\_utility::vectorScale(forward, range);

	traceorigins[0] = start + forward;
	traceorigins[1] = start;

	trace = bulletTrace(traceorigins[0], (traceorigins[0] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1 && (!isdefined(trace["entity"]) || trace["entity"].classname != "script_vehicle"))
	{
		return 1;
	}

	trace = bulletTrace(traceorigins[1], (traceorigins[1] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1 && (!isdefined(trace["entity"]) || trace["entity"].classname != "script_vehicle"))
	{
		return 1;
	}

	traceorigins[2] = start + (16, 16, 0);
	traceorigins[3] = start + (16, -16, 0);
	traceorigins[4] = start + (-16, -16, 0);
	traceorigins[5] = start + (-16, 16, 0);

	for(i = 0; i < traceorigins.size; i++)
	{
		trace = bulletTrace(traceorigins[i], (traceorigins[i] + (0, 0, -1000)), false, undefined);

		if(isdefined(trace["entity"]) && trace["entity"].classname == "script_vehicle")
		{
			continue;
		}

		//ent[i] = spawn("script_model",(traceorigins[i]+(0, 0, -2)));
		//ent[i].angles = (0, 180, 180);
		//ent[i] setmodel("xmodel/105");

		//println("^6trace ", i ," fraction is ", trace["fraction"]);

		if(!isdefined(besttracefraction) || (trace["fraction"] < besttracefraction))
		{
			besttracefraction = trace["fraction"];
			besttraceposition = trace["position"];

			//println("^6besttracefraction set to ", besttracefraction, " which is traceorigin[", i, "]");
		}
	}

	if(!isdefined(besttracefraction))
		return 0;

	return 1;	
}
