#using_animtree ("generic_human");

main()
{
	if(!isdefined(level.scr_anim))
		level.scr_anim = [];
	level.scr_anim["ingram_beach"]=						%f_sicily2_ingram_beach;
	level.scr_anim["ingram_blast"]=						%f_sicily2_ingram_blast;
	level.scr_anim["ingram_blimey"]=					%f_sicily2_ingram_blimey;
	level.scr_anim["ingram_continue_onfoot"]=				%f_sicily2_ingram_continue_onfoot;
	level.scr_anim["ingram_corral"]=					%f_sicily2_ingram_corral;
	level.scr_anim["ingram_cutoff"]=					%f_sicily2_ingram_cutoff;
	level.scr_anim["ingram_damn_jerries"]=					%f_sicily2_ingram_damn_jerries;
	level.scr_anim["ingram_day_cruise"]=					%f_sicily2_ingram_day_cruise;
	level.scr_anim["ingram_dead_end"]=					%f_sicily2_ingram_dead_end;
	level.scr_anim["ingram_detour"]=					%f_sicily2_ingram_detour;
	level.scr_anim["ingram_down_there"]=					%f_sicily2_ingram_down_there;
	level.scr_anim["ingram_enjoy"]=						%f_sicily2_ingram_enjoy;
	level.scr_anim["ingram_eye_out"]=					%f_sicily2_ingram_eye_out;
	level.scr_anim["ingram_eye_out2"]=					%f_sicily2_ingram_eye_out2;
	level.scr_anim["ingram_fire"]=						%f_sicily2_ingram_fire;
	level.scr_anim["ingram_follow"]=					%f_sicily2_ingram_follow;
	level.scr_anim["ingram_get_around"]=					%f_sicily2_ingram_get_around;
	level.scr_anim["ingram_going_through"]=					%f_sicily2_ingram_going_through;
	level.scr_anim["ingram_good_show"]=					%f_sicily2_ingram_good_show;
	level.scr_anim["ingram_got_higgs"]=					%f_sicily2_ingram_got_higgs;
	level.scr_anim["ingram_jerry_boat"]=					%f_sicily2_ingram_jerry_boat;
	level.scr_anim["ingram_leapfrog"]=					%f_sicily2_ingram_leapfrog;
	level.scr_anim["ingram_lorry_left"]=					%f_sicily2_ingram_lorry_left;
	level.scr_anim["ingram_niceshot1"]=					%f_sicily2_ingram_niceshot1;
	level.scr_anim["ingram_niceshot2"]=					%f_sicily2_ingram_niceshot2;
	level.scr_anim["ingram_niceshot3"]=					%f_sicily2_ingram_niceshot3;
	level.scr_anim["ingram_off_coast"]=					%f_sicily2_ingram_off_coast;
	level.scr_anim["ingram_on_left"]=					%f_sicily2_ingram_on_left;
	level.scr_anim["ingram_standoff"]=					%f_sicily2_ingram_standoff;
	level.scr_anim["ingram_thru_bunker"]=					%f_sicily2_ingram_thru_bunker;
	level.scr_anim["ingram_use_grenades"]=					%f_sicily2_ingram_use_grenades;

}


crashtiming(bike)
{
	wait 0;
	bike notify ("groupedanimevent","crash");
	
}