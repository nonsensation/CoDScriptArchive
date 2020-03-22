main()
{
	//EXAMPLE
	//introscreen("Place, Country", "Date", "24hourclocktime");
	//EXAMPLE

//	Use this an EXAMPLE!
//	if(level.script == "training")
//	{
//		precacheString(&"INTROSCREEN_TRAINING_PLACE");
//		precacheString(&"INTROSCREEN_TRAINING_DATE");
//		precacheString(&"INTROSCREEN_TRAINING_TIME");
//		introscreen(&"INTROSCREEN_TRAINING_PLACE", &"INTROSCREEN_TRAINING_DATE", &"INTROSCREEN_TRAINING_TIME");
//		return;
//	}

	if(level.script == "trenches")
	{
		precacheString(&"GMI_INTROSCREEN_TRENCHES_PLACE");
		precacheString(&"GMI_INTROSCREEN_TRENCHES_DATE");
		precacheString(&"GMI_INTROSCREEN_TRENCHES_TIME");
		introscreen(&"GMI_INTROSCREEN_TRENCHES_PLACE", &"GMI_INTROSCREEN_TRENCHES_DATE", &"GMI_INTROSCREEN_TRENCHES_TIME");
		return;
	}

	if(level.script == "bastogne1")
	{
		precacheString(&"GMI_INTROSCREEN_BASTOGNE1_PLACE");
		precacheString(&"GMI_INTROSCREEN_BASTOGNE1_DATE");
		precacheString(&"GMI_INTROSCREEN_BASTOGNE1_TIME");
		introscreen(&"GMI_INTROSCREEN_BASTOGNE1_PLACE", &"GMI_INTROSCREEN_BASTOGNE1_DATE", &"GMI_INTROSCREEN_BASTOGNE1_TIME");
		return;
	}

	if(level.script == "bastogne2")
	{
		precacheString(&"GMI_INTROSCREEN_BASTOGNE2_PLACE");
		precacheString(&"GMI_INTROSCREEN_BASTOGNE2_DATE");
		precacheString(&"GMI_INTROSCREEN_BASTOGNE2_TIME");
		introscreen(&"GMI_INTROSCREEN_BASTOGNE2_PLACE", &"GMI_INTROSCREEN_BASTOGNE2_DATE", &"GMI_INTROSCREEN_BASTOGNE2_TIME");
		return;
	}

	if(level.script == "foy")
	{
		precacheString(&"GMI_INTROSCREEN_FOY_PLACE");
		precacheString(&"GMI_INTROSCREEN_FOY_DATE");
		precacheString(&"GMI_INTROSCREEN_FOY_TIME");
		introscreen(&"GMI_INTROSCREEN_FOY_PLACE", &"GMI_INTROSCREEN_FOY_DATE", &"GMI_INTROSCREEN_FOY_TIME");
		return;
	}

	if(level.script == "bomber")
	{
		precachestring(&"GMI_INTROSCREEN_BOMBER_PLACE");
		precachestring(&"GMI_INTROSCREEN_BOMBER_DATE");
		precachestring(&"GMI_INTROSCREEN_BOMBER_TIME");
		introscreen(&"GMI_INTROSCREEN_BOMBER_PLACE", &"GMI_INTROSCREEN_BOMBER_DATE", &"GMI_INTROSCREEN_BOMBER_TIME");
		return;
	}

	if(level.script == "sicily1")
	{
		precachestring(&"GMI_INTROSCREEN_SICILY1_PLACE");
		precachestring(&"GMI_INTROSCREEN_SICILY1_DATE");
		precachestring(&"GMI_INTROSCREEN_SICILY1_TIME");
		introscreen(&"GMI_INTROSCREEN_SICILY1_PLACE", &"GMI_INTROSCREEN_SICILY1_DATE", &"GMI_INTROSCREEN_SICILY1_TIME");
		return;
	}

	if(level.script == "kharkov1")
	{
		precacheString(&"GMI_INTROSCREEN_KHARKOV1_PLACE");
		precacheString(&"GMI_INTROSCREEN_KHARKOV1_DATE");
		precacheString(&"GMI_INTROSCREEN_KHARKOV1_TIME");
		introscreen(&"GMI_INTROSCREEN_KHARKOV1_PLACE", &"GMI_INTROSCREEN_KHARKOV1_DATE", &"GMI_INTROSCREEN_KHARKOV1_TIME");
		return;
	}

	if(level.script == "kharkov2")
	{
		precacheString(&"GMI_INTROSCREEN_KHARKOV2_PLACE");
		precacheString(&"GMI_INTROSCREEN_KHARKOV2_DATE");
		precacheString(&"GMI_INTROSCREEN_KHARKOV2_TIME");
		introscreen(&"GMI_INTROSCREEN_KHARKOV2_PLACE", &"GMI_INTROSCREEN_KHARKOV2_DATE", &"GMI_INTROSCREEN_KHARKOV2_TIME");
		return;
	}

	if(level.script == "noville")
	{
		precacheString(&"GMI_INTROSCREEN_NOVILLE_PLACE");
		precacheString(&"GMI_INTROSCREEN_NOVILLE_DATE");
		precacheString(&"GMI_INTROSCREEN_NOVILLE_TIME");
		introscreen(&"GMI_INTROSCREEN_NOVILLE_PLACE", &"GMI_INTROSCREEN_NOVILLE_DATE", &"GMI_INTROSCREEN_NOVILLE_TIME");
		return;
	}

	if(level.script == "trainbridge")
	{
		precacheString(&"GMI_INTROSCREEN_TRAINBRIDGE_PLACE");
		precacheString(&"GMI_INTROSCREEN_TRAINBRIDGE_DATE");
		precacheString(&"GMI_INTROSCREEN_TRAINBRIDGE_TIME");
		introscreen(&"GMI_INTROSCREEN_TRAINBRIDGE_PLACE", &"GMI_INTROSCREEN_TRAINBRIDGE_DATE", &"GMI_INTROSCREEN_TRAINBRIDGE_TIME");
		return;
	}



// ===============
// PGM - PI level support
	if(level.script == "ponyri")
	{
		precacheString(&"PI_PONYRI_PLACE");
		precacheString(&"PI_PONYRI_DATE");
		precacheString(&"PI_PONYRI_TIME");
		thread maps\_introscreen_gmi::introscreen(&"PI_PONYRI_PLACE", &"PI_PONYRI_DATE", &"PI_PONYRI_TIME");
		return;
	}
	if(level.script == "kursk")
	{
		precacheString(&"PI_KURSK_PLACE");
		precacheString(&"PI_KURSK_DATE");
		precacheString(&"PI_KURSK_TIME");
		thread maps\_introscreen_gmi::introscreen(&"PI_KURSK_PLACE", &"PI_KURSK_DATE", &"PI_KURSK_TIME");
		return;
	}
// PGM
// ===============

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
