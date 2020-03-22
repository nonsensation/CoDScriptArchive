main()
{
	setCullFog(0, 20000, 0.35, 0.345, 0.33, 0 );
	ambientPlay("ambient_mp_carentan");

	// set the nighttime flag to be off
	setcvar("sv_night", "0" );

	maps\mp\_load::main();
	maps\mp\_flak_gmi::main();
	level thread maps\mp\mp_kharkov_fx::main();
	maps\mp\mp_kharkov::layout_images();
	level thread maps\mp\_tankdrive_gmi::main();
	level thread maps\mp\_jeepdrive_gmi::main();

	level thread firesounds();

	// Used for Random Planes
	precachemodel("xmodel/v_ge_air_me-109");
	level thread Random_Plane_FlyBy();

	game["allies"] = "russian";
	game["axis"] = "german";

	game["hud_allies_victory_image"]= "gfx/hud/hud@mp_victory_kharkov_r.dds";
	game["hud_axis_victory_image"] 	= "gfx/hud/hud@mp_victory_kharkov_g.dds";

	game["attackers"] = "axis";
	game["defenders"] = "allies";

	game["compass_range"] = 6124;


	// HQ Mode
	if (getcvar("g_gametype") == "hq")
        {
		//spawn radio 1
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (1216, -1216, -80);
                radio.angles = (0, 315, 0);
                radio.targetname = "hqradio";
                
                //spawn radio 2
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (-368, -4992, 24);
                radio.angles = (0, 315, 0);
                radio.targetname = "hqradio";

                //spawn radio 3
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (1695, -4437, -17);
                radio.angles = (355.99, 221.844, 4.46614);
                radio.targetname = "hqradio";

                //spawn radio 4
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (2096, 3192, 116);
                radio.angles = (0, 90, 0);
                radio.targetname = "hqradio";

                //spawn radio 5
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (-1628, 3648, 116);
                radio.angles = (0, 0, 0);
                radio.targetname = "hqradio";

                //spawn radio 6
                radio = spawn ("script_model", (0,0,0));
                radio.origin = (1082, 290, -74);
                radio.angles = (0, 220, 0);
                radio.targetname = "hqradio";

	}	

	//setcvar("scr_allow_allied_secondary", "1");
	//setcvar("scr_allow_axis_secondary", "1");
		

	//Flag Setup
	//There must be a set of the following for each flag in your map.
	flag1 = getent("flag1","targetname");			// identifies the flag you're setting up
	flag1.script_timer = 5;					// how many seconds a capture takes with one player
	flag1.description = (&"GMI_DOM_FLAG1_MP_KHARKOV");	// the name of the flag (localized in gmi_mp.str)

      	flag2 = getent("flag2","targetname");
	flag2.script_timer = 5;
	flag2.description = (&"GMI_DOM_FLAG2_MP_KHARKOV");

	flag3 = getent("flag3","targetname");
	flag3.script_timer = 5;
	flag3.description = (&"GMI_DOM_FLAG3_MP_KHARKOV");

      	flag4 = getent("flag4","targetname");
	flag4.script_timer = 5;
	flag4.description = (&"GMI_DOM_FLAG4_MP_KHARKOV");

      	flag5 = getent("flag5","targetname");
	flag5.script_timer = 5;
	flag5.description = (&"GMI_DOM_FLAG5_MP_KHARKOV");

      	flag6 = getent("flag6","targetname");
	flag6.script_timer = 5;
	flag6.description = (&"GMI_DOM_FLAG6_MP_KHARKOV");


	//Retrival Setup
	level.obj["Code Book"] = (&"RE_OBJ_CODE_BOOK");
	level.obj["Field Radio"] = (&"RE_OBJ_FIELD_RADIO");
	game["re_attackers"] = "allies";
	game["re_defenders"] = "axis";
	game["re_attackers_obj_text"] = (&"GMI_MP_RE_OBJ_KHARKOV_ATTACKER");
	game["re_defenders_obj_text"] = (&"GMI_MP_RE_OBJ_KHARKOV_DEFENDER");
	game["re_spectator_obj_text"] = (&"GMI_MP_RE_OBJ_KHARKOV_SPECTATOR");
	game["re_attackers_intro_text"] = (&"GMI_MP_RE_OBJ_KHARKOV_SPAWN_ATTACKER");
	game["re_defenders_intro_text"] = (&"GMI_MP_RE_OBJ_KHARKOV_SPAWN_DEFENDER");

	setcvar("scr_allow_allied_secondary", "1");
	setcvar("scr_allow_axis_secondary", "1");

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
}

#using_animtree ("stuka");
Random_Plane_FlyBy()
{
	path_start = [];
	path_end = [];
	path_start[0] = (-14445, -21, 640);
	path_end[0] = (16418, -21, 640);
	path_snd_delay[0] = 1;
	path_start[1] = (3192, 10800, 1152);
	path_end[1] = (-3192, -10800, 1152);
	path_snd_delay[1] = 0;

//Time = Distance / Speed
//
//Distance = Time * Speed
//
//Speed = Distance / Time
	wait (20 + randomint(45));

	level.plane_flybys = 1;
	while(1)
	{
		// Choose Random Path
		random_path = randomint(path_start.size);
		the_path_start = path_start[random_path];
		the_path_end = path_end[random_path];

		side = randomint(2);

		if(side == 1)
		{
			startpos = the_path_start;
			endpos = the_path_end;
		}
		else
		{
			startpos = the_path_end;
			endpos = the_path_start;
		}

		sound_delay = path_snd_delay[random_path];

		speed = (3000  + randomint(750));
		dist = distance(startpos,endpos);
	
		time = (dist / speed);

		num_of_planes = 1 + randomint(2);
		println("num_of_planes ", num_of_planes);
		for(i=0;i<num_of_planes;i++)
		{
			level.plane_flybys--;
			random_x = (startpos[0] - 256) + randomfloat(512);
			random_y = (startpos[1] - 256) + randomfloat(512);
			random_z = (startpos[2] - 128) + randomfloat(256);
			offset = (random_x, random_y, random_z);

//			println("OFFSET = ",offset);

			plane = spawn("script_model", offset);
			plane setmodel("xmodel/v_ge_air_me-109");
			plane thread Plane_Move(startpos,endpos,time, sound_delay);
			wait (0.5 + randomfloat(2));
		}

//		println("PLANE GROUPS : ",level.plane_flybys);

		while(level.plane_flybys <= 0)
		{
			wait 1;
		}

		wait (20 + randomint(45));
	}
}

do_line()
{
	self endon("death");
	while(1)
	{
		line(self.origin, (0,0,0),(1,1,1));
		print3d((self.origin + (0,0,50)), self.angles, (1,1,1));
		wait 0.05;
	}
}

Plane_Move(startpos,endpos,time, sound_delay)
{
	self moveto(endpos, time, 0, 0);
	self.angles = vectortoangles (endpos - startpos);
	self thread Plane_Rotate();
	level thread Plane_Sound(sound_delay);

	self waittill("movedone");
	level.plane_flybys++;
	
	println("Deleting plane.");
	self delete();
}

Plane_Rotate()
{
	self endon("death");
	og_angles = self.angles;

	while(1)
	{
		random_x = og_angles[2] + (-15 + randomfloat(30));
		random_y = og_angles[0] + (-5 + randomfloat(10));
		random_time = 2 + randomfloat(5);
		offset = (random_y, og_angles[1], random_x);

		self rotateto(offset, random_time, 0.5, 0.5);
		self waittill("rotatedone");
	}
}

Plane_Sound(sound_delay)
{
	org = spawn("script_model",(0,0,0));
	
	org SetContents(0);
	wait 0.1;
	random_num = randomint(2);
	if(random_num == 0)
	{
		alias = "bf109_attack03";
		sound_wait = 10;
	}
	else
	{
		alias = "bf109_attack04";
		sound_wait = 8;
	}

	if(isdefined(sound_delay))
	{
		wait sound_delay;
	}

	println("^5Playing Sound " + alias + " wait: " + sound_wait);
	org playsound (alias);
	wait sound_wait;
	println("DELETE!");
	org delete();
}

firesounds()
{
	org1 = spawn("script_model",(1376, -1600, -32));
	org1 playloopsound ("medfire");
	org2 = spawn("script_model",(2048, 3392, 376));
	org2 playloopsound ("bigfire");
	org3 = spawn("script_model",(-110, -4496, -42));
	org3 playloopsound ("medfire");
	org4 = spawn("script_model",(3776, -1024, -16));
	org4 playloopsound ("medfire");
}

do_line2()
{
	self endon("death");
	while(1)
	{
		line(self.origin, (self.origin + (0,0,1000)),(1,0,0));
		wait 0.05;
	}
}

layout_images()
{
	game["dom_layoutimage"] = "mp_kharkov_dom";
	game["ctf_layoutimage"] = "mp_kharkov_ctf";
	game["layoutimage"] = "mp_kharkov";
}

