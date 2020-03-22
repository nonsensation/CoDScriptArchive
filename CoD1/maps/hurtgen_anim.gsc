#using_animtree("generic_human");
main()
{
	//* FOLEY
	
	//* Gentlemen, we've fought a whole bunch of these, so I know you know what to do.
	level.scrsound["foley"]["indulge me"]			= "hurtgen_foley_indulgeme";
	level.scr_face["foley"]["indulge me"]			= %Hurtgen_facial_Foley_103_Gentlemen;
	level.scr_anim["foley"]["indulge me"]			= %Hurtgen_foley_103_gentlemen;
	
	//* Keep moving guys, don't stop!
	level.scrsound["foley"]["keep moving"]			= "hurtgen_foley_keepmovingguys";
	level.scr_face["foley"]["keep moving"]			= %Hurtgen_facial_Foley_104_keepmoving;
	
	//* Martin, that bunker's yours.  Take any documents you find.
	level.scrsound["foley"]["that bunker"]			= "hurtgen_foley_thatbunkersyours";
	level.scr_face["foley"]["that bunker"]			= %Hurtgen_facial_Foley_105_thatbunkersyours;
	
	//* Same drill Martin.  Clear this bunker and search for documents.
	level.scrsound["foley"]["same drill"]			= "hurtgen_foley_samedrilldocs";
	level.scr_face["foley"]["same drill"]			= %Hurtgen_facial_Foley_106_samedrill;
	
	//* Martin, quick! We've got two Panzers comin' over the ridge!  Get on one of those 88's and take 'em out!
	level.scrsound["foley"]["quick panzers"]		= "hurtgen_foley_quickpanzers";
	level.scr_face["foley"]["quick panzers"]		= %Hurtgen_facial_Foley_107_martinquick;
	level.scr_anim["foley"]["quick panzers"]		= %Hurtgen_foley_107_martinquick;
	
	//* Great job on those tanks.  Private Martin, you've done yourself proud.  I can hardly believe. . .we've done it.
	level.scrsound["foley"]["great job"]			= "hurtgen_foley_proudbelieve";
	level.scr_face["foley"]["great job"]			= %Hurtgen_facial_Foley_109_greatjob;
	level.scr_anim["foley"]["great job"]			= %Hurtgen_foley_109_greatjob;
	
	//* Not there, watch out of those mines!
	level.scrsound["foley"]["watch out"]			= "hurtgen_paratrooper_mines";
	level.scr_face["foley"]["watch out"]			= %Hurtgen_facial_Para1_002alt5_watchmines;
	
	//* End Idle
	level.scr_anim["foley"]["paused"]			= %hurtgen_foley_109_greatjob_idle;

}