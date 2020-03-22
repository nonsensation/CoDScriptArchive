#using_animtree("generic_human");
main()
{
	//*-1a. All right guys, get set to move, on my command!	
	//level.scr_anim["foley"]["intro"]				= (%fullbody_foley1);
	//level.scr_face["foley"]["intro"]				= (%facial_foley1);
	//level.scrsound["foley"]["intro"]				= ("burnville_foley_1a");
	
	//*1. "Captain, we salvaged the area. Apart from some medical supplies, all we found were a couple of rifles and several Panzerfausts, which are woefully inaccurate."	
	level.scrsound["davis"]["intro"]		= "pegday_intro1";
	level.scr_face["davis"]["intro"]		= (%PegDay_facial_Lieut_01_captain);
	level.scr_anim["davis"]["intro"]		= (%pegday_lieut_01_captainwefound);
	
	//*2. "Thank God we still have that flak gun. We can use it to hold the bridge until our relief shows up."	
	level.scrsound["price"]["intro"]		= "pegday_intro2";
	level.scr_face["price"]["intro"]		= (%PegDay_facial_Price_01_thankgod);
	level.scr_anim["price"]["intro"]		= (%pegday_price_01_thankgod);
	
	//*3. "INCOMING!!"	
	level.scrsound["friend1"]["incoming"]		= "pegday_intro3";
	level.scr_face["friend1"]["incoming"]		= (%PegDay_facial_Friend1_01_incoming);
	
	//*4. "Take cover!!"	
	level.scrsound["friend2"]["takecover"]		= "pegday_intro4";
	level.scr_face["friend2"]["takecover"]		= (%PegDay_facial_Friend2_01_takecover);
	
	//*5. "Everyone, take cover!"	
	level.scrsound["price"]["everyonecover"]	= "pegday_intro5";
	level.scr_face["price"]["everyonecover"]	= (%PegDay_facial_Price_02_everyone);
	
	//*6. "Come on, get out of there -- you! Move!"	
	level.scrsound["davis"]["outofthere"]		= "pegday_intro6";
	level.scr_face["davis"]["outofthere"]		= (%PegDay_facial_Lieut_02_comeon);
	
	//*7. "Infantry, coming in from the west!"	
	level.scrsound["friend1"]["fromwest"]		= "pegday_intro7";
	level.scr_face["friend1"]["fromwest"]		= (%PegDay_facial_Friend1_02_infantry);
	
	//*8. "Bloody hell, watch the right flank!"	
	level.scrsound["friend2"]["watchright"]		= "pegday_intro8";
	level.scr_face["friend2"]["watchright"]		= (%PegDay_facial_Friend2_02_bloodyhell);
	
	//*9. "Hold this position, men!  Fall back to the bridge on my command!"	
	level.scrsound["price"]["mycommand"]		= "pegday_intro9";
	level.scr_face["price"]["mycommand"]		= (%PegDay_facial_Price_03_holdposition);
	
	//*10. "Regroup, men! Back to the bridge! Fall back to the bridge! Let's go!"	
	level.scrsound["price"]["regroup"]		= "pegday_retreat1";
	level.scr_face["price"]["regroup"]		= (%PegDay_facial_Price_04a_regroup);
	
	//*11. "Fall back across the bridge! Sergeant Evans! Get back to the machine gun and cover us!"	
	level.scrsound["price"]["fallback"]		= "pegday_retreat2";
	level.scr_face["price"]["fallback"]		= (%PegDay_facial_Price_04b_pullback);
	
	//*12. "Tank, southwest - across the canal! Sergeant Evans, take it out!"	
	level.scrsound["price"]["southwest1"]		= "pegday_tank_southwest1";
	level.scr_face["price"]["southwest1"]		= (%PegDay_facial_Price_05a_tanksouthwest);
	
	//*13. "There's another tank! Southwest!"	
	level.scrsound["price"]["southwest2"]		= "pegday_tank_southwest2";
	level.scr_face["price"]["southwest2"]		= (%PegDay_facial_Price_05b_thereisanother);
	
	//*14. "Evans! Destroy that tank to the south!"	
	level.scrsound["price"]["southeast1"]		= "pegday_tank_southeast1";
	level.scr_face["price"]["southeast1"]		= (%PegDay_facial_Price_05c_evansdestroy);
	
	//*15. "Enemy tank on the southeast road!"	
	level.scrsound["price"]["southeast2"]		= "pegday_tank_southeast2";
	level.scr_face["price"]["southeast2"]		= (%PegDay_facial_Price_05d_enemytank);
	
	//*16. "Tank, northeast! Keep your eyes open Evans!"	
	level.scrsound["price"]["northeast1"]		= "pegday_tank_northeast1";
	level.scr_face["price"]["northeast1"]		= (%PegDay_facial_Price_05e_tanknortheast);
	
	//*17. "Northeast again! Another tank!"	
	level.scrsound["price"]["northeast2"]		= "pegday_tank_northeast2";
	level.scr_face["price"]["northeast2"]		= (%PegDay_facial_Price_05f_northeastagain);
	
	//*18. "Enemy tank! Moving in from the north!"	
	level.scrsound["price"]["northeast3"]		= "pegday_tank_northeast3";
	level.scr_face["price"]["northeast3"]		= (%PegDay_facial_Price_05g_enemytankmoving);
	
	//*19. "Gentlemen, we have friendlies coming in from the west! Make sure of your targets! Watch your fire!"	
	level.scrsound["price"]["victory1"]		= "pegday_victory1";
	level.scr_face["price"]["victory1"]		= (%PegDay_facial_Price_06_gentlemen);
	
	//*20. "I believe that's the last of them.  Excellent work, lads, bloody well done!"	
	level.scrsound["price"]["victory2"]		= "pegday_victory2";
	level.scr_face["price"]["victory2"]		= (%PegDay_facial_Price_07_Ibelieve);
}
