#using_animtree("generic_human");
main()
{
/*
	tigertank_runup_gunguy
	tigertank_waitloop_gunguy
	tigertank_runup_grenadeguy
	
	tigertank_hatchopencloseandrun_gunguy
	tigertank_hatchopencloseandrun_grenadeguy
	tigertank_hatchopencloseandrun_hatch
	
	The last 3 clips should be played together. Both soldiers open the hatch, shoot and jump down.
	The gunguy has an idle, wait loop, which plays until the grenadeguy arrives.
	
	Also a hatch and taghatch_open dummy were added to the tiger tanks, and the tanks re-exported.

	Someone needs to play %dawn_moody_run_and_wave in front of the player as the screen fades in.  The guy 
	should be running, and as he gets to approximately the near end of the little wall in front of the player, 
	he should play this animation and then keep on running.  He could say one of the "get off the streets" 
	lines at the same time.

	We also have animations for Foley to deliver some of his dialogue:
*		%dawn_foley_mortarsaretakin
*		%dawn_foley_thatsagermantruck
*		%dawn_foley_drawtheirfire
	and a generic animation for when he tells you to follow him and you're a long way away:
*		%dawn_foley_waving_followme
*/

	level.scr_animtree["gun guy"] = #animtree;
	level.scr_animtree["grenade guy"] = #animtree;

	level.scr_anim["gun guy"]["run"]			= (%tigertank_runup_gunguy);
	level.scr_anim["gun guy"]["idle"][0]		= (%tigertank_waitloop_gunguy);
	level.scr_anim["grenade guy"]["run"]		= (%tigertank_runup_grenadeguy);

	level.scr_anim["gun guy"]["attack"]			= (%tigertank_hatchopencloseandrun_gunguy);
	level.scr_anim["grenade guy"]["attack"]		= (%tigertank_hatchopencloseandrun_grenadeguy);
	level.scr_notetrack["gun guy"][0]["notetrack"]	= "fire";
	level.scr_notetrack["gun guy"][0]["effect"]		= "pistol";
	level.scr_notetrack["gun guy"][0]["sound"]		= "weap_thompson_fire";
	level.scr_notetrack["gun guy"][0]["selftag"]	= "tag_flash";

	level.scr_notetrack["grenade guy"][0]["notetrack"]		= "grenade attach";
	level.scr_notetrack["grenade guy"][0]["attach model"]	= "xmodel/weapon_MK2FragGrenade";
	level.scr_notetrack["grenade guy"][0]["selftag"]	= "tag_weapon_right";
	
	precacheModel("xmodel/weapon_mk2fraggrenade");  //head for script dieing models
	level.scr_notetrack["grenade guy"][1]["notetrack"]		= "grenade throw";
	level.scr_notetrack["grenade guy"][1]["detach model"]	= "xmodel/weapon_mk2fraggrenade";
	level.scr_notetrack["grenade guy"][1]["selftag"]	= "tag_weapon_right";


	// Shooting into the tank
	level._effect["pistol"] = loadfx ("fx/muzzleflashes/standardflashworld.efx");

	//* Up! Get up! Wake it and shake it! The Germans are bringing your coffee!
	level.scrsound["baker"]["wake up"]			= "dawnville_friendly1_wakeit";
	//* Mortars, incoming!"
	level.scrsound["baker"]["mortars"]			= "dawnville_friendly1_incoming";
	//* Enemy tank! Look out!
	level.scrsound["baker"]["enemy tank"]		= "dawnville_friendly1_enemytank";
	
	//* We got company! Tiger, moving in from the east!"
	level.scrsound["jackson"]["tiger incoming"]	= "dawnville_friendly3_gotcompany";
	//* Incoming! Take cover! 
	level.scrsound["jackson"]["mortars"]		= "dawnville_friendly3_takecover";
	// Come on, wake up! Get with it!"
	level.scrsound["jackson"]["wake up"]		= "dawnville_friendly3_getwithit";


	//* Off the streets! Mortars!
//	level.scr_anim["foley"]["off the streets"]	= %dawn_foley_waving_followme;
	level.scr_anim["foley"]["off the streets"]  = %dawn_moody_run_and_wave;
//	level.scr_anim["foley"]["wave follow"]		= %dawn_moody_run_and_wave;
	level.scrsound["foley"]["off the streets"]	= "dawnville_foley_offstreets";
	level.scr_face["foley"]["off the streets"]	= %dawnville_facial_foley_062_offthestreets;
	
	//* Alright, the mortars are taking a break."
	level.scr_anim["foley"]["mortars stopped"]	= %dawn_foley_mortarsaretakin;
	level.scrsound["foley"]["mortars stopped"]	= "dawnville_foley_takingbreak";
	level.scr_face["foley"]["mortars stopped"]	= %dawnville_facial_foley_063_allrightthemortars;
	
	//* Alright, the mortars are taking a break."
	level.scrsound["foley"]["mortars stopped 2"]= "dawnville_foley_takingbreak2";
	level.scr_face["foley"]["mortars stopped 2"]= %dawnville_facial_foley_063b_allrightthemortars;


	//* Jackson, Baker, we'll draw their fire! Go!"
	level.scr_anim["foley"]["draw their fire"]	= %dawn_foley_drawtheirfire;
	level.scrsound["foley"]["draw their fire"]	= "dawnville_foley_jackson";
	//* That's a Tiger! Martin, get a Panzerfaust from the church and take that mother out!"
	level.scr_anim["foley"]["get a panzer"]		= %dawn_foley_085_getpanzerfaust;
	level.scrsound["foley"]["get a panzer"]		= "dawnville_foley_getpanzerfaust";
	//* Martin! The Panzerfausts are in the church! Go!
	level.scrsound["foley"]["panzer reminder"]	= "dawnville_foley_faustremind";
	level.scr_face["foley"]["panzer reminder"]	= %dawnville_facial_foley_086alt_areinthechurch;
   
	
	//* Martin! The church! Go! Go! Go!
	level.scrsound["foley"]["panzer reminder 2"]= "dawnville_foley_goremind";
	level.scr_face["foley"]["panzer reminder 2"]= %dawnville_facial_foley_068_martinthechurch;

	//* They got him! Damn!
	level.scrsound["foley"]["they got him"] 	= "dawnville_foley_theygothimdamn";
	level.scr_face["foley"]["they got him"] 	= %dawnville_facial_Foley_064_damn;
	
	//* Right, Captain.
	level.scrsound["johnson"]["right captain"]	= "dawnville_johnson_rightcaptain";
	level.scr_face["johnson"]["right captain"]	= %dawnville_facial_johnson_right;

	//* Behind you!
	level.scrsound["foley"]["behind you"]		= "dawnville_foley_behindyou";
	level.scr_face["foley"]["behind you"]		= %dawnville_facial_foley_076alt_behindyou;

	// Martin, we gotta get that tank!"
	level.scrsound["foley"]["take out tank"]	= "dawnville_foley_gottagettank";
	//* Martin - back to the church with me! The rest of you hold this position!
	level.scrsound["foley"]["to the church"]	= "dawnville_foley_backtochurch";
	level.scr_face["foley"]["to the church"]	= %dawnville_facial_foley_069_martinbacktochurch;

	//* "They're pullin' back! Alright! Good work, but don't let down. They'll be back."
	level.scrsound["foley"]["germans retreat"]	= "dawnville_foley_pullingback";
	level.scr_face["foley"]["germans retreat"]	= %dawnville_facial_foley_070alt_pullingback;

	//* Lewis, Franklin, hold the church."
	level.scrsound["foley"]["L + F hold church"]= "dawnville_foley_lewisfrank";
	level.scr_face["foley"]["L + F hold church"]= %dawnville_facial_foley_071alt3_holdthechurch;

	//* Lewis, hold the church."
	level.scrsound["foley"]["L hold church"]	= "dawnville_foley_lewis";
	//* Franklin, hold the church."
	level.scrsound["foley"]["F hold church"]	= "dawnville_foley_franklin";
	//* Everyone else, follow me!"
	level.scrsound["foley"]["everyone else follow"] = "dawnville_foley_elsefollow";
	level.scr_face["foley"]["everyone else follow"] = %dawnville_facial_foley_074alt_everyonelse;
	//* Everyone follow me!
	level.scrsound["foley"]["everyone follow"]	= "dawnville_foley_everyonefollow";
	level.scr_face["foley"]["everyone follow"]  = %dawnville_facial_foley_067alt_jacksonfollowme;

	//* They're fallin' back! Push 'em outta here! Move it -- go!
	level.scrsound["foley"]["push them back"]	= "dawnville_foley_pushemout";
	// Regroup! Regroup! Over here! Nice work!
	level.scrsound["foley"]["regroup"]			= "dawnville_foley_regroup";
	level.scr_face["foley"]["regroup"]			= %dawnville_facial_foley_079_regroup;
	
	//* Tiger tank!!! Take cover!!!
	level.scrsound["foley"]["tiger tank"]		= "dawnville_foley_tigertankcover";
	// Martin, get another Panzerfaust and take it out! We'll hold off their infantry!"
	level.scrsound["foley"]["get another panzer"]	= "dawnville_foley_holdoffinfantry";
	level.scr_face["foley"]["get another panzer"]	= %dawnville_facial_foley_089_getanother;
	
	//* Nice shot, Martin."
	level.scrsound["foley"]["hey man nice shot"]	= "dawnville_foley_niceshot";
	level.scr_face["foley"]["hey man nice shot"]	= %dawnville_facial_foley_091_niceshotmartin;

	//* Sir! We just spotted German mortar teams to the west! I say we move in quick, and take 'em out!"
	level.scr_anim["parker"]["get mortars"]			= (%dawn_parker_mortarsequence);
	level.scr_notetrack["parker"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["parker"][0]["anime"]		= "get mortars";
	level.scr_notetrack["parker"][0]["dialogue"]	= "dawnville_parker_teams";
	level.scr_notetrack["parker"][0]["facial"]		= %dawnville_facial_Parker_south;

	//* Nice one, Parker. Ok guys...be ready to use any grenades you have left! 
	//* Put down suppressing fire only if you need to - do not waste your ammo! 
	//* All right, let's put those mortars outta business!"
	level.scr_anim["foley"]["get mortars"]			= (%dawn_foley_mortarsequence);
	level.scr_notetrack["foley"][4]["notetrack"]	= "dialogue";
	level.scr_notetrack["foley"][4]["anime"]		= "get mortars";
	level.scr_notetrack["foley"][4]["dialogue"]		= "dawnville_foley_getmortars";
	level.scr_notetrack["foley"][4]["facial"]		= %dawnville_facial_foley_090alt_supress;

	//*-15. Good job, son!
	level.scr_face["foley"]["good job"]				= (%facial_foley15);
	level.scrsound["foley"]["good job"]				= ("burnville_foley_15");

	//* Damnit Martin, get to the church with Foley. We got this area covered."
	level.scrsound["moody"]["got it covered"]		= "dawnville_moody_getchurch";
	level.scr_face["moody"]["got it covered"]		= %dawnville_facial_Moody_042_dammitmartin;

	// Martin, over here. Get in the car."
	level.scrsound["moody"]["1"]	= "dawnville_moody_getincar";

	// Ok captain, assuming that we get back to battalion in this rolling junkyard, what do I tell 'em?"
	level.scrsound["moody"]["2"]	= "dawnville_moody_rollingjunkyard";
	
	// Hand this directly to Major Sheppard.  Tell him Baker Company has secured the town, but won't be able to hold it long - if we don't get relieved soon.  Got that, Sergeant?"
	level.scrsound["foley"]["3"]	= "dawnville_foley_handthis";
	
	// Oh, yes sir, you bet. We ride through enemy lines in a French tin can. Wanna paint a bullseye on it, sir?"
	level.scrsound["moody"]["4"]	= "dawnville_moody_tincan";

	// Pretty sure that won't be necessary, Sarge.  So unless you got a better idea - or a radio that works, carry on. Good luck."
	level.scrsound["foley"]["5"]	= "dawnville_foley_prettysure";
	
	// This is nuts! I can't believe I'm doing this.
	level.scrsound["elder"]["6"]	= "dawnville_elder_thisisnuts";
	
	// Believe it! Unless you sprout wings and wanna fly. It's only 6 miles private, just shutup and do your job."
	level.scrsound["moody"]["7"]	= "dawnville_moody_sproutwings";
	
			
	
/*
	end of level car sequence - 

	foley- attaches to tag driver - he is leaning against the car.
	randomly choose between idles and twitch
 
	moody- attaches to tag driver
	random idles accept for when he waves at the player
 
	elder and car- elder attaches to tag passenger
	(start)
	dawn_peugeot_car_startidle
	dawn_peugeot_elder_startidle
	(elder gets in)
	dawn_peugeot_elder_startidle2endidle
	dawn_peugeot_car_elderin
	(wait for player to get in)
	dawn_peugeot_elder_endidleA
	dawn_peugeot_elder_endidleB
	dawn_peugeot_car_waitidle
	(player get in)
	dawn_peugeot_car_playerin 

*/
	
			
	level.scr_animtree["elder"] = #animtree;
	level.scr_anim["elder"]["teleport"]			= (%dawn_peugeot_elder_startidle);
	level.scr_face["elder"]["teleport"]			= (%facial_neutral);
	level.scr_anim["elder"]["startidle"][0]		= (%dawn_peugeot_elder_startidle);
	level.scr_face["elder"]["startidle"][0]		= (%facial_neutral);
	level.scr_anim["elder"]["elderin"]			= (%dawn_peugeot_elder_startidle2endidle);
	level.scr_face["elder"]["elderin"]			= (%facial_neutral);
	level.scr_anim["elder"]["idle"][0]			= (%dawn_peugeot_elder_endidleA);
	level.scr_face["elder"]["idle"][0]			= (%facial_neutral);
	level.scr_anim["elder"]["idle"][1]			= (%dawn_peugeot_elder_endidleB);
	level.scr_face["elder"]["idle"][1]			= (%facial_neutral);
	level.scr_anim["elder"]["end"]				= (%dawn_peugeot_elder_endsequence);

	// This is nuts! I can't believe I'm doing this.
	level.scr_notetrack["elder"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["elder"][0]["dialogue"]		= "dawnville_elder_thisisnuts";
	level.scr_notetrack["elder"][0]["facial"]		= %dawnville_facial_elder_002_nuts;

	level.scr_animtree["moody"] = #animtree;
	level.scr_anim["moody"]  ["teleport"]		= (%dawn_peugeot_moody_idleA);
	level.scr_face["moody"]  ["teleport"]		= (%facial_neutral);
	level.scr_anim["moody"]  ["idle"][0]		= (%dawn_peugeot_moody_idleA);
	level.scr_face["moody"]  ["idle"][0]		= (%facial_neutral);
	level.scr_anim["moody"]  ["idle"][1]		= (%dawn_peugeot_moody_idleB);
	level.scr_face["moody"]  ["idle"][1]		= (%facial_neutral);
	level.scr_anim["moody"]  ["idle"][2]		= (%dawn_peugeot_moody_idleC);
	level.scr_face["moody"]  ["idle"][2]		= (%facial_neutral);
	level.scr_anim["moody"]  ["wave"]			= (%dawn_peugeot_moody_wave);
	level.scrsound["moody"]  ["wave"]			= "dawnville_moody_getincar";
	level.scr_face["moody"]  ["wave"]			= (%dawnville_facial_moody_043_getin);
	level.scr_anim["moody"]  ["end"]			= (%dawn_peugeot_moody_endsequence);
	level.scr_anim["moody"]  ["endidle"][0]		= (%dawn_peugeot_moody_endidle);
	level.scr_face["moody"]  ["endidle"][0]		= (%facial_neutral);

	// Ok captain, assuming that we get back to battalion in this rolling junkyard, what do I tell 'em?"
	level.scr_notetrack["moody"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["moody"][0]["dialogue"]		= "dawnville_moody_rollingjunkyard";
	level.scr_notetrack["moody"][0]["facial"]		= %dawnville_facial_moody_044_junk;

	// Oh, yes sir, you bet. We ride through enemy lines in a French tin can. Wanna paint a bullseye on it, sir?"
	level.scr_notetrack["moody"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["moody"][1]["dialogue"]		= "dawnville_moody_tincan";
	level.scr_notetrack["moody"][1]["facial"]		= %dawnville_facial_moody_045_bullseye;

	// Believe it! Unless you sprout wings and wanna fly. It's only 6 miles private, just shutup and do your job."
	level.scr_notetrack["moody"][2]["notetrack"]	= "dialogue";
	level.scr_notetrack["moody"][2]["dialogue"]		= "dawnville_moody_sproutwings";
	level.scr_notetrack["moody"][2]["facial"]		= %dawnville_facial_moody_046_shutup;

	level.scr_notetrack["moody"][3]["notetrack"]	= "attach map = \"left\"";
	level.scr_notetrack["moody"][3]["anime"]		= "end";
	level.scr_notetrack["moody"][3]["attach model"]	= "xmodel/dawnville_map";
	level.scr_notetrack["moody"][3]["selftag"]		= "tag_weapon_left";

	level.scr_notetrack["moody"][4]["notetrack"]	= "detach map = \"left\"";
	level.scr_notetrack["moody"][4]["anime"]		= "end";
	level.scr_notetrack["moody"][4]["detach model"]	= "xmodel/dawnville_map";
	level.scr_notetrack["moody"][4]["selftag"]		= "tag_weapon_left";


	level.scr_animtree["foley"] = #animtree;
	level.scr_anim["foley"]  ["teleport"]		= (%dawn_peugeot_foley_idleA);
	level.scr_face["foley"]  ["teleport"]		= (%facial_neutral);
	level.scr_anim["foley"]  ["reach idle"]		= (%dawn_peugeot_foley_idleA);
	level.scr_face["foley"]  ["reach idle"]		= (%facial_neutral);
	level.scr_anim["foley"]  ["idle"][0]		= (%dawn_peugeot_foley_idleA);
	level.scr_face["foley"]  ["idle"][0]		= (%facial_neutral);
	level.scr_anim["foley"]  ["idle"][1]		= (%dawn_peugeot_foley_idleB);
	level.scr_face["foley"]  ["idle"][1]		= (%facial_neutral);
	level.scr_anim["foley"]  ["idle"][2]		= (%dawn_peugeot_foley_twitch);
	level.scr_face["foley"]  ["idle"][2]		= (%facial_neutral);
	level.scr_anim["foley"]  ["end"]			= (%dawn_peugeot_foley_endsequence);

	// Hand this directly to Major Sheppard.  Tell him Baker Company has secured the town, but won't be able to hold it long - if we don't get relieved soon.  Got that, Sergeant?"
	level.scr_notetrack["foley"][0]["notetrack"]	= "dialogue";
	level.scr_notetrack["foley"][0]["anime"]		= "end";
	level.scr_notetrack["foley"][0]["dialogue"]		= "dawnville_foley_handthis";
	level.scr_notetrack["foley"][0]["facial"]		= %dawnville_facial_foley_083alt_gotthat;

	// Pretty sure that won't be necessary, Sarge.  So unless you got a better idea - or a radio that works, carry on. Good luck."
	level.scr_notetrack["foley"][1]["notetrack"]	= "dialogue";
	level.scr_notetrack["foley"][1]["anime"]		= "end";
	level.scr_notetrack["foley"][1]["dialogue"]		= "dawnville_foley_prettysure";
	level.scr_notetrack["foley"][1]["facial"]		= %dawnville_facial_foley_084alt_wontbe;

/*
	level.scr_notetrack["foley"][2]["notetrack"]	= "attach map = \"left\"";
	level.scr_notetrack["foley"][2]["anime"]		= "end";
	level.scr_notetrack["foley"][2]["attach model"]	= "xmodel/dawnville_map";
	level.scr_notetrack["foley"][2]["selftag"]		= "tag_weapon_left";
*/
	level.scr_notetrack["foley"][2]["notetrack"]	= "detach map = \"left\"";
	level.scr_notetrack["foley"][2]["anime"]		= "end";
	level.scr_notetrack["foley"][2]["detach model"]	= "xmodel/dawnville_map";
	level.scr_notetrack["foley"][2]["selftag"]		= "tag_weapon_left";

	level.scr_notetrack["foley"][3]["notetrack"]	= "detach pencil = \"right\"";
	level.scr_notetrack["foley"][3]["anime"]		= "end";
	level.scr_notetrack["foley"][3]["detach model"]	= "xmodel/dawnville_pencil";
	level.scr_notetrack["foley"][3]["selftag"]		= "tag_weapon_right";

	tank();
	peugeot();
}	

#using_animtree("panzerIV");
tank()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["attack"]			= (%tigertank_hatchopencloseandrun_hatch);
	level.scr_anim["tank"]["root"] = %root;
	// Dawnville_tank_hatch

	level.scr_notetrack["tank"][0]["notetrack"]	= "\"sound\"";
	level.scr_notetrack["tank"][0]["sound"]		= "dawnville_tank_hatch";
}

#using_animtree("peugeot");
peugeot()
{
	level.scr_animtree["car"] = #animtree;
	level.scr_anim["car"]["start"]				= (%dawn_peugeot_car_startidle);
	level.scr_anim["car"]["startidle"][0]		= (%dawn_peugeot_car_startidle);
	level.scr_anim["car"]["elderin"]			= (%dawn_peugeot_car_elderin);
	level.scr_anim["car"]["idle"][0]			= (%dawn_peugeot_car_waitidle);
	level.scr_anim["car"]["playerin"]			= (%dawn_peugeot_car_playerin);
	level.scr_anim["car"]["end"]				= (%dawn_peugeot_car_endsequence);

}

/*
// dawnville_friendly1_wakeit			// Up! Get up! Wake it and shake it! The Germans are bringing your coffee!
// dawnville_friendly3_gotcompany		// We got company! Tiger, moving in from the east!"
// dawnville_friendly1_incoming			// Mortars, incoming!"
// dawnville_friendly3_takecover		//Incoming! Take cover!

// dawnville_foley_offstreets			// Off the streets! Mortars!
// dawnville_foley_takingbreak			// All right, the mortars are taking a break."
// dawnville_foley_jackson				// Jackson, Baker, we'll draw their fire! Go!"
// dawnville_foley_getpanzerfaust		// That's a Tiger! Martin, get a Panzerfaust from the church and take that mother out!"
// dawnville_foley_faustremind			// Martin! The Panzerfausts are in the church! Go!
// dawnville_foley_goremind				// Martin! The church! Go! Go! Go!
// dawnville_foley_theygothimdamn		// They got him! Damn!

// dawnville_johnson_rightcaptain		// "Right, Captain."

// dawnville_friendly1_enemytank		// Enemy tank! Look out!
// dawnville_friendly1_areacovered1		// We're takin' some light action, but we've got this area covered!"
// dawnville_friendly1_areacovered2		// No sweat - we're good - we got the church covered!
// dawnville_friendly1_areacovered2		// Tell Foley we're takin' some action, but don't need help."
// dawnville_friendly1_churchfall		// Sir! The Germans are at the church! It's gonna fall!

// dawnville_foley_backtochurch			// Martin - back to the church with me! The rest of you hold this position!

// dawnville_friendly3_getwithit		// Come on, wake up! Get with it!"

// dawnville_elder_thisisnuts			// This is nuts! I can't believe I'm doing this.

// dawnville_foley_pullingback			// "They're pullin' back! Alright! Good work, but don't let down. They'll be back."
// dawnville_foley_lewisfrank			// Lewis, Franklin, hold the church."
// dawnville_foley_lewis				// Lewis, hold the church."
// dawnville_foley_franklin				// Franklin, hold the church."
// dawnville_foley_elsefollow			// Everyone else, follow me!"
// dawnville_foley_everyonefollow		// Everyone follow me!
// dawnville_foley_behindyou			// Behind you!
// dawnville_foley_gottagettank			// Martin, we gotta get that tank!"

// dawnville_friendly1_incoming			// Get a grenade in there!
// dawnville_friendly3_fireinhole		// Fire in the hole!

// dawnville_foley_pushemout			// They're fallin' back! Push 'em outta here! Move it -- go!
// dawnville_foley_regroup				// Regroup! Regroup! Over here! Nice work!
// dawnville_foley_tigertankcover		// Tiger tank!!! Take cover!!!
// dawnville_foley_holdoffinfantry		// Martin, get another Panzerfaust and take it out! We'll hold off their infantry!"
// dawnville_foley_niceshot				// Nice shot, Martin."

// dawnville_parker_teams				// Sir! We just spotted German mortar teams to the west! I say we move in quick, and take 'em out!"

// dawnville_foley_getmortars			// Nice one, Parker. Ok guys...be ready to use any grenades you have left! Put down suppressing fire only if you need to - do not waste your ammo! All right, let's put those mortars outta business!"
// dawnville_foley_handthis				// Hand this directly to Major Sheppard.  Tell him Baker Company has secured the town, but won't be able to hold it long - if we don't get relieved soon.  Got that, Sergeant?"
// dawnville_foley_prettysure			// Pretty sure that won't be necessary, Sarge.  So unless you got a better idea - or a radio that works, carry on. Good luck."

// dawnville_moody_assup				// Martin, get your ass up. We gotta get the hell off the streets."
// dawnville_moody_getchurch			// Damnit Martin, get to the church with Foley. We got this area covered."
// dawnville_moody_getincar				// Martin, over here. Get in the car."
// dawnville_moody_rollingjunkyard		// Ok captain, assuming that we get back to battalion in this rolling junkyard, what do I tell 'em?"
// dawnville_moody_tincan				// Oh, yes sir, you bet. We ride through enemy lines in a French tin can. Wanna paint a bullseye on it, sir?"
// dawnville_moody_sproutwings			// Believe it! Unless you sprout wings and wanna fly. It's only 6 miles private, just shutup and do your job."


*/

/*
// dawnville_friendly1_areacovered1		// We're takin' some light action, but we've got this area covered!"
// dawnville_friendly1_areacovered2		// No sweat - we're good - we got the church covered!
// dawnville_friendly1_areacovered2		// Tell Foley we're takin' some action, but don't need help."
// dawnville_friendly1_churchfall		// Sir! The Germans are at the church! It's gonna fall!

wont be used:
// dawnville_moody_assup				// Martin, get your ass up. We gotta get the hell off the streets."
// dawnville_friendly1_incoming			// Get a grenade in there!
// dawnville_friendly3_fireinhole		// Fire in the hole!

   
	dawnville_facial_foley_085_thepanzerfaust
	dawnville_facial_foley_077alt_gottagettank
	
	dawnville_facial_elder_002_ohthisisnot
	dawnville_facial_elder_002_nuts
	dawnville_facial_moody_046_shutup
	dawnville_facial_moody_045_bullseye
	dawnville_facial_moody_044_junk
	dawnville_facial_moody_043_getin
	dawnville_facial_foley_084alt_wontbe
	dawnville_facial_foley_083alt_gotthat
	dawnville_facial_foley_090alt_supress
	dawnville_facial_Parker_south
*/
