// This autosave system differs from the primary autosave system in that 
// the minimum level of health is set through the trigger. 
// This is primarily designed for the tanks in Kursk.

getnames(num)
{
	if (level.script == "kursk")
	{
		savedescription = &"AUTOSAVE_KURSK";
		if (num == 1)
			savedescription = &"PI_AUTOSAVE_KURSK1";
		if (num == 2)
			savedescription = &"PI_AUTOSAVE_KURSK2";
		if (num == 3)
			savedescription = &"PI_AUTOSAVE_KURSK3";
		if (num == 4)
			savedescription = &"PI_AUTOSAVE_KURSK4";
		if (num == 5)
			savedescription = &"PI_AUTOSAVE_KURSK5";
		if (num == 6)
			savedescription = &"PI_AUTOSAVE_KURSK6";

		return savedescription;
	}


	if (num == 0)
		savedescription = &"AUTOSAVE_GAME";
	else
		savedescription = &"AUTOSAVE_NOGAME";
	return savedescription;
}


autosaves_think(trigger)
{
	if ((isdefined (trigger.targetname)) && (trigger.targetname == "dead_autosave"))
		return;

	num = 1;

	// SUPER KLUDGE - Cast our string to an int...
	if (trigger.target == "1") {
		num = 1;
	} else if (trigger.target == "2") {
		num = 2;
	} else if (trigger.target == "3") {
		num = 3;
	} else if (trigger.target == "4") {
		num = 4;
	} else if (trigger.target == "5") {
		num = 5;
	} else if (trigger.target == "6") {
		num = 6;
	}

	savedescription = getnames(num);

	if ( !(isdefined (savedescription) ) )
	{
		println ("autosave", self.target," with no save description in _autosave.gsc!");
		return;
	}

	trigger waittill ("trigger");
	
	imagename = "levelshots/autosave/autosave_" + level.script + num;
	println ("z:         imagename: ", imagename);

	// The par health is held in the script_noteworthy parameter
	par_health = 0.4;

	switch (num) {
		case 1:	par_health = 0.9; break;
		case 2:	par_health = 0.7; break;
		case 3:	par_health = 0.5; break;
		case 4:	par_health = 0.4; break;
		case 5:	par_health = 0.35; break;
		case 6:	par_health = 0.3; break;
	}

	trigger healthchecksave(num, savedescription, imagename, par_health);
//	trigger delete();
}

dead_autosave(trigger)
{
	trigger waittill ("trigger");

	if (isdefined (trigger.target))
	{
		include = getentarray (trigger.target,"targetname");
		maps\_utility_gmi::living_ai_wait (trigger,"axis", include);
	}
	else
		maps\_utility_gmi::living_ai_wait (trigger,"axis");

	wait (1);

	if (isdefined (trigger.script_autosave))
		savedescription = getnames(trigger.script_autosave);
	else
	{
		savedescription = &"AUTOSAVE_AUTOSAVE";
		trigger.script_autosave = 1;
	}


	num = trigger.script_autosave;

	imagename = "levelshots/autosave/autosave_" + level.script + num;
	println ("z:         imagename: ", imagename);

	healthchecksave(num, savedescription, imagename);
	//println ("Saving game ", num," with desc ", savedescription);

	trigger delete();
}

healthchecksave(num, savedescription, imagename, par_health)
{

	healthfraction = (float)level.playertank.health / (float)level.playertank.maxhealth;

	if(healthfraction > par_health)
	{
		saveGame(num, savedescription, imagename);
		println ("Saving game ", num," with desc ", savedescription);
	}
	else
	{
		println ("NOT Saving game, health below healthfraction (",healthfraction,")");
	}	
	
	println ("^6--- SAVE ---  health: ", healthfraction);
	println ("^6--- SAVE ---  par:    ", par_health);
	
}
