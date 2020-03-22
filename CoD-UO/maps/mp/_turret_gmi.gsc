#using_animtree("turret88");
main()
{
	precacheShader("gfx/hud/hud@health_bar.dds");
	precacheShader("gfx/hud/hud@vehiclehealth.dds");

	initTurretCvars();
	restrictPlacedTurret();
	
	script_mg42s = getentarray ("misc_mg42","classname");
	for (i=0;i<script_mg42s.size;i++)
	{
		script_mg42s[i] thread turret_think();
	}
	
	script_turrets = getentarray ("misc_turret","classname");
	for (i=0;i<script_turrets.size;i++)
	{
		script_turrets[i] thread turret_think();
	}
}

initTurretCvars()
{
}

restrictPlacedTurret()
{
}

deletePlacedEntity(turrettype)
{
}

turret_think()
{
	self endon("death");

	self waittill("activated",gunner);

	self thread turret_activated_delay(gunner);
}

turret_activated_delay(gunner)
{
	wait 0.1;	// wait for a dismount to be processed if on same frame

	overheat_back = newClientHudElem( gunner );
	overheat_back setShader("gfx/hud/hud@vehiclehealth.dds", 128, 7, 1.0, 0.20);
	overheat_back.alignX = "left";
	overheat_back.alignY = "top";
	overheat_back.x = 488+13;
	overheat_back.y = 449;

	overheat = newClientHudElem( gunner );
	overheat setShader("gfx/hud/hud@health_bar.dds", 128, 4);
	overheat.alignX = "left";
	overheat.alignY = "top";
	overheat.x = 488+14;
	overheat.y = 450;

	level thread turret_hud_destroy_think( self, gunner, overheat, overheat_back);

	// Incase we want to use this else where.
	self.gunner = gunner; 

	self thread turret_hud_overheat_run( gunner, overheat );
	self thread turret_dismount();
}

turret_hud_destroy_think(turret, gunner, overheat, overheat_back)
{
	gunner waittill("stop_turret_hud");

	if (!isValidPlayer( gunner ))
	{
		// already disconnected, hudelem's must have been destroyed
		return;
	}

	overheat destroy();
	overheat_back destroy();
}

turret_hud_overheat_run(activator, overheat)
{
	self endon("death");
	activator endon("death");
	activator endon("stop_tank_hud");
	
	minheight = 0;

	max_width = 126;
	
	while(1)
	{
		wait (0.1);
		if ( !isAlive(self) || !isDefined(overheat) )
			continue;
		
		heat = self getturretheat();
		overheating = self getturretoverheating();
		
		if ( overheating )
		{
			overheat.color = ( 1.0, 0.0, 0.0);
		}
		else
		{
			overheat.color = ( 1.0, 1.0-heat,1.0-heat);
		}
		
		hud_width = (1.0 - heat) * max_width;
		
		if ( hud_width < 1 )
			hud_width = 1;
			
		overheat setShader("gfx/hud/hud@health_bar.dds", hud_width, 5);
	}
}

turret_dismount()
{
	self waittill("deactivated");
	
	self.gunner notify("stop_turret_hud");
	
	// now restart the thinking for the next user
	self thread turret_think();
}
