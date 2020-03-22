#using_animtree("generic_human");
main()
{
	// Generic
	level.scr_anim["generic"]["kick door 1"] = %chateau_kickdoor1;
	level.scr_anim["generic"]["kick door 2"] = %chateau_kickdoor2;
	
	
	//* FOLEY
	
	level.scr_anim["foley"]["truck idle"][0]		= %germantruck_driver_sitidle_loop;
	
	//* Ok Martin, we're ready to ram the gate...
//	level.scrsound["foley"]["ok martin"]			= "powcamp_foley_readytoram1";
//	level.scr_face["foley"]["ok martin"]			= %POWCamp_facial_Foley01_okmartin;
	
	level.scr_anim["foley"]["ok martin"]			= %powcamp_foley_dialogue;
	level.scr_notetrack["foley"][0]["notetrack"]		= "dialogue";
	level.scr_notetrack["foley"][0]["facial"]		= %POWCamp_facial_Foley01_okmartin;
	level.scr_notetrack["foley"][0]["dialogue"]		= "powcamp_foley_readytoram1";
	
	//* Take any longer and they'll be sending someone to rescue us...
	
	level.scr_notetrack["foley"][1]["notetrack"]		= "dialogue";
	level.scr_notetrack["foley"][1]["facial"]		= %POWCamp_facial_Foley02_takeanylonger;
	level.scr_notetrack["foley"][1]["dialogue"]		= "powcamp_foley_readytoram2";
	
	//* Once the gate is down, get in there and find the major...
	
	level.scr_notetrack["foley"][2]["notetrack"]		= "dialogue";
	level.scr_notetrack["foley"][2]["facial"]		= %POWCamp_facial_Foley03_oncegatedown;
	level.scr_notetrack["foley"][2]["dialogue"]		= "powcamp_foley_readytoram3";

	
	//"...I'll stay and secure the truck!"
	level.scrsound["foley"]["secure truck"]			= "powcamp_foley_gogetingram";
	level.scr_face["foley"]["secure truck"]			= %POWCamp_facial_Foley_102alt_alrightnowgo;    
	
	
	//* INGRAM
	
	level.scr_anim["ingram"]["choke"][0]			= %powcamp_ingram_choking_loop;
	level.scr_anim["guard"]["choke"][0]			= %powcamp_guard_choking_loop;

	
	//* Yanks! Now there's a spot of luck. Come to collect me, have you?
	
	level.scr_anim["ingram"]["yanks"]			= %powcamp_ingram_001and002;
	level.scr_anim["guard"]["yanks"]			= %powcamp_guard_faints;
//	level.scr_anim["guard"]["death"]			= %powcamp_guard_faints_end;
	level.scr_notetrack["ingram"][0]["notetrack"]		= "facial";
	level.scr_notetrack["ingram"][0]["facial"]			= %POWCamp_facial_Ingram_001_yanks;
//	level.scr_notetrack["ingram"][0]["anime"]			= "yanks";
	
	level.scr_notetrack["ingram"][1]["notetrack"]		= "dialogue";
	level.scr_notetrack["ingram"][1]["dialogue"]		= "powcamp_ingram1";
//	level.scr_notetrack["ingram"][1]["anime"]			= "yanks";
	
	//* Lead on lads, no time for handshakes and hellos
	
	level.scr_notetrack["ingram"][2]["notetrack"]		= "facial";
	level.scr_notetrack["ingram"][2]["facial"]			= %POWCamp_facial_Ingram_002_leadonlads;	
//	level.scr_notetrack["ingram"][2]["anime"]			= "yanks";
	
	level.scr_notetrack["ingram"][3]["notetrack"]		= "dialogue";
	level.scr_notetrack["ingram"][3]["dialogue"]		= "powcamp_ingram2";
//	level.scr_notetrack["ingram"][3]["anime"]			= "yanks";

	level.scr_notetrack["ingram"][4]["notetrack"]		= "grabweapon";
	level.scr_notetrack["ingram"][4]["attach gun right"]= "xmodel/weapon_mp40";
//	level.scr_notetrack["ingram"][5]["anime"]			= "yanks";
	
	level.scr_notetrack["ingram"][5]["notetrack"]		= "moot";
	level.scr_notetrack["ingram"][5]["detach gun"]		= "xmodel/weapon_mp40";
	level.scr_notetrack["ingram"][5]["tag"]				= "tag_weapon_right";
//	level.scr_notetrack["ingram"][4]["anime"]			= "yanks";
	
	
	//* Good show Captain, to you and your boys! Well done, well done!
	level.scrsound["ingram"]["good show"]			= "powcamp_ingram3";
	level.scr_face["ingram"]["good show"]			= %POWCamp_facial_Ingram_003_goodshow;
	
	truck();	
}

#using_animtree("germantruck");

truck()
{
	level.scr_animtree["truck"] = #animtree;
	//* TRUCK
	
	level.scr_anim["truck"]["ok martin"]			= %powcamp_foley_dialogue_truckdoor;
	
	level.scr_anim["truck"]["door close"]			= %powcamp_foley_dialogue_truckdoor_lastframe;						

}