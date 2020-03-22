#using_animtree("generic_human");
main()
{
	// Generic
	level.scr_anim["generic"]["kick door 1"] = %chateau_kickdoor1;
	level.scr_anim["generic"]["kick door 2"] = %chateau_kickdoor2;

/*
chess animations;
	play (think) animations on both characters until the player gets close enough to see them..
	play (guard) for the last line of the guards dialogue
	play (move1), then (move2), and finally (move3).These need to be played in order but you can play (think) between them if you need 
	to slow it down...
	
	play (think) until the player interupts the seqence...
	if (stand) guy is killed play a normal standing death. If he sees the player or is alerted by the player... play (panic) and he 
	will move to corner behavior in cover.
	if (sit) guy is killed play (death). If he sees the player or is alerted by the player... play (leap) go for his gun.
	chess animations; rig
	
	when the (sit) guy reacts to the player he kicks and moves some of the props so play the corresponding anim (leap/death)
	you will also need to play the corresponding chess piece animations for the moves (move1,move2,move3) 
	if this is done correctly the game board will look different based on when you interupt it and he will still be able to kick the 
	board at any point in the game...  

*/
	level.scr_animtree["stand"] = #animtree;
	level.scr_anim["stand"]["fight"]		= (%chess_standguy_paniccover);
	level.scr_anim["stand"]["move 1"]		= (%chess_standguy_move01);
	level.scr_anim["stand"]["move 2"]		= (%chess_standguy_move02);
	level.scr_anim["stand"]["move 3"]		= (%chess_standguy_move03);
	level.scr_anim["stand"]["idle"][0]		= (%chess_standguy_thinkidle);
	level.scr_anim["stand"]["idle"][1]		= (%chess_standguy_thinktwitch);
	level.scr_anim["stand"]["think 1"]		= (%chess_standguy_thinkidle);
//	level.scrsound["stand"]["think 1"]			= "Pathfinder_German_Guard1_hmm";
	level.scr_anim["stand"]["think 2"]		= (%chess_standguy_thinktwitch);
//	level.scrsound["stand"]["think 2"]			= "Pathfinder_German_Guard1_hmm";
	level.scr_anim["stand"]["guard"]		= (%chess_standguy_guard102);
	level.scr_anim["stand"]["death"]		= (%death_run_left);
  
		
  
	level.scr_animtree["sit"] = #animtree;
	level.scr_anim["sit"]["sit death"]		= (%chess_sitguy_sitdeath);
	level.scr_anim["sit"]["leap death"]		= (%chess_sitguy_leapingdeath);

	level.scr_anim["sit"]["fight"]			= (%chess_sitguy_leapforgun);
	level.scr_anim["sit"]["move 1"]			= (%chess_sitguy_move01);
//	level.scrsound["sit"]["move 1"]			= "Pathfinder_German_Guard2_kibitz";
	level.scr_anim["sit"]["move 2"]			= (%chess_sitguy_move02);
//	level.scrsound["sit"]["move 2"]			= "Pathfinder_German_Guard2_kibitz";
	level.scr_anim["sit"]["move 3"]			= (%chess_sitguy_move03);
//	level.scrsound["sit"]["move 3"]			= "Pathfinder_German_Guard2_kibitz";
	level.scr_anim["sit"]["idle"][0]		= (%chess_sitguy_thinkidle);
	level.scr_anim["sit"]["idle"][1]		= (%chess_sitguy_thinktwitch);
	level.scr_anim["sit"]["think 1"]		= (%chess_sitguy_thinkidle);
	level.scr_anim["sit"]["think 2"]		= (%chess_sitguy_thinktwitch);
	level.scr_anim["sit"]["guard"]			= (%chess_sitguy_guard102);


//	level.scr_anim["foley"]["get moving"]			= (%fullbody_foley8);
	level.scr_anim["foley"]["get moving"]			= %dawn_moody_run_and_wave;
	level.scr_face["foley"]["get moving"]			= (%facial_foley8);
	level.scrsound["foley"]["get moving"]			= ("burnville_foley_8");
	
	/*
	level.scr_notetrack["sit"][0]["notetrack"] = "detach gun";
	level.scr_notetrack["sit"][0]["detach gun"] = "xmodel/weapon_kAr98";
	level.scr_notetrack["sit"][0]["tag"] = "kar99";

	level.scr_notetrack["sit"][1]["notetrack"] = "attach gun left";
	*/
	
/*
piss animations; characters
	play (idle). it is long so you won't need to play it more then once after the player sees it.
	play (shakeout) for him to finish.
	if the player gets in his line of sight or fires at him play (flinch turn) - he will quickly go for his gun
	if he isn't desturbed before finishing play (casual turn) - he turn around to get his gun and start to walk off
	if he is shot he can play a normal standing pain but his gun may just appear in his hand... if this is an issue we can deal with it.
piss animations; rig
	you use this simply to get the basepose for the gun...
*/
//	piss_sequence_gunpose (xmodel)  - to place gun in correct spot leaning against the tree 

	level.scr_anim["pisser"]["casual turn"]	= (%pisser_casualturn);
	level.scr_anim["pisser"]["flinch turn"] = (%pisser_flinchturn);
	level.scr_anim["pisser"]["idle"]		= (%pisser_pissidle);
	level.scr_anim["pisser"]["shakeout"]	= (%pisser_shakeout);

	level.scr_notetrack["pisser"][0]["notetrack"] = "detach gun";
	level.scr_notetrack["pisser"][0]["detach gun"] = "xmodel/weapon_kAr98";
	level.scr_notetrack["pisser"][0]["tag"] = "TAG_GUN";

	level.scr_notetrack["pisser"][1]["notetrack"] = "attach gun left";
	level.scr_notetrack["pisser"][1]["attach gun left"] = "xmodel/weapon_kAr98";
	paraguy();
	parachute();
	c47();
	treeguy();
}

enableChessSounds ()
{
	level.scrsound["stand"]["think 1"]			= "Pathfinder_German_Guard1_hmm";
	level.scrsound["stand"]["think 2"]			= "Pathfinder_German_Guard1_hmm";
	level.scrsound["sit"]["move 1"]				= "Pathfinder_German_Guard2_kibitz1";
	level.scrsound["sit"]["move 2"]				= "Pathfinder_German_Guard2_kibitz2";
	level.scrsound["sit"]["move 3"]				= "Pathfinder_German_Guard2_kibitz1";
}

#using_animtree("animation_rig_chessgame");
props()
{
	level.scr_animtree["pieces"] = #animtree;

	level.scr_anim["pieces"]["move 1"]		= (%chess_pieces_move01);
	level.scr_anim["pieces"]["move 2"]		= (%chess_pieces_move02);
	level.scr_anim["pieces"]["move 3"]		= (%chess_pieces_move03);
	level.scr_anim["pieces"]["fight"]		= (%chess_props_leapforgun);
	level.scr_anim["pieces"]["death"]		= (%chess_props_sitdeath);
}


/*
paratrooper landing; characters
want to set it up so the guys that land in the open pick between these two landings randomly
next I will make specific landing to interact with objects in the world...
*/

#using_animtree("generic_human");
paraguy()
{
	level.scr_anim["paraguy"]["landing 1"]	= (%airborne_landing_firm);
	level.scr_anim["paraguy"]["landing 2"]	= (%airborne_landing_roll);
	level.scr_anim["paraguy"]["jump"]		= (%airborne_jumpA);
	level.scr_anim["paraguy"]["jump idle"][0]	= (%airborne_idleA);
	level.scr_anim["paraguy"]["hit"]		= (%airborne_hitA);
	
	//	Move out! Secure the perimeter!
	level.scrsound["paraguy"]["move out"]			= "Pathfinder_USA_Para1_Perimeter";
	//	You guys, over here! By the wall! Defensive positions, get down!"
	level.scrsound["paraguy"]["over here"]		= "Pathfinder_USA_Para2_Defensive";
	
}

#using_animtree("pathfinder_treeguy");
treeguy()
{
	level.scr_animtree["tree_guy"] = #animtree;
	level.scr_anim["tree_guy"]["idle"][0]	= (%hangingguy_tree_idle);
}


#using_animtree("animation_rig_parachute");
parachute()
{
	level.scr_animtree["parachute"] = #animtree;
	level.scr_animtree["paraguy fake"] = #animtree;

	level.scr_anim["parachute"]["landing 1"]		= (%parachute_landing_firm);
	level.scr_anim["parachute"]["landing 2"]		= (%parachute_landing_roll);
	level.scr_anim["parachute"]["idle"][0]			= (%hanginggear_tree_idle);

	level.scr_anim["parachute"]["jump"]				= (%parachute_jumpA);
	level.scr_anim["parachute"]["jump idle"][0]		= (%parachute_idleA);
	level.scr_anim["parachute"]["hit"]				= (%parachute_hitA);

	level.scr_anim["paraguy fake"]["landing 1"]		= (%airborne_landing_firm);
	level.scr_anim["paraguy fake"]["landing 2"]		= (%airborne_landing_roll);
	level.scr_anim["paraguy fake"]["jump"]			= (%airborne_jumpA);
	level.scr_anim["paraguy fake"]["jump idle"][0]	= (%airborne_idleA);
	level.scr_anim["paraguy fake"]["hit"]			= (%airborne_hitA);

/*
	//	Move out! Secure the perimeter!
	level.scrsound["parachute"]["move out"]			= "Pathfinder_USA_Para1_Perimeter";
	//	You guys, over here! By the wall! Defensive positions, get down!"
	level.scrsound["parachute"]["over here"]		= "Pathfinder_USA_Para2_Defensive";
*/
//Pathfinder_USA_Para3_Jerries,,voiceovers/us/pathfinder/Path_Para3_001_Gerries.wav,1.5,,,240,1200,,voice,streamed,,,,,Jerries to the south! Suppressing fire! Behind us! Cover the rear!
	

}

#using_animtree("c47");
c47()
{
	level.scr_animtree["c47"] = #animtree;

	level.scr_anim["c47"]["root"]			= (%root);
	level.scr_anim["c47"]["hit above"]		= (%c47_flakhit_above);
	level.scr_anim["c47"]["hit below"]		= (%c47_flakhit_below);
	level.scr_anim["c47"]["idle"][0]		= (%c47_idleA);
	level.scr_anim["c47"]["idle"][1]		= (%c47_idleB);
	level.scr_anim["c47"]["spin"][0]		= (%c47_spin);
}

 
/*
character animations------------------------ 
chess_standguy_paniccover
chess_standguy_move03
chess_standguy_move02
chess_standguy_thinktwitch
chess_standguy_thinkidle
chess_standguy_move01
chess_standguy_guard102

chess_sitguy_sitdeath
chess_sitguy_leapforgun
chess_sitguy_move03
chess_sitguy_move02
chess_sitguy_thinktwitch
chess_sitguy_thinkidle
chess_sitguy_move01
chess_sitguy_guard102 

prop animations---------------------- 
chess_pieces_move01
chess_pieces_move02
chess_pieces_move03
chess_props_leapforgun
chess_props_sitdeath


piss_sequence_gunpose (xmodel) 
pisser_casualturn 
pisser_flinchturn 
pisser_pissidle 
pisser_shakeout 
*/


	