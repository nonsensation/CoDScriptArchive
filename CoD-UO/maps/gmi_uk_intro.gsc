main()
{
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_1.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_2.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_3.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_4.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_5.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_6.dds");
	precacheShader("levelshots/campaign_briefings/uk_intro/uk_intro_7.dds");

	maps\_briefing_gmi::main();
	player = getent("player", "classname");
	player thread skipthebriefing();
	player dothebriefing();
	player gotothelevel();
}

dothebriefing()
{
	// Slide 1
	self maps\_briefing_gmi::start(0.5);
	wait(0.5);
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_1.dds");
	self playsound("uk_intro_fo1", "sounddone");
	//  Slide 2
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo2", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_2.dds");
	//  Slide 3
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo3", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_3.dds");
	//  Slide 4
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo4", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_4.dds");
	//  Slide 5
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo5", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_5.dds");
	//  Slide 6
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo6", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_6.dds");
	//  Slide 7
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_intro_fo7", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_intro/uk_intro_7.dds");

	// End of Slides
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	maps\_briefing_gmi::end();
}

skipthebriefing()
{
	self waittill("briefingskip");
	gotothelevel();
}

gotothelevel()
{
	changelevel ("bomber", false);
}