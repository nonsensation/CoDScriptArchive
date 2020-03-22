main()
{
	// set the nighttime flag to be off
	// otherwise it will be carried from level to level
	// any level that wants to be night needs to set this cvar after calling _load::main
	setcvar("sv_night", "0" );

	game["compass_range"] = 1024;

	thread maps\mp\_minefields::minefields();
	thread maps\mp\_deepwater_gmi::deepwater();
	thread maps\mp\_turret_gmi::main();

	// Hide exploder models.
	bmodels = getentarray("script_brushmodel", "classname");
	smodels = getentarray("script_model", "classname");
	ents = bmodels;
	for(i = 0; i < smodels.size; i++)
		ents[ents.size] = smodels[i];

	for(i = 0; i < ents.size; i++)
	{
		if(isdefined(ents[i].script_exploder))
		{
			if((ents[i].model == "xmodel/fx") && ((!isdefined(ents[i].targetname)) || (ents[i].targetname != "exploderchunk")))
			{
				ents[i] hide();
			}
			else if((isdefined(ents[i].targetname)) && (ents[i].targetname == "exploder"))
			{
				ents[i] hide();
				
				if(ents[i].classname != "script_model")
					ents[i] notsolid();
			}
			else if((isdefined(ents[i].targetname)) && (ents[i].targetname == "exploderchunk"))
			{
				ents[i] hide();
				
				if(ents[i].classname != "script_model")
					ents[i] notsolid();
			}
		}
	}
	
	ents = undefined;

// Do various things on triggers
	for(p = 0; p < 5; p++)
	{
		switch (p)
		{
			case 0:	triggertype = "trigger_multiple"; break;
			case 1:	triggertype = "trigger_once"; break;
			case 2:	triggertype = "trigger_use"; break;
			case 3:	triggertype = "trigger_damage"; break;
			case 4:	triggertype = "trigger_hurt"; break;
		}		
			
		triggers = getentarray(triggertype, "classname");
		for(i = 0; i < triggers.size; i++)
		{
			if(isdefined(triggers[i].script_exploder))
				level thread exploder(triggers[i]);
		}
	}

	brushes = getentarray("script_brushmodel", "classname");
	for(i = 0; i < brushes.size; i++)
		level._script_expoders = maps\mp\_utility::add_to_array(level._script_expoders, brushes[i]);

	models = getentarray("script_model", "classname");
	for(i = 0; i < models.size; i++)
		level._script_expoders = maps\mp\_utility::add_to_array(level._script_expoders, models[i]);

	brushes = undefined;
	models = undefined;
}

exploder(trigger)
{
	trigger waittill("trigger");
//	println("TRIGGERED");
	maps\mp\_utility::exploder(trigger.script_exploder);
	trigger delete();
}