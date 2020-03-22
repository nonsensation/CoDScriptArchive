#using_animtree("generic_human");
main()
{
	// Opening
	level.scr_anim["deadgerman"]["opening"]			= (%ship_opening_deadgerman);
	level.scr_anim["price"]["opening"]			= (%ship_opening_price);
	level.scr_anim["waters"]["opening"]			= (%ship_opening_waters);
	level.scr_anim["waters"]["opening_loop"][0]		= (%ship_opening_waters_endloop);

	// Ending
	level.scr_anim["waters"]["ending_loop"][0]		= (%ship_waters_045_lostcaptain_idle);

	level.scr_anim["waters"]["lost"]			= (%ship_waters_045_lostcaptain);
	level.scr_face["waters"]["lost"]			= (%Ship_facial_Waters_045_lost);
	level.scrsound["waters"]["lost"]			= "ship_waters_fineman";

	// Initialization
	level.scr_anim["shipdeck_officer"]["easeidle"][0]	= (%shipdeck_officer_easeidle);
	level.scr_anim["shipdeck_soldier"]["easeidle"][0]	= (%shipdeck_soldier_easeidle);
	level.scr_anim["mp40guy"]["easeidle"][0]		= (%shiplower_mp40guy_easeidle_armory);
	level.scr_anim["pistolguy"]["easeidle"][0]		= (%shiplower_pistolguy_easeidle_armory);

	level.scr_anim["shipdeck_officer"]["easeidle teleport"]	= (%shipdeck_officer_easeidle);
	level.scr_anim["shipdeck_soldier"]["easeidle teleport"]	= (%shipdeck_soldier_easeidle);
	level.scr_anim["mp40guy"]["easeidle teleport"]		= (%shiplower_mp40guy_easeidle_armory);
	level.scr_anim["pistolguy"]["easeidle teleport"]	= (%shiplower_pistolguy_easeidle_armory);

	// Papers
	level.scr_anim["price"]["papers"]			= (%shipdeck_price_papers);
	level.scr_anim["shipdeck_officer"]["papers"]		= (%shipdeck_officer_papers);

	// Shipdeck soldier
	level.scr_anim["shipdeck_soldier"]["easetrans"]		= (%shipdeck_soldier_easetrans);
	level.scr_anim["shipdeck_soldier"]["attentionidle"][0]	= (%shipdeck_soldier_attentionidle);
	level.scr_anim["shipdeck_soldier"]["presentarms"]	= (%shipdeck_soldier_presentarms);

	// Armory sequence
	level.scr_anim["price"]["armory"]			= (%shiplower_price_armory);
	level.scr_anim["mp40guy"]["armory"]			= (%shiplower_mp40guy_armory);
	level.scr_anim["pistolguy"]["armory"]			= (%shiplower_pistolguy_armory);

	level.scr_face["price"]["hanger"]			= (%Ship_facial_Price_044alt_hanger);
	level.scrsound["price"]["hanger"]			= "ship_price_throughhangar";
	level.scr_face["price"]["explosives"]			= (%Ship_facial_Price_045alt_explosives);
	level.scrsound["price"]["explosives"]			= "ship_price_boilersline";
	level.scr_face["price"]["bridge"]			= (%Ship_facial_Price_046_bridge);
	level.scrsound["price"]["bridge"]			= "ship_price_conningtower";

	// Notetrack attaches/detaches
	level.scr_notetrack["price"][0]["notetrack"] 		= "pick up light";
	level.scr_notetrack["price"][0]["attach model"] 	= "xmodel/ship_opening_light";
	level.scr_notetrack["price"][0]["selftag"] 		= "TAG_WEAPON_LEFT";

	level.scr_notetrack["price"][1]["notetrack"]		= "put down light";
	level.scr_notetrack["price"][1]["detach model"]		= "xmodel/ship_opening_light";
	level.scr_notetrack["price"][1]["selftag"]		= "TAG_WEAPON_LEFT";

	level.scr_notetrack["price"][2]["notetrack"]		= "attach_papers = \"right\"";
	level.scr_notetrack["price"][2]["attach model"]		= "xmodel/soldbuch";
	level.scr_notetrack["price"][2]["selftag"]		= "TAG_WEAPON_RIGHT";

	level.scr_notetrack["price"][3]["notetrack"]		= "detach_papers = \"right\"";
	level.scr_notetrack["price"][3]["detach model"]		= "xmodel/soldbuch";
	level.scr_notetrack["price"][3]["selftag"]		= "TAG_WEAPON_RIGHT";

	level.scr_notetrack["price"][4]["notetrack"]		= "dot";
	level.scr_notetrack["price"][4]["effect"]		= "morsecode_dot_boat";
	level.scr_notetrack["price"][4]["selftag"]		= "ship_light01";
	level.scr_notetrack["price"][4]["sound"]		= "signal_dot";

	level.scr_notetrack["price"][5]["notetrack"]		= "dash";
	level.scr_notetrack["price"][5]["effect"]		= "morsecode_dash_boat";
	level.scr_notetrack["price"][5]["selftag"]		= "ship_light01";
	level.scr_notetrack["price"][5]["sound"]		= "signal_dash";

	level.scr_notetrack["price"][6]["notetrack"]		= "facial and dialogue";
	level.scr_notetrack["price"][6]["dialogue"]		= "ship_price_holdrighthere";
	level.scr_notetrack["price"][6]["facial"]		= %Ship_facial_Price_040_holdrighthere;
	level.scr_notetrack["price"][7]["notetrack"]		= "facial and dialogue";
	level.scr_notetrack["price"][7]["dialogue"]		= "ship_price_werecleartoapproach";
	level.scr_notetrack["price"][7]["facial"]		= %Ship_facial_Price_041_okweareclear;
	level.scr_notetrack["price"][8]["notetrack"]		= "facial and dialogue";
	level.scr_notetrack["price"][8]["dialogue"]		= "ship_price_ger_permission";
	level.scr_notetrack["price"][8]["facial"]		= %Ship_facial_Price_042alt_board;
	level.scr_notetrack["price"][9]["notetrack"]		= "dialogue";
	level.scr_notetrack["price"][9]["dialogue"]		= "ship_price_ger_donitz";
	level.scr_notetrack["price"][9]["facial"]		= %Ship_facial_Price_043alt_meeting;

	level.scr_face["shipdeck_officer"]["granted"]		= (%Ship_facial_WarrantOfficer_001_granted);
	level.scrsound["shipdeck_officer"]["granted"]		= "ship_warrant_granted";

	level.scr_notetrack["shipdeck_officer"][0]["notetrack"]	= "attach_papers = \"left\"";
	level.scr_notetrack["shipdeck_officer"][0]["attach model"] = "xmodel/soldbuch";
	level.scr_notetrack["shipdeck_officer"][0]["selftag"]	= "TAG_WEAPON_LEFT";

	level.scr_notetrack["shipdeck_officer"][1]["notetrack"]	= "detach_papers = \"left\"";
	level.scr_notetrack["shipdeck_officer"][1]["detach model"] = "xmodel/soldbuch";
	level.scr_notetrack["shipdeck_officer"][1]["selftag"]	= "TAG_WEAPON_LEFT";

	level.scr_notetrack["shipdeck_officer"][2]["notetrack"]	= "dialogue";
	level.scr_notetrack["shipdeck_officer"][2]["dialogue"]	= "ship_warrant_seeyourpapers";
	level.scr_notetrack["shipdeck_officer"][2]["facial"]	= %Ship_facial_WarrantOfficer_002_papers;
	level.scr_notetrack["shipdeck_officer"][3]["notetrack"]	= "dialogue";
	level.scr_notetrack["shipdeck_officer"][3]["dialogue"]	= "ship_warrant_schmidt";
	level.scr_notetrack["shipdeck_officer"][3]["facial"]	= %Ship_facial_WarrantOfficer_003_schmidt;
	level.scr_notetrack["shipdeck_officer"][4]["notetrack"]	= "dialogue";
	level.scr_notetrack["shipdeck_officer"][4]["dialogue"]	= "ship_warrant_welcomeaboard";
	level.scr_notetrack["shipdeck_officer"][4]["facial"]	= %Ship_facial_WarrantOfficer_004_welcome;

	level.scr_notetrack["pistolguy"][0]["notetrack"]	= "attach_papers = \"left\"";
	level.scr_notetrack["pistolguy"][0]["attach model"]	= "xmodel/soldbuch";
	level.scr_notetrack["pistolguy"][0]["selftag"]		= "TAG_WEAPON_LEFT";

	level.scr_notetrack["pistolguy"][1]["notetrack"]	= "detach_papers = \"left\"";
	level.scr_notetrack["pistolguy"][1]["detach model"]	= "xmodel/soldbuch";
	level.scr_notetrack["pistolguy"][1]["selftag"]		= "TAG_WEAPON_LEFT";

	level.scr_notetrack["pistolguy"][2]["notetrack"]	= "dialogue";
	level.scr_notetrack["pistolguy"][2]["dialogue"]		= "ship_armory_showmepapers";
	level.scr_notetrack["pistolguy"][2]["facial"]		= %Ship_facial_ArmoryGuard_001alt_papers;
	level.scr_notetrack["pistolguy"][3]["notetrack"]	= "dialogue";
	level.scr_notetrack["pistolguy"][3]["dialogue"]		= "ship_armory_havetocheckthis";
	level.scr_notetrack["pistolguy"][3]["facial"]		= %Ship_facial_ArmoryGuard_002_check;
	level.scr_notetrack["pistolguy"][4]["notetrack"]	= "dialogue";
	level.scr_notetrack["pistolguy"][4]["dialogue"]		= "ship_armory_officerswithme";
	level.scr_notetrack["pistolguy"][4]["facial"]		= %Ship_facial_ArmoryGuard_003_officer;

	// Deaths
	level.scr_anim["mp40guy"]["death"]			= (%shiplower_mp40guy_death_armory);
	level.scr_anim["pistolguy"]["death"]			= (%shiplower_pistolguy_death_armory);

	// Price injury/death
	level.scr_anim["price"]["injury"]			= (%ship_pricedeath_fallandsit);
	level.scr_anim["price"]["idle"][0]			= (%ship_priceshoot_idle);
	level.scr_anim["price"]["shoot 4"]			= (%ship_priceshoots4times);
	level.scr_anim["price"]["shoot 6"]			= (%ship_priceshoots6times);
	level.scr_anim["price"]["death"]			= (%ship_pricedeathpose);

	level.scr_face["price"]["holdoff"]			= (%Ship_facial_Price_047_holdoff);
	level.scrsound["price"]["holdoff"]			= "ship_price_mortalwound";
	
	// Price casual anims
	level.scr_anim["price"]["unarmedwalk"]			= (%leaderwalk_cocky_idle);
	level.scr_anim["price"]["unarmedrun"]			= (%unarmed_run_officer);
	level.scr_anim["price"]["unarmedstand"]			= (%unarmed_standidle_officer);
	
	// Officer casual anims
	level.scr_anim["shipdeck_officer"]["unarmedwalk"]	= (%leaderwalk_cocky_idle);
	level.scr_anim["shipdeck_officer"]["unarmedrun"]	= (%unarmed_run_officer);
	level.scr_anim["shipdeck_officer"]["unarmedstand"]	= (%unarmed_standidle_officer);

	// Hangar soldier1 anims
	level.scr_anim["hangar_soldier1"]["unarmedwalk"]	= (%leaderwalk_cocky_idle);
	level.scr_anim["hangar_soldier1"]["unarmedrun"]		= (%unarmed_run_officer);
	level.scr_anim["hangar_soldier1"]["unarmedstand"]	= (%unarmed_standidle_officer);

	// Hangar soldier2 anims
	level.scr_anim["hangar_soldier2"]["unarmedwalk"]	= (%leaderwalk_cocky_idle);
	level.scr_anim["hangar_soldier2"]["unarmedrun"]		= (%unarmed_run_officer);
	level.scr_anim["hangar_soldier2"]["unarmedstand"]	= (%unarmed_standidle_officer);
} 

#using_animtree("ship_yacht");
boat()
{
	// Opening
	level.scr_animtree["boat"] = #animtree;
	level.scr_anim["boat"]["opening"]			= (%ship_opening_boat);
	level.scr_anim["boatrig"]["opening"]			= (%ship_opening_boat_animrig);

	level.scr_notetrack["boat"][0]["notetrack"]		= "show light";
	level.scr_notetrack["boat"][0]["attach model"]		= "xmodel/ship_opening_light";
	level.scr_notetrack["boat"][0]["selftag"]		= "TAG_LIGHT";

	level.scr_notetrack["boat"][1]["notetrack"]		= "hide light";
	level.scr_notetrack["boat"][1]["detach model"]		= "xmodel/ship_opening_light";
	level.scr_notetrack["boat"][1]["selftag"]		= "TAG_LIGHT";

	// Opening endloop
	level.scr_anim["boatrig"]["opening_loop"][0]		= (%ship_opening_boat_endloop);
}

#using_animtree("ship_phone");
phone()
{
	level.scr_animtree["phone"] = #animtree;
	level.scr_anim["phone"]["idle"][0]			= (%shiplower_phone_idle);
	level.scr_anim["phone"]["armory"]			= (%shiplower_phone_armory);
	
	level.scr_notetrack["phone"][0]["notetrack"]		= "dialogue";
	level.scr_notetrack["phone"][0]["sound"]		= "ship_phone_soundthealarm";	
}