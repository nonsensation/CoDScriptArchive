spawner_setup(vehicle)
{
	if(!isdefined(level.vehiclecount))
		level.vehiclecount = 0;
	if(!isdefined(level.vehicle))
		level.vehicle = [];

	if(isdefined (vehicle.targetname))
	{
		level.vehicle[level.vehiclecount] = spawnstruct();
		level.vehicle[level.vehiclecount] setspawnervariables(vehicle);
		level.vehiclecount++;

	}
	else
	{
		spam();
		println("vehicle needs targetname at", vehicle.origin);
		spam();
	}

}


setspawnervariables(vehicle)
{
	self.classname = vehicle.classname;
	if(vehicle.model == "xmodel/vehicle_german_bmw_bike")  // temp hack to see vehicles in level without recompiling
		self.model = "xmodel/v_ge_lnd_bmw";
	else
		self.model = vehicle.model;
	self.angles = vehicle.angles;
	self.origin = vehicle.origin;
	if(isdefined(vehicle.drivertriggered))
		self.drivertriggered = vehicle.drivertriggered;
	if(isdefined(vehicle.script_delay))
		self.script_delay = vehicle.script_delay;
	if(isdefined(vehicle.script_noteworthy))
		self.script_noteworthy = vehicle.script_noteworthy;
	if(isdefined(vehicle.script_team))
		self.script_team = vehicle.script_team;
	if(isdefined(vehicle.script_accuracy))
		self.script_accuracy = vehicle.script_accuracy;
	if(isdefined(vehicle.script_vehiclegroup))
		self.script_vehiclegroup = vehicle.script_vehiclegroup;
	if(isdefined(vehicle.target))
		self.target = vehicle.target;
	if(isdefined(vehicle.targetname))
		self.targetname = vehicle.targetname;
	if(isdefined(vehicle.triggeredthink))
		self.triggeredthink = vehicle.triggeredthink;
	if(isdefined(vehicle.script_sound))
		self.script_sound = vehicle.script_sound;
	if(isdefined(vehicle.script_tankmgaccuracy))
		self.script_sound = vehicle.script_tankmgaccuracy;
	if(isdefined(vehicle.script_squadname))
		self.script_squadname = vehicle.script_squadname;
	if(isdefined(vehicle.delay))
		self.delay = vehicle.delay;
	if(isdefined(vehicle.vehicletype))
	{
		self.vehicletype = vehicle.vehicletype;
	}
	else
		println("vehicle doesn't have vehicle type at ",vehicle.origin);
	vehicle delete();
}

vehicle_spawn(vspawner)
{
//	vehiclenum = getvehiclespawnernum(self.target);
	vehiclenum = getvehiclespawnernum(vspawner);
	vspawner = level.vehicle[vehiclenum];
	vehicle = spawnVehicle( vspawner.model, vspawner.targetname, vspawner.vehicletype ,vspawner.origin, vspawner.angles );
	if(isdefined(vspawner.drivertriggered))
		vehicle.drivertriggered = vspawner.drivertriggered;
	if(isdefined(vspawner.script_delay))
		vehicle.script_delay = vspawner.script_delay;
	if(isdefined(vspawner.script_noteworthy))
		vehicle.script_noteworthy = vspawner.script_noteworthy;
	if(isdefined(vspawner.script_team))
		vehicle.script_team = vspawner.script_team;
	if(isdefined(vspawner.script_accuracy))
		vehicle.script_accuracy = vspawner.script_accuracy;
	if(isdefined(vspawner.script_vehiclegroup))
		vehicle.script_vehiclegroup = vspawner.script_vehiclegroup;
	if(isdefined(vspawner.target))
		vehicle.target = vspawner.target;
	if(isdefined(vspawner.vehicletype))
		vehicle.vehicletype = vspawner.vehicletype;
	if(isdefined(vspawner.triggeredthink))
		vehicle.triggeredthink = vspawner.triggeredthink;
	if(isdefined(vspawner.script_sound))
		vehicle.script_sound = vspawner.script_sound;
	if(isdefined(vspawner.script_tankmgaccuracy))
		vehicle.script_sound = vspawner.script_tankmgaccuracy;
	if(isdefined(vspawner.script_squadname))
		vehicle.script_squadname = vspawner.script_squadname;
	if(isdefined(vspawner.delay))
		vehicle.delay = vspawner.delay;
	if(vspawner.vehicletype == "GermanFordTruck")
	{
		vehicle maps\_truck_gmi::init();
		vehicle thread maps\_truck_gmi::handle_attached_guys();
	}
	if(vspawner.vehicletype == "Kubelwagon")
	{
		vehicle maps\_kubelwagon_gmi::init();
		vehicle thread maps\_kubelwagon_gmi::handle_attached_guys();
	}
	if(vspawner.vehicletype == "GermanBMW")
	{
		vehicle maps\_bmwbike_gmi::init();
		vehicle thread maps\_bmwbike_gmi::handle_attached_guys();
	}
	if(vspawner.vehicletype == "PanzerIV")
	{
		vehicle maps\_panzerIV_gmi::init();
	}
	if(vspawner.vehicletype == "tiger")
	{
		if ( (isdefined (vspawner.script_noteworthy)) && (vspawner.script_noteworthy == "panzeriv") )
			vehicle maps\_panzeriv_gmi::init();
		else
			vehicle maps\_tiger_gmi::init();
	}
	if(vspawner.vehicletype == "Stuka")
	{
		vehicle maps\_stuka_gmi::init();
	}
	if(vspawner.vehicletype == "t34")
	{
		vehicle maps\_t34_gmi::init();
	}
	if(vspawner.vehicletype == "bf109")
	{
		vehicle maps\_bf109_gmi::init();
	}
	if(vspawner.vehicletype == "boat")
	{
		vehicle maps\_boat_gmi::init();
	}
	if(vspawner.vehicletype == "ptboat")
	{
		if(vehicle.model == "xmodel/v_ge_sea_player_ptboat" || vehicle.model == "xmodel/v_ge_sea_view_ptboat")
			return vehicle;  // this is the players boat! don't want it shooting at the player
		vehicle maps\_ptboat_gmi::init();
	}
	return vehicle;
}

getvehiclespawnernum(target)
{
	for(i=0;i<level.vehicle.size;i++)
	{
		if(level.vehicle[i].targetname == target)
			return i;
	}
	println("no vehiclespawner found with targetname ", target);
}

spam()
{
	println("*****_vehiclespawn******");
}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}


