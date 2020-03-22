main()
{
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_objective4.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/OmahaLanding.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/Misdrop.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/DawnvilleChurch.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/Peugeot.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/Brecourt.dds");
	precacheShader("levelshots/campaign_briefings/US_mid/C47.dds");
	
	maps\_briefing::main();
	player = getent("player", "classname");
	player thread skipthebriefing();
	player dothebriefing();
	player gotothelevel();
}

dothebriefing()
{
	self maps\_briefing::start(0.5);
	wait(.5);
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_objective4.dds");
	//"First platoon, listen up!  Sgt. Moody owes me fifty bucks 
	//'cause it looks like Operation Overlord was a success."
	self playsound("us_midbrief_foley1", "sounddone");
	self waittill("sounddone");
	wait(0.5);
	//"Our British and Canadian friends took most of their objectives."
	self playsound("us_midbrief_foley2", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/OmahaLanding.dds");
	//"And except for Omaha, all the beach landings went pretty smoothly."
	self playsound("us_midbrief_foley3", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/Misdrop.dds");
	//"The airborne was miss dropped everywhere but the men formed 
	//mixed units and accomplished most of the airborne D-Day objectives."
	self playsound("us_midbrief_foley4", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/DawnvilleChurch.dds");
	//"I am extremely proud of all of you."
	self playsound("us_midbrief_foley5", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/Peugeot.dds");
	//"As you know, Sgt. Moody and Privates Elder and Martin broke through German lines 
	//to get word to battalion headquarters.  If it wasn't for their success, 
	//HQ probably would not have sent the reinforcements that helped us hold Ste Mere Eglise."
	self playsound("us_midbrief_foley6", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/Brecourt.dds");
	//"At headquarters, Moody, Elder, and Martin were assigned to silence a German battery at 
	//Brecourt Manor and faced an entire platoon of Germans with only a handful of men."
	self playsound("us_midbrief_foley7", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_mid/C47.dds");
	//"Well, it seems that someone at command noticed your actions.  
	//Our unit has been detached from the rest of the 101st so that it can be used for some 
	//special missions behind enemy lines."
	self playsound("us_midbrief_foley8", "sounddone");
	self waittill("sounddone");
	wait(0.5);
	//"I suggest that you brush on your German, gentlemen, and enjoy your R and R while you can."
	self playsound("us_midbrief_foley9", "sounddone");
	self waittill("sounddone");
	self playsound ("slide_advance");
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
	changelevel("chateau", false);
}