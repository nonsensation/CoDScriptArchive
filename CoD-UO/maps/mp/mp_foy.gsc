main()
{
        setCullFog (500, 5500, .5254, .6117, .7215, 0 );
	ambientPlay("ambient_mp_foy");
	
	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

       	level thread maps\mp\mp_foy_fx::main();
	
	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	maps\mp\mp_foy::layout_images();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();
	level thread maps\mp\_treefall_gmi::main();

	//	we set the different base models here for base assault
	//	note we COULD use different models for each team 

//	-------------------------------------------	
	//	BASE ASSAULT SETUP
//	this is how it should be ( but we don't do it because thats just the defaults ANYWAY 
//	if(getCvar("scr_bas_basehealth") == "")		// healtg for each base
//		setCvar("scr_bas_basehealth", "24500");	// 700 tank shell * 35
//	if(getCvar("scr_bas_damagedhealth") == "")	// health to switch to damage model
//		setCvar("scr_bas_damagedhealth", getCvarInt("scr_bas_basehealth")/2);


	game["bas_allies_rubble"] 	= "xmodel/mp_bunker_foy_rubble";
	game["bas_allies_complete"] 	= "xmodel/mp_bunker_foy";
	game["bas_allies_damaged"] 	= "xmodel/mp_bunker_foy_predmg";
	game["bas_allies_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";
	game["bas_axis_rubble"] 	= "xmodel/mp_bunker_foy_rubble";
	game["bas_axis_complete"] 	= "xmodel/mp_bunker_foy";
	game["bas_axis_damaged"] 	= "xmodel/mp_bunker_foy_predmg";
	game["bas_axis_destroyed"] 	= "xmodel/mp_bunker_foy_dmg";
//	-------------------------------------------	

        maps\mp\_util_mp_gmi::base_swapper();
        
	level thread belltower_damage();

	game["allies"] = "american";
	game["axis"] = "german";

	game["hud_allies_victory_image"] 	= "gfx/hud/hud@mp_victory_foy_us.dds";
	game["hud_axis_victory_image"] 		= "gfx/hud/hud@mp_victory_foy_g.dds";

        game["american_soldiertype"] = "airborne";
	game["american_soldiervariation"] = "winter";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "winter";
	
        game["attackers"] = "allies";
	game["defenders"] = "axis";
	
	game["compass_range"] = 6124;				//How far the compass is zoomed in
	game["sec_type"] = "hold";				//What type of secondary objective

	game["attackers"] = "allies";
	game["defenders"] = "axis";

       	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_FOY_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_FOY_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_FOY_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_FOY_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_FOY_SPAWN_DEFENDER");

	//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 8;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_FOY");
	
       	flag2 = getent("flag2","targetname");
	flag2.script_timer = 12;
	flag2.description = (&"GMI_DOM_FLAG2_MP_FOY");

        flag3 = getent("flag3","targetname");
	flag3.script_timer = 18;
	flag3.description = (&"GMI_DOM_FLAG3_MP_FOY");

        flag4 = getent("flag4","targetname");
	flag4.script_timer = 12;
	flag4.description = (&"GMI_DOM_FLAG4_MP_FOY");

        flag5 = getent("flag5","targetname");
	flag5.script_timer = 8;
	flag5.description = (&"GMI_DOM_FLAG5_MP_FOY");

	//wait 0.5;
	
	//vehicle_spawner();
	maps\mp\mp_foy::move_bases();
	maps\mp\mp_foy::ctf_balancer();
	
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

belltower_damage()
{
	trig = getent("belltower_damage","targetname");
	trig waittill ("trigger");
	radiusDamage(trig.origin, 256, 200, 190);
}

vehicle_spawner()      // Spawns in sets of tanks dependent upon gametype.
{
        level.vehicles = getentarray ("script_vehicle","classname");
        
        // GMI game modes
	if (getcvar("g_gametype") == "dom")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_ctf") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
        if (getcvar("g_gametype") == "ctf")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_dom") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
	if (getcvar("g_gametype") == "ttdm")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_ctf") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
	
	if (getcvar("g_gametype") == "bas")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_dom") || (level.vehicles[i].targetname == "tank_ctf"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
	
        // IW Game Modes
     	if (getcvar("g_gametype") == "re")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_ctf") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
	if (getcvar("g_gametype") == "sd")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_ctf") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
        if (getcvar("g_gametype") == "bel")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_dom") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
        if (getcvar("g_gametype") == "hq")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
	            if ((level.vehicles[i].targetname == "tank_dom") || (level.vehicles[i].targetname == "bas"))
                    {
		     level.vehicles[i] delete();
		     }
	        }
	}
	
	/*// NO TANKS OR JEEPS
	if (getcvar("g_gametype") == "dm")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
		     level.vehicles[i] delete();
	        }
	}
        if (getcvar("g_gametype") == "tdm")
	{
	        for (i=0;i<level.vehicles.size;i++)
	        {
		     level.vehicles[i] delete();
	        }
	}*/
}

layout_images()
{
	game["bas_layoutimage"] = "mp_foy_bas";
	game["dom_layoutimage"] = "mp_foy_dom";
	game["ctf_layoutimage"] = "mp_foy_ctf";
	game["layoutimage"] = "mp_foy";
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

ctf_balancer()
{
	if (getcvar("g_gametype") == "ctf")
	{
		flak88 = getent("bad_flak","targetname");
		flak88 delete();
	}
}
