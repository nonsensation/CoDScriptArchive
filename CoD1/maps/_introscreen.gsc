main()
{
	//EXAMPLE
	//introscreen("Place, Country", "Date", "24hourclocktime");
	//EXAMPLE

	if(level.script == "training")
	{
		precacheString(&"INTROSCREEN_TRAINING_PLACE");
		precacheString(&"INTROSCREEN_TRAINING_DATE");
		precacheString(&"INTROSCREEN_TRAINING_TIME");
		introscreen(&"INTROSCREEN_TRAINING_PLACE", &"INTROSCREEN_TRAINING_DATE", &"INTROSCREEN_TRAINING_TIME");
		return;
	}

	if(level.script == "pathfinder")
	{
		precacheString(&"INTROSCREEN_PATHFINDER_PLACE");
		precacheString(&"INTROSCREEN_PATHFINDER_DATE");
		precacheString(&"INTROSCREEN_PATHFINDER_TIME");
		introscreen(&"INTROSCREEN_PATHFINDER_PLACE", &"INTROSCREEN_PATHFINDER_DATE", &"INTROSCREEN_PATHFINDER_TIME");
		return;
	}

	if((level.script == "burnville") || (level.script == "burnville_nolight"))
	{
		precacheString(&"INTROSCREEN_BURNVILLE_PLACE");
		precacheString(&"INTROSCREEN_BURNVILLE_DATE");
		precacheString(&"INTROSCREEN_BURNVILLE_TIME");
		introscreen(&"INTROSCREEN_BURNVILLE_PLACE", &"INTROSCREEN_BURNVILLE_DATE", &"INTROSCREEN_BURNVILLE_TIME");
		return;
	}

	if((level.script == "dawnville") || (level.script == "dawnville_nolight"))
	{
		precacheString(&"INTROSCREEN_DAWNVILLE_PLACE");
		precacheString(&"INTROSCREEN_DAWNVILLE_DATE");
		precacheString(&"INTROSCREEN_DAWNVILLE_TIME");
		introscreen(&"INTROSCREEN_DAWNVILLE_PLACE", &"INTROSCREEN_DAWNVILLE_DATE", &"INTROSCREEN_DAWNVILLE_TIME");
		return;
	}

	if(level.script == "carride")
	{
		precacheString(&"INTROSCREEN_CARRIDE_PLACE");
		precacheString(&"INTROSCREEN_CARRIDE_DATE");
		precacheString(&"INTROSCREEN_CARRIDE_TIME");
		introscreen(&"INTROSCREEN_CARRIDE_PLACE", &"INTROSCREEN_CARRIDE_DATE", &"INTROSCREEN_CARRIDE_TIME");
		return;
	}

	if(level.script == "brecourt")
	{
		precacheString(&"INTROSCREEN_BRECOURT_PLACE");
		precacheString(&"INTROSCREEN_BRECOURT_DATE");
		precacheString(&"INTROSCREEN_BRECOURT_TIME");
		introscreen(&"INTROSCREEN_BRECOURT_PLACE", &"INTROSCREEN_BRECOURT_DATE", &"INTROSCREEN_BRECOURT_TIME");
		return;
	}

	if(level.script == "chateau")
	{
		precacheString(&"INTROSCREEN_CHATEAU_PLACE");
		precacheString(&"INTROSCREEN_CHATEAU_DATE");
		precacheString(&"INTROSCREEN_CHATEAU_TIME");
		introscreen(&"INTROSCREEN_CHATEAU_PLACE", &"INTROSCREEN_CHATEAU_DATE", &"INTROSCREEN_CHATEAU_TIME");
		return;
	}

	if(level.script == "powcamp")
	{
		precacheString(&"INTROSCREEN_POWCAMP_PLACE");
		precacheString(&"INTROSCREEN_POWCAMP_DATE");
		precacheString(&"INTROSCREEN_POWCAMP_TIME");
		introscreen(&"INTROSCREEN_POWCAMP_PLACE", &"INTROSCREEN_POWCAMP_DATE", &"INTROSCREEN_POWCAMP_TIME");
		return;
	}

	if(level.script == "pegasusnight")
	{
		precacheString(&"INTROSCREEN_PEGASUSNIGHT_PLACE");
		precacheString(&"INTROSCREEN_PEGASUSNIGHT_DATE");
		precacheString(&"INTROSCREEN_PEGASUSNIGHT_TIME");
		introscreen(&"INTROSCREEN_PEGASUSNIGHT_PLACE", &"INTROSCREEN_PEGASUSNIGHT_DATE", &"INTROSCREEN_PEGASUSNIGHT_TIME");
		return;
	}

	if(level.script == "pegasusday")
	{
		precacheString(&"INTROSCREEN_PEGASUSDAY_PLACE");
		precacheString(&"INTROSCREEN_PEGASUSDAY_DATE");
		precacheString(&"INTROSCREEN_PEGASUSDAY_TIME");
		introscreen(&"INTROSCREEN_PEGASUSDAY_PLACE", &"INTROSCREEN_PEGASUSDAY_DATE", &"INTROSCREEN_PEGASUSDAY_TIME");
		return;
	}

	if(level.script == "dam")
	{
		precacheString(&"INTROSCREEN_DAM_PLACE");
		precacheString(&"INTROSCREEN_DAM_DATE");
		precacheString(&"INTROSCREEN_DAM_TIME");
		introscreen(&"INTROSCREEN_DAM_PLACE", &"INTROSCREEN_DAM_DATE", &"INTROSCREEN_DAM_TIME");
		return;
	}

	if(level.script == "ship")
	{
		precacheString(&"INTROSCREEN_SHIP_PLACE");
		precacheString(&"INTROSCREEN_SHIP_DATE");
		precacheString(&"INTROSCREEN_SHIP_TIME");
		introscreen(&"INTROSCREEN_SHIP_PLACE", &"INTROSCREEN_SHIP_DATE", &"INTROSCREEN_SHIP_TIME");
		return;
	}

	if((level.script == "stalingrad") || (level.script == "stalingrad_nolight"))
	{
		precacheString(&"INTROSCREEN_STALINGRAD_PLACE");
		precacheString(&"INTROSCREEN_STALINGRAD_DATE");
		precacheString(&"INTROSCREEN_STALINGRAD_TIME");
		introscreen(&"INTROSCREEN_STALINGRAD_PLACE", &"INTROSCREEN_STALINGRAD_DATE", &"INTROSCREEN_STALINGRAD_TIME");
		return;
	}
	
	if(level.script == "redsquare")
	{
		precacheString(&"INTROSCREEN_REDSQUARE_PLACE");
		precacheString(&"INTROSCREEN_REDSQUARE_DATE");
		precacheString(&"INTROSCREEN_REDSQUARE_TIME");
		introscreen(&"INTROSCREEN_REDSQUARE_PLACE", &"INTROSCREEN_REDSQUARE_DATE", &"INTROSCREEN_REDSQUARE_TIME");
		return;
	}

	if(level.script == "sewer")
	{
		precacheString(&"INTROSCREEN_SEWER_PLACE");
		precacheString(&"INTROSCREEN_SEWER_DATE");
		precacheString(&"INTROSCREEN_SEWER_TIME");
		introscreen(&"INTROSCREEN_SEWER_PLACE", &"INTROSCREEN_SEWER_DATE", &"INTROSCREEN_SEWER_TIME");
		return;
	}

	if(level.script == "factory")
	{
		precacheString(&"INTROSCREEN_FACTORY_PLACE");
		precacheString(&"INTROSCREEN_FACTORY_DATE");
		precacheString(&"INTROSCREEN_FACTORY_TIME");
		introscreen(&"INTROSCREEN_FACTORY_PLACE", &"INTROSCREEN_FACTORY_DATE", &"INTROSCREEN_FACTORY_TIME");
		return;
	}

	if(level.script == "tankdrivecountry")
	{
		precacheString(&"INTROSCREEN_TANKDRIVECOUNTRY_PLACE");
		precacheString(&"INTROSCREEN_TANKDRIVECOUNTRY_DATE");
		precacheString(&"INTROSCREEN_TANKDRIVECOUNTRY_TIME");
		introscreen(&"INTROSCREEN_TANKDRIVECOUNTRY_PLACE", &"INTROSCREEN_TANKDRIVECOUNTRY_DATE", &"INTROSCREEN_TANKDRIVECOUNTRY_TIME");
		return;
	}

	if(level.script == "hurtgen")
	{
		precacheString(&"INTROSCREEN_HURTGEN_PLACE");
		precacheString(&"INTROSCREEN_HURTGEN_DATE");
		precacheString(&"INTROSCREEN_HURTGEN_TIME");
		introscreen(&"INTROSCREEN_HURTGEN_PLACE", &"INTROSCREEN_HURTGEN_DATE", &"INTROSCREEN_HURTGEN_TIME");
		return;
	}

	if(level.script == "rocket")
	{
		precacheString(&"INTROSCREEN_ROCKET_PLACE");
		precacheString(&"INTROSCREEN_ROCKET_DATE");
		precacheString(&"INTROSCREEN_ROCKET_TIME");
		introscreen(&"INTROSCREEN_ROCKET_PLACE", &"INTROSCREEN_ROCKET_DATE", &"INTROSCREEN_ROCKET_TIME");
		return;
	}

	if(level.script == "berlin")
	{
		precacheString(&"INTROSCREEN_BERLIN_PLACE");
		precacheString(&"INTROSCREEN_BERLIN_DATE");
		precacheString(&"INTROSCREEN_BERLIN_TIME");
		introscreen(&"INTROSCREEN_BERLIN_PLACE", &"INTROSCREEN_BERLIN_DATE", &"INTROSCREEN_BERLIN_TIME");
		return;
	}

	// Shouldn't do a notify without a wait statement before 
	// it, or bad things can happen when loading a save game.
	wait 0.05; 
	
	level notify ("finished intro screen"); // Do final notify when player controls have been restored
}

introscreen(string1, string2, string3)
{
	level.introblack = newHudElem();
	level.introblack.x = 0;
	level.introblack.y = 0;
	level.introblack setShader("black", 640, 480);

	if(!(level.script == "redsquare"))
		level.player freezeControls(true);

	wait 0.1;

	level.introstring1 = newHudElem();
	level.introstring1.x = 320;
	level.introstring1.y = 260;
	level.introstring1.alignX = "center";
	level.introstring1.alignY = "middle";
	level.introstring1.sort = 1; // force to draw after the background
	level.introstring1.fontScale = 1.75;
	level.introstring1 setText(string1);
	level.introstring1.alpha = 0;
	level.introstring1 fadeOverTime(1.2); 
	level.introstring1.alpha = 1;

	level.introstring2 = newHudElem();
	level.introstring2.x = 320;
	level.introstring2.y = 290;
	level.introstring2.alignX = "center";
	level.introstring2.alignY = "middle";
	level.introstring2.sort = 1; // force to draw after the background
	level.introstring2.fontScale = 1.75;
	level.introstring2 setText(string2);
	level.introstring2.alpha = 0;
	level.introstring2 fadeOverTime(1.2); 
	level.introstring2.alpha = 1;

	level.introstring3 = newHudElem();
	level.introstring3.x = 320;
	level.introstring3.y = 320;
	level.introstring3.alignX = "center";
	level.introstring3.alignY = "middle";
	level.introstring3.sort = 1; // force to draw after the background
	level.introstring3.fontScale = 1.75;
	level.introstring3 setText(string3);
	level.introstring3.alpha = 0;
	level.introstring3 fadeOverTime(1.2); 
	level.introstring3.alpha = 1;

	wait 1.2;
	
	if(level.script == "stalingrad")
		wait (2.0);

	level notify ("finished final intro screen fadein");

	wait 1;
	// Fade out black
	level.introblack fadeOverTime(1.5); 
	level.introblack.alpha = 0;

	level notify ("starting final intro screen fadeout");

	// Restore player controls part way through the fade in
	wait 0.5;
	level.player freezeControls(false);
	level notify ("finished intro screen"); // Do final notify when player controls have been restored

	// Fade out text
	level.introstring1 fadeOverTime(1.5); 
	level.introstring1.alpha = 0;
	level.introstring2 fadeOverTime(1.5); 
	level.introstring2.alpha = 0;
	level.introstring3 fadeOverTime(1.5); 
	level.introstring3.alpha = 0;

	wait 1.5;
	level.introblack destroy();
	level.introstring1 destroy();
	level.introstring2 destroy();
	level.introstring3 destroy();
}
