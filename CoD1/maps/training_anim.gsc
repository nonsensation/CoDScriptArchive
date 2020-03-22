#using_animtree("generic_human");
main()
{
	//"Private Martin, today you'll be navigating the obstacle course and doing weapons training." 
	level.scr_anim["foley"]["todayobstacle"] = (%training_foley_todayobstacle);
	level.scr_face["foley"]["todayobstacle"] = (%Training_facial_Foley_01_listenup);
	
	//"Before entering the obstacle course, read each of these important signs." 
	level.scr_anim["foley"]["readsigns"] = (%training_foley_readsigns);
	level.scr_face["foley"]["readsigns"] = (%Training_facial_Foley_02_beforestarting);

	
	//"You’ll notice that your current objective is highlighted. "
	level.scr_face["foley"]["readsigns"] = (%Training_facial_Foley_08_objectivehighlighted);

	//"In addition the location of your current objective is marked by the star on your compass."
	level.scr_face["foley"]["locationobjective"] = (%Training_facial_Foley_09_locationobjective);
	
	//"As you approach your current objective the star will move toward the center of your compass."
	level.scr_face["foley"]["approach"] = (%Training_facial_Foley_10_approach);
	
	//"Approach your current objective"
	level.scr_face["foley"]["approachobjective"] = (%Training_facial_Foley_11_approachobjective);


	//"Now step five paces to the left."
	level.scr_anim["foley"]["stepleft"] = (%training_foley_stepleft);
	level.scr_face["foley"]["stepleft"] = (%Training_facial_Foley_03_fivepacesleft);
	
	//"Try five paces to the right."
	level.scr_anim["foley"]["stepright"] = (%training_foley_stepright);
	level.scr_face["foley"]["stepright"] = (%Training_facial_Foley_04_fivetoright);
	  
	//"Five paces backwards."
	level.scr_anim["foley"]["backwards"] = (%training_foley_backwards);
	level.scr_face["foley"]["stepright"] = (%Training_facial_Foley_05_fivebackwards);
	
	//"And five paces forwards."
	level.scr_anim["foley"]["forwards"] = (%training_foley_forwards);
	level.scr_face["foley"]["forwards"] = (%Training_facial_Foley_06_fiveforwards);
	
	//"That's fine. Now check your objectives."
	level.scr_anim["foley"]["nowcheck"] = (%training_foley_nowcheck);
	level.scr_face["foley"]["nowcheck"] = (%Training_facial_Foley_07_checkobjectives);
	
	//"Excellent. Now notice that objective is checked off and you have a new objective."
	level.scr_anim["foley"]["checkedoff"] = (%training_foley_checkedoff);
	level.scr_face["foley"]["checkedoff"] = (%Training_facial_Foley_12_thatsit);
	
	//"Open the gate, Martin, and complete the obstacle course."
	level.scr_anim["foley"]["opengate"] = (%training_foley_opengate);
	level.scr_face["foley"]["opengate"] = (%Training_facial_Foley_13_opengate);
	
	//”Lets move gentlemen, this is not social function!"
	level.scr_anim["foley"]["letsmove"] = (%training_foley_letsmove);

	//"Crouch through those concrete pipes and under that barrier. Move it Elder!"
	level.scr_anim["foley"]["crouchthru"] = (%training_foley_crouchthru);

	//"Now jump over these barriers. Come on Elder."
	level.scr_anim["foley"]["nowjump"] = (%training_foley_nowjump);

	//"Private Martin, go through that door. Sgt Moody is going to take through Weapons training." 
	//(hint of disappointment and anger)
	level.scr_anim["foley"]["gothrudoor"] = (%training_foley_gothrudoor);

	//"The rest of you ladies stay right there."
	level.scr_anim["foley"]["ladiesstay"] = (%training_foley_ladiesstay);

	////////////////////
	//FOLEYS IDLE
	level.scr_anim["foley"]["breathing"][0] = (%training_foley_breathing_loop);
	
	//FOLEYS MOVEMENT ANIMS
	level.scr_anim["foley"]["unarmedwalk"]			= (%leaderwalk_cocky_idle);
	level.scr_anim["foley"]["unarmedrun"]			= (%unarmed_run_officer);
	level.scr_anim["foley"]["unarmedstand"]			= (%unarmed_standidle_officer);
	
	
	//PARACHUTE TRAINING JUMPER
	level.scr_anim["jumper"]["training_jump"] = (%training_guy_practicejump);
	
	////////////////////
	//MOODYS IDLE
	level.scr_anim["moody"]["breathing"][0] = (%training_foley_breathing_loop);
	
	//"Eyes up private, I'm up here..."
	level.scr_anim["moody"]["eyesup"] = (%training_moody_waving_Imuphere);
	
	
	//MOODY GENERIC TALKING 
	level.scr_anim["moody"]["talk1"] = (%training_moody_dialogue_idle1);
	level.scr_anim["moody"]["talk2"] = (%training_foley_talking_loopA);
	level.scr_anim["moody"]["talk3"] = (%training_foley_talking_loopB);
	level.scr_anim["moody"]["talk4"] = (%training_foley_readsigns);
	level.scr_anim["moody"]["talk5"] = (%training_foley_stepleft);
	level.scr_anim["moody"]["talk6"] = (%training_foley_stepright);
	level.scr_anim["moody"]["talk7"] = (%training_foley_backwards);
	level.scr_anim["moody"]["talk8"] = (%training_foley_forwards);
	level.scr_anim["moody"]["talk9"] = (%training_foley_nowcheck);
	
	//MOODYS FACIAL ANIMS
	level.scr_anim["moody"]["grabspringfield"] = (%Training_facial_Moody_011);
	level.scr_anim["moody"]["turntoleft"] = (%Training_facial_Moody_012);
	level.scr_anim["moody"]["nowADS"] = (%Training_facial_Moody_013);
	level.scr_anim["moody"]["youcandobusiness"] = (%Training_facial_Moody_014);
	level.scr_anim["moody"]["moveslower"] = (%Training_facial_Moody_015);
	level.scr_anim["moody"]["twomorerounds"] = (%Training_facial_Moody_016);
	level.scr_anim["moody"]["moreaccurateADS"] = (%Training_facial_Moody_017);
	level.scr_anim["moody"]["moveon"] = (%Training_facial_Moody_018);
	level.scr_anim["moody"]["exchangespringfield"] = (%Training_facial_Moody_019);
	level.scr_anim["moody"]["unlessyouvegot"] = (%Training_facial_Moody_020);
	
	level.scr_anim["moody"]["movetothefence"] = (%Training_facial_Moody_021_movethedefense);
	level.scr_anim["moody"]["youwillnotice"] = (%Training_facial_Moody_022_youwillnotice);
	level.scr_anim["moody"]["preceedthroughthat"] = (%Training_facial_Moody_023_persuetothatdoor);
	level.scr_anim["moody"]["inclosequarters"] = (%Training_facial_Moody_024_inclosequarters);
	level.scr_anim["moody"]["switchweapons"] = (%Training_facial_Moody_025_switchweapons);
	level.scr_anim["moody"]["fire3more"] = (%Training_facial_Moody_026_fire3more);
	level.scr_anim["moody"]["outstanding"] = (%Training_facial_Moody_027_nowstanding);
	level.scr_anim["moody"]["pickupgrenades"] = (%Training_facial_Moody_028_pickupgrenades);
	level.scr_anim["moody"]["movebehind"] = (%Training_facial_Moody_029_movebehind);
	level.scr_anim["moody"]["throwgrenade"] = (%Training_facial_Moody_030_rollgrenade);
	level.scr_anim["moody"]["allrightprivate"] = (%Training_facial_Moody_031_allrightprivate);
	level.scr_anim["moody"]["ifugethurt"] = (%Training_facial_Moody_032_ifugethurt);
	level.scr_anim["moody"]["movetomachineguns"] = (%Training_facial_Moody_033_movetomachineguns);
	level.scr_anim["moody"]["laststation"] = (%Training_facial_Moody_034_ourlaststation);
	level.scr_anim["moody"]["pickemup"] = (%Training_facial_Moody_035a_pickemup);
	level.scr_anim["moody"]["lotoffire"] = (%Training_facial_Moody_035b_lotoffire);
	level.scr_anim["moody"]["whenusee"] = (%Training_facial_Moody_036_whenusee);
	level.scr_anim["moody"]["explosives"] = (%Training_facial_Moody_037_lazerexplosives);
	level.scr_anim["moody"]["notestopwatch"] = (%Training_facial_Moody_038_notestopwatch);
	level.scr_anim["moody"]["fireinthehole"] = (%Training_facial_Moody_039_fireinthehole);
	level.scr_anim["moody"]["goodjob"] = (%Training_facial_Moody_040_goodjob);

	//ELDER GREETING
	level.scr_anim["elder"]["goodtosee"] = (%Training_facial_Elder_001_goodtoseeyou);
	level.scr_anim["elder"]["goodluck"] = (%Training_facial_Elder_002_goodluck);
	//(Elder facial exports have animation on the biped-head also. And his head was animated from a standing pose - combat stand)


	//FOLEY GENERIC TALKING
	level.scr_anim["foley"]["talkingA"] = (%training_foley_talking_loopA);
	level.scr_anim["foley"]["talkingB"] = (%training_foley_talking_loopB);

/*
training_soldier_wamup

Starts with the jogging_loop pose. It should play only once. The jogging_loop can be inserted before this clip, so character enters the scene, then he runs away or on a path.

training_soldier_jogging_loop 

training_soldier_situp_loop

training_soldier_situp_resting

training_soldier_pushup_loop

training_soldier_pushup_resting 

I think the guy behind Foley at the beginning could be either doing situps or pushups randomly (each time you play Training is different).  To the right where there is grass, one guy (or more) can start with the warm-up then jog back & forth.
*/

}

#using_animtree("animation_rig_wire_trainingjump");
jump_wire()
{
	level.scr_animtree["jump_wire"] = #animtree;

	level.scr_anim["jump_wire"]["training_jump"]		= (%training_wire_practicejump);
}


#using_animtree("animation_rig_gear_trainingjump");
jump_gear()
{
	level.scr_animtree["jump_gear"] = #animtree;

	level.scr_anim["jump_gear"]["training_jump"]		= (%training_gear_practicejump);
}
