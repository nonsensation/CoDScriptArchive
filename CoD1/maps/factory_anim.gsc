#using_animtree("generic_human");
main()
{
	//Blow open the doors to the factory
	level.scr_anim["bomb"]["left"]["animation"]	= (%levelfactory_bombplacement_left);
	level.scr_anim["bomb"]["right"]["animation"]	= (%levelfactory_bombplacement_right);
	
	//waves to signal player to come closer to the factory doors
	level.scr_anim["private"]["overhere"]		= (%dawn_foley_waving_followme);
	level.scr_anim["private"]["thisway"]		= (%dawn_foley_waving_followme);
	
	//face anims
	level.scr_anim["face"][0]		= (%Carride_facial_Moody_048);
	level.scr_anim["face"][1]		= (%Carride_facial_Moody_048);
	level.scr_anim["face"][2]		= (%Carride_facial_Moody_048);
	level.scr_anim["face"][3]		= (%Carride_facial_Moody_048);
	level.scr_anim["face"][4]		= (%Carride_facial_Moody_048);
	
	//over here!
	level.scr_anim["face"][5]		= (%Carride_facial_Moody_048);
	
	//this way!
	level.scr_anim["face"][6]		= (%Carride_facial_Moody_048);
} 
