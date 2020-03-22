#using_animtree("generic_human");
main()
{
	// Flag guy anims
	level.scr_anim["flagwaver"]["run"]		= (%flagwaver_interiorrun);
	level.scr_anim["flagwaver"]["wave"]		= (%stalingrad_flagwaver_idle);
	
	// Facial Anims
	level.scr_anim["face"][0]			= (%Berlin_facial_RusSoldier4_001_weneed);
	level.scr_anim["face"][1]			= (%Berlin_facial_RusSoldier3_002alt_blowthisgunup);
	level.scr_anim["face"][2]			= (%Berlin_facial_RusSoldier1_006_getthatflak);
	level.scr_anim["face"][3]			= (%Berlin_facial_RusSoldier4_002_hangon);
	level.scr_anim["face"][4]			= (%Berlin_facial_RusSoldier2_003_holdthis);
	level.scr_anim["face"][5]			= (%Berlin_facial_RusSoldier1_004_comeoncomrades);
	level.scr_anim["face"][6]			= (%Berlin_facial_RusSoldier2_004alt_forward);
	level.scr_anim["face"][7]			= (%Berlin_facial_RusSoldier3_003_downwithfascism);
	level.scr_anim["face"][8]			= (%Carride_facial_Moody_050);
	level.scr_anim["face"][9]			= (%Carride_facial_Moody_050);
	level.scr_anim["face"][10]			= (%Berlin_facial_RusSoldier1_005_comeoncomrades);
	level.scr_anim["face"][11]			= (%Berlin_facial_RusSoldier1_003alt_keepmoving);
	level.scr_anim["face"][12]			= (%Carride_facial_Moody_050);
	
	// Body Anims
	level.scr_anim["body"]["waitfortanks"]		= (%Berlin_russian2_03_waitfortanks);
	//level.scr_anim["body"]["holdtheline"]		= (%Berlin_russian4_01_holdtheline);
	//level.scr_anim["body"]["comeonletsgo"]		= (%Berlin_russian1_04_comeonletsgo);
	//level.scr_anim["body"]["berlinisours"]		= (%Berlin_russian1_06_berlinisours);
	//level.scr_anim["body"]["uptorooftop"]		= (%Berlin_russian1_05_uptorooftop);
	//level.scr_anim["body"]["flagtoroof"]		= (%Berlin_russian2_05_flagtoroof);
}