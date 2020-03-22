#using_animtree("generic_human");
main()
{

	// Commissar style!
//	level.scr_anim["officer"]["idle"][0]			= (%commissar4_line_32_fullbody);
	level.scr_anim["officer"]["idle"][0]			= (%commissar4_line_50_fullbody);
	level.scr_anim["officer"]["idle"][1]			= (%commissar4_line_51_fullbody);
	
	// Generic
	level.scr_anim["generic"]["kick door 1"] = %chateau_kickdoor1;
	level.scr_anim["generic"]["kick door 2"] = %chateau_kickdoor2;

	level.scr_anim["foley"]["kick door 1"] = %chateau_kickdoor1;
	level.scrsound["foley"]["good job"] = "burnville_foley_13b";
 
	/*
	Intro animation	
	*/
	level.scr_anim["foley"]["intro"]				= (%levelchateau_opening_waters);

	//	Let's hope.  Captain Price and Major Ingram?
	level.scr_notetrack["foley"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["foley"][0]["facial"]		= %Chateau_facial_Foley_092_letshope;
	level.scr_notetrack["foley"][0]["dialogue"]		= "chateau_foley_letshope";
	level.scr_notetrack["foley"][0]["anime"]		= "intro";

	//	"Martin, you take point, knock out that '42.  Harding and Brooks, go get the truck - meet us at the front of the chateau.  Everyone else, follow Martin. Move!"
	level.scr_notetrack["foley"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["foley"][1]["facial"]		= %Chateau_facial_Foley_093alt2_takepoint;
	level.scr_notetrack["foley"][1]["dialogue"]		= "chateau_foley_theplan";
	level.scr_notetrack["foley"][1]["anime"]		= "intro";
	
	level.scr_anim["moody"]["intro"]				= (%levelchateau_opening_scout);
	//	"There's an MG42 on the left, with a guard house on the right.  They didn't spot me."
	level.scr_notetrack["moody"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["moody"][0]["facial"]		= %Chateau_facial_Moody_081_mg42onleft;
	level.scr_notetrack["moody"][0]["dialogue"]		= "chateau_moody_didntseeme";
	level.scr_notetrack["moody"][0]["anime"]		= "intro";

	//	Probably in the big house up the road.
	level.scr_notetrack["moody"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["moody"][1]["facial"]		= %Chateau_facial_Moody_082_bighouse;
	level.scr_notetrack["moody"][1]["dialogue"]		= "chateau_moody_inbighouse";
	level.scr_notetrack["moody"][1]["anime"]		= "intro";

	level.scr_anim["harding"]["intro"]			= (%levelchateau_opening_thirdguy);
	level.scr_anim["brooks"]["intro"]		= (%levelchateau_opening_fourthguy);

	//	Good work, Martin.  Everyone breathe deep, catch your breath.  Now, let's do it all over again."
	level.scrsound["foley"]["good work"]		= ("chateau_foley_catchbreath");
	level.scr_face["foley"]["good work"]		= (%Chateau_facial_Foley_094alt_goodwork);
	
	//*	Martin, get in there, grab any docs, knock out their communications, then meet back up with us.  Sergeant Moody and I will find Price and Ingram."
	level.scrsound["foley"]["split up"]		= ("chateau_foley_entry");
	level.scr_face["foley"]["split up"]		= (%Chateau_facial_Foley_095_getinthere);	
	/*
	Help price up in his cell
	*/
	level.scr_anim["foley"]["get up"]		= (%levelchateau_woundedpickup_helper);
	
	level.scr_anim["price"]["idle"][0]			= (%levelchateau_sitidle_wounded);
	level.scr_anim["price"]["idle noticed"][0]	= (%levelchateau_price_lookarond_idle);

	//	Well, goodness me, Americans! Made quite a racket, didn't you? That's quite alright, I can still walk."
	level.scr_anim["price"]["noticed"]		= (%levelchateau_price_008_wellgoodness);
	level.scr_notetrack["price"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["price"][0]["facial"]		= %Chateau_facial_Price_008_well;
	level.scr_notetrack["price"][0]["dialogue"]		= "chateau_price_goodness";
	level.scr_notetrack["price"][0]["anime"]		= "noticed";

	//	Well, goodness me, Americans! Made quite a racket, didn't you? That's quite alright, I can still walk."
	level.scr_anim["price"]["get up"]		= (%levelchateau_woundedpickup_wounded);
	level.scrsound["price"]["get up"]		= ("chateau_price_goodness2");
	level.scr_face["price"]["get up"]		= (%Chateau_facial_Price_008_goodone);

	//	Captain Price, Captain Foley. Where's Major Ingram?"
	level.scrsound["foley"]["where is ingram?"]	= ("chateau_foley_ingram");
	level.scr_face["foley"]["where is ingram?"]	= (%Chateau_facial_Foley_097_wheresingram);
	
	//	They moved him to a camp. Not to worry, I overheard where."
	level.scrsound["price"]["moved ingram"]		= ("chateau_price_movedtocamp");
	level.scr_face["price"]["moved ingram"]		= (%Chateau_facial_Price_009alt_movedhim);
	/*
	Help price out the window
	*/
	level.scr_anim["brooks"]["window"]				= (%levelchateau_carryoutwindow_first);
	level.scr_anim["brooks"]["idle"][0]				= (%levelchateau_windowidle_first);
	/*
//	Truck's out front, sir."
	level.scr_notetrack["brooks"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["brooks"][0]["dialogue"]	= "chateau_brooks_truckoutfront";
	//	Captain, what about Major Ingram?"
	level.scr_notetrack["brooks"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["brooks"][1]["dialogue"]	= "chateau_brooks_whataboutingram";
	*/

	level.scr_anim["harding"]["window"]				= (%levelchateau_carryoutwindow_second);
	level.scr_anim["harding"]["idle"][0]			= (%levelchateau_windowidle_second);
	level.scr_anim["price"]["window"] 				= (%levelchateau_carryoutwindow_wounded);

	//	Truck's out front, sir."
	level.scrsound["brooks"]["window 1"]			= ("chateau_brooks_truckoutfront");
	level.scr_face["brooks"]["window 1"]			= (%Chateau_facial_Brooks_001alt_truckoutfront);
	//	Excellent.  Help Captain Price out the window. He's been hurt.
	level.scrsound["foley"]["window 2"]				= ("chateau_foley_helpprice");
	level.scr_face["foley"]["window 2"]				= (%Chateau_facial_Foley_098_help);
	//	Let's pile in. We're getting out.
	level.scrsound["foley"]["truck 1"]				= ("chateau_foley_pilein");
	level.scr_face["foley"]["truck 1"]				= (%Chateau_facial_Foley_099_pilein);
	//	Captain, what about Major Ingram?"
	level.scrsound["brooks"]["truck 2"]				= ("chateau_brooks_whataboutingram");
	level.scr_face["brooks"]["truck 2"]				= (%Chateau_facial_Brooks_002_majoringram);
	//	We'll be back for him. Get in.
	level.scrsound["foley"]["truck 3"]				= ("chateau_foley_backforhim");
	level.scr_face["foley"]["truck 3"]				= (%Chateau_facial_Foley_100alt4_wellbeback);

	/*
	Blow the doors
	*/
	//	Don't stop now - Price and Ingram are behind these doors! Stand back! We're gonna blow 'em!
	level.scr_anim["foley"]["bomb"]					= (%levelchateau_bombplacement_left);
	level.scr_face["foley"]["bomb"]					= (%Chateau_facial_Foley_096_standback);
	level.scrsound["foley"]["bomb quote"]			= "chateau_foley_blowdoors";
	level.scrsound["foley"]["blow doors"]			= "chateau_foley_blowdoors";

/*
	level.scr_notetrack["foley"][2]["notetrack"]	= "Dialogue1";
	level.scr_notetrack["foley"][2]["attach model"]	= "xmodel/explosivepack";
	level.scr_notetrack["foley"][2]["selftag"]	= "tag_weapon_right";

	level.scr_notetrack["foley"][3]["notetrack"]	= "plant bombs";
	level.scr_notetrack["foley"][3]["detach model"]	= "xmodel/explosivepack";
	level.scr_notetrack["foley"][3]["selftag"]	= "tag_weapon_right";
*/
	level.scr_notetrack["foley"][2]["notetrack"]		= "plant bombs = \"left\"";
	level.scr_notetrack["foley"][2]["create model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][2]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][2]["selftag"]			= "tag_weapon_left";
	level.scr_notetrack["foley"][2]["anime"]			= "bomb";

	level.scr_notetrack["foley"][3]["notetrack"]		= "plant bombs = \"right\"";
	level.scr_notetrack["foley"][3]["create model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][3]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][3]["selftag"]			= "tag_weapon_right";
	level.scr_notetrack["foley"][3]["anime"]			= "bomb";
	
	level.scr_notetrack["foley"][4]["notetrack"]		= "attach bomb = \"left\"";
	level.scr_notetrack["foley"][4]["attach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][4]["selftag"]			= "tag_weapon_left";
	level.scr_notetrack["foley"][4]["anime"]			= "bomb";
	
	level.scr_notetrack["foley"][5]["notetrack"]		= "attach bomb = \"right\"";
	level.scr_notetrack["foley"][5]["attach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["foley"][5]["selftag"]			= "tag_weapon_right";
	level.scr_notetrack["foley"][5]["anime"]			= "bomb";

	level.scr_notetrack["foley"][6]["notetrack"]		= "explode";
	level.scr_notetrack["foley"][6]["delete model"]		= 1;
	level.scr_notetrack["foley"][6]["explosion"]		= "bomb explosion";
	level.scr_notetrack["foley"][6]["anime"]			= "bomb";
	
//	level._effect["kaboom"]								= loadfx ("fx/explosions/pathfinder_explosion.efx");
	
	level.scr_anim["moody"]["bomb"]						= (%levelchateau_bombplacement_right);

	level.scr_notetrack["moody"][2]["notetrack"]		= "plant bombs = \"left\"";
	level.scr_notetrack["moody"][2]["create model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][2]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][2]["selftag"]			= "tag_weapon_left";
	level.scr_notetrack["moody"][2]["anime"]			= "bomb";

	level.scr_notetrack["moody"][3]["notetrack"]		= "plant bombs = \"right\"";
	level.scr_notetrack["moody"][3]["create model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][3]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][3]["selftag"]			= "tag_weapon_right";
	level.scr_notetrack["moody"][3]["anime"]			= "bomb";
	
	level.scr_notetrack["moody"][4]["notetrack"]		= "attach bomb = \"left\"";
	level.scr_notetrack["moody"][4]["attach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][4]["selftag"]			= "tag_weapon_left";
	level.scr_notetrack["moody"][4]["anime"]			= "bomb";
	
	level.scr_notetrack["moody"][5]["notetrack"]		= "attach bomb = \"right\"";
	level.scr_notetrack["moody"][5]["attach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][5]["selftag"]			= "tag_weapon_right";
	level.scr_notetrack["moody"][5]["anime"]			= "bomb";
	
	level.scr_notetrack["moody"][6]["notetrack"]		= "detach bomb = \"left\"";
	level.scr_notetrack["moody"][6]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][6]["selftag"]			= "tag_weapon_left";
	level.scr_notetrack["moody"][6]["anime"]			= "bomb";
	
	level.scr_notetrack["moody"][7]["notetrack"]		= "detach bomb = \"right\"";
	level.scr_notetrack["moody"][7]["detach model"]		= "xmodel/explosivepack";
	level.scr_notetrack["moody"][7]["selftag"]			= "tag_weapon_right";
	level.scr_notetrack["moody"][7]["anime"]			= "bomb";

	level.scr_notetrack["moody"][8]["notetrack"]		= "explode";
	level.scr_notetrack["moody"][8]["delete model"]		= 1;
	level.scr_notetrack["moody"][8]["explosion"]		= "bomb explosion";
	level.scr_notetrack["moody"][8]["anime"]			= "bomb";
	
	/*
	chateau_moody_didntseeme			//	"There's an MG42 on the left, with a guard house on the right.  They didn't spot me."
	chateau_moody_inbighouse			//	Probably in the big house up the road.
	
	chateau_foley_letshope				//	Let's hope.  Captain Price and Major Ingram?
	chateau_foley_theplan				//	"Martin, you take point, knock out that '42.  Harding and Brooks, go get the truck - meet us at the front of the chateau.  Everyone else, follow Martin. Move!"
	
	chateau_foley_catchbreath			//	Good work, Martin.  Everyone breathe deep, catch your breath.  Now, let's do it all over again."
	chateau_foley_entry					//	Martin, get in there, grab any docs, knock out their communications, then meet back up with us.  Sergeant Moody and I will find Price and Ingram."
	chateau_foley_blowdoors				//	Don't stop now - Price and Ingram are behind these doors! Stand back! We're gonna blow 'em!
	chateau_foley_ingram				//	Captain Price, Captain Foley. Where's Major Ingram?"
	chateau_foley_helpprice				//	Excellent.  Help Captain Price out the window. He's been hurt.
	chateau_foley_pilein				//	Let's pile in. We're getting out.
	chateau_foley_backforhim			//	We'll be back for him. Get in.
	
	chateau_price_goodness				//	Well, goodness me, Americans! Made quite a racket, didn't you? That's quite alright, I can still walk."
	chateau_price_movedtocamp			//	They moved him to a camp. Not to worry, I overheard where."
	
	chateau_brooks_truckoutfront		//	Truck's out front, sir."
	chateau_brooks_whataboutingram		//	Captain, what about Major Ingram?"

--------------------------------------------------------------------------------------------------	
	//	Truck's out front, sir."
	chateau_brooks_truckoutfront
	//	Excellent.  Help Captain Price out the window. He's been hurt.
	chateau_foley_helpprice
	//	Let's pile in. We're getting out.
	chateau_foley_pilein				
	//	Captain, what about Major Ingram?"
	chateau_brooks_whataboutingram
	//	We'll be back for him. Get in.
	chateau_foley_backforhim
	*/
} 
