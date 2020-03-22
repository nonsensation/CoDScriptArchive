main()
{
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_1.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_2.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_3.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_4.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_5.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_6.dds");
	precacheShader("levelshots/campaign_briefings/uk_mid/uk_mid_7.dds");
	
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
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_1.dds");
	self playsound("uk_mid_ingram1", "sounddone");
	//  Slide 2
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram2", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_2.dds");
	//  Slide 3
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram3", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_3.dds");
	//  Slide 4
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram4", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_4.dds");
	//  Slide 5
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram5", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_5.dds");
	//  Slide 6
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram6", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_6.dds");
	//  Slide 7
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_mid_ingram7", "sounddone");
	self thread maps\_briefing_gmi::image("levelshots/campaign_briefings/uk_mid/uk_mid_7.dds");
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
	changelevel ("sicily1", false);
}