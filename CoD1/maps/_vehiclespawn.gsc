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
	if(vspawner.vehicletype == "GermanFordTruck")
	{
		vehicle maps\_truck::init();
		vehicle thread maps\_truck::handle_attached_guys();
	}
	if(vspawner.vehicletype == "Kubelwagon")
	{
		vehicle maps\_kubelwagon::init();
		vehicle thread maps\_kubelwagon::handle_attached_guys();
	}
	if(vspawner.vehicletype == "GermanBMW")
	{
		vehicle maps\_bmwbike::init();
		vehicle thread maps\_bmwbike::handle_attached_guys();
	}
	if(vspawner.vehicletype == "PanzerIV")
	{
		vehicle maps\_PanzerIV::init();
	}
	if(vspawner.vehicletype == "tiger")
	{
		vehicle maps\_tiger::init();
	}
	if(vspawner.vehicletype == "Stuka")
	{
		vehicle maps\_stuka::init();
	}
	if(vspawner.vehicletype == "t34")
	{
		vehicle maps\_t34::init();
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
	maps\_spawner::waitframe();
}


