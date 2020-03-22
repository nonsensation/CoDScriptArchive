// ----------------------------------------------------------------------------------
//	InitializeBattleRank
//
// 		Sets up defaults for all of the values
// ----------------------------------------------------------------------------------
InitializeBattleRank()
{
	game["br_artillery_ready"] = "gfx/hud/hud@fire_ready_shell.dds";

	// set up the icons
	game["br_headicons_allies_0"] = "gfx/hud/headicon@us_rank1.dds";
	game["br_headicons_allies_1"] = "gfx/hud/headicon@us_rank2.dds";
	game["br_headicons_allies_2"] = "gfx/hud/headicon@us_rank3.dds";
	game["br_headicons_allies_3"] = "gfx/hud/headicon@us_rank4.dds";
	game["br_headicons_allies_4"] = "gfx/hud/headicon@us_rank5.dds";

	game["br_hudicons_allies_0"] = "gfx/hud/hud@us_rank1.dds";
	game["br_hudicons_allies_1"] = "gfx/hud/hud@us_rank2.dds";
	game["br_hudicons_allies_2"] = "gfx/hud/hud@us_rank3.dds";
	game["br_hudicons_allies_3"] = "gfx/hud/hud@us_rank4.dds";
	game["br_hudicons_allies_4"] = "gfx/hud/hud@us_rank5.dds";

	// set up the points
	if(!isdefined(game["br_points_objective"]))	// Achieving an objective
		game["br_points_objective"] = 5;
	if(!isdefined(game["br_points_teamcap"]))	// How many points to the team
		game["br_points_teamcap"] = 1;
	if(!isdefined(game["br_points_cap"]))		// Capping a flag
		game["br_points_cap"] = 2;
	if(!isdefined(game["br_points_assist"]))	// Assisting a cap
		game["br_points_assist"] = 1;
	if(!isdefined(game["br_points_defense"]))	// Killing enemy in flag zone
		game["br_points_defense"] = 2;
	if(!isdefined(game["br_points_kill"]))		// Getting a kill
		game["br_points_kill"] = 1;
	if(!isdefined(game["br_points_teamkill"]))	// Killing someone on your own team
		game["br_points_teamkill"] = -3;
	if(!isdefined(game["br_points_suicide"]))	// Killing yourself
		game["br_points_suicide"] = -1;
	if(!isdefined(game["br_points_dying"]))		// Getting killed
		game["br_points_dying"] = 0;
	if(!isdefined(game["br_points_reversal"]))	// Other team taking a flag
		game["br_points_reversal"] = 0;

	if(getCvar("scr_rank_ppr") == "")	// points per rank
		setCvar("scr_rank_ppr", "10");
	game["br_ppr"] = getCvarInt("scr_rank_ppr");

	// set up the rank points
	if(!isdefined(game["br_rank_1"]))	// points to achieve first rank
		game["br_rank_1"] = game["br_ppr"] * 1;
	if(!isdefined(game["br_rank_2"]))	// points to achieve second rank
		game["br_rank_2"] = game["br_ppr"] * 2;
	if(!isdefined(game["br_rank_3"]))	// points to achieve third rank
		game["br_rank_3"] = game["br_ppr"] * 3;
	if(!isdefined(game["br_rank_4"]))	// points to achieve fourth rank
		game["br_rank_4"] = game["br_ppr"] * 4;
		
	// set up the ammo values for the various ranks
	// remember that they will already have one clip in the gun
	game["br_ammo_gunclips_0"] = 4;
	game["br_ammo_gunclips_1"] = 4;
	game["br_ammo_gunclips_2"] = 5;
	game["br_ammo_gunclips_3"] = 5;
	game["br_ammo_gunclips_4"] = 6;

	game["br_ammo_pistolclips_0"] = 2;
	game["br_ammo_pistolclips_1"] = 3;
	game["br_ammo_pistolclips_2"] = 3;
	game["br_ammo_pistolclips_3"] = 4;
	game["br_ammo_pistolclips_4"] = 4;

	game["br_ammo_grenades_0"] = 1;
	game["br_ammo_grenades_1"] = 2;
	game["br_ammo_grenades_2"] = 2;
	game["br_ammo_grenades_3"] = 2;
	game["br_ammo_grenades_4"] = 3;

	game["br_ammo_smoke_grenades_0"] = 1;
	game["br_ammo_smoke_grenades_1"] = 1;
	game["br_ammo_smoke_grenades_2"] = 2;
	game["br_ammo_smoke_grenades_3"] = 2;
	game["br_ammo_smoke_grenades_4"] = 2;
	
	game["br_ammo_satchel_charge_0"] = 0;
	game["br_ammo_satchel_charge_1"] = 0;
	game["br_ammo_satchel_charge_2"] = 0;
	game["br_ammo_satchel_charge_3"] = 1;
	game["br_ammo_satchel_charge_4"] = 1;
	
	if( GetCvar("scr_artillery_first_interval") == "" )
		setCvar("scr_artillery_first_interval", "45"); 
	if( GetCvar("scr_artillery_interval") == "" )
		setCvar("scr_artillery_interval", "120"); 
	if( GetCvar("scr_artillery_interval_range") == "" )
		setCvar("scr_artillery_interval_range", "15"); 
		
	//
	// DEBUG
	//
	if(getCvar("scr_forcerank") == "")
		setCvar("scr_forcerank", "0"); 
}

// ----------------------------------------------------------------------------------
//	UpdateBattleRank
//
// 		Monitors for changes in battle rank settings
// ----------------------------------------------------------------------------------
UpdateBattleRank()
{
	for(;;)
	{
		//
		// DEBUG
		//

		wait 5;
	}
}

// ----------------------------------------------------------------------------------
//	ResetPlayerRank
//
// 		Resets both the player rank and score for all players
// ----------------------------------------------------------------------------------
ResetPlayerRank()
{
	players = getentarray("player", "classname");
	
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		player.pers["rank"] = 0;
		player.pers["score"] = 0;
		player.score = 0;
		player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);
		
		if ( level.drawfriend )
		{
			player.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(player);
		}
		else
		{
			player.headicon = "";
		}
		
		if ( player.pers["team"] == "allies" )
			player.headiconteam = "allies";
		else if (player.pers["team"] == "axis")
			player.headiconteam = "axis";
		else
			player.headiconteam = "none";
	}
}

// ----------------------------------------------------------------------------------
//	PrecacheBattleRank
//
// 		Precaches anything needed for battle rank
// ----------------------------------------------------------------------------------
PrecacheBattleRank()
{
	
	precacheHeadIcon(game["br_headicons_allies_0"]);
	precacheHeadIcon(game["br_headicons_allies_1"]);
	precacheHeadIcon(game["br_headicons_allies_2"]);
	precacheHeadIcon(game["br_headicons_allies_3"]);
	precacheHeadIcon(game["br_headicons_allies_4"]);

//	precacheHeadIcon(game["br_headicons_axis_0"]);
//	precacheHeadIcon(game["br_headicons_axis_1"]);
//	precacheHeadIcon(game["br_headicons_axis_2"]);
//	precacheHeadIcon(game["br_headicons_axis_3"]);
//	precacheHeadIcon(game["br_headicons_axis_4"]);
	
	precacheStatusIcon(game["br_hudicons_allies_0"]);
	precacheStatusIcon(game["br_hudicons_allies_1"]);
	precacheStatusIcon(game["br_hudicons_allies_2"]);
	precacheStatusIcon(game["br_hudicons_allies_3"]);
	precacheStatusIcon(game["br_hudicons_allies_4"]);

//	precacheStatusIcon(game["br_hudicons_axis_0"]);
//	precacheStatusIcon(game["br_hudicons_axis_1"]);
//	precacheStatusIcon(game["br_hudicons_axis_2"]);
//	precacheStatusIcon(game["br_hudicons_axis_3"]);
//	precacheStatusIcon(game["br_hudicons_axis_4"]);
	
	precacheShader(game["br_artillery_ready"]);
	precacheShader(game["br_hudicons_allies_0"]);
	precacheShader(game["br_hudicons_allies_1"]);
	precacheShader(game["br_hudicons_allies_2"]);
	precacheShader(game["br_hudicons_allies_3"]);
	precacheShader(game["br_hudicons_allies_4"]);

	precacheString(&"GMI_RANK_PROMOTION");
	precacheString(&"GMI_RANK_DEMOTION");
	
	game["br_rank_message_2"] = &"GMI_RANK_2_MESSAGE";
	game["br_rank_message_3"] = &"GMI_RANK_3_MESSAGE";
	game["br_rank_message_4"] = &"GMI_RANK_4_MESSAGE";
	game["br_rank_message_5"] = &"GMI_RANK_5_MESSAGE";
	
	precacheString(game["br_rank_message_2"]);
	precacheString(game["br_rank_message_3"]);
	precacheString(game["br_rank_message_4"]);
	precacheString(game["br_rank_message_5"]);

}

// ----------------------------------------------------------------------------------
//	DetermineBattleRank
//
// 		Returns a level 0 - 4 that the player is currently at.
// ----------------------------------------------------------------------------------
DetermineBattleRank(player)
{
	if ( getCvarInt("scr_forcerank") != 0 )
	{
		rank =  getCvarInt("scr_forcerank");
		if ( rank > 5 )
			rank = 5;
			
		return rank - 1;
	}
	else if ( player.score >= game["br_rank_4"] )
	{
		return 4;
	}
	else if ( player.score >= game["br_rank_3"] )
	{
		return 3;
	}
	else if ( player.score >= game["br_rank_2"] )
	{
		return 2;
	}
	else if ( player.score >= game["br_rank_1"] )
	{
		return 1;
	}
	
	return 0;
}

// ----------------------------------------------------------------------------------
//	CheckPlayersForRankChanges
//
// 		Checks all of the players for a change from their previous rank.
//		This function will update the rank value of all players.
//		This function will play sounds when the player changes rank.
//		THIS FUNCTION ASSUMES THAT THE .rank VARIABLE IS DEFINED.
// ----------------------------------------------------------------------------------
CheckPlayersForRankChanges()
{
	players = getentarray("player", "classname");
	
	// count up the people in the flag area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(isalive(player))
		{			
			old_rank = player.pers["rank"];
			new_rank = DetermineBattleRank(player);
			
			if ( old_rank != new_rank )
			{
				// did they get promoted?
				if ( old_rank < new_rank )
				{
					player notify("rank changed");
					PlayPromotionSound(player);
					player iprintln(&"GMI_RANK_PROMOTION");		
				}
				// or demoted?
				else
				{
					player notify("rank changed");
					PlayDemotionSound(player);
					player iprintln(&"GMI_RANK_DEMOTION");		
				}
				
				player.pers["rank"] = new_rank;
				
				if (!isdefined(player.hasflag))	// during CTF statusicon is used to identify the flag carrier
					player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);

				if ( level.drawfriend )
				{
					player.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(player);
				}
				else
				{
					player.headicon = "";
				}

				if ( player.pers["team"] == "allies" )
					player.headiconteam = "allies";
				else if (player.pers["team"] == "axis")
					player.headiconteam = "axis";
				else
					player.headiconteam = "none";
					
				// print the rank message
				if (new_rank > 0 && old_rank < new_rank )
					player iprintln(game[ ("br_rank_message_" + (new_rank + 1) ) ]);
			}
			
		}
	}
	

}

// ----------------------------------------------------------------------------------
//	PlayPromotionSound
//
//		Plays the appropriate promotion sound
// ----------------------------------------------------------------------------------
PlayPromotionSound(player)
{
	if ( player.pers["team"] == "allies" ) 
	{
		player playLocalSound("mp_promotion" );
	}
	else
	{
		player playLocalSound("mp_promotion");
	}
}

// ----------------------------------------------------------------------------------
//	PlayDemotionSound
//
//		Plays the appropriate demotion sound
// ----------------------------------------------------------------------------------
PlayDemotionSound(player)
{
	if ( player.pers["team"] == "allies" ) 
	{
		player playLocalSound("mp_demotion" );
	}
	else
	{
		player playLocalSound("mp_demotion");
	}
}

// ----------------------------------------------------------------------------------
//	GetRankHeadIcon
//
//		Returns the appropriate head rank icon
// ----------------------------------------------------------------------------------
GetRankHeadIcon(player)
{	
	if ( player.pers["team"] == "spectator" )
		return "";

	icon_name = "br_headicons_allies_" + player.pers["rank"];
	return game[icon_name];
}

// ----------------------------------------------------------------------------------
//	GetRankStatusIcon
//
//		Returns the appropriate status rank icon
// ----------------------------------------------------------------------------------
GetRankStatusIcon(player)
{	
	if ( player.pers["team"] == "spectator" )
		return "";
		
	icon_name = "br_hudicons_allies_" + player.pers["rank"];
	
	return game[icon_name];
}

// ----------------------------------------------------------------------------------
//	GetGunAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetGunAmmo(weapon)
{
	clip_count = game["br_ammo_gunclips_" + self.pers["rank"]];

	clip_size = getfullclipammo(weapon);
	
	switch(weapon)
	{
		// projectile weapons need to have default ammo returned for the original
		// game types
		case "panzerfaust_mp":
			return 1;
		case "panzerschreck_mp":
			return 3;
		case "bazooka_mp":
			return 3;
		case "flamethrower_mp":
			return 300;
			
		//special weapons	
		case "fg42_mp":
		case "fg42_semi_mp":
			
		//American Weapons
		case "thompson_mp": 
		case "thompson_semi_mp": 
		case "bar_mp": 
		case "bar_slow_mp":
		case "mg30cal_mp":
		//British Weapons
		case "sten_mp":
		case "sten_silenced_mp":
		case "bren_mp":
		//Russian Weapons
		case "ppsh_mp":
		case "ppsh_semi_mp":
		//German Weapons
		case "mp40_mp":
		case "mp44_semi_mp":
		case "mp44_mp":
		case "mg34_mp":
		
		return clip_count * clip_size;
		
		// Semi-automatic rifles get 1 extra clip
		//American Weapons
		case "m1carbine_mp":
		case "m1garand_mp":
		//Russian Weapons
		case "svt40_mp":
		case "dp28_mp":
		//German Weapons
		case "gewehr43_mp":

		return (clip_count + 1) * clip_size;

		// Bolt action rifles get 2 extra clips
		//American Weapons
		case "springfield_mp": 
		//British Weapons
		case "enfield_mp":
		//Russian Weapons
		case "mosin_nagant_mp":
		case "mosin_nagant_sniper_mp":
		//German Weapons
		case "kar98k_mp": 
		case "kar98k_sniper_mp":
			
		return (clip_count + 2) * clip_size;

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
	clip_count = game["br_ammo_pistolclips_" + self.pers["rank"]];

	clip_size = getfullclipammo(weapon);
	
	return clip_count * clip_size;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedSmokeGrenadeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedSmokeGrenadeCount(weapon)
{
	rank_count = game["br_ammo_smoke_grenades_" + self.pers["rank"]];

	return rank_count;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedSatchelChargeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedSatchelChargeCount(weapon)
{
	rank_count = game["br_ammo_satchel_charge_" + self.pers["rank"]];

	return rank_count;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedGrenadeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedGrenadeCount(weapon)
{
	rank_count = game["br_ammo_grenades_" + self.pers["rank"]];

	return rank_count;
}

giveBinoculars(spawnweapon)
{
	binoctype = "binoculars_mp";
	
	self takeWeapon("binoculars_mp");
	self takeWeapon("binoculars_artillery_mp");
	
	// if they are highest rank then they get the artillery strike binoculars
	if ( self.pers["rank"] == 4 && level.allow_artillery)
	{
		
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])		
			{
			case "american":
				binoctype = "binoculars_artillery_mp";
				break;
	
			case "british":
				binoctype = "binoculars_artillery_mp";
				break;
	
			case "russian":
				binoctype = "binoculars_artillery_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				binoctype = "binoculars_artillery_mp";
				break;
			}			
		}
		
		self setWeaponSlotWeapon("binocular", binoctype);
		
		// They do not start with any ammo
		self setWeaponSlotClipAmmo("binocular", 0);
		
		// give them ammo regularly
		self thread dispense_artillery_strike();
		self thread artillery_strike_sounds();
		
	}
	else if ( self.pers["rank"] >= 2 && level.allow_binoculars )
	{
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])		
			{
			case "american":
				binoctype = "binoculars_mp";
				break;
	
			case "british":
				binoctype = "binoculars_mp";
				break;
	
			case "russian":
				binoctype = "binoculars_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				binoctype = "binoculars_mp";
				break;
			}			
		}
		
		self setWeaponSlotWeapon("binocular", binoctype);
	}
}
// ----------------------------------------------------------------------------------
//	artillery_strike_sounds
//
// 		Will play all the apropriate sounds whenever an artillery strike gets called
// ----------------------------------------------------------------------------------
artillery_strike_sounds()
{
	self endon("death");

	if ( self.pers["team"] == "allies" )	
	{
		switch( game["allies"])
		{
		case "british":
			fire_sound = "uk_fire_mission";
			incoming_sound = "uk_incoming";
			break;
		case "russian":
			fire_sound = "ru_fire_mission";
			incoming_sound = "ru_incoming";
			break;
		default:
			fire_sound = "us_fire_mission";
			incoming_sound = "us_incoming";
		}
	}
	else
	{
		fire_sound = "ge_fire_mission";
		incoming_sound = "ge_incoming";
	}
	
	while (1)
	{
		self waittill( "artillery", strike_point );
		
		// play the vo for calling in the artillery strike
		self playLocalSound(fire_sound);
		
		// now play the incoming sound for any teammates in the area
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
		
			if(player != self && player.pers["team"] == self.pers["team"])
			{
				dist = distance( player.origin, strike_point );
				
				// only play the warning if they are close to the strike area
				if ( dist < 1000 )
					player playLocalSound(incoming_sound);
			}
		}
		
		wait(0.1);	
	}
}

// ----------------------------------------------------------------------------------
//	dispense_artillery_strike
//
// 		thinks while player is alive and gives an artillery strike after timed
//		intervals
// ----------------------------------------------------------------------------------
dispense_artillery_strike()
{
	first_interval = GetCvarInt("scr_artillery_first_interval");   
	interval = GetCvarInt("scr_artillery_interval");
	interval_range = GetCvarInt("scr_artillery_interval_range");
	
	if ( interval_range < 1 )
		interval_range = 1;
		
	self endon("death");
	
	// kill any currently running dispense_artillery_strike functions
	self notify("end dispense_artillery_strike");
	wait(0.1);
	self endon("end dispense_artillery_strike");
	
	// wait the first
	wait(first_interval);
	
	while (1)
	{
		// go ahead and give them one ammo if they do not have any
		if ( self getWeaponSlotClipAmmo( "binocular" ) == 0 )
		{
			// let them know the artillery strike is available
			clientAnnouncement(self,&"GMI_RANK_ARTILLERY_IN_PLACE");
			
			// play a vo
			if ( self.pers["team"] == "allies" )	
			{
				switch( game["allies"])
				{
				case "british":
					sound = "uk_arty_gtg";
					break;
				case "russian":
					sound = "ru_arty_gtg";
					break;
				default:
					sound = "us_arty_gtg";
				}
			}
			else
			{
				sound = "ge_arty_gtg";
			}
			self playLocalSound(sound);
		
			// give them one
			self setWeaponSlotClipAmmo("binocular", 1);
			
			//set up the on screen icon
			artillery_available_hud();
		}
		
		// wait until they use artillery
		self waittill("artillery");
	
		// now wait for one interval
		wait(interval + randomint(interval_range));
	}
}	

// ----------------------------------------------------------------------------------
//	artillery_available_hud
//
// 		puts an icon on the screen when artillery is available
// ----------------------------------------------------------------------------------
artillery_available_hud()
{
	self endon("death");
	self notify("artillery available hud");
	
	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();

	self.artillery_available_icon = newClientHudElem(self);		
	self.artillery_available_icon.alignX = "center";
	self.artillery_available_icon.alignY = "middle";
	self.artillery_available_icon.x = 160;
	self.artillery_available_icon.y = 455;
	self.artillery_available_icon.alpha = 1.0;
	self.artillery_available_icon setShader(game["br_artillery_ready"], 32, 32);	
	
	self thread artillery_available_hud_destroy();
}

// ----------------------------------------------------------------------------------
//	artillery_available_hud_destroy
//
// 		Cleans up the artillery availble icon
// ----------------------------------------------------------------------------------
artillery_available_hud_destroy()
{
	self thread artillery_available_hud_destroy2();
	self endon("artillery available hud");
	self waittill("death");
	
	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();
}

// ----------------------------------------------------------------------------------
//	artillery_available_hud_destroy
//
// 		Cleans up the artillery availble icon
// ----------------------------------------------------------------------------------
artillery_available_hud_destroy2()
{
	self endon("death");
	self endon("artillery available hud");

	// wait until they use artillery
	self waittill("artillery");
	
	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudInit
//
// 		Sets up the rank hud icon
// ----------------------------------------------------------------------------------
RankHudInit()
{
	if ( !getcvarint("scr_battlerank") )
		return;
		
	self endon("death");
	self notify("rank RankHudInit");
	
	wait (0.01);
	self endon("rank RankHudInit");
	
	if (isDefined(self.rank_hud_icon))
	{
		self.rank_hud_icon destroy();
	}
	

	self.rank_hud_icon = newClientHudElem(self);		
	self.rank_hud_icon.alignX = "center";
	self.rank_hud_icon.alignY = "middle";
	self.rank_hud_icon.x = 119;
	self.rank_hud_icon.y = 405;
	self.rank_hud_icon.alpha = 0.7;
	
	self thread RankHudSetShader();
	self thread RankHudMonitor();
	self thread RankHudDestroy();
}		

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudSetShader(rank_change)
{
	self endon("death");
	self endon("rank RankHudInit");
	
	if ( isDefined(rank_change) && rank_change )
	{
		self.rank_hud_icon setShader(GetRankStatusIcon(self), 78, 96);
		self.rank_hud_icon scaleOverTime(3, 26, 32);
	}
	else
	{
		self.rank_hud_icon setShader(GetRankStatusIcon(self), 26, 32);	
	}
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudDestroy()
{
	self thread rankHudDestroy2();
	self endon("rank RankHudInit");
	self waittill("death");
	
	if ( isdefined(self.rank_hud_icon))
		self.rank_hud_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudDestroy2()
{
	self endon("death");
	self endon("rank RankHudInit");

	while ( level.battlerank )
	 	wait (0.01);
	
	if ( isdefined(self.rank_hud_icon))
		self.rank_hud_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudMonitor()
{
	self endon("death");
	self endon("rank RankHudInit");
	
	while ( level.battlerank )
	{
		self waittill("rank changed");
		
		self thread RankHudSetShader(true);
		wait (0.01);
	}
	
	if (isDefined(self.rank_hud_icon))
	{
		self.rank_hud_icon destroy();
	}
}
