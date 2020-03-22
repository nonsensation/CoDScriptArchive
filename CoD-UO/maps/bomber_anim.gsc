//Bomber Anim Tree TS 01/19/04

#using_animtree("generic_human");
main()
{
//saved this list of sounds for later implementation into the fighter_attacks calls
//	// 3-1
//"bogies_at_3";
//	// 3-2
//"me_3";
//	// 6-1
//"fighters_on_6";
//	// 6-2
//"more_bandits_6";
//	// 9-1
//"bandits_9";
//	// 9-2
//"more_bandits_9";
//	// 12-1
//"mess_12";
//	// 12-2
//"crimey";
//	//pilot anims

	character\ally_britishairborne_bomber_tailgunner::precache();   
	character\ally_britishairborne_bomber_waistgunner::precache();
	character\ally_britishairborne_bomber_waistgunner2::precache();
	character\ally_britishairborne_bomber_radio::precache();

	maps\bomber_anim::tailgunner();
	maps\bomber_anim::lwg_turret();
	maps\bomber_anim::rwg_turret();
	maps\bomber_anim::lwgunner();
	maps\bomber_anim::rwgunner();
	maps\bomber_anim::wirelessop();
	maps\bomber_anim::copilot();
	maps\bomber_anim::pilot();
	maps\bomber_anim::end_game();
}

#using_animtree("bomber_guns");
lwg_turret()
{
	level.scr_animtree["lwg_turret"]				= #animtree;
	level.scr_anim["lwg_turret"]["lwg_fireA"]			= (%bomber_50cal_waistgunner_firingA);
	level.scr_anim["lwg_turret"]["lwg_fireB"]			= (%bomber_50cal_waistgunner_firingB);
	level.scr_anim["lwg_turret"]["lwg_idle"]			= (%bomber_50cal_waistgunner_idleleft);
	level.scr_anim["lwg_turret"]["lwg_idleB"]			= (%bomber_50cal_waistgunner_lookleft);
}

rwg_turret()
{
	level.scr_animtree["rwg_turret"]				= #animtree;
	level.scr_anim["rwg_turret"]["rwg_fireA"]			= (%bomber_50cal_waistgunner_firingA);
	level.scr_anim["rwg_turret"]["rwg_fireB"]			= (%bomber_50cal_waistgunner_firingB);
	level.scr_anim["rwg_turret"]["rwg_idle"]			= (%bomber_50cal_waistgunner_idleright);
	level.scr_anim["rwg_turret"]["rwg_idleB"]			= (%bomber_50cal_waistgunner_stretchright);
	level.scr_anim["rwg_turret"]["rwg_flak1"]			= (%bomber_50cal_waistgunner_flak1right);
	level.scr_anim["rwg_turret"]["rwg_flak2"]			= (%bomber_50cal_waistgunner_flak2right);
	level.scr_anim["rwg_turret"]["rwg_motion"]			= (%bomber_50cal_waistgunner_motioningright);
}

#using_animtree("bomber_gunners");
tailgunner()
{
	level.scr_character["tail"] 					= character\ally_britishairborne_bomber_tailgunner::main;
	level.scr_animtree["tail"]					= #animtree;
	level.scr_anim["tail"]["tgunner_idle"]				= (%c_br_bomber_tailgunner_idle);
	level.scr_anim["tail"]["tgunner_idleB"]				= (%c_br_bomber_tailgunner_strech);
	level.scr_anim["tail"]["tgunner_dead"]				= (%c_br_bomber_tailgunner_dead);
	level.scr_anim["tail"]["tgunner_flying"]			= (%c_br_bomber_tailgunner_flying);
}

lwgunner()
{
	level.scr_character["lwaist"] 					= character\ally_britishairborne_bomber_waistgunner::main;
	level.scr_animtree["lwaist"]					= #animtree;
	level.scr_anim["lwaist"]["lwgunner_idle"]			= (%c_br_bomber_leftgunner_idle);
	level.scr_anim["lwaist"]["lwgunner_idleB"]			= (%c_br_bomber_leftgunner_look);
	level.scr_anim["lwaist"]["lwgunner_fireA"]			= (%c_br_bomber_waistgunner_firingA);
	level.scr_anim["lwaist"]["lwgunner_fireB"]			= (%c_br_bomber_waistgunner_firingB);
	level.scr_anim["lwaist"]["lwgunner_death"]			= (%c_br_bomber_rightgunner_death);	//dom wanted this
	level.scr_anim["lwaist"]["lwgunner_motion"]			= (%c_br_bomber_leftgunner_motioning);
	level.scr_anim["lwaist"]["lwgunner_flak1_in"]			= (%c_br_bomber_leftgunner_flak1_in);
	level.scr_anim["lwaist"]["lwgunner_flak1_loop"]			= (%c_br_bomber_leftgunner_flak1_loop);
	level.scr_anim["lwaist"]["lwgunner_flak1_out"]			= (%c_br_bomber_leftgunner_flak1_out);
	level.scr_anim["lwaist"]["lwgunner_dead"]			= (%c_br_bomber_rightgunner_dead);	//falls to scripting to clean it up, hehe
}

rwgunner()
{
	level.scr_character["rwaist"] 					= character\ally_britishairborne_bomber_waistgunner2::main;
	level.scr_animtree["rwaist"]					= #animtree;
	level.scr_anim["rwaist"]["rwgunner_idle"]			= (%c_br_bomber_rightgunner_idle);
	level.scr_anim["rwaist"]["rwgunner_idleB"]			= (%c_br_bomber_rightgunner_stretch);
	level.scr_anim["rwaist"]["rwgunner_fireA"]			= (%c_br_bomber_waistgunner_firingA);
	level.scr_anim["rwaist"]["rwgunner_fireB"]			= (%c_br_bomber_waistgunner_firingB);
//	level.scr_anim["rwaist"]["rwgunner_death"]			= (%c_br_bomber_leftgunner_death);	//dom asked for flip
//	level.scr_anim["rwaist"]["rwgunner_motion"]			= (%c_br_bomber_rightgunner_motioning);
	level.scr_anim["rwaist"]["rwgunner_flak1"]			= (%c_br_bomber_rightgunner_flak1);
	level.scr_anim["rwaist"]["rwgunner_flak2"]			= (%c_br_bomber_rightgunner_flak2);
//	level.scr_anim["rwaist"]["rwgunner_dead"]			= (%c_br_bomber_rightgunner_dead);
}

#using_animtree("bomber_anim");
wirelessop()
{
	level.scr_character["wire"]					= character\ally_britishairborne_bomber_radio::main;
	level.scr_animtree["wire"]					= #animtree;
	level.scr_anim["wire"]["wirelessop_idleA"]			= (%c_br_bomber_radio_idle);
	level.scr_anim["wire"]["wirelessop_idleB"]			= (%c_br_bomber_radio_listen);
	level.scr_anim["wire"]["wirelessop_wounded"]			= (%c_br_bomber_radio_wounded);
	level.scr_anim["wire"]["wirelessop_death"]			= (%c_br_bomber_radio_death);
	level.scr_anim["wire"]["wirelessop_dead"]			= (%c_br_bomber_radio_dead);
	level.scr_anim["wire"]["wirelessop_motion0"]			= (%c_br_bomber_radio_motioning0);
	level.scr_anim["wire"]["wirelessop_motion1"]			= (%c_br_bomber_radio_motioning1);
	level.scr_anim["wire"]["wirelessop_motion_trans"]		= (%c_br_bomber_radio_motioning_transition);
	level.scr_anim["wire"]["wirelessop_motion2"]			= (%c_br_bomber_radio_motioning2);
}

copilot()
{
	level.scr_character["copilot"]					= character\ally_britishairborne_bomber_copilot::main;
	level.scr_animtree["copilot"]					= #animtree;
	level.scr_anim["copilot"]["copilot_idleA"]			= (%c_br_bomber_copilot_idleA);
	level.scr_anim["copilot"]["copilot_lookleft"]			= (%c_br_bomber_copilot_lookleft);
	level.scr_anim["copilot"]["copilot_b01_06"]			= (%c_br_bomber_copilot_eventB1);
}

pilot()
{
	level.scr_character["pilot"]					= character\ally_britishairborne_bomber_pilot::main;
	level.scr_animtree["pilot"]					= #animtree;
	level.scr_anim["pilot"]["pilot_idleA"]				= (%c_br_bomber_pilot_idleA);
	level.scr_anim["pilot"]["pilot_talk_in"]			= (%c_br_bomber_pilot_talk_in);
	level.scr_anim["pilot"]["pilot_talk_loop"]			= (%c_br_bomber_pilot_talk_loop);
	level.scr_anim["pilot"]["pilot_talk_out"]			= (%c_br_bomber_pilot_talk_out);
	level.scr_anim["pilot"]["pilot_looklr"]				= (%c_br_bomber_pilot_looklright);
	level.scr_anim["pilot"]["pilot_b01_06"]				= (%c_br_bomber_pilot_eventB1);
}

#using_animtree("bomber_end_camera");
end_game()
{
	level.scr_animtree["bomber_end_camera"]					= #animtree;
	level.scr_anim["bomber_end_camera"]["plane_eject"]			= (%bomber_end_camera);
	level.scr_anim["parachute"]["parachute_deploy"]				= (%bomber_parachute_deploys);
	level.scr_anim["parachute"]["parachute_deployed"]			= (%bomber_parachute_deployed);
}