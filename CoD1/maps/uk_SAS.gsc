main()
{
	precacheShader("levelshots/campaign_briefings/British_mid/enemy_listening.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/pegasus2.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/dam_map.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/factory.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/mockup1.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/mockup2.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/dam_d.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/eder_dam.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/flakveirling.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/eder_power.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/condor.dds");
	precacheShader("levelshots/campaign_briefings/British_mid/eder_dam.dds");
	
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
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/enemy_listening.dds");
	self playsound("uk_brief_waters1", "sounddone");
	//"Alright, settle down.  We've got new orders straight from SOE, 
	//as well as two new transfers from the 6th Airborne to help us carry 'em out.  
	
	wait 6.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/pegasus2.dds");
	
	//They were highly recommended for this operation as a result of their actions on D-Day.  
	//Captain Price, Sgt. Evans - welcome to 3 Troop.  Now, let's get down to business."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/dam_map.dds");
	self playsound("uk_brief_waters2", "sounddone");
	//"These are the locations of the major hydroelectric dams in the Ruhr industrial region of Germany.  
	//Their main purpose is to provide electrical power 
	wait 6.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/factory.dds");
	//to the factories and cities throughout the area."
	self waittill("sounddone");
	wait(0.5);
	self playsound("uk_brief_waters3", "sounddone");
	// "Last year a clever fellow by the name of Dr. Barnes Wallis 
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/mockup1.dds");
	//created an odd sort of bomb that was specially designed to breach these dams.
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/mockup2.dds");
	self playsound("uk_brief_waters4", "sounddone");
	//"Using these bombs, the Dambusters from 617 Squadron successfully breached the Mohne and Eder dams, 
	//causing extensive flooding and damage 
	
	//to the industrial heart of Germany.  
	//The bad news is the bastards have already repaired the damage done, 
	//and Bomber Command wants to have another crack at these targets."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/eder_dam.dds");
	self playsound("uk_brief_waters5", "sounddone");
	//"This is the Eder Dam.  We're to make a night drop on this one.  
	//From the DZ, it's a day's tab through unpopulated areas around the dam's reservoir."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/flakveirling.dds");
	self playsound("uk_brief_waters6", "sounddone");
	//"Dropping in any closer is impossible, 
	//as the enemy flak is simply too concentrated around the dam itself."
	self waittill("sounddone");
	wait(0.5);
	self playsound("uk_brief_waters7", "sounddone");
	//"Our mission is to locate as many of these anti-air guns as possible, 
	//wipe them out so that the bombers can make their runs."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/eder_power.dds");
	self playsound("uk_brief_waters8", "sounddone");
	//"This building at the foot of the dam houses the electrical generators.  
	//Our orders are to blow this structure in the event that the bombers fail to breach the dam. 
	//We set the explosives on a short timer, 
	wait 9.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/condor.dds");
	//then get the hell out of there by truck to a nearby 
	//airfield and appropriate suitable 
	//air transport from the enemy."
	self waittill("sounddone");
	wait(0.5);
	self playsound("uk_brief_waters9", "sounddone");
	//"You all know what to do."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_mid/eder_dam.dds");
	self playsound("uk_brief_waters10", "sounddone");
	//"Check and test your magazines, zero your sights, and review the maps and photographs carefully.  
	//We'll recieve signals and embarkation details within the next two hours.  Good luck."
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
	changelevel("dam", false);
}