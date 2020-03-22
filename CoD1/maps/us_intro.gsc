main()
{
	precacheShader("levelshots/campaign_briefings/US_intro/Foley.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/dday_map1.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/dday_map2.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/dday_map3.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/dday_map4.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_objective1.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_drop1.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_drop2.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_objective2.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_objective3.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airborne_objective4.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/Eureka.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/normandy.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/GermanFortifications.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/airdrop.dds");
	precacheShader("levelshots/campaign_briefings/US_intro/DDay.dds");
	
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
	//SS of Foley
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/Foley.dds");
	self playsound("us_introbrief_foley1", "sounddone");
	// "Baker Company, listen up."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley2", "sounddone");
	//"This is the big one."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley3", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/dday_map1.dds");
	//"Operation Overlord.  The air and sea borne invasion of Normandy."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley4", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/dday_map2.dds");
	//"On H-hour, D-Day, sea borne infantry will attack five beaches codenamed 
	//Utah, Omaha, Gold, Juno, and Sword, here on the coast of Normandy."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley5", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/dday_map3.dds");
	//"Utah and Omaha beaches will be attacked by three of our infantry divisions."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley6", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/dday_map4.dds");
	//"At the same time, two British and one Canadian division will hit Gold, Juno, and Sword beaches."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley7", "sounddone");
	// "The airborne will be landing six hours before H-Hour, before the air and naval bombardments."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley10", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_objective1.dds");
	//"The British 6th Airborne division will be landing here.  
	wait 2.5;
	self playsound ("slide_advance");
	wait .5;
	//self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_drop0.dds");
	//At the same time the 101st and the 82nd Airborne will be landing in these areas."
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_drop1.dds");
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley11", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_drop2.dds");
	//"The Douze River estuary, here, divides Utah and Omaha beach."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley12", "sounddone");
	//"The mission of the 101st is to capture the Douze River crossings, 
	//linking Utah and Omaha beach, and to protect the flanks of Utah beach."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_objective2.dds");
	self playsound("us_introbrief_foley13", "sounddone");
	//"This road here is the main highway that connects the entire Cotentin peninsula."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley14", "sounddone"); 
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_objective3.dds");
	//"The Germans have troop concentrations in this region.  
	//When those troops are mobilized into a counter-attack on the beaches, 
	//they'll have to move along this road."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley15", "sounddone");
	//"The 101st is going to make sure that doesn't happen."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("us_introbrief_foley16", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airborne_objective4.dds");
	//"Baker Company, that's us, has been assigned this causeway here."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley17", "sounddone");
	//"The pathfinders, like Private Martin, will be dropped ahead of the main force and 
	//will plant beacons on the ground to mark the landing zones."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/normandy.dds");
	self playsound("us_introbrief_foley18", "sounddone");
	//"However, there is no telling what will happen once we're on the ground.  
	//So I want all of you to learn the objectives of every unit in both the 101st and 82nd."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley19", "sounddone");
	//"I also want you to study these maps and photographs until you've memorized them."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/DDay.dds");
	self playsound("us_introbrief_foley20", "sounddone");
	//"We will be landing behind the Atlantic Wall, between several German garrisons.  
	//We can't expect to be relieved until at least several hours after H-Hour."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/US_intro/airdrop.dds");
	self playsound("us_introbrief_foley21", "sounddone");
	//"This is what we've been training for."
	self waittill("sounddone");
	wait(0.5);
	self playsound("us_introbrief_foley22", "sounddone");
	//"Good luck."
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
	changelevel ("pathfinder", false);
}