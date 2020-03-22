main()
{
	precacheShader("levelshots/campaign_briefings/British_intro/enemy_listening.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/invasion_map1.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/invasion_map2.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/invasion_map3.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/invasion_map4.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/invasion_map5.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/pegasus_bridge.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/bridgesketch1.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/bridgesketch2.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/bridgesketch3.dds");
	precacheShader("levelshots/campaign_briefings/British_intro/pegasus_bridge.dds");
	
	precacheShader("levelshots/campaign_briefings/British_intro/horsa.dds");
	
	maps\_briefing::main();
	player = getent("player", "classname");
	player thread skipthebriefing();
	player dothebriefing();
	player gotothelevel();
}

dothebriefing()
{
	self maps\_briefing::start(0.5);
	wait .5;
	self playsound ("slide_advance");
	wait(.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/enemy_listening.dds");
	self playsound("uk_brief_price1", "sounddone");
	//"Gentlemen, thus far you've been training hard at Exeter for a special purpose.  
	//This special purpose... obviously... has something to do with the capturing of bridges.  
	//What I'm about to explain is Top Secret material.  If any of you blokes mention the word 
	//'bridge' outside of this room and I hear of it - and I will - you'll be RTU'd on the spot."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/invasion_map1.dds");
	self playsound("uk_brief_price2", "sounddone");
	//"The invasion of Europe will take place across five main beaches across the Normandy 
	//coast of France.  Elements of the British 2nd Army will strike at Gold and Sword beaches, 
	//along with the 3rd Canadian Infantry Division at Juno.  To the west, the Yanks will take 
	//Utah and Omaha beach."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	//"Now the entire eastern flank of the invasion will be exposed to a German counterattack 
	//from the Calais region.  Should the Germans break through, they could very well have 
	//tanks rolling through Sword beach and all the way down to Utah, wiping out the entier beachhead."
	self playsound("uk_brief_price3", "sounddone");

	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/invasion_map2.dds");
	wait 4.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/invasion_map3.dds");
	wait 4.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/invasion_map4.dds");
	
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self playsound("uk_brief_price4", "sounddone");
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/invasion_map5.dds");
	//"Our task, along with the rest of the 6th Airborne Division, is to secure that flank at 
	//all costs, by capturing and holding key bridges along the axis of approach.  
	wait 9.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/pegasus_bridge.dds");
	//D Company's objective is this bridge of the Caen Canal."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/bridgesketch1.dds");
	self playsound("uk_brief_price5", "sounddone");
	//"Under cover of darkness, the gliders will put us down in the field next to the bridge."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/bridgesketch2.dds");
	self playsound("uk_brief_price6", "sounddone");
	//"From there, we rush the pillbox and prevent the Germans from blowing the bridge.  
	//At least one Bren gun will provide a base of fire while we flank it from both sides."
	self waittill("sounddone");
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/bridgesketch3.dds");
	self playsound("uk_brief_price7", "sounddone");
	//"Once we've captured the bridge, we hold it until relieved, which will be several hours.  
	wait 3.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/horsa.dds");
	
	//During that time, we may find ourselves using the German's own weapons against them, 	
	wait 6;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/British_intro/pegasus_bridge.dds");
	//so I suggest you familiarize yourselves 
	//with the captured ones we have on base.  
	//Good luck, and Godspeed.  Dismissed!"
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
	changelevel ("pegasusnight", false);
}