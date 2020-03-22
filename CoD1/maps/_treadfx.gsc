main(timeOfDay)
{
	if ((!isdefined (timeofDay)) || (timeOfDay == "day"))
	{
		level._effect["treads_sand"] = loadfx ("fx/tagged/dust4truckdrive.efx");
		level._effect["treads_grass"] = loadfx ("fx/tagged/dust4truckdrive.efx");
		level._effect["treads_dirt"] = loadfx ("fx/tagged/dust4truckdrive.efx");
//		level._effect["treads_rock"] = loadfx ("fx/tagged/dust4truckdrive.efx");
		level._effect["treads_snow"] = loadfx ("fx/tagged/snow4tanktread.efx");
		level._effect["treads_ice"] = loadfx ("fx/water/tanksplash.efx");
	}
	else
	{
		level._effect["treads_sand"] = loadfx ("fx/tagged/tread_dust_dark.efx");
		level._effect["treads_grass"] = loadfx ("fx/tagged/tread_dust_dark.efx");
		level._effect["treads_dirt"] = loadfx ("fx/tagged/tread_dust_dark.efx");
		level._effect["treads_rock"] = loadfx ("fx/tagged/tread_dust_dark.efx");
		level._effect["treads_snow"] = loadfx ("fx/tagged/snow4tanktread.efx");
		level._effect["treads_ice"] = loadfx ("fx/water/tanksplash.efx");
	}
}

