#using_animtree("generic_human");
main()
{
	level.scr_animtree["gun guy"] = #animtree;
	level.scr_animtree["grenade guy"] = #animtree;

	// Shooting into the tank
	level._effect["pistol"] = loadfx ("fx/muzzleflashes/standardflashworld.efx");

	level.scr_anim["gun guy"]["run"]			= (%tigertank_runup_gunguy);
	level.scr_anim["gun guy"]["idle"][0]		= (%tigertank_waitloop_gunguy);
	level.scr_anim["grenade guy"]["run"]		= (%tigertank_runup_grenadeguy);

	level.scr_anim["gun guy"]["attack"]			= (%tigertank_hatchopencloseandrun_gunguy);
	level.scr_anim["grenade guy"]["attack"]		= (%tigertank_hatchopencloseandrun_grenadeguy);
	level.scr_notetrack["gun guy"][0]["notetrack"]	= "fire";
	level.scr_notetrack["gun guy"][0]["effect"]		= "pistol";
	level.scr_notetrack["gun guy"][0]["sound"]		= "weap_thompson_fire";
	level.scr_notetrack["gun guy"][0]["selftag"]	= "tag_flash";

	level.scr_notetrack["grenade guy"][0]["notetrack"]		= "grenade attach";
	level.scr_notetrack["grenade guy"][0]["attach model"]	= "xmodel/weapon_MK2FragGrenade";
	level.scr_notetrack["grenade guy"][0]["selftag"]	= "tag_weapon_right";
	
	precacheModel("xmodel/weapon_mk2fraggrenade");  //head for script dieing models
	level.scr_notetrack["grenade guy"][1]["notetrack"]		= "grenade throw";
	level.scr_notetrack["grenade guy"][1]["detach model"]	= "xmodel/weapon_mk2fraggrenade";
	level.scr_notetrack["grenade guy"][1]["selftag"]	= "tag_weapon_right";
	
	level.scr_anim["ender"]["landing 1"]		= (%airborne_landing_firm);
	level.scr_anim["ender"]["landing 2"]		= (%airborne_landing_credits);
	level.scr_anim["ender"]["idle"]		= (%tigertank_waitloop_gunguy);
	
	tank();
	parachute();
}

#using_animtree("panzerIV");
tank()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["attack"]			= (%tigertank_hatchopencloseandrun_hatch);
	level.scr_anim["tank"]["root"] = %root;
	// Dawnville_tank_hatch

	level.scr_notetrack["tank"][0]["notetrack"]	= "\"sound\"";
	level.scr_notetrack["tank"][0]["sound"]		= "dawnville_tank_hatch";
}


#using_animtree("animation_rig_parachute");
parachute()
{
	level.scr_animtree["parachute"] = #animtree;
	level.scr_anim["parachute"]["landing 1"]		= (%parachute_landing_firm);
	level.scr_anim["parachute"]["landing 2"]		= (%parachute_landing_credits);
	level.scr_anim["parachute"]["idle"][0]			= (%hanginggear_tree_idle);

	level.scr_anim["parachute"]["jump"]				= (%parachute_jumpA);
	level.scr_anim["parachute"]["jump idle"][0]		= (%parachute_idleA);
	level.scr_anim["parachute"]["hit"]				= (%parachute_hitA);

	level.scr_anim["parachute"]["landing 3"]		= (%player_landing_roll);
}