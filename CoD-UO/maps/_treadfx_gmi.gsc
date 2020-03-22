main(timeOfDay)
{
	if (isdefined (level.timeofDay))
		timeOfDay = level.timeofDay;
	if ((!isdefined (timeofDay)) || (timeOfDay == "day"))
	{
		level._effect["treads_sand"] = loadfx ("fx/vehicle/wheelspray_gen_sand.efx");
		level._effect["treads_grass"] = loadfx ("fx/vehicle/wheelspray_gen_grass.efx");
		level._effect["treads_dirt"] = loadfx ("fx/vehicle/wheelspray_gen_dirt.efx");
//		level._effect["treads_rock"] = loadfx ("fx/vehicle/wheelspray_gen_rock.efx");
		level._effect["treads_snow"] = loadfx ("fx/vehicle/wheelspray_gen_snow.efx");
		level._effect["treads_ice"] = loadfx ("fx/vehicle/wheelspray_gen_snow.efx");
	}
	else
	{
		level._effect["treads_sand"] = loadfx ("fx/vehicle/wheelspray_gen_sand_d.efx");
		level._effect["treads_grass"] = loadfx ("fx/vehicle/wheelspray_gen_grass_d.efx");
		level._effect["treads_dirt"] = loadfx ("fx/vehicle/wheelspray_gen_dirt_d.efx");
		level._effect["treads_rock"] = loadfx ("fx/vehicle/wheelspray_gen_rock_d.efx");
		level._effect["treads_snow"] = loadfx ("fx/vehicle/wheelspray_gen_snow_d.efx");
		level._effect["treads_ice"] = loadfx ("fx/vehicle/wheelspray_gen_snow_d.efx");
	}
}

