#using_animtree("generic_human");
main()
{	
	//Wounded Guy Animations
		level.scr_anim["wounded"]["idle"] 		= (%brecourt_woundedman_idle);
		level.scr_anim["wounded"]["pickup"]		= (%brecourt_man_moodypickupwoundedman);
		level.scr_anim["wounded"]["walkback"]		= (%brecourt_man_moodypluswoundedman_walk);
		level.scr_anim["wounded"]["putdown"]		= (%brecourt_man_moodyputsdownwoundedman);
		level.scr_anim["wounded"]["death"]		= (%brecourt_man_moodywoundedmandeath);
		level.scr_anim["wounded"]["deathidle"]		= (%brecourt_man_moodywoundedmandeath_idle);
	
	//Moody With Wounded Guy Animations
		level.scr_anim["moody"]["kickdoor"]		= (%chateau_kickdoor1);
		level.scr_anim["moody"]["getout"]		= (%step_up_low_wall);
		level.scr_anim["moody"]["pickup"]		= (%brecourt_moody_moodypickupwoundedman);
		level.scr_anim["moody"]["walkback"]		= (%brecourt_moody_moodypluswoundedman_walk);
		level.scr_anim["moody"]["putdown"]		= (%brecourt_moody_moodyputsdownwoundedman);
		level.scr_anim["moody"]["death"]		= (%brecourt_moody_moodywoundedmandeath);
		level.scr_anim["moody"]["death2"]		= (%brecourt_moody_moodywoundedmandeath);
		level.scr_anim["moody"]["deathidle"]		= (%brecourt_moody_moodywoundedmandeath_idle);
		level.scr_anim["moody"]["deathidle2"]		= (%brecourt_moody_moodywoundedmandeath_idle);
	
	//Moody Plants Explosives on a Flak88
		level.scr_anim["bomb"]["flak"]["animation"]	= (%brecourt_flak_foleyplantsbomb);
	
	//Medic Animations
		level.scr_anim["medic"]["idle1"]		= (%brecourt_medic_scaredhide);
		level.scr_anim["medic"]["idle2"]		= (%brecourt_medic_listening_idle);
		level.scr_anim["medic"]["death"]		= (%brecourt_medic_shotinthehead_dead);
}

dialogue_body_anims()
{
	//MOODY	
		level.scr_anim["body"]["thirdsquad"]		= (%brecourt_moody_067_69);
		level.scr_anim["body"]["wegottwo"]		= (%brecourt_moody_070_wegottwo);
		level.scr_anim["body"]["downtrench"]		= (%brecourt_moody_071b_downtrench);
		level.scr_anim["body"]["aintdone"]		= (%brecourt_moody_073_aintdone);
		level.scr_anim["body"]["getpapers"]		= (%brecourt_moody_getpapers);
		level.scr_anim["body"]["takeexplosives"]	= (%brecourt_moody_080_takeexplosives);
	
	//MEDIC
		level.scr_anim["body"]["sorrysarge"]		= (%brecourt_medic_001_sargesorry);
		level.scr_anim["body"]["rules"]			= (%brecourt_medic_002_theyareshooting);


}

dialogue_facial_anims()
{
	//MOODY
		//First opening
			level.scr_anim["face"]["thirdsquad"]	= (%brecourt_facial_moody_067_thirdsquad);
			level.scr_anim["face"]["onmytail"]	= (%brecourt_facial_moody_068_onmytail);
			level.scr_anim["face"]["letsgo"]	= (%brecourt_facial_moody_069_letsgo);
		
		//secong opening
			level.scr_anim["face"]["wegottwo"]	= (%brecourt_facial_moody_070_twomg);
		
		//blow up first flak88
			level.scr_anim["face"]["goboom"]	= (%brecourt_facial_moody_071_goboom);
			level.scr_anim["face"]["downtrench"]	= (%brecourt_facial_moody_071b_downtrench);
		
		//blow up second flak88
			level.scr_anim["face"]["headsup"]	= (%brecourt_facial_moody_072_headsup);
			level.scr_anim["face"]["aintdone"]	= (%brecourt_facial_moody_073_aintdone);
		
		//get the papers
			level.scr_anim["face"]["getpapers"]	= (%brecourt_facial_moody_074_documents);
			level.scr_anim["face"]["getout"]	= (%brecourt_facial_moody_075_getout);
			
		//medic sequence
			level.scr_anim["face"]["medic"]		= (%brecourt_facial_moody_076_medic);
			level.scr_anim["face"]["move"]		= (%brecourt_facial_moody_077alt_move);
			level.scr_anim["face"]["coverfire"]	= (%brecourt_facial_moody_079_coveringfire);
		
		//moody makes it back, tells you to take explosives
			level.scr_anim["face"]["takeexplosives"]= (%brecourt_facial_moody_080_takeexplosives);
	
	//Elder
		level.scr_anim["face"]["sargedown"]		= (%brecourt_facial_Elder_018_thesargeisdown);
	
	//Medic
		level.scr_anim["face"]["sorry"]			= (%brecourt_facial_medic_001_sargesorry);
		level.scr_anim["face"]["rules"]			= (%brecourt_facial_medic_002_theyareshooting);
	
	//Lieutenant
		level.scr_anim["face"]["movein"]		= (%brecourt_facial_Lieutenant_001_2ndplatoon);
		level.scr_anim["face"]["grabdocs"]		= (%brecourt_facial_Lieutenant_002_private);
		level.scr_anim["face"]["headsup"]		= (%brecourt_facial_Lieutenant_003alt3_headsup);
		level.scr_anim["face"]["outtahere"]		= (%brecourt_facial_Lieutenant_004_theirlastgun);
}

popHelmet()
{
	if ( isDefined ( self.hatModel ) )
	{
		partName = GetPartName ( self.hatModel, 0 );        
		helmetModel = spawn ("script_model", self.origin + (0,0,48) );
		helmetModel setmodel ( self.hatModel  );
		helmetModel.origin = self GetTagOrigin ( partName );
		helmetModel.angles = self GetTagAngles ( partName );
		helmetModel thread helmetMove ( (-3672, 3856, 16), self.hatModel );
		
		thread maps\_utility::playSoundinSpace("bullet_small_metal", helmetModel.origin);
		
//		if (isdefined(self.helmetSideModel))
//		{
//			helmetSideModel = spawn ("script_model", self . origin + (0,0,64) );
//			helmetSideModel setmodel ( self.helmetSideModel  );
//			helmetSideModel . origin = self GetTagOrigin ( "TAG_HELMETSIDE" );
//			helmetSideModel . angles = self GetTagAngles ( "TAG_HELMETSIDE" );
//			helmetSideModel thread helmetMove ( (-3672, 3856, 16) );
//		}

		wait 0.05;
		if (isdefined(self.helmetSideModel))
		{
			self detach(self.helmetSideModel, "TAG_HELMETSIDE");
			self.helmetSideModel = undefined;
		}
		self detach ( self.hatModel , "");
		self.hatModel = undefined;
	}
}

helmetMove(org,model)
{
	temp_vec = vectornormalize (self.origin - org);
	temp_vec = maps\_utility::vectorScale (temp_vec, 200);

	x = temp_vec[0];
	y = temp_vec[1];
	z = 50;
	
	if (x > 0)
		self rotateroll(9000 * -1, 5,0,0);
	else
		self rotateroll(9000, 5,0,0);
	
	self moveGravity ((x, y, z), 1);
	
	wait (0.46);
	
	pos = self.origin;
	ang = self.angles;
	
	groundModel = spawn ("script_model", pos);
	groundModel setmodel (model);
	groundModel.origin = (pos - (0,0,5));
	groundModel.angles = ang;
	
	self delete();
}