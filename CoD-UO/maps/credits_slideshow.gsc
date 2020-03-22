// You MUST notify "level notify("start slideshow")" in order for the slides to start!
// Additionally, you MUST set level.slideshow_playing to FALSE in order to stop the slideshow!
main()
{
	level thread slideshow();
}

slideshow()
{
	//Level control variables
	level.credits_playing = true;		// Variable that controls the length of the slideshow
	icon_x_size = 375;			// Size of each of the icons
	icon_y_size = 375;			// Add a buffer of 16 units between each slide
	start_x = 10;				// Start position
	start_y = 55;				// Rich built a buffer into the slides
	totalnumslides = 40;			// How many total slides we have
	slides_shown = 0;			// How many slides have been shown so far

	//We USED to have 3 positions the slides swapped between...now there's only 1 (2 with alternate fade in)
	//So all of the start_y's are the same...it used to be start_y += icon_y_size * n

	level.slide_array = [];
	level.slide_shown = [];

	//Create array of slides
	for(n=0;n<totalnumslides;n++)
	{
		if(n<10)
		{
			level.slide_array[n] = "gfx/hud/credits/slide" + "0" + n + ".dds";
		}
		else
		{
			level.slide_array[n] = "gfx/hud/credits/slide" + n + ".dds";
		}

		println(level.slide_array[n]);

		//Create the "shown" flag
		level.slide_shown[n] = false;

		//Precache the slide images
		precacheShader(level.slide_array[n]);
	}

	//Create the slide positions
	for(n=0;n<2;n++)
	{
		level.slide_pos[n] = newHudElem();
		level.slide_pos[n].alignX = "left";
		level.slide_pos[n].alignY = "top";
		level.slide_pos[n].fontscale = "1";
		level.slide_pos[n].x = start_x;
		level.slide_pos[n].y = start_y;
		level.slide_pos[n].alpha = 0;
		level.slide_pos[n].angle = 0;
	}

	level waittill("start slideshow");

	//***********************************
	//*** Main body of the slide loop ***
	//***********************************
	while(level.credits_playing == true)	//Switch this off when the credits are over
	{
		//Setting new slide position
		new_position = randomint(2);

		//If the new position is the same as the old one, get the other one
		while(isdefined(old_position) && old_position == new_position)
		{
			new_position = randomint(2);
			wait 0.05;
		}

		//Pick a slide and see if it's been used before
		slidenum = randomint(totalnumslides);
		while( level.slide_shown[slidenum] == true )
		{
			slidenum = randomint(totalnumslides);
		}

		slides_shown++;
		if(slides_shown > ( 0.75 * totalnumslides ) )	//When 3/4 of the slides have been shown reset the flags
		{
			for(n=0;n<totalnumslides;n++)
			{
				level.slide_shown[n] = false;
			}
			slides_shown = 0;
		}

		// Setting new_slide to an element of slide_array
		new_slide = level.slide_array[ slidenum ];

		//Mark this slide as being shown
		level.slide_shown[ slidenum ] = true;

		//Set the slide's shader
		level.slide_pos[new_position] setShader( new_slide, icon_x_size, icon_y_size );

		level.slide_pos[new_position] thread fade_slide();

		println(level.slide_pos[new_position]);
		println(new_slide);
		
		level waittill("fading slide");

		old_slide = new_slide;
		old_position = new_position;
	}
}

fade_slide()
{
	self.alpha = 0;

	fade_increment = 0;

	for(n=0;n<50;n++)
	{
		scaleinc = 0.02;
		fade_increment += scaleinc;
		self.alpha = fade_increment;
		wait 0.05;
	}

	//It's faded in!
	self.alpha = 1;

	wait 5;

	level notify("fading slide");

	fade_increment = 1;

	for(n=0;n<50;n++)
	{

		scaleinc = 0.02;
		fade_increment -= scaleinc;
		self.alpha = fade_increment;
		wait 0.05;
	}

	self.alpha = 0;
}
