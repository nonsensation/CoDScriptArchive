// ----------------------------------------------------------------------------------
//	PlayerSpawnLoadout
//
// 		Sets up the player weapons
// ----------------------------------------------------------------------------------
PlayerSpawnLoadout()
{
	if (!isdefined(self.pers["weapon"]) && !isdefined(self.pers["weapon1"]))
	{
//	 	maps\mp\_utility::error("no defined weapon for the spawning player");
	 	return;
	}
	
	// make sure that the weapon is set up
	if (!isdefined(self.pers["weapon"]))
	{
		self.pers["weapon"] = self.pers["weapon1"];
	 	maps\mp\_utility::error("no defined weapon for the spawning player");
	}
	
	if(isDefined(self.pers["weapon1"]) && isDefined(self.pers["weapon2"]))
	{
		clip_size = getfullclipammo(self.pers["weapon1"]);
		ammount = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(self.pers["weapon1"]);

	 	self setWeaponSlotWeapon("primary", self.pers["weapon1"]);
		
		//this will only give up to one full clip in the gun
		self setWeaponSlotClipAmmo("primary", ammount);
		if ( ammount > clip_size )
			self setWeaponSlotAmmo("primary", ammount - clip_size );

		clip_size = getfullclipammo(self.pers["weapon2"]);
		ammount = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(self.pers["weapon2"]);

	 	self setWeaponSlotWeapon("primaryb", self.pers["weapon2"]);

		//this will only give up to one full clip in the gun
		self setWeaponSlotClipAmmo("primaryb", ammount);
		if ( ammount > clip_size )
			self setWeaponSlotAmmo("primaryb", ammount - clip_size);

		self.pers["spawnweapon"] = self.pers["weapon1"];
		self setSpawnWeapon(self.pers["spawnweapon"]);
	}
	else
	{
		if ( !isdefined(self.pers["weapon"]) )
		{
			self.pers["weapon"] = self.pers["weapon1"];
		}
		clip_size = getfullclipammo(self.pers["weapon"]);
		ammount = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(self.pers["weapon"]);

		self setWeaponSlotWeapon("primary", self.pers["weapon"]);

		//this will only give up to one full clip in the gun
		self setWeaponSlotClipAmmo("primary", ammount);
		if ( ammount > clip_size )
			self setWeaponSlotAmmo("primary", ammount - clip_size);
	
		self.pers["spawnweapon"] = self.pers["weapon"];
		self setSpawnWeapon(self.pers["weapon"]);
	}
	
	self maps\mp\gametypes\_teams::givePistol();
	self maps\mp\gametypes\_teams::giveGrenades(self.pers["weapon"]);
	self maps\mp\gametypes\_teams::giveBinoculars(self.pers["weapon"]);
	
	// give smoke grenades will be called from giveGrenades for now
//	self maps\mp\gametypes\_teams::giveSmokeGrenades(self.pers["selectedweapon"]);
}

// ----------------------------------------------------------------------------------
//	GetGunAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetGunAmmo(weapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::GetGunAmmo(weapon);
	}
	
	switch(weapon)
	{
		//American Weapons
		case "m1carbine_mp":
			return 60;
		case "m1garand_mp":
			return 56;
		case "springfield_mp": 
			return 25;
		case "thompson_mp": 
		case "thompson_semi_mp": 
			return 120;
		case "bar_mp": 
		case "bar_slow_mp": 
			return 100;
		case "mg30cal_mp":
			return 225;
		//British Weapons
		case "enfield_mp":
			return 60;
		case "sten_mp": 
		case "sten_silenced_mp":
			return 128;
		case "bren_mp": 
			return 90;
		//Russian Weapons
		case "mosin_nagant_mp":
			return 60;
		case "svt40_mp":
			return 60;
		case "mosin_nagant_sniper_mp":
			return 25;
		case "ppsh_mp":
		case "ppsh_semi_mp":
			return 142;
		case "dp28_mp":
			return 225;
		//German Weapons
		case "kar98k_mp": 
			return 60;
		case "gewehr43_mp":
			return 60;
		case "kar98k_sniper_mp":
			return 25;
		case "mp40_mp":
			return 128;
		case "mp44_mp":
		case "mp44_semi_mp":
			return 90;
		case "mg34_mp":
			return 225;
		case "panzerfaust_mp":
			return 1;
		case "panzerschreck_mp":
			return 3;
		case "bazooka_mp":
			return 3;
		case "fg42_mp":
		case "fg42_semi_mp":
			return 60;
		case "flamethrower_mp":
			return 300;
		// unrecognized weapon
		default:
		   	return 0;
		}
		
	return 0;
}

// ----------------------------------------------------------------------------------
//	GetPistolAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetPistolAmmo(weapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::GetPistolAmmo(weapon);
	}
	
	// fill em up
	return 999;
}

