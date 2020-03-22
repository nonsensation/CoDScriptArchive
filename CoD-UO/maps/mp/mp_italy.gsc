//mp_italy

main()
{
	setCullFog (500, 7000, .39, .30, .29, 0 );
	ambientPlay("ambient_day");

	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	level thread maps\mp\mp_italy_fx::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();

	level thread firesounds();

	//	-------------------------------------------	
	//	BASE ASSAULT SETUP
//	this is how it should be ( but we don't do it because thats just the defaults ANYWAY 
//	if(getCvar("scr_bas_basehealth") == "")		// healtg for each base
//		setCvar("scr_bas_basehealth", "24500");	// 700 tank shell * 35
//	if(getCvar("scr_bas_damagedhealth") == "")	// health to switch to damage model
//		setCvar("scr_bas_damagedhealth", getCvarInt("scr_bas_basehealth")/2);

	game["bas_allies_rubble"] 	= "xmodel/mp_bunker_italy_rubble";
	game["bas_allies_complete"] 	= "xmodel/mp_bunker_italy";
	game["bas_allies_damaged"] 	= "xmodel/mp_bunker_italy_predmg";
	game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_italy_dmg";

	game["bas_axis_rubble"] 	= "xmodel/mp_bunker_italy_rubble";
	game["bas_axis_complete"] 	= "xmodel/mp_bunker_italy";
	game["bas_axis_damaged"] 	= "xmodel/mp_bunker_italy_predmg";
	game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_italy_dmg";
        maps\mp\_util_mp_gmi::base_swapper();
//	-------------------------------------------

	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "commando";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["layoutimage"] = "mp_italy.dds";
	game["dom_layoutimage"] = "mp_italy_dom.dds";
	game["ctf_layoutimage"] = "mp_italy_ctf.dds";
	game["bas_layoutimage"] = "mp_italy_bas.dds";

	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_italy_us.dds";
	game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_italy_g.dds";

	game["attackers"] = "allies";
	game["defenders"] = "axis";

	game["compass_range"] = 13000;	

	game["sec_type"] = "destroy";				//What type of secondary objective

        
	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";

        game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_ITALY_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_ITALY_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_ITALY_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_ITALY_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_ITALY_SPAWN_DEFENDER");

	//maps\mp\_artillery_strike_gmi::Initialize();
	//maps\mp\_artillery_strike_gmi::Precache();
	//trigger = getent("artillery_strike_trigger","targetname");
	//trigger thread maps\mp\_artillery_strike_gmi::TriggerZoneThink();

	
	thread flag_def();

	// FOR BUILDING PAK FILES ONLY
	if (getcvar("fs_copyfiles") == "1")
	{
		precacheShader(game["dom_layoutimage"]);
		precacheShader(game["ctf_layoutimage"]);
		precacheShader(game["bas_layoutimage"]);
		precacheShader(game["layoutimage"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
	}
}

flag_def()
{
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 3;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_ITALY");	// the name of the flag (localized in gmi_mp.str)

	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_ITALY");

	flag3 = getent("flag3","targetname");
	flag3.script_timer = 7;
	flag3.description = (&"GMI_DOM_FLAG3_MP_KURSK");

	flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_ITALY");

	flag5 = getent("flag5","targetname");
	flag5.script_timer = 3;
	flag5.description = (&"GMI_DOM_FLAG5_MP_ITALY");
}

move_bases()
{
	base_movers = [];	
		
	entitytypes = getentarray();
	for(i = 0; i < entitytypes.size; i++)
	{
		if(isdefined(entitytypes[i].groupname))
		{
			if(entitytypes[i].groupname == "base_mover")
			{		
				entitytypes[i] moveto(entitytypes[i].origin+(0,0,256), 0.1,0,0);	
			}
		
		}
	}
}

firesounds()
{
	org1 = spawn("script_model",(5374, 5408, -72));
	org1 playloopsound ("smallfire");
}