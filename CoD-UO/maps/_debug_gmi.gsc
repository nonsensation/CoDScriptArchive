//
// Only for Debug scripts!
//
// Rules...
// 1. All functions must start with "debug_" i.e. debug_ai_count
// 2. Once it's working, CHECK IT IN! You cannot leave this file checked out overnight!
// 3. ALL functions must work, cause if you mess it up in here, all scripts will error out.
// 4. Add notes as to what the debug will do.
//

// Usually you will add a debug function into your level script, then copy it into here. Of course
// DO NOT FORGET TO TEST IT when you copy it in here!

// Types of Cvars:
// ---------------
// CVAR, where you enter a cvar and it enables.
// FUNCTION CALL, where in your script you call into this file.


//added 12/5/04, ts -- debug print statement with colored margin


main()
{
	// debug_ai_count
	precacheString(&"GMI_DEBUG_VEHICLE_COUNTER");
	precacheString(&"GMI_DEBUG_AI_COUNTER");
	precacheString(&"GMI_DEBUG_AXIS_COUNTER");
	precacheString(&"GMI_DEBUG_ALLIES_COUNTER");
	precacheString(&"GMI_DEBUG_DUMMIES");

	// Debug_brushmodel_hud
	precacheString(&"GMI_DEBUG_BRUSHMODEL_ROTATE_PITCH");
	precacheString(&"GMI_DEBUG_BRUSHMODEL_ROTATE_YAW");
	precacheString(&"GMI_DEBUG_BRUSHMODEL_ROTATE_ROLL");
	precacheString(&"GMI_DEBUG_BRUSHMODEL_MOVE_X");
	precacheString(&"GMI_DEBUG_BRUSHMODEL_MOVE_Y");
	precacheString(&"GMI_DEBUG_BRUSHMODEL_MOVE_Z");

	level thread debug_ai_count();
	level thread debug_ai_text();
	level thread debug_fog();
	level thread debug_brushmodel();
	level thread debug_music();
	level thread player_health_regen();

	level thread help();
}

// Prints out detailed info in the console when the level loads, so we can refer to it easily.
help()
{
	println("");
	println("^2<<=================Debug Help Section=================>>");
	println("");

	println("^2Function: debug_ai_count");
	println("^2Type: Cvar");
	println("^2Description: Prints on the screen how many AI and Vehicles are present/alive in the map. Updates every 0.25 seconds");
	println("^2Use: debug_ai_count <0,1>");

	println("");
	println("^2--------------------------------------------------------");
	println("");

	println("^2Function: debug_print");
	println("^2Type: Function Call");
	println("^2Description: Displays a text message with optional variable parameter with high-visibility colored margin");
	println("^2Use: debug_print (<text>, <variable>)");

	println("");
	println("^2--------------------------------------------------------");
	println("");

	println("^2Function: debug_ai_text");
	println("^2Type: Cvar");
	println("^2Description: Prints Above the AI's head the type of field you want to see. Updates PRINT3D every 0.1 seconds");
	println("^2Examples:");
	println("^2debug_ai_count origin");
	println("^2debug_ai_count goalradius");
	println("^2debug_ai_count maxsightdistsqrd");
	println("^2debug_ai_count groupname");
	println("^2debug_ai_count targetname");

	println("");
	println("^2--------------------------------------------------------");
	println("");

	println("^2Function: debug_fog");
	println("^2Type: Cvar");
	println("^2Description: Allows for anyone to modify the fog variables on the fly.");
	println("^2Note: I put in a fog.cfg, so you can just exect that.");
	println("^2Insert: Increases the Red");
	println("^2Delete: Decreases the Red");
	println("^2Home: Increases the Green");
	println("^2End: Decreases the Green");
	println("^2Page Up: Increases the Blue");
	println("^2Page Down: Decreases the Blue");
	println("^2+/=: Increases the outter radius of the fog");
	println("^2-: Decreases the outter radius of the fog");
	println("^2[: Increases the innter radius of the fog");
	println("^2]: Decreases the innter radius of the fog");


	println("");
	println("^2<<===============End Debug Help Section===============>>");
	println("");
}

// --------------------------------------------------------------------------- //
// Type of Debug: Cvar                                                         //
// Prints on the screen how many AI and Vehicles are present/alive in the map. //
// Updates every 0.25 seconds.                                                 //
// Created By: Mike                                                            //
// --------------------------------------------------------------------------- //
debug_ai_count()
{
	if(getcvar("debug_ai_count") == "")
	{
		setcvar("debug_ai_count","0");
	}

	text_toggle = false;
	dummytext_toggle = false;
	while(1)
	{
		if(getcvar("debug_ai_count") == 1)
		{
			if(!text_toggle)
			{
				level.ai_counter_text = newHudElem();
				level.ai_counter_text.alignX = "right";
				level.ai_counter_text.alignY = "middle";
				level.ai_counter_text.fontscale = "1.5";
				level.ai_counter_text.x = 596;
				level.ai_counter_text.y = 370;

				level.ai_counter_text setText(&"GMI_DEBUG_AI_COUNTER");

				level.vehicle_counter_text = newHudElem();
				level.vehicle_counter_text.alignX = "right";
				level.vehicle_counter_text.alignY = "middle";
				level.vehicle_counter_text.fontscale = "1.5";
				level.vehicle_counter_text.x = 596;
				level.vehicle_counter_text.y = 390;

				level.vehicle_counter_text setText(&"GMI_DEBUG_VEHICLE_COUNTER");


				level.allies_counter_text = newHudElem();
				level.allies_counter_text.alignX = "right";
				level.allies_counter_text.alignY = "middle";
				level.allies_counter_text.fontscale = "1.5";
				level.allies_counter_text.x = 596;
				level.allies_counter_text.y = 330;

				level.allies_counter_text setText(&"GMI_DEBUG_ALLIES_COUNTER");

				level.axis_counter_text = newHudElem();
				level.axis_counter_text.alignX = "right";
				level.axis_counter_text.alignY = "middle";
				level.axis_counter_text.fontscale = "1.5";
				level.axis_counter_text.x = 596;
				level.axis_counter_text.y = 350;

				level.axis_counter_text setText(&"GMI_DEBUG_AXIS_COUNTER");
			}

			text_toggle = true;
			axis_guys = getaiarray("axis");
			allies_guys = getaiarray("allies");
			total_guys = axis_guys.size + allies_guys.size;
			if(!isdefined(level.ai_counter))
			{
				level.ai_counter = newHudElem();
				level.ai_counter.alignX = "left";
				level.ai_counter.alignY = "middle";
				level.ai_counter.fontscale = "1.5";
				level.ai_counter.x = 600;
				level.ai_counter.y = 370;
			}

			if(isdefined(level.ai_counter))
			{
				level.ai_counter setvalue(total_guys);
			}

			if(!isdefined(level.axis_counter))
			{
				level.axis_counter = newHudElem();
				level.axis_counter.alignX = "left";
				level.axis_counter.alignY = "middle";
				level.axis_counter.fontscale = "1.5";
				level.axis_counter.x = 600;
				level.axis_counter.y = 350;
			}

			if(isdefined(level.axis_counter))
			{
				level.axis_counter setvalue(axis_guys.size);
			}

			if(!isdefined(level.allies_counter))
			{
				level.allies_counter = newHudElem();
				level.allies_counter.alignX = "left";
				level.allies_counter.alignY = "middle";
				level.allies_counter.fontscale = "1.5";
				level.allies_counter.x = 600;
				level.allies_counter.y = 330;
			}

			if(isdefined(level.allies_counter))
			{
				level.allies_counter setvalue(allies_guys.size);
			}

			if(isdefined(level.dummy_count))
			{
				if(!dummytext_toggle)
				{
					level.dummy_counter_text = newHudElem();
					level.dummy_counter_text.alignX = "right";
					level.dummy_counter_text.alignY = "middle";
					level.dummy_counter_text.fontscale = "1.5";
					level.dummy_counter_text.x = 596;
					level.dummy_counter_text.y = 410;
	
					level.dummy_counter_text setText(&"GMI_DEBUG_DUMMIES");
					dummytext_toggle = true;
				}

				if(!isdefined(level.dummy_counter))
				{
					level.dummy_counter = newHudElem();
					level.dummy_counter.alignX = "left";
					level.dummy_counter.alignY = "middle";
					level.dummy_counter.fontscale = "1.5";
					level.dummy_counter.x = 600;
					level.dummy_counter.y = 410;
				}

				if(isdefined(level.dummy_counter))
				{
					level.dummy_counter setvalue(level.dummy_count);
				}				
			}

			vehicles = getNumVehicles();

			if(!isdefined(level.vehicle_counter))
			{
				level.vehicle_counter = newHudElem();				
				level.vehicle_counter.alignX = "left";
				level.vehicle_counter.alignY = "middle";
				level.vehicle_counter.fontscale = "1.5";
				level.vehicle_counter.x = 600;
				level.vehicle_counter.y = 390;
			}

			if(isdefined(level.vehicle_counter))
			{
				level.vehicle_counter setvalue(vehicles);
			}
		}
		else
		{
			text_toggle = false;

			if(isdefined(level.ai_counter_text))
			{
				level.ai_counter_text destroy();
			}
		
			if(isdefined(level.vehicle_counter_text))
			{
				level.vehicle_counter_text destroy();
			}

			if(isdefined(level.ai_counter))
			{
				level.ai_counter destroy();
			}
		
			if(isdefined(level.vehicle_counter))
			{
				level.vehicle_counter destroy();
			}

			if(isdefined(level.dummy_counter))
			{
				level.dummy_counter destroy();
			}

			if(isdefined(level.dummy_counter_text))
			{
				level.dummy_counter_text destroy();
				dummytext_toggle = false;
			}
		}
		wait 0.25;
	}	
}


// Debug print added by ts
debug_print (arg1, arg2)
{
	if (!isdefined(arg2))
	{
		println("^5*************** ");
		println("^5*************** ", arg1);
		println("^5*************** ");
	}
	else
	{
		println("^5*************** ");
		println("^4*************** ", arg1, " " , arg2);
		println("^5*************** ");
	}
}

// --------------------------------------------------------------------------- //
// Type of Debug: Cvar                                                         //
// Prints Above the AI's head the type of field you want to print              //
// Updates every 0.5 seconds.                                                  //
// Created By: Mike                                                            //
// --------------------------------------------------------------------------- //
debug_ai_text()
{
	if(getcvar("debug_ai_text") == "")
	{
		setcvar("debug_ai_text","0");
	}

	text_use = false;

	while(1)
	{
		if(getcvar("debug_ai_text") != "0")
		{
//			axis = getaiarray("axis");
//			allies = getaiarray("allies");
//			ai = add_array_to_array(axis,allies);
//			neutral = getaiarray("neutral");

			ai = getaiarray();

//			dummies = getentarray("dummy","targetname");
//			if(isdefined(dummies) && dummies.size > 0)
//			{
//				ai = add_array_to_array(ai,dummies);
//			}
	
			for(i=0;i<ai.size;i++)
			{
				if(getcvar("debug_ai_text") == "origin")
				{
					text_use = true;
					text = ai[i].origin;
				}
				else if(getcvar("debug_ai_text") == "angles")
				{
					text_use = true;
					text = ai[i].angles;
				}
				else if(getcvar("debug_ai_text") == "pacifist")
				{
					text_use = true;
					text = ai[i].pacifist;
				}
				else if(getcvar("debug_ai_text") == "accuracy")
				{
					text_use = true;
					text = ai[i].accuracy;
				}
				else if(getcvar("debug_ai_text") == "health")
				{
					text_use = true;
					text = ai[i].health;
				}
				else if(getcvar("debug_ai_text") == "followmax")
				{
					text_use = true;
					text = ai[i].followmax;
				}
				else if(getcvar("debug_ai_text") == "followmin")
				{
					text_use = true;
					text = ai[i].followmin;
				}
				else if(getcvar("debug_ai_text") == "targetname")
				{
					text_use = true;
					text = ai[i].targetname;
				}
				else if(getcvar("debug_ai_text") == "groupname")
				{
					text_use = true;
					text = ai[i].groupname;
				}
				else if(getcvar("debug_ai_text") == "pacifistwait")
				{
					text_use = true;
					text = ai[i].pacifistwait;
				}
				else if(getcvar("debug_ai_text") == "favoriteenemy")
				{
					text_use = true;
					if (isdefined(ai[i].favoriteenemy))
					{
						if (ai[i].favoriteenemy == level.player)
						{
							text = "PLAYER";
						}
						else
						{
							if (isdefined(ai[i].favoriteenemy.targetname))
							{
								text = ai[i].favoriteenemy.targetname;
							}
							else
							{
								text = "NO TARGETNAME";
							}
						}
					}
					else
					{
						text = "undefined";
					}
				}
				else if(getcvar("debug_ai_text") == "bravery")
				{
					text_use = true;
					text = ai[i].bravery;
				}
				else if(getcvar("debug_ai_text") == "goalradius")
				{
					text_use = true;
					text = ai[i].goalradius;
				}
				else if(getcvar("debug_ai_text") == "suppressionwait")
				{
					text_use = true;
					text = ai[i].suppressionwait;
				}
				else if(getcvar("debug_ai_text") == "maxsightdistsqrd")
				{
					text_use = true;
					text = ai[i].maxsightdistsqrd;
				}
				else if(getcvar("debug_ai_text") == "flinch") // Specific to Trenches
				{
					text_use = true;
					text = ai[i].flinch;
				}
				else if(getcvar("debug_ai_text") == "animname")
				{
					text_use = true;
					text = ai[i].animname;
				}
				else if(getcvar("debug_ai_text") == "model")
				{
					text_use = true;
					text = ai[i].model;
				}
				else if(getcvar("debug_ai_text") == "anim_pose")
				{
					text_use = true;
					text = ai[i].anim_pose;
				}
				else if(getcvar("debug_ai_text") == "anim_movement")
				{
					text_use = true;
					text = ai[i].anim_movement;
				}
				else if(getcvar("debug_ai_text") == "anim_script")
				{
					text_use = true;
					text = ai[i].anim_script;
				}
				else if(getcvar("debug_ai_text") == "ignoreme")
				{
					text_use = true;
					text = ai[i].ignoreme;
				}
				else if(getcvar("debug_ai_text") == "dontavoidplayer")
				{
					text_use = true;
					text = ai[i].dontavoidplayer;
				}
				else if(getcvar("debug_ai_text") == "useable")
				{
					text_use = true;
					text = ai[i].useable;
				}
				else if(getcvar("debug_ai_text") == "dontdropweapon")
				{
					text_use = true;
					text = ai[i].dontdropweapon;
				}
				else if(getcvar("debug_ai_text") == "takedamage")
				{
					text_use = true;
					text = ai[i].takedamage;
				}
				else if(getcvar("debug_ai_text") == "threatbias")
				{
					text_use = true;
					text = ai[i].threatbias;
				}
				else if(getcvar("debug_ai_text") == "neutral")
				{
					text_use = true;
					text = ai[i].neutral;
				}
				else if(getcvar("debug_ai_text") == "script_squadname")
				{
					text_use = true;
					text = ai[i].script_squadname;
				}
				else if(getcvar("debug_ai_text") == "script_radius")
				{
					text_use = true;
					text = ai[i].script_radius;
				}
				else if(getcvar("debug_ai_text") == "walkdist")
				{
					text_use = true;
					text = ai[i].walkdist;
				}
				else if(getcvar("debug_ai_text") == "uniquename")
				{
					text_use = true;
					text = ai[i].script_uniquename;
				}
				else if(getcvar("debug_ai_text") == "script_noteworthy")
				{
					text_use = true;
					text = ai[i].script_noteworthy;
				}
				else if(getcvar("debug_ai_text") == "dropweapon")
				{
					text_use = true;
					text = ai[i].dropweapon;
				}
				else if(getcvar("debug_ai_text") == "team")
				{
					text_use = true;
					text = ai[i].team;
				}
				else if(getcvar("debug_ai_text") == "personalspace")
				{
					text_use = true;
					text = ai[i].personalspace;
				}
				else if(getcvar("debug_ai_text") == "interval")
				{
					text_use = true;
					text = ai[i].no_generic_dialogue;
				}
				else if(getcvar("debug_ai_text") == "anim_idleSet")
				{
					text_use = true;
					text = ai[i].anim_idleSet;
				}
				else
				{
					text_use = false;
				}

				if(text_use)
				{
					if(isdefined(text))
					{
						print3d((ai[i].origin + (0,0,100)), text,(1,1,1), 5, 1);
					}
					else
					{
						print3d((ai[i].origin + (0,0,100)), "undefined",(1,1,1), 5, 1);
					}
				}
			}
			wait 0.1;
		}
		else
		{
			wait 0.5;
		}
	}
}

// --------------------------------------------------------------------------- //
// Type of Debug: Cvar                                                         //
// For Modifying the fog parameters				               //
// Updates every 0.1 seconds.                                                  //
// Created By: Mike                                                            //
// --------------------------------------------------------------------------- //
debug_fog()
{
	if(getcvar("fog_modder") == "")
	{
		setcvar("fog_modder" , "0");
	}

	while(getcvar("fog_modder") != "1")
	{
		wait 0.5;
	}

	color[0] = 128;
	color[1] = 128;
	color[2] = 128;

	use_color[0] = color[0];
	use_color[1] = color[1];
	use_color[2] = color[2];

	set_color[0] = color[0];
	set_color[1] = color[1];
	set_color[2] = color[2];


	use_inner_radius = 500;
	inner_radius = use_inner_radius;

	use_outter_radius = 10000;
	outter_radius = use_outter_radius;

	if(getcvar("fog_red_inc") == "")
	{
		setcvar("fog_red_inc" , "0");
	}

	if(getcvar("fog_green_inc") == "")
	{
		setcvar("fog_green_inc" , "0");
	}

	if(getcvar("fog_blue_inc") == "")
	{
		setcvar("fog_blue_inc" , "0");
	}

	if(getcvar("fog_red_dec") == "")
	{
		setcvar("fog_red_dec" , "0");
	}

	if(getcvar("fog_green_dec") == "")
	{
		setcvar("fog_green_dec" , "0");
	}

	if(getcvar("fog_blue_dec") == "")
	{
		setcvar("fog_blue_dec" , "0");
	}

	if(getcvar("fog_outter_inc") == "")
	{
		setcvar("fog_outter_inc" , "0");
	}

	if(getcvar("fog_outter_dec") == "")
	{
		setcvar("fog_outter_dec" , "0");
	}

	if(getcvar("fog_inner_inc") == "")
	{
		setcvar("fog_inner_inc" , "0");
	}

	if(getcvar("fog_inner_dec") == "")
	{
		setcvar("fog_inner_dec" , "0");
	}

	if(getcvar("fog_radius_multiplier") == "")
	{
		setcvar("fog_radius_multiplier" , "100");

	}

	println("Fog multiplier = ", getCvarint("fog_radius_multiplier"));
	while(1)
	{
		if(getcvar("fog_red_inc") == "1")
		{
			setcvar("fog_red_inc" , "0");
			color[0]++; 
		}

		if(getcvar("fog_green_inc") == "1")
		{
			setcvar("fog_green_inc" , "0");
			color[1]++;
		}

		if(getcvar("fog_blue_inc") == "1")
		{
			setcvar("fog_blue_inc" , "0");
			color[2]++;
		}

		if(getcvar("fog_red_dec") == "1")
		{
			setcvar("fog_red_dec" , "0");
			color[0]--; 
		}

		if(getcvar("fog_green_dec") == "1")
		{
			setcvar("fog_green_dec" , "0");
			color[1]--;
		}

		if(getcvar("fog_blue_dec") == "1")
		{
			setcvar("fog_blue_dec" , "0");
			color[2]--;
		}

		if(getcvar("fog_outter_inc") == "1")
		{
			setcvar("fog_outter_inc" , "0");
			outter_radius += getCvarint("fog_radius_multiplier");
		}
	
		if(getcvar("fog_outter_dec") == "1")
		{
			setcvar("fog_outter_dec" , "0");
			outter_radius -= getCvarint("fog_radius_multiplier");
		}
	
		if(getcvar("fog_inner_inc") == "1")
		{
			setcvar("fog_inner_inc" , "0");
			inner_radius += getCvarint("fog_radius_multiplier");
		}
	
		if(getcvar("fog_inner_dec") == "1")
		{
			setcvar("fog_inner_dec" , "0");
			inner_radius -= getCvarint("fog_radius_multiplier");
		}

		// Update fog.
		if(color[0] != set_color[0] || color[1] != set_color[1] || color[2] != set_color[2] || outter_radius != use_outter_radius || inner_radius != use_inner_radius )
		{
			for(i=0;i<color.size;i++)
			{
				if(color[i] <= 0)
				{
					color[i] = 0;
					set_color[i] = 0;
				}
				else if(color[i] >= 255)
				{
					color[i] = 255;
					set_color[i] = 255;
				}
				set_color[i] = color[i];
				use_color[i] = (color[i] * 0.00390625);
			}

			diff1 = outter_radius - inner_radius;
			if(diff1 < 500)
			{
				inner_radius = use_inner_radius;
				outter_radius = use_outter_radius;
			}
			if(outter_radius <= 1000)
			{
				outter_radius = 1000;
				use_outter_radius = 1000;
			}
			else
			{
				use_outter_radius = outter_radius;
			}

			diff2 = outter_radius - inner_radius;
			if(diff2 < 500)
			{
				inner_radius = use_inner_radius;
				outter_radius = use_outter_radius;
			}
			else if(inner_radius <= 0)
			{
				inner_radius = 0;
				use_inner_radius = 0;
			}
			else
			{
				use_inner_radius = inner_radius;
			}

			println("");
			println("^5--- Fog Modifier ---");
			println("^1Red: ", color[0], " ^2Green: ", color[1], " ^4Blue: ", color[2]);
			println("Inner Radius: ", use_inner_radius);
			println("Outter Radius: ", use_outter_radius);
			println("");

			setCullFog (use_inner_radius, use_outter_radius, use_color[0], use_color[1], use_color[2], 0 );
		}

		wait 0.1;
	}
}

// --------------------------------------------------------------------------- //
// Type of Debug: Cvar                                                         //
// For Modifying the rotations on a brush model/model		               //
// Updates every 0.1 seconds.                                                  //
// Created By: Mike                                                            //
// --------------------------------------------------------------------------- //
debug_brushmodel()
{
	level thread debug_brushmodel_ender();

	level endon("stop_debug_brushmodel");

	if(getcvar("debug_brushmodel") == "" || getcvar("debug_brushmodel") != "-5")
	{
		setcvar("debug_brushmodel" , "-5");
	}

	if(getcvar("debug_brushname") != "")
	{
		setcvar("debug_brushname" , "mr_noname");
	}

	if(getcvar("debug_brushnum") != "")
	{
		setcvar("debug_brushnum" , "-5");
	}

	println("debug_brushmodel ", getcvar("debug_brushmodel"));
	while(getcvar("debug_brushmodel") != "1")
	{
		wait 0.5;
	}

	ent = debug_brushmodel_check();

	level thread debug_brushmodel_hud(ent);
	rotate = ent.angles;
	use_rotate = ent.angles;

	if(getcvar("pitch_inc") == "")
	{
		setcvar("pitch_inc" , "0");
	}

	if(getcvar("pitch_dec") == "")
	{
		setcvar("pitch_dec" , "0");
	}

	if(getcvar("yaw_inc") == "")
	{
		setcvar("yaw_inc" , "0");
	}

	if(getcvar("yaw_dec") == "")
	{
		setcvar("yaw_dec" , "0");
	}

	if(getcvar("roll_inc") == "")
	{
		setcvar("roll_inc" , "0");
	}

	if(getcvar("roll_dec") == "")
	{
		setcvar("roll_dec" , "0");
	}

	if(getcvar("debug_brush_rotate_multiplier") == "")
	{
		setcvar("debug_brush_rotate_multiplier" , "10");
	}

	if(getcvar("debug_brush_rotate_time") == "")
	{
		setcvar("debug_brush_rotate_time" , "0.25");
	}

	level thread debug_brushmodel_move(ent);

	while(1)
	{
		if(getcvar("pitch_inc") == "1")
		{
			setcvar("pitch_inc" , "0");
			rotate = ((rotate[0] + getcvarfloat("debug_brush_rotate_multiplier")), rotate[1], rotate[2]);
		}

		if(getcvar("pitch_dec") == "1")
		{
			setcvar("pitch_dec" , "0");
			rotate = ((rotate[0] - getcvarfloat("debug_brush_rotate_multiplier")), rotate[1], rotate[2]);
		}

		if(getcvar("yaw_inc") == "1")
		{
			setcvar("yaw_inc" , "0");
		rotate = (rotate[0], (rotate[1] + getcvarfloat("debug_brush_rotate_multiplier")), rotate[2]);
		}

		if(getcvar("yaw_dec") == "1")
		{
			setcvar("yaw_dec" , "0");
			rotate = (rotate[0], (rotate[1] - getcvarfloat("debug_brush_rotate_multiplier")), rotate[2]);
		}

		if(getcvar("roll_inc") == "1")
		{
			setcvar("roll_inc" , "0");
			rotate = (rotate[0], rotate[1], (rotate[2] + getcvarfloat("debug_brush_rotate_multiplier")));
		}

		if(getcvar("roll_dec") == "1")
		{
			setcvar("roll_dec" , "0");
			rotate = (rotate[0], rotate[1], (rotate[2] - getcvarfloat("debug_brush_rotate_multiplier")));
		}

		if(rotate[0] != use_rotate[0] || rotate[1] != use_rotate[1] || rotate[2] != use_rotate[2])
		{
			use_rotate = rotate;

			ent rotateto(use_rotate, getcvarfloat("debug_brush_rotate_time"), 0,0);	
			ent waittill("rotatedone");
		}

		wait 0.1;
	}
}

debug_brushmodel_move(ent)
{
	level endon("stop_debug_brushmodel");

	move = ent.origin;
	use_move = ent.origin;

	if(getcvar("x_inc") == "")
	{
		setcvar("x_inc" , "0");
	}

	if(getcvar("y_inc") == "")
	{
		setcvar("y_inc" , "0");
	}

	if(getcvar("z_inc") == "")
	{
		setcvar("z_inc" , "0");
	}

	if(getcvar("pitch_inc") == "")
	{
		setcvar("pitch_inc" , "0");
	}

	if(getcvar("x_dec") == "")
	{
		setcvar("x_dec" , "0");
	}

	if(getcvar("y_dec") == "")
	{
		setcvar("y_dec" , "0");
	}

	if(getcvar("z_dec") == "")
	{
		setcvar("z_dec" , "0");
	}

	if(getcvar("debug_brush_move_multiplier") == "")
	{
		setcvar("debug_brush_move_multiplier" , "32");
	}

	if(getcvarfloat("debug_brush_move_time") == "" || getcvarfloat("debug_brush_move_time") <= 0)
	{
		setcvar("debug_brush_move_time" , "0.5");
	}

	while(1)
	{
		if(getcvar("x_inc") == "1")
		{
			setcvar("x_inc" , "0");
			move = ((move[0] + getcvarfloat("debug_brush_move_multiplier")), move[1], move[2]);
		}
	
		if(getcvar("y_inc") == "1")
		{
			setcvar("y_inc" , "0");
			move = (move[0], (move[1] + getcvarfloat("debug_brush_move_multiplier")), move[2]);
		}
	
		if(getcvar("z_inc") == "1")
		{
			setcvar("z_inc" , "0");
			move = ( move[0], move[1], (move[2] + getcvarfloat("debug_brush_move_multiplier")));
		}
	
		if(getcvar("x_dec") == "1")
		{
			setcvar("x_dec" , "0");
			move = ((move[0] - getcvarfloat("debug_brush_move_multiplier")), move[1], move[2]);
		}
	
		if(getcvar("y_dec") == "1")
		{
			setcvar("y_dec" , "0");
			move = (move[0], (move[1] - getcvarfloat("debug_brush_move_multiplier")), move[2]);
		}
	
		if(getcvar("z_dec") == "1")
		{
			println("z_dec");
			setcvar("z_dec" , "0");
			move = ( move[0], move[1], (move[2] - getcvarfloat("debug_brush_move_multiplier")));
		}

//		if(move[0] != use_move[0] || move[1] != use_move[1] || move[2] != use_move[2])
		if(move != use_move)
		{
			use_move = move;

			ent moveTo(use_move, (getcvarfloat("debug_brush_move_time")), 0, 0);
			ent waittill("movedone");
		}
		wait 0.1;
	}
}

debug_brushmodel_check()
{
	level endon("stop_debug_brushmodel");

	while(!isdefined(ent))
	{
		i_delay = 9;
		while(getcvar("debug_brushname") == "mr_noname")
		{
			i_delay++;
			if(i_delay > 10)
			{
				i_delay = 0;
				println("^5(debug_brushmodel_rotate): Please insert 'debug_brushname' (targetname or groupname) for 'debug_brush_rotation'");
			}
			wait 0.5;
		}

		targetname = getentarray(getcvar("debug_brushname"),"targetname");
		groupname = getentarray(getcvar("debug_brushname"),"groupname");

		println("Targetname ",targetname);	
		println("groupname ",groupname);
		if(!isdefined(groupname[0]) && !isdefined(targetname[0]))
		{
			println("^5(debug_brushmodel_rotate): Sorry, no Targetname / Groupname found for '" + getcvar("debug_brushname") + "'");
		}
		else
		{
			if(isdefined(targetname[0]))
			{
				test_ent = targetname;			
			}
			else if(isdefined(groupname[0]))
			{
				test_ent = groupname;
			}
		}

		if(isdefined(test_ent))
		{
			if(test_ent.size > 1)
			{
				i_delay = 9;
				while(1)
				{
					i_delay++;
					if(i_delay > 10)
					{
						i_delay = 0;
						println("^3(debug_brushmodel_rotate): Please insert 'debug_brushnum' (targetname or groupname) for 'debug_brush_rotation'");
						println("^3Array Range: 0 - " + (test_ent.size -1));
					}
	
					if(getcvarint("debug_brushnum") >= 0)
					{
						ent = test_ent[getcvarint("debug_brushnum")];
						setcvar("debug_brushnum","-5");
						break;
					}
					wait 0.5;
				}
			}
			else
			{
				ent = test_ent[0];
			}

			if(ent.classname != "script_model" && ent.classname != "script_brushmodel")
			{
				ent = undefined;
				println("(debug_brushmodel_rotate): " + getcvar("debug_brushname") + " is not a 'script_model' or a 'script_brushmodel'");
			}
		}

		setcvar("debug_brushname", "mr_noname");
		wait 0.5;
	}

	return ent;
}

debug_brushmodel_ender()
{
	while(1)
	{
		if(getcvar("debug_brushmodel") == "0")
		{
			break;
		}
		wait 0.5;
	}

	println("stop_debug_brushmodel"); 
	level notify("stop_debug_brushmodel");

	setcvar("stop_debug_brushmodel" , "-5");

	wait 0.1;

	level thread debug_brushmodel();
}

debug_brushmodel_hud(ent)
{
	while(getcvar("debug_brushmodel") == "1")
	{
		if(!isdefined(level.hud_rotate_pitch))
		{
			level.hud_rotate_pitch = newHudElem();
			level.hud_rotate_pitch.alignX = "right";
			level.hud_rotate_pitch.alignY = "middle";
			level.hud_rotate_pitch.fontscale = "1";
			level.hud_rotate_pitch.x = 60;
			level.hud_rotate_pitch.y = 320;

			level.hud_rotate_pitch setText(&"GMI_DEBUG_BRUSHMODEL_ROTATE_PITCH");			
		}
	
		if(!isdefined(level.hud_rotate_pitch_value))
		{
			level.hud_rotate_pitch_value = newHudElem();
			level.hud_rotate_pitch_value.alignX = "left";
			level.hud_rotate_pitch_value.alignY = "middle";
			level.hud_rotate_pitch_value.fontscale = "1";
			level.hud_rotate_pitch_value.x = 60;
			level.hud_rotate_pitch_value.y = 320;
		}
	
		if(!isdefined(level.hud_rotate_yaw))
		{
			level.hud_rotate_yaw = newHudElem();
			level.hud_rotate_yaw.alignX = "right";
			level.hud_rotate_yaw.alignY = "middle";
			level.hud_rotate_yaw.fontscale = "1";
			level.hud_rotate_yaw.x = 60;
			level.hud_rotate_yaw.y = 335;

			level.hud_rotate_yaw setText(&"GMI_DEBUG_BRUSHMODEL_ROTATE_YAW");
		}
	
		if(!isdefined(level.hud_rotate_yaw_value))
		{
			level.hud_rotate_yaw_value = newHudElem();
			level.hud_rotate_yaw_value.alignX = "left";
			level.hud_rotate_yaw_value.alignY = "middle";
			level.hud_rotate_yaw_value.fontscale = "1";
			level.hud_rotate_yaw_value.x = 60;
			level.hud_rotate_yaw_value.y = 335;
		}
	
		if(!isdefined(level.hud_rotate_roll))
		{
			level.hud_rotate_roll = newHudElem();
			level.hud_rotate_roll.alignX = "right";
			level.hud_rotate_roll.alignY = "middle";
			level.hud_rotate_roll.fontscale = "1";
			level.hud_rotate_roll.x = 60;
			level.hud_rotate_roll.y = 350;

			level.hud_rotate_roll setText(&"GMI_DEBUG_BRUSHMODEL_ROTATE_ROLL");
		}
	
		if(!isdefined(level.hud_rotate_roll_value))
		{
			level.hud_rotate_roll_value = newHudElem();
			level.hud_rotate_roll_value.alignX = "left";
			level.hud_rotate_roll_value.alignY = "middle";
			level.hud_rotate_roll_value.fontscale = "1";
			level.hud_rotate_roll_value.x = 60;
			level.hud_rotate_roll_value.y = 350;
		}

		level.hud_rotate_pitch_value setValue(ent.angles[0]);
		level.hud_rotate_yaw_value setValue(ent.angles[1]);
		level.hud_rotate_roll_value setValue(ent.angles[2]);

		// Movement.

		if(!isdefined(level.hud_move_x))
		{
			level.hud_move_x = newHudElem();
			level.hud_move_x.alignX = "right";
			level.hud_move_x.alignY = "middle";
			level.hud_move_x.fontscale = "1";
			level.hud_move_x.x = 60;
			level.hud_move_x.y = 260;

			level.hud_move_x setText(&"GMI_DEBUG_BRUSHMODEL_MOVE_X");
		}
	
		if(!isdefined(level.hud_move_x_value))
		{
			level.hud_move_x_value = newHudElem();
			level.hud_move_x_value.alignX = "left";
			level.hud_move_x_value.alignY = "middle";
			level.hud_move_x_value.fontscale = "1";
			level.hud_move_x_value.x = 60;
			level.hud_move_x_value.y = 260;
		}
	
		if(!isdefined(level.hud_move_y))
		{
			level.hud_move_y = newHudElem();
			level.hud_move_y.alignX = "right";
			level.hud_move_y.alignY = "middle";
			level.hud_move_y.fontscale = "1";
			level.hud_move_y.x = 60;
			level.hud_move_y.y = 275;

			level.hud_move_y setText(&"GMI_DEBUG_BRUSHMODEL_MOVE_Y");
		}
	
		if(!isdefined(level.hud_move_y_value))
		{
			level.hud_move_y_value = newHudElem();
			level.hud_move_y_value.alignX = "left";
			level.hud_move_y_value.alignY = "middle";
			level.hud_move_y_value.fontscale = "1";
			level.hud_move_y_value.x = 60;
			level.hud_move_y_value.y = 275;
		}
	
		if(!isdefined(level.hud_move_z))
		{
			level.hud_move_z = newHudElem();
			level.hud_move_z.alignX = "right";
			level.hud_move_z.alignY = "middle";
			level.hud_move_z.fontscale = "1";
			level.hud_move_z.x = 60;
			level.hud_move_z.y = 290;

			level.hud_move_z setText(&"GMI_DEBUG_BRUSHMODEL_MOVE_Z");
		}
	
		if(!isdefined(level.hud_move_z_value))
		{
			level.hud_move_z_value = newHudElem();
			level.hud_move_z_value.alignX = "left";
			level.hud_move_z_value.alignY = "middle";
			level.hud_move_z_value.fontscale = "1";
			level.hud_move_z_value.x = 60;
			level.hud_move_z_value.y = 290;
		}

		x_value = ent.origin[0];
		y_value = ent.origin[1];
		z_value = ent.origin[2];

		level.hud_move_x_value setValue(x_value);
		level.hud_move_y_value setValue(y_value);
		level.hud_move_z_value setValue(z_value);

		wait 0.05;
	}

	if(isdefined(level.hud_rotate_pitch))
	{
		level.hud_rotate_pitch destroy();		
	}

	if(isdefined(level.hud_rotate_pitch_value))
	{
		level.hud_rotate_pitch_value destroy();
	}

	if(isdefined(level.hud_rotate_yaw))
	{
		level.hud_rotate_yaw destroy();
	}

	if(isdefined(level.hud_rotate_yaw_value))
	{
		level.hud_rotate_yaw_value destroy();
	}

	if(isdefined(level.hud_rotate_roll))
	{
		level.hud_rotate_roll destroy();
	}

	if(isdefined(level.hud_rotate_roll_value))
	{
		level.hud_rotate_roll_value destroy();
	}

	// Movement:
	if(isdefined(level.hud_move_x))
	{
		level.hud_move_x destroy();
	}

	if(isdefined(level.hud_move_y))
	{
		level.hud_move_y destroy();
	}

	if(isdefined(level.hud_move_z))
	{
		level.hud_move_z destroy();
	}

	if(isdefined(level.hud_move_x_value))
	{
		level.hud_move_x_value destroy();
	}

	if(isdefined(level.hud_move_y_value))
	{
		level.hud_move_y_value destroy();
	}

	if(isdefined(level.hud_move_z_value))
	{
		level.hud_move_z_value destroy();
	}
}

// --------------------------------------------------------------------------- //
// Type of Debug: Cvar                                                         //
// For Changing the music on the fly.				               //
// Updates every 0.25 seconds.                                                 //
// Created By: Mike                                                            //
// --------------------------------------------------------------------------- //
debug_music()
{
	if(getcvar("debug_music") == "")
	{
		setcvar("debug_music","0");
		current_music = 0;
	}
	else
	{
		current_music = getcvar("debug_music");
	}

	while(1)
	{
		if(getcvar("debug_music") != "0" && getcvar("debug_music") != current_music && getcvar("debug_music") != "-1")
		{
			musicstop(0.1);
			current_music = getcvar("debug_music");
			wait 0.25;
			musicplay(current_music);
		}
		else if(getcvar("debug_music") == "0")
		{
			setcvar("debug_music","-1");
			musicstop(0.1);
			current_music = 0;
		}
		wait 0.25;
	}
}

player_health_regen()
{
	wait 0.1; // Wait for a couple frames, so cheats are set.

	level.player endon("death");

	if(getcvarint("sv_cheats") < 1)
	{
		return;
	}

	if(getcvar("player_magic_bullet") == "")
	{
		setcvar("player_magic_bullet","0");
	}

	while(1)
	{
		while(getcvar("player_magic_bullet") == "1")
		{
			if(level.player.health < (level.player.maxhealth * 0.5))
			{
				level.player.health = level.player.maxhealth;
			}
			wait 0.1;
		}
		wait 0.5;
	}
	
}

add_array_to_array(array1, array2)
{
	if(!isdefined(array1) || !isdefined(array2))
	{
		println("^3(_debug_gmi::add_array_to_array)WARNING! WARNING!, ONE OF THE ARRAYS ARE NOT DEFINED");
		return;
	}

	array = array1;

	for(i=0;i<array2.size;i++)
	{
		array[array.size] = array2[i];
	}
	return array;
}