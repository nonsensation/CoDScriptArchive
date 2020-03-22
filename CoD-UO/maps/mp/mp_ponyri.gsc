main()
{
	setExpFog (0.00005, .36, .39, .42, 0 );

	ambientPlay("ambient_mp_kursk");
	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();
	level thread maps\mp\_treefall_gmi::main();

	maps\mp\mp_ponyri::cull_entities();

	game["allies"] = "russian";
	game["axis"] = "german";

	game["attackers"] = "axis";
	game["defenders"] = "allies";

	game["layoutimage"] = "mp_ponyri";
	game["dom_layoutimage"] = "mp_ponyri_dom";
	game["ctf_layoutimage"] = "mp_ponyri_ctf";
	game["bas_layoutimage"] = "mp_ponyri_bas";

	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_ponyri_r.dds";
	game["hud_axis_victory_image"] = "gfx/hud/hud@mp_victory_ponyri_g.dds";

	flag1 = getent("flag1","targetname");
	flag1.script_timer = 5;
	flag1.description = (&"GMI_DOM_FLAG1_MP_PONYRI");

 	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_PONYRI");

 	flag3 = getent("flag3","targetname");
	flag3.script_timer = 5;
	flag3.description = (&"GMI_DOM_FLAG3_MP_PONYRI");

	flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_PONYRI");

	flag5 = getent("flag5","targetname");
	flag5.script_timer = 5;
	flag5.description = (&"GMI_DOM_FLAG5_MP_PONYRI");
	
//	-------------------------------------------	
//	BASE ASSAULT SETUP
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

	maps\mp\_util_mp_gmi::base_swapper();
//	-------------------------------------------	

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

// Removes ents based on gamemode/spawnflag settings
cull_entities()
{
	gametype = getcvar("g_gametype");
	cullflag = 0;
	
	switch(gametype)
	{
		// !Easy
		// strict team spawn areas
		case "ctf": cullflag = 256; break;
		case "sd":  cullflag = 256; break;
		case "re":   cullflag = 256; break; // not supported
		
		// !Medium
		// command point-style modes (i.e. Domination)
		case "dom": cullflag = 512; break;
		
		// !Hard
		// open dm-style spawning
		case "dm":  cullflag = 1024; break;
		case "tdm": cullflag = 1024; break;
		case "hq":  cullflag = 1024; break;
		case "bel": cullflag = 1024; break;
		case "ttdm": cullflag = 1024; break; // not supported

		// !Deathmatch
		// numerous localized team spawns (i.e. Base Assault)
		case "bas": cullflag = 2048; break;

	}

	// just going to do vehicles for now; add other ents only if needed
	cullents = getentarray( "script_vehicle","classname" );
	for( i=0; i < cullents.size; i++ )
	{
		if( cullents[i].spawnflags & cullflag )
		{
//			println( "^2DELETING: ", cullents[i].vehicletype );
			cullents[i] delete();
		}
	}

}