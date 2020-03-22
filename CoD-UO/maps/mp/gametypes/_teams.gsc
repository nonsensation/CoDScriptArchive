
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
	maps\mp\gametypes\_shellshock_gmi::precache(); // Precache shellshock.
	maps\mp\gametypes\_rank_gmi::PrecacheBattleRank(); // Precache rank items.
	maps\mp\gametypes\_secondary_gmi::Precache(); // Precache rank items.

	precacheHeadIcon("gfx/hud/headicon@quickmessage");	//TEMP
	precacheString(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_AMERICAN");
	precacheString(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_BRITISH");
	precacheString(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_RUSSIAN");
	precacheString(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_GERMAN");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_AMERICAN");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_BRITISH");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_RUSSIAN");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_AXIS");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_ALLIED");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_ALLIED2");
	precacheString(&"PATCH_1_3_CANTJOINTEAM_AXIS2");
	precacheString(&"PATCH_1_3_AMERICAN");
	precacheString(&"PATCH_1_3_BRITISH");
	precacheString(&"PATCH_1_3_RUSSIAN");
	
	switch(game["allies"])
	{
	case "american":
		game["headicon_allies"] = "gfx/hud/headicon@american.tga";
		//precacheShader("gfx/hud/hud@mpflag_american.tga");
		precacheItem("fraggrenade_mp");
		precacheItem("smokegrenade_mp");
		precacheItem("flashgrenade_mp");
		precacheItem("colt_mp");
		precacheItem("m1carbine_mp");
		precacheItem("m1garand_mp");
		precacheItem("thompson_mp");
		precacheItem("bar_mp");
		precacheItem("springfield_mp");
		precacheItem("mg30cal_mp");
		precacheItem("binoculars_mp");
		precacheItem("binoculars_artillery_mp");
		precacheItem("satchelcharge_mp");
		break;
	
	case "british":
		game["headicon_allies"] = "gfx/hud/headicon@british.tga";
		//precacheShader("gfx/hud/hud@mpflag_british.tga");
		precacheItem("mk1britishfrag_mp");
		precacheItem("smokegrenade_mp");
		precacheItem("flashgrenade_mp");
		precacheItem("webley_mp");
		precacheItem("enfield_mp");
		precacheItem("sten_mp");
		precacheItem("bren_mp");
		precacheItem("springfield_mp");
		precacheItem("mg30cal_mp");
		precacheItem("binoculars_mp");
		precacheItem("binoculars_artillery_mp");
		precacheItem("satchelcharge_mp");
		break;
	
	case "russian":
		game["headicon_allies"] = "gfx/hud/headicon@russian.tga";
		//precacheShader("gfx/hud/hud@mpflag_russian.tga");
		precacheItem("rgd-33russianfrag_mp");
		precacheItem("smokegrenade_mp");
		precacheItem("flashgrenade_mp");
		precacheItem("tt33_mp");
		precacheItem("mosin_nagant_mp");
		precacheItem("svt40_mp");
		precacheItem("ppsh_mp");
		precacheItem("mosin_nagant_sniper_mp");
		precacheItem("dp28_mp");
		precacheItem("binoculars_mp");
		precacheItem("binoculars_artillery_mp");
		precacheItem("satchelcharge_mp");
		break;
	}

	switch(game["axis"])
	{
	case "german":
		game["headicon_axis"] = "gfx/hud/headicon@german.tga";
		//precacheShader("gfx/hud/hud@mpflag_german.tga");
		precacheItem("stielhandgranate_mp");
		precacheItem("smokegrenade_mp");
		precacheItem("flashgrenade_mp");
		precacheItem("luger_mp");
		precacheItem("kar98k_mp");
		precacheItem("gewehr43_mp");
		precacheItem("mp40_mp");
		precacheItem("mp44_mp");
		precacheItem("kar98k_sniper_mp");
		precacheItem("mg34_mp");
		precacheItem("binoculars_mp");
		precacheItem("binoculars_artillery_mp");
		precacheItem("satchelcharge_mp");
		break;
	}
	
	precacheHeadIcon(game["headicon_allies"]);
	precacheHeadIcon(game["headicon_axis"]);

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
	level.hostname = getCvar("sv_hostname");
	if(level.hostname == "")
		level.hostname = "CoDHost";
	setCvar("sv_hostname", level.hostname);
	setCvar("ui_hostname", level.hostname);
	makeCvarServerInfo("ui_hostname", "CoDHost");

	level.motd = getCvar("scr_motd");
	if(level.motd == "")
		level.motd = "";
	setCvar("scr_motd", level.motd);
	setCvar("ui_motd", level.motd);
	makeCvarServerInfo("ui_motd", "");

	level.allowvote = getCvar("g_allowvote");
	if(level.allowvote == "")
		level.allowvote = "1";
	setCvar("g_allowvote", level.allowvote);
	setCvar("ui_allowvote", level.allowvote);
	makeCvarServerInfo("ui_allowvote", "1");

	level.allowvotemaprestart = getCvar("g_allowvotemaprestart");
	if(level.allowvotemaprestart == "")
		level.allowvotemaprestart = "1";
	setCvar("g_allowvotemaprestart", level.allowvotemaprestart);
	setCvar("ui_allowvotemaprestart", level.allowvotemaprestart);
	makeCvarServerInfo("ui_allowvotemaprestart", "1");

	level.allowvotemaprotate = getCvar("g_allowvotemaprotate");
	if(level.allowvotemaprotate == "")
		level.allowvotemaprotate = "1";
	setCvar("g_allowvotemaprotate", level.allowvotemaprotate);
	setCvar("ui_allowvotemaprotate", level.allowvotemaprotate);
	makeCvarServerInfo("ui_allowvotemaprotate", "1");

	level.allowvotemap = getCvar("g_allowvotemap");
	if(level.allowvotemap == "")
		level.allowvotemap = "1";
	setCvar("g_allowvotemap", level.allowvotemap);
	setCvar("ui_allowvotemap", level.allowvotemap);
	makeCvarServerInfo("ui_allowvotemap", "1");

	level.allowvotetypemap = getCvar("g_allowvotetypemap");
	if(level.allowvotetypemap == "")
		level.allowvotetypemap = "1";
	setCvar("g_allowvotetypemap", level.allowvotetypemap);
	setCvar("ui_allowvotetypemap", level.allowvotetypemap);
	makeCvarServerInfo("ui_allowvotetypemap", "1");

	level.allowvotekick = getCvar("g_allowvotekick");
	if(level.allowvotekick == "")
		level.allowvotekick = "1";
	setCvar("g_allowvotekick", level.allowvotekick);
	setCvar("ui_allowvotekick", level.allowvotekick);
	makeCvarServerInfo("ui_allowvotekick", "1");

	level.allowvotetempbanuser = getCvar("g_allowvotetempbanuser");
	if(level.allowvotetempbanuser == "")
		level.allowvotetempbanuser = "1";
	setCvar("g_allowvotetempbanuser", level.allowvotetempbanuser);
	setCvar("ui_allowvotetempbanuser", level.allowvotetempbanuser);
	makeCvarServerInfo("ui_allowvotetempbanuser", "1");

	level.friendlyfire = getCvar("scr_friendlyfire");
	if(level.friendlyfire == "")
		level.friendlyfire = "0";
	setCvar("scr_friendlyfire", level.friendlyfire, true);
	setCvar("ui_friendlyfire", level.friendlyfire);
	makeCvarServerInfo("ui_friendlyfire", "0");
	
	level.vehicle_limit = 60;	// a few short of the actual limit, to be safe
}

initWeaponCvars()
{
	level.allow_m1carbine = getCvar("scr_allow_m1carbine");
	if(level.allow_m1carbine == "")
		level.allow_m1carbine = "1";
	setCvar("scr_allow_m1carbine", level.allow_m1carbine);
	setCvar("ui_allow_m1carbine", level.allow_m1carbine);
	makeCvarServerInfo("ui_allow_m1carbine", "1");

	level.allow_m1garand = getCvar("scr_allow_m1garand");
	if(level.allow_m1garand == "")
		level.allow_m1garand = "1";
	setCvar("scr_allow_m1garand", level.allow_m1garand);
	setCvar("ui_allow_m1garand", level.allow_m1garand);
	makeCvarServerInfo("ui_allow_m1garand", "1");

	level.allow_thompson = getCvar("scr_allow_thompson");
	if(level.allow_thompson == "")
		level.allow_thompson = "1";
	setCvar("scr_allow_thompson", level.allow_thompson);
	setCvar("ui_allow_thompson", level.allow_thompson);
	makeCvarServerInfo("ui_allow_thompson", "1");

	level.allow_bar = getCvar("scr_allow_bar");
	if(level.allow_bar == "")
		level.allow_bar = "1";
	setCvar("scr_allow_bar", level.allow_bar);
	setCvar("ui_allow_bar", level.allow_bar);
	makeCvarServerInfo("ui_allow_bar", "1");

	level.allow_springfield = getCvar("scr_allow_springfield");
	if(level.allow_springfield == "")
		level.allow_springfield = "1";
	setCvar("scr_allow_springfield", level.allow_springfield);
	setCvar("ui_allow_springfield", level.allow_springfield);
	makeCvarServerInfo("ui_allow_springfield", "1");

	level.allow_mg30cal = getCvar("scr_allow_mg30cal");
	if(level.allow_mg30cal == "")
		level.allow_mg30cal = "1";
	setCvar("scr_allow_mg30cal", level.allow_mg30cal);
	setCvar("ui_allow_mg30cal", level.allow_mg30cal);
	makeCvarServerInfo("ui_allow_mg30cal", "1");

	level.allow_enfield = getCvar("scr_allow_enfield");
	if(level.allow_enfield == "")
		level.allow_enfield = "1";
	setCvar("scr_allow_enfield", level.allow_enfield);
	setCvar("ui_allow_enfield", level.allow_enfield);
	makeCvarServerInfo("ui_allow_enfield", "1");

	level.allow_sten = getCvar("scr_allow_sten");
	if(level.allow_sten == "")
		level.allow_sten = "1";
	setCvar("scr_allow_sten", level.allow_sten);
	setCvar("ui_allow_sten", level.allow_sten);
	makeCvarServerInfo("ui_allow_sten", "1");

	level.allow_bren = getCvar("scr_allow_bren");
	if(level.allow_bren == "")
		level.allow_bren = "1";
	setCvar("scr_allow_bren", level.allow_bren);
	setCvar("ui_allow_bren", level.allow_bren);
	makeCvarServerInfo("ui_allow_bren", "1");

	level.allow_nagant = getCvar("scr_allow_nagant");
	if(level.allow_nagant == "")
		level.allow_nagant = "1";
	setCvar("scr_allow_nagant", level.allow_nagant);
	setCvar("ui_allow_nagant", level.allow_nagant);
	makeCvarServerInfo("ui_allow_nagant", "1");
	
	level.allow_svt40 = getCvar("scr_allow_svt40");
	if(level.allow_svt40 == "")
		level.allow_svt40 = "1";
	setCvar("scr_allow_svt40", level.allow_svt40);
	setCvar("ui_allow_svt40", level.allow_svt40);
	makeCvarServerInfo("ui_allow_svt40", "1");

	level.allow_ppsh = getCvar("scr_allow_ppsh");
	if(level.allow_ppsh == "")
		level.allow_ppsh = "1";
	setCvar("scr_allow_ppsh", level.allow_ppsh);
	setCvar("ui_allow_ppsh", level.allow_ppsh);
	makeCvarServerInfo("ui_allow_ppsh", "1");

	level.allow_nagantsniper = getCvar("scr_allow_nagantsniper");
	if(level.allow_nagantsniper == "")
		level.allow_nagantsniper = "1";
	setCvar("scr_allow_nagantsniper", level.allow_nagantsniper);
	setCvar("ui_allow_nagantsniper", level.allow_nagantsniper);
	makeCvarServerInfo("ui_allow_nagantsniper", "1");

	level.allow_dp28 = getCvar("scr_allow_dp28");
	if(level.allow_dp28 == "")
		level.allow_dp28 = "1";
	setCvar("scr_allow_dp28", level.allow_dp28);
	setCvar("ui_allow_dp28", level.allow_dp28);
	makeCvarServerInfo("ui_allow_dp28", "1");

	level.allow_kar98k = getCvar("scr_allow_kar98k");
	if(level.allow_kar98k == "")
		level.allow_kar98k = "1";
	setCvar("scr_allow_kar98k", level.allow_kar98k);
	setCvar("ui_allow_kar98k", level.allow_kar98k);
	makeCvarServerInfo("ui_allow_kar98k", "1");

	level.allow_gewehr43 = getCvar("scr_allow_gewehr43");
	if(level.allow_gewehr43 == "")
		level.allow_gewehr43 = "1";
	setCvar("scr_allow_gewehr43", level.allow_gewehr43);
	setCvar("ui_allow_gewehr43", level.allow_gewehr43);
	makeCvarServerInfo("ui_allow_gewehr43", "1");

	level.allow_mp40 = getCvar("scr_allow_mp40");
	if(level.allow_mp40 == "")
		level.allow_mp40 = "1";
	setCvar("scr_allow_mp40", level.allow_mp40);
	setCvar("ui_allow_mp40", level.allow_mp40);
	makeCvarServerInfo("ui_allow_mp40", "1");

	level.allow_mp44 = getCvar("scr_allow_mp44");
	if(level.allow_mp44 == "")
		level.allow_mp44 = "1";
	setCvar("scr_allow_mp44", level.allow_mp44);
	setCvar("ui_allow_mp44", level.allow_mp44);
	makeCvarServerInfo("ui_allow_mp44", "1");

	level.allow_kar98ksniper = getCvar("scr_allow_kar98ksniper");
	if(level.allow_kar98ksniper == "")
		level.allow_kar98ksniper = "1";
	setCvar("scr_allow_kar98ksniper", level.allow_kar98ksniper);
	setCvar("ui_allow_kar98ksniper", level.allow_kar98ksniper);
	makeCvarServerInfo("ui_allow_kar98ksniper", "1");

	level.allow_mg34 = getCvar("scr_allow_mg34");
	if(level.allow_mg34 == "")
		level.allow_mg34 = "1";
	setCvar("scr_allow_mg34", level.allow_mg34);
	setCvar("ui_allow_mg34", level.allow_mg34);
	makeCvarServerInfo("ui_allow_mg34", "1");

	level.allow_fg42 = getCvar("scr_allow_fg42");
	if(level.allow_fg42 == "")
		level.allow_fg42 = "0";
	setCvar("scr_allow_fg42", level.allow_fg42);
	setCvar("ui_allow_fg42", level.allow_fg42);
	makeCvarServerInfo("ui_allow_fg42", "0");

	level.allow_panzerfaust = getCvar("scr_allow_panzerfaust");
	if(level.allow_panzerfaust == "")
		level.allow_panzerfaust = "1";
	setCvar("scr_allow_panzerfaust", level.allow_panzerfaust);
	setCvar("ui_allow_panzerfaust", level.allow_panzerfaust);
	makeCvarServerInfo("ui_allow_panzerfaust", "1");

	level.allow_bazooka = getCvar("scr_allow_bazooka");
	if(level.allow_bazooka == "")
		level.allow_bazooka = "1";
	setCvar("scr_allow_bazooka", level.allow_bazooka);
	setCvar("ui_allow_bazooka", level.allow_bazooka);
	makeCvarServerInfo("ui_allow_bazooka", "1");

	level.allow_panzerschreck = getCvar("scr_allow_panzerschreck");
	if(level.allow_panzerschreck == "")
		level.allow_panzerschreck = "1";
	setCvar("scr_allow_panzerschreck", level.allow_panzerschreck);
	setCvar("ui_allow_panzerschreck", level.allow_panzerschreck);
	makeCvarServerInfo("ui_allow_panzerschreck", "1");

	level.allow_flamethrower = getCvar("scr_allow_flamethrower");
	if(level.allow_flamethrower == "")
		level.allow_flamethrower = "1";
	setCvar("scr_allow_flamethrower", level.allow_flamethrower);
	setCvar("ui_allow_flamethrower", level.allow_flamethrower);
	makeCvarServerInfo("ui_allow_flamethrower", "1");

	level.allow_binoculars = getCvar("scr_allow_binoculars");
	if(level.allow_binoculars == "")
		level.allow_binoculars = "1";
	setCvar("scr_allow_binoculars", level.allow_binoculars);
	setCvar("ui_allow_binoculars", level.allow_binoculars);
	makeCvarServerInfo("ui_allow_binoculars", "1");

	level.allow_artillery = getCvar("scr_allow_artillery");
	if(level.allow_artillery == "")
		level.allow_artillery = "1";
	setCvar("scr_allow_artillery", level.allow_artillery);
	setCvar("ui_allow_artillery", level.allow_artillery);
	makeCvarServerInfo("ui_allow_artillery", "1");

	level.allow_satchel = getCvar("scr_allow_satchel");
	if(level.allow_satchel == "")
		level.allow_satchel = "1";
	setCvar("scr_allow_satchel", level.allow_satchel);
	setCvar("ui_allow_satchel", level.allow_satchel);
	makeCvarServerInfo("ui_allow_satchel", "1");

	level.allow_grenades = getCvar("scr_allow_grenades");
	if(level.allow_grenades == "")
		level.allow_grenades = "1";
	setCvar("scr_allow_grenades", level.allow_grenades);
	setCvar("ui_allow_grenades", level.allow_grenades);
	makeCvarServerInfo("ui_allow_grenades", "1");

	level.allow_smoke = getCvar("scr_allow_smoke");
	if(level.allow_smoke == "")
		level.allow_smoke = "1";
	setCvar("scr_allow_smoke", level.allow_smoke);
	setCvar("ui_allow_smoke", level.allow_smoke);
	makeCvarServerInfo("ui_allow_smoke", "1");

	level.allow_pistols = getCvar("scr_allow_pistols");
	if(level.allow_pistols == "")
		level.allow_pistols = "1";
	setCvar("scr_allow_pistols", level.allow_pistols);
	setCvar("ui_allow_pistols", level.allow_pistols);
	makeCvarServerInfo("ui_allow_pistols", "1");

}

updateGlobalCvars()
{
	for(;;)
	{
		sv_hostname = getCvar("sv_hostname");
		if(level.hostname != sv_hostname)
		{
			level.hostname = sv_hostname;
			setCvar("ui_hostname", level.hostname);
		}

		scr_motd = getCvar("scr_motd");
		if(level.motd != scr_motd)
		{
			level.motd = scr_motd;
			setCvar("ui_motd", level.motd);
		}

		g_allowvote = getCvar("g_allowvote");
		if(level.allowvote != g_allowvote)
		{
			level.allowvote = g_allowvote;
			setCvar("ui_allowvote", level.allowvote);
		}
		
		g_allowvotemaprestart = getCvar("g_allowvotemaprestart");
		if(level.allowvotemaprestart != g_allowvotemaprestart)
		{
			level.allowvotemaprestart = g_allowvotemaprestart;
			setCvar("ui_allowvotemaprestart", level.allowvotemaprestart);
		}
		
		g_allowvotemaprotate = getCvar("g_allowvotemaprotate");
		if(level.allowvotemaprotate != g_allowvotemaprotate)
		{
			level.allowvotemaprotate = g_allowvotemaprotate;
			setCvar("ui_allowvotemaprotate", level.allowvotemaprotate);
		}
		
		g_allowvotemap = getCvar("g_allowvotemap");
		if(level.allowvotemap != g_allowvotemap)
		{
			level.allowvotemap = g_allowvotemap;
			setCvar("ui_allowvotemap", level.allowvotemap);
		}
		
		g_allowvotetypemap = getCvar("g_allowvotetypemap");
		if(level.allowvotetypemap != g_allowvotetypemap)
		{
			level.allowvotetypemap = g_allowvotetypemap;
			setCvar("ui_allowvotetypemap", level.allowvotetypemap);
		}
		
		g_allowvotekick = getCvar("g_allowvotekick");
		if(level.allowvotekick != g_allowvotekick)
		{
			level.allowvotekick = g_allowvotekick;
			setCvar("ui_allowvotekick", level.allowvotekick);
		}
		
		g_allowvotetempbanuser = getCvar("g_allowvotetempbanuser");
		if(level.allowvotetempbanuser != g_allowvotetempbanuser)
		{
			level.allowvotetempbanuser = g_allowvotetempbanuser;
			setCvar("ui_allowvotetempbanuser", level.allowvotetempbanuser);
		}
		
		scr_friendlyfire = getCvar("scr_friendlyfire");
		if(level.friendlyfire != scr_friendlyfire)
		{
			level.friendlyfire = scr_friendlyfire;
			setCvar("ui_friendlyfire", level.friendlyfire);
		}

		wait 5;
	}
}

updateWeaponCvars()
{
	for(;;)
	{
		scr_allow_m1carbine = getCvar("scr_allow_m1carbine");
		if(level.allow_m1carbine != scr_allow_m1carbine)
		{
			level.allow_m1carbine = scr_allow_m1carbine;
			setCvar("ui_allow_m1carbine", level.allow_m1carbine);
		}

		scr_allow_m1garand = getCvar("scr_allow_m1garand");
		if(level.allow_m1garand != scr_allow_m1garand)
		{
			level.allow_m1garand = scr_allow_m1garand;
			setCvar("ui_allow_m1garand", level.allow_m1garand);
		}
		
		scr_allow_thompson = getCvar("scr_allow_thompson");
		if(level.allow_thompson != scr_allow_thompson)
		{
			level.allow_thompson = scr_allow_thompson;
			setCvar("ui_allow_thompson", level.allow_thompson);
		}

		scr_allow_bar = getCvar("scr_allow_bar");
		if(level.allow_bar != scr_allow_bar)
		{
			level.allow_bar = scr_allow_bar;
			setCvar("ui_allow_bar", level.allow_bar);
		}

		scr_allow_springfield = getCvar("scr_allow_springfield");
		if(level.allow_springfield != scr_allow_springfield)
		{
			level.allow_springfield = scr_allow_springfield;
			setCvar("ui_allow_springfield", level.allow_springfield);
		}

		scr_allow_mg30cal = getCvar("scr_allow_mg30cal");
		if(level.allow_mg30cal != scr_allow_mg30cal)
		{
			level.allow_mg30cal = scr_allow_mg30cal;
			setCvar("ui_allow_mg30cal", level.allow_mg30cal);
		}

		scr_allow_enfield = getCvar("scr_allow_enfield");
		if(level.allow_enfield != scr_allow_enfield)
		{
			level.allow_enfield = scr_allow_enfield;
			setCvar("ui_allow_enfield", level.allow_enfield);
		}

		scr_allow_sten = getCvar("scr_allow_sten");
		if(level.allow_sten != scr_allow_sten)
		{
			level.allow_sten = scr_allow_sten;
			setCvar("ui_allow_sten", level.allow_sten);
		}

		scr_allow_bren = getCvar("scr_allow_bren");
		if(level.allow_bren != scr_allow_bren)
		{
			level.allow_bren = scr_allow_bren;
			setCvar("ui_allow_bren", level.allow_bren);
		}

		scr_allow_nagant = getCvar("scr_allow_nagant");
		if(level.allow_nagant != scr_allow_nagant)
		{
			level.allow_nagant = scr_allow_nagant;
			setCvar("ui_allow_nagant", level.allow_nagant);
		}

		scr_allow_svt40 = getCvar("scr_allow_svt40");
		if(level.allow_svt40 != scr_allow_svt40)
		{
			level.allow_svt40 = scr_allow_svt40;
			setCvar("ui_allow_svt40", level.allow_svt40);
		}

		scr_allow_ppsh = getCvar("scr_allow_ppsh");
		if(level.allow_ppsh != scr_allow_ppsh)
		{
			level.allow_ppsh = scr_allow_ppsh;
			setCvar("ui_allow_ppsh", level.allow_ppsh);
		}

		scr_allow_nagantsniper = getCvar("scr_allow_nagantsniper");
		if(level.allow_nagantsniper != scr_allow_nagantsniper)
		{
			level.allow_nagantsniper = scr_allow_nagantsniper;
			setCvar("ui_allow_nagantsniper", level.allow_nagantsniper);
		}

		scr_allow_dp28 = getCvar("scr_allow_dp28");
		if(level.allow_dp28 != scr_allow_dp28)
		{
			level.allow_dp28 = scr_allow_dp28;
			setCvar("ui_allow_dp28", level.allow_dp28);
		}

		scr_allow_kar98k = getCvar("scr_allow_kar98k");
		if(level.allow_kar98k != scr_allow_kar98k)
		{
			level.allow_kar98k = scr_allow_kar98k;
			setCvar("ui_allow_kar98k", level.allow_kar98k);
		}

		scr_allow_gewehr43 = getCvar("scr_allow_gewehr43");
		if(level.allow_gewehr43 != scr_allow_gewehr43)
		{
			level.allow_gewehr43 = scr_allow_gewehr43;
			setCvar("ui_allow_gewehr43", level.allow_gewehr43);
		}

		scr_allow_mp40 = getCvar("scr_allow_mp40");
		if(level.allow_mp40 != scr_allow_mp40)
		{
			level.allow_mp40 = scr_allow_mp40;
			setCvar("ui_allow_mp40", level.allow_mp40);
		}

		scr_allow_mp44 = getCvar("scr_allow_mp44");
		if(level.allow_mp44 != scr_allow_mp44)
		{
			level.allow_mp44 = scr_allow_mp44;
			setCvar("ui_allow_mp44", level.allow_mp44);
		}

		scr_allow_kar98ksniper = getCvar("scr_allow_kar98ksniper");
		if(level.allow_kar98ksniper != scr_allow_kar98ksniper)
		{
			level.allow_kar98ksniper = scr_allow_kar98ksniper;
			setCvar("ui_allow_kar98ksniper", level.allow_kar98ksniper);
		}

		scr_allow_mg34 = getCvar("scr_allow_mg34");
		if(level.allow_mg34 != scr_allow_mg34)
		{
			level.allow_mg34 = scr_allow_mg34;
			setCvar("ui_allow_mg34", level.allow_mg34);
		}

		scr_allow_fg42 = getCvar("scr_allow_fg42");
		if(level.allow_fg42 != scr_allow_fg42)
		{
			level.allow_fg42 = scr_allow_fg42;
			setCvar("ui_allow_fg42", level.allow_fg42);
		}

		scr_allow_panzerfaust = getCvar("scr_allow_panzerfaust");
		if(level.allow_panzerfaust != scr_allow_panzerfaust)
		{
			level.allow_panzerfaust = scr_allow_panzerfaust;
			setCvar("ui_allow_panzerfaust", level.allow_panzerfaust);
		}

		scr_allow_panzerschreck = getCvar("scr_allow_panzerschreck");
		if(level.allow_panzerschreck != scr_allow_panzerschreck)
		{
			level.allow_panzerschreck = scr_allow_panzerschreck;
			setCvar("ui_allow_panzerschreck", level.allow_panzerschreck);
		}

		scr_allow_bazooka = getCvar("scr_allow_bazooka");
		if(level.allow_bazooka != scr_allow_bazooka)
		{
			level.allow_bazooka = scr_allow_bazooka;
			setCvar("ui_allow_bazooka", level.allow_bazooka);
		}

		scr_allow_flamethrower = getCvar("scr_allow_flamethrower");
		if(level.allow_flamethrower != scr_allow_flamethrower)
		{
			level.allow_flamethrower = scr_allow_flamethrower;
			setCvar("ui_allow_flamethrower", level.allow_flamethrower);
		}

		scr_allow_binoculars = getCvar("scr_allow_binoculars");
		if(level.allow_binoculars != scr_allow_binoculars)
		{
			level.allow_binoculars = scr_allow_binoculars;
			setCvar("ui_allow_binoculars", level.allow_binoculars);
		}

		scr_allow_artillery = getCvar("scr_allow_artillery");
		if(level.allow_artillery != scr_allow_artillery)
		{
			level.allow_artillery = scr_allow_artillery;
			setCvar("ui_allow_artillery", level.allow_artillery);
		}

		scr_allow_satchel = getCvar("scr_allow_satchel");
		if(level.allow_satchel != scr_allow_satchel)
		{
			level.allow_satchel = scr_allow_satchel;
			setCvar("ui_allow_satchel", level.allow_satchel);
		}

		scr_allow_smoke = getCvar("scr_allow_smoke");
		if(level.allow_smoke != scr_allow_smoke)
		{
			level.allow_smoke = scr_allow_smoke;
			setCvar("ui_allow_smoke", level.allow_smoke);
		}

		scr_allow_grenades = getCvar("scr_allow_grenades");
		if(level.allow_grenades != scr_allow_grenades)
		{
			level.allow_grenades = scr_allow_grenades;
			setCvar("ui_allow_grenades", level.allow_grenades);
		}

		scr_allow_pistols = getCvar("scr_allow_pistols");
		if(level.allow_pistols != scr_allow_pistols)
		{
			level.allow_pistols = scr_allow_pistols;
			setCvar("ui_allow_pistols", level.allow_pistols);
		}

		wait 5;
	}
}

restrictPlacedWeapons()
{
	if(level.allow_m1carbine != "1")
		deletePlacedEntity("mpweapon_m1carbine");
	if(level.allow_m1garand != "1")
		deletePlacedEntity("mpweapon_m1garand");
	if(level.allow_thompson != "1")
		deletePlacedEntity("mpweapon_thompson");
	if(level.allow_bar != "1")
		deletePlacedEntity("mpweapon_bar");
	if(level.allow_springfield != "1")
		deletePlacedEntity("mpweapon_springfield");
	if(level.allow_mg30cal != "1")
		deletePlacedEntity("mpweapon_mg30cal");
	if(level.allow_enfield != "1")
		deletePlacedEntity("mpweapon_enfield");
	if(level.allow_sten != "1")
		deletePlacedEntity("mpweapon_sten");
	if(level.allow_bren != "1")
		deletePlacedEntity("mpweapon_bren");
	if(level.allow_nagant != "1")
		deletePlacedEntity("mpweapon_mosinnagant");
	if(level.allow_svt40 != "1")
		deletePlacedEntity("mpweapon_svt40");
	if(level.allow_ppsh != "1")
		deletePlacedEntity("mpweapon_ppsh");
	if(level.allow_nagantsniper != "1")
		deletePlacedEntity("mpweapon_mosinnagantsniper");
	if(level.allow_dp28 != "1")
		deletePlacedEntity("mpweapon_dp28");
	if(level.allow_kar98k != "1")
		deletePlacedEntity("mpweapon_kar98k");
	if(level.allow_gewehr43 != "1")
		deletePlacedEntity("mpweapon_gewehr43");
	if(level.allow_mp40 != "1")
		deletePlacedEntity("mpweapon_mp40");
	if(level.allow_mp44 != "1")
		deletePlacedEntity("mpweapon_mp44");
	if(level.allow_kar98ksniper != "1")
		deletePlacedEntity("mpweapon_kar98ksniper");
	if(level.allow_mg34 != "1")
		deletePlacedEntity("mpweapon_mg34");
	if(level.allow_fg42 != "1")
		deletePlacedEntity("mpweapon_fg42");
	if(level.allow_panzerfaust != "1")
		deletePlacedEntity("mpweapon_panzerfaust");
	if(level.allow_panzerschreck != "1")
		deletePlacedEntity("mpweapon_panzerschreck");
	if(level.allow_bazooka != "1")
		deletePlacedEntity("mpweapon_bazooka");
	if(level.allow_flamethrower != "1")
		deletePlacedEntity("mpweapon_flamethrower");
	if(level.allow_binoculars != "1")
		deletePlacedEntity("mpweapon_binoculars");
	if(level.allow_artillery != "1")
		deletePlacedEntity("mpweapon_binoculars_artillery");
	if(level.allow_satchel != "1")
		deletePlacedEntity("mpweapon_satchelcharge");
	// Need to not automatically give these to players if I allow restricting them
	// colt_mp
	// luger_mp
	// fraggrenade_mp
	// mk1britishfrag_mp
	// rgd-33russianfrag_mp
	// stielhandgranate_mp
	// smokegrenade_mp
	// flashgrenade_mp
	// binoculars_mp
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

givePistol()
{
	self takeWeapon("colt_mp");
	self takeWeapon("luger_mp");
	self takeWeapon("webley_mp");
	self takeWeapon("tt33_mp");
	
	if ( !level.allow_pistols )
		return;
		
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			pistoltype = "colt_mp";
			break;

		case "british":
			pistoltype = "webley_mp";
			break;

		case "russian":
			pistoltype = "tt33_mp";			
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			pistoltype = "luger_mp";			
			break;
		}			
	}

	// clear out all ammo
	self setWeaponSlotAmmo("pistol", 0 );
	self setWeaponSlotClipAmmo("pistol", 0 );
	
	clip_size = getfullclipammo(pistoltype);
	ammount = maps\mp\gametypes\_loadout_gmi::GetPistolAmmo(pistoltype);
	
	self giveWeapon(pistoltype);

	if ( ammount > clip_size )
	{
		self setWeaponSlotClipAmmo("pistol", clip_size );
		self setWeaponSlotAmmo("pistol", ammount - clip_size );
	}
	else
	{
		self setWeaponSlotClipAmmo("pistol", ammount );
	}
}

giveSmokeGrenades(spawnweapon)
{
	self takeWeapon("smokegrenade_mp");
	self takeWeapon("flashgrenade_mp");
	
	if ( !level.allow_smoke )
		return;
			
//	if (getcvarint("sv_night") == 0)
	{
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])		
			{
			case "american":
				grenadetype = "smokegrenade_mp";
				break;
	
			case "british":
				grenadetype = "smokegrenade_mp";
				break;
	
			case "russian":
				grenadetype = "smokegrenade_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				grenadetype = "smokegrenade_mp";
				break;
			}			
		}
	}
//	else
//	{
//		if(self.pers["team"] == "allies")
//		{
//			switch(game["allies"])		
//			{
//			case "american":
//				grenadetype = "flashgrenade_mp";
//				break;
//	
//			case "british":
//				grenadetype = "flashgrenade_mp";
//				break;
//	
//			case "russian":
//				grenadetype = "flashgrenade_mp";
//				break;
//			}
//		}
//		else if(self.pers["team"] == "axis")
//		{
//			switch(game["axis"])
//			{
//			case "german":
//				grenadetype = "flashgrenade_mp";
//				break;
//			}			
//		}
//	}

	count = getWeaponBasedSmokeGrenadeCount(spawnweapon);

	if ( count )
	{
		self setWeaponSlotWeapon("smokegrenade", grenadetype);
		self setWeaponSlotClipAmmo("smokegrenade",  count);
	}
}

getWeaponBasedSmokeGrenadeCount(weapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::getWeaponBasedSmokeGrenadeCount(weapon);
	}
	
	switch(weapon)
	{
	case "m1carbine_mp":
	case "m1garand_mp":
	case "enfield_mp":
	case "mosin_nagant_mp":
	case "svt40_mp":	
	case "kar98k_mp":
	case "gewehr43_mp":	
		return 2;
	case "thompson_mp":
	case "thompson_semi_mp":
	case "sten_mp":
	case "ppsh_mp":
	case "ppsh_semi_mp":
	case "mp40_mp":	
	case "bar_mp":
	case "bar_slow_mp":
	case "bren_mp":
	case "mp44_mp":
	case "mp44_semi_mp":
		return 1;
	case "springfield_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mg30cal_mp":
	case "dp28_mp":
	case "mg34_mp":
		return 0;
	}
}

giveSatchelCharges(spawnweapon)
{
	self takeWeapon("satchelcharge_mp");

	if (!level.allow_satchel)
		return;
	
	count = getWeaponBasedSatchelChargeCount(spawnweapon);
	
	if ( count )
	{
		self setWeaponSlotWeapon("satchel", "satchelcharge_mp");
		self setWeaponSlotClipAmmo("satchel", count);
	}
}

getWeaponBasedSatchelChargeCount(weapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::getWeaponBasedSatchelChargeCount(weapon);
	}
	
	// no satchel charges given if we are not in battle rank mode
	return 0;
}

giveGrenades(spawnweapon)
{
	// for now we should give them the smoke grenades here as well 
	// because this is an easy way to get smoke grenades into all of the game
	// types without having to modify them
	giveSmokeGrenades(spawnweapon);
	giveSatchelCharges(spawnweapon);
	
	if ( !level.allow_grenades )
		return;
		
	self takeWeapon("fraggrenade_mp");
	self takeWeapon("mk1britishfrag_mp");
	self takeWeapon("rgd-33russianfrag_mp");
	self takeWeapon("stielhandgranate_mp");

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			grenadetype = "fraggrenade_mp";
			break;

		case "british":
			grenadetype = "mk1britishfrag_mp";
			break;

		case "russian":
			grenadetype = "rgd-33russianfrag_mp";
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])
		{
		case "german":
			grenadetype = "stielhandgranate_mp";
			break;
		}			
	}

	count = getWeaponBasedGrenadeCount(spawnweapon);
	if( count )
	{
		self setWeaponSlotWeapon("grenade", grenadetype);
		self setWeaponSlotClipAmmo("grenade", count );
	}
}

getWeaponBasedGrenadeCount(weapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::getWeaponBasedGrenadeCount(weapon);
	}

	switch(weapon)
	{
	case "m1carbine_mp":
	case "m1garand_mp":
	case "enfield_mp":
	case "mosin_nagant_mp":
	case "svt40_mp":	
	case "kar98k_mp":
	case "gewehr43_mp":	
		return 3;
	case "thompson_mp":
	case "thompson_semi_mp":
	case "sten_mp":
	case "ppsh_mp":
	case "ppsh_semi_mp":
	case "mp40_mp":	
	case "bar_mp":
	case "bar_slow_mp":
	case "bren_mp":
	case "mp44_mp":
	case "mp44_semi_mp":
		return 2;
	case "springfield_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mg30cal_mp":
	case "dp28_mp":
	case "mg34_mp":
		return 1;
	}
}

isPistolOrGrenade(weapon)
{
	switch(weapon)
	{
	case "colt_mp":
	case "webley_mp":
	case "tt33_mp":
	case "luger_mp":
	case "fraggrenade_mp":
	case "mk1britishfrag_mp":
	case "rgd-33russianfrag_mp":
	case "stielhandgranate_mp":
	case "smokegrenade_mp":
	case "flashgrenade_mp":
		return true;
	default:
		return false;
	}
}

giveBinoculars(spawnweapon)
{
	// if battle rank is on then call the battle rank function
	if ( isDefined(level.battlerank) && level.battlerank)
	{
		return maps\mp\gametypes\_rank_gmi::giveBinoculars(weapon);
	}

	if ( !level.allow_binoculars )
		return;
	
	binoctype = "binoculars_mp";
	
	self takeWeapon("binoculars_mp");
	self takeWeapon("binoculars_artillery_mp");
	
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
				
			case "mg30cal_mp":
				if(!getcvar("scr_allow_mg30cal"))
				{
					self iprintln(&"GMI_WEAPON_30CAL_IS_A_RESTRICTED");
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

			case "mg30cal_mp":
				if(!getcvar("scr_allow_mg30cal"))
				{
					self iprintln(&"GMI_WEAPON_30CAL_IS_A_RESTRICTED");
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

			case "svt40_mp":
				if(!getcvar("scr_allow_svt40"))
				{
					self iprintln(&"GMI_WEAPON_SVT40_IS_A_RESTRICTED");
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

			case "dp28_mp":
				if(!getcvar("scr_allow_dp28"))
				{
					self iprintln(&"GMI_WEAPON_DP28_IS_A_RESTRICTED");
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

			case "gewehr43_mp":
				if(!getcvar("scr_allow_gewehr43"))
				{
					self iprintln(&"GMI_WEAPON_GEWEHR43_IS_A_RESTRICTED");
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

			case "mg34_mp":
				if(!getcvar("scr_allow_mg34"))
				{
					self iprintln(&"GMI_WEAPON_MG34_IS_A_RESTRICTED");
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

			case "mg30cal_mp":
				if(!getcvar("scr_allow_mg30cal"))
				{
					self iprintln(&"GMI_WEAPON_30CAL_IS_A_RESTRICTED");
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

			case "svt40_mp":
				if(!getcvar("scr_allow_svt40"))
				{
					self iprintln(&"GMI_WEAPON_SVT40_IS_A_RESTRICTED");
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

			case "dp28_mp":
				if(!getcvar("scr_allow_dp28"))
				{
					self iprintln(&"GMI_WEAPON_DP28_IS_A_RESTRICTED");
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

			case "gewehr43_mp":
				if(!getcvar("scr_allow_gewehr43"))
				{
					self iprintln(&"GMI_WEAPON_GEWEHR43_IS_A_RESTRICTED");
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

			case "mg34_mp":
				if(!getcvar("scr_allow_mg34"))
				{
					self iprintln(&"GMI_WEAPON_MG34_IS_A_RESTRICTED");
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

purchase_weapon(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	if (!self.supply_available)
	{
		self iprintln(&"PURCHASE_NOT_AVAILABLE");
		return;
	}

	switch(response)		
	{
	case "1":	// anti-tank
	
		cost = level.purchase_cost_antitank;
		
		if (self.supply_credits < cost)
		{
			self iprintln(&"PURCHASE_NOT_ENOUGH_CREDIT");
			break;
		}
		
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])		
			{
			case "american":
				weapontype = "bazooka_mp";
				break;

			case "british":
				weapontype = "bazooka_mp";
				break;

			case "russian":
				weapontype = "panzerfaust_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				weapontype = "panzerschreck_mp";
				break;
			}			
		}
	
		dropitem = self getWeaponSlotWeapon("primaryb");
	
		// do they already have it?
		bestslot = "primaryb";
		
		slot = "primary";
		dropitem = self getWeaponSlotWeapon(slot);
		if (weapontype == dropitem)
		{
			self iprintln(&"PURCHASE_MAXIMUM_REACHED");
			break;
		}
		if (dropitem == "none")
			bestslot = slot;
			
		slot = "primaryb";
		dropitem = self getWeaponSlotWeapon(slot);
		if (weapontype == dropitem)
		{
			self iprintln(&"PURCHASE_MAXIMUM_REACHED");
			break;
		}
		if (dropitem == "none")
			bestslot = slot;
		
		if (dropitem != "none")
		{
			self dropItem( self getWeaponSlotWeapon(bestslot) );
		}
		
		// take their money
		self.supply_credits -= cost;

		// give us the weapon, and some ammo
		self setWeaponSlotWeapon("primaryb", weapontype);
		clip_size = getfullclipammo(weapontype);
		ammount = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(weapontype);
		
		//this will only give up to one full clip in the gun
		self setWeaponSlotClipAmmo("primaryb", ammount);
		if ( ammount > clip_size )
			self setWeaponSlotAmmo("primaryb", ammount - clip_size );
		
		// play a sound so we know we got it
		self playLocalSound("weap_raise");
	
		self iprintln(&"PURCHASE_ANTITANK_SUPPLIED");
		
		break;
		
	case "2":	// Flamethrower
	
		cost = level.purchase_cost_flamethrower;
		
		if (self.supply_credits < cost)
		{
			self iprintln(&"PURCHASE_NOT_ENOUGH_CREDIT");
			break;
		}
		
		weapontype = "flamethrower_mp";
	
		// do they already have it?
		bestslot = "primaryb";
		
		slot = "primary";
		dropitem = self getWeaponSlotWeapon(slot);
		if (weapontype == dropitem)
		{
			self iprintln(&"PURCHASE_MAXIMUM_REACHED");
			break;
		}
		if (dropitem == "none")
			bestslot = slot;
			
		slot = "primaryb";
		dropitem = self getWeaponSlotWeapon(slot);
		if (weapontype == dropitem)
		{
			self iprintln(&"PURCHASE_MAXIMUM_REACHED");
			break;
		}
		if (dropitem == "none")
			bestslot = slot;
		
		if (dropitem != "none")
		{
			self dropItem( self getWeaponSlotWeapon(bestslot) );
		}
		
		// take their money
		self.supply_credits -= cost;

		self setWeaponSlotWeapon("primaryb", weapontype);
		clip_size = getfullclipammo(weapontype);
		ammount = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(weapontype);
		
		//this will only give up to one full clip in the gun
		self setWeaponSlotClipAmmo("primaryb", ammount);
		if ( ammount > clip_size )
			self setWeaponSlotAmmo("primaryb", ammount - clip_size );
		
		// play a sound so we know we got it
		self playLocalSound("weap_raise");

		self iprintln(&"PURCHASE_FLAMETHROWER_SUPPLIED");
	
		break;
	}
}

purchase_ammo(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	if (!self.supply_available)
	{
		self iprintln(&"PURCHASE_NOT_AVAILABLE");
		return;
	}

	switch(response)		
	{
	case "1":	// primary ammo

		cost = level.purchase_cost_primary_ammo;
		slot = "primary";

		ammoweapon = self getWeaponSlotWeapon(slot);
		
		switch (ammoweapon)
		{
		case "flamethrower_mp":
		case "bazooka_mp":
		case "panzerfaust_mp":
		case "panzerschreck_mp":
			self iprintln(&"PURCHASE_AMMO_PRIMARY_INVALID");
			return;
		}
		
		clip_size = getfullclipammo(ammoweapon);
		start_ammo = maps\mp\gametypes\_loadout_gmi::GetGunAmmo(ammoweapon);

		// give whichever is smaller.. clip_size, or start_ammo/3 
		give = start_ammo/3;
		if (clip_size < give)
			give = clip_size;
		if (give <= 1)
			give = 1;
			
		break;
		
	case "2":	// pistol ammo

		cost = level.purchase_cost_pistol_ammo;
		slot = "pistol";

		ammoweapon = self getWeaponSlotWeapon(slot);
		
		// pistol gets fixed amount
		give = 999;

		break;
		
	case "3":	// hand grenade
	
		cost = level.purchase_cost_handgrenade;
		slot = "grenade";
		
		ammoweapon = self getWeaponSlotWeapon(slot);
		
		if (ammoweapon == "none")
		{
			if(self.pers["team"] == "allies")
			{
				switch(game["allies"])		
				{
				case "american":
					ammoweapon = "fraggrenade_mp";
					break;

				case "british":
					ammoweapon = "mk1britishfrag_mp";
					break;

				case "russian":
					ammoweapon = "rgd-33russianfrag_mp";
					break;
				}
			}
			else if(self.pers["team"] == "axis")
			{
				switch(game["axis"])
				{
				case "german":
					ammoweapon = "stielhandgranate_mp";
					break;
				}			
			}
			
			self setWeaponSlotWeapon(slot, ammoweapon);
		}
		
		give = 1;		
		
		break;
		
	case "4":	// smoke grenade
	
		cost = level.purchase_cost_handgrenade;
		slot = "smokegrenade";
		ammoweapon = "smokegrenade_mp";
		self setWeaponSlotWeapon(slot, ammoweapon);
		give = 1;		
		
		break;
		
	case "5":	// flamethrower fuel
	
		cost = level.purchase_cost_flamethrower_ammo;
		slot = "primaryb";
		ammoweapon = "flamethrower_mp";
		if (self getWeaponSlotWeapon( slot ) != ammoweapon)
		{
			slot = "primary";
			if (self getWeaponSlotWeapon( slot ) != ammoweapon)
			{
				self iprintln(&"PURCHASE_AMMO_UNUSABLE_FLAMETHROWER");
				return;
			}
		}
		self setWeaponSlotWeapon(slot, ammoweapon);
		give = 150;
		
		break;
		
	case "6":	// anti-tank ammo
	
		cost = level.purchase_cost_antitank_ammo;
		slot = "primary";
		found = 0;
		
		for (i=0; i<2; i++)
		{
			ammoweapon = self getWeaponSlotWeapon( slot );
			switch (ammoweapon)
			{
			case "panzerschreck_mp":
			case "bazooka_mp":
			case "panzerfaust_mp":
				found = 1;
				break;
			default:
				slot = "primaryb";
			}
		}
		
		if (!found)
		{
			self iprintln(&"PURCHASE_AMMO_UNUSABLE_ANTITANK");
			return;
		}
		
		give = 1;		
		
		break;
		
	case "7":	// anti-tank satchel
	
		cost = level.purchase_cost_antitank_satchel;
		slot = "satchel";
		ammoweapon = "satchelcharge_mp";
		self setWeaponSlotWeapon(slot, ammoweapon);
		give = 1;		

		break;
		
	default:
		return;
	}
		
	// fall down to here to give the ammo
		
	if (ammoweapon == "none")
	{
		self iprintln(&"PURCHASE_AMMO_PRIMARY_EMPTY");
		return;
	}
	
	//this will only give up to one full clip in the gun
	if (slot == "grenade" || slot == "smokegrenade")
	{
		got = self getWeaponSlotClipAmmo(slot);
		self setWeaponSlotClipAmmo(slot, give + got );
		got_after = self getWeaponSlotClipAmmo(slot);
	} else
	{
		got = self getWeaponSlotAmmo(slot);
		self setWeaponSlotAmmo(slot, give + got );
		got_after = self getWeaponSlotAmmo(slot);
	}

	// if they didnt recieve any ammo, then dont charge them
	if (got == got_after)
	{
		self iprintln(&"PURCHASE_AMMO_MAX_LIMIT");
		return;
	}
	
	// take their money
	self.supply_credits -= cost;
	
	// play a sound so we know we got it
	self playLocalSound("weap_raise");
	
	self iprintln(&"PURCHASE_AMMO_SUPPLIED");
}

purchase_vehicle(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	if (!self.supply_available)
	{
		self iprintln(&"PURCHASE_NOT_AVAILABLE");
		return;
	}

	switch(response)		
	{
	case "1":	// JEEP
	
		cost = level.purchase_cost_jeep;
		
		// what type of vehicle?
		if ( self.pers["team"] == "allies" )	
		{
			switch( game["allies"])
			{
			case "british":
				vehtype = "willyjeep_mp";
				break;
			case "russian":
				vehtype = "gaz67b_mp";
				break;
			default:
				vehtype = "willyjeep_mp";
			}
		}
		else
		{
			vehtype = "horch_mp";
		}
		
		break;
		
	case "2":	// MEDIUM TANK
	
	case "3":	// HEAVY TANK
	
		if (response == "2")
		{
			cost = level.purchase_cost_medium_tank;
			
			// what type of vehicle?
			if ( self.pers["team"] == "allies" )	
			{
				switch( game["allies"])
				{
				case "british":
					vehtype = "shermantank_mp";
					break;
				case "russian":
					vehtype = "t34_mp";
					break;
				default:
					vehtype = "shermantank_mp";
				}
			}
			else
			{
				vehtype = "panzeriv_mp";
			}
		}
		else
		{
			cost = level.purchase_cost_heavy_tank;
			
			// what type of vehicle?
			if ( self.pers["team"] == "allies" )	
			{
				switch( game["allies"])
				{
				case "british":
					vehtype = "su152_mp";
					break;
				case "russian":
					vehtype = "su152_mp";
					break;
				default:
					vehtype = "su152_mp";
				}
			}
			else
			{
				vehtype = "elefant_mp";
			}
		}

		break;
	}
		
	if (self.supply_credits < cost)
	{
		self iprintln(&"PURCHASE_NOT_ENOUGH_CREDIT");
		return;
	}
		
	// make sure there are enough free vehicle slots
	if (maps\mp\_tankdrive_gmi::vehicleTeamCount( self.pers["team"] ) >= level.vehicle_limit/2)
	{
		self iprintln(&"PURCHASE_VEHICLE_LIMIT_REACHED");
		return;
	}
	
	// try and find one
	if (!maps\mp\_tankdrive_gmi::canSpawnVehicleType( vehtype ))
	{
		self iprintln(&"PURCHASE_VEHICLE_UNAVAILABLE");
		return;
	}
	
	if (response == "1")	//JEEP
		vehicle = maps\mp\_jeepdrive_gmi::spawnVehicle( vehtype, self.supply_base.origin, level.bop_base_vehicle_range, self.origin );
	else
		vehicle = maps\mp\_tankdrive_gmi::spawnVehicle( vehtype, self.supply_base.origin, level.bop_base_vehicle_range, self.origin );
	
	if (!isdefined(vehicle))
	{
		self iprintln( level.spawnVehicleError );
		return;
	}
	
	// take their money
	self.supply_credits -= cost;

	self iprintln(&"PURCHASE_VEHICLE_SUPPLIED");
	
	// make it only available to the purchaser
	vehicle maps\mp\_tankdrive_gmi::setVehicleOwner( self, 10 );
	
	// spawn an indicator over the vehicle
	vehicle.purchase_indicator = spawn( "script_vehicle_owner_icon", vehicle.origin );
	vehicle.purchase_indicator.vehicle_owner = self;
	vehicle.purchase_indicator.duration = 10;
	if (response == "1")	//JEEP
		vehicle.purchase_indicator.radius = 130;
	else
		vehicle.purchase_indicator.radius = 170;
	
}

purchase_support_fire(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator")
		return;

	if (!self.supply_available)
	{
		self iprintln(&"PURCHASE_NOT_AVAILABLE");
		return;
	}

	switch(response)		
	{
	case "1":
		cost = level.purchase_cost_artillery;

		if ( self getWeaponSlotClipAmmo( "binocular" ) == 1 )
		{
			self iprintln(&"PURCHASE_MAXIMUM_REACHED");
			break;
		}
		
		if (self.supply_credits < cost)
		{
			self iprintln(&"PURCHASE_NOT_ENOUGH_CREDIT");
			break;
		}

		// take their money
		self.supply_credits -= cost;
		
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
		self setWeaponSlotWeapon("binocular", "binoculars_artillery_mp");
		self setWeaponSlotClipAmmo("binocular", 1);
		
		//set up the on screen icon
		self thread maps\mp\gametypes\_rank_gmi::artillery_available_hud();
		self thread maps\mp\gametypes\_rank_gmi::artillery_strike_sounds();
		
		self iprintln(&"PURCHASE_SUPPORT_FIRE_AVAILABLE");
		
		break;
	}
}

quickcommands(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

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
			case "9":
				soundalias = "us_redeploy";
				saytext = &"GMI_QUICKMESSAGE_REDEPLOY_FORWARD";
				break;

			default:
				return;
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
			case "9":
				soundalias = "uk_redeploy";
				saytext = &"GMI_QUICKMESSAGE_REDEPLOY_FORWARD";
				break;
			default:
				return;
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
			case "9":
				soundalias = "ru_redeploy";
				saytext = &"GMI_QUICKMESSAGE_REDEPLOY_FORWARD";
				break;
			default:
				return;
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
			case "9":
				soundalias = "ge_redeploy";
				saytext = &"GMI_QUICKMESSAGE_REDEPLOY_FORWARD";
				break;
			default:
				return;
			}
			break;
		}			
	}

	self.spamdelay = true;

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
				soundalias = "us_smokeout";
				saytext = &"GMI_QUICKMESSAGE_SMOKE_OUT";
				break;
			case "8":
				soundalias = "us_spotted";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_SPOTTED_AHEAD";
				break;
			case "9":
				soundalias = "us_behind";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_BEHIND";
				break;
			default:
				return;
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
				soundalias = "uk_smokeout";
				saytext = &"GMI_QUICKMESSAGE_SMOKE_OUT";
				break;
			case "8":
				soundalias = "uk_spotted";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_SPOTTED_AHEAD";
				break;
			case "9":
				soundalias = "uk_behind";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_BEHIND";
				break;
			default:
				return;
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
				soundalias = "ru_smokeout";
				saytext = &"GMI_QUICKMESSAGE_SMOKE_OUT";
				break;
			case "8":
				soundalias = "ru_spotted";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_SPOTTED_AHEAD";
				break;
			case "9":
				soundalias = "ru_behind";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_BEHIND";
				break;
			default:
				return;
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
				soundalias = "ge_smokeout";
				saytext = &"GMI_QUICKMESSAGE_SMOKE_OUT";
				break;
			case "8":
				soundalias = "ge_spotted";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_SPOTTED_AHEAD";
				break;
			case "9":
				soundalias = "ge_behind";
				saytext = &"GMI_QUICKMESSAGE_ENEMY_BEHIND";
				break;
			default:
				return;
			}
			break;
		}			
	}

	self.spamdelay = true;

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
			case "8":
				soundalias = "us_thanks";
				saytext = &"GMI_QUICKMESSAGE_THANK_YOU";
				break;
			default:
				return;
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
			case "8":
				soundalias = "uk_thanks";
				saytext = &"GMI_QUICKMESSAGE_THANK_YOU";
				break;
			default:
				return;
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
			case "8":
				soundalias = "ru_thanks";
				saytext = &"GMI_QUICKMESSAGE_THANK_YOU";
				break;
			default:
				return;
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
			case "8":
				soundalias = "ge_thanks";
				saytext = &"GMI_QUICKMESSAGE_THANK_YOU";
				break;
			default:
				return;
			}
			break;
		}			
	}

	self.spamdelay = true;

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;

	self restoreHeadIcon();	
}

quickvehicles(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "us_pickup";
				saytext = &"GMI_QUICKMESSAGE_NEED_PICKUP";
				break;

			case "2":
				soundalias = "us_getin_jeep";
				saytext = &"GMI_QUICKMESSAGE_GET_IN_JEEP";
				break;

			case "3":
				soundalias = "us_jeep_full";
				saytext = &"GMI_QUICKMESSAGE_JEEP_FULL";
				break;

			case "4":
				soundalias = "us_geton_50";
				saytext = &"GMI_QUICKMESSAGE_GET_ON_GUN";
				break;

			case "5":
				soundalias = "us_jeep";
				saytext = &"GMI_QUICKMESSAGE_JEEP_SPOTTED";
				break;

			case "6":
				soundalias = "us_tank";
				saytext = &"GMI_QUICKMESSAGE_TANK_SPOTTED";
				break;

			case "7":
				soundalias = "us_heavy_tank";
				saytext = &"GMI_QUICKMESSAGE_HEAVY_TANK_SPOTTED";
				break;
			case "8":
				soundalias = "us_tank2";
				saytext = &"GMI_QUICKMESSAGE_INCOMING_ARMOR";
				break;
			default:
				return;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "uk_pickup";
				saytext = &"GMI_QUICKMESSAGE_NEED_PICKUP";
				break;

			case "2":
				soundalias = "uk_getin_jeep";
				saytext = &"GMI_QUICKMESSAGE_GET_IN_JEEP";
				break;

			case "3":
				soundalias = "uk_jeep_full";
				saytext = &"GMI_QUICKMESSAGE_JEEP_FULL";
				break;

			case "4":
				soundalias = "uk_geton_50";
				saytext = &"GMI_QUICKMESSAGE_GET_ON_GUN";
				break;

			case "5":
				soundalias = "uk_jeep";
				saytext = &"GMI_QUICKMESSAGE_JEEP_SPOTTED";
				break;

			case "6":
				soundalias = "uk_tank";
				saytext = &"GMI_QUICKMESSAGE_TANK_SPOTTED";
				break;

			case "7":
				soundalias = "uk_heavy_tank";
				saytext = &"GMI_QUICKMESSAGE_HEAVY_TANK_SPOTTED";
				break;
			case "8":
				soundalias = "uk_tank2";
				saytext = &"GMI_QUICKMESSAGE_INCOMING_ARMOR";
				break;
			default:
				return;
			}
			break;

		case "russian":
			switch(response)		
			{
			case "1":
				soundalias = "ru_pickup";
				saytext = &"GMI_QUICKMESSAGE_NEED_PICKUP";
				break;

			case "2":
				soundalias = "ru_getin_jeep";
				saytext = &"GMI_QUICKMESSAGE_GET_IN_JEEP";
				break;

			case "3":
				soundalias = "ru_jeep_go";
				saytext = &"GMI_QUICKMESSAGE_JEEP_FULL";
				break;

			case "4":
				soundalias = "ru_machingun";
				saytext = &"GMI_QUICKMESSAGE_GET_ON_GUN";
				break;

			case "5":
				soundalias = "ru_jeep";
				saytext = &"GMI_QUICKMESSAGE_JEEP_SPOTTED";
				break;

			case "6":
				soundalias = "ru_tank";
				saytext = &"GMI_QUICKMESSAGE_TANK_SPOTTED";
				break;

			case "7":
				soundalias = "ru_heavy_tank";
				saytext = &"GMI_QUICKMESSAGE_HEAVY_TANK_SPOTTED";
				break;
			case "8":
				soundalias = "ru_tank2";
				saytext = &"GMI_QUICKMESSAGE_INCOMING_ARMOR";
				break;
			default:
				return;
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
				soundalias = "ge_pickup";
				saytext = &"GMI_QUICKMESSAGE_NEED_PICKUP";
				break;

			case "2":
				soundalias = "ge_getin_jeep";
				saytext = &"GMI_QUICKMESSAGE_GET_IN_JEEP";
				break;

			case "3":
				soundalias = "ge_jeep_full";
				saytext = &"GMI_QUICKMESSAGE_JEEP_FULL";
				break;

			case "4":
				soundalias = "ge_machingun";
				saytext = &"GMI_QUICKMESSAGE_GET_ON_GUN";
				break;

			case "5":
				soundalias = "ge_jeep";
				saytext = &"GMI_QUICKMESSAGE_JEEP_SPOTTED";
				break;

			case "6":
				soundalias = "ge_tank";
				saytext = &"GMI_QUICKMESSAGE_TANK_SPOTTED";
				break;

			case "7":
				soundalias = "ge_heavy_tank";
				saytext = &"GMI_QUICKMESSAGE_HEAVY_TANK_SPOTTED";
				break;
			case "8":
				soundalias = "ge_tank2";
				saytext = &"GMI_QUICKMESSAGE_INCOMING_ARMOR";
				break;
			default:
				return;
			}
			break;
		}			
	}

	self.spamdelay = true;
	
	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;

	self restoreHeadIcon();	
}

quickrequests(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "american_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;

			case "2":
				soundalias = "american_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "3":
				soundalias = "us_bazooka";
				saytext = &"GMI_QUICKMESSAGE_NEED_BAZOOKA";
				break;

			case "4":
				soundalias = "us_armor";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARMOR";
				break;

			case "5":
				soundalias = "us_need_arty_support";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARTILLERY";
				break;
			default:
				return;

			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "british_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;

			case "2":
				soundalias = "british_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "3":
				soundalias = "uk_bazooka";
				saytext = &"GMI_QUICKMESSAGE_NEED_BAZOOKA";
				break;

			case "4":
				soundalias = "uk_armor";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARMOR";
				break;

			case "5":
				soundalias = "uk_need_arty_support";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARTILLERY";
				break;

			default:
				return;
			}
			break;

		case "russian":
			switch(response)		
			{
			case "1":
				soundalias = "russian_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;

			case "2":
				soundalias = "russian_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "3":
				soundalias = "ru_bazooka";
				saytext = &"GMI_QUICKMESSAGE_NEED_BAZOOKA";
				break;

			case "4":
				soundalias = "ru_armor";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARMOR";
				break;

			case "5":
				soundalias = "ru_need_arty_support";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARTILLERY";
				break;

			default:
				return;
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
				soundalias = "german_hold_fire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;

			case "2":
				soundalias = "german_need_reinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			case "3":
				soundalias = "ge_bazooka";
				saytext = &"GMI_QUICKMESSAGE_NEED_BAZOOKA";
				break;

			case "4":
				soundalias = "ge_armor";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARMOR";
				break;

			case "5":
				soundalias = "ge_need_arty_support";
				saytext = &"GMI_QUICKMESSAGE_NEED_ARTILLERY";
				break;

			default:
				return;
			}
			break;
		}			
	}

	self.spamdelay = true;
	
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

//===================================================================================================
//	vsay_monitor
//
//		Waits for a console vsay command from the clients.  
//		The client can enter a vsay command into the console in the following format:
//			
//			vsay 1 1   // this will play the first vo in the first menu
//			vsay 1 1 1 2  // this will play the first vo in the first menu with the first key press
//				      // it will play the second vo in the first menu with a double tap (if it is bound to a key)
//			vsay 1 1 1 2 1 3 // this will play the first vo in the first menu with the first key press
//				      	 // it will play the second vo in the first menu with a double tap (if it is bound to a key)
//				         // it will play the thrid vo in the first menu with a tripple tap (if it is bound to a key)
//===================================================================================================
vsay_monitor()
{
	if (!isPlayer(self))
		maps\mp\_utility::error("vsay_monitor must be called on a player");
		
	for(;;)
	{
		self waittill("vsay", response);
		
		self.vsay = response;
		self thread vsay_talk();
		
		wait (0.01);
	}
}

vsay_talk()
{
	// only play if alive and not a spectator
	if ( isAlive(self) && self.sessionstate != "spectator" )
	{
		numbers = [];
		numbers[0] = "";
		index = 0;
		
		// turn the string into an array
		for ( i = 0;i < self.vsay.size ; i++)
		{
			if ( self.vsay[i] == " ")
			{
				index++;
				numbers[index] = "";
				continue;
			}
			
			numbers[index] += self.vsay[i];
		}
		
		count = numbers.size;
		
		// drop any extra odd numbers (should be an even amount
		if ( count % 2 )
		{
			count--;
		}
		
		// dont allow an invalid count
		if ( count <= 0 )
			return;
			
		menu = numbers[0];
		say =  numbers[1];
		
		switch ( menu )
		{
			case "1":
				self thread quickcommands(say);
				break;
			case "2":
				self thread quickstatements(say);
				break;
			case "3":
				self thread quickresponses(say);
				break;
			case "4":
				self thread quickrequests(say);
				break;
			case "5":
				self thread quickvehicles(say);
				break;
		}
	}
	
	// clear the vsay
	self.vsay = undefined;
	self.vsay_index = 0;
	self.vsay_time = 0;
}

//===================================================================================================
//	purchase_monitor
//
//		Waits for a console purchase command from the clients.  
//		The client can enter a purchase command into the console in the following format:
//			
//			purchase 1 1   // this will purchase the first item in the first menu
//			purchase 1 1 1 2  // this will purchase the first item in the first menu with the first key press
//				      // it will purchase the second item in the first menu with a double tap (if it is bound to a key)
//			purchase 1 1 1 2 1 3 // this will purchase the first item in the first menu with the first key press
//				      	 // it will purchase the second item in the first menu with a double tap (if it is bound to a key)
//				         // it will purchase the thrid item in the first menu with a tripple tap (if it is bound to a key)
//===================================================================================================
purchase_monitor()
{
	if (!isPlayer(self))
		maps\mp\_utility::error("purchase_monitor must be called on a player");
		
	for(;;)
	{
		self waittill("purchase", response);
		
		self.purchase = response;
		self thread purchase_action();
		
		wait (0.01);
	}
}

purchase_action()
{
	// only play if alive and not a spectator
	if ( isAlive(self) && self.sessionstate != "spectator" )
	{
		numbers = [];
		numbers[0] = "";
		index = 0;
		
		// turn the string into an array
		for ( i = 0;i < self.purchase.size ; i++)
		{
			if ( self.purchase[i] == " ")
			{
				index++;
				numbers[index] = "";
				continue;
			}
			
			numbers[index] += self.purchase[i];
		}
		
		count = numbers.size;
		
		// drop any extra odd numbers (should be an even amount
		if ( count % 2 )
		{
			count--;
		}
		
		// dont allow an invalid count
		if ( count <= 0 )
			return;
			
		menu = numbers[0];
		say =  numbers[1];
		
		switch ( menu )
		{
			case "1":
				self thread purchase_weapon(say);
				break;
			case "2":
				self thread purchase_ammo(say);
				break;
			case "3":
				self thread purchase_vehicle(say);
				break;
			case "4":
				self thread purchase_support_fire(say);
				break;
		}
	}
	
	// clear the purchase
	self.purchase = undefined;
	self.purchase_index = 0;
	self.purchase_time = 0;
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
	case "thompson_semi_mp":
		weaponname = &"WEAPON_THOMPSON";
		break;
		
	case "bar_mp":
	case "bar_slow_mp":
		weaponname = &"WEAPON_BAR";
		break;
		
	case "springfield_mp":
		weaponname = &"WEAPON_SPRINGFIELD";
		break;

	case "mg30cal_mp":
		weaponname = &"GMI_WEAPON_30CAL";
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

	case "svt40_mp":
		weaponname = &"GMI_WEAPON_SVT40";
		break;
		
	case "ppsh_mp":
	case "ppsh_semi_mp":
		weaponname = &"WEAPON_PPSH";
		break;
		
	case "mosin_nagant_sniper_mp":
		weaponname = &"WEAPON_SCOPEDMOSINNAGANT";
		break;
		
	case "dp28_mp":
		weaponname = &"GMI_WEAPON_DP28";
		break;

	case "kar98k_mp":
		weaponname = &"WEAPON_KAR98K";
		break;
		
	case "gewehr43_mp":
		weaponname = &"GMI_WEAPON_GEWEHR43";
		break;

	case "mp40_mp":
		weaponname = &"WEAPON_MP40";
		break;
		
	case "mp44_mp":
	case "mp44_semi_mp":
		weaponname = &"WEAPON_MP44";
		break;
		
	case "mg34_mp":
		weaponname = &"GMI_WEAPON_MG34";
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
	case "mp44_semi_mp":
		result = true;
		break;
		
	default:
		result = false;
		break;
	}

	return result;
}

CountPlayers()
{
	//chad
	players = getentarray("player", "classname");
	allies = 0;
	axis = 0;
	for(i = 0; i < players.size; i++)
	{
		if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
			allies++;
		else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
			axis++;
	}
	players["allies"] = allies;
	players["axis"] = axis;
	return players;
}

TeamBalance_Check()
{
	level endon("intermission");
	
	if(level.teambalance > 0)
	{
		level.team["allies"] = 0;
		level.team["axis"] = 0;
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				level.team["allies"]++;
			else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
				level.team["axis"]++;
		}
		//iprintlnbold ("ALLIES: " + level.team["allies"] + " AXIS: " + level.team["axis"]);
		
		if (level.team["allies"] > (level.team["axis"] + level.teambalance))
		{
			// TOO MANY ALLIES
			iprintlnbold (&"MPSCRIPT_AUTOBALANCE_SECONDS", 15);
			wait 15;
			level TeamBalance();
			return;
		}
		else if (level.team["axis"] > (level.team["allies"] + level.teambalance))
		{
			// TOO MANY AXIS
			iprintlnbold (&"MPSCRIPT_AUTOBALANCE_SECONDS", 15);
			wait 15;
			level TeamBalance();
			return;
		}
		
		// TEAMS ARE EVEN ALREADY
		println ("TEAMBALANCE DEBUGGER ### TEAMS ARE EVEN - TEAMS WILL REMAIN THE SAME NEXT ROUND");
		game["BalanceTeamsNextRound"] = false;
	}
}

TeamBalance()
{
	wait 0.5;
	iprintln (&"MPSCRIPT_AUTOBALANCE_NOW");
	//Create/Clear the team arrays
	AlliedPlayers = [];
	AxisPlayers = [];
	
	// Populate the team arrays
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if (!isdefined (players[i].pers["teamTime"]))
			players[i].pers["teamTime"] = 0;
		if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
			AlliedPlayers[AlliedPlayers.size] = players[i];
		else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
			AxisPlayers[AxisPlayers.size] = players[i];
	}
	while ( (AlliedPlayers.size > (AxisPlayers.size + 1)) || (AxisPlayers.size > (AlliedPlayers.size + 1)) )
	{	
		if (AlliedPlayers.size > (AxisPlayers.size + 1))
		{
			game["BalanceTeamsNextRound"] = false;
			// Move the player that's been on the team the shortest ammount of time (highest teamTime value)
			for (j=0;j<AlliedPlayers.size;j++)
			{
				// only switch players that are waiting to respawn
				if (AlliedPlayers[j].health > 0)
					continue;
				if (!isdefined (MostRecent))
					MostRecent = AlliedPlayers[j];
				else if (AlliedPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
					MostRecent = AlliedPlayers[j];
			}
			if (isdefined( MostRecent ))
				MostRecent ChangeTeam("axis");
			//AlliedPlayers[randomint(AlliedPlayers.size)] ChangeTeam("axis");
		}
		else if (AxisPlayers.size > (AlliedPlayers.size + 1))
		{
			game["BalanceTeamsNextRound"] = false;
			// Move the player that's been on the team the shortest ammount of time (highest teamTime value)
			for (j=0;j<AxisPlayers.size;j++)
			{
				// only switch players that are waiting to respawn
				if (AxisPlayers[j].health > 0)
					continue;
				if (!isdefined (MostRecent))
					MostRecent = AxisPlayers[j];
				else if (AxisPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
					MostRecent = AxisPlayers[j];
			}
			if (isdefined( MostRecent ))
				MostRecent ChangeTeam("allies");
		}
		MostRecent = undefined;
		wait 0.5;
		
		AlliedPlayers = [];
		AxisPlayers = [];
		
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				AlliedPlayers[AlliedPlayers.size] = players[i];
			else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
				AxisPlayers[AxisPlayers.size] = players[i];
		}
	}
	level notify ("Teams Balanced");
}

TeamBalance_Check_Roundbased()
{
	wait 1;
	if(level.teambalance > 0)
	{
		level.team["allies"] = 0;
		level.team["axis"] = 0;
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				level.team["allies"]++;
			else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
				level.team["axis"]++;
		}
		
		if (level.team["allies"] > (level.team["axis"] + level.teambalance))
		{
			// TOO MANY ALLIES
			iprintlnbold (&"MPSCRIPT_AUTOBALANCE_NEXT_ROUND");
			game["BalanceTeamsNextRound"] = true;
			return;
		}
		else if (level.team["axis"] > (level.team["allies"] + level.teambalance))
		{
			// TOO MANY AXIS
			iprintlnbold (&"MPSCRIPT_AUTOBALANCE_NEXT_ROUND");
			game["BalanceTeamsNextRound"] = true;
			return;
		}
		
		// TEAMS ARE EVEN ALREADY
		println ("TEAMBALANCE DEBUGGER ### TEAMS ARE EVEN - TEAMS WILL REMAIN THE SAME NEXT ROUND");
		game["BalanceTeamsNextRound"] = false;
	}
}

ChangeTeam(team)
{
	if (self.sessionstate != "dead")
	{
		// Set a flag on the player to they aren't robbed points for dying - the callback will remove the flag
		self.autobalance = true;
		// Suicide the player so they can't hit escape and fail the team balance
		self suicide();
	}

	self.pers["team"] = team;
	self.pers["teamTime"] = (gettime() / 1000);
	
	// took this out here so we can determine later on if the teams were changed
	// and spawn the player in correctly
//	self.sessionteam = self.pers["team"];

	self.freerespawn = true; //for HQ Gametype
	if (!isdefined (game["timepassed"]))
		self.pers["teamTime"] = ((getTime() - level.starttime) / 1000);
	else
		self.pers["teamTime"] = game["timepassed"] + ((getTime() - level.starttime) / 1000) / 60.0;
	self.pers["selectedweapon"] = undefined;
	self.pers["weapon"] = undefined;
	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	
	// update spectator permissions immediately on change of team
	self SetSpectatePermissions();
	
	self setClientCvar("ui_weapontab", "1");
	self thread TeamBalance_NotifyPlayer();

	if(self.pers["team"] == "allies")
	{
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
		self openMenu(game["menu_weapon_allies"]);
	}
	else
	{
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
		self openMenu(game["menu_weapon_axis"]);
	}
}

TeamBalance_NotifyPlayer()
{
	if (!isdefined (self.autobalance_notify))
	{
		self.autobalance_notify = newClientHudElem(self);
		self.autobalance_notify.alignX = "center";
		self.autobalance_notify.alignY = "middle";
		self.autobalance_notify.x = 320;
		self.autobalance_notify.y = 50;
		self.autobalance_notify.archived = false;
		self.autobalance_notify.fontScale = 1.5;
		if (self.pers["team"] == "allies")
		{
			if (game["allies"] == "american")
				self.autobalance_notify settext(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_AMERICAN");
			else if (game["allies"] == "british")
				self.autobalance_notify settext(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_BRITISH");
			else if (game["allies"] == "russian")
				self.autobalance_notify settext(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_RUSSIAN");
		}
		else
			self.autobalance_notify settext(&"PATCH_1_3_TEAMBALANCE_NOTIFICATION_GERMAN");
	}
	wait 5;
	if ( (isdefined (self)) && (isdefined (self.autobalance_notify)) )
		self.autobalance_notify destroy();
}


SetSpectatePermissions()
{
	if (isdefined(self.killcam))
		return;
	
	if ( (!isdefined (level.allowfreelook)) || (!isdefined (level.allowenemyspectate)) )
		return;
	
	freelook = true;
	if (level.allowfreelook <= 0)
		freelook = false;
	
	enemyspectate = true;
	if (level.allowenemyspectate <= 0)
		enemyspectate = false;
	
	//switch (self.pers["team"])
	switch (self.sessionteam)
	{
	case "allies":
		self allowSpectateTeam("allies", true);
		self allowSpectateTeam("axis", enemyspectate);
		self allowSpectateTeam("freelook", freelook);
		self allowSpectateTeam("none", false);
		break;
		
	case "axis":
		self allowSpectateTeam("allies", enemyspectate);
		self allowSpectateTeam("axis", true);
		self allowSpectateTeam("freelook", freelook);
		self allowSpectateTeam("none", false);
		break;
		
	default:
		self allowSpectateTeam("allies", true);
		self allowSpectateTeam("axis", true);
		self allowSpectateTeam("freelook", true);
		self allowSpectateTeam("none", true);
		break;
	}
}

SetKillcamSpectatePermissions()
{
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
}

UpdateSpectatePermissions()
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		players[i] thread SetSpectatePermissions();
	}
}                           

watchWeaponUsage()
{
	self endon("spawned");
	level endon("round_started");
	
	while(self attackButtonPressed())
		wait .05;

	while(!(self attackButtonPressed()))
		wait .05;
		
	self.usedweapons = true;
}

isweaponavailable(team)
{
	if(team == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			if(level.allow_m1carbine == "1")
				return true;
			if(level.allow_m1garand == "1")
				return true;
			if(level.allow_thompson == "1")
				return true;
			if(level.allow_bar == "1")
				return true;
			if(level.allow_springfield == "1")
				return true;
			if(level.allow_mg30cal == "1")
				return true;
	
			return false;
			break;

		case "british":
			if(level.allow_enfield  == "1")
				return true;
			if(level.allow_sten == "1")
				return true;
			if(level.allow_bren == "1")
				return true;
			if(level.allow_springfield == "1")
				return true;
			if(level.allow_mg30cal == "1")
				return true;
	
			return false;
			break;
			
		case "russian":
			if(level.allow_nagant  == "1")
				return true;
			if(level.allow_svt40 == "1")
				return true;
			if(level.allow_ppsh == "1")
				return true;
			if(level.allow_nagantsniper == "1")
				return true;
			if(level.allow_dp28 == "1")
				return true;
	
			return false;
			break;
		}
	}
	else if(self.pers["team"] == "axis")
	{
		switch(game["axis"])		
		{
		case "german":
			if(level.allow_kar98k  == "1")
				return true;
			if(level.allow_gewehr43 == "1")
				return true;
			if(level.allow_mp40 == "1")
				return true;
			if(level.allow_mp44 == "1")
				return true;
			if(level.allow_kar98ksniper == "1")
				return true;
			if(level.allow_mg34 == "1")
				return true;
	
			return false;
			break;
		}			
	}
	return false;
}                  
             