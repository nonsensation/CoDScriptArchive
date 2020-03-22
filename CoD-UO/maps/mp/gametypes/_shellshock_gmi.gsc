// ----------------------------------------------------------------------------------
//	precache
// ----------------------------------------------------------------------------------
precache()
{
	precacheShellshock("default_mp");
	precacheShellshock("melee");
}

// ----------------------------------------------------------------------------------
//	DoShellShock
//
// 	Shell shock effect for nades and rockets in GMI multiplayer
// ----------------------------------------------------------------------------------
DoShellShock(weapon, sMeansOfDeath, sHitLoc, iDamage)
{
	// should this scr_shellshock be converted to a level variable like friendly fire was?
	if(getCvar("scr_shellshock") == 1)
	{		
		// if this is and explosion but not from a weapon (artillery or whatever) then do the shellshock
		if (   sMeansOfDeath == "MOD_GRENADE_SPLASH" 
		    || sMeansOfDeath == "MOD_EXPLOSIVE" 
		    || sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" 
		    || sMeansOfDeath == "MOD_ARTILLERY" || sMeansOfDeath == "MOD_ARTILLERY_SPLASH" )
		{
			self thread gmiPlayerShellShocked(iDamage);
		}
		else if ( sMeansOfDeath != "MOD_MELEE"  )
		{
			switch(weapon)
			{
				case "mk1britishfrag_mp":
				case "rgd-33russianfrag_mp":
				case "fraggrenade_mp":
				case "stielhandgranate_mp":
				case "panzerfaust_mp":
				case "bazooka_mp":
				case "panzerschreck_mp":
				{
					self thread gmiPlayerShellShocked(iDamage);
					break;
				}	
			}
		}
		else if ( sMeansOfDeath == "MOD_MELEE" && sHitLoc == "head" )
		{
			self thread gmiPlayerShellShocked(iDamage, "melee");
		}
	}
}

// ----------------------------------------------------------------------------------
//	gmiPlayerShellShocked
//
// 	Shell shock effect for nades and rockets in GMI multiplayer
// ----------------------------------------------------------------------------------
gmiPlayerShellShocked(dmg, customShellShock)
{
	time = 0;
	
	if(dmg >= 90)
		time = 4.00;
	else if(dmg < 89 && dmg > 50)
		time = 3.00;
	else if(dmg < 49 && dmg > 25)
		time = 2.0;
	else if(dmg < 24 && dmg > 1)
		time = 1.0;
 	else
 		time = 1.0;
 
 	// if they are in a vehicle do not do a long shell shock
 	if ( self isinvehicle() )
 		time = 1.0;

	self notify("player shell shocked");
	self thread gmiShellShock(time, undefined, undefined, undefined, undefined, customShellShock);
}

gmiShellShock(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock)
{
	self thread gmiSSinternalMain(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock);
}

gmiSSinternalMain(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock)
{
	println("do shell shock");
	
	if(!isdefined(nMaxDamageBase))
	{
		nMaxDamageBase = 0;
	}
	
	if(!isdefined(nRanDamageBase))
	{
		nRanDamageBase = 0;
	}
	
	if(!isdefined(nMinDamageBase))
	{
		nMinDamageBase = 0;
	}
	
	if(!isdefined(customShellShock))
	{
		strShocktype = "default_mp";
	}
	else
	{
		strShocktype = customShellShock;
	}
	
	origin = (self getorigin() + (0,8,2));
	range = 320;
	
	if(isalive(self))
	{
		wait 0.15;
		self viewkick(96, self.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
		self shellshock(strShocktype, duration);
	}
}


