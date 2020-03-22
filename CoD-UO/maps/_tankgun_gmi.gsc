mginit(optionalTurret)
{
	if (isdefined (optionalTurret))
	{
		println("spawning a special turret " + optionalTurret);
		if(optionalturret == "no_turret")
		{
			return;
		}
		else
		{
			self.mgturret = spawnTurret("misc_turret", (0,0,0), optionalTurret);
		}
	}
	else
	{
		self.mgturret = spawnTurret("misc_turret", (0,0,0), "mg42_panzerIV_tank");
	}
	if(isdefined(self.script_tankmgaccuracy))
	{
		self.mgturret setturretaccuracy(self.script_tankmgaccuracy);
	}
	self.mgturret setmodel("xmodel/vehicle_tank_panzeriv_machinegun");

	self.mgturret linkto(self, "tag_turret2", (0, 0, 0), (0, 0, 0));

	self.mgturret.angles = self.angles;
	self.mgturret thread maps\_mg42_gmi::burst_fire_unmanned();
	self.mgturret maketurretunusable();
	mgon();
//	self thread debug();
}

mgoff()
{
	self.mgturret setmode("manual");

}

mgon()
{

	self.mgturret setmode("auto_nonai");
	if(!isdefined(self.script_team)) // player tank
		self.mgturret setTurretTeam("allies");
	else
		self.mgturret setTurretTeam(self.script_team);
}

debug()
{
	while(1)
	{
		line(level.player.origin, self.mgturret.origin);
		wait 0.075;
	}
}

