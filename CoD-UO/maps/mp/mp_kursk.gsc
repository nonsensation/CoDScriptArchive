main()
{
	setExpFog (0.00005, .72, .59, .63, 0 );
	ambientPlay("ambient_mp_kursk");

	// Looping windmill sounds -SG
	level thread windmill_sounds();


	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();
	level thread maps\mp\_treefall_gmi::main();

	game["allies"] = "russian";
	game["axis"] = "german";

	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_kursk_r.dds";
	game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_kursk_g.dds";


	//game["allies_victory_screen"] 	= "hud@mp_victory_kursk_r.dds";
	//game["axis_victory_screen"] 	= "hud@mp_victory_kursk_g.dds";

	game["attackers"] = "axis";
	game["defenders"] = "allies";

	game["layoutimage"] = "mp_kursk.dds";
	game["dom_layoutimage"] = "mp_kursk_dom.dds";
	game["ctf_layoutimage"] = "mp_kursk_ctf.dds";
	game["bas_layoutimage"] = "mp_kursk_bas.dds";

	//	-------------------------------------------	
	//	BASE ASSAULT SETUP
//	this is how it should be ( but we don't do it because thats just the defaults ANYWAY 
//	if(getCvar("scr_bas_basehealth") == "")		// healtg for each base
//		setCvar("scr_bas_basehealth", "24500");	// 700 tank shell * 35
//	if(getCvar("scr_bas_damagedhealth") == "")	// health to switch to damage model
//		setCvar("scr_bas_damagedhealth", getCvarInt("scr_bas_basehealth")/2);

	game["bas_allies_rubble"] 	= "xmodel/mp_bunker_kursk_rubble";
	game["bas_allies_complete"] 	= "xmodel/mp_bunker_kursk";
	game["bas_allies_damaged"] 	= "xmodel/mp_bunker_kursk_predmg";
	game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_kursk_dmg";
	game["bas_axis_rubble"] 	= "xmodel/mp_bunker_kursk_rubble";
	game["bas_axis_complete"] 	= "xmodel/mp_bunker_kursk";
	game["bas_axis_damaged"] 	= "xmodel/mp_bunker_kursk_predmg";
	game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_kursk_dmg";

	//	this must be called after the above setup 
        maps\mp\_util_mp_gmi::base_swapper();

	game["compass_range"] = 13000;	

	game["layoutimage"] = "mp_kursk";

	//setcvar("scr_allow_allied_secondary", "1");
	//setcvar("scr_allow_axis_secondary", "1");
		
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


	//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	if (isdefined(flag1))
	{
		flag1.script_timer = 5;					// how many seconds a capture takes with one player
		flag1.description = (&"GMI_DOM_FLAG1_MP_KURSK");	// the name of the flag (localized in gmi_mp.str)
	}

      	flag2 = getent("flag2","targetname");

	if (isdefined(flag2))
	{
		flag2.script_timer = 5;
		flag2.description = (&"GMI_DOM_FLAG2_MP_KURSK");
	}
	flag3 = getent("flag3","targetname");

	if (isdefined(flag3))
	{
		flag3.script_timer = 5;
		flag3.description = (&"GMI_DOM_FLAG3_MP_KURSK");
	}
      	flag4 = getent("flag4","targetname");
	if (isdefined(flag4))
	{
		flag4.script_timer = 5;
		flag4.description = (&"GMI_DOM_FLAG4_MP_KURSK");
	}
      	flag5 = getent("flag5","targetname");
	if (isdefined(flag5))
	{
		flag5.script_timer = 5;
		flag5.description = (&"GMI_DOM_FLAG5_MP_KURSK");
	}
	//retrival settings
		level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
		level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
		game["re_attackers"] = "allies";
		game["re_defenders"] = "axis";
		game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_KURSK_ATTACKER");
		game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_KURSK_DEFENDER");
		game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_KURSK_SPECTATOR");
		game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_KURSK_SPAWN_ATTACKER");
		game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_KURSK_SPAWN_DEFENDER");


	wait 0.1;
	setcvar("scr_allow_allied_secondary", "1");
	setcvar("scr_allow_axis_secondary", "1");

	level thread windmills();
}

windmills()
{
	level.windmill1 = getent("windmill1","targetname");	
	if (isdefined(level.windmill1))
		level.windmill1 thread maps\mp\_windmill_gmi::windmill_spin();

	level.windmill2 = getent("windmill2","targetname");	
	if (isdefined(level.windmill1))
		level.windmill2 thread maps\mp\_windmill_gmi::windmill_spin();
}

windmill_sounds()
{
	org1 = spawn("script_model",(4369,-8643,1170));
	org1 playloopsound ("windmill");
	org2 = spawn("script_model",(-3107,-10759,1324));
	org2 playloopsound ("windmill");

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

