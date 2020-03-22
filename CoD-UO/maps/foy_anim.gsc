#using_animtree("generic_human");
main()
{
	maps\foy_anim::allied_drones();
	maps\foy_anim::axis_drones();
	maps\foy_anim::lamp_table_anim();

	maps\foy_anim::moody();
	maps\foy_anim::foley();
	maps\foy_anim::others();



//need to put these in for each guy
////////////				c_us_foy_foley_ev00_01
////////////				c_us_foy_foley_ev00_01a  
////////////				c_us_foy_dyke_ev01_01 
////////////				c_us_foy_moody_ev01_03 
////////////				c_us_foy_moody_ev01_04
////////////				c_us_foy_moody_ev_03_01 
////////////				c_us_foy_foley_ev08_01 
////////////				c_us_foy_foley_ev09_01 

//f_foy_moody_ev02_01

//c_us_foy_foley_ev07_01 

}

moody()
{
// kick door anims
	level.scr_anim["moody"]["kick_door_1"] = %chateau_kickdoor1;
	level.scr_anim["moody"]["kick_door_2"] = %chateau_kickdoor2;

// moody section
// Stick_with_me
	level.scrsound["moody"]["Stick_with_me"]			= "Moody_ev01_00a";
	level.scr_face["moody"]["Stick_with_me"]			= (%f_foy_moody_ev01_00a);

// moody charge
	level.scrsound["moody"]["go_go_go"]				= "moody_ev01_01";
	level.scr_face["moody"]["go_go_go"]				= (%f_foy_moody_ev01_01);
	level.scr_anim["moody"]["go_go_go"]				= (%c_run_and_wave);
	//level.scr_anim["moody"]["go_go_go"]				= (%dawn_moody_run_and_wave);

// OK_ladies
	level.scrsound["moody"]["OK_ladies"]				= "moody_ev01_01a";
	level.scr_face["moody"]["OK_ladies"]				= (%f_foy_moody_ev01_01a);

// Half_way_there
	level.scrsound["moody"]["Half_way_there"]			= "Moody_ev01_01b";
	level.scr_face["moody"]["Half_way_there"]			= (%f_foy_moody_ev01_01b);

// Suppressing_fire
	level.scrsound["moody"]["Suppressing_fire"]			= "Moody_ev01_01c";
	level.scr_face["moody"]["Suppressing_fire"]			= (%f_foy_moody_ev01_01c);

// Get_to_that_shed 
	level.scrsound["moody"]["Get_to_that_shed"]			= "Moody_ev01_01d";
	level.scr_face["moody"]["Get_to_that_shed"]			= (%f_foy_Moody_ev01_01d);

// Get_the_lead 
	level.scrsound["moody"]["Get_the_lead"]				= "Moody_ev01_01e";
	level.scr_face["moody"]["Get_the_lead"]				= (%PegDay_facial_Friend1_01_incoming);

// Hold_up
	level.scrsound["moody"]["Hold_up"]				= "moody_ev01_02";
	level.scr_face["moody"]["Hold_up"]				= (%f_foy_moody_ev01_02);
 //	level.scr_anim["moody"]["Hold_up"]				= (%fullbody_foley_wave);


// assault_is_going_nowhere 
	level.scrsound["moody"]["assault_is_going_nowhere"]		= "dyke_ev01_01";
	level.scr_face["moody"]["assault_is_going_nowhere"]		= (%PegDay_facial_Friend1_01_incoming);


// On_me
	level.scrsound["moody"]["On_me"]				= "moody_ev01_03";
	level.scr_face["moody"]["On_me"]				= (%f_foy_moody_ev01_03);
 	level.scr_anim["moody"]["On_me"]				= (%c_us_foy_moody_ev01_03);

//c_us_foy_moody_ev01_03   

// look_for_position
	level.scrsound["moody"]["look_for_position"]			= "moody_ev01_04";
	level.scr_face["moody"]["look_for_position"]			= (%f_foy_moody_ev01_04);
 	level.scr_anim["moody"]["look_for_position"]			= (%c_us_foy_moody_ev01_04);

// sniper
	level.scrsound["moody"]["sniper"]				= "anderson_ev01_01";
	level.scr_face["moody"]["sniper"]				= (%PegDay_facial_Friend1_01_incoming);

// Good work riley take out 88 now
	level.scrsound["moody"]["good_work_88_now"]			= "moody_ev02_01";
	level.scr_face["moody"]["good_work_88_now"]			= (%f_foy_moody_ev02_01);

// Take out the guy on the mg42
	level.scrsound["moody"]["take_out_mg42_with_88"]		= "moody_ev02_02";
	level.scr_face["moody"]["take_out_mg42_with_88"]		= (%f_foy_moody_ev02_02);

// Disable gun incase the krauts come back
	level.scrsound["moody"]["now_destroy_88"]			= "moody_ev02_03";
	level.scr_face["moody"]["now_destroy_88"]			= (%f_foy_moody_ev02_03);

// Now were gonna clear the houses
	level.scrsound["moody"]["clear_houses"]				= "moody_ev03_01";
	level.scr_face["moody"]["clear_houses"]				= (%f_foy_moody_ev03_01);										
 	level.scr_anim["moody"]["clear_houses"]				= (%c_us_foy_moody_ev03_01);    

// take out that tank
	level.scrsound["moody"]["moody_talk_tank"]			= "moody_ev03_02a";
	level.scr_face["moody"]["moody_talk_tank"]			= (%f_foy_moody_ev03_02a);


// pushes player in houses
	level.scrsound["moody"]["moody_dont_stop"]			= "moody_dont_stop";
	level.scr_face["moody"]["moody_dont_stop"]			= (%PegDay_facial_Friend1_01_incoming);

// at mg42 inside of the houses
	level.scrsound["moody"]["moody_clear_rooms"]			= "moody_clear_rooms";
	level.scr_face["moody"]["moody_clear_rooms"]			= (%PegDay_facial_Friend1_01_incoming);


// take out that tank
	level.scrsound["moody"]["moody_door_go"]			= "moody_door_go";
	level.scr_face["moody"]["moody_door_go"]			= (%PegDay_facial_Friend1_01_incoming);





// use_grenades
	level.scrsound["moody"]["use_grenades"]				= "moody_ev03_02";
	level.scr_face["moody"]["use_grenades"]				= (%PegDay_facial_Friend1_01_incoming);

// rendezvous_at_the_church
	level.scrsound["moody"]["rendezvous_at_the_church"]		= "moody_ev03_02b";
	level.scr_face["moody"]["rendezvous_at_the_church"]		= (%f_foy_moody_ev03_02b);

// Get a satchel charge on that tank
	level.scrsound["moody"]["charge_on_tank"]                       = "moody_ev03_03";
	level.scr_face["moody"]["charge_on_tank"]			= (%f_foy_moody_ev03_03);

// Whooo 11th armor thank you very much
	level.scrsound["moody"]["11th_thank_you"]                     	= "anderson_ev04_01";
	level.scr_face["moody"]["11th_thank_you"]			=(%f_foy_anderson_ev04_01);

// lets have a look outside
	level.scrsound["moody"]["look_outside"]                 	 = "Moody_ev04_01";
	level.scr_face["moody"]["look_outside"]				=(%PegDay_facial_Friend1_01_incoming);

// Getting ready to flank and attack the church
	level.scrsound["moody"]["prep_church"]				= "Moody_ev04_02";
	level.scr_face["moody"]["prep_church"]				= (%f_foy_moody_ev04_02);

// 1 2 3 go go go 
	level.scrsound["moody"]["1_2_3_go_go_go"]			= "moody_ev05_02";
	level.scr_face["moody"]["1_2_3_go_go_go"]			= (%f_foy_moody_ev05_02);
//	level.scr_anim["foley"]["get moving"]				= (%fullbody_foley8);


// Get_up_in_the_bell_tower
	level.scrsound["moody"]["Get_up_in_the_bell_tower"]		= "Moody_ev07_01";
	level.scr_face["moody"]["Get_up_in_the_bell_tower"]		= (%f_foy_moody_ev07_01);

// Ok_follow_me
	level.scrsound["moody"]["Ok_follow_me"]				= "moody_ev09_02";
	level.scr_face["moody"]["Ok_follow_me"]				= (%f_foy_moody_ev09_02);

// barn
	level.scrsound["moody"]["barn"]					= "moody_ev09_01";
	level.scr_face["moody"]["barn"]					= (%PegDay_facial_Friend1_01_incoming);


// Plant explosives
	level.scrsound["moody"]["plant_explosives"]			= "moody_ev02_01";
	level.scr_face["moody"]["plant_explosives"]			= (%PegDay_facial_Friend1_01_incoming);

// Plant explosives
	level.scrsound["moody"]["moody_gotit"]				= "moody_gotit";
	level.scr_face["moody"]["moody_gotit"]				= (%f_foy_moody_gotit);

// Fire in the hole
	level.scrsound["moody"]["fire_in_the_hole"]			= "fire_in_the_hole";
	level.scr_face["moody"]["fire_in_the_hole"]			= (%PegDay_facial_Friend1_01_incoming);

//regroup
	level.scrsound["moody"]["moody_ev09_02"]			= "moody_ev09_02";
	level.scr_face["moody"]["moody_ev09_02"]			= (%PegDay_facial_Friend1_01_incoming);


// regrouping stuff
//regroup
	level.scrsound["moody"]["moody_regroup"]			= "moody_regroup";
	level.scr_face["moody"]["moody_regroup"]			= (%PegDay_facial_Friend1_01_incoming);


	level.scrsound["moody"]["moody_nosir"]				= "moody_nosir";
	level.scr_face["moody"]["moody_nosir"]				= (%f_foy_moody_nosir);
}

foley()
{
//whistle blowing anim
	level.scr_face["foley"]["whistle_blow"]				= (%PegDay_facial_Friend1_01_incoming);
 	level.scr_anim["foley"]["whistle_blow"]				= (%c_us_foy_blow_wistle);

	level.scr_face["foley"]["whistle_watch"]			= (%PegDay_facial_Friend1_01_incoming);
 	level.scr_anim["foley"]["whistle_watch"]			= (%c_us_foy_idle2watch);

	level.scr_face["foley"]["whistle_watch_loop"]			= (%PegDay_facial_Friend1_01_incoming);
 	level.scr_anim["foley"]["whistle_watch_loop"]			= (%c_us_foy_look_watch_loop);

// foley Section ===================== //
	// opening speech while everyone runs to the line!!
	level.scrsound["foley"]["open_speech"]				= "foley_ev00_01";
	level.scr_face["foley"]["open_speech"]				= (%f_foy_foley_ev00_01);
 	level.scr_anim["foley"]["open_speech"]				= (%c_us_foy_foley_ev00_01);      

// give em hell boys
	level.scrsound["foley"]["open_speecha"]				= "foley_ev00_01a";
	level.scr_face["foley"]["open_speecha"]				= (%f_foy_foley_ev00_01a);
 	level.scr_anim["foley"]["open_speecha"]				= (%c_us_foy_foley_ev00_01a);      

// 11th_armor_is_moving
	level.scrsound["foley_ai"]["11th_armor_is_moving"]		= "Foley_ev05_01";
	level.scr_face["foley_ai"]["11th_armor_is_moving"]		= (%f_foy_foley_ev05_01);

// riley_get_down_here
	level.scrsound["foley_ai"]["riley_get_down_here"]		= "foley_ev07_01";
	level.scr_face["foley_ai"]["riley_get_down_here"]		= (%f_foy_foley_ev07_01);
 	level.scr_anim["foley_ai"]["riley_get_down_here"]		= (%c_us_foy_foley_ev07_01);  
 

// hell_of_a_job
	level.scrsound["foley_ai"]["foley_stay_with"]			= "foley_stay_with";
	level.scr_face["foley_ai"]["foley_stay_with"]			= (%f_foy_foley_stay_with);

// hell_of_a_job
	level.scrsound["foley_ai"]["foley_take_cover"]			= "foley_take_cover";
	level.scr_face["foley_ai"]["foley_take_cover"]			= (%f_foy_foley_take_cover);

// dammit_take_charge
	level.scrsound["foley_ai"]["dammit_take_charge"]		= "foley_ev08_01";
	level.scr_face["foley_ai"]["dammit_take_charge"]		= (%f_foy_foley_ev08_01);
 	level.scr_anim["foley_ai"]["dammit_take_charge"]			= (%c_us_foy_foley_ev08_01 );    

// hell_of_a_job
	level.scrsound["foley_ai"]["hell_of_a_job"]			= "foley_ev09_01";
	level.scr_face["foley_ai"]["hell_of_a_job"]			= (%f_foy_foley_ev09_01);
 	level.scr_anim["foley_ai"]["hell_of_a_job"]			= (%c_us_foy_foley_ev09_01);    
										 
}

others()
{

// trooper1_nosir
//	level.scrsound["Anderson"]["trooper1_nosir"]				= "trooper1_nosir";
//	level.scr_face["Anderson"]["trooper1_nosir"]				= (%PegDay_facial_Friend1_01_incoming);
//
//// trooper1_nosir
//	level.scrsound["Anderson"]["Trooper2_nosir"]				= "Trooper2_nosir";
//	level.scr_face["Anderson"]["Trooper2_nosir"]				= (%PegDay_facial_Friend1_01_incoming);
// trooper1_nosir
	level.scrsound["Anderson"]["trooper3_nosir"]				= "trooper3_nosir";
//	level.scr_face["Anderson"]["trooper3_nosir"]				= (%PegDay_facial_Friend1_01_incoming);

	level.scrsound["Anderson"]["trooper1_nosir"]				= "trooper1_nosir";                    
	level.scr_face["Anderson"]["trooper1_nosir"]				= (%f_foy_trooper1_nosir);// trooper1_nosir
//	level.scrsound["Anderson"]["trooper4_nosir"]				= "trooper4_nosir";
//	level.scr_face["Anderson"]["trooper4_nosir"]				= (%PegDay_facial_Friend1_01_incoming);

// spotter anim
	level.scr_anim["spotter"]["spot_anim"][0] = %c_ge_foy_spotter;

// sniper
	level.scrsound["Anderson"]["sniper"]				= "anderson_ev01_01";
	level.scr_face["Anderson"]["sniper"]				= (%PegDay_facial_Friend1_01_incoming);

// this place is on fire!!!
	level.scrsound["Anderson"]["Anderson_joint_on_fire"]		= "Anderson_joint_on_fire";
	level.scr_face["Anderson"]["Anderson_joint_on_fire"]		= (%f_foy_anderson_joint_on_fire);

// table and lamp
// Fire in the hole
 	level.scr_anim["guy_table"]["knock_over"]			= (%c_gr_foy_kick_table);
//	level.scrsound["guy_table"]["knock_over"]			= "table_crash";

	level.scrsound["Whitney"]["whitney_top_floor"]			= "whitney_top_floor";
	level.scr_face["Whitney"]["whitney_top_floor"]			= (%f_foy_whitney_top_floor);

	// no sir
	level.scrsound["Whitney"]["trooper5_nosir"]			= "trooper5_nosir";
	level.scr_face["Whitney"]["trooper5_nosir"]			= (%PegDay_facial_Friend1_01_incoming);


// test

	// no sir
	level.scrsound["moody"]["trooper1_nosir"]			= "trooper1_nosir";
	level.scr_face["moody"]["trooper1_nosir"]			= (%f_foy_trooper1_nosir);

	// no sir
	level.scrsound["moody"]["trooper2_nosir"]			= "trooper2_nosir";
	level.scr_face["moody"]["trooper2_nosir"]			= (%f_foy_trooper2_nosir);

	// no sir
	level.scrsound["moody"]["trooper3_nosir"]			= "trooper3_nosir";
//	level.scr_face["moody"]["trooper3_nosir"]			= (%f_foy_trooper3_nosir);

	// no sir
	level.scrsound["moody"]["trooper4_nosir"]			= "trooper4_nosir";
	level.scr_face["moody"]["trooper4_nosir"]			= (%f_foy_trooper4_nosir);
	// no sir
	level.scrsound["moody"]["trooper5_nosir"]			= "trooper5_nosir";
	level.scr_face["moody"]["trooper5_nosir"]			= (%f_foy_trooper5_nosir);


// assault_is_going_nowhere 
	level.scrsound["poor_bastard"]["assault_is_going_nowhere"]	= "dyke_ev01_01";
	level.scr_face["poor_bastard"]["assault_is_going_nowhere"]	= (%f_foy_dyke_ev01_01);
 	level.scr_anim["poor_bastard"]["assault_is_going_nowhere"]	= (%c_us_foy_dyke_ev01_01);

}

#using_animtree("foy_dummies");
allied_drones()
{
	level.scr_sound ["exaggerated flesh impact"] 			= "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    	level._effect["ground"]						= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"]					= loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0] 				= "ground";
	level.scr_dyingguy["effect"][1] 				= "flesh small";
	level.scr_dyingguy["sound"][0] 					= level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] 					= "bip01 l thigh";         																							
	level.scr_dyingguy["tag"][1] 					= "bip01 head";            																							
	level.scr_dyingguy["tag"][2] 					= "bip01 l calf";          																							
	level.scr_dyingguy["tag"][3] 					= "bip01 pelvis";          																							
	level.scr_dyingguy["tag"][4] 					= "tag_breastpocket_right";																							
	level.scr_dyingguy["tag"][5] 					= "bip01 l clavicle";      																							
	
	level.scr_character["allied_drone"][0] 				= character\Airborne1a_thompson_snow ::main;
	level.scr_character["allied_drone"][1] 				= character\Airborne1b_garand_snow ::main;
	level.scr_character["allied_drone"][2] 				= character\Airborne1c_bar_snow ::main;

	level.scr_anim["allied_drone"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["allied_drone"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["allied_drone"]["move_forward"][2]			= (%crouchrun_loop_forward_1);

	level.scr_anim["allied_drone"]["death"][0]				= (%death_run_forward_crumple);
	level.scr_anim["allied_drone"]["death"][1]				= (%crouchrun_death_drop);
	level.scr_anim["allied_drone"]["death"][2]				= (%crouchrun_death_crumple);
	level.scr_anim["allied_drone"]["death"][3]				= (%death_run_onfront);
	level.scr_anim["allied_drone"]["death"][4]				= (%death_run_onleft);
	// Explosion Deaths
	level.scr_anim["allied_drone"]["exp_death"][0]				= (%death_explosion_back13);
	level.scr_anim["allied_drone"]["exp_death"][1]				= (%death_explosion_forward13);     
	level.scr_anim["allied_drone"]["exp_death"][2]				= (%death_explosion_left11);  
	level.scr_anim["allied_drone"]["exp_death"][3]				= (%death_explosion_right13);        
	level.scr_anim["allied_drone"]["exp_death"][4]				= (%death_explosion_up10);
}

#using_animtree("foy_dummies");
axis_drones()
{
	level.scr_character["axis_drone"][0] 				= character\German_wehrmact_snow ::main;

	level.scr_anim["axis_drone"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["axis_drone"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["axis_drone"]["move_forward"][2]			= (%crouchrun_loop_forward_1);

	level.scr_anim["axis_drone"]["death"][0]				= (%death_run_forward_crumple);
	level.scr_anim["axis_drone"]["death"][1]				= (%crouchrun_death_drop);
	level.scr_anim["axis_drone"]["death"][2]				= (%crouchrun_death_crumple);
	level.scr_anim["axis_drone"]["death"][3]				= (%death_run_onfront);
	level.scr_anim["axis_drone"]["death"][4]				= (%death_run_onleft);
	// Explosion Deaths
	level.scr_anim["axis_drone"]["exp_death"][0]				= (%death_explosion_back13);
	level.scr_anim["axis_drone"]["exp_death"][1]				= (%death_explosion_forward13);     
	level.scr_anim["axis_drone"]["exp_death"][2]				= (%death_explosion_left11);  
	level.scr_anim["axis_drone"]["exp_death"][3]				= (%death_explosion_right13);        
	level.scr_anim["axis_drone"]["exp_death"][4]				= (%death_explosion_up10);
}

#using_animtree("foy_table_lamp_anim");
lamp_table_anim()
{	
	
	level.scr_animtree["table_kick"]					= #animtree;
	level.scr_anim["table_kick"]["table_anim"]				= (%foy_table_kicked);
//	level.scrsound["table_kick"]["table_anim"]				= "table_crash";
}
