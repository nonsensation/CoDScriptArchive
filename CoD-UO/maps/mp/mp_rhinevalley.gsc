main()
{
	setExpFog (0.00002, 0.7, 0.85, 1.0, 0 );

	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	ambientPlay("ambient_day");
	maps\mp\mp_rhinevalley::layout_images();

	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();

	game["allies"] = "american";
	game["axis"] = "german";
	game["compass_range"] = 12500;	
	game["sec_type"] = "hold";				//What type of secondary objective

	//Search & Destroy Settings
	game["attackers"] = "axis";
	game["defenders"] = "allies";

	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_rhinevalley_us.dds";
	game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_rhinevalley_g.dds";

		
      //Retrival Settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_RHINEVALLEY_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_RHINEVALLEY_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_RHINEVALLEY_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_RHINEVALLEY_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_RHINEVALLEY_SPAWN_DEFENDER");

	//Domination Settings
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 10;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_RHINEVALLEY");	// the name of the flag (localized in gmi_mp.str)

      flag2 = getent("flag2","targetname");
	flag2.script_timer = 15;
	flag2.description = (&"GMI_DOM_FLAG2_MP_RHINEVALLEY");

      flag3 = getent("flag3","targetname");
	flag3.script_timer = 20;
	flag3.description = (&"GMI_DOM_FLAG3_MP_RHINEVALLEY");

      flag4 = getent("flag4","targetname");
	flag4.script_timer = 15;
	flag4.description = (&"GMI_DOM_FLAG4_MP_RHINEVALLEY");

      flag5 = getent("flag5","targetname");
	flag5.script_timer = 10;
	flag5.description = (&"GMI_DOM_FLAG5_MP_RHINEVALLEY");

//	-------------------------------------------	
//		BASE ASSAULT SETUP
//	this is how it should be ( but we don't do it because thats just the defaults ANYWAY 
//	if(getCvar("scr_bas_basehealth") == "")		// healtg for each base
//		setCvar("scr_bas_basehealth", "24500");	// 700 tank shell * 35
//	if(getCvar("scr_bas_damagedhealth") == "")	// health to switch to damage model
//		setCvar("scr_bas_damagedhealth", getCvarInt("scr_bas_basehealth")/2);

	game["bas_allies_rubble"] 	= "xmodel/mp_bunker_rhinevalley_rubble";
	game["bas_allies_complete"] 	= "xmodel/mp_bunker_rhinevalley";
	game["bas_allies_damaged"] 	= "xmodel/mp_bunker_rhinevalley_predmg";
	game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_rhinevalley_dmg";
	game["bas_axis_rubble"] 	= "xmodel/mp_bunker_rhinevalley_rubble";
	game["bas_axis_complete"] 	= "xmodel/mp_bunker_rhinevalley";
	game["bas_axis_damaged"] 	= "xmodel/mp_bunker_rhinevalley_predmg";
	game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_rhinevalley_dmg";
//	-------------------------------------------	

      maps\mp\_util_mp_gmi::base_swapper();
      

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


layout_images()
{
	game["bas_layoutimage"] = "mp_rhinevalley_bas";
	game["dom_layoutimage"] = "mp_rhinevalley_dom";
	game["ctf_layoutimage"] = "mp_rhinevalley_ctf";
	game["layoutimage"] = "mp_rhinevalley";
	
}

