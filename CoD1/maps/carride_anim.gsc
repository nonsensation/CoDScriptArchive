#using_animtree("generic_human");
main()
{
	//Moody Drive Peugeot
	level.scr_anim["moody"]["peugeot_hardleft"]		= (%peugeot_moody_drive_hardleft);	//moody makes a hard left turn
	level.scr_anim["moody"]["peugeot_hardright"]		= (%peugeot_moody_drive_hardright);	//moody makes a hard right turn
	level.scr_anim["moody"]["peugeot_idle"][1]		= (%peugeot_moody_drive_idleA);		//moody driving animation A
	level.scr_anim["moody"]["peugeot_idle"][2]		= (%peugeot_moody_drive_idleB);		//moody driving animation B
	level.scr_anim["moody"]["peugeot_idle"][3]		= (%peugeot_moody_drive_idleC);		//moody driving animation C
	level.scr_anim["moody"]["peugeot_reverse_start"]	= (%peugeot_moody_reverse_start);	//moody start car in reverse
	level.scr_anim["moody"]["peugeot_reverse_loop"]		= (%peugeot_moody_reverse_loop);	//moody driving reverse
	level.scr_anim["moody"]["peugeot_reverse_forward"]	= (%peugeot_moody_reverse_forward);	//moody puts car back into forward
	level.scr_anim["moody"]["peugeot_reverse_crash"]	= (%peugeot_moody_reverse_crash);	//moody crash and get out
	
	//Elder Passenget Peugeot
	level.scr_anim["elder"]["peugeot_idle_backleft"]	= (%peugeot_elder_idle_backleft);	//1- aims to back over left shoulder
	level.scr_anim["elder"]["peugeot_idle_backright"]	= (%peugeot_elder_idle_backright);	//2 - aims to back over right shoulder
	level.scr_anim["elder"]["peugeot_idle_left"]		= (%peugeot_elder_idle_left);		//3 - points gun out window to his left
	level.scr_anim["elder"]["peugeot_idle_right"]		= (%peugeot_elder_idle_right);		//4 - points gun out window to his right
	level.scr_anim["elder"]["peugeot_transition_L2R"]	= (%peugeot_elder_transition_L2R);	//5 - transition from pointing gun out left window to the right
	level.scr_anim["elder"]["peugeot_transition_R2L"]	= (%peugeot_elder_transition_R2L);	//6 - transition from pointing gun out right window to the left
	level.scr_anim["elder"]["peugeot_idle_back"]		= (%peugeot_elder_idle_back);		//7 - sits and looks over his right shoulder
	level.scr_anim["elder"]["peugeot_idle_calm"]		= (%peugeot_elder_idle_calm);		//calm forward
	level.scr_anim["elder"]["peugeot_reverse_start"]	= (%peugeot_elder_reverse_start);	//elder looks around while moody puts peugeot in reverse
	level.scr_anim["elder"]["peugeot_reverse_loop"]		= (%peugeot_elder_reverse_loop);	//elder riding in reverse
	level.scr_anim["elder"]["peugeot_reverse_forward"]	= (%peugeot_elder_reverse_forward);	//elder riding in reverse back to forward
	level.scr_anim["elder"]["peugeot_reverse_crash"]	= (%peugeot_elder_reverse_crash);	//elder crash and get out
	
	//Elder Drive Kubelwagon
	level.scr_anim["elder"]["kubelwagon_jumpin"]		= (%kubelwagon_elder_jumpin);		//elder jumps into the kubelwagon
	level.scr_anim["elder"]["kubelwagon_hotwire"]		= (%kubelwagon_elder_hotwire_loop);	//elder hotwire loop
	level.scr_anim["elder"]["kubelwagon_startcar"]		= (%carride_elder_011_Igotit );		//elder starts kubelwagon
	level.scr_anim["elder"]["kubelwagon_driveidle"][0]	= (%kubelwagon_elder_driveidleA);	//elder driving idle A
	level.scr_anim["elder"]["kubelwagon_driveidle"][1]	= (%kubelwagon_elder_driveidleB);	//elder driving idle B
	level.scr_anim["elder"]["kubelwagon_driveidle"][2]	= (%kubelwagon_elder_driveidleC);	//elder driving idle C
	level.scr_anim["elder"]["kubelwagon_hardleft"]		= (%kubelwagon_elder_drivehardleft);	//elder makes a hard left turn
	level.scr_anim["elder"]["kubelwagon_hardright"]		= (%kubelwagon_elder_drivehardright);	//elder makes a hard right turn
	level.scr_anim["elder"]["kubelwagon_idle"]		= (%kubelwagon_elder_drive_idle);	//elder idle as he waits in the car
	level.scr_anim["elder"]["kubelwagon_end"]		= (%kubelwagon_elder_drive_end);	//elder relax in car (follows the anim above)
	
	
	//Moody Passenger Kubelwagon
	level.scr_anim["moody"]["kubelwagon_jumpin"]		= (%kubelwagon_moody_jumpin);		//moody gets in the kubelwagon
	level.scr_anim["moody"]["kubelwagon_fire"]		= (%wagon_passenger_fire);		//moody sits on the passenger seat and shoots
	level.scr_anim["moody"]["kubelwagon_startcar"]		= (%carride_moody_057_dontgetit);	//moody does startcar animation
	level.scr_anim["moody"]["kubelwagon_idle_up"]		= (%wagon_passenger_idle_up);		//moodys idle while waiting for the hotwire
	level.scr_anim["moody"]["kubelwagon_uptosit"]		= (%kubelwagon_moody_up2sit);		//moody slides down into the seat
	level.scr_anim["moody"]["kubelwagon_sitidle"]		= (%kubelwagon_moody_sitidle);		//moody sits in the seat
	level.scr_anim["moody"]["kubelwagon_sit2hide"]		= (%kubelwagon_moody_sit2hide);		//mody goes to hide position
	level.scr_anim["moody"]["kubelwagon_hide2sit"]		= (%kubelwagon_moody_hide2sit);		//mody returns from hide position back to sitidle
	level.scr_anim["moody"]["kubelwagon_sit2up"]		= (%kubelwagon_moody_sit2up);		//transition from sitidle to idle_up
	level.scr_anim["moody"]["kubelwagon_sit2run"]		= (%kubelwagon_moody_sittorun);		//gets out of car and runs
	level.scr_anim["moody"]["kubelwagon_hideidle"]		= (%wagon_passenger_idle);		//keeps moodys head down in hide
}

dialogue_anims()
{
	//moody body anims
	level.scr_anim["moody"]["geezIdont"]			= (%carride_moody_047_geezIdont);
	level.scr_anim["moody"]["adios"]			= (%carride_moody_048_adios);
	level.scr_anim["moody"]["turnright"]			= (%carride_moody_061_turnright);
	level.scr_anim["moody"]["igottago"]			= (%carride_moody_066_Igottago);
	level.scr_anim["moody"]["wave"]				= (%dawn_peugeot_moody_wave);
	
	//elder body anims
	level.scr_anim["elder"]["thatsagerman"]			= (%carride_elder_003_thatsagerman);
	level.scr_anim["elder"]["whatthehell"]			= (%carride_elder_004_whatthehell);
	level.scr_anim["elder"]["hititgo"]			= (%carride_elder_005_hititgo);
	level.scr_anim["elder"]["oksarge"]			= (%carride_elder_017_oksarge);
	level.scr_anim["elder"]["restidle"]			= (%kubelwagon_elder_drive_restidle);
}

facial_anims()
{
	//moody facial anims
	level.scr_anim["face"]["shootbastards"]			= (%Carride_facial_Moody_047);
	level.scr_anim["face"]["adios"]				= (%Carride_facial_Moody_048);
	level.scr_anim["face"]["hopeitworks"]			= (%Carride_facial_Moody_049);
	level.scr_anim["face"]["stopem"]			= (%Carride_facial_Moody_050);
	level.scr_anim["face"]["volunteered"]			= (%Carride_facial_Moody_051);
	level.scr_anim["face"]["shutup"]			= (%Carride_facial_Moody_052);
	level.scr_anim["face"]["stealacar"]			= (%Carride_facial_Moody_053);
	level.scr_anim["face"]["coverhim"]			= (%Carride_facial_Moody_054);
	level.scr_anim["face"]["getdone"]			= (%Carride_facial_Moody_055);
	level.scr_anim["face"]["godsbusy"]			= (%Carride_facial_Moody_056);
	level.scr_anim["face"]["moody_kubelwagon_startcar"]	= (%Carride_facial_Moody_057);
	level.scr_anim["face"]["inthecar"]			= (%Carride_facial_Moody_058);
	level.scr_anim["face"]["steponit"]			= (%Carride_facial_Moody_059);
	level.scr_anim["face"]["comeonelder"]			= (%Carride_facial_Moody_060);
	level.scr_anim["face"]["turnright"]			= (%Carride_facial_Moody_061);
	level.scr_anim["face"]["getuskilled"]			= (%Carride_facial_Moody_062);
	level.scr_anim["face"]["clearedlines"]			= (%Carride_facial_Moody_063);
	level.scr_anim["face"]["Isaidslowdown"]			= (%Carride_facial_Moody_064);
	level.scr_anim["face"]["turnright"]			= (%Carride_facial_Moody_065);
	level.scr_anim["face"]["igottago"]			= (%Carride_facial_Moody_066);
	
	//elder facial anims
	level.scr_anim["face"]["thatsagerman"]			= (%carride_facial_elder_003_thatsagerman);
	level.scr_anim["face"]["whatthehell"]			= (%carride_facial_elder_004_whatthehell);
	level.scr_anim["face"]["hititgo"]			= (%carride_facial_elder_005_hititgo);
	level.scr_anim["face"]["ohheygreat"]			= (%carride_facial_elder_006_ohheygreat);
	level.scr_anim["face"]["icantbelieve"]			= (%carride_facial_elder_007_icantbelieve);
	level.scr_anim["face"]["onlywhenineed"]			= (%carride_facial_elder_008_onlywhenineed);
	level.scr_anim["face"]["workinsarge"]			= (%carride_facial_elder_009_workinsarge);
	level.scr_anim["face"]["ourfather"]			= (%carride_facial_elder_010_ourfather);
	level.scr_anim["face"]["elder_kubelwagon_startcar"]	= (%carride_facial_elder_011_igotit);
	level.scr_anim["face"]["iamdriving"]			= (%carride_facial_elder_012_iamdriving);
	level.scr_anim["face"]["whatsitlooklike"]		= (%carride_facial_elder_013_whatsitlooklike);
	level.scr_anim["face"]["youdidntfinishjob"]		= (%carride_facial_elder_014_youdidntfinishjob);
	level.scr_anim["face"]["ohyeahright"]			= (%carride_facial_elder_015_ohyeahright);
	level.scr_anim["face"]["yougotit"]			= (%carride_facial_elder_016_yougotit);
	level.scr_anim["face"]["oksarge"]			= (%carride_facial_elder_017_okiedoke);
}

#using_animtree("peugeot");
peugeot_load_anims()
{
	level.scr_animtree["peugeot"] = #animtree;
	//Peugeot steering wheel to match Moodys driving anims
	level.scr_anim["peugeot"]["wheel_idle"][1]		= (%peugeot_wheel_drive_idleA);
	level.scr_anim["peugeot"]["wheel_idle"][2]		= (%peugeot_wheel_drive_idleB);
	level.scr_anim["peugeot"]["wheel_idle"][3]		= (%peugeot_wheel_drive_idleC);
	level.scr_anim["peugeot"]["wheel_hardleft"]		= (%peugeot_wheel_drive_hardleft);
	level.scr_anim["peugeot"]["wheel_hardright"]		= (%peugeot_wheel_drive_hardright);
	
	//Peugeot player anims
 	level.scr_anim["peugeot"]["player_bounce_normal"]	= (%peugeot_player_bounce_normal);
 	level.scr_anim["peugeot"]["player_bounce_strong"]	= (%peugeot_player_bounce_strong);
	level.scr_anim["peugeot"]["player_lean_out"]		= (%peugeot_player_lean_out);
	level.scr_anim["peugeot"]["player_lean_backin"]		= (%peugeot_player_lean_backin);
	level.scr_anim["peugeot"]["player_death"]		= (%peugeot_player_bounce_deathposition);
	
	//Reverse anims
	level.scr_anim["peugeot"]["reverse_start"]		= (%peugeot_car_reverse_start);
	level.scr_anim["peugeot"]["reverse_loop"]		= (%peugeot_car_reverse_loop);
	level.scr_anim["peugeot"]["reverse_forward"]		= (%peugeot_car_reverse_forward);
	level.scr_anim["peugeot"]["reverse_crash"]		= (%peugeot_car_reverse_crash);
	
	//Steering wheel anims to match Moodys dialogue anims
	level.scr_anim["peugeot"]["wheel_geezIdont"]		= (%carride_wheel_047_geezIdont);
	level.scr_anim["peugeot"]["wheel_adios"]		= (%carride_wheel_048_adios);
}

#using_animtree("kubelwagon");
kubelwagon_load_anims()
{
	level.scr_animtree["kubealwagon"] = #animtree;
	level.scr_anim["kubelwagon"]["elderjumpin"]		= (%kubelwagon_car_elderjumpin);
	level.scr_anim["kubelwagon"]["moodyjumpin"]		= (%kubelwagon_car_moodyjumpin);
	level.scr_anim["kubelwagon"]["startcar"]		= (%kubelwagon_car_startcar);
	level.scr_anim["kubelwagon"]["driveidle"][0]		= (%kubelwagon_wheel_driveidleA);
	level.scr_anim["kubelwagon"]["driveidle"][1]		= (%kubelwagon_wheel_driveidleB);
	level.scr_anim["kubelwagon"]["driveidle"][2]		= (%kubelwagon_wheel_driveidleC);
	level.scr_anim["kubelwagon"]["hardleft"]		= (%kubelwagon_wheel_drivehardleft);
	level.scr_anim["kubelwagon"]["hardright"]		= (%kubelwagon_wheel_drivehardright);
	level.scr_anim["kubelwagon"]["player_bounce_normal"]	= (%kubelwagon_car_playerbounce);
 	level.scr_anim["kubelwagon"]["player_bounce_strong"]	= (%kubelwagon_car_playerbounce_strong);
}

#using_animtree("peugeot");
peugeot_anims(num)
{
	level endon ("ExitVehicle");
	self UseAnimTree(#animtree);
	switch (num)
	{
		case 1: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_idle"][num]);break;
		case 2: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_idle"][num]);break;
		case 3: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_idle"][num]);break;
		case 4: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_hardleft"]);break;
		case 5: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_hardright"]);break;
		case 6: self setanimknobrestart(level.scr_anim["peugeot"]["reverse_start"]);break;
		case 7: self setanimknobrestart(level.scr_anim["peugeot"]["reverse_loop"]);break;
		case 8: self setanimknobrestart(level.scr_anim["peugeot"]["reverse_forward"]);break;
		case 9: self setanimknobrestart(level.scr_anim["peugeot"]["reverse_crash"]);break;
		case 10: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_geezIdont"]);break;
		case 11: self setanimknobrestart(level.scr_anim["peugeot"]["wheel_adios"]);break;
	}
}

#using_animtree("peugeot");
peugeot_moveplayer(death)
{
	level endon ("ExitVehicle");
	self UseAnimTree(#animtree);
	
	if ( (isdefined (death)) && (death == "death") )
	{
		if (level.flags["OutWindow"] == true)
			self setanimknob(level.scr_anim["peugeot"]["player_lean_backin"]);
		self setanimknob(level.scr_anim["peugeot"]["player_death"]);
		return;
	}
	
	if (level.flags["OutWindow"] == true)
	{
		level.flags["OutWindow"] = false;
		self setflaggedanimknob("leandone",level.scr_anim["peugeot"]["player_lean_backin"]);
		return;
	}
	else
	{
		level.flags["OutWindow"] = true;
		self setflaggedanimknob("leandone",level.scr_anim["peugeot"]["player_lean_out"]);
		return;
	}
}

#using_animtree("peugeot");
peugeot_bumpy()
{
	level endon ("ExitVehicle");
	self UseAnimTree(#animtree);
	while (level.flags["bumpy"] == true)
	{
		speed = self getspeedmph();
		if(speed >= 40)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["peugeot"]["player_bounce_strong"]);
			self waittillmatch ("bouncedone","end");
		}
		else if(speed >= 10)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["peugeot"]["player_bounce_normal"]);
			self waittillmatch ("bouncedone","end");
		}
		else
		{
			wait 1.5;
		}
	}
}

#using_animtree("kubelwagon");
kubelwagon_bumpy()
{
	self UseAnimTree(#animtree);
	while (level.flags["bumpy"] == true)
	{
		speed = self getspeedmph();
		if(speed >= 40)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["kubelwagon"]["player_bounce_strong"]);
			self waittillmatch ("bouncedone","end");
		}
		else if(speed >= 10)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["kubelwagon"]["player_bounce_normal"]);
			self waittillmatch ("bouncedone","end");
		}
		else
		{
			wait 1.5;
		}
	}
}

moody_drive_setup()
{
	level.moody linkto(level.peugeot, "tag_driver");
	level.moody animscripts\shared::PutGunInHand("none");
}

driver_hardleft(delay, sound)
{
	if (isdefined(delay))
		wait (delay);
	
	if (level.flags["PlayerInKubel"] == true)
	{
		level notify ("Stop Elder Anims");
		level.kubelwagon thread kubelwagon_anims(3);
		level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_hardleft"]);
		if ( (isdefined(sound)) && (sound == "yes") )
			level.player playsound ("dirt_skid");
		
		level.elder waittillmatch ("animdone","end");
		thread elder_kubelwagon_idles();
	}
	else
	{
		level notify ("Stop Moody Anim");
		level.peugeot thread maps\carride_anim::peugeot_anims(4);
		level.moody animscripted("animdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_hardleft"]);
		if ( (isdefined(sound)) && (sound == "yes") )
			level.player playsound ("dirt_skid");
		
		level.moody waittillmatch ("animdone","end");
		thread moody_drive_idle();
	}
}

moody_driver_dialogue_anim(num)
{
	switch (num)
	{
		case 1: //Gee I don’t know, how about you try shoot'n the bastards.
			level notify ("Stop Moody Anim");
			level.peugeot thread maps\carride_anim::peugeot_anims(10);
			level.moody.scripted_dialogue = ("carride_Moody_047");
			level.moody.facial_animation = (level.scr_anim["face"]["shootbastards"]);
			level.moody animscripted("animdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["geezIdont"]);
			level.moody waittillmatch ("animdone","end");
			thread moody_drive_idle();
			break;
		case 2: //Adios amigos!
			level notify ("Stop Moody Anim");
			level.peugeot thread maps\carride_anim::peugeot_anims(11);
			level.moody.scripted_dialogue = ("carride_Moody_048");
			level.moody.facial_animation = (level.scr_anim["face"]["adios"]);
			level.moody animscripted("animdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["adios"]);
			level.moody waittillmatch ("animdone","end");
			thread moody_drive_idle();
			break;
	}
}

driver_hardright(delay, sound)
{
	if (isdefined(delay))
		wait (delay);
	
	if (level.flags["PlayerInKubel"] == true)
	{
		level notify ("Stop Elder Anims");
		level.kubelwagon thread kubelwagon_anims(4);
		level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_hardright"]);
		if ( (isdefined(sound)) && (sound == "yes") )
		{
			level.player playsound ("dirt_skid");
		}
		level.elder waittillmatch ("animdone","end");
		thread elder_kubelwagon_idles();
	}
	else
	{
		level notify ("Stop Moody Anim");
		level.peugeot thread maps\carride_anim::peugeot_anims(5);
		level.moody animscripted("animdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_hardright"]);
		if ( (isdefined(sound)) && (sound == "yes") )
		{
			level.player playsound ("dirt_skid");
		}
		level.moody waittillmatch ("animdone","end");
		thread moody_drive_idle();
	}
}

moody_reverse2forward()
{
	level notify ("Stop Elder Anims");
	level.peugeot thread maps\carride_anim::peugeot_anims(8);
	level.moody animscripted("reverseforwarddone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_forward"]);
	level.moodyanim = 0;
	level.player playsound ("dirt_skid");
	level.moody waittillmatch ("reverseforwarddone","end");
	thread moody_drive_idle();
	level.peugeot resumespeed(10);
	thread driver_hardright(2,"yes");
}

moody_drive_idle()
{
	level endon ("ExitVehicle");
	level endon ("Stop Moody Anim");
	while (1)
	{
		rand = (randomint(3) + 1);
		
		switch (level.moodyanim)
		{
			case 1:
				level.peugeot thread maps\carride_anim::peugeot_anims(6);
				level.moody animscripted("reversestartdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_start"]);
				level.player playsound ("dirt_skid");
				level.moody waittillmatch ("reversestartdone","end");
				level.moodyanim = 2;
				break;
			case 2:
				level.peugeot thread maps\carride_anim::peugeot_anims(7);
				level.moody animscripted("reverseloopdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
				level.moody waittillmatch ("reverseloopdone","end");
				break;
			default:
				level.peugeot thread maps\carride_anim::peugeot_anims(rand);
				level.moody animscripted("animdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_idle"][rand]);
				level.moody waittillmatch ("animdone","end");
				break;
		}
	}
}

elder_passenger_idle()
{	
	level endon ("ExitVehicle");
	level.elder linkto(level.peugeot, "tag_passenger");
	level.elder animscripts\shared::PutGunInHand("none");
	level.elder animscripts\shared::PutGunInHand("left");
	lastanim = (0);
	while (1)
	{
		if (level.elderanim != lastanim)
			thread elder_anim_intrans();
			
		lastanim = level.elderanim;
		switch (level.elderanim)
		{
			case 0:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_calm"]);
				level.elder animscripts\shared::PutGunInHand("left");
				break;
			case 1:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_backleft"]);
				level.elder animscripts\shared::PutGunInHand("right");
				break;
			case 2:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_backright"]);
				level.elder animscripts\shared::PutGunInHand("left");
				break;
			case 3:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_left"]);
				level.elder animscripts\shared::PutGunInHand("right");
				break;
			case 4:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_right"]);
				level.elder animscripts\shared::PutGunInHand("left");
				break;
			case 5:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_transition_L2R"]);
				level.elder animscripts\shared::PutGunInHand("left");
				break;
			case 6:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_transition_R2L"]);
				level.elder animscripts\shared::PutGunInHand("right");
				break;
			case 7:
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_idle_back"]);
				level.elder animscripts\shared::PutGunInHand("left");
				break;
			case 8:	//reverse start
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_reverse_start"]);
				level.elder animscripts\shared::PutGunInHand("left");
				thread play_rand_anim(9,undefined,undefined);
				break;
			case 9: //reverse loop
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_reverse_loop"]);
				break;
			case 10://reverse to forward
				level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_reverse_forward"]);
				thread play_rand_anim(0,undefined,undefined);
				break;
		}
		level.elder waittillmatch ("animdone","end");
	}
}

play_rand_anim( anim1, anim2, anim3)
{
	level notify ("NewElderAnim");
	level endon ("NewElderAnim");
	level endon ("PeugeotCrash");
	
	if (isdefined (anim1))
		diffanims[0] = (anim1);
	if (isdefined (anim2))
		diffanims[1] = (anim2);
	if (isdefined (anim3))
		diffanims[2] = (anim3);
	
	if (diffanims.size > 1)
	{
		while (1)
		{
			rand = (randomint(diffanims.size));
			level.elderanim = (diffanims[rand]);
			level.elder waittill ("animdone");
		}
	}
	else
	{
		level.elderanim = diffanims[0];
	}
}

elder_kubelwagon()
{
	level.elder linkto(level.kubelwagon, "tag_driver");
	
	//play anim for Elder to get in the kubelwagon
	//level.kubelwagon_model thread kubelwagon_anims(5);
	level.kubelwagon thread kubelwagon_anims(5);
	level.elder thread elder_dropgunnote();
	level.elder animscripted("elderjumpin", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_jumpin"]);
	level notify ("FloodSpawn");
	level.elder waittillmatch ("elderjumpin","end");
	//level.kubelwagon_model thread kubelwagon_anims(7); //waits for notify then plays startcar anim on kubelwagon
	level.kubelwagon thread kubelwagon_anims(7); //waits for notify then plays startcar anim on kubelwagon
	
	//play hotwire loop until it I set the flag true
	while (level.flags["KubelStart"] == false)
	{
		level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_hotwire"]);
		level.elder waittillmatch ("animdone","end");
	}
	
	//car started, play car start animation on Elder
	level notify ("StartCarAnims");
	level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_startcar"]);
	level.elder waittillmatch ("animdone","end");
	
	level.elder animscripts\shared::PutGunInHand("none");
	
	//Play idle animation until player gets in the car
	while (level.flags["PlayerInKubel"] == false)
	{
		level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_idle"]);
		level.elder waittillmatch ("animdone","end");
	}
	
	thread elder_kubelwagon_idles();
}

elder_kubelwagon_idles()
{
	level endon ("Elder Stop Anims");
	while (1)
	{
		rand = randomint(3);
		if (level.flags["elder_end"] == true)
		{
			level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_idle"]);
			level.elder waittillmatch ("animdone","end");
			level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_end"]);
		}
		else
		{
			level.kubelwagon thread kubelwagon_anims(rand);
			level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["kubelwagon_driveidle"][rand]);
		}
		level.elder waittillmatch ("animdone","end");
	}
}

moody_kubelwagon()
{
	level endon ("ExitVehicle");
	level.moody linkto(level.kubelwagon, "tag_passenger");
	
	//play anim for Moody to get in the kubelwagon
	//level.kubelwagon_model thread kubelwagon_anims(6);
	level.kubelwagon thread kubelwagon_anims(6);
	level.moody thread moody_fireonnote();
	level.moody animscripted("moodygetin", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_jumpin"]);
	level.moody waittillmatch ("moodygetin","end");
	self notify ("StopNotes");
	
	//wait until elder starts the car
	while (level.flags["KubelStart"] == false)
	{
		rand = randomint (6);
		if (rand == 0)
		{
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_fire"]);
			level.moody shoot();
		}
		else
		level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_idle_up"]);
		level.moody waittillmatch ("animdone","end");
	}
	
	//car started, play car start animation on Elder
	level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["moody_kubelwagon_startcar"], "carride_Moody_057", 1.0);
	level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_startcar"]);
	level.moody waittillmatch ("animdone","end");
	level notify ("CarStarted");
	
	//take another shot, then get in
	level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_idle_up"]);
	level.moody waittillmatch ("animdone","end");
	level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_fire"]);
	level.moody waittillmatch ("animdone","end");
	
	//have moody sit down into the seat now
	level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_uptosit"]);
	level.moody waittillmatch ("animdone","end");
	
	level notify ("KubelwagonStarted");
	
	level.moody animscripts\shared::PutGunInHand("none");
	firstlean = 1;
	while (1)
	{
		if (level.flags["KubelDuck_Moody"] == true)
		{
			randomnum = randomint(2);
			level.flags["KubelDuck_Moody"] = false;
			//Duck down
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_sit2hide"]);
			level.moody waittillmatch ("animdone","end");
			
			//stay down 1 time
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_hideidle"]);
			level.moody waittillmatch ("animdone","end");
			
			//sometimes stay down a little longer
			if (firstlean == 1)
			{
				firstlean = 0;
				level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_hideidle"]);
				level.moody waittillmatch ("animdone","end");
			}
			
			//sit back up
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_hide2sit"]);
		}
		else
		{
			//play idle
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["kubelwagon_sitidle"]);
		}
		level.moody waittillmatch ("animdone","end");
	}
}

#using_animtree("kubelwagon");
kubelwagon_anims(num)
{
	self UseAnimTree(#animtree);
	
	switch (num)
	{
		case 0: self setanimknobrestart(level.scr_anim["kubelwagon"]["driveidle"][num]); break;
		case 1: self setanimknobrestart(level.scr_anim["kubelwagon"]["driveidle"][num]); break;
		case 2: self setanimknobrestart(level.scr_anim["kubelwagon"]["driveidle"][num]); break;
		case 3: self setanim(level.scr_anim["kubelwagon"]["hardleft"]);break;
		case 4: self setanim(level.scr_anim["kubelwagon"]["hardright"]);break;
		case 5: self setanim(level.scr_anim["kubelwagon"]["elderjumpin"]);break;
		case 6: self setanim(level.scr_anim["kubelwagon"]["moodyjumpin"]);break;
		case 7:
			level waittill ("StartCarAnims");
			self setanimknob(level.scr_anim["kubelwagon"]["startcar"]);
			level.kubelwagon playsound ("kubel_start","startup");
			sound_ent = spawn ("script_origin",level.kubelwagon.origin);
			sound_ent playloopsound("kubel_idle_high");
			level.kubelwagon waittill ("startup");
			level waittill ("KubelMoving");
			sound_ent stoploopsound("kubel_idle_high");
			break;
	}
}

elder_dropgunnote()
{
	while (1)
	{
		self waittill ("elderjumpin", notetrack);
		if (notetrack == "drop gun")
		{
			self animscripts\shared::PutGunInHand("none");
			return;
		}
	}
}

moody_fireonnote()
{
	self endon ("StopNotes");
	while (1)
	{
		self waittill ("moodygetin", notetrack);
		if (notetrack == "fire")
			self shoot();
	}
}

elder_shoot(delay, length)
{
	level notify ("Stop Shooting");
	level endon ("Stop Shooting");
	if (delay > 0)
		wait (delay);
	
	thread elder_shoot_timer(length);
	while (1)
	{
		if (level.flags["ElderTrans"] == false)
			level.elder shoot();
		wait (0.0857);
	}
}

elder_shoot_timer(time)
{
	level endon ("Stop Shooting");
	wait (time);
	level notify ("Stop Shooting");
}

elder_anim_intrans()
{
	level.flags["ElderTrans"] = true;
	wait (0.3);
	level.flags["ElderTrans"] = false;
}