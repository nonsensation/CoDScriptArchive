main()
{

	setCullFog(500, 15000, .0273, .0820, .1601, 0 );
	ambientPlay("ambient_mp_berlin");
	precacheModel("xmodel/turret_flak88_static_antitank");
	level thread firesounds();
		
	// sound for the lampposts.  Needs to be before calling _treefall_gmi
	game["treefall_sound"] = "streetlamp_fall";

	maps\mp\_load::main();
	level thread maps\mp\mp_berlin_fx::main();
	maps\mp\_flak_gmi::main();
	maps\mp\mp_berlin::layout_images();
	level thread maps\mp\_searchlight_gmi::main();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_treefall_gmi::main();
	
	game["allies"] = "russian";
	game["axis"] = "german";

	game["hud_allies_victory_image"] 	= "gfx/hud/hud@mp_victory_berlin_r.dds";
	game["hud_axis_victory_image"] 		= "gfx/hud/hud@mp_victory_berlin_g.dds";

	game["russian_soldiertype"] = "conscript";
	game["russian_soldiervariation"] = "normal";
	game["german_soldiertype"] = "waffen";
	game["german_soldiervariation"] = "normal";

        game["compass_range"] = 2816;				//How far the compass is zoomed in
	game["sec_type"] = "hold";				//What type of secondary objective
	game["sec_defaultteam"] = "axis";			//Who owns secondary at start of round

	//domination settings - CHANGE TO BERLIN STRINGS
	game["attackers"] = "allies";
	game["defenders"] = "axis";

	game["cap_attackers_obj_text"] = (&"GMI_DOM_OBJ_BERLIN_OBJ_ATTACKER");
	game["cap_defenders_obj_text"] = (&"GMI_DOM_OBJ_BERLIN_OBJ_DEFENDER");
	game["cap_spectator_obj_text"] = (&"GMI_DOM_OBJ_BERLIN_OBJ_SPECTATOR");
	game["cap_attackers_intro_text"] = (&"GMI_DOM_OBJ_BERLIN_SPAWN_ATTACKER");
	game["cap_defenders_intro_text"] = (&"GMI_MP_OBJ_BERLIN_SPAWN_DEFENDER");
	
       	//retrival settings
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_BERLIN_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_BERLIN_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_BERLIN_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_BERLIN_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_BERLIN_SPAWN_DEFENDER");
	
	// FOR BUILDING PAK FILES ONLY
	if (getcvar("fs_copyfiles") == "1")
	{
		precacheShader(game["dom_layoutimage"]);
		precacheShader(game["ctf_layoutimage"]);
//		precacheShader(game["bas_layoutimage"]);
		precacheShader(game["layoutimage"]);
		precacheShader(game["hud_allies_victory_image"]);
		precacheShader(game["hud_axis_victory_image"]);
	}

	//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 5;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_BERLIN");
	
       	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_BERLIN");

        flag3 = getent("flag3","targetname");
	flag3.script_timer = 5;
	flag3.description = (&"GMI_DOM_FLAG3_MP_BERLIN");

        flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_BERLIN");

        flag5 = getent("flag5","targetname");
	flag5.script_timer = 5;
	flag5.description = (&"GMI_DOM_FLAG5_MP_BERLIN");

	flak_disabler();
	
	wait 0.5;
	//flak_swapper();
}

layout_images()
{
	game["dom_layoutimage"] = "mp_berlin_dom";
	game["ctf_layoutimage"] = "mp_berlin_ctf";
	game["layoutimage"] = "mp_berlin";
}


/*flak_swapper()
{
	gametype = getcvar("g_gametype");
        if(gametype == "sd")
        {
                flak1 = getent("flak1","script_noteworthy");
		//flak1_clip = getent("clip1","targetname");
		//flak1_clip.origin = flak1.origin;
		flak1_dummy = spawn("script_model",flak1.origin);
		flak1_dummy setmodel("xmodel/turret_flak88_static_antitank");
		
		flak2 = getent("flak2","script_noteworthy");
		//flak2_clip = getent("clip2","targetname");
		//flak2_clip.origin = flak2.origin;
		flak2_dummy = spawn("script_model",flak2.origin);
		flak2_dummy setmodel("xmodel/turret_flak88_static_antitank");
        }
}*/

firesounds()
{
	org1 = spawn("script_model",(-1979,1320,754));
	org1 playloopsound ("medfire");
	org2 = spawn("script_model",(-2669,634,644));
	org2 playloopsound ("smallfire");
	org3 = spawn("script_model",(-2837,2745,759));
	org3 playloopsound ("medfire");
	org4 = spawn("script_model",(987,4242,582));
	org4 playloopsound ("medfire");
	org5 = spawn("script_model",(-2749,3802,1014));
	org5 playloopsound ("medfire");
	org6 = spawn("script_model",(-4632,471,732));
	org6 playloopsound ("medfire");
	org7 = spawn("script_model",(-6678,3227,872));
	org7 playloopsound ("medfire");
	org8 = spawn("script_model",(-6102,3358,807));
	org8 playloopsound ("medfire");
	org9 = spawn("script_model",(-5379,5956,766));
	org9 playloopsound ("medfire");
	org10 = spawn("script_model",(-7159,602,676));
	org10 playloopsound ("medfire");
	org11 = spawn("script_model",(-296,2272,742));
	org11 playloopsound ("smallfire");









}

flak_disabler()
{
	array = getentarray("flak","targetname");
	flak_sp = getent("flak_sp","targetname");
	
	gametype = getcvar("g_gametype");
	if(gametype == "sd")
        {
        	for (i=0;i<array.size;i++)
        	{
        		array[i] makevehicleunusable();
        	}
        	flak_sp makevehicleunusable();
        }
        else
        {
        	flak_sp delete();
        }
}
