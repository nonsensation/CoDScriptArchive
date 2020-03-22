//sicily1_anim

#using_animtree("generic_human");
main()
{
	character\ally_british_ingram::precache();   
	character\ally_british_scar::precache();   
	character\ally_british_stash::precache();   
	character\ally_british_freckles::precache();   
	character\ally_british_old::precache();   

	maps\sicily1_anim::ingram();
	maps\sicily1_anim::luyties();
	maps\sicily1_anim::hoover();
	maps\sicily1_anim::moditch();
	maps\sicily1_anim::denny();
	maps\sicily1_anim::boatdriver();

	maps\sicily1_anim::d_axis_0();
	maps\sicily1_anim::d_axis_1();
	maps\sicily1_anim::d_axis_2();
	maps\sicily1_anim::dock_house_chair();
	maps\sicily1_anim::fakedeadguy();

	maps\sicily1_anim::Falling_Debris();
	
	maps\sicily1_anim::loadtruckanim();

	//This is how the Rhino does it, and it works fine
	level.scr_anim["spawn1"]["kick_door_2"] = %chateau_kickdoor2;

	//-=From Trainbridge=-		//Replaced with custom anims!
//    	level.scr_anim["truckriders"]["jumpin"]              			= (%germantruck_guyC_climbin);
//   	level.scr_anim["truckriders"]["death"]                  		= (%death_stand_dropinplace);

	level.scr_anim["ingram"]["jumpin"]					= (%germantruck_guyC_climbin);
	level.scr_anim["hoover"]["jumpin"]					= (%germantruck_guyC_climbin);
	level.scr_anim["moditch"]["jumpin"]					= (%germantruck_guyC_climbin);
	level.scr_anim["denny"]["jumpin"]					= (%germantruck_guyC_climbin);

	level.scr_anim["ingram"]["truckidle"]					= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim["hoover"]["truckidle"]					= (%c_br_sicily1_idletruck_guy4);
	level.scr_anim["moditch"]["truckidle"]					= (%c_br_sicily1_idletruck_guy5);
	level.scr_anim["denny"]["truckidle"]					= (%c_br_sicily1_idletruck_guy6);

	level.scr_anim["ingram"]["jumpout"]					= (%germantruck_guy1_jumpout);
	level.scr_anim["hoover"]["jumpout"]					= (%germantruck_guy4_jumpout);
	level.scr_anim["moditch"]["jumpout"]					= (%germantruck_guy5_jumpout);
	level.scr_anim["denny"]["jumpout"]					= (%germantruck_guy6_jumpout);

    	level.scr_anim["truck_driver"]["idle_loop"]				= (%germantruck_driver_sitidle_loop);
	level.scr_anim["truck_driver"]["drive_loop"]				= (%germantruck_driver_drive_loop);
 	level.scr_anim["truck_driver"]["jumpin_fast"]				= (%trainbridge_truckdriver_climbin_fast);
	level.scr_anim["truck_driver"]["jumpin_slow"]				= (%trainbridge_truckdriver_climbin_slow);
	
	level.scr_anim[0]["getoutanim"] 					= %germantruck_driver_climbout;
	level.scr_anim[1]["getoutanim"]  					= %germantruck_guy1_jumpout;
	level.scr_anim[2]["getoutanim"]  					= %germantruck_guy2_jumpout;
	level.scr_anim[3]["getoutanim"]  					= %germantruck_guy3_jumpout;
	level.scr_anim[4]["getoutanim"]  					= %germantruck_guy4_jumpout;
	level.scr_anim[5]["getoutanim"]  					= %germantruck_guy5_jumpout;
	level.scr_anim[6]["getoutanim"]  					= %germantruck_guy6_jumpout;
	level.scr_anim[7]["getoutanim"]  					= %germantruck_guy7_jumpout;
	level.scr_anim[8]["getoutanim"]  					= %germantruck_guy8_jumpout;
	
	level.scr_anim[0]["exittag"]  						= "tag_driver";
	level.scr_anim[1]["exittag"]  						= "tag_guy01";
	level.scr_anim[2]["exittag"]  						= "tag_guy02";
	level.scr_anim[3]["exittag"]  						= "tag_guy03";
	level.scr_anim[4]["exittag"]  						= "tag_guy04";
	level.scr_anim[5]["exittag"]  						= "tag_guy05";
	level.scr_anim[6]["exittag"]  						= "tag_guy06";
	level.scr_anim[7]["exittag"]  						= "tag_guy07";
	level.scr_anim[8]["exittag"]  						= "tag_guy08";

	level.scr_anim[0]["delay"]  						= 0; 	//driver
	level.scr_anim[1]["delay"]  						= 0; 	//tag1
	level.scr_anim[2]["delay"]  						= .2; 	//tag2
	level.scr_anim[3]["delay"]  						= .3;	//tag3
	level.scr_anim[4]["delay"]  						= 0;	//tag4
	level.scr_anim[5]["delay"]  						= .4;	//tag5
	level.scr_anim[6]["delay"]  						= .2;	//tag6
	level.scr_anim[7]["delay"]  						= .5;	//tag7
	level.scr_anim[8]["delay"]  						= .8;	//tag8
}

ingram()
{
	level.scr_character["ingram"] 					= character\ally_british_ingram::main;
	level.scr_animtree["ingram"]					= #animtree;
	level.scr_anim["ingram"]["boatingram1"]				= (%c_br_sicily1_boatride_guy5);
	level.scr_anim["ingram"]["kick_door_2"] 			= (%chateau_kickdoor1);

	//Ingram's line inside the docks house about storming the bunker
	level.scr_face["ingram"]["ingram_bunker"]			= (%f_sicily1_ingram_bunker);
	level.scr_anim["ingram"]["ingram_bunker"]			= (%c_br_sicily1_ingram_bunker);
	level.scrsound["ingram"]["ingram_bunker"]			= "ingram_bunker";

	//Chatty biotch!
	level.scr_face["ingram"]["ingram_brief1"]			= (%f_sicily1_ingram_brief1);
	level.scrsound["ingram"]["ingram_brief1"]			= "ingram_brief1";

	level.scr_face["ingram"]["ingram_brief2"]			= (%f_sicily1_ingram_brief2);
	level.scrsound["ingram"]["ingram_brief2"]			= "ingram_brief2";

//	level.scr_face["ingram"]["ingram_brief3"]			= (%f_sicily1_ingram_brief3);  
	level.scrsound["ingram"]["ingram_brief3"]			= "ingram_brief3";

	level.scr_face["ingram"]["ingram_low_cover"]			= (%f_sicily1_ingram_low_cover);
	level.scrsound["ingram"]["ingram_low_cover"]			= "ingram_low_cover";

	level.scr_face["ingram"]["ingram_sticky_wicket"]		= (%f_sicily1_ingram_sticky_wicket);	//33
	level.scrsound["ingram"]["ingram_sticky_wicket"]		= "ingram_sticky_wicket";		//33

	level.scr_face["ingram"]["ingram_lighthouse"]			= (%f_sicily1_ingram_lighthouse);
	level.scrsound["ingram"]["ingram_lighthouse"]			= "ingram_lighthouse";

	level.scr_face["ingram"]["ingram_hornets2"]			= (%f_sicily1_ingram_hornets);
	level.scr_anim["ingram"]["ingram_hornets"]			= (%c_br_sicily1_ingram_hornets);
//	level.scrsound["ingram"]["ingram_hornets2"]			= "ingram_hornets";

	level.scr_face["ingram"]["ingram_staylow"]			= (%f_sicily1_ingram_staylow);
	level.scrsound["ingram"]["ingram_staylow"]			= "ingram_staylow";

	level.scr_face["ingram"]["ingram_goodmen"]			= (%f_sicily1_ingram_goodmen);
	level.scrsound["ingram"]["ingram_goodmen"]			= "ingram_goodmen";

	level.scr_face["ingram"]["ingram_comms"]			= (%f_sicily1_ingram_comms);   
	level.scrsound["ingram"]["ingram_comms"]			= "ingram_comms";

	level.scr_face["ingram"]["ingram_docks1"]			= (%f_sicily1_ingram_docks1);  
	level.scrsound["ingram"]["ingram_docks1"]			= "ingram_docks1";

	level.scr_face["ingram"]["ingram_docks2"]			= (%f_sicily1_ingram_docks2);  
	level.scrsound["ingram"]["ingram_docks2"]			= "ingram_docks2";

	level.scr_face["ingram"]["ingram_fort"]				= (%f_sicily1_ingram_fort);    
	level.scr_anim["ingram"]["ingram_fort"]				= (%c_br_sicily1_ingram_fort);
	level.scrsound["ingram"]["ingram_fort"]				= "ingram_fort";

	level.scr_face["ingram"]["ingram_hoover"]			= (%f_sicily1_ingram_hoover);  
	level.scrsound["ingram"]["ingram_hoover"]			= "ingram_hoover";

//	level.scr_face["ingram"]["ingram_kill"]				= (%f_sicily1_ingram_kill);    
	level.scrsound["ingram"]["ingram_kill"]				= "ingram_kill";

	level.scr_face["ingram"]["ingram_kubel"]			= (%f_sicily1_ingram_kubel);
	level.scr_anim["ingram"]["ingram_kubel"]			= (%c_br_sicily1_ingram_kubel); 
	level.scrsound["ingram"]["ingram_kubel"]			= "ingram_kubel";

	level.scr_face["ingram"]["ingram_lorry"]			= (%f_sicily1_ingram_lorry);   
	level.scrsound["ingram"]["ingram_lorry"]			= "ingram_lorry";

//	level.scr_face["ingram"]["ingram_motorpool1"]			= (%f_sicily1_ingram_motorpool1);
	level.scrsound["ingram"]["ingram_motorpool1"]			= "ingram_motorpool1";

//	level.scr_face["ingram"]["ingram_motorpool2"]			= (%f_sicily1_ingram_motorpool2);
	level.scrsound["ingram"]["ingram_motorpool2"]			= "ingram_motorpool2";

	level.scr_face["ingram"]["ingram_off_boat"]			= (%f_sicily1_ingram_off_boat);
	level.scrsound["ingram"]["ingram_off_boat"]			= "ingram_off_boat";

//	level.scr_face["ingram"]["ingram_radios"]			= (%f_sicily1_ingram_radios);  
	level.scrsound["ingram"]["ingram_radios"]			= "ingram_radios";

	level.scr_face["ingram"]["ingram_sabotage"]			= (%f_sicily1_ingram_sabotage);
	level.scrsound["ingram"]["ingram_sabotage"]			= "ingram_sabotage";

//	level.scr_face["ingram"]["ingram_sentry"]			= (%f_sicily1_ingram_sentry);
//	level.scrsound["ingram"]["ingram_sentry"]			= "ingram_sentry";

	level.scr_face["ingram"]["ingram_surprise"]			= (%f_sicily1_ingram_surprise);
	level.scrsound["ingram"]["ingram_surprise"]			= "ingram_surprise";

//	level.scr_face["ingram"]["ingram_towers"]			= (%f_sicily1_ingram_towers);  
	level.scrsound["ingram"]["ingram_towers"]			= "ingram_towers";

	level.scr_face["ingram"]["ingram_uphill"]			= (%f_sicily1_ingram_uphill);  
	level.scrsound["ingram"]["ingram_uphill"]			= "ingram_uphill";

	level.scr_face["ingram"]["ingram_wall"]				= (%f_sicily1_ingram_wall);    
	level.scrsound["ingram"]["ingram_wall"]				= "ingram_wall";
                                                                                                      
	level.scr_face["ingram"]["ingram_commentary"]			= (%f_sicily1_ingram_commentary);	//26
	level.scrsound["ingram"]["ingram_commentary"]			= "ingram_commentary";			//26
}

luyties()
{
	level.scr_character["luyties"] 					= character\ally_british_scar::main;
	level.scr_animtree["luyties"]					= #animtree;
	level.scr_anim["luyties"]["boatguy2"]				= (%c_br_sicily1_boatride_guy2);

	level.scr_face["luyties"]["luyties_sorry"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scr_face["luyties"]["luyties_lorry_stalled"]		= (%PegDay_facial_Friend1_01_incoming);

	level.scrsound["luyties"]["luyties_sorry"]			= "luyties_sorry";
	level.scrsound["luyties"]["luyties_lorry_stalled"]		= "luyties_lorry_stalled";
}

hoover()
{
	level.scr_character["hoover"] 					= character\ally_british_stash::main;
	level.scr_animtree["hoover"]					= #animtree;
	level.scr_anim["hoover"]["boatguy3"]				= (%c_br_sicily1_boatride_guy3);

	level.scr_anim["hoover"]["kill_guard"]				= (%c_br_sicily1_kill_harbor_guard);
	level.scr_anim["hoover"]["window"]				= (%c_br_sicily1_hoover_window);
}

moditch()
{
	level.scr_character["moditch"] 					= character\ally_british_old::main;
	level.scr_animtree["moditch"]					= #animtree;
	level.scr_anim["moditch"]["boatguy1"]				= (%c_br_sicily1_boatride_guy1);

	level.scr_face["moditch"]["moditch_good"]			= (%f_sicily1_moditch_good);
	level.scr_anim["modtich"]["moditch_good"]			= (%c_br_sicily1_moditch_good);
	level.scrsound["moditch"]["moditch_good"]			= "moditch_good";

	level.scr_face["moditch"]["moditch_behindyou"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scr_face["moditch"]["moditch_search"]			= (%PegDay_facial_Friend1_01_incoming);

	level.scr_face["moditch"]["moditch_fire_hole"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scr_face["moditch"]["moditch_oh_man"]			= (%PegDay_facial_Friend1_01_incoming);

	level.scrsound["moditch"]["moditch_behindyou"]			= "moditch_behindyou";
	level.scrsound["moditch"]["moditch_search"]			= "moditch_search";
	level.scrsound["moditch"]["moditch_fire_hole"]			= "moditch_fire_hole";
	level.scrsound["moditch"]["moditch_oh_man"]			= "moditch_oh_man";
}

denny()
{
	level.scr_character["denny"] 					= character\ally_british_freckles::main;
	level.scr_animtree["denny"]					= #animtree;
	level.scr_anim["denny"]["boatguy4"]				= (%c_br_sicily1_boatride_guy4);

	level.scr_face["denny"]["denny_lookout"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scr_face["denny"]["denny_fire_hole"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scr_face["denny"]["denny_outta_here"]			= (%PegDay_facial_Friend1_01_incoming);

	level.scrsound["denny"]["denny_lookout"]			= "denny_lookout";
	level.scrsound["denny"]["denny_fire_hole"]			= "denny_fire_hole";
	level.scrsound["denny"]["denny_outta_here"]			= "denny_outta_here";
}

//Dock House Guards
d_axis_0()
{
	level.scr_anim["d_axis_0"]["guard_loop"]				= (%c_ge_sicily1_harbor_guard_loop);
	level.scr_face["d_axis_0"]["guard_loop"]				= (%PegDay_facial_Friend1_01_incoming);

	level.scr_anim["d_axis_0"]["guard_death"]				= (%c_ge_sicily1_harbor_guard_death);
	level.scr_face["d_axis_0"]["guard_death"]				= (%PegDay_facial_Friend1_01_incoming);

	level.scr_anim["d_axis_0"]["guard_dead"]				= (%c_ge_sicily1_harbor_guard_dead);
	level.scr_face["d_axis_0"]["guard_dead"]				= (%PegDay_facial_Friend1_01_incoming);
}


d_axis_1()
{
	level.scr_character["d_axis_1"]						= character\german_tropical_mg42::main;
	level.scr_animtree["d_axis_1"]						= #animtree;

	level.scr_anim["d_axis_1"]["seated_idle"]				= (%c_ge_sicily1_dockhouse_seated_idle);
	level.scr_anim["d_axis_1"]["seated_to_standing"]			= (%c_ge_sicily1_dockhouse_seated2standup);
	level.scr_anim["d_axis_1"]["seated_death"]				= (%c_ge_sicily1_dockhouse_seated_death);
	level.scr_anim["d_axis_1"]["seated_dead"]				= (%c_ge_sicily1_dockhouse_seated_dead);
}

d_axis_2()
{
	level.scr_character["d_axis_2"]						= character\german_tropical_mg42::main;
	level.scr_animtree["d_axis_2"]						= #animtree;

	level.scr_anim["d_axis_2"]["laying_idle"]				= (%c_ge_sicily1_dockhouse_laying_idle);
	level.scr_anim["d_axis_2"]["laying_death"]				= (%c_ge_sicily1_dockhouse_laying_death);
	level.scr_anim["d_axis_2"]["laying_to_standing"]			= (%c_ge_sicily1_dockhouse_laying2standup);
	level.scr_anim["d_axis_2"]["laying_dead"]				= (%c_ge_sicily1_dockhouse_laying_dead);
}

#using_animtree("sicily1_fakedeadguy");
fakedeadguy()
{
	level.scr_character["fakedeadguy"]					= character\german_tropical_mg42::main;
	level.scr_animtree["fakedeadguy"]					= #animtree;

	level.scr_anim["fakedeadguy"]["seated_dead"]				= (%c_ge_sicily1_dockhouse_seated_dead);
	level.scr_anim["fakedeadguy"]["laying_dead"]				= (%c_ge_sicily1_dockhouse_laying_dead);
}

#using_animtree("dock_house_chair");
dock_house_chair()
{
	level.scr_animtree["dock_house_chair"]					= #animtree;
	level.scr_anim["dock_house_chair"]["chair_fall"]			= (%sicily1_dockhouse_chair);
}

//This guy's not an AI
#using_animtree("sicily1_anim");
boatdriver()
{	
	level.scr_character["boatdriver"]				= character\ally_british_old::main;
	level.scr_animtree["boatdriver"]				= #animtree;
	level.scr_anim["boatdriver"]["boatdriver1"]			= (%c_br_sicily1_boatride_guy6);
	level.scr_anim["boatdriver"]["boatdriverend"]			= (%c_br_sicily1_boatride_guy6_end);
}

#using_animtree("sicily1_debris");
Falling_Debris()
{
	level.scr_animtree["sicily1_debris"]				= (#animtree);
	level.scr_anim["sicily1_lighthouse_explosion"]["reactor"]	= (%sicily1_lighthouse_explosion);
}

#using_animtree("germantruck");
loadtruckanim()
{
	level.scr_anim["germantruck"]["truckflip"]			= (%trainbridge_truck_flip);
	level.scr_anim["germantruck"]["closedoor_startpose"]		= (%germantruck_truck_closedoor_startpose);
	level.scr_anim["germantruck"]["closedoor_fast"]			= (%trainbridge_truck_climbin_fast);
	level.scr_anim["germantruck"]["closedoor_slow"]			= (%trainbridge_truck_climbin_slow);
}

