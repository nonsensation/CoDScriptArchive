#using_animtree("flak88");
main()
{
	initArtilleryCvars();
	restrictPlacedArtillery();

	precacheShader( "gfx/hud/tank_reticle25.dds");
	precacheShader( "gfx/hud/tank_reticle50.dds");
	precacheShader( "gfx/hud/tank_reticle75.dds");
	precacheShader( "gfx/hud/tank_reticle100.dds");
	
	script_vehicles = getentarray ("script_vehicle","classname");
	for (i=0;i<script_vehicles.size;i++)
	{
		if(script_vehicles[i].vehicletype == "Flak88_MP" || script_vehicles[i].vehicletype == "flak88_mp")
		{
			precacheshader("gfx/hud/hud@fire_ready_shell.tga");
			precachevehicle("Flak88_MP");
			if ((script_vehicles[i].model == "xmodel/turret_flak88"))
			{
				precachemodel ("xmodel/turret_flak88_d");
				script_vehicles[i].dead_model = ("xmodel/turret_flak88_d");
			}
			else if ((script_vehicles[i].model == "xmodel/mp_artillery_flak88") || (script_vehicles[i].model == "xmodel/mp_artillery_flak88_snow"))
			{
				precachemodel ("xmodel/mp_artillery_flak88_d");
				script_vehicles[i].dead_model = ("xmodel/mp_artillery_flak88_d");
			}
			else
			{
				precachemodel ("xmodel/mp_artillery_flak88_d");
				script_vehicles[i].dead_model = ("xmodel/mp_artillery_flak88_d");
			}
			script_vehicles[i] thread flak_init();
		}
	}
}

initArtilleryCvars()
{
	level.allow_flak88 = getCvar("scr_allow_flak88");
	if(level.allow_flak88 == "")
		level.allow_flak88 = "1";
	setCvar("scr_allow_flak88", level.allow_flak88);
	setCvar("ui_allow_flak88", level.allow_flak88);
	makeCvarServerInfo("ui_allow_flak88", "1");
}

restrictPlacedArtillery()
{
	if(level.allow_flak88 != "1")
	{
		deletePlacedEntity("Flak88_MP");
		deletePlacedEntity("flak88_mp");
	}
}

deletePlacedEntity(vehicletype)
{
	tanks = getentarray("script_vehicle","classname");

	for(i=0;i<tanks.size;i++)
	{
		if (tanks[i].vehicletype == vehicletype)
		{
			// precache effects and setup for death model change
//			println("DELETED: ", tanks[i].vehicletype);
			tanks[i] delete();
		}
	}
}

flak_init()
{
	self endon ("death");

	if(isdefined(self.script_health))
	{
		self.health = self.script_health;
	}
	else
	{
		self.regen_health = 20000;
		self.health = self.regen_health;
		// and regen
		self thread flak_regen();
	}

	self thread flak_think();
}

flak_think()
{
	self endon("death");

	self thread wait_for_activate();
}

wait_for_activate()
{
	self endon("death");

	while (1)
	{
		wait (0.1);
		self waittill("activated",vehpos,gunner);
	
		self thread flak_activated_delay(gunner);
	}
}

flak_activated_delay(gunner)
{
	wait 0.1;	// wait for a dismount to be processed if on same frame


	fireicon[0] = newClientHudElem(gunner );
	fireicon[0].alignX = "center";
	fireicon[0].alignY = "middle";
	fireicon[0].x = 320;
	fireicon[0].y = 240;
	fireicon[0] setShader("gfx/hud/tank_reticle25.dds", 64, 64);

	fireicon[1] = newClientHudElem(gunner );
	fireicon[1].alignX = "center";
	fireicon[1].alignY = "middle";
	fireicon[1].x = 320;
	fireicon[1].y = 240;
	fireicon[1] setShader("gfx/hud/tank_reticle50.dds", 64, 64);

	fireicon[2] = newClientHudElem(gunner );
	fireicon[2].alignX = "center";
	fireicon[2].alignY = "middle";
	fireicon[2].x = 320;
	fireicon[2].y = 240;
	fireicon[2] setShader("gfx/hud/tank_reticle75.dds", 64, 64);

	fireicon[3] = newClientHudElem(gunner );
	fireicon[3].alignX = "center";
	fireicon[3].alignY = "middle";
	fireicon[3].x = 320;
	fireicon[3].y = 240;
	fireicon[3] setShader("gfx/hud/tank_reticle100.dds", 64, 64);

	for (q=0;q<4;q++)
	{
		fireicon[q].threaded = 0;
		fireicon[q].alpha = 0;
	}

	level thread flak_hud_destroy_think( self, gunner, fireicon );

	// wait for the tank to be deactivated
	level thread flak_hud_deactivated_think( self, gunner, fireicon );

	// Incase we want to use this else where.
	self.gunner = gunner; 

	self thread flak_fire_think(fireicon);
	self thread flak_dismount();
}

flak_hud_destroy_think(flak, driver, fireicon)
{
	driver waittill("stop_flak_hud");

	if (!isValidPlayer( driver ))
	{
		// already disconnected, hudelem's must have been destroyed
		return;
	}

	if (isdefined(fireicon))
	{
		if (isdefined( fireicon[0] )) fireicon[0] destroy();
		if (isdefined( fireicon[1] )) fireicon[1] destroy();
		if (isdefined( fireicon[2] )) fireicon[2] destroy();
		if (isdefined( fireicon[3] )) fireicon[3] destroy();
	}
}

flak_hud_deactivated_think( flak, activator, fireicon )
{
	flak waittill("deactivated", deactivator);
		
	if (!isValidPlayer( activator ))
	{
		// already disconnected, hudelem's must have been destroyed
		return;
	}

	if (isdefined(fireicon))
	{
		if (isdefined( fireicon[0] )) fireicon[0] destroy();
		if (isdefined( fireicon[1] )) fireicon[1] destroy();
		if (isdefined( fireicon[2] )) fireicon[2] destroy();
		if (isdefined( fireicon[3] )) fireicon[3] destroy();
	}
}

flak_dismount()
{
	self endon("death");
	self waittill("deactivated", activator);
	
	if ( isalive(activator) )
		activator notify("stop_flak_hud");
}

flak_regen()
{
	self endon("death");
	
	while (1)
	{
		self waittill("damage");
		self.health = self.regen_health;		
	}
}

fadeoff()
{
	while(self.alpha > 0.0)
	{
		self.alpha = self.alpha - 0.1;
		wait(0.05);
	}
	self.threaded = 0;
}

flak_fire_think(fireicon)
{
	self endon("death");
	self endon("deactivated");

	if (!isdefined(fireicon)) return;	//	oh shit


	while (self.health>0)
	{
		self waittill ("turret_fire");

		if(level.ceasefire == 2)
			continue;

		for (q=0;q<4;q++)
		{
			if ( isdefined( fireicon[q] ) )
				fireicon[q].alpha = 1.0;
		}
		self FireTurret();

		wait .5;
		self playsound ("flak_reload");
	
		while (self isTurretReady() != true)
		{
			val = self get_fire_time() / 1000;
			if (val<=3)
			{
				if (isdefined( fireicon[val] ) && fireicon[val].threaded == 0)
				{
					fireicon[val].threaded = 1;
					fireicon[val] thread fadeoff();
				}
			}
			wait .25;
		}
	}
/*
	while(self.health > 0)
	{
		fire_icon.alpha = 1;
		self waittill ("turret_fire");
		fire_icon.alpha = 0;
		self FireTurret();
		wait .5;
		self playsound ("flak_reload");
		while (self isTurretReady() != true)
			wait .2;
	}
*/
}
