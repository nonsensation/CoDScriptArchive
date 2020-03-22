main()
{
	precacheShader("levelshots/campaign_briefings/Allied_intro/europe_map.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/big3.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/wrecked_panther.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/bombers.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/dest_plane.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/burning_ship.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/german88crew.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/v1.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/v2.dds");
	
	precacheShader("levelshots/campaign_briefings/Allied_intro/bombed_city.dds");
	precacheShader("levelshots/campaign_briefings/Allied_intro/london_fireman.dds");
	
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
	wait(.5);

	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/europe_map.dds");
	//Show map of Europe (with borders and names of countries clearly marked) 
	//with 3 colors, Gray for the area the allies controlled before June 44, 
	//light blue (with dark blue arrows moving across it) for the area they 
	//liberated between June 44 and January 45, and Red for the area still 
	//controlled by Germany in January 45.

	self playsound("allied_brief_narrator1", "sounddone");
	//Since June of 1944 the Americans, British and Canadians 
	//have made enormous advances through Europe, sweeping through 
	//much of France, Belgium and Holland almost to the banks of the Rhine. 
	self waittill("sounddone");

	self playsound ("slide_advance");
	wait(0.5);

	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/big3.dds");
	//Show the famous photo of Stalin, Churchill and Roosevelt together.
	self playsound("allied_brief_narrator2", "sounddone");
	//Much of their success must be credited to the Russians who at Stalingrad 
	//during the winter of 1943 destroyed many of the Germans best Panzer divisions.
	self waittill("sounddone");

	self playsound ("slide_advance");
	wait(0.5);

	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/wrecked_panther.dds");
	self playsound("allied_brief_narrator3", "sounddone");
	//On the eastern front the Russians have continued to push the Germans back through 
	//Russia and much of Poland and will soon be on the banks of the Oder river and the border of Germany.
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);

	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/bombers.dds");
	self playsound("allied_brief_narrator4", "sounddone");
	//The situation for the Germans has grown desperate. 
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/bombed_city.dds");

	self playsound("allied_brief_narrator5", "sounddone");
	//Allied Bombers have reduced many major German cities to rubble. 
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/dest_plane.dds");
	//Show a photo of airplanes on a airfield burning and destroyed.

	self playsound("allied_brief_narrator6", "sounddone");
	//The German air force, the Luftwaffe is a mere shadow of the power 
	//it once had, and can do little to stop the bombers, 
	//much less fight the allied armies. 
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/burning_ship.dds");
	//Show a photo of a major German ship sinking or sunk in harbor, 
	//could be the Tripitz, the important thing is that its obviously a ship and its obviously badly damaged.

	self playsound("allied_brief_narrator7", "sounddone");
	//The Kriegsmarine, the German navy is mostly sunk, its U-boats 
	//destroyed and its sailors pressed into the army.
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);

	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/german88crew.dds");
	self playsound("allied_brief_narrator8", "sounddone");
	//However, the enemy refuses to surrender.
	self waittill("sounddone");
	
	self playsound ("slide_advance");
	wait(0.5);
	
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/v1.dds");
	self playsound("allied_brief_narrator9", "sounddone");
	//Unable to stop the allied advance, Hitler has turned to vengeance 
	wait 3.5;
	self playsound ("slide_advance");
	wait .5;
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/v2.dds");
	
	//weapons, the V1 and now the V2 rockets. 
	self waittill("sounddone");
	wait(0.5);
	self playsound("allied_brief_narrator10", "sounddone");
	//These rockets, although some of the most advanced weapons of the war, 
	//are too inaccurate to hit military targets. 
	self playsound ("slide_advance");
	wait(0.5);
	self thread maps\_briefing::image("levelshots/campaign_briefings/Allied_intro/london_fireman.dds");
	//Instead they are being 
	//used to terrorize London. 
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
	changelevel ("hurtgen", false);
}