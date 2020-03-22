#using_animtree("stalingrad_drones");
main()
{
	level.drone_mortar[0] = loadfx ("fx/impacts/beach_mortar.efx");
	level.drone_mortar[1] = loadfx ("fx/impacts/dirthit_mortar.efx");

	level.scr_sound ["exaggerated flesh impact"] = "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    level._effect["ground"]	= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"] = loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0] = "ground";
	level.scr_dyingguy["effect"][1] = "flesh small";
	level.scr_dyingguy["sound"][0] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] = "bip01 l thigh";
	level.scr_dyingguy["tag"][1] = "bip01 head";
	level.scr_dyingguy["tag"][2] = "bip01 l calf";
	level.scr_dyingguy["tag"][3] = "bip01 pelvis";
	level.scr_dyingguy["tag"][4] = "tag_breastpocket_right";
	level.scr_dyingguy["tag"][5] = "bip01 l clavicle";
	level.scr_anim["flag drone"]["run"][0] = (%stalingrad_flagrunner_idle);
	level.scr_anim["flag drone"]["walk"][0] = (%stalingrad_flagrunner_idle);
	level.scr_anim["flag drone"]["death"][0] = (%flagrun_drone_death);
	level.scr_character["flag drone"][0]	= character\RussianArmyOfficer_flagwave ::main;
	

	level.scr_character["drone"][0] 		= character\RussianArmy ::main;
	level.scr_character["drone"][1] 		= character\RussianArmy_nohat ::main;
	level.scr_character["drone"][2] 		= character\RussianArmy_pants ::main;

	level.scr_anim["drone"]["run"][0]		= (%pistol_crouchrun_loop_forward_1);
	level.scr_anim["drone"]["run"][1]		= (%pistol_crouchrun_loop_forward_2);
	level.scr_anim["drone"]["run"][2]		= (%pistol_crouchrun_loop_forward_3);
//	level.scr_anim["drone"]["run"][3]		= (%crouchrun_loop_forward_1);
//	level.scr_anim["drone"]["run"][4]		= (%crouchrun_loop_forward_2);
//	level.scr_anim["drone"]["run"][5]		= (%crouchrun_loop_forward_3);

	level.scr_anim["drone"]["walk"][0]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][1]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][2]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][3]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][4]		= (%stalingrad_flagrunner_idle);
	level.scr_anim["drone"]["walk"][5]		= (%stalingrad_flagrunner_idle);

	level.scr_anim["drone"]["death"][0]		= (%death_run_forward_crumple);
	level.scr_anim["drone"]["death"][1]		= (%crouchrun_death_drop);
	level.scr_anim["drone"]["death"][2]		= (%crouchrun_death_crumple);
	level.scr_anim["drone"]["death"][3]		= (%death_run_onfront);
	level.scr_anim["drone"]["death"][4]		= (%death_run_onleft);
	
	level.scr_anim["drone"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["drone"]["explode death back"] = %death_explosion_back13;			// Flies back 13 feet.
	level.scr_anim["drone"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["drone"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["drone"]["explode death right"] = %death_explosion_right13;
} 
