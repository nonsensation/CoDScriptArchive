#using_animtree("generic_human");

main()
{
	level.scr_anim["nMills"]["repair"] = (%pegasus_privatemills_fixflak88);
	
	dialog();
	pilot();
	copilot();
	specials();
	stens();
	others();
	glider_interior();
}

dialog()
{
	//*-1a. All right guys, get set to move, on my command!	
	//level.scr_anim["foley"]["intro"]				= (%fullbody_foley1);
	//level.scr_face["foley"]["intro"]				= (%facial_foley1);
	//level.scrsound["foley"]["intro"]				= ("burnville_foley_1a");
	
	//1. No. 3 glider ready for separation - casting off.
	level.scrsound["pilot"]["castingoff"]		= "pegnight_glider1";
	
	
	//2. I can't see the Bois de Bavent!
	level.scrsound["pilot"]["bavent"]		= "pegnight_glider2";
	level.scr_face["pilot"]["bavent"]		= (%PegNight_facial_Glider_02_Icantsee);
								
	//3. For God's sake, Jack, it's the biggest forest in Normandy! Pay attention!
	level.scrsound["copilot"]["bigforest"]		= "pegnight_glider3";
	level.scr_face["copilot"]["bigforest"]		= (%PegNight_facial_Copilot_01_forgodsake);
	
	//4. I am! It's not there!
	level.scrsound["pilot"]["notthere"]		= "pegnight_glider4";
	level.scr_face["pilot"]["notthere"]		= (%PegNight_facial_Glider_03_Iamitsnotthere);
	
	//5. Well, perhaps they moved it. By my calculations, we're on course. You'll want to bank north two degrees at five, four, three, two, one, and bingo.
	level.scrsound["copilot"]["bingo"]		= "pegnight_glider5";
	level.scr_face["copilot"]["bingo"]		= (%PegNight_facial_Copilot_02_wellperhaps);
	
	//6. Two degrees starboard onto course.
	level.scrsound["pilot"]["twodegrees"]		= "pegnight_glider6";
	level.scr_face["pilot"]["twodegrees"]		= (%PegNight_facial_Glider_04_twodegrees);
	
	//7. All right everyone, brace for landing!
	level.scrsound["pilot"]["braceforlanding"]	= "pegnight_glider7";
	level.scr_face["pilot"]["braceforlanding"]	= (%PegNight_facial_Glider_05_allright);
	
	//8. Stream!
	level.scrsound["pilot"]["stream"]		= "pegnight_glider8";
	
	//9. Jettison the chute!
	level.scrsound["pilot"]["jettison"]		= "pegnight_glider9";
	level.scr_face["pilot"]["jettison"]		= (%PegNight_facial_Glider_07_jettisonthechute);
	
	//10a. German - Heard that noise?
	level.scr_anim["gerguard1"]["guardstalking"]	= (%pegasusnight_guard1_left);
	level.scr_notetrack["gerguard1"][0]["notetrack"] = "dialogue";
	level.scr_notetrack["gerguard1"][0]["dialogue"] = "pegnight_guard1";
	
	//10b. German - Shouldn't we check?
	level.scr_notetrack["gerguard1"][1]["notetrack"] = "dialogue";
	level.scr_notetrack["gerguard1"][1]["dialogue"] = "pegnight_guard3";
	
	//11a. German - Tis nothing.
	level.scr_anim["gerguard2"]["guardstalking"]	= (%pegasusnight_guard2_right);
	level.scr_notetrack["gerguard2"][0]["notetrack"] = "dialogue";
	level.scr_notetrack["gerguard2"][0]["dialogue"] = "pegnight_guard2";
	
	//11b. German - Don't waste your time, go check the bridge.
	level.scr_notetrack["gerguard2"][1]["notetrack"] = "dialogue";
	level.scr_notetrack["gerguard2"][1]["dialogue"] = "pegnight_guard4";
	
	//12. German - Shouldn't we check?
	//level.scrsound["gerguard1"]["shouldcheck"]	= "pegnight_guard3";
	
	//13. German - Don't waste your time, go check the bridge.
	//level.scrsound["gerguard2"]["notimewaste"]	= "pegnight_guard4";
	
	//14. Sergeant Evans, glad you're still with us -- we're in luck. The Germans haven't responded to our stellar landing.
	level.scr_anim["nPrice"]["stellar"]		= (%pegasusnight_price_introdialogue);
	level.scr_notetrack["nPrice"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["nPrice"][0]["dialogue"]	= "pegnight_price1";
	level.scr_notetrack["nPrice"][0]["facial"]	= (%PegNight_facial_Price_01a_sergeantevans);
	
	//15. Find a good spot to suppress their bunker. We'll advance behind your base of fire.
	level.scr_notetrack["nPrice"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["nPrice"][1]["dialogue"]	= "pegnight_price2";
	level.scr_notetrack["nPrice"][1]["facial"]	= (%PegNight_facial_Price_01b_findagood);
	
	//16. SUPPRESSING FIRE!
	level.scrsound["nPrice"]["suppressshout"]	= "pegnight_price3";
	level.scr_face["nPrice"]["suppressshout"]	= (%PegNight_facial_Price_02a_suppressingfire);
	
	//17. Sergeant Evans! Suppress that bunker! Keep their heads down!
	level.scrsound["nPrice"]["keepheadsdn"]		= "pegnight_price4";
	level.scr_face["nPrice"]["keepheadsdn"]		= (%PegNight_facial_Price_02b_sgtevanssuppress);
	
	//18. Panzer! Take cover!
	level.scrsound["nPrice"]["panzercover"]		= "pegnight_price5";
	level.scr_face["nPrice"]["panzercover"]		= (%PegNight_facial_Price_03_panzertakecover);
	
	//19. Sergeant! Go back across! Get to their Flak gun and turn it on that tank! Find Private Mills and take him with you! Get him to free up the bloody thing!
	level.scrsound["nPrice"]["findmills"]		= "pegnight_price6";
	level.scr_face["nPrice"]["findmills"]		= (%PegNight_facial_Price_04_sgtgoback);
	level.scr_anim["nPrice"]["findmills"]		= (%pegnight_price_04_sgtgoback);
	
	//20. No problem, I'll get it working! Follow me!
	level.scrsound["nMills"]["followme"]		= "pegnight_mills1";
	level.scr_face["nMills"]["followme"]		= (%PegNight_facial_Mills_01_noproblem);
	
	//21. That ought to do it, Sarge! Try it now!
	level.scrsound["nMills"]["oughtadoit"]		= "pegnight_mills2";
	level.scr_face["nMills"]["oughtadoit"]		= (%PegNight_facial_Mills_02_thatought);
	
	//22. That did it!
	level.scrsound["nMills"]["thatdidit"]		= "pegnight_mills3";
	level.scr_face["nMills"]["thatdidit"]		= (%PegNight_facial_Mills_03_thatdidit);
	
	//23. Nice shot, Sergeant!
	level.scrsound["nMills"]["nicesarge"]		= "pegnight_mills4";
	level.scr_face["nMills"]["nicesarge"]		= (%PegNight_facial_Mills_04_niceshot);
	
	//24. Check those trenches!
	level.scrsound["nMills"]["checktrenches"]	= "pegnight_mills5";
	level.scr_face["nMills"]["checktrenches"]	= (%PegNight_facial_Mills_05_checkthose);
	
	//25. Bridge clear!
	level.scrsound["nMills"]["bridgeclearmills"]	= "pegnight_mills6";
	level.scr_face["nMills"]["bridgeclearmills"]	= (%PegNight_facial_Mills_06_bridgeclear);
	
	//26. German - It's the enemy!
	level.scrsound["alertedguard"]["germanalerted"]	= "generic_enemysighted_german_1vbritish";
	
	//27. German - Enemy spotted!
	level.scrsound["sightedguard"]["germansighted"]	= "generic_enemysighted_german_1vbritish";
	
	//*** Friendly victory phrases
	
	//28. They're pulling back!
	level.scrsound["randomguy"]["victory1"]		= "pegnight_victory1";
	
	//29. Ham and jam! Bridge secured!
	level.scrsound["randomguy"]["victory2"]		= "pegnight_victory2";
	
	//30. All clear!
	level.scrsound["randomguy"]["victory3"]		= "pegnight_victory3";
	
	//31. All clear! (alt voice)
	level.scrsound["randomguy"]["victory4"]		= "pegnight_victory4";
	
	//32. Clear over here!
	level.scrsound["randomguy"]["victory5"]		= "pegnight_victory5";
}

/*

pegnight_victory1, They're pulling back!
pegnight_victory2, Ham and jam! Bridge secured!
pegnight_victory3, All clear!
pegnight_victory4, All clear! (alt)
pegnight_victory5, Clear over here!

Disembodied Set:

	pegnight_crash1, Blood hard landing, eh?
	pegnight_crash2, Is everyone all right? Mills!
	pegnight_crash3, Yeah I'm fine, just great.
	pegnight_crash4, Button up! Let's go! Let's go!
	pegnight_crash5, Move, move, move! Come on!

	pegasusnight_enemy_openfire, Open fire!
*/

/****************************************************************************

Level: 		PEGASUS BRIDGE NIGHT GLIDER RIDE, ANIMATIONS

Added the animations for the second half of the glider sequence.  
I'm not sure who is doing the level script for this, but here's what you need to know so far:
 
The glider is called vehicle_british_horsainterior.  It uses the animtree vehicle_british_horsainterior.atr, 
and has an animation on it called pegasus_glider_glider_2ndhalf.
 
In the glider there is a tag for the camera, called tag_camera.  There are also tags for the guys, called tag_guy01 through tag_guy12.
 
Each guy has one animation to play, called %pegasus_glider_guy01_2ndhalf through %pegasus_glider_guy12_2ndhalf.
 
The animation on the glider itself does the bouncing when it gets to the ground.  You need to make it fly along a path and hit the 
ground at 8 seconds into this animation, then skid along the ground until the end of the animation (22.3 seconds) at which point 
the player is supposed to black out.
 
The first half of the sequence is a little more complicated - involving looping animations and things like that.  
We haven't exported those yet.

*****************************************************************************/

#using_animtree("horsa_guy1");
pilot()
{
	level.scr_animtree["guy1"] = #animtree;
	
	level.scr_anim["guy1"]["intro"]			= (%pegasus_glider_guy01_intro);
	
	level.scr_anim["guy1"]["highturb"][0] 		= (%pegasus_glider_guy01_highturb);
    	level.scr_anim["guy1"]["lowturb"][0]		= (%pegasus_glider_guy01_lowturb);
    	level.scr_anim["guy1"]["lowturb"][1]		= (%pegasus_glider_guy01_lowturb_twitch);
    	
    	level.scr_anim["guy1"]["dialogue_start"]	= (%pegasus_glider_guy01_dialogue_start);
    	level.scr_anim["guy1"]["dialogue_loop"][0]	= (%pegasus_glider_guy01_dialogue_loop);
    	level.scr_anim["guy1"]["turnright"]		= (%pegasus_glider_guy01_turnright);
    	
    	level.scr_anim["guy1"]["2nd half"]		= (%pegasus_glider_guy01_2ndhalf);
    	level.scr_face["guy1"]["2nd half"]		= (%PegNight_facial_Glider_05_allright);
    	level.scrsound["guy1"]["2nd half"]		= "pegnight_glider7";
    	//level.scr_notetrack["guy1"][0]["notetrack"]	= "dialogue";
    	
	//level.scr_notetrack["guy1"][0]["dialogue"]	= "pegnight_glider7";
	//level.scr_notetrack["guy1"][0]["facial"]	= %dawnville_facial_Parker_south;
}

#using_animtree("horsa_guy2");
copilot()
{
	level.scr_animtree["guy2"] = #animtree;
	
	level.scr_anim["guy2"]["highturb"][0]		= (%pegasus_glider_guy02_highturb);
    	level.scr_anim["guy2"]["lowturb"][0]		= (%pegasus_glider_guy02_lowturb);
    	level.scr_anim["guy2"]["lowturb"][1]		= (%pegasus_glider_guy02_lowturb_twitch);
    	
    	level.scr_anim["guy2"]["dialogue"]		= (%pegasus_glider_guy02_dialogue);
    	
    	level.scr_anim["guy2"]["2nd half"]		= (%pegasus_glider_guy02_2ndhalf);
}

#using_animtree("horsa_specials");
specials()
{
	level.scr_animtree["horsa_specials"] = #animtree;

	level.scr_notetrack["guy3"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy3"][0]["swap from"]= "tag_weapon_right";
	level.scr_notetrack["guy3"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy3"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy3"][1]["swap from"]= "tag_weapon_left";
	level.scr_notetrack["guy3"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy11"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy11"][0]["swap from"]= "tag_weapon_right";
	level.scr_notetrack["guy11"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy11"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy11"][1]["swap from"]= "tag_weapon_left";
	level.scr_notetrack["guy11"][1]["self tag"]	= "tag_weapon_right";
	
	
	
	level.scr_anim["guy3"]["highturb"][0]		= (%pegasus_glider_guy06_highturb);
	level.scr_face["guy3"]["highturb"][0]		= (%PegNight_facial_glider_guy12_highturb);

	level.scr_anim["guy3"]["lowturb"][0]		= (%pegasus_glider_guy11_lowturb_lookaround);
	level.scr_face["guy3"]["lowturb"][0]		= (%PegNight_facial_glider_guy11_lookaround);
	level.scr_anim["guy3"]["lowturb"][1]		= (%pegasus_glider_guy11_lowturb_lookleft);
	level.scr_anim["guy3"]["lowturb"][2]		= (%pegasus_glider_guy06_lowturb);
	level.scr_face["guy3"]["lowturb"][2]		= (%PegNight_facial_glider_guy12_lowturb);
	
	level.scr_anim["guy3"]["2nd half"]			= (%pegasus_glider_guy03_2ndhalf); 
	level.scr_face["guy3"]["2nd half"]			= (%PegNight_facial_glider_highturb); 

	level.scr_anim["guy11"]["lowturb"][0]		= (%pegasus_glider_guy11_lowturb_lookaround);
	level.scr_face["guy11"]["lowturb"][0]		= (%PegNight_facial_glider_guy11_lookaround);
	level.scr_anim["guy11"]["lowturbweight"][0]	= 6.0;
	level.scr_anim["guy11"]["lowturb"][1]		= (%pegasus_glider_guy11_lowturb_adjusthelmet);
	level.scr_face["guy11"]["lowturb"][1]		= (%PegNight_facial_glider_guy12_lowturb);
	level.scr_anim["guy11"]["lowturb"][2]		= (%pegasus_glider_guy11_lowturb_lookleft);
	level.scr_face["guy11"]["lowturb"][2]		= (%PegNight_facial_glider_guy11_lookleft);
	level.scr_anim["guy11"]["lowturbweight"][2]	= 2.0;
	level.scr_anim["guy11"]["lowturb"][3]		= (%pegasus_glider_guy11_lowturb_lookright);
	level.scr_face["guy11"]["lowturb"][3]		= (%PegNight_facial_glider_guy11_lookright);
	
	level.scr_anim["guy11"]["lowturb"][4]		= (%pegasus_glider_guy11_lowturb_sneeze);
	level.scr_face["guy11"]["lowturb"][4]		= (%PegNight_facial_glider_guy11_sneeze);
	level.scrsound["guy11"]["lowturb"][4]		= "sneeze";
	level.scr_anim["guy11"]["lowturbweight"][4]	= 0.15;
	
	level.scr_anim["guy11"]["highturb"][0]		= (%pegasus_glider_guy06_highturb);
	level.scr_face["guy11"]["highturb"][0]		= (%PegNight_facial_glider_guy12_highturb);
	 
	level.scr_anim["guy11"]["2nd half"]			= (%pegasus_glider_guy11_2ndhalf);  
	level.scr_face["guy11"]["2nd half"]			= (%PegNight_facial_glider_highturb); 	
}

#using_animtree("horsa_stens");
stens()
{
	level.scr_animtree["horsa_stens"] = #animtree;

	level.scr_notetrack["guy4"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy4"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy4"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy4"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy4"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy4"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy10"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy10"][0]["swap from"]= "tag_weapon_right";
	level.scr_notetrack["guy10"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy10"][1]["notetrack"]= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy10"][1]["swap from"]= "tag_weapon_left";
	level.scr_notetrack["guy10"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy12"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy12"][0]["swap from"]= "tag_weapon_right";
	level.scr_notetrack["guy12"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy12"][1]["notetrack"]= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy12"][1]["swap from"]= "tag_weapon_left";
	level.scr_notetrack["guy12"][1]["self tag"]	= "tag_weapon_right";

	
	level.scr_anim["guy4"]["lowturb"][0]		= (%pegasus_glider_guy12_lowturb);
	level.scr_anim["guy4"]["highturb"][0]		= (%pegasus_glider_guy12_highturb);
	level.scr_anim["guy4"]["2nd half"]			= (%pegasus_glider_guy04_2ndhalf); 

	//level.scr_anim["guy10"]["cigarette_smokedrop"]	= (%pegasus_glider_guy10_draganddropcigarette);
	level.scr_anim["guy10"]["highturb"][0]		= (%pegasus_glider_guy12_highturb);
	level.scr_face["guy10"]["highturb"][0]		= (%PegNight_facial_glider_guy12_highturb);
	level.scr_anim["guy10"]["lowturb"][0]		= (%pegasus_glider_guy12_lowturb);
	level.scr_face["guy10"]["lowturb"][0]		= (%PegNight_facial_glider_guy12_lowturb);
	level.scr_anim["guy10"]["2nd half"]			= (%pegasus_glider_guy10_2ndhalf); 
	level.scr_face["guy10"]["2nd half"]			= (%PegNight_facial_glider_highturb); 
	
	level.scr_anim["guy12"]["highturb"][0]		= (%pegasus_glider_guy12_highturb);
	level.scr_face["guy12"]["highturb"][0]		= (%PegNight_facial_glider_guy12_highturb);
	level.scr_anim["guy12"]["lowturb"][0]		= (%pegasus_glider_guy12_lowturb);
	level.scr_face["guy12"]["lowturb"][0]		= (%PegNight_facial_glider_guy12_lowturb);
	level.scr_anim["guy12"]["lowturb"][1]		= (%pegasus_glider_guy12_lowturb_twitch);
	level.scr_face["guy12"]["lowturb"][1]		= (%PegNight_facial_glider_guy12_lowturb_twitch);
	
	level.scr_anim["guy12"]["2nd half"]			= (%pegasus_glider_guy12_2ndhalf); 
	level.scr_face["guy12"]["2nd half"]			= (%PegNight_facial_glider_highturb); 
}

#using_animtree("horsa_others");
others()
{
	level.scr_animtree["horsa_others"] = #animtree;
	
	level.scr_notetrack["guy5"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy5"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy5"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy5"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy5"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy5"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy6"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy6"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy6"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy6"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy6"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy6"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy7"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy7"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy7"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy7"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy7"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy7"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy8"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy8"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy8"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy8"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy8"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy8"][1]["self tag"]	= "tag_weapon_right";
	
	level.scr_notetrack["guy9"][0]["notetrack"]	= "anim_gunhand = \"left\"";
	level.scr_notetrack["guy9"][0]["swap from"]	= "tag_weapon_right";
	level.scr_notetrack["guy9"][0]["self tag"]	= "tag_weapon_left";
	level.scr_notetrack["guy9"][1]["notetrack"]	= "anim_gunhand = \"right\"";
	level.scr_notetrack["guy9"][1]["swap from"]	= "tag_weapon_left";
	level.scr_notetrack["guy9"][1]["self tag"]	= "tag_weapon_right";


	level.scr_anim["guy5"]["lowturb"][0]		= (%pegasus_glider_guy09_lowturb);
	level.scr_anim["guy5"]["highturb"][0]		= (%pegasus_glider_guy09_highturb);

	level.scr_anim["guy6"]["highturb"][0]		= (%pegasus_glider_guy06_highturb);

	level.scr_anim["guy6"]["lowturb"][0]		= (%pegasus_glider_guy11_lowturb_lookaround);
	level.scr_anim["guy6"]["lowturbweight"][0]	= 1.0;	
	level.scr_anim["guy6"]["lowturb"][1]		= (%pegasus_glider_guy06_lowturb);
	level.scr_anim["guy6"]["lowturbweight"][1]	= 0.3;
	//level.scrsound["guy6"]["lowturb"][1]		= "cough";	
	
	level.scr_anim["guy6"]["highturb_smoke"]	= (%pegasus_glider_guy06_dragcigarette_highturb);
	level.scr_anim["guy6"]["lowturb_smoke"]		= (%pegasus_glider_guy06_dragcigarette_lowturb);
	level.scr_anim["guy6"]["cigarette"]			= (%pegasus_glider_guy06_passcigaretteto09);
 
	level.scr_anim["guy7"]["lowturb"][0]		= (%pegasus_glider_guy11_lowturb_lookleft);
	level.scr_anim["guy7"]["highturb"][0]		= (%pegasus_glider_guy09_highturb);
	
	level.scr_anim["guy8"]["lowturb"][0]		= (%pegasus_glider_guy06_lowturb);
	level.scr_anim["guy8"]["lowturbweight"][0]	= 3.0;	
	level.scr_anim["guy8"]["lowturb"][1]		= (%pegasus_glider_guy11_lowturb_adjusthelmet);
	level.scr_anim["guy8"]["lowturbweight"][1]	= 1.0;
	level.scr_anim["guy8"]["lowturb"][2]		= (%pegasus_glider_guy06_lowturb);
	level.scrsound["guy8"]["lowturb"][2]		= "cough";
	level.scr_anim["guy8"]["lowturbweight"][2]	= 1.0;	
	level.scr_anim["guy8"]["highturb"][0]		= (%pegasus_glider_guy12_highturb);

	level.scr_anim["guy9"]["highturb"][0]		= (%pegasus_glider_guy09_highturb);
	level.scr_anim["guy9"]["lowturb"][0]		= (%pegasus_glider_guy09_lowturb);
	level.scr_anim["guy9"]["highturb_smoke"]	= (%pegasus_glider_guy09_dragcigarette_highturb);
	level.scr_anim["guy9"]["lowturb_smoke"]		= (%pegasus_glider_guy09_dragcigarette_lowturb);
	level.scr_anim["guy9"]["cigarette"]		= (%pegasus_glider_guy09_passcigarettefrom06);
	
	level.scr_anim["guy5"]["2nd half"]		= (%pegasus_glider_guy05_2ndhalf); 
 	level.scr_anim["guy6"]["2nd half"]			= (%pegasus_glider_guy06_2ndhalf); 
	level.scr_anim["guy7"]["2nd half"]		= (%pegasus_glider_guy07_2ndhalf); 
	level.scr_anim["guy8"]["2nd half"]		= (%pegasus_glider_guy08_2ndhalf); 
	level.scr_anim["guy9"]["2nd half"]		= (%pegasus_glider_guy09_2ndhalf); 
}

#using_animtree("vehicle_british_horsainterior");
glider_interior()
{
	level.scr_animtree["glider"] = #animtree;
	
	level.scr_anim["glider"]["2nd half"]		= (%pegasus_glider_glider_2ndhalf);
	level.scr_anim["glider"]["gliderlowturb"]	= (%pegasus_glider_glider_lowturb);
	level.scr_anim["glider"]["gliderhighturb"]	= (%pegasus_glider_glider_highturb);
}

#using_animtree("horsa_guy");
glider()
{	
	//level.scr_animtree["guy"] = #animtree;
	
	//Animations for the pilot and copilot for the beginning of the glider ride.  These are a bit tricky.
 
	//First, the pilot plays
    	
    	//level.scr_anim["guy1"]["intro"]			= (%pegasus_glider_guy01_intro);
	
	//(the copilot skips this bit and goes straight to the next bit)
 
	//Then they play
    	/*
    	level.scr_anim["guy1"]["highturb"] 		= (%pegasus_glider_guy01_highturb);
    	level.scr_anim["guy1"]["lowturb"]		= (%pegasus_glider_guy01_lowturb);
    	level.scr_anim["guy1"]["lowturb_twitch"]	= (%pegasus_glider_guy01_lowturb_twitch);
    	*/
	//or
	/*
    	level.scr_anim["guy2"]["highturb"]		= (%pegasus_glider_guy02_highturb);
    	level.scr_anim["guy2"]["lowturb"]		= (%pegasus_glider_guy02_lowturb);
    	level.scr_anim["guy2"]["lowturb_twitch"]	= (%pegasus_glider_guy02_lowturb_twitch);
	*/
	//Basically at any point in time you decide if you're having low turbulence or high turbulence.  
	//You should use low most of the time and break it up with high.  
	//While the turbulence is low, each guy should play his low turbulence loop and occasionally play his twitch.  
	//When the turbulence is high you should switch over to the high turbulence loop.  
	//This is how most of the guys in the glider will work.
    
	//At 13 seconds, the pilot plays
    	/*
    	level.scr_anim["guy1"]["dialogue_start"]	= (%pegasus_glider_guy01_dialogue_start);
    	level.scr_anim["guy1"]["dialogue_loop"]		= (%pegasus_glider_guy01_dialogue_loop);
    	level.scr_anim["guy1"]["turnright"]		= (%pegasus_glider_guy01_turnright);
	*/
	//while the copilot plays
    
    	//level.scr_anim["guy2"]["dialogue"]		= (%pegasus_glider_guy02_dialogue);
 
	//The dialogue for this section should just be played back to back for now.  
	//The copilot's dialogue animation will probably have to be broken into an intro, a loop and an end like the pilot's.
	
	/*
	The rules for playing the following:
	- all the guys play high turbulence animations at the same time, and low turbulence at the same time.
	- the low turbulence animations are all different lengths so don't time them all from one guy
	- guy06 drags on his cigarette and then passes it to 09.  06 and 09 play the pass sequence at the same time.  
	- There's a note in the pass animation called "pass" that we can use to pass the cigarette if we ever have one.
	- All the other guys in the glider can play idles from these guys.  Give guy12 animations to guy04 or guy05, and give guy11 
	animations to guy07 or guy08, and give the other guys just basic lowturb and highturb animations from someone else.
	*/	
	/*
	level.scr_anim["guy6"]["highturb"]		= (%pegasus_glider_guy06_highturb);
	level.scr_anim["guy6"]["lowturb"]		= (%pegasus_glider_guy06_lowturb);
	level.scr_anim["guy6"]["highturb_cigarette"]	= (%pegasus_glider_guy06_dragcigarette_highturb);
	level.scr_anim["guy6"]["lowturb_cigarette"]	= (%pegasus_glider_guy06_dragcigarette_lowturb);
	level.scr_anim["guy6"]["pass_cigarette_to9"]	= (%pegasus_glider_guy06_passcigaretteto09);
 
	level.scr_anim["guy9"]["highturb"]		= (%pegasus_glider_guy09_highturb);
	level.scr_anim["guy9"]["lowturb"]		= (%pegasus_glider_guy09_lowturb);
	level.scr_anim["guy9"]["highturb_cigarette"]	= (%pegasus_glider_guy09_dragcigarette_highturb);
	level.scr_anim["guy9"]["lowturb_cigarette"]	= (%pegasus_glider_guy09_dragcigarette_lowturb);
	level.scr_anim["guy9"]["pass_cigarette_from6"]	= (%pegasus_glider_guy09_passcigarettefrom06);
 	*/
	//level.scr_anim["guy10"]["cigarette_smokedrop"]	= (%pegasus_glider_guy10_draganddropcigarette);
	/*
	level.scr_anim["guy11"]["lowturb_lookaround"]	= (%pegasus_glider_guy11_lowturb_lookaround);
	level.scr_anim["guy11"]["lowturb_adjusthelmet"]	= (%pegasus_glider_guy11_lowturb_adjusthelmet);
	level.scr_anim["guy11"]["lowturb_lookleft"]	= (%pegasus_glider_guy11_lowturb_lookleft);
	level.scr_anim["guy11"]["lowturb_lookright"]	= (%pegasus_glider_guy11_lowturb_lookright);
	level.scr_anim["guy11"]["lowturb_sneeze"]	= (%pegasus_glider_guy11_lowturb_sneeze);
	 
	level.scr_anim["guy12"]["highturb"]		= (%pegasus_glider_guy12_highturb);
	level.scr_anim["guy12"]["lowturb"]		= (%pegasus_glider_guy12_lowturb);
	level.scr_anim["guy12"]["lowturb_twitch"]	= (%pegasus_glider_guy12_lowturb_twitch);
	*/
	//The rest of the guys 
	/*
	level.scr_anim["guy3"]["highturb"]		= (%pegasus_glider_guy06_highturb);
	level.scr_anim["guy4"]["highturb"]		= (%pegasus_glider_guy12_highturb);
	level.scr_anim["guy5"]["highturb"]		= (%pegasus_glider_guy09_highturb);
	level.scr_anim["guy7"]["highturb"]		= (%pegasus_glider_guy09_highturb);
	level.scr_anim["guy8"]["highturb"]		= (%pegasus_glider_guy12_highturb);
	//level.scr_anim["guy10"]["highturb"]		= (%pegasus_glider_guy09_highturb);
	//level.scr_anim["guy11"]["highturb"]		= (%pegasus_glider_guy12_highturb);

	level.scr_anim["guy3"]["lowturb"]		= (%pegasus_glider_guy11_lowturb_lookaround);
	level.scr_anim["guy4"]["lowturb"]		= (%pegasus_glider_guy12_lowturb);
	level.scr_anim["guy5"]["lowturb"]		= (%pegasus_glider_guy09_lowturb);
	level.scr_anim["guy7"]["lowturb"]		= (%pegasus_glider_guy11_lowturb_lookleft);
	level.scr_anim["guy8"]["lowturb"]		= (%pegasus_glider_guy11_lowturb_adjusthelmet);
	level.scr_anim["guy10"]["lowturb"]		= (%pegasus_glider_guy12_lowturb);
	level.scr_anim["guy11"]["lowturb"]		= (%pegasus_glider_guy11_lowturb_lookright);
	*/
	//2nd half anims - rough landing sequence
	
	//level.scr_anim["guy1"]["2nd half"]		= (%pegasus_glider_guy01_2ndhalf);
	//level.scr_anim["guy2"]["2nd half"]		= (%pegasus_glider_guy02_2ndhalf);
	
	/*
	level.scr_anim["guy3"]["2nd half"]		= (%pegasus_glider_guy03_2ndhalf); 
	level.scr_anim["guy4"]["2nd half"]		= (%pegasus_glider_guy04_2ndhalf); 
	level.scr_anim["guy5"]["2nd half"]		= (%pegasus_glider_guy05_2ndhalf); 
	
	level.scr_anim["guy7"]["2nd half"]		= (%pegasus_glider_guy07_2ndhalf); 
	level.scr_anim["guy8"]["2nd half"]		= (%pegasus_glider_guy08_2ndhalf); 
	*/
	//level.scr_anim["guy10"]["2nd half"]		= (%pegasus_glider_guy10_2ndhalf); 
	//level.scr_anim["guy6"]["2nd half"]		= (%pegasus_glider_guy06_2ndhalf); 
	//level.scr_anim["guy9"]["2nd half"]		= (%pegasus_glider_guy09_2ndhalf); 
	//level.scr_anim["guy11"]["2nd half"]		= (%pegasus_glider_guy11_2ndhalf); 
	//level.scr_anim["guy12"]["2nd half"]		= (%pegasus_glider_guy12_2ndhalf); 
	
	//glider_interior();
}