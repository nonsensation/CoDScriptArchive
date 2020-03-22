#using_animtree("searchlight");
searchlights()
{
	level.scr_animtree["searchlights"] = #animtree;

	level.scr_anim["searchlights"]["searchlight_search1"]		= (%searchlight_search1);
	level.scr_anim["searchlights"]["searchlight_search2"]		= (%searchlight_search2);
}


#using_animtree("switch_objective");
switch_objective()
{
	level.scr_animtree["switch_objective"] = #animtree;

	level.scr_anim["switch_objective"]["switch_objective_up"]		= (%switch_objective_up);
	level.scr_anim["switch_objective"]["switch_objective_down"]		= (%switch_objective_down);
}
