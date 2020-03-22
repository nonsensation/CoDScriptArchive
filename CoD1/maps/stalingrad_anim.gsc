#using_animtree("generic_human");
main()
{
// Explode deaths
	level.scr_anim["generic"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["generic"]["explode death back"] = %death_explosion_back13;			// Flies back 13 feet.
	level.scr_anim["generic"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["generic"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["generic"]["explode death right"] = %death_explosion_right13;

	level.scr_anim["generic"]["knockdown back"] = %stand2prone_knockeddown_back;
	level.scr_anim["generic"]["knockdown forward"] = %stand2prone_knockeddown_forward;
	level.scr_anim["generic"]["knockdown left"] = %stand2prone_knockeddown_left;
	level.scr_anim["generic"]["knockdown right"] = %stand2prone_knockeddown_right;
	level.scr_anim["generic"]["getup"]				= (%scripted_standwabble_A);


/*
	Flag guy that charges up the hill
	level.scr_animtree["flagrun"] = #animtree;
*/
	level.scr_anim["flagrun"]["trans"]			= (%flagrun_guy_run2crouch);
	level.scr_anim["flagrun"]["idle"][0]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["flagrun"]["death"]			= (%flagrun_guy_death);
	level.scr_anim["flagrun"]["deathidle"][0]	= (%flagrun_guy_deathidle);
	level.scr_anim["flagrun"]["pickup"]			= (%flagrun_guy_pickup);
	level.scr_anim["flagrun"]["crouchidle"][0]	= (%flagrun_guy_crouchidle);
	level.scr_anim["flagrun"]["crouchidle"][1]	= (%flagrun_guy_crouchtwitch);

	level.scr_character["flagrun"] = character\RussianArmyOfficer_flagwave ::main;

	
/*
sniper animations
play "transitionA" to get the character from the hidelowwallC pose(back to wall) to his scope adjustment idle "idleA".
play "transitionB" to get the character to look through the scope and 
	play "idleB" for him to adjust it agian in the new pose.
play "transitionC" to get the character to turn around to talk to player. 
play "fullbody60". 
play "idleC" to wait for mg42's to stop.
play "fullbody61".	
play "transitionD" to get the character into the AI lowwall aim pose... this animation has a notetrack to switch
the gun to right hand. run. 
play "fullbody62", pause with "holdidle", play "sniper63_fullbody".run. 
play "sniper64_fullbody" (standing pose).
at the building play "sniper67_fullbody" he should be in crouch fire pose.
*/
	level.scr_anim["sniper"]["transitionA"]	= (%sniper_hidelowwallC2sniperidleA);
	level.scr_anim["sniper"]["idleA"][0]	= (%sniperidleA);
	level.scr_anim["sniper"]["transitionB"]	= (%sniperidleA2sniperidleB);
	level.scr_anim["sniper"]["idleB"][0]	= (%sniperidleB);
	level.scr_anim["sniper"]["transitionC"]	= (%sniperidleB2sniperidleC);
	
	level.scr_anim["sniper"]["lookleft"]	= (%Sniper60_lookleft_fullbody);
	level.scr_anim["sniper"]["lookright"]	= (%Sniper60_lookright_fullbody);

	level.scr_anim["sniper"]["lookleft62"]	= (%stand_aim_look_left_90);
	level.scr_anim["sniper"]["lookright62"]	= (%stand_aim_look_right_90);

	level.scr_anim["sniper"]["fullbody60"]	= (%Sniper60_fullbody);
	level.scr_face["sniper"]["fullbody60"]	= (%facial_sniper_60);
	level.scrsound["sniper"]["fullbody60"]	= ("sniper_line60");
	
	level.scr_anim["sniper"]["idleC"][0]	= (%sniperidleC);
	level.scr_anim["sniper"]["idleD"][0]	= (%sniperidleC);
	level.scr_anim["sniper"]["fullbody61"]	= (%Sniper61_fullbody);
	level.scr_face["sniper"]["fullbody61"]	= (%facial_sniper_61);
	level.scrsound["sniper"]["fullbody61"]	= ("sniper_line61");
	level.scr_anim["sniper"]["transitionD"]	= (%sniperidleC2crouchaim);
	level.scr_anim["sniper"]["idleD"][0]	= (%sniperidleD);
	level.scr_anim["sniper"]["fullbody62"]	= (%sniper62_fullbody);
	level.scr_face["sniper"]["fullbody62"]	= (%facial_sniper_62);
	level.scrsound["sniper"]["fullbody62"]	= ("sniper_line62");
	level.scr_anim["sniper"]["holdidle"][0]	= (%sniper62_holdidle);
	level.scr_anim["sniper"]["fullbody63"]	= (%sniper63_fullbody);
	level.scr_face["sniper"]["fullbody63"]	= (%facial_sniper_63);
	level.scrsound["sniper"]["fullbody63"]	= ("sniper_line63");
	level.scr_anim["sniper"]["fullbody64"]	= (%sniper64_fullbody);
	level.scr_face["sniper"]["fullbody64"]	= (%facial_sniper_64);
	level.scrsound["sniper"]["fullbody64"]	= ("sniper_line64");
	level.scr_anim["sniper"]["fullbody64gogo"]	= (%sniper64_idle);
	level.scr_face["sniper"]["fullbody64gogo"]	= (%facial_sniper_63);
	level.scrsound["sniper"]["fullbody64gogo"]	= ("sniper_line63");
	level.scr_anim["sniper"]["fullbody64idle"][0] = (%sniper64_idle);
	level.scr_anim["sniper"]["fullbody67"]	= (%sniper67_fullbody);
	level.scr_face["sniper"]["fullbody67"]	= (%facial_sniper_67);
	level.scrsound["sniper"]["fullbody67"]	= ("sniper_line67");

	level.scr_anim["sniper"]["retaking redsquare"]	= (%LeadConscript_Line_72);
	level.scr_face["sniper"]["retaking redsquare"]	= (%facial_LeadConscript_Line_72);
	level.scrsound["sniper"]["retaking redsquare"]	= ("lead_conscript_line72");

	level.scr_notetrack["sniper"][0]["notetrack"] = ""; // Special for switching gun hands

	level.scr_character["sniper"] = character\RussianArmySniper ::main;


	/*
	Soldier getting a gun
	play "idle" to give a gun to a soldier and play gunwalk (gunguy) afterwards. 
	start this animation and the passoutgunguys idle at the same time...
	*/
	level.scr_anim["gunguy"]["gun"][0]	= (%gunpass_grab_gunguy);

	/*
	Soldier getting ammo
	play "idle" to give ammo to a soldier and play gunwalk (ammoguy) afterwards... 
	start this animation and the passoutammoguys idle at the same time...
	*/
	level.scr_anim["gunguy"]["ammo"][0]	= (%gunpass_grab_ammoguy);

	/*
	Other gunpass animations - waiting in line and walking up to get a gun or ammo.
	*/
/*	
	level.scr_anim["gunguy"]["idle"][0] = %gunpass_idlecrowd_A1; // For guys in the crowd.
	level.scr_anim["gunguy"]["idle"][1] = %gunpass_idlecrowd_A2;
	level.scr_anim["gunguy"]["move"][0] = %gunpass_stepforward_A1;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["gunguy"]["move"][1] = %gunpass_stepforward_A2;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["gunguy"]["move"][2] = %gunpass_stepforward_A3;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["gunguy"]["getgun"] =  %gunpass_walk_gunguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_gunguy
	level.scr_anim["gunguy"]["getammo"] = %gunpass_walk_ammoguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_ammoguy

*/
	level.scr_anim["gunguy"]["idle"][0]	= %gunpass_idlecrowd_A1; // For guys in the crowd.
	level.scr_face["gunguy"]["idle"][0]	= %facial_neutral; 	
	level.scr_anim["gunguy"]["idle"][1]	= %gunpass_idlecrowd_A2;
	level.scr_face["gunguy"]["idle"][1]	= %facial_fear01;
	level.scr_anim["gunguy"]["move"][0]	= %gunpass_stepforward_A1;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["gunguy"]["move"][0]	= %facial_neutral;
	level.scr_anim["gunguy"]["move"][1]	= %gunpass_stepforward_A2;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["gunguy"]["move"][1]	= %facial_fear01;
	level.scr_anim["gunguy"]["move"][2]	= %gunpass_stepforward_A3;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["gunguy"]["move"][2]	= %facial_fear02;
	level.scr_anim["gunguy"]["getgun"]	= %gunpass_walk_gunguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_gunguy
	level.scr_face["gunguy"]["getgun"]	= %facial_fear02;	
	level.scr_anim["gunguy"]["getammo"]	= %gunpass_walk_ammoguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_ammoguy
	level.scr_face["gunguy"]["getammo"]	= %facial_fear01;
	level.scr_anim["gunguy"]["gun"][0]	= %gunpass_grab_gunguy;
	level.scr_face["gunguy"]["gun"][0]	= %facial_neutral;
	level.scr_anim["gunguy"]["ammo"][0]	= %gunpass_grab_ammoguy;
	level.scr_face["gunguy"]["ammo"][0]	= %facial_panic01;

	/*
	woundgroupwalk (two guys carring another
	*/
	level.scr_anim["carrywalk1"]["idle"][0]		= (%woundgroupwalk_firstguy_idle);
	level.scr_anim["carrywalk1"]["pickup"]		= (%woundgroupwalk_firstguy_pickup);
	level.scr_anim["carrywalk1"]["walk"][0]		= (%woundgroupwalk_firstguy_carrywalk);
	level.scr_anim["carrywalk1"]["walk"][1]		= (%woundgroupwalk_firstguy_carrywalktwitch);

	level.scr_anim["carrywalk2"]["idle"][0]		= (%woundgroupwalk_secondguy_idle);
	level.scr_anim["carrywalk2"]["pickup"]		= (%woundgroupwalk_secondguy_pickup);
	level.scr_anim["carrywalk2"]["walk"][0]		= (%woundgroupwalk_secondguy_carrywalk);
	level.scr_anim["carrywalk2"]["walk"][1]		= (%woundgroupwalk_secondguy_carrywalktwitch);

	level.scr_anim["carrywalk3"]["idle"][0]		= (%woundgroupwalk_woundedguy_idle);
	level.scr_anim["carrywalk3"]["pickup"]		= (%woundgroupwalk_woundedguy_pickup);
	level.scr_anim["carrywalk3"]["walk"][0]		= (%woundgroupwalk_woundedguy_carrywalk);
	level.scr_anim["carrywalk3"]["walk"][1]		= (%woundgroupwalk_woundedguy_carrywalktwitch);

	/*
	unarmed walks for the long line of soldiers
	*/
	level.scr_anim["walkguy1"]["walk"]		= (%soldierwalk_cower_idle);
	level.scr_anim["walkguy1"]["walktwitch"]= (%soldierwalk_cower_twitch);
	level.scr_anim["walkguy2"]["walk"]		= (%soldierwalk_dazed_idle);
	level.scr_anim["walkguy2"]["walktwitch"]= (%soldierwalk_dazed_twitch);
	level.scr_anim["walkguy3"]["walk"]		= (%soldierwalk_stiff_idle);
	level.scr_anim["walkguy3"]["walktwitch"]= (%soldierwalk_stiff_twitch);

	/*
	gun walks for soldiers in trenches
	use these special walks after the soldiers are given either a gun or ammo....
	*/
	level.scr_anim["gunguy"]["crouchwalk"]			= (%gunwalk_crouchidle_gunguy);
	level.scr_anim["gunguy"]["crouchwalktwitch"]	= (%gunwalk_crouchtwitch_gunguy);
	level.scr_anim["gunguy"]["walk"]				= (%gunwalk_idle_gunguy);
	level.scr_anim["gunguy"]["walktwitch"]			= (%gunwalk_twitch_gunguy);
	level.scr_anim["gunguy"]["fullbody55"]			= (%LeadConscript_Line_55_fullbody);
	level.scrsound["gunguy"]["fullbody55"]			= ("lead_conscript_line55");
	level.scr_anim["gunguy"]["cower"][0]			= (%LeadConscript_coweridle);
	level.scr_anim["gunguy"]["fullbody56"]			= (%LeadConscript_Line_56_fullbody);
	level.scrsound["gunguy"]["fullbody56"]			= ("lead_conscript_line56");
	level.scr_anim["gunguy"]["getup"]				= (%scripted_standwabble_A);

	level.scr_animtree["ammoguy"] = #animtree;
	level.scr_anim["ammoguy"]["crouchwalk"]			= (%gunwalk_crouchidle_ammoguy);
	level.scr_anim["ammoguy"]["crouchwalktwitch"]	= (%gunwalk_crouchtwitch_ammoguy);
	level.scr_anim["ammoguy"]["walk"]				= (%gunwalk_idle_ammoguy);
	level.scr_anim["ammoguy"]["walktwitch"]			= (%gunwalk_twitch_ammoguy);
	level.scr_anim["ammoguy"]["getup"]				= (%scripted_standwabble_B);

	/*
	building commissar
	*/
	level.scr_anim["buildingcommissar"]["fullbody"]		= (%BuildingCommissar_fullbody);
	level.scr_face["buildingcommissar"]["fullbody"]		= (%facial_BuildingCommissar);
	level.scrsound["buildingcommissar"]["fullbody"]		= ("BuildingCommissar");
	level.scr_character["buildingcommissar"] = character\RussianArmyOfficer_AI ::main;

	/*
	commissar1
	*/
	level.scr_anim["commissar1"]["fullbody31"]		= (%commissar1_line_31_fullbody);
	level.scr_face["commissar1"]["fullbody31"]		= (%facial_commissar1_line_31);
	level.scrsound["commissar1"]["fullbody31"]		= ("commissar1_line31");
	level.scr_anim["commissar1"]["fullbody40"]		= (%commissar1_line_40_fullbody);
	level.scr_face["commissar1"]["fullbody40"]		= (%facial_commissar1_line_40);
	level.scrsound["commissar1"]["fullbody40"]		= ("commissar1_line40");

	/*
	commissar2
	*/
	level.scr_anim["commissar2"]["fullbody51"]		= (%commissar2_line_51_fullbody);
	level.scr_face["commissar2"]["fullbody51"]		= (%facial_commissar2_line_51);
	level.scrsound["commissar2"]["fullbody51"]		= ("commissar2_line51");
	level.scr_anim["commissar2"]["fullbody52"]		= (%commissar2_line_52_fullbody);
	level.scr_face["commissar2"]["fullbody52"]		= (%facial_commissar2_line_52);
	level.scrsound["commissar2"]["fullbody52"]		= ("commissar2_line52");

	/*
	commissar3
	*/
	level.scr_anim["commissar3"]["fullbody33"]		= (%commissar3_line_33_fullbody);
	level.scr_face["commissar3"]["fullbody33"]		= (%facial_commissar3_line_33);
	level.scrsound["commissar3"]["fullbody33"]		= ("commissar3_line33");
	level.scr_anim["commissar3"]["fullbody49"]		= (%commissar3_line_49_fullbody);
	level.scr_face["commissar3"]["fullbody49"]		= (%facial_commissar3_line_49);
	level.scrsound["commissar3"]["fullbody49"]		= ("commissar3_line49");

	/*
	commissar4
	*/
	level.scr_anim["commissar4"]["idle"][0]			= (%commissar4_line_32_fullbody);
	level.scr_face["commissar4"]["idle"][0]			= (%facial_commissar4_line_32);
	level.scrsound["commissar4"]["idle"][0]			= ("commissar4_line32");
	
	level.scr_anim["commissar4"]["idle"][1]			= (%commissar4_line_50_fullbody);
	level.scr_face["commissar4"]["idle"][1]			= (%facial_commissar4_line_50);
	level.scrsound["commissar4"]["idle"][1]			= ("commissar4_line50");
	
	level.scr_anim["commissar4"]["idle"][2]			= (%commissar4_line_51_fullbody);
	level.scr_face["commissar4"]["idle"][2]			= (%facial_commissar4_line_51);
	level.scrsound["commissar4"]["idle"][2]			= ("commissar4_line51");
	
	level.scr_anim["commissar4"]["idle"][3]			= (%commissar4_line_51_fullbody);
	level.scr_anim["commissar4"]["idle"][4]			= (%commissar4_line_50_fullbody);
	level.scr_anim["commissar4"]["idle"][5]			= (%commissar4_line_32_fullbody);
	
	level.scr_anim["commissar4"]["fullbody41"]		= (%commissar4_line_41_fullbody);
	level.scr_face["commissar4"]["fullbody41"]		= (%facial_commissar4_line_41);
	level.scrsound["commissar4"]["fullbody41"]		= ("commissar4_line41");
	
	level.scr_anim["commissar4"]["shellshock"]		= (%shellshocked_commissar_fullbody);
	level.scr_face["commissar4"]["shellshock"]		= (%facial_ShellshockCommissar);
	level.scrsound["commissar4"]["breaking through"]= ("shellshock_commissar");
	level.scr_character["commissar4"] = character\RussianArmyOfficer_AI ::main;
	// Shell shock commissar doesn't have many animations so I put him in with Commissar4 to give him stuff to do.
	
	// Boat tags for effects:
	level.boat_right_effect[0] = "metal";
	level.boat_right_tag   [0] = "TAG_metal_right01";
	level.boat_right_effect[1] = "metal";
	level.boat_right_tag   [1] = "TAG_metal_right02";
	level.boat_right_effect[2] = "metal";
	level.boat_right_tag   [2] = "TAG_metal_right03";
	level.boat_right_effect[3] = "metal";
	level.boat_right_tag   [3] = "TAG_metal_right04";
	level.boat_right_effect[4] = "metal";
	level.boat_right_tag   [4] = "TAG_flesh_right05";
	level.boat_right_effect[5] = "flesh";
	level.boat_right_tag   [5] = "TAG_flesh_right06";
	level.boat_right_effect[6] = "flesh";
	level.boat_right_tag   [6] = "TAG_flesh_right07";
	level.boat_right_effect[7] = "flesh";
	level.boat_right_tag   [7] = "TAG_metal_right08";
	level.boat_right_effect[8] = "metal";
	level.boat_right_tag   [8] = "TAG_metal_right09";
	level.boat_right_effect[9] = "metal";
	level.boat_right_tag   [9] = "TAG_metal_right10";

	level.boat_left_effect[0] = "metal";
	level.boat_left_tag   [0] = "TAG_metal_left01";
	level.boat_left_effect[1] = "metal";
	level.boat_left_tag   [1] = "TAG_metal_left02";
	level.boat_left_effect[2] = "flesh";
	level.boat_left_tag   [2] = "TAG_flesh_left03";
	level.boat_left_effect[3] = "metal";
	level.boat_left_tag   [3] = "TAG_metal_left04";
	level.boat_left_effect[4] = "flesh";
	level.boat_left_tag   [4] = "TAG_flesh_left05";
	level.boat_left_effect[5] = "flesh";
	level.boat_left_tag   [5] = "TAG_flesh_left06";
	level.boat_left_effect[6] = "flesh";
	level.boat_left_tag   [6] = "TAG_flesh_left07";
	level.boat_left_effect[7] = "flesh";
	level.boat_left_tag   [7] = "TAG_flesh_left08";
	level.boat_left_effect[8] = "flesh";
	level.boat_left_tag   [8] = "TAG_flesh_left09";
	level.boat_left_effect[9] = "metal";
	level.boat_left_tag   [9] = "TAG_metal_left10";
	level.boat_left_effect[10]= "metal";
	level.boat_left_tag   [10]= "TAG_metal_left11";
	level.boat_left_effect[11] = "metal";
	level.boat_left_tag   [11] = "TAG_metal_left12";
	level.boat_left_effect[12] = "metal";
	level.boat_left_tag   [12] = "TAG_metal_left13";	
	
	level.dust_left_tag  [0] = "TAG_dust_left01";
	level.dust_left_tag  [1] = "TAG_dust_left02";
	level.dust_left_tag  [2] = "TAG_dust_left03";
	level.dust_left_tag  [3] = "TAG_dust_left04";
	level.dust_left_tag  [4] = "TAG_dust_left05";
	
	level.dust_right_tag [0] = "TAG_dust_right01";
	level.dust_right_tag [1] = "TAG_dust_right02";
	level.dust_right_tag [2] = "TAG_dust_right03";
	level.dust_right_tag [3] = "TAG_dust_right04";
	level.dust_right_tag [4] = "TAG_dust_right05";

	// Special ESRB additions:
	level.boat_right_effect[5] = "ground";
//	level.boat_right_effect[6] = "ground";
//	level.boat_right_effect[7] = "ground";
	level.boat_left_effect[2] = "ground";
	level.boat_left_effect[4] = "ground";
//	level.boat_left_effect[5] = "ground";
	level.boat_left_effect[6] = "ground";
	level.boat_left_effect[7] = "ground";
//	level.boat_left_effect[8] = "ground";

//	level.scr_dyingguy["effect"][2] = "flesh";
	level.scr_dyingguy["effect"][0] = "ground";
	level.scr_dyingguy["effect"][1] = "flesh small";
	level.scr_dyingguy["sound"][0] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] = "bip01 l thigh";
	level.scr_dyingguy["tag"][1] = "bip01 head";
	level.scr_dyingguy["tag"][2] = "bip01 l calf";
	level.scr_dyingguy["tag"][3] = "bip01 pelvis";
	level.scr_dyingguy["tag"][4] = "tag_breastpocket_right";
	level.scr_dyingguy["tag"][5] = "bip01 l clavicle";

	large();

//	maps\stalingrad_anim::large_group(); maps\stalingrad_anim::drones(); 
	maps\stalingrad_anim::crateguy(); maps\stalingrad_anim::truckguy1(); 
	maps\stalingrad_anim::truckguy2(); maps\stalingrad_anim::truckguy3(); 
	maps\stalingrad_anim::leaderguy(); maps\stalingrad_anim::ppshguy(); 
	maps\stalingrad_anim::shoutguy(); maps\stalingrad_anim::pistolguy(); 
	maps\stalingrad_anim::groupA_guy01(); 
	maps\stalingrad_anim::groupA_guy01_back(); 
	maps\stalingrad_anim::groupA_guy02(); 
	maps\stalingrad_anim::groupA_guy02_back(); 
	maps\stalingrad_anim::groupA_guy03(); 
	maps\stalingrad_anim::groupA_guy03_back(); 
	maps\stalingrad_anim::groupB_jumpguy(); 
	maps\stalingrad_anim::back_jumpguy(); maps\stalingrad_anim::officerA(); 
	maps\stalingrad_anim::officerB(); maps\stalingrad_anim::officerC(); 
	maps\stalingrad_anim::groupC_guy01(); maps\stalingrad_anim::groupC_guy02(); 
	maps\stalingrad_anim::groupC_guy03(); maps\stalingrad_anim::groupD_guy01(); 
	maps\stalingrad_anim::groupE_guy01(); maps\stalingrad_anim::groupE_guy02(); 
	maps\stalingrad_anim::groupE_guy03();
	maps\stalingrad_anim::flag();
	maps\stalingrad_anim::flagwaver();
	maps\stalingrad_anim::flagwave();
	maps\stalingrad_anim::officerP();
	maps\stalingrad_anim::deadguy();
	maps\stalingrad_anim::floater();
	maps\stalingrad_anim::chestguy();
	maps\stalingrad_anim::sideguy();
	maps\stalingrad_anim::neckguy();
	maps\stalingrad_anim::groinguy();
//	maps\stalingrad_anim::leaderguy();
	maps\stalingrad_anim::lineofficer();
	maps\stalingrad_anim::spotter();
	maps\stalingrad_anim::wallguys();
	maps\stalingrad_anim::lineguys();
	maps\stalingrad_anim::mg42();
	
}

#using_animtree("animation_rig_largegroup20");
large()
{
	level.large_group["right"] = %largegroup_rightside;
	level.large_group["left"] = %largegroup_leftside;
	level.large_group["left ending"] = %largegroup_leftside2;
	level.large_group["left far dock"] = %largegroup_leftside3;
}

#using_animtree("stalingrad_flag");
flag()
{
	level.scr_animtree["flag"] = #animtree;
	level.scr_anim["flag"]["idle"][0]		= (%flagrun_flag_idle);
	level.scr_anim["flag"]["death"]			= (%flagrun_flag_death);
	level.scr_anim["flag"]["pickup"]		= (%flagrun_flag_pickup);
}

#using_animtree("stalingrad_flagwaver");
flagwaver()
{
	level.scr_animtree["flagwaver"] = #animtree;
	level.scr_anim["flagwaver"]["death"]			= (%flagrun_guy_death);
}

/*
#using_animtree("animation_rig_largegroup20");
large_group()
{
	level.large_group[0] = %largegroup_playerjetty_uptrench;
	level.large_group[1] = %largegroup_rightside;
	level.large_group[2] = %largegroup_rightside2;
	level.large_group[3] = %largegroup_leftside;
}

#using_animtree("stalingrad_drones");
drones()
{
	level.scr_anim["drone"]["walk"] = %soldierwalk_cower_idle;
	level.scr_anim["drone"]["walktwitch"] = %soldierwalk_cower_idle;
}
*/

/*
script model gunpass animations - waiting in line and walking up to get a gun or ammo.
*/
#using_animtree("stalingrad_lineguys");
lineguys()	// Used for the fake guy the player attaches to, to get through the crowd
{
	level.scr_animtree["lineguy"] = #animtree;
	level.scr_anim["lineguy"]["idle"][0]	= %gunpass_idlecrowd_A1; // For guys in the crowd.
	level.scr_anim["lineguy"]["idle"][1]	= %gunpass_idlecrowd_A2;
	level.scr_anim["lineguy"]["move"][0]	= %gunpass_stepforward_A1;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["lineguy"]["move"][1]	= %gunpass_stepforward_A2;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["lineguy"]["move"][2]	= %gunpass_stepforward_A3;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_anim["lineguy"]["getgun"]		= %gunpass_walk_gunguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_gunguy
	level.scr_anim["lineguy"]["getammo"]	= %gunpass_walk_ammoguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_ammoguy
	level.scr_anim["lineguy"]["gun"][0]		= %gunpass_grab_gunguy;
	level.scr_anim["lineguy"]["ammo"][0]	= %gunpass_idle_player;
	level.scr_face["lineguy"]["idle"][0]	= %gunpass_idlecrowd_A1; // For guys in the crowd.
	level.scr_face["lineguy"]["idle"][1]	= %gunpass_idlecrowd_A2;
	level.scr_face["lineguy"]["move"][0]	= %gunpass_stepforward_A1;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["lineguy"]["move"][1]	= %gunpass_stepforward_A2;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["lineguy"]["move"][2]	= %gunpass_stepforward_A3;	// For guys in the crowd.  Play as a scripted animation on the node you're stepping to.
	level.scr_face["lineguy"]["getgun"]		= %gunpass_walk_gunguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_gunguy
	level.scr_face["lineguy"]["getammo"]	= %gunpass_walk_ammoguy;		// To go from tag_guy00 to the beginning of %gunpass_grab_ammoguy
	level.scr_face["lineguy"]["gun"][0]		= %gunpass_grab_gunguy;
	level.scr_face["lineguy"]["ammo"][0]	= %gunpass_grab_ammoguy;
}

/*
animations for flaot ing dead guys
*/
#using_animtree("stalingrad_floaters");
floatguys()	
{
	level.scr_anim["floatguy"]["idleA"][0]	= %deadguys_floaterA_idle; 
	level.scr_anim["floatguy"]["idleB"][0]	= %deadguys_floaterB_idle;

}

/*
cowering wall guys
*/
#using_animtree("stalingrad_wallguys");
wallguys()
{
	level.scr_animtree["wallguy"] = #animtree;
	level.scr_anim["wallguy"]["idle"][0]		= (%hideLowWall_fetal);
	level.scr_face["wallguy"]["idle"][0]		= (%facial_fear01);
	level.scr_anim["wallguy"]["idleA"][0]		= (%hideLowWall_scaredA);
	level.scr_face["wallguy"]["idleA"][0]		= (%facial_panic01);
	level.scr_anim["wallguy"]["idleAweight"][0]	= 1.0;
	level.scr_anim["wallguy"]["idleA"][1]		= (%hideLowWall_scaredA_twitch);
	level.scr_face["wallguy"]["idleA"][1]		= (%facial_fear02);
	level.scr_anim["wallguy"]["idleAweight"][1]	= 0.3;
	level.scr_anim["wallguy"]["idleB"][0]		= (%hideLowWall_scaredB);
	level.scr_face["wallguy"]["idleB"][0]		= (%facial_fear01);
	level.scr_anim["wallguy"]["BtoA"]			= (%hideLowWall_scaredBtoA);
	level.scr_face["wallguy"]["BtoA"]			= (%facial_panic01);
	level.scr_anim["wallguy"]["AtoB"]			= (%hideLowWall_scaredAtoB);
	level.scr_face["wallguy"]["AtoB"]			= (%facial_fear02);

	level.scr_character["wallguy"] = character\RussianArmy_pants ::main;
}

/*
radio officer animations
play "idle"until I have dialogue to animate to...
attach "equipment_russian_fieldphone(parts)_headpiece" to his tagweaponleft.
the radio officer and the dead radioman should be alligned
with the first stalingrad wallnode on the left.
*/
#using_animtree("stalingrad_radio_officerP");
officerP()
{
	level.scr_animtree["officerP"] = #animtree;
	level.scr_anim["officerP"]["idle"][0]		= (%phone_officerP_talkA);
	level.scr_face["officerP"]["idle"][0]		= (%facial_Captain_line_58);;
	level.scr_anim["officerP"]["fullbody58"]	= (%phone_captain58_fullbody);
	level.scr_face["officerP"]["fullbody58"]	= (%facial_Captain_line_58);
	level.scrsound["officerP"]["fullbody58"]	= ("captain_line58");
	level.scr_anim["officerP"]["fullbody59"]	= (%phone_captain59_fullbody);
	level.scr_face["officerP"]["fullbody59"]	= (%facial_Captain_line_59);
	level.scrsound["officerP"]["fullbody59"]	= ("captain_line59");

	level.scr_character["officerP"] = character\RussianArmyOfficer_radio ::main;
}

/*
radio artillery spotter animations
play "idle"until I have dialogue to animate to...
play 'idle" between dialogues if you need him to wait for a response.
The last dialogue ends in the cower pose so you will need to play
the "cower"idle. Then play "transition"... after that you can play "idle" again.
attach "equipment_russian_fieldphone(parts)_headpiece" to his tagweaponleft.
the radio officer and the dead radioman should be alligned
with the first stalingrad wallnode on the left.
*/
#using_animtree("stalingrad_radio_spotter");
spotter()
{
	level.scr_animtree["spotter"] = #animtree;
	level.scr_anim["spotter"]["cower"][0]		= (%spotter_cover);
	level.scr_anim["spotter"]["transition"]		= (%spotter_cover2idle);
	level.scr_anim["spotter"]["idle"][0]		= (%spotter_idle);
	level.scr_anim["spotter"]["idle"][1]		= (%spotter_twitch);
	level.scr_anim["spotter"]["fullbody66"]		= (%fullbody_spotter66);
	level.scr_face["spotter"]["fullbody66"]		= (%facial_ArtillerySpotter_Line_66);
	level.scrsound["spotter"]["fullbody66"]		= ("artilleryspotter_line66");
	level.scr_anim["spotter"]["fullbody68"]		= (%fullbody_spotter68);
	level.scr_face["spotter"]["fullbody68"]		= (%facial_ArtillerySpotter_Line_68);
	level.scrsound["spotter"]["fullbody68"]		= ("artilleryspotter_line68");
	level.scr_anim["spotter"]["fullbody69"]		= (%fullbody_spotter69);
	level.scr_face["spotter"]["fullbody69"]		= (%facial_ArtillerySpotter_Line_69);
	level.scrsound["spotter"]["fullbody69"]		= ("artilleryspotter_line69");
	level.scr_anim["spotter"]["fullbody70"]		= (%fullbody_spotter70);
	level.scr_face["spotter"]["fullbody70"]		= (%facial_ArtillerySpotter_Line_70);
	level.scrsound["spotter"]["fullbody70"]		= ("artilleryspotter_line70");
	level.scr_anim["spotter"]["fullbody71"]		= (%fullbody_spotter71);
	level.scr_face["spotter"]["fullbody71"]		= (%facial_ArtillerySpotter_Line_71);
	level.scrsound["spotter"]["fullbody71"]		= ("artilleryspotter_line71");

	level.scr_character["spotter"] = character\RussianArmyOfficer_spotter ::main;
	level.scr_model["spotter"][0] = "xmodel/equipment_russian_fieldphone(parts)_pack_spotter";
	level.scr_tag["spotter"][0] = "TAG_ORIGIN";
}

/*
deadguy poses for stretchers and radio sequence.
radio- attach "equipment_russian_fieldphone(parts)_pack"to "phone_deadguy_deathpose" 
wounded- attach deadguys to the tag_origin in the stretcher xmodel.
*/
#using_animtree("stalingrad_deadguys");
deadguy()
{
	level.scr_animtree["deadguyA"] = #animtree;
	level.scr_animtree["deadguyB"] = #animtree;
	level.scr_animtree["deadguy_radio"] = #animtree;
	level.scr_anim["deadguyA"]["death"]		= (%wounded_deadposeA);
	level.scr_face["deadguyA"]["death"]		= (%facial_dead1);
	level.scr_anim["deadguyB"]["death"]		= (%wounded_deadposeB);
	level.scr_face["deadguyB"]["death"]		= (%facial_dead2);
	level.scr_anim["deadguy_radio"]["death"]		= (%phone_deadguy_deathpose);
	level.scr_face["deadguy_radio"]["death"]		= (%facial_dead4);

	level.scr_character["deadguyA"] = character\RussianArmyWoundedTunic ::main;
	level.scr_character["deadguyB"] = character\RussianArmyDead1 ::main;
	level.scr_character["deadguy_radio"] = character\RussianArmyRadioman_dead ::main;
}

/*
scripted_mg42gunner_pain
standMG42gunner_fire_forward_level
standMG42gunner_aim_forward_level
prone2crouch_straight
scripted_standwabble_B
scripted_standwabble_A

stand_death_neckdeath
stand_death_headchest_topple
*/
#using_animtree("stalingrad_mg42guys");
mg42()
{
	level.scr_animtree["german mg42owner"]		= #animtree;
	level.scr_anim["german mg42owner"]["intro"]	= (%prone2crouch_straight);
	level.scr_anim["german mg42owner"]["aim"][0]	= (%standMG42gunner_aim_forward_level);
	level.scr_anim["german mg42owner"]["fire"][0]	= (%standMG42gunner_fire_forward_level);
	
//	level.scr_anim["german mg42owner"]["death1"]	= (%stalingrad_death_mg42_rolldownhill);
//	level.scr_anim["german mg42owner"]["death2"]	= (%stalingrad_death_mg42_rolldownhill);	// This one never used?
	level.scr_anim["german mg42owner"]["death1"]	= (%death_explosion_back13);
	level.scr_anim["german mg42owner"]["death2"]	= (%death_explosion_back13);	// This one never used?

	level.scr_character["german mg42owner"] = character\RussianArmyWoundedTunic ::main;
}



/*
wounded guy - chest
attach chestguy to the tag_origin in the stretcher xmodel. 
*/
#using_animtree("stalingrad_wounded_chestguy");
chestguy()
{
	level.scr_animtree["chestguy"] = #animtree;
	level.scr_anim["chestguy"]["idle"][0]			= (%wounded_chestguy_idle);
	level.scr_face["chestguy"]["idle"][0]			= (%facial_pain);
	level.scr_anim["chestguy"]["idleweight"][0]	= 1.0;
	level.scr_anim["chestguy"]["idle"][1]			= (%wounded_chestguy_twitch);
	level.scr_face["chestguy"]["idle"][1]			= (%facial_pain02);
	level.scr_anim["chestguy"]["idleweight"][1]	= 1.0;

	level.scr_character["chestguy"] = character\RussianArmyWoundedTunic ::main;
}

/*
wounded guy - side
attach sideguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("stalingrad_wounded_sideguy");
sideguy()
{
	level.scr_animtree["sideguy"] = #animtree;
	level.scr_anim["sideguy"]["idle"][0]			= (%wounded_sideguy_idle);
	level.scr_face["sideguy"]["idle"][0]			= (%facial_pain);
	level.scr_anim["sideguy"]["idleweight"][0]	= 1.0;
	level.scr_anim["sideguy"]["idle"][1]			= (%wounded_sideguy_twitch);
	level.scr_face["sideguy"]["idle"][1]			= (%facial_yell02);
	level.scr_anim["sideguy"]["idleweight"][1]	= 1.0;

	level.scr_character["sideguy"] = character\RussianArmyDead2 ::main;
}

/*
wounded guy - neck
attach neckguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("stalingrad_wounded_neckguy");
neckguy()
{	
	level.scr_animtree["neckguy"] = #animtree;
	level.scr_anim["neckguy"]["idle"][0]			= (%wounded_neckguy_idle);
	level.scr_face["neckguy"]["idle"][0]			= (%facial_pain);
	level.scr_anim["neckguy"]["idleweight"][0]	= 1.0;
	level.scr_anim["neckguy"]["idle"][1]			= (%wounded_neckguy_twitch);
	level.scr_face["neckguy"]["idle"][1]			= (%facial_yell);
	level.scr_anim["neckguy"]["idleweight"][1]	= 1.0;

	level.scr_character["neckguy"] = character\RussianArmyWoundedTunic ::main;
}

/*
wounded guy - groin
attach groinguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("stalingrad_wounded_groinguy");
groinguy()
{
	level.scr_animtree["groinguy"] = #animtree;
	level.scr_anim["groinguy"]["idle"][0]			= (%wounded_groinguy_idle);
	level.scr_face["groinguy"]["idle"][0]			= (%facial_pain);
	level.scr_anim["groinguy"]["idleweight"][0]	= 1.0;
	level.scr_anim["groinguy"]["idle"][1]			= (%wounded_groinguy_twitch);
	level.scr_face["groinguy"]["idle"][1]			= (%facial_pain02);
	level.scr_anim["groinguy"]["idleweight"][1]	= 1.0;

	level.scr_character["groinguy"] = character\RussianArmyWoundedTunic ::main;
}

/*
Shouting guy on crate.
props_ he needs a megaphone in his right hand.
*/
#using_animtree("stalingrad_crateguy");
crateguy()
{	
	level.scr_animtree["crateguy"] = #animtree;
	level.scr_anim["crateguy"]["idle"][0]		= (%Leader_shout_A);
	level.scr_anim["crateguy"]["idle"][1]		= (%Leader_shout_B);
	level.scr_anim["crateguy"]["idle"][2]		= (%Leader_shout_C);
	level.scr_anim["crateguy"]["fullbody42"]		= (%megaphonecommissar_fullbody42);
	level.scr_face["crateguy"]["fullbody42"]		= (%facial_megaphonecommissar_line_42);
	level.scrsound["crateguy"]["fullbody42"]		= ("megaphonecommissar_line42");
	level.scr_anim["crateguy"]["fullbody43"]		= (%megaphonecommissar_fullbody43);
	level.scr_face["crateguy"]["fullbody43"]		= (%facial_megaphonecommissar_line_43);
	level.scrsound["crateguy"]["fullbody43"]		= ("megaphonecommissar_line43");
	level.scr_anim["crateguy"]["fullbody44"]		= (%megaphonecommissar_fullbody44);
	level.scr_face["crateguy"]["fullbody44"]		= (%facial_megaphonecommissar_line_44);
	level.scrsound["crateguy"]["fullbody44"]		= ("megaphonecommissar_line44");

	level.scr_character["crateguy"] = character\RussianArmyOfficer_shout2 ::main;
}

/*
flag waver on crate. Put him on the docks at the far shore (where the boat starts).
props_ he has a flag in his right hand and a megaphone in his left
*/
#using_animtree("stalingrad_flagwaver");
flagwave()
{	
	level.scr_animtree["flagwave"] = #animtree;
	level.scr_anim["flagwave"]["idle"][0]		= (%stalingrad_flagwaver_idle);


	level.scr_character["flagwave"] = character\RussianArmyOfficer_flagwave ::main;
}

/*
Guy passing out guns -back-
play "idle" to give a gun to a soldier and play "wait" to give the soldier more time to get to the node.
play "trans" when all the guns are gone, then play "endidle" for the rest of the time...
*/
#using_animtree("stalingrad_truckguy1");
truckguy1()
{	
	level.scr_animtree["truckguy1"] = #animtree;
	level.scr_anim["truckguy1"]["gun"][0]	= (%gunpass_idle_backguy);
	level.scr_face["truckguy1"]["gun"][0]	= (%facial_neutral);
	level.scr_anim["truckguy1"]["idle"][0]	= (%gunpass_waitidle_backguy);
	level.scr_face["truckguy1"]["idle"][0]	= (%facial_neutral);
	level.scr_anim["truckguy1"]["trans"]	= (%gunpass_transition_backguy);
	level.scr_face["truckguy1"]["trans"]	= (%facial_neutral);
	level.scr_anim["truckguy1"]["endidle"][0]	= (%gunpass_endidle_backguy);
	level.scr_face["truckguy1"]["endidle"][0]	= (%facial_neutral);

	level.scr_character["truckguy1"] = character\RussianArmyOfficer_giver ::main;
}

/*
Guy passing out guns -front-
play "idle" to give a gun to a soldier and play "wait" to give the soldier more time to get to the node...
play "trans" when all the guns are gone, then play "endidle" for the rest of the time...
*/
#using_animtree("stalingrad_truckguy2");
truckguy2()
{	
	level.scr_animtree["truckguy2"] = #animtree;
	level.scr_anim["truckguy2"]["gun"][0]	= (%gunpass_idle_frontguy);
	level.scr_face["truckguy2"]["gun"][0]	= (%facial_neutral);
	level.scr_anim["truckguy2"]["idle"][0]	= (%gunpass_waitidle_frontguy);
	level.scr_face["truckguy2"]["idle"][0]	= (%facial_neutral);
	level.scr_anim["truckguy2"]["trans"]	= (%gunpass_transition_frontguy);
	level.scr_face["truckguy2"]["trans"]	= (%facial_alert02);
	level.scr_anim["truckguy2"]["endidle"][0]	= (%gunpass_endidle_frontguy);
	level.scr_face["truckguy2"]["endidle"][0]	= (%facial_alert02);

	level.scr_character["truckguy2"] = character\RussianArmyOfficer_giver ::main;
}

/*
Guy passing out ammo 
    play "idle" to give ammo to a soldier and play "wait" to give the soldier more time to get to the node...
	play "endidle" when all the guns are gone, then play "endtwitch" for the rest of the time...
*/
#using_animtree("stalingrad_truckguy3");
truckguy3()
{	
	level.scr_animtree["truckguy3"] = #animtree;
	level.scr_anim["truckguy3"]["gun"][0]	= (%gunpass_idle_ammogiver);
	level.scr_face["truckguy3"]["gun"][0]	= (%facial_neutral);
	level.scr_anim["truckguy3"]["idle"][0]	= (%gunpass_waitidle_ammogiver);
	level.scr_face["truckguy3"]["idle"][0]	= (%facial_neutral);
	level.scr_anim["truckguy3"]["endidle"][0]	= (%gunpass_endidle_ammogiver);
	level.scr_face["truckguy3"]["endidle"][0]	= (%facial_neutral);
	level.scr_anim["truckguy3"]["endidleweight"][0]	= 1.0;
	level.scr_anim["truckguy3"]["endidle"][1]	= (%gunpass_endtwitch_ammogiver);
	level.scr_face["truckguy3"]["endidle"][1]	= (%facial_neutral);
	level.scr_anim["truckguy3"]["endidleweight"][1]	= 0.3;


	level.scr_character["truckguy3"] = character\RussianArmyOfficer_ammogiver ::main;
}

/*
leader anims WAVE LEFT HAND - put on right side of player
*/
#using_animtree("stalingrad_leaderguy");
leaderguy()
{	
	level.scr_animtree["leader"] = #animtree;
	level.scr_anim["leader"]["idle"][0]		= (%line_officerA_stand_twitchB);
	level.scr_anim["leader"]["idleweight"][0]	= 0.5;
	level.scr_anim["leader"]["idle"][1]		= (%line_officer_stand_idle);
	level.scr_anim["leader"]["idleweight"][1]	= 2;
	level.scr_anim["leader"]["idle"][2]		= (%line_officerA_stand_twitchA);
	level.scr_anim["leader"]["idleweight"][2]	= 0.5;
	level.scr_anim["leader"]["idle"][3]		= (%line_officerA_waveB);
	level.scr_anim["leader"]["idleweight"][3]	= 3;
	level.scr_anim["leader"]["walk"]			= (%leaderwalk_cocky_idle);
	level.scr_anim["leader"]["fire"]			= (%line_officerA_shoot);

	level.scr_face["leader"]["idle"][0]		= (%facial_alert01);
	level.scr_face["leader"]["idle"][1]		= (%facial_alert02);
	level.scr_face["leader"]["idle"][2]		= (%facial_alert01);
	level.scr_face["leader"]["idle"][3]		= (%facial_angst);

	level.scr_character["leader"] = character\RussianArmyOfficer ::main;
}

/*
lineofficer anims WAVE RIGHT HAND - put on left side of player
*/
#using_animtree("stalingrad_lineofficer");
lineofficer()
{	
	level.scr_animtree["lineofficer"] = #animtree;
	level.scr_anim["lineofficer"]["idle"][0]		= (%line_officerA_stand_twitchB);
	level.scr_anim["lineofficer"]["idleweight"][0]	= 0.5;
	level.scr_anim["lineofficer"]["idle"][1]		= (%line_officer_stand_idle);
	level.scr_anim["lineofficer"]["idleweight"][1]	= 2;
	level.scr_anim["lineofficer"]["idle"][2]		= (%line_officerA_stand_twitchA);
	level.scr_anim["lineofficer"]["idleweight"][2]	= 0.5;
	level.scr_anim["lineofficer"]["idle"][3]		= (%line_officerA_wave);
	level.scr_anim["lineofficer"]["idleweight"][3]	= 1;
	level.scr_anim["lineofficer"]["walk"]			= (%leaderwalk_cocky_idle);
	level.scr_anim["lineofficer"]["fire"]			= (%line_officerA_shoot);

	level.scr_face["lineofficer"]["idle"][0]		= (%facial_alert02);
	level.scr_face["lineofficer"]["idle"][1]		= (%facial_alert01);
	level.scr_face["lineofficer"]["idle"][2]		= (%facial_alert01);
	level.scr_face["lineofficer"]["idle"][3]		= (%facial_alert02);
	level.scr_face["lineofficer"]["fire"]			= (%facial_angst);

	level.scr_character["lineofficer"] = character\RussianArmyOfficer ::main;
}

/*
boat ride _ ppsh guy  _  TAG_ppshguy
 play "idle". play "duck" when mortars start. play "death" for the stukka attack.
props_ he needs a ppsh in his right hand.
*/
#using_animtree("stalingrad_ppshguy");
ppshguy()
{	
	level.scr_animtree["ppshguy"] = #animtree;
	level.scr_anim["ppshguy"]["idle"][0]	= (%boat_ppsh_idle);
	level.scr_anim["ppshguy"]["idleweight"][0]	= 1.5;
	level.scr_anim["ppshguy"]["idle"][1]	= (%boat_ppsh_twitch);
	level.scr_anim["ppshguy"]["idleweight"][1]	= 0.5;
	level.scr_anim["ppshguy"]["duck"]		= (%boat_ppsh_duck);
	level.scr_anim["ppshguy"]["death"]		= (%boat_ppsh_shootingdeath);
	
	level.scr_notetrack["ppshguy"][0]["notetrack"] = "fire";
	level.scr_notetrack["ppshguy"][0]["effect"] = "pistol";
	level.scr_notetrack["ppshguy"][0]["sound"] = "weap_ppsh_fire";
	level.scr_notetrack["ppshguy"][0]["selftag"] = "tag_flash";

//	level.scr_special_notetrack["ppshguy"][0]["notetrack"] = "fire";
//	level.scr_special_notetrack["ppshguy"][0]["sound"] = "weap_ppsh_fire";
	
	level.scr_notetrack["ppshguy"][1]["notetrack"] = "pain";
	level.scr_notetrack["ppshguy"][1]["sound"] = "allied_pain";
	
	level.scr_notetrack["ppshguy"][2]["notetrack"] = "fall";
	level.scr_notetrack["ppshguy"][2]["sound"] = "bodyfall_metal_large";
	
	level.scr_notetrack["ppshguy"][3]["notetrack"] = "bodyhit 0 (bip01 l thigh)";
	level.scr_notetrack["ppshguy"][3]["effect"] = "flesh";
	level.scr_notetrack["ppshguy"][3]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["ppshguy"][3]["selftag"] = "bip01 l thigh";

	level.scr_notetrack["ppshguy"][4]["notetrack"] = "bodyhit 1 (bip01 spine2)";
	level.scr_notetrack["ppshguy"][4]["effect"] = "flesh";
	level.scr_notetrack["ppshguy"][4]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["ppshguy"][4]["selftag"] = "Bip01 Spine2";

	level.scr_notetrack["ppshguy"][5]["notetrack"] = "bodyhit 2 (Bip01 Neck)";
	level.scr_notetrack["ppshguy"][5]["effect"] = "flesh";
	level.scr_notetrack["ppshguy"][5]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["ppshguy"][5]["selftag"] = "Bip01 Neck";

	// Special ESRB additions:
	level.scr_notetrack["ppshguy"][3]["effect"] = "ground";
	level.scr_notetrack["ppshguy"][4]["effect"] = "ground";
	level.scr_notetrack["ppshguy"][5]["effect"] = "ground";

	level.scr_character["ppshguy"] = character\RussianArmyOfficer_ppsh ::main;
}

/*
boat ride _ Shouting guy _  TAG_shoutguy
play "fullbody01", it should finish as the mortar hits. play "lookidle" 
to extend the pause before he starts talking again. play "fullbody02" to finish speech.
play "duck" for the first stukka attack and then "crouchidle" and "stukka" for the second. 
After the last stukka attack play "jump". play "standidle" until the boat reaches the dock.
When you are ready for them to leave play "climb"
props_ he needs a megaphone in his right hand and papers in the left.
*/

#using_animtree("stalingrad_shoutguy");
shoutguy()
{	
	level.scr_animtree["shoutguy"] = #animtree;

	level.scr_anim["shoutguy"]["fullbody 1"]	= (%boatmaster01_fullbody);
	level.scr_face["shoutguy"]["fullbody 1"]	= (%facial_boatmaster01);
	level.scrsound["shoutguy"]["fullbody 1"]	= ("boatmaster01");
	level.scr_anim["shoutguy"]["lookidle"][0]	= (%boatmaster_lookidle_fullbody);
	level.scr_anim["shoutguy"]["fullbody 2"]	= (%boatmaster02a_fullbody);
	level.scr_face["shoutguy"]["fullbody 2"]	= (%facial_boatmaster02a);
	level.scrsound["shoutguy"]["fullbody 2"]	= ("boatmaster02a");
	level.scr_anim["shoutguy"]["fullbody 3"]	= (%boatmaster02b_fullbody);
	level.scr_face["shoutguy"]["fullbody 3"]	= (%facial_boatmaster02b);
	level.scrsound["shoutguy"]["fullbody 3"]	= ("boatmaster02b");
	level.scr_anim["shoutguy"]["idle"][0]		= (%boat_shout_stand_idle);
	level.scr_face["shoutguy"]["idle"][0]		= (%facial_neutral);
	level.scr_anim["shoutguy"]["idleweight"][0]	= 3.5;
	level.scr_anim["shoutguy"]["idle"][1]		= (%boat_shout_stand_twitch);
	level.scr_face["shoutguy"]["idle"][1]		= (%facial_alert02);
	level.scr_anim["shoutguy"]["idleweight"][1]	= 0.5;
//	level.scr_anim["shoutguy"]["idle"][2]		= (%boat_shout_walk_idle);
	level.scr_anim["shoutguy"]["duck"]			= (%boat_shout_duck);
	level.scr_face["shoutguy"]["duck"]			= (%facial_panic01);
	level.scr_anim["shoutguy"]["stuka"]		= (%boat_shout_turn2crouch);
	level.scr_face["shoutguy"]["stuka"]		= (%facial_panic01);
	level.scr_anim["shoutguy"]["crouchidle"][0]	= (%boat_shout_crouch_idle);
	level.scr_face["shoutguy"]["crouchidle"][0]	= (%facial_panic01);
	level.scr_anim["shoutguy"]["jump"]			= (%boat_shout_jump);
	level.scr_face["shoutguy"]["jump"]			= (%facial_angst);
	level.scr_anim["shoutguy"]["standidle"][0]	= (%boat_shout_postjumpidle);
	level.scr_face["shoutguy"]["standidle"][0]	= (%facial_alert02);
	level.scr_anim["shoutguy"]["standidle"][1]	= (%boat_shout_postjumpidleB);
	level.scr_face["shoutguy"]["standidle"][1]	= (%facial_alert02);
	level.scr_anim["shoutguy"]["standidle"][2]	= (%boat_shout_postjumpidle);
	level.scr_face["shoutguy"]["standidle"][2]	= (%facial_angst);
	level.scr_anim["shoutguy"]["climb"]			= (%boat_shout_climbout);
	level.scr_face["shoutguy"]["climb"]			= (%facial_angst);
	level.scr_notetrack["shoutguy"][0]["notetrack"] = "step";
	level.scr_notetrack["shoutguy"][0]["sound"] = "step_walk_metal";

	level.scr_character["shoutguy"] = character\RussianArmyOfficer_shout1 ::main;
//	level.scr_model["shoutguy"][0] = "xmodel/woodgib_big";
//	level.scr_tag["shoutguy"][0] = "TAG_HELMETSIDE";
//	level.scr_model["shoutguy"][1] = "xmodel/woodgib_medium";
//	level.scr_tag["shoutguy"][1] = "TAG_BELT_FRONT";
}

/*
boat ride _ pistol guy _  TAG_pistolguy
play "idle" until mortar attack. play "duck" for the mortar attack and then "crouchidle".
play "stuka" for the stukka attack. After the last stukka attack play "jump". play "standidle" until the boat reaches the dock.
When you are ready for them to leave play "climb".
props_ he needs a pistol in his right hand.
*/

#using_animtree("stalingrad_pistolguy");
pistolguy()
{	
	level.scr_animtree["pistolguy"] = #animtree;
	level.scr_anim["pistolguy"]["idle"][0]			= (%boat_pistol_stand_idle);
	level.scr_anim["pistolguy"]["idleweight"][0]	= 1.0;
	level.scr_anim["pistolguy"]["idle"][1]			= (%boat_pistol_stand_twitch);
	level.scr_anim["pistolguy"]["idleweight"][1]	= 0.5;
	level.scr_anim["pistolguy"]["duck"]				= (%boat_pistol_duck);
	level.scr_anim["pistolguy"]["flinch"]			= (%boat_pistol_stand_twitch);
	level.scr_anim["pistolguy"]["crouchidle"][0]	= (%boat_pistol_crouch_idle);
	level.scr_anim["pistolguy"]["crouchidle"][1]	= (%boat_pistol_crouch_twitch);
	level.scr_anim["pistolguy"]["stuka"]			= (%boat_pistol_stukka);
	level.scr_anim["pistolguy"]["jump"]				= (%boat_pistol_jump);
	level.scr_face["pistolguy"]["jump"]				= (%facial_angst);
	level.scr_anim["pistolguy"]["standidle"][0]		= (%boat_pistol_postjumpidle);
	level.scr_face["pistolguy"]["standidle"][0]		= (%facial_alert02);
	level.scr_anim["pistolguy"]["standidle"][1]		= (%boat_pistol_postjumptwitch);
	level.scr_face["pistolguy"]["standidle"][1]		= (%facial_alert02);
	level.scr_anim["pistolguy"]["climb"]			= (%boat_pistol_climb);
	level.scr_face["pistolguy"]["climb"]			= (%facial_angst);
	level.scr_notetrack["pistolguy"][0]["notetrack"] = "fire";
	level.scr_notetrack["pistolguy"][0]["effect"] = "pistol";
	level.scr_notetrack["pistolguy"][0]["sound"] = "weap_luger_fire";
	level.scr_notetrack["pistolguy"][0]["selftag"] = "tag_flash";

	level.scr_special_notetrack["pistolguy"][0]["effect"] = "watersplash";
	level.scr_special_notetrack["pistolguy"][0]["tag"] = "TAG_pistolsplash01";
	level.scr_special_notetrack["pistolguy"][1]["effect"] = "watersplash";
	level.scr_special_notetrack["pistolguy"][1]["tag"] = "TAG_gpistolsplash02";
	level.scr_special_notetrack["pistolguy"][2]["effect"] = "watersplash";
	level.scr_special_notetrack["pistolguy"][2]["tag"] = "TAG_pistolsplash03";
	level.scr_special_notetrack["pistolguy"][3]["effect"] = "watersplash";
	level.scr_special_notetrack["pistolguy"][3]["tag"] = "TAG_pistolsplash04";
	level.scr_special_notetrack["pistolguy"][4]["effect"] = "watersplash";
	level.scr_special_notetrack["pistolguy"][4]["tag"] = "TAG_pistolsplash05";

	level.scr_notetrack["pistolguy"][1]["notetrack"] = "step";
	level.scr_notetrack["pistolguy"][1]["sound"] = "step_walk_metal";

	level.scr_character["pistolguy"] = character\RussianArmyOfficer ::main;
}

/*
boat ride _ officerA _  TAG_officerA, TAG_officerA01, TAG_officerA02
play "idle" until mortar attack. play "duck" for the mortar attack and play "idle" again.
play "duck for the first stukka and "stuka" for the second stukka attack. After the last 
stukka attack play "jump". play "idle" again. When you are ready for them to leave play "climb".
props_ he needs a pistol in his right hand.
*/

#using_animtree("stalingrad_officerA");
officerA()
{	
	level.scr_animtree["officerA"] = #animtree;
	level.scr_anim["officerA"]["idle"][0]			= (%boat_officerA_stand_idle);
	level.scr_anim["officerA"]["idleweight"][0]	= 0.5;
	level.scr_anim["officerA"]["idle"][1]			= (%boat_officerA_stand_idleB);
	level.scr_anim["officerA"]["idleweight"][1]	= 1.0;
	level.scr_anim["officerA"]["idle"][2]			= (%boat_officerA_stand_twitchA);
	level.scr_anim["officerA"]["idleweight"][2]	= 0.5;
	level.scr_anim["officerA"]["idle"][3]			= (%boat_officerA_stand_twitchB);
	level.scr_anim["officerA"]["idleweight"][3]	= 0.5;
	level.scr_anim["officerA"]["idle"][4]			= (%boat_officerA_stand_twitchC);
	level.scr_anim["officerA"]["idleweight"][4]	= 0.5;
	level.scr_anim["officerA"]["duck"]				= (%boat_officerA_duck);
	level.scr_anim["officerA"]["stuka"]			= (%boat_officerA_stukka);
	level.scr_anim["officerA"]["jump"]				= (%boat_officerA_jump);
	level.scr_anim["officerA"]["climb"]	    	= (%boat_officerA_climbout);
///	level.scr_anim["officerA"]["climb"][1]	    	= (%boat_officerA_wave);

	level.scr_anim["officerA"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["officerA"]["explode death"][1] = %balcony_fallloop_onback;

	level.scr_character["officerA"] = character\RussianArmyOfficer ::main;
}

/*
boat ride _ officerB _  TAG_officerB, TAG_officerB01
play "idle" until mortar attack. play "duck" for the mortar attack and then "crouchidle".
play "stuka" for the stukka attack. After the last stukka attack play "jump". play "standidle" again.
props_ he needs a pistol in his right hand.
*/

#using_animtree("stalingrad_officerB");
officerB()
{	
	level.scr_animtree["officerB"] = #animtree;
	level.scr_anim["officerB"]["idle"][0]			= (%boat_officerB_stand_idle);
	level.scr_anim["officerB"]["idleweight"][0]	= 1.5;
	level.scr_anim["officerB"]["idle"][1]			= (%boat_officerB_stand_twitch);
	level.scr_anim["officerB"]["idleweight"][1]	= 0.5;
	level.scr_anim["officerB"]["duck"]				= (%boat_officerB_duck);
	level.scr_anim["officerB"]["crouchidle"][0]	    = (%boat_officerB_crouch_idle);
	level.scr_anim["officerB"]["crouchidle"][1]	    = (%boat_officerB_crouch_twitch);
	level.scr_anim["officerB"]["stuka"]				= (%boat_officerB_stukka);
	level.scr_anim["officerB"]["jump"]				= (%boat_officerB_jump);
	level.scr_anim["officerB"]["climb"]				= (%boat_officerB_jump);

	level.scr_anim["officerB"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["officerB"]["explode death"][1] = %balcony_fallloop_onback;

	level.scr_character["officerB"] = character\RussianArmyOfficer_ppsh ::main;
}

/*
boat ride _ officerC _ TAG_officerC - this is a new ppsh officer to shoot jumping out guys!!!
play "idle" until mortar attack. play "duck" for the mortar attack and then "crouchidle".
play "stuka" for the stukka attack. After the last stukka attack play "jump". play "standidle" again.
props_ he needs a pistol in his right hand.
*/

#using_animtree("stalingrad_ppshguy");
officerC()
{	
	level.scr_animtree["officerC"] = #animtree;
	level.scr_anim["officerC"]["idle"][0]			= (%boat_ppshB_idle);
	level.scr_anim["officerC"]["idleweight"][0]	= 1.5;
	level.scr_anim["officerC"]["idle"][1]			= (%boat_ppshB_twitch);
	level.scr_anim["officerC"]["idleweight"][1]	= 0.5;
	level.scr_anim["officerC"]["duck"]				= (%boat_ppshB_duck);
	level.scr_anim["officerC"]["crouchidle"][0]	    = (%boat_ppshB_idle);
	level.scr_anim["officerC"]["crouchidle"][1]	    = (%boat_ppshB_twitch);
	level.scr_anim["officerC"]["stuka"]				= (%boat_ppshB_stukka);
	level.scr_anim["officerC"]["jump"]				= (%boat_ppshB_jump);
	level.scr_anim["officerC"]["climb"]				= (%boat_ppshB_jump);
	
	level.scr_anim["officerC"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["officerC"]["explode death"][1] = %balcony_fallloop_onback;
	
	level.scr_notetrack["officerC"][0]["notetrack"] = "fire";
	level.scr_notetrack["officerC"][0]["effect"] = "pistol";
	level.scr_notetrack["officerC"][0]["sound"] = "weap_ppsh_fire";
	level.scr_notetrack["officerC"][0]["selftag"] = "tag_flash";

	level.scr_special_notetrack["officerC"][0]["effect"] = "watersplash";
	level.scr_special_notetrack["officerC"][0]["tag"] = "TAG_ppshsplash01";
	level.scr_special_notetrack["officerC"][1]["effect"] = "watersplash";
	level.scr_special_notetrack["officerC"][1]["tag"] = "TAG_ppshsplash02";
	level.scr_special_notetrack["officerC"][2]["effect"] = "watersplash";
	level.scr_special_notetrack["officerC"][2]["tag"] = "TAG_ppshsplash03";
	level.scr_special_notetrack["officerC"][3]["effect"] = "watersplash";
	level.scr_special_notetrack["officerC"][3]["tag"] = "TAG_ppshsplash04";
	level.scr_special_notetrack["officerC"][4]["effect"] = "watersplash";
	level.scr_special_notetrack["officerC"][4]["tag"] = "TAG_ppshsplash05";

	level.scr_character["officerC"] = character\RussianArmyOfficer_ppsh ::main;
}


/*
boat ride _ groupA _  TAG_groupA
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "jump".
play standing"idle" until they reach the dock. play "climb" to get them off the boat.
*/
#using_animtree("stalingrad_groupA_guy01");
groupA_guy01()
{	
	level.scr_animtree["groupA_guy01"] = #animtree;
	level.scr_anim["groupA_guy01"]["idle"][0]		= (%groupA_standtwitch_guy01);
	level.scr_face["groupA_guy01"]["idle"][0]		= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["idle"][1]		= (%groupA_standidle_guy01);
	level.scr_face["groupA_guy01"]["idle"][1]		= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["ducktrans"]			= (%groupA_ducktrans_guy01);
	level.scr_face["groupA_guy01"]["ducktrans"]		= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["ducktransout"]		= (%groupA_ducktransout_guy01);
	level.scr_face["groupA_guy01"]["ducktransout"]		= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["duckidle"][0]		= (%groupA_duckidle_guy01);
	level.scr_face["groupA_guy01"]["duckidle"][0]		= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["duckflinch"]		= (%groupA_duckflinch_guy01);
	level.scr_face["groupA_guy01"]["duckflinch"]		= (%facial_panic01);
	level.scr_anim["groupA_guy01"]["duck"]			= (%groupA_duck_guy01);
	level.scr_face["groupA_guy01"]["duck"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["crouchidle"][0]	= (%groupA_crouchtwitch_guy01);
	level.scr_face["groupA_guy01"]["crouchidle"][0]	= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupA_guy01"]["crouchidle"][1]	= (%groupA_crouchidle_guy01);
	level.scr_face["groupA_guy01"]["crouchidle"][1]	= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupA_guy01"]["stuka"]			= (%groupA_stukkaattack_guy01);
	level.scr_face["groupA_guy01"]["stuka"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["jump"]			= (%groupA_jump_guy01);
	level.scr_face["groupA_guy01"]["jump"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["climb"]			= (%groupA_climbout_guy01);
	level.scr_face["groupA_guy01"]["climb"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["groupA_guy01"]["explode death"][1] = %balcony_fallloop_onback;

	level.scr_character["groupA_guy01"] = character\RussianArmy ::main;
}

/*
boat ride _ groupAback _ TAG_groupA01,TAG_groupA02
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "jump".
play standing"idle" until they reach the dock. play "climb" to get them off the boat.
*/
#using_animtree("stalingrad_groupA_back_guy01");
groupA_guy01_back()
{	
	level.scr_animtree["groupA_guy01_back"] = #animtree;
	level.scr_anim["groupA_guy01_back"]["idle"][0]		= (%groupA_standtwitch_guy01);
	level.scr_face["groupA_guy01_back"]["idle"][0]		= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["idle"][1]		= (%groupA_standidle_guy01);
	level.scr_face["groupA_guy01_back"]["idle"][1]		= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["ducktrans"]	= (%groupA_ducktrans_guy01);
	level.scr_face["groupA_guy01_back"]["ducktrans"]	= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["ducktransout"]	= (%groupA_ducktransout_guy01);
	level.scr_face["groupA_guy01_back"]["ducktransout"]	= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["duckidle"][0]	= (%groupA_duckidle_guy01);
	level.scr_face["groupA_guy01_back"]["duckidle"][0]	= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["duckflinch"]	= (%groupA_duckflinch_guy01);
	level.scr_face["groupA_guy01_back"]["duckflinch"]	= (%facial_panic01);
	level.scr_anim["groupA_guy01_back"]["duck"]			= (%groupA_duck_guy01);
	level.scr_face["groupA_guy01_back"]["duck"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["crouchidle"][0]= (%groupA_crouchtwitch_guy01);
	level.scr_face["groupA_guy01_back"]["crouchidle"][0]= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupA_guy01_back"]["crouchidle"][1]= (%groupA_crouchidle_guy01);
	level.scr_face["groupA_guy01_back"]["crouchidle"][1]= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupA_guy01_back"]["stuka"]		= (%groupA_stukkaattack_guy01);
	level.scr_face["groupA_guy01_back"]["stuka"]		= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["jump"]			= (%groupA_jump_background_guy01);
	level.scr_face["groupA_guy01_back"]["jump"]			= (%facial_fear01);
	level.scr_anim["groupA_guy01_back"]["climb"]		= (%groupA_climbout_background_guy01);
	level.scr_face["groupA_guy01_back"]["climb"]		= (%facial_fear01);

	level.scr_character["groupA_guy01_back"] = character\RussianArmy_nohat ::main;
}

/*
boat ride _ groupA _  TAG_groupA
*/
#using_animtree("stalingrad_groupA_guy02");
groupA_guy02()
{	
	level.scr_animtree["groupA_guy02"] = #animtree;
	level.scr_anim["groupA_guy02"]["idle"][0]		= (%groupA_standtwitch_guy02);
	level.scr_anim["groupA_guy02"]["idle"][1]		= (%groupA_standidle_guy02);
	level.scr_anim["groupA_guy02"]["ducktrans"]			= (%groupA_ducktrans_guy02);
	level.scr_anim["groupA_guy02"]["ducktransout"]		= (%groupA_ducktransout_guy02);
	level.scr_anim["groupA_guy02"]["duckidle"][0]		= (%groupA_duckidle_guy02);
	level.scr_anim["groupA_guy02"]["duckflinch"]		= (%groupA_duckflinch_guy02);
	level.scr_anim["groupA_guy02"]["duck"]			= (%groupA_duck_guy02);
	level.scr_anim["groupA_guy02"]["crouchidle"][0]	= (%groupA_crouchtwitch_guy02);
	level.scr_anim["groupA_guy02"]["crouchidle"][1]	= (%groupA_crouchidle_guy02);
	level.scr_anim["groupA_guy02"]["stuka"]			= (%groupA_stukkaattack_guy02);
	level.scr_anim["groupA_guy02"]["jump"]			= (%groupA_jump_guy02);
	level.scr_anim["groupA_guy02"]["climb"]			= (%groupA_climbout_guy02);

	level.scr_face["groupA_guy02"]["idle"][0]		= (%facial_fear01);
	level.scr_face["groupA_guy02"]["idle"][1]		= (%facial_fear01);
	level.scr_face["groupA_guy02"]["ducktrans"]		= (%facial_fear01);
	level.scr_face["groupA_guy02"]["ducktransout"]	= (%facial_fear01);
	level.scr_face["groupA_guy02"]["duckidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy02"]["duckflinch"]	= (%facial_panic01);
	level.scr_face["groupA_guy02"]["duck"]			= (%facial_fear01);
	level.scr_face["groupA_guy02"]["crouchidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy02"]["crouchidle"][1]	= (%facial_fear01);
	level.scr_face["groupA_guy02"]["stuka"]			= (%facial_fear01);
	level.scr_face["groupA_guy02"]["jump"]			= (%facial_fear01);
	level.scr_face["groupA_guy02"]["climb"]			= (%facial_fear01);

	level.scr_character["groupA_guy02"] = character\RussianArmy ::main;
}

/*
boat ride _ groupAback _ TAG_groupA01, TAG_groupA02
*/
#using_animtree("stalingrad_groupA_back_guy02");
groupA_guy02_back()
{	
	level.scr_animtree["groupA_guy02_back"] = #animtree;
	level.scr_anim["groupA_guy02_back"]["idle"][0]		= (%groupA_standtwitch_guy02);
	level.scr_anim["groupA_guy02_back"]["idle"][1]		= (%groupA_standidle_guy02);
	level.scr_anim["groupA_guy02_back"]["ducktrans"]		= (%groupA_ducktrans_guy02);
	level.scr_anim["groupA_guy02_back"]["ducktransout"]		= (%groupA_ducktransout_guy02);
	level.scr_anim["groupA_guy02_back"]["duckidle"][0]		= (%groupA_duckidle_guy02);
	level.scr_anim["groupA_guy02_back"]["duckflinch"]		= (%groupA_duckflinch_guy02);
	level.scr_anim["groupA_guy02_back"]["duck"]			= (%groupA_duck_guy02);
	level.scr_anim["groupA_guy02_back"]["crouchidle"][0]	= (%groupA_crouchtwitch_guy02);
	level.scr_anim["groupA_guy02_back"]["crouchidle"][1]	= (%groupA_crouchidle_guy02);
	level.scr_anim["groupA_guy02_back"]["stuka"]			= (%groupA_stukkaattack_guy02);
	level.scr_anim["groupA_guy02_back"]["jump"]			= (%groupA_jump_background_guy02);
	level.scr_anim["groupA_guy02_back"]["climb"]			= (%groupA_climbout_background_guy02);

	level.scr_face["groupA_guy02_back"]["idle"][0]		= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["idle"][1]		= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["ducktrans"]	= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["ducktransout"]	= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["duckidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["duckflinch"]	= (%facial_panic01);
	level.scr_face["groupA_guy02_back"]["duck"]			= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["crouchidle"][0]= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["crouchidle"][1]= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["stuka"]		= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["jump"]			= (%facial_fear01);
	level.scr_face["groupA_guy02_back"]["climb"]		= (%facial_fear01);

	level.scr_character["groupA_guy02_back"] = character\RussianArmy_nohat ::main;
}

/*
boat ride _ groupA _ TAG_groupA01, TAG_groupA02, TAG_groupA
*/	
#using_animtree("stalingrad_groupA_guy03");
groupA_guy03()
{	
	level.scr_animtree["groupA_guy03"] = #animtree;
	level.scr_anim["groupA_guy03"]["idle"][0]		= (%groupA_standtwitch_guy03);
	level.scr_anim["groupA_guy03"]["idle"][1]		= (%groupA_standidle_guy03);
	level.scr_anim["groupA_guy03"]["ducktrans"]			= (%groupA_ducktrans_guy03);
	level.scr_anim["groupA_guy03"]["ducktransout"]		= (%groupA_ducktransout_guy03);
	level.scr_anim["groupA_guy03"]["duckidle"][0]		= (%groupA_duckidle_guy03);
	level.scr_anim["groupA_guy03"]["duckflinch"]		= (%groupA_duckflinch_guy03);
	level.scr_anim["groupA_guy03"]["duck"]			= (%groupA_duck_guy03);
	level.scr_anim["groupA_guy03"]["crouchidle"][0]	= (%groupA_crouchtwitch_guy03);
	level.scr_anim["groupA_guy03"]["crouchidle"][1]	= (%groupA_crouchidle_guy03);
	level.scr_anim["groupA_guy03"]["death"]			= (%groupA_stukkaattack_guy03);

	level.scr_face["groupA_guy03"]["idle"][0]		= (%facial_fear01);
	level.scr_face["groupA_guy03"]["idle"][1]		= (%facial_fear01);
	level.scr_face["groupA_guy03"]["ducktrans"]		= (%facial_fear01);
	level.scr_face["groupA_guy03"]["ducktransout"]	= (%facial_fear01);
	level.scr_face["groupA_guy03"]["duckidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy03"]["duckflinch"]	= (%facial_panic01);
	level.scr_face["groupA_guy03"]["duck"]			= (%facial_fear01);
	level.scr_face["groupA_guy03"]["crouchidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy03"]["crouchidle"][1]	= (%facial_fear01);
	level.scr_face["groupA_guy03"]["stuka"]			= (%facial_fear01);
	level.scr_face["groupA_guy03"]["jump"]			= (%facial_fear01);
	level.scr_face["groupA_guy03"]["climb"]			= (%facial_fear01);

	level.scr_notetrack["groupA_guy03"][0]["notetrack"] = "bodyhit 0 (bip01 neck)";
	level.scr_notetrack["groupA_guy03"][0]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03"][0]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03"][0]["selftag"] = "Bip01 Neck";

	level.scr_notetrack["groupA_guy03"][1]["notetrack"] = "bodyhit 1 (bip01 spine2)";
	level.scr_notetrack["groupA_guy03"][1]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03"][1]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03"][1]["selftag"] = "Bip01 Spine2";

	level.scr_notetrack["groupA_guy03"][2]["notetrack"] = "bodyhit 2 (bip01 head)";
	level.scr_notetrack["groupA_guy03"][2]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03"][2]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03"][2]["selftag"] = "Bip01 Head";

	// Special ESRB additions:
	level.scr_notetrack["groupA_guy03"][0]["effect"] = "ground";
	level.scr_notetrack["groupA_guy03"][1]["effect"] = "ground";
	level.scr_notetrack["groupA_guy03"][2]["effect"] = "ground";

	level.scr_character["groupA_guy03"] = character\RussianArmy_pants ::main;
}

/*
boat ride _ groupA _ TAG_groupA01, TAG_groupA02, TAG_groupA
*/	
#using_animtree("stalingrad_groupA_guy03");
groupA_guy03_back()
{	
	level.scr_animtree["groupA_guy03_back"] = #animtree;
	level.scr_anim["groupA_guy03_back"]["idle"][0]		= (%groupA_standtwitch_guy03);
	level.scr_anim["groupA_guy03_back"]["idle"][1]		= (%groupA_standidle_guy03);
	level.scr_anim["groupA_guy03_back"]["ducktrans"]			= (%groupA_ducktrans_guy03);
	level.scr_anim["groupA_guy03_back"]["ducktransout"]		= (%groupA_ducktransout_guy03);
	level.scr_anim["groupA_guy03_back"]["duckidle"][0]		= (%groupA_duckidle_guy03);
	level.scr_anim["groupA_guy03_back"]["duckflinch"]		= (%groupA_duckflinch_guy03);
	level.scr_anim["groupA_guy03_back"]["duck"]			= (%groupA_duck_guy03);
	level.scr_anim["groupA_guy03_back"]["crouchidle"][0]	= (%groupA_crouchtwitch_guy03);
	level.scr_anim["groupA_guy03_back"]["crouchidle"][1]	= (%groupA_crouchidle_guy03);
	level.scr_anim["groupA_guy03_back"]["death"]			= (%groupA_stukkaattack_guy03);

	level.scr_face["groupA_guy03_back"]["idle"][0]		= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["idle"][1]		= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["ducktrans"]		= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["ducktransout"]	= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["duckidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["duckflinch"]	= (%facial_panic01);
	level.scr_face["groupA_guy03_back"]["duck"]			= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["crouchidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["crouchidle"][1]	= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["stuka"]			= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["jump"]			= (%facial_fear01);
	level.scr_face["groupA_guy03_back"]["climb"]			= (%facial_fear01);

	level.scr_notetrack["groupA_guy03_back"][0]["notetrack"] = "bodyhit 0 (bip01 neck)";
	level.scr_notetrack["groupA_guy03_back"][0]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03_back"][0]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03_back"][0]["selftag"] = "Bip01 Neck";

	level.scr_notetrack["groupA_guy03_back"][1]["notetrack"] = "bodyhit 1 (bip01 spine2)";
	level.scr_notetrack["groupA_guy03_back"][1]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03_back"][1]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03_back"][1]["selftag"] = "Bip01 Spine2";

	level.scr_notetrack["groupA_guy03_back"][2]["notetrack"] = "bodyhit 2 (bip01 head)";
	level.scr_notetrack["groupA_guy03_back"][2]["effect"] = "flesh";
	level.scr_notetrack["groupA_guy03_back"][2]["sound"] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_notetrack["groupA_guy03_back"][2]["selftag"] = "Bip01 Head";

	// Special ESRB additions:
	level.scr_notetrack["groupA_guy03_back"][0]["effect"] = "ground";
	level.scr_notetrack["groupA_guy03_back"][1]["effect"] = "ground";
	level.scr_notetrack["groupA_guy03_back"][2]["effect"] = "ground";

	level.scr_character["groupA_guy03_back"] = character\RussianArmy_pants ::main;
}

/*
boat ride _ groupB _  TAG_jumpguy
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "death"
*/

#using_animtree("stalingrad_groupB_jumpguy");
groupB_jumpguy()
{	
	level.scr_animtree["groupB_jumpguy"] = #animtree;
	level.scr_anim["groupB_jumpguy"]["idle"][0]			= (%groupB_standtwitch_jumpguy);
	level.scr_anim["groupB_jumpguy"]["idleweight"][0]	= 0.5;
	level.scr_anim["groupB_jumpguy"]["idle"][1]			= (%groupB_standidle_jumpguy);
	level.scr_anim["groupB_jumpguy"]["idleweight"][1]	= 1.5;
	level.scr_anim["groupB_jumpguy"]["ducktrans"]		= (%groupB_ducktrans_jumpguy);
	level.scr_anim["groupB_jumpguy"]["ducktransout"]	= (%groupB_ducktransout_jumpguy);
	level.scr_anim["groupB_jumpguy"]["duckidle"][0]		= (%groupB_duckidle_jumpguy);
	level.scr_anim["groupB_jumpguy"]["duckflinch"]			= (%groupB_duckflinch_jumpguy);
	level.scr_anim["groupB_jumpguy"]["duck"]			= (%groupB_duck_jumpguy);
	level.scr_anim["groupB_jumpguy"]["crouchidle"][0]	= (%groupB_crouchtwitch_jumpguy);
	level.scr_anim["groupB_jumpguy"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupB_jumpguy"]["crouchidle"][1]	= (%groupB_crouchidle_jumpguy);
	level.scr_anim["groupB_jumpguy"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupB_jumpguy"]["stuka"]			= (%groupB_stukkaattack_jumpguy);
	level.scr_anim["groupB_jumpguy"]["death"]			= (%groupB_jumpout_jumpguy);

	level.scr_face["groupA_jumpguy"]["idle"][0]			= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["idle"][1]			= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["ducktrans"]		= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["ducktransout"]	= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["groupA_jumpguy"]["duck"]			= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["crouchidle"][0]	= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["crouchidle"][1]	= (%facial_fear01);
	level.scr_face["groupA_jumpguy"]["stuka"]			= (%facial_fear01);

	level.scr_notetrack["groupB_jumpguy"][0]["notetrack"] = "splash";
	level.scr_notetrack["groupB_jumpguy"][0]["effect"] = "watersplash";
	level.scr_notetrack["groupB_jumpguy"][0]["sound"] = "Bodysplash";
	level.scr_notetrack["groupB_jumpguy"][0]["tag"] = "TAG_splash";
	
	level.scr_character["groupB_jumpguy"] = character\RussianArmy_nohat ::main;
}

/*
boat ride _ background jump out guy _  jumpguy01 
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "death"
*/

#using_animtree("stalingrad_groupB_jumpguy");
back_jumpguy()
{	
	level.scr_animtree["back_jumpguy"] = #animtree;
	level.scr_anim["back_jumpguy"]["idle"][0]			= (%groupB_standtwitch_jumpguy);
	level.scr_anim["back_jumpguy"]["idleweight"][0]	= 0.5;
	level.scr_anim["back_jumpguy"]["idle"][1]			= (%groupB_standidle_jumpguy);
	level.scr_anim["back_jumpguy"]["idleweight"][1]	= 1.5;
	level.scr_anim["back_jumpguy"]["ducktrans"]			= (%groupB_ducktrans_jumpguy);
	level.scr_anim["back_jumpguy"]["ducktransout"]		= (%groupB_ducktransout_jumpguy);
	level.scr_anim["back_jumpguy"]["duckidle"][0]		= (%groupB_duckidle_jumpguy);
	level.scr_anim["back_jumpguy"]["duckflinch"]		= (%groupB_duckflinch_jumpguy);
	level.scr_anim["back_jumpguy"]["duck"]			= (%groupB_duck_jumpguy);
	level.scr_anim["back_jumpguy"]["crouchidle"][0]	= (%groupB_crouchtwitch_jumpguy);
	level.scr_anim["back_jumpguy"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["back_jumpguy"]["crouchidle"][1]	= (%groupB_crouchidle_jumpguy);
	level.scr_anim["back_jumpguy"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["back_jumpguy"]["stuka"]			= (%groupB_stukkaattack_jumpguy);
	level.scr_anim["back_jumpguy"]["death"]			= (%groupB_backjumpdeck_jumpguy);

	level.scr_face["back_jumpguy"]["idle"][0]			= (%facial_fear01);
	level.scr_face["back_jumpguy"]["idle"][1]			= (%facial_fear01);
	level.scr_face["back_jumpguy"]["ducktrans"]			= (%facial_fear01);
	level.scr_face["back_jumpguy"]["ducktransout"]		= (%facial_fear01);
	level.scr_face["back_jumpguy"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["back_jumpguy"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["back_jumpguy"]["duck"]				= (%facial_fear01);
	level.scr_face["back_jumpguy"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["back_jumpguy"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["back_jumpguy"]["stuka"]				= (%facial_fear01);

	level.scr_notetrack["back_jumpguy"][0]["notetrack"] = "splash";
	level.scr_notetrack["back_jumpguy"][0]["effect"] = "watersplash";
	level.scr_notetrack["back_jumpguy"][0]["sound"] = "Bodysplash";
	level.scr_notetrack["back_jumpguy"][0]["tag"] = "TAG_splash01";
	
	level.scr_character["back_jumpguy"] = character\RussianArmy_pants ::main;
}

/*
boat ride _ groupC _  TAG_groupC,TAG_groupC01,TAG_groupC02,TAG_groupC03,TAG_groupC04,TAG_groupC05
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "jump".
play standing"idle" until they reach the dock.
*/
	
#using_animtree("stalingrad_groupC_guy01");
groupC_guy01()
{	
	level.scr_animtree["groupC_guy01"] = #animtree;
	level.scr_anim["groupC_guy01"]["idle"][0]				= (%groupC_standtwitch_guy01);
	level.scr_anim["groupC_guy01"]["idleweight"][0]			= 0.5;
	level.scr_anim["groupC_guy01"]["idle"][1]				= (%groupC_standidle_guy01);
	level.scr_anim["groupC_guy01"]["idleweight"][1]			= 2.5;
	level.scr_anim["groupC_guy01"]["lookright"]				= (%groupC_lookright_guy01);
	level.scr_anim["groupC_guy01"]["ducktrans"]				= (%groupC_ducktrans_guy01);
	level.scr_anim["groupC_guy01"]["ducktransout"]			= (%groupC_ducktransout_guy01);
	level.scr_anim["groupC_guy01"]["duckidle"][0]			= (%groupC_duckidle_guy01);
	level.scr_anim["groupC_guy01"]["duckflinch"]			= (%groupC_duckflinch_guy01);
	level.scr_anim["groupC_guy01"]["duck"]					= (%groupC_duck_guy01);
	level.scr_anim["groupC_guy01"]["crouchidle"][0]			= (%groupC_crouchtwitch_guy01);
	level.scr_anim["groupC_guy01"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupC_guy01"]["crouchidle"][1]			= (%groupC_crouchidle_guy01);
	level.scr_anim["groupC_guy01"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupC_guy01"]["stuka"]					= (%groupC_stukkaattack_guy01);
	level.scr_anim["groupC_guy01"]["jump"]					= (%groupC_jump_guy01);
	level.scr_anim["groupC_guy01"]["climb"]					= (%groupC_climb_guy01);

	level.scr_face["groupC_guy01"]["idle"][0]			= (%facial_fear01);
	level.scr_face["groupC_guy01"]["idle"][1]			= (%facial_fear01);
	level.scr_face["groupC_guy01"]["ducktrans"]			= (%facial_fear01);
	level.scr_face["groupC_guy01"]["ducktransout"]		= (%facial_fear01);
	level.scr_face["groupC_guy01"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy01"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["groupC_guy01"]["duck"]				= (%facial_fear01);
	level.scr_face["groupC_guy01"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy01"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["groupC_guy01"]["stuka"]				= (%facial_fear01);
	level.scr_face["groupC_guy01"]["jump"]				= (%facial_fear01);
	level.scr_face["groupC_guy01"]["climb"]				= (%facial_fear01);

	level.scr_anim["groupC_guy01"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["groupC_guy01"]["explode death"][1] = %balcony_fallloop_onback;
	
	level.scr_character["groupC_guy01"] = character\RussianArmy_pants ::main;
}

#using_animtree("stalingrad_groupC_guy02");
groupC_guy02()
{	
	level.scr_animtree["groupC_guy02"] = #animtree;
	level.scr_anim["groupC_guy02"]["idle"][0]		= (%groupC_standtwitch_guy02);
	level.scr_anim["groupC_guy02"]["idle"][1]		= (%groupC_standidle_guy02);
	level.scr_anim["groupC_guy02"]["lookright"]				= (%groupC_lookright_guy02);
	level.scr_anim["groupC_guy02"]["ducktrans"]				= (%groupC_ducktrans_guy02);
	level.scr_anim["groupC_guy02"]["ducktransout"]			= (%groupC_ducktransout_guy02);
	level.scr_anim["groupC_guy02"]["duckidle"][0]			= (%groupC_duckidle_guy02);
	level.scr_anim["groupC_guy02"]["duckflinch"]			= (%groupC_duckflinch_guy02);
	level.scr_anim["groupC_guy02"]["duck"]			= (%groupC_duck_guy02);
	level.scr_anim["groupC_guy02"]["crouchidle"][0]	= (%groupC_crouchtwitch_guy02);
	level.scr_anim["groupC_guy02"]["crouchidle"][1]	= (%groupC_crouchidle_guy02);
	level.scr_anim["groupC_guy02"]["stuka"]			= (%groupC_stukkaattack_guy02);
	level.scr_anim["groupC_guy02"]["jump"]			= (%groupC_jump_guy02);
	level.scr_anim["groupC_guy02"]["climb"]			= (%groupC_climb_guy02);

	level.scr_face["groupC_guy02"]["idle"][0]			= (%facial_fear01);
	level.scr_face["groupC_guy02"]["idle"][1]			= (%facial_fear01);
	level.scr_face["groupC_guy02"]["ducktrans"]			= (%facial_fear01);
	level.scr_face["groupC_guy02"]["ducktransout"]		= (%facial_fear01);
	level.scr_face["groupC_guy02"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy02"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["groupC_guy02"]["duck"]				= (%facial_fear01);
	level.scr_face["groupC_guy02"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy02"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["groupC_guy02"]["stuka"]				= (%facial_fear01);
	level.scr_face["groupC_guy02"]["jump"]				= (%facial_fear01);
	level.scr_face["groupC_guy02"]["climb"]				= (%facial_fear01);
	
	level.scr_character["groupC_guy02"] = character\RussianArmy_nohat ::main;
}

#using_animtree("stalingrad_groupC_guy03");
groupC_guy03()
{	
	level.scr_animtree["groupC_guy03"] = #animtree;
	level.scr_anim["groupC_guy03"]["idle"][0]		= (%groupC_standtwitch_guy03);
	level.scr_anim["groupC_guy03"]["idle"][1]		= (%groupC_standidle_guy03);
	level.scr_anim["groupC_guy03"]["lookright"]				= (%groupC_lookright_guy03);
	level.scr_anim["groupC_guy03"]["ducktrans"]				= (%groupC_ducktrans_guy03);
	level.scr_anim["groupC_guy03"]["ducktransout"]			= (%groupC_ducktransout_guy03);
	level.scr_anim["groupC_guy03"]["duckidle"][0]			= (%groupC_duckidle_guy03);
	level.scr_anim["groupC_guy03"]["duckflinch"]			= (%groupC_duckflinch_guy03);
	level.scr_anim["groupC_guy03"]["duck"]			= (%groupC_duck_guy03);
	level.scr_anim["groupC_guy03"]["crouchidle"][0]	= (%groupC_crouchtwitch_guy03);
	level.scr_anim["groupC_guy03"]["crouchidle"][1]	= (%groupC_crouchidle_guy03);
	level.scr_anim["groupC_guy03"]["stuka"]			= (%groupC_stukkaattack_guy03);
	level.scr_anim["groupC_guy03"]["jump"]			= (%groupC_jump_guy03);	
	level.scr_anim["groupC_guy03"]["climb"]			= (%groupC_climb_guy03);	

	level.scr_face["groupC_guy03"]["idle"][0]			= (%facial_fear01);
	level.scr_face["groupC_guy03"]["idle"][1]			= (%facial_fear01);
	level.scr_face["groupC_guy03"]["ducktrans"]			= (%facial_fear01);
	level.scr_face["groupC_guy03"]["ducktransout"]		= (%facial_fear01);
	level.scr_face["groupC_guy03"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy03"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["groupC_guy03"]["duck"]				= (%facial_fear01);
	level.scr_face["groupC_guy03"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["groupC_guy03"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["groupC_guy03"]["stuka"]				= (%facial_fear01);
	level.scr_face["groupC_guy03"]["jump"]				= (%facial_fear01);
	level.scr_face["groupC_guy03"]["climb"]				= (%facial_fear01);

	level.scr_character["groupC_guy03"] = character\RussianArmy_pants ::main;
}

/*
boat ride _ groupD _  TAG_groupD,TAG_groupD01,TAG_groupD02,TAG_groupD03,TAG_groupD04,TAG_groupD05  
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "jump".
play standing"idle" until they reach the dock.
*/
#using_animtree("stalingrad_groupD_guy01");
groupD_guy01()
{
	level.scr_animtree["groupD_guy01"] = #animtree;
//	level.scr_anim["groupD_guy01"]["idle"][0]		= (%groupC_standtwitch_guy04);
//	level.scr_anim["groupD_guy01"]["idleweight"][0]	= 0.5;
	level.scr_anim["groupD_guy01"]["idle"][0]		= (%groupC_standidle_guy04);
	level.scr_anim["groupD_guy01"]["idleweight"][0]	= 2.5;
	level.scr_anim["groupD_guy01"]["lookright"]				= (%groupC_lookright_guy04);
	level.scr_anim["groupD_guy01"]["ducktrans"]				= (%groupC_ducktrans_guy04);
	level.scr_anim["groupD_guy01"]["ducktransout"]			= (%groupC_ducktransout_guy04);
	level.scr_anim["groupD_guy01"]["duckidle"][0]			= (%groupC_duckidle_guy04);
	level.scr_anim["groupD_guy01"]["duckflinch"]			= (%groupC_duckflinch_guy04);
	level.scr_anim["groupD_guy01"]["duck"]			= (%groupC_duck_guy04);
	level.scr_anim["groupD_guy01"]["crouchidle"][0]	= (%groupC_crouchtwitch_guy04);
	level.scr_anim["groupD_guy01"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupD_guy01"]["crouchidle"][1]	= (%groupC_crouchidle_guy04);
	level.scr_anim["groupD_guy01"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupD_guy01"]["stuka"]			= (%groupC_stukkaattack_guy04);
	level.scr_anim["groupD_guy01"]["jump"]			= (%groupC_jump_guy04);
	level.scr_anim["groupD_guy01"]["climb"]			= (%groupC_climb_guy04);

	level.scr_face["groupD_guy01"]["idle"][0]			= (%facial_fear01);
	level.scr_face["groupD_guy01"]["idle"][1]			= (%facial_fear01);
	level.scr_face["groupD_guy01"]["ducktrans"]			= (%facial_fear01);
	level.scr_face["groupD_guy01"]["ducktransout"]		= (%facial_fear01);
	level.scr_face["groupD_guy01"]["duckidle"][0]		= (%facial_fear01);
	level.scr_face["groupD_guy01"]["duckflinch"]		= (%facial_panic01);
	level.scr_face["groupD_guy01"]["duck"]				= (%facial_fear01);
	level.scr_face["groupD_guy01"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["groupD_guy01"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["groupD_guy01"]["stuka"]				= (%facial_fear01);
	level.scr_face["groupD_guy01"]["jump"]				= (%facial_fear01);
	level.scr_face["groupD_guy01"]["climb"]				= (%facial_fear01);

	level.scr_anim["groupD_guy01"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["groupD_guy01"]["explode death"][1] = %balcony_fallloop_onback;

	level.scr_character["groupD_guy01"] = character\RussianArmy ::main;
} 

/*
boat ride _ groupE _  TAG_groupE,TAG_groupE01
play "idle" until mortars start. When mortars start use "duck" to transition to "crouchidle".
play "stukka" for the stukka attack. After the last stukka attack play "jump".
play standing"idle" until they reach the dock.
*/
	
#using_animtree("stalingrad_groupE_guy01");
groupE_guy01()
{	
	level.scr_animtree["groupE_guy01"] = #animtree;
	level.scr_anim["groupE_guy01"]["idle"][0]		= (%groupE_standtwitch_guy01);
	level.scr_anim["groupE_guy01"]["idleweight"][0]	= 0.5;
	level.scr_anim["groupE_guy01"]["idle"][1]		= (%groupE_standidle_guy01);
	level.scr_anim["groupE_guy01"]["idleweight"][1]	= 1.5;
	level.scr_anim["groupE_guy01"]["ducktrans"]				= (%groupE_ducktrans_guy01);
	level.scr_anim["groupE_guy01"]["ducktransout"]			= (%groupE_ducktransout_guy01);
	level.scr_anim["groupE_guy01"]["duckidle"][0]			= (%groupE_duckidle_guy01);
	level.scr_anim["groupE_guy01"]["duckflinch"]			= (%groupE_duckflinch_guy01);
	level.scr_anim["groupE_guy01"]["duck"]			= (%groupE_duck_guy01);
	level.scr_anim["groupE_guy01"]["crouchidle"][0]	= (%groupE_crouchtwitch_guy01);
	level.scr_anim["groupE_guy01"]["crouchidleweight"][0]	= 0.5;
	level.scr_anim["groupE_guy01"]["crouchidle"][1]	= (%groupE_crouchidle_guy01);
	level.scr_anim["groupE_guy01"]["crouchidleweight"][1]	= 1.5;
	level.scr_anim["groupE_guy01"]["death"]			= (%groupE_stukkadeath_guy01);
	level.scr_anim["groupE_guy01"]["stuka"]			= (%groupE_stukkaattack_guy01);
	level.scr_anim["groupE_guy01"]["jump"]			= (%groupE_jump_guy01);
	level.scr_anim["groupE_guy01"]["climb"]			= (%groupE_jump_guy01);

	level.scr_face["groupE_guy01"]["idle"][0]			= (%stalingrad_faceE01_standtwitch);
	level.scr_face["groupE_guy01"]["idle"][1]			= (%stalingrad_faceE01_standidle);
	level.scr_face["groupE_guy01"]["ducktrans"]			= (%stalingrad_faceE01_ducktrans);
	level.scr_face["groupE_guy01"]["ducktransout"]		= (%stalingrad_faceE01_ducktransout);
	level.scr_face["groupE_guy01"]["duckidle"][0]		= (%stalingrad_faceE01_duckidle);
	level.scr_face["groupE_guy01"]["duckflinch"]		= (%stalingrad_faceE01_duckflinch);
	level.scr_face["groupE_guy01"]["duck"]				= (%stalingrad_faceE01_duck);
	level.scr_face["groupE_guy01"]["crouchidle"][0]		= (%facial_fear02);
	level.scr_face["groupE_guy01"]["crouchidle"][1]		= (%facial_fear02);
	level.scr_face["groupE_guy01"]["death"]				= (%facial_panic01);
	level.scr_face["groupE_guy01"]["stuka"]				= (%facial_fear02);
	level.scr_face["groupE_guy01"]["jump"]				= (%facial_fear02);
	level.scr_face["groupE_guy01"]["climb"]				= (%facial_fear02);

	level.scr_anim["groupE_guy01"]["explode death"][0] = %balcony_fallloop_tumbleforwards;
	level.scr_anim["groupE_guy01"]["explode death"][1] = %balcony_fallloop_onback;
   
	level.scr_character["groupE_guy01"] = character\RussianArmy_pants ::main;
}

#using_animtree("stalingrad_groupE_guy02");
groupE_guy02()
{	
	level.scr_animtree["groupE_guy02"] = #animtree;
	level.scr_anim["groupE_guy02"]["idle"][0]		= (%groupE_standtwitch_guy02);
	level.scr_anim["groupE_guy02"]["idle"][1]		= (%groupE_standidle_guy02);
	level.scr_anim["groupE_guy02"]["ducktrans"]				= (%groupE_ducktrans_guy02);
	level.scr_anim["groupE_guy02"]["ducktransout"]			= (%groupE_ducktransout_guy02);
	level.scr_anim["groupE_guy02"]["duckidle"][0]			= (%groupE_duckidle_guy02);
	level.scr_anim["groupE_guy02"]["duckflinch"]			= (%groupE_duckflinch_guy02);
	level.scr_anim["groupE_guy02"]["duck"]			= (%groupE_duck_guy02);
	level.scr_anim["groupE_guy02"]["crouchidle"][0]	= (%groupE_crouchtwitch_guy02);
	level.scr_anim["groupE_guy02"]["crouchidle"][1]	= (%groupE_crouchidle_guy02);
	level.scr_anim["groupE_guy02"]["death"]			= (%groupE_stukkadeath_guy02);
	level.scr_anim["groupE_guy02"]["stuka"]			= (%groupE_stukkaattack_guy02);
	level.scr_anim["groupE_guy02"]["jump"]			= (%groupE_jump_guy02);
	level.scr_anim["groupE_guy02"]["climb"]			= (%groupE_jump_guy02);

	level.scr_face["groupE_guy02"]["idle"][0]			= (%stalingrad_faceE02_standtwitch);
	level.scr_face["groupE_guy02"]["idle"][1]			= (%stalingrad_faceE02_standidle);
	level.scr_face["groupE_guy02"]["ducktrans"]			= (%stalingrad_faceE02_ducktrans);
	level.scr_face["groupE_guy02"]["ducktransout"]		= (%stalingrad_faceE02_ducktransout);
	level.scr_face["groupE_guy02"]["duckidle"][0]		= (%stalingrad_faceE02_duckidle);
	level.scr_face["groupE_guy02"]["duckflinch"]		= (%stalingrad_faceE02_duckflinch);
	level.scr_face["groupE_guy02"]["duck"]				= (%facial_fear01);
	level.scr_face["groupE_guy02"]["crouchidle"][0]		= (%facial_fear01);
	level.scr_face["groupE_guy02"]["crouchidle"][1]		= (%facial_fear01);
	level.scr_face["groupE_guy02"]["death"]				= (%facial_panic01);
	level.scr_face["groupE_guy02"]["stuka"]				= (%facial_fear01);
	level.scr_face["groupE_guy02"]["jump"]				= (%facial_fear01);
	level.scr_face["groupE_guy02"]["climb"]				= (%facial_fear01);

	level.scr_character["groupE_guy02"] = character\RussianArmy ::main;

}

#using_animtree("stalingrad_groupE_guy03");
groupE_guy03()
{	
	level.scr_animtree["groupE_guy03"] = #animtree;
	level.scr_anim["groupE_guy03"]["idle"][0]		= (%groupE_standtwitch_guy03);
	level.scr_anim["groupE_guy03"]["idle"][1]		= (%groupE_standidle_guy03);
	level.scr_anim["groupE_guy03"]["ducktrans"]				= (%groupE_ducktrans_guy03);
	level.scr_anim["groupE_guy03"]["ducktransout"]			= (%groupE_ducktransout_guy03);
	level.scr_anim["groupE_guy03"]["duckidle"][0]			= (%groupE_duckidle_guy03);
	level.scr_anim["groupE_guy03"]["duckflinch"]			= (%groupE_duckflinch_guy03);
	level.scr_anim["groupE_guy03"]["duck"]			= (%groupE_duck_guy03);
	level.scr_anim["groupE_guy03"]["crouchidle"][0]	= (%groupE_crouchtwitch_guy03);
	level.scr_anim["groupE_guy03"]["crouchidle"][1]	= (%groupE_crouchidle_guy03);
	level.scr_anim["groupE_guy03"]["stuka"]			= (%groupE_stukkaattack_guy03);
	level.scr_anim["groupE_guy03"]["jump"]			= (%groupE_jump_guy03);
	level.scr_anim["groupE_guy03"]["climb"]			= (%groupE_jump_guy03);

	level.scr_face["groupE_guy03"]["idle"][0]			= (%facial_fear02);
	level.scr_face["groupE_guy03"]["idle"][1]			= (%facial_fear02);
	level.scr_face["groupE_guy03"]["ducktrans"]			= (%facial_fear02);
	level.scr_face["groupE_guy03"]["ducktransout"]		= (%facial_fear02);
	level.scr_face["groupE_guy03"]["duckidle"][0]		= (%facial_fear02);
	level.scr_face["groupE_guy03"]["duckflinch"]		= (%facial_fear02);
	level.scr_face["groupE_guy03"]["duck"]				= (%facial_fear02);
	level.scr_face["groupE_guy03"]["crouchidle"][0]		= (%facial_fear02);
	level.scr_face["groupE_guy03"]["crouchidle"][1]		= (%facial_fear02);
	level.scr_face["groupE_guy03"]["stuka"]				= (%facial_fear02);
	level.scr_face["groupE_guy03"]["jump"]				= (%facial_fear02);
	level.scr_face["groupE_guy03"]["climb"]				= (%facial_fear02);

	level.scr_character["groupE_guy03"] = character\RussianArmy_pants ::main;
}

#using_animtree("stalingrad_floater");
floater()
{
	level.scr_animtree["floater1"]			= #animtree;
	level.scr_anim["floater1"]["idle"][0]	= (%deadguys_floaterA_idle);
	level.scr_character["floater1"]			= character\RussianArmyWoundedTunic ::main;
	
	level.scr_animtree["floater2"]			= #animtree;
	level.scr_anim["floater2"]["idle"][0]	= (%deadguys_floaterA_idle);
	level.scr_character["floater2"]			= character\RussianArmy_pants ::main;
	
	level.scr_animtree["floater3"]			= #animtree;
	level.scr_anim["floater3"]["idle"][0]	= (%deadguys_floaterB_idle);
	level.scr_character["floater3"]			= character\RussianArmy ::main;
	
	level.scr_animtree["floater4"]			= #animtree;
	level.scr_anim["floater4"]["idle"][0]	= (%deadguys_floaterB_idle);
	level.scr_character["floater4"]			= character\RussianArmy_pants ::main;
}


/*
added lead conscript fullbody dialogue animations (gunguy)
	I'm not sure which animation this is in reference to.
	+++this is the guy who tells everyone to get down (in the trench) when the mortars start (before you get to the car)+++

added "getup"animations for soldiers thrown to the ground during shellshock (gunguy/ammoguy)

added new duck animations to group C and D (ducktrans/duckidle/duckflinch)
+ shout guy is popping because he is using "duck" animation twice... use "duck" for the first stukka and "stukka" for the second...
	I will be holding off on this until the waittill sounddone bug is fixed.

added chances cowering guy (wallguys)
added facial animations to (shellshock commissar, building commissar, sniper, officerP, shoutguy, crateguy)
I tried to attach the "spotters" radio in script but it didn't work so I commented it out... look at it and tell me what I did wrong.

April 5
Added ducktransout animations to groups A-E (and back guys) on the boat.  These are the transition from the duckidle pose.  Now, 
after playing ducktrans, duckidle, duckflinch, you can play duckidle again if you want, 
and then you have to play ducktransout to get back to the normal pose.
Added the model death_rolldownhill_rig which controls the guy when he rolls down the hill.  
Right now it only has one animation, 
scripted_death_rolldownhill_rig1, which is flat.
  

-added "explode" and "shock" notetracks to the player getout animation
+the SPOTTER still doesn't have a radio... we need to figure out how to get it attached again.
explode/shock
- ppshguy comes back to life! he needs to stay dead after the second stukka attack

TAG_metal_right01
TAG_metal_right02
TAG_metal_right03
TAG_metal_right04

TAG_flesh_right05
TAG_flesh_right06
TAG_flesh_right07

TAG_metal_right08
TAG_metal_right09
TAG_metal_right10



TAG_metal_left01
TAG_metal_left02

TAG_flesh_left03

TAG_metal_left04

TAG_flesh_left05
TAG_flesh_left06
TAG_flesh_left07
TAG_flesh_left08
TAG_flesh_left09

TAG_metal_left10
TAG_metal_left11
TAG_metal_left12
TAG_metal_left13
-sniper notetracks (anim_gunhand = \"right\") and (anim_gunhand = \"left\")

Added facial_fear01 and facial_panic01 for guys on the boat (and on the docks if you want)
facial_fear01 is a looping animation - set and forget
facial_panic01 should be played at the same time as the flinches - when mortars go off, or something scary 
happens.  When facial_panic finishes, play facial_fear again.  I will make more versions of each of these 
animations.  Currently I'm thinking that each guy will have one  - eg one guy would play fear01 and panic01, 
while another guy would play fear02 and panic02.

April 11: Stalingrad_cover_crouch changes.
Added self.customAttackSpeed, which can have values "fast", "normal" or "hide".  This value can be changed on 
guys who are already running the script and they will respond as soon as they finish their current animation. 
Note that self.customFastAttack no longer works.  There is still a problem with stalingrad_cover_crouch in 
the test map (on Stalingrad I just have no idea).  Whenever he ducks down, the script getes reset.


May 1

added 3man carry walk (woundgroupwalk) - it needs to ge set up like the dragging animation in burnville
added facial idles for lineofficer and leaderguy
added "lookright" to groupC and D - this is so they can turn and look at the stukkas when they start their diving run...
added flagwaving commissar (flagwave)
added deaths for stukka attacks... they are for these two guys (groupE_guy01 and groupE_guy02)
added stand_alert_look_right_90 and  stand_alert_look_left_90 to all the boatsoldiergroup atr's so we can try doing the lookat..
Added 
	pistol_crouchrun_loop_forward_1	// (Pistol runs are also good for unarmed)
	pistol_crouchrun_loop_forward_2
	pistol_crouchrun_loop_forward_3
	crouchrun_loop_forward_1
	crouchrun_loop_forward_2
	crouchrun_loop_forward_3
to stalingrad_drones.atr.  Each guy should be randomly assigned one of these and should use it when he is 
running - guys with guns should get one of the regular ones, unarmed guys should get a pistol one.  Also made 
the walk and run animations for the drones be looping so that you only need to play them once.
Added
	death_run_onfront
	death_run_onleft
to stalingrad_drones.atr, for more variety when guys die.
added flagrun (he should lead the drones

May 2

Here's how I play the cowering animations in stalingrad_cover_crouch:
	rand = randomint(100);
	if (rand<25)
	{
		for (;;)
		{
            //            self . scriptState = "cower nogun";
            
			playbackRate = 0.9 + randomfloat(0.2);
			self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_fetal, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}
	else if (rand<50)
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			if (!isDefined(scaredSet))
			{
				if (randomint(100)<50)
					scaredSet = "A";
				else
					scaredSet = "B";
			}
			if (scaredSet=="A")
			{
				rand = randomint(100);
				if (rand<60)
					self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredA, %root, 1, .1, playbackRate);
				else if (rand<90)
					self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredA_twitch, %root, 1, .1, playbackRate);
				else
				{
					self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredAtoB, %root, 1, .1, playbackRate);
					scaredSet = "B";
				}
				animscripts\shared::DoNoteTracks("coweranim");
			}
			else
			{
				rand = randomint(100);
				if (rand<85)
					self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredB, %root, 1, .1, playbackRate);
				else
				{
					self setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredBtoA, %root, 1, .1, playbackRate);
					scaredSet = "A";
				}
				animscripts\shared::DoNoteTracks("coweranim");
			}
		}
	}
	else if (rand<75)
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			rand = randomint(100);
			if (rand<50)
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_idle, %root, 1, .1, playbackRate);
			else if (rand<75)
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_twitch, %root, 1, .1, playbackRate);
			else
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_look, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}
	else
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			rand = randomint(100);
			if (rand<50)
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_idle, %root, 1, .1, playbackRate);
			else if (rand<75)
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_twitch, %root, 1, .1, playbackRate);
			else
				self setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_look, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}

	-------------------new may 07--------------
	added tags to tugboat so it so we can put low polly characters on it...
	add upper torso low polly guy to this tag (TAG_driver)
	add fullbody low polly guys to these tags ...
	TAG_deckguy01
	TAG_deckguy02
	TAG_deckguy03
	TAG_deckguy04
	TAG_deckguy05
	TAG_deckguy06
	TAG_deckguy07
	they should be able to use the boat guys idles (standing or prone)

	------------
	added "trans" animation to flagrun guy for his transition from run to crouch...

*/
