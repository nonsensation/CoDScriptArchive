#using_animtree("generic_human");
main()
{
	//*-1a. All right guys, get set to move, on my command!	
	//level.scr_anim["foley"]["intro"]				= (%fullbody_foley1);
	//level.scr_face["foley"]["intro"]				= (%facial_foley1);
	//level.scrsound["foley"]["intro"]				= ("burnville_foley_1a");
	
	//1. Stay in the ditch and keep your head down! They've got snipers out there!
	level.scrsound["sgtpavlov"]["stayinditch"]			= "ph_pavlov1";
	level.scr_anim["sgtpavlov"]["stayinditch"]			= (%pavlov_Kamarov_001_StayInDitch);
	level.scr_face["sgtpavlov"]["stayinditch"]			= (%pavlov_facial_Kamarov_001_StayInDitch);
	
	//2. Private Kovalenko, as the fastest man here, you will be the bait.
	level.scrsound["sgtpavlov"]["bethebait"]			= "ph_pavlov2";
	level.scr_anim["sgtpavlov"]["bethebait"]			= (%pavlov_kamarov_003_pdtkovalenkofastest);
	level.scr_face["sgtpavlov"]["bethebait"]			= (%pavlov_facial_kamarov_003_pdtkovalenkofastest);
	
	//3. Me? No thank you, comrade!
	level.scrsound["kovalenko"]["nothanks"]				= "ph_pavlov3";
	level.scr_anim["kovalenko"]["nothanks"]				= (%pavlov_kovalenko_001_menothankyou);
	level.scr_face["kovalenko"]["nothanks"]				= (%pavlov_facial_kovalenko_001alt_menothankyou);
	
	//4. That is an order! Alexei will cover you with the sniper rifle from here. Now go, before I shoot you myself!
	level.scrsound["sgtpavlov"]["thatsanorder"]			= "ph_pavlov4";
	level.scr_anim["sgtpavlov"]["thatsanorder"]			= (%pavlov_kamarov_012_thatisanorder);
	level.scr_face["sgtpavlov"]["thatsanorder"]			= (%Pavlov_facial_Kamarov_012_ThatIsAnOrder);
	
	//5. Snipers in the windows! Take them out!
	level.scrsound["sgtpavlov"]["sniperwindows"]			= "ph_pavlov5";
	level.scr_anim["sgtpavlov"]["sniperwindows"]			= (%pavlov_kamarov_006_snipersinthewindow);
	level.scr_face["sgtpavlov"]["sniperwindows"]			= (%Pavlov_facial_Kamarov_006alt_SnipersInTheWindows);
	
	//6. They've got us zeroed in! We're all dead if we stay here! Let's go comrades! Go! Get moving! All of you, go!
	level.scrsound["sgtpavlov"]["zeroedin"]				= "ph_pavlov6";
	level.scr_face["sgtpavlov"]["zeroedin"]				= (%Pavlov_facial_Kamarov_005_TheyveGotUsZeroed);
	
	//7. Secure the building! Clear it out, floor by floor!
	level.scrsound["sgtpavlov"]["clearitout"]			= "ph_pavlov7";
	level.scr_face["sgtpavlov"]["clearitout"]			= (%Pavlov_facial_Kamarov_007_SecureTheBuilding);
	
	//8. Comrade Alexei, we've got those anti-tank rifles on the second and third floor! You take out the tanks - we'll stop the troops!
	level.scrsound["sgtpavlov"]["comradealexei"]			= "ph_pavlov_defend1";
	level.scr_face["sgtpavlov"]["comradealexei"]			= (%Pavlov_facial_Kamarov_009_ComradeAlexi);
	
	//9. Here they come! Ready on the anti-tank rifles!
	level.scrsound["sgtpavlov"]["readyantitank"]			= "ph_pavlov_defend2";
	level.scr_face["sgtpavlov"]["readyantitank"]			= (%Pavlov_facial_Kamarov_010_HereTheyCome);
	
	//10. Machine guns!!
	level.scrsound["sgtpavlov"]["machineguns"]			= "ph_pavlov_defend4";
	level.scr_face["sgtpavlov"]["machineguns"]			= (%Pavlov_facial_Kamarov_011_MachineGuns);
	
	//11. Get ready, comrades!!
	level.scrsound["sgtpavlov"]["readycomrades"]			= "ph_pavlov_defend6";
	
	//12. Anti-tank rifles ready!
	level.scrsound["randomguy"]["atriflesready"]			= "ph_pavlov_defend3";
	
	//13. Machine guns ready!
	level.scrsound["randomguy"]["mgsready"]				= "ph_pavlov_defend5";
	
	//14. Hold this position!
	level.scrsound["randomguy"]["holdthispos"]			= "ph_pavlov_defend7";
	
	//*** VLADIMIR THE FRIENDLY RUSSIAN GREETER
	
	//15. Hey Alexei!
	level.scrsound["vladimir"]["heyalexei"]			= "generic_greetplayerloud_russian_6";
	level.scr_face["vladimir"]["heyalexei"]			= (%Redsquare_facial_Clever_02_alexeioverthere);
}

/*

#Pavlov's House,,,,,,,,,,,,,,,

Disembodied set:

ph_pavlov_basement, Basement clear!
ph_pavlov_firstfloor, First floor clear!
ph_pavlov_secondfloor, Second floor is clear!
ph_pavlov_thirdfloor, Clear on third floor!
ph_pavlov_fourthfloor, Fourth floor is secure!
ph_pavlov_topfloor, Top floor is clear!

ph_pavlov_looking1, Alexei, the Sergeant's looking for you!
ph_pavlov_looking2, Comrade! Regroup with the Sergeant on the fourth floor!

ph_pavlov_defend3, Anti-tank rifles ready!
ph_pavlov_defend5, Machine guns ready!
ph_pavlov_defend7, Hold this position!

*/