#using_animtree("generic_human");
main()
{
	//level.scr_anim["tankguy"]["prep"]	= (%tigertank_gettingin_pose_guy);
	level.scr_anim["tankguy"]["getin"]	= (%tigertank_gettingin_guy);
	
	level.scr_anim["tankguy2"]["idle"]	= (%tigertank_jumpoff_wait);
	level.scr_anim["tankguy2"]["jumpoff"]	= (%tigertank_jumpoff_jump);
	
	//face anims
	level.scr_anim["face"][0]		= (%Railyard_facial_RusPriv1_3alt2_artillery);
	level.scr_anim["face"][1]		= (%Railyard_facial_RusPriv2_004_itsours);
	level.scr_anim["face"][2]		= (%Railyard_facial_RusPriv1_04alt_wouldtheystop);
	level.scr_anim["face"][3]		= (%Railyard_facial_RusPriv2_5alt_hardtosay);
	level.scr_anim["face"][4]		= (%Railyard_facial_RusArmyCapt_001_stillalive);
	level.scr_anim["face"][5]		= (%Railyard_facial_RusArmyCapt_002_wemustgetout);
}

#using_animtree("panzerIV");
tank_load_anims()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["prep"]		= (%tigertank_gettingin_pose_hatch);
	level.scr_anim["tank"]["closehatch"]	= (%tigertank_gettingin_hatch);
}

tank_hatch()
{
	level.tank UseAnimTree(#animtree);
	level.tank setanim(level.scr_anim["tank"]["prep"]);
	level waittill ("close hatch");
	level.tank setanimknob(level.scr_anim["tank"]["closehatch"]);
}