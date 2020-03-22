main()
{
	
	precacheShader("levelshots/campaign_briefings/R_intro/russian01.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian02.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian03.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian04.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian08.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian05.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian06.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian07.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian09.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian10.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian11.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian12.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian13.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian14.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian15.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian16.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian17.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian18.dds");
	precacheShader("levelshots/campaign_briefings/R_intro/russian19.dds");
	
	maps\_briefing::main();
	player = getent("player", "classname");
	player thread skipthebriefing();
	player dothebriefing();
	player gotothelevel();

}

dothebriefing()
{
	self maps\_briefing::start(0.5);
	wait (.5);
	self playsound ("slide_advance");
	wait(.5);
	self playsound("stalingrad_briefing", "sounddone");
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian01.dds");
	wait 3.5;
	//attack 4 seconds
	
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian02.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian03.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian04.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian08.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	
	//raping 14 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian07.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian06.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian09.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	//destroying cities 20 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian05.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	//the city that bears our great leaders name 24 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian10.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	//Stalingrad 26 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian11.dds");
	wait 3.5;
	self playsound ("slide_advance");
	wait .5;
	
	//russians fighting 30 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian12.dds");
	wait 1.5;
	self playsound ("slide_advance");
	wait .5;
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian13.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian14.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian15.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian16.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian17.dds");
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	
	//commissars 47 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian18.dds");
	wait 6.5;
	self playsound ("slide_advance");
	wait .5;
	
	
	//mother land 54 seconds
	self thread maps\_briefing::image("levelshots/campaign_briefings/R_intro/russian19.dds");
	wait 5;
	self playsound ("slide_advance");
	
	
	//wait 59;
	//self waittill("sounddone");
	wait(0.5);

	maps\_briefing::end();
}

skipthebriefing()
{
	self waittill("briefingskip");
	gotothelevel();
}

gotothelevel()
{
	changelevel("stalingrad", false);
}