modeltype()
{
	switch(game["allies"])
	{
	case "american":
		if(isdefined(game["american_soldiertype"]))
		{
			switch(game["american_soldiertype"])
			{
			case "airborne":
				if(isdefined(game["american_soldiervariation"]))
				{
					switch(game["american_soldiervariation"])
					{
					case "normal":
						mptype\american_airborne::precache();
						game["allies_model"] = mptype\american_airborne::main;	
						break;
					
					case "winter":
						mptype\american_airborne_winter::precache();
						game["allies_model"] = mptype\american_airborne_winter::main;
						break;
				
					default:
						println("Unknown american_soldiervariation specified, using default");
						mptype\american_airborne::precache();
						game["allies_model"] = mptype\american_airborne::main;
						break;
					}
				}
				else
				{
					mptype\american_airborne::precache();
					game["allies_model"] = mptype\american_airborne::main;
				}
				break;
				
			default:
				println("Unknown american_soldiertype specified, using default");
				mptype\american_airborne::precache();
				game["allies_model"] = mptype\american_airborne::main;
				break;
			}
		}
		else
		{
			mptype\american_airborne::precache();
			game["allies_model"] = mptype\american_airborne::main;
		}
		break;

	case "british":
		if(isdefined(game["british_soldiertype"]))
		{
			switch(game["british_soldiertype"])
			{
			case "airborne":
				if(isdefined(game["british_soldiervariation"]))
				{
					switch(game["british_soldiervariation"])
					{
					case "normal":
						mptype\british_airborne::precache();
						game["allies_model"] = mptype\british_airborne::main;	
						break;
					
					default:
						println("Unknown british_soldiervariation specified, using default");
						mptype\british_airborne::precache();
						game["allies_model"] = mptype\british_airborne::main;
						break;
					}
				}
				else
				{
					mptype\british_airborne::precache();
					game["allies_model"] = mptype\british_airborne::main;
				}
				break;

			case "commando":
				if(isdefined(game["british_soldiervariation"]))
				{
					switch(game["british_soldiervariation"])
					{
					case "normal":
						mptype\british_commando::precache();
						game["allies_model"] = mptype\british_commando::main;	
						break;
					
					case "winter":
						mptype\british_commando_winter::precache();
						game["allies_model"] = mptype\british_commando_winter::main;
						break;
				
					default:
						println("Unknown british_soldiervariation specified, using default");
						mptype\british_commando::precache();
						game["allies_model"] = mptype\british_commando::main;
						break;
					}
				}
				else
				{
					mptype\british_commando::precache();
					game["allies_model"] = mptype\british_commando::main;
				}
				break;
				
			default:
				println("Unknown british_soldiertype specified, using default");
				mptype\british_commando::precache();
				game["allies_model"] = mptype\british_commando::main;
				break;
			}
		}
		else
		{
			mptype\british_commando::precache();
			game["allies_model"] = mptype\british_commando::main;
		}
		break;

	case "russian":
		if(isdefined(game["russian_soldiertype"]))
		{
			switch(game["russian_soldiertype"])
			{
			case "conscript":
				if(isdefined(game["russian_soldiervariation"]))
				{
					switch(game["russian_soldiervariation"])
					{
					case "normal":
						mptype\russian_conscript::precache();
						game["allies_model"] = mptype\russian_conscript::main;	
						break;
					
					case "winter":
						mptype\russian_conscript_winter::precache();
						game["allies_model"] = mptype\russian_conscript_winter::main;
						break;
				
					default:
						println("Unknown russian_soldiervariation specified, using default");
						mptype\russian_conscript::precache();
						game["allies_model"] = mptype\russian_conscript::main;
						break;
					}
				}
				else
				{
					mptype\russian_conscript::precache();
					game["allies_model"] = mptype\russian_conscript::main;
				}
				break;
				
			case "veteran":
				if(isdefined(game["russian_soldiervariation"]))
				{
					switch(game["russian_soldiervariation"])
					{
					case "normal":
						mptype\russian_veteran::precache();
						game["allies_model"] = mptype\russian_veteran::main;	
						break;
					
					case "winter":
						mptype\russian_veteran_winter::precache();
						game["allies_model"] = mptype\russian_veteran_winter::main;	
						break;

					default:
						println("Unknown russian_soldiervariation specified, using default");
						mptype\russian_veteran::precache();
						game["allies_model"] = mptype\russian_veteran::main;
						break;
					}
				}
				else
				{
					mptype\russian_veteran::precache();
					game["allies_model"] = mptype\russian_veteran::main;
				}
				break;

			default:
				println("Unknown russian_soldiertype specified, using default");
				mptype\russian_conscript::precache();
				game["allies_model"] = mptype\russian_conscript::main;
				break;
			}
		}
		else
		{
			mptype\russian_conscript::precache();
			game["allies_model"] = mptype\russian_conscript::main;
		}
		break;
	}

	switch(game["axis"])
	{
	case "german":
		if(isdefined(game["german_soldiertype"]))
		{
			switch(game["german_soldiertype"])
			{
			case "wehrmacht":
				if(isdefined(game["german_soldiervariation"]))
				{
					switch(game["german_soldiervariation"])
					{
					case "normal":
						mptype\german_wehrmacht::precache();
						game["axis_model"] = mptype\german_wehrmacht::main;	
						break;
					
					case "winter":
						mptype\german_wehrmacht_winter::precache();
						game["axis_model"] = mptype\german_wehrmacht_winter::main;
						break;
				
					default:
						println("Unknown german_soldiervariation specified, using default");
						mptype\german_wehrmacht::precache();
						game["axis_model"] = mptype\german_wehrmacht::main;
						break;
					}
				}
				else
				{
					mptype\german_wehrmacht::precache();
					game["axis_model"] = mptype\german_wehrmacht::main;
				}
				break;
				
			case "waffen":
				if(isdefined(game["german_soldiervariation"]))
				{
					switch(game["german_soldiervariation"])
					{
					case "normal":
						mptype\german_waffen::precache();
						game["axis_model"] = mptype\german_waffen::main;	
						break;
					
					case "winter":
						mptype\german_waffen_winter::precache();
						game["axis_model"] = mptype\german_waffen_winter::main;
						break;
				
					default:
						println("Unknown german_soldiervariation specified, using default");
						mptype\german_waffen::precache();
						game["axis_model"] = mptype\german_waffen::main;
						break;
					}
				}
				else
				{
					mptype\german_waffen::precache();
					game["axis_model"] = mptype\german_waffen::main;
				}
				break;

			case "fallschirmjagercamo":
				if(isdefined(game["german_soldiervariation"]))
				{
					switch(game["german_soldiervariation"])
					{
					case "normal":
						mptype\german_fallschirmjagercamo::precache();
						game["axis_model"] = mptype\german_fallschirmjagercamo::main;	
						break;
					
					default:
						println("Unknown german_soldiervariation specified, using default");
						mptype\german_fallschirmjagercamo::precache();
						game["axis_model"] = mptype\german_fallschirmjagercamo::main;
						break;
					}
				}
				else
				{
					mptype\german_fallschirmjagercamo::precache();
					game["axis_model"] = mptype\german_fallschirmjagercamo::main;
				}
				break;

			case "fallschirmjagergrey":
				if(isdefined(game["german_soldiervariation"]))
				{
					switch(game["german_soldiervariation"])
					{
					case "normal":
						mptype\german_fallschirmjagergrey::precache();
						game["axis_model"] = mptype\german_fallschirmjagergrey::main;	
						break;
					
					default:
						println("Unknown german_soldiervariation specified, using default");
						mptype\german_fallschirmjagergrey::precache();
						game["axis_model"] = mptype\german_fallschirmjagergrey::main;
						break;
					}
				}
				else
				{
					mptype\german_fallschirmjagergrey::precache();
					game["axis_model"] = mptype\german_fallschirmjagergrey::main;
				}
				break;

			case "kriegsmarine":
				if(isdefined(game["german_soldiervariation"]))
				{
					switch(game["german_soldiervariation"])
					{
					case "normal":
						mptype\german_kriegsmarine::precache();
						game["axis_model"] = mptype\german_kriegsmarine::main;	
						break;
					
					default:
						println("Unknown german_soldiervariation specified, using default");
						mptype\german_kriegsmarine::precache();
						game["axis_model"] = mptype\german_kriegsmarine::main;
						break;
					}
				}
				else
				{
					mptype\german_kriegsmarine::precache();
					game["axis_model"] = mptype\german_kriegsmarine::main;
				}
				break;
			
			default:
				println("Unknown german_soldiertype specified, using default");
				mptype\german_wehrmacht::precache();
				game["axis_model"] = mptype\german_wehrmacht::main;
				break;
			}
		}
		else
		{
			mptype\german_wehrmacht::precache();
			game["axis_model"] = mptype\german_wehrmacht::main;
		}
		break;
	}
}

precache()
{
	precacheHeadIcon("gfx/hud/headicon@quickmessage");	//TEMP
	
	switch(game["allies"])
	{
	case "american":
		//precacheShader("gfx/hud/hud@mpflag_american.tga");
		precacheItem("fraggrenade_mp");
		precacheItem("colt_mp");
		precacheItem("m1carbine_mp");
		precacheItem("m1garand_mp");
		precacheItem("thompson_mp");
		precacheItem("bar_mp");
		precacheItem("springfield_mp");
		break;
	
	case "british":
		//precacheShader("gfx/hud/hud@mpflag_british.tga");
		precacheItem("mk1britishfrag_mp");
		precacheItem("colt_mp");
		precacheItem("enfield_mp");
		precacheItem("sten_mp");
		precacheItem("bren_mp");
		precacheItem("springfield_mp");
		break;
	
	case "russian":
		//precacheShader("gfx/hud/hud@mpflag_russian.tga");
		precacheItem("rgd-33russianfrag_mp");
		precacheItem("luger_mp");
		precacheItem("mosin_nagant_mp");
		precacheItem("ppsh_mp");
		precacheItem("mosin_nagant_sniper_mp");
		break;
	}

	switch(game["axis"])
	{
	case "german":
		//precacheShader("gfx/hud/hud@mpflag_german.tga");
		precacheItem("stielhandgranate_mp");
		precacheItem("luger_mp");
		precacheItem("kar98k_mp");
		precacheItem("mp40_mp");
		precacheItem("mp44_mp");
		precacheItem("kar98k_sniper_mp");
		break;
	}
}
	
scoreboard()
{
	switch(game["allies"])
	{
	case "american":
		setcvar("g_TeamName_Allies", &"MPSCRIPT_AMERICAN");
		setcvar("g_TeamColor_Allies", ".25 .75 .25");
		setcvar("g_ScoresBanner_Allies", "gfx/hud/hud@mpflag_american.tga");
		break;
	
	case "british":
		setcvar("g_TeamName_Allies", &"MPSCRIPT_BRITISH");
		setcvar("g_TeamColor_Allies", ".25 .25 .75");
		setcvar("g_ScoresBanner_Allies", "gfx/hud/hud@mpflag_british.tga");
		break;
	
	case "russian":
		setcvar("g_TeamName_Allies", &"MPSCRIPT_RUSSIAN");
		setcvar("g_TeamColor_Allies", ".75 .25 .25");
		setcvar("g_ScoresBanner_Allies", "gfx/hud/hud@mpflag_russian.tga");
		break;
	}

	switch(game["axis"])
	{
	case "german":
		setcvar("g_TeamName_Axis", &"MPSCRIPT_GERMAN");
		setcvar("g_TeamColor_Axis", ".6 .6 .6");
		setcvar("g_ScoresBanner_Axis", "gfx/hud/hud@mpflag_german.tga");
		break;
	}
}

initGlobalCvars()
{
	makeCvarServerInfo("scr_motd", "");
	makeCvarServerInfo("scr_allow_vote", "1");
	makeCvarServerInfo("scr_allow_m1carbine", "1");
	makeCvarServerInfo("scr_allow_m1garand", "1");
	makeCvarServerInfo("scr_allow_thompson", "1");
	makeCvarServerInfo("scr_allow_bar", "1");
	makeCvarServerInfo("scr_allow_springfield", "1");
	makeCvarServerInfo("scr_allow_enfield", "1");
	makeCvarServerInfo("scr_allow_sten", "1");
	makeCvarServerInfo("scr_allow_bren", "1");
	makeCvarServerInfo("scr_allow_nagant", "1");
	makeCvarServerInfo("scr_allow_ppsh", "1");
	makeCvarServerInfo("scr_allow_nagantsniper", "1");
	makeCvarServerInfo("scr_allow_kar98k", "1");
	makeCvarServerInfo("scr_allow_mp40", "1");
	makeCvarServerInfo("scr_allow_mp44", "1");
	makeCvarServerInfo("scr_allow_kar98ksniper", "1");
	makeCvarServerInfo("scr_allow_fg42", "1");
	makeCvarServerInfo("scr_allow_panzerfaust", "1");
}

restrictPlacedWeapons()
{
	if(!getcvar("scr_allow_m1carbine"))
		deletePlacedEntity("mpweapon_m1carbine");
	if(!getcvar("scr_allow_m1garand"))
		deletePlacedEntity("mpweapon_m1garand");
	if(!getcvar("scr_allow_thompson"))
		deletePlacedEntity("mpweapon_thompson");
	if(!getcvar("scr_allow_bar"))
		deletePlacedEntity("mpweapon_bar");
	if(!getcvar("scr_allow_springfield"))
		deletePlacedEntity("mpweapon_springfield");
	if(!getcvar("scr_allow_enfield"))
		deletePlacedEntity("mpweapon_enfield");
	if(!getcvar("scr_allow_sten"))
		deletePlacedEntity("mpweapon_sten");
	if(!getcvar("scr_allow_bren"))
		deletePlacedEntity("mpweapon_bren");
	if(!getcvar("scr_allow_nagant"))
		deletePlacedEntity("mpweapon_mosinnagant");
	if(!getcvar("scr_allow_ppsh"))
		deletePlacedEntity("mpweapon_ppsh");
	if(!getcvar("scr_allow_nagantsniper"))
		deletePlacedEntity("mpweapon_mosinnagantsniper");
	if(!getcvar("scr_allow_kar98k"))
		deletePlacedEntity("mpweapon_kar98k");
	if(!getcvar("scr_allow_mp40"))
		deletePlacedEntity("mpweapon_mp40");
	if(!getcvar("scr_allow_mp44"))
		deletePlacedEntity("mpweapon_mp44");
	if(!getcvar("scr_allow_kar98ksniper"))
		deletePlacedEntity("mpweapon_kar98ksniper");
	if(!getcvar("scr_allow_fg42"))
		deletePlacedEntity("mpweapon_fg42");
	if(!getcvar("scr_allow_panzerfaust"))
		deletePlacedEntity("mpweapon_panzerfaust");

	// Need to not automatically give these to players if I allow restricting them
	// colt_mp
	// luger_mp
	// fraggrenade_mp
	// mk1britishfrag_mp
	// rgd-33russianfrag_mp
	// stielhandgranate_mp
}

deletePlacedEntity(entity)
{
	entities = getentarray(entity, "classname");
	for(i = 0; i < entities.size; i++)
	{
		//println("DELETED: ", entities[i].classname);
		entities[i] delete();
	}
}

model()
{
	self detachAll();
	
	if(self.pers["team"] == "allies")
		[[game["allies_model"] ]]();
	else if(self.pers["team"] == "axis")
		[[game["axis_model"] ]]();

	self.pers["savedmodel"] = maps\mp\_utility::saveModel();
}

loadout()
{
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			self giveWeapon("colt_mp");
			self giveMaxAmmo("colt_mp");
			self giveWeapon("fraggrenade_mp");
			self giveMaxAmmo("fraggrenade_mp");
			break;

		case "british":
			self giveWeapon("colt_mp");
			self giveMaxAmmo("colt_mp");
			self giveWeapon("mk1britishfrag_mp");
			self giveMaxAmmo("mk1britishfrag_mp");
			break;

		case "russian":
			self giveWeapon("luger_mp");
			self giveMaxAmmo("luger_mp");
			self giveWeapon("rgd-33russianfrag_mp");
			self giveMaxAmmo("rgd-33russianfrag_mp");
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			self giveWeapon("luger_mp");
			self giveMaxAmmo("luger_mp");
			self giveWeapon("stielhandgranate_mp");
			self giveMaxAmmo("stielhandgranate_mp");
			break;
		}			
	}
}

isPistolOrGrenade(weapon)
{
	switch(weapon)
	{
	case "colt_mp":
	case "luger_mp":
	case "fraggrenade_mp":
	case "mk1britishfrag_mp":
	case "rgd-33russianfrag_mp":
	case "stielhandgranate_mp":
		return true;
	default:
		return false;
	}
}

restrict(response)
{
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "m1carbine_mp":
				if(!getcvar("scr_allow_m1carbine"))
				{
					self iprintln(&"MPSCRIPT_M1A1_CARBINE_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "m1garand_mp":
				if(!getcvar("scr_allow_m1garand"))
				{
					self iprintln(&"MPSCRIPT_M1_GARAND_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "thompson_mp":
				if(!getcvar("scr_allow_thompson"))
				{
					self iprintln(&"MPSCRIPT_THOMPSON_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "bar_mp":
				if(!getcvar("scr_allow_bar"))
				{
					self iprintln(&"MPSCRIPT_BAR_IS_A_RESTRICTED_WEAPON");
					response = "restricted";
				}
				break;
				
			case "springfield_mp":
				if(!getcvar("scr_allow_springfield"))
				{
					self iprintln(&"MPSCRIPT_SPRINGFIELD_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			default:
				self iprintln(&"MPSCRIPT_UNKNOWN_WEAPON_SELECTED");
				response = "restricted";
			}
			break;

		case "british":
			switch(response)		
			{
			case "enfield_mp":
				if(!getcvar("scr_allow_enfield"))
				{
					self iprintln(&"MPSCRIPT_LEEENFIELD_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "sten_mp":
				if(!getcvar("scr_allow_sten"))
				{
					self iprintln(&"MPSCRIPT_STEN_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "bren_mp":
				if(!getcvar("scr_allow_bren"))
				{
					self iprintln(&"MPSCRIPT_BREN_LMG_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
			
			case "springfield_mp":
				if(!getcvar("scr_allow_springfield"))
				{
					self iprintln(&"MPSCRIPT_SPRINGFIELD_IS_A_RESTRICTED1");
					response = "restricted";
				}
				break;

			default:
				self iprintln(&"MPSCRIPT_UNKNOWN_WEAPON_SELECTED");
				response = "restricted";
			}
			break;

		case "russian":
			switch(response)		
			{
			case "mosin_nagant_mp":
				if(!getcvar("scr_allow_nagant"))
				{
					self iprintln(&"MPSCRIPT_MOSINNAGANT_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "ppsh_mp":
				if(!getcvar("scr_allow_ppsh"))
				{
					self iprintln(&"MPSCRIPT_PPSH_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mosin_nagant_sniper_mp":
				if(!getcvar("scr_allow_nagantsniper"))
				{
					self iprintln(&"MPSCRIPT_SCOPED_MOSINNAGANT_IS");
					response = "restricted";
				}
				break;

			default:
				self iprintln(&"MPSCRIPT_UNKNOWN_WEAPON_SELECTED");
				response = "restricted";
			}
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])		
		{
		case "german":
			switch(response)		
			{
			case "kar98k_mp":
				if(!getcvar("scr_allow_kar98k"))
				{
					self iprintln(&"MPSCRIPT_KAR98K_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mp40_mp":
				if(!getcvar("scr_allow_mp40"))
				{
					self iprintln(&"MPSCRIPT_MP40_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mp44_mp":
				if(!getcvar("scr_allow_mp44"))
				{
					self iprintln(&"MPSCRIPT_MP44_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "kar98k_sniper_mp":
				if(!getcvar("scr_allow_kar98ksniper"))
				{
					self iprintln(&"MPSCRIPT_SCOPED_KAR98K_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			default:
				self iprintln(&"MPSCRIPT_UNKNOWN_WEAPON_SELECTED");
				response = "restricted";
			}
			break;
		}			
	}
	return response;
}

restrict_anyteam(response)
{
			switch(response)		
			{
			case "m1carbine_mp":
				if(!getcvar("scr_allow_m1carbine"))
				{
					self iprintln(&"MPSCRIPT_M1A1_CARBINE_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "m1garand_mp":
				if(!getcvar("scr_allow_m1garand"))
				{
					self iprintln(&"MPSCRIPT_M1_GARAND_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "thompson_mp":
				if(!getcvar("scr_allow_thompson"))
				{
					self iprintln(&"MPSCRIPT_THOMPSON_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;
				
			case "bar_mp":
				if(!getcvar("scr_allow_bar"))
				{
					self iprintln(&"MPSCRIPT_BAR_IS_A_RESTRICTED_WEAPON");
					response = "restricted";
				}
				break;
				
			case "springfield_mp":
				if(!getcvar("scr_allow_springfield"))
				{
					self iprintln(&"MPSCRIPT_SPRINGFIELD_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "enfield_mp":
				if(!getcvar("scr_allow_enfield"))
				{
					self iprintln(&"MPSCRIPT_LEEENFIELD_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "sten_mp":
				if(!getcvar("scr_allow_sten"))
				{
					self iprintln(&"MPSCRIPT_STEN_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "bren_mp":
				if(!getcvar("scr_allow_bren"))
				{
					self iprintln(&"MPSCRIPT_BREN_LMG_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mosin_nagant_mp":
				if(!getcvar("scr_allow_nagant"))
				{
					self iprintln(&"MPSCRIPT_MOSINNAGANT_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "ppsh_mp":
				if(!getcvar("scr_allow_ppsh"))
				{
					self iprintln(&"MPSCRIPT_PPSH_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mosin_nagant_sniper_mp":
				if(!getcvar("scr_allow_nagantsniper"))
				{
					self iprintln(&"MPSCRIPT_SCOPED_MOSINNAGANT_IS");
					response = "restricted";
				}
				break;

			case "kar98k_mp":
				if(!getcvar("scr_allow_kar98k"))
				{
					self iprintln(&"MPSCRIPT_KAR98K_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mp40_mp":
				if(!getcvar("scr_allow_mp40"))
				{
					self iprintln(&"MPSCRIPT_MP40_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "mp44_mp":
				if(!getcvar("scr_allow_mp44"))
				{
					self iprintln(&"MPSCRIPT_MP44_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			case "kar98k_sniper_mp":
				if(!getcvar("scr_allow_kar98ksniper"))
				{
					self iprintln(&"MPSCRIPT_SCOPED_KAR98K_IS_A_RESTRICTED");
					response = "restricted";
				}
				break;

			default:
				self iprintln(&"MPSCRIPT_UNKNOWN_WEAPON_SELECTED");
				response = "restricted";
				break;
			}
	return response;
}

quickcommands(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "american_follow_me";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "american_move_in";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "american_fall_back";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "american_suppressing_fire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "american_attack_left_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_LEFT_FLANK";
				//saytext = "Squad, attack left flank!";
				break;

			case "6":
				soundalias = "american_attack_right_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_RIGHT_FLANK";
				//saytext = "Squad, attack right flank!";
				break;

			case "7":
				soundalias = "american_hold_position";
				saytext = &"QUICKMESSAGE_SQUAD_HOLD_THIS_POSITION";
				//saytext = "Squad, hold this position!";
				break;

			case "8":
				temp = randomInt(2);

				if(temp)
				{
					soundalias = "american_regroup";
					saytext = &"QUICKMESSAGE_SQUAD_REGROUP";
					//saytext = "Squad, regroup!";
				}
				else
				{
					soundalias = "american_stick_together";
					saytext = &"QUICKMESSAGE_SQUAD_STICK_TOGETHER";
					//saytext = "Squad, stick together!";
				}
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "british_follow_me";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "british_move_in";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "british_fall_back";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "british_suppressing_fire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "british_attack_left_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_LEFT_FLANK";
				//saytext = "Squad, attack left flank!";
				break;

			case "6":
				soundalias = "british_attack_right_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_RIGHT_FLANK";
				//saytext = "Squad, attack right flank!";
				break;

			case "7":
				soundalias = "british_hold_position";
				saytext = &"QUICKMESSAGE_SQUAD_HOLD_THIS_POSITION";
				//saytext = "Squad, hold this position!";
				break;

			case "8":
				temp = randomInt(2);

				if(temp)
				{
					soundalias = "british_regroup";
					saytext = &"QUICKMESSAGE_SQUAD_REGROUP";
					//saytext = "Squad, regroup!";
				}
				else
				{
					soundalias = "british_stick_together";
					saytext = &"QUICKMESSAGE_SQUAD_STICK_TOGETHER";
					//saytext = "Squad, stick together!";
				}
				break;
			}
			break;

		case "russian":
			switch(response)		
			{
			case "1":
				soundalias = "russian_follow_me";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "russian_move_in";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "russian_fall_back";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "russian_suppressing_fire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "russian_attack_left_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_LEFT_FLANK";
				//saytext = "Squad, attack left flank!";
				break;

			case "6":
				soundalias = "russian_attack_right_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_RIGHT_FLANK";
				//saytext = "Squad, attack right flank!";
				break;

			case "7":
				soundalias = "russian_hold_position";
				saytext = &"QUICKMESSAGE_SQUAD_HOLD_THIS_POSITION";
				//saytext = "Squad, hold this position!";
				break;

			case "8":
				soundalias = "russian_regroup";
				saytext = &"QUICKMESSAGE_SQUAD_REGROUP";
				//saytext = "Squad, regroup!";
				break;
			}
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			switch(response)		
			{
			case "1":
				soundalias = "german_follow_me";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "german_move_in";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "german_fall_back";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "german_suppressing_fire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "german_attack_left_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_LEFT_FLANK";
				//saytext = "Squad, attack left flank!";
				break;

			case "6":
				soundalias = "german_attack_right_flank";
				saytext = &"QUICKMESSAGE_SQUAD_ATTACK_RIGHT_FLANK";
				//saytext = "Squad, attack right flank!";
				break;

			case "7":
				soundalias = "german_hold_position";
				saytext = &"QUICKMESSAGE_SQUAD_HOLD_THIS_POSITION";
				//saytext = "Squad, hold this position!";
				break;

			case "8":
				soundalias = "german_regroup";
				saytext = &"QUICKMESSAGE_SQUAD_REGROUP";
				//saytext = "Squad, regroup!";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();	
}

quickstatements(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;
	
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "american_enemy_spotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "american_enemy_down";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "american_in_position";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "american_area_secure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "american_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "american_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "american_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "8":
				soundalias = "american_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "british_enemy_spotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "british_enemy_down";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "british_in_position";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "british_area_secure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "british_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "british_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "british_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "8":
				soundalias = "british_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;

		case "russian":
			switch(response)		
			{
			case "1":
				soundalias = "russian_enemy_spotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "russian_enemy_down";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "russian_in_position";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "russian_area_secure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "russian_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "russian_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "russian_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "8":
				soundalias = "russian_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			switch(response)		
			{
			case "1":
				soundalias = "german_enemy_spotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "german_enemy_down";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "german_in_position";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "german_area_secure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "german_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "german_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "german_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "8":
				soundalias = "german_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();
}

quickresponses(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "american_yes_sir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "american_no_sir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "american_on_my_way";
				saytext = &"QUICKMESSAGE_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "american_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "american_great_shot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "american_took_long_enough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			case "7":
				temp = randomInt(3);

				if(temp == 0)
				{
					soundalias = "american_youre_crazy";
					saytext = &"QUICKMESSAGE_YOURE_CRAZY";
					//saytext = "You're crazy!";
				}
				else if(temp == 1)
				{
					soundalias = "american_you_outta_your_mind";
					saytext = &"QUICKMESSAGE_YOU_OUTTA_YOUR_MIND";
					//saytext = "You outta your mind?";
				}
				else
				{
					soundalias = "american_youre_nuts";
					saytext = &"QUICKMESSAGE_YOURE_NUTS";
					//saytext = "You're nuts!";
				}
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "british_yes_sir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "british_no_sir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "british_on_my_way";
				saytext = &"QUICKMESSAGE_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "british_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "british_great_shot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "british_took_long_enough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			case "7":
				soundalias = "british_youre_crazy";
				saytext = &"QUICKMESSAGE_YOURE_CRAZY";
				//saytext = "You're crazy!";
				break;
			}
			break;

		case "russian":
			switch(response)		
			{
			case "1":
				soundalias = "russian_yes_sir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "russian_no_sir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "russian_on_my_way";
				saytext = &"QUICKMESSAGE_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "russian_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "russian_great_shot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "russian_took_long_enough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			case "7":
				soundalias = "russian_youre_crazy";
				saytext = &"QUICKMESSAGE_YOURE_CRAZY";
				//saytext = "You're crazy!";
				break;
			}
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			switch(response)		
			{
			case "1":
				soundalias = "german_yes_sir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "german_no_sir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "german_on_my_way";
				saytext = &"QUICKMESSAGE_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "german_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "german_great_shot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "german_took_long_enough";
				saytext = &"QUICKMESSAGE_TOOK_YOU_LONG_ENOUGH";
				//saytext = "Took you long enough!";				
				break;

			case "7":
				soundalias = "german_are_you_crazy";
				saytext = &"QUICKMESSAGE_ARE_YOU_CRAZY";
				//saytext = "Are you crazy?";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();
}

doQuickMessage(soundalias, saytext)
{
	if(self.sessionstate != "playing")
		return;

	if(isdefined(level.QuickMessageToAll) && level.QuickMessageToAll)
	{
		self.headiconteam = "none";
		self.headicon = "gfx/hud/headicon@quickmessage";

		self playSound(soundalias);
		self sayAll(saytext);
	}
	else
	{
		if(self.sessionteam == "allies")
			self.headiconteam = "allies";
		else if(self.sessionteam == "axis")
			self.headiconteam = "axis";
		
		self.headicon = "gfx/hud/headicon@quickmessage";

		self playSound(soundalias);
		self sayTeam(saytext);
		self pingPlayer();
	}
}

saveHeadIcon()
{
	if(isdefined(self.headicon))
		self.oldheadicon = self.headicon;

	if(isdefined(self.headiconteam))
		self.oldheadiconteam = self.headiconteam;
}

restoreHeadIcon()
{
	if(isdefined(self.oldheadicon))
		self.headicon = self.oldheadicon;

	if(isdefined(self.oldheadiconteam))
		self.headiconteam = self.oldheadiconteam;
}

sayMoveIn()
{
	wait 2;
	
	alliedsoundalias = game["allies"] + "_move_in";
	axissoundalias = game["axis"] + "_move_in";

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(player.pers["team"] == "allies")
			player playLocalSound(alliedsoundalias);
		else if(player.pers["team"] == "axis")
			player playLocalSound(axissoundalias);
	}
}

getWeaponName(weapon)
{
	switch(weapon)
	{
	case "m1carbine_mp":
		weaponname = &"WEAPON_M1A1CARBINE";
		break;
		
	case "m1garand_mp":
		weaponname = &"WEAPON_M1GARAND";
		break;
		
	case "thompson_mp":
		weaponname = &"WEAPON_THOMPSON";
		break;
		
	case "bar_mp":
		weaponname = &"WEAPON_BAR";
		break;
		
	case "springfield_mp":
		weaponname = &"WEAPON_SPRINGFIELD";
		break;
		
	case "enfield_mp":
		weaponname = &"WEAPON_LEEENFIELD";
		break;
		
	case "sten_mp":
		weaponname = &"WEAPON_STEN";
		break;
		
	case "bren_mp":
		weaponname = &"WEAPON_BREN";
		break;
		
	case "mosin_nagant_mp":
		weaponname = &"WEAPON_MOSINNAGANT";
		break;
		
	case "ppsh_mp":
		weaponname = &"WEAPON_PPSH";
		break;
		
	case "mosin_nagant_sniper_mp":
		weaponname = &"WEAPON_SCOPEDMOSINNAGANT";
		break;
		
	case "kar98k_mp":
		weaponname = &"WEAPON_KAR98K";
		break;
		
	case "mp40_mp":
		weaponname = &"WEAPON_MP40";
		break;
		
	case "mp44_mp":
		weaponname = &"WEAPON_MP44";
		break;
		
	case "kar98k_sniper_mp":
		weaponname = &"WEAPON_SCOPEDKAR98K";
		break;
		
	default:
		weaponname = &"WEAPON_UNKNOWNWEAPON";
		break;
	}

	return weaponname;
}

useAn(weapon)
{
	switch(weapon)
	{
	case "m1carbine_mp":
	case "m1garand_mp":
	case "mp40_mp":
	case "mp44_mp":
		result = true;
		break;
		
	default:
		result = false;
		break;
	}

	return result;
}