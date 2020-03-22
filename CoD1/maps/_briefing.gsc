/*
MISSION BRIEFING
*/

main()
{
	precacheShader("black");
	precacheString (&"SCRIPT_FIRE_TO_SKIP");
}

// Does the initial startup for a mission briefing
// iFadeTime Is the length of time it will take to transition between images. Defaults to 500 (milliseconds) Set to 0 for instant change
start(fFadeTime)
{
	level.briefing_running = true;
	level.briefing_ending = false;
	level.PlaceNextImage = "A";
	
	if (isdefined (level.imageA))
		level.imageA destroy();
	if (isdefined (level.imageB))
		level.imageB destroy();
	if (isdefined (level.blackscreen))
		level.blackscreen destroy();
	if (isdefined (level.FiretoSkip))
		level.FiretoSkip destroy();
	
	if( !isDefined(fFadeTime) || !fFadeTime )
	{
		level.briefing_fadeInTime = 0.5;
		level.briefing_fadeOutTime = 0.5;
	}
	else
	{
		level.briefing_fadeInTime = fFadeTime;
		level.briefing_fadeOutTime = fFadeTime;
	}

	self endon("briefingskip");
	self thread skipCheck();

	// Make the screen black
	level.blackscreen = newHudElem();
	level.blackscreen.sort = -1;
	level.blackscreen.alignX = "left";
	level.blackscreen.alignY = "top";
	level.blackscreen.x = 0;
	level.blackscreen.y = 0;
	level.blackscreen.alpha = 1;
	level.blackscreen setShader("black", 640, 480);

	// Fire to skip text
	level.FiretoSkip = newHudElem();
	level.FiretoSkip.sort = 1;
	level.FiretoSkip.alignX = "center";
	level.FiretoSkip.alignY = "bottom";
	level.FiretoSkip.fontScale = 2;
	level.FiretoSkip.x = 320;
	level.FiretoSkip.y = 470;
	level.FiretoSkip settext (&"SCRIPT_FIRE_TO_SKIP");
	
	//Image A
	level.imageA = newHudElem();
	level.imageA.alignX = "left";
	level.imageA.alignY = "top";
	level.imageA.x = 0;
	level.imageA.y = 0;
	level.imageA.alpha = 0;
	level.imageA setShader("black", 640, 480);
	
	//Image B
	level.imageB = newHudElem();
	level.imageB.alignX = "left";
	level.imageB.alignY = "top";
	level.imageB.x = 0;
	level.imageB.y = 0;
	level.imageB.alpha = 0;
	level.imageB setShader("black", 640, 480);
	
	self freezeControls(true);
}

// waits till the briefing is done
waitTillBriefingDone()
{
	self waittill("briefingend");
}

// This ends the briefing if the player says he wants to
skipCheck()
{
	self endon("briefingend");

	player = getent("player", "classname" );

	for(;;)
	{
		if(player attackButtonPressed())
		{
			self notify("briefingskip");			
			end();
			return;
		}
		wait(0.05);
	}
}

image(sImageShader)
{
	self endon("briefingskip");
	
	if (level.PlaceNextImage == "A")
	{
		level.PlaceNextImage = "B";
		level.imageA setShader(sImageShader, 640, 480);
		thread imageFadeOut("B");
		level.imageA fadeOverTime(level.briefing_fadeInTime);
		level.imageA.alpha = 1;
	}
	else if (level.PlaceNextImage == "B")
	{
		level.PlaceNextImage = "A";
		level.imageB setShader(sImageShader, 640, 480);
		thread imageFadeOut("A");
		level.imageB fadeOverTime(level.briefing_fadeInTime);
		level.imageB.alpha = 1;
	}
}

imageFadeOut(elem)
{
	if (elem == "A")
	{
		level.imageA fadeOverTime(level.briefing_fadeOutTime);
		level.imageA.alpha = 0;
	}
	else if (elem == "B")
	{
		level.imageB fadeOverTime(level.briefing_fadeOutTime);
		level.imageB.alpha = 0;
	}
}

endThread()
{
	// Check for the briefing already being ended
	if(!level.briefing_running)
		return;
	if(level.briefing_ending)
		return;
		
	self notify("briefingend");
	level.briefing_ending = true;
	
	// Make sure the briefing audio is ended
	self playsound("stop_voice");

	// Fade the screen in
	thread imageFadeOut("A");
	thread imageFadeOut("B");
	
	wait(1.5);
	self freezeControls(false);

	level.briefing_ending = false;
}

end()
{
	self thread endThread();
}
