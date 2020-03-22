main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
	// Smoke and fire effects, "wildfire1" is the popular one on the hill.
    level._effect["smallfire"]	= loadfx ("fx/fire/smallbon_1stalin.efx"); 
    level._effect["fireheavysmoke"]		= loadfx ("fx/fire/fireheavysmoke.efx");
    level._effect["flameout"]			= loadfx ("fx/tagged/flameout.efx");      
    level._effect["medFire"]		= loadfx ("fx/fire/medFireLightSmoke.efx");
    level._effect["gigantor"]		= loadfx ("fx/smoke/gigantor_lite.efx");
    level._effect["waterhit"]		= loadfx ("fx/impacts/n_waterimpact.efx");
    level._effect["smokewall"]	= loadfx ("fx/smoke/facade_big.efx");
    level._effect["wildfire1"]	= loadfx ("fx/fire/em_fire1stalin.efx");
    level._effect["wildfire2"]	= loadfx ("fx/fire/extreme_stalingrad.efx");

	// Used in the CAN at the foot of the hill to the right
    level._effect["canfire"]	= loadfx ("fx/fire/smallbon_1stalin.efx"); 

	// These effects are used in explosions.
    level._effect["stone"]	= loadfx ("fx/cannon/stone.efx");
    level._effect["wood_close"]	= loadfx ("fx/cannon/wood_close.efx");
    level._effect["wood"]	= loadfx ("fx/cannon/wood.efx");
    level._effect["brick"]	= loadfx ("fx/cannon/brick.efx");
    level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
    level._effect["dirt"]	= loadfx ("fx/cannon/dirt.efx");
    level._effect["glass"]	= loadfx ("fx/cannon/glass.efx");
    
    // For when the stukas shoots dirt or water
    level._effect["stuka dirt"]	= loadfx ("fx/impacts/stukastrafe_dirt.efx");
	level._effect["stuka water hit"] = loadfx ("fx/impacts/waterhit_large.efx");

	// Effect that plays when the MG42s are trying to shoot you (on the ground). 
	// Also plays on AI when they die scripted deaths (like a dust hit).
    level._effect["ground"]	= loadfx ("fx/impacts/small_gravel.efx");

	// Big version of that effect, used for AI bullet hits.
    level._effect["big ground"]	= loadfx ("fx/impacts/large_gravel.efx");
    
    // To be used in the future for when the walls you hide behind are hit by the MG42s as an additional squib.
    level._effect["wall brick"]	= loadfx ("fx/impacts/large_gravel.efx");

	// Dust that comes down from the ceiling when the barge is strafed by planes. 
	// Should be tightened up/replaced to make this more apparent
    level._effect["boat dust"]	= loadfx ("fx/impacts/dusty_em.efx");

	// Pistol effect when the Commissar shoots swimming jumpers
	level._effect["pistol"] = loadfx ("fx/muzzleflashes/standardflashworld.efx");
	
	// Metal and flesh hits used when the planes strafe the barges
	level._effect["metal small"] = loadfx ("fx/impacts/metalhit_large.efx");
	level._effect["metal"] = loadfx ("fx/impacts/metalhit_dramatic.efx");
	level._effect["flesh"] = loadfx ("fx/impacts/flesh_hit5g.efx");
	level._effect["flesh small"] = loadfx ("fx/impacts/flesh_hit.efx");



	// Mortar impact effects on the landscape
//	level.mortar[0] = loadfx ("fx/impacts/beach_mortar.efx");
//	level.mortar[1] = loadfx ("fx/impacts/dirthit_mortar.efx");
//	level.mortar[0] = loadfx ("fx/impacts/newimps/blast_gen3.efx");
	level.mortar[0] = loadfx ("fx/impacts/newimps/minefield_dark.efx");
	
	// Mg42 effects from the planes
	level.mg42_effect = loadfx ("fx/muzzleflashes/mg42hv.efx");
	level.mg42_effect2 = loadfx ("fx/muzzleflashes/mg42hv_nosmoke.efx");
	
//	level.mg42_effect = loadfx ("fx/surfacehits/mortarImpact.efx");
	level._effect["explosion"] = loadfx ("fx/explosions/explosion1_beach.efx");

	// Effects used for the grand finale ridge explosion and whatnot.
	level._effect["ridge explosion"] = loadfx ("fx/explosions/mutha2.efx");
	level._effect["missile"] = loadfx ("fx/cannon/missile_launch.efx");
	level._effect["sky flash"] = loadfx ("fx/atmosphere/missile_skyflash.efx");
	level._effect["launch flash"] = loadfx ("fx/cannon/missile_flash.efx");
	
	// Comes off the tugboats on the left. WE SHOULD PUT THIS ON BARGES TOO.
	level._effect["bow left"] = loadfx ("fx/tagged/tag_bow_left.efx");
	level._effect_rate["bow left"] = 0.3;

	// Comes out of the right side of tugboats
	level._effect["bow right"] = loadfx ("fx/tagged/tag_bow_right.efx");
	level._effect_rate["bow right"] = 0.2;

	// Used on the tugboat smokestack, should be more noticeable and not look like sprites popping into existence.
	// Also used on train. Not very noticeable on train.
	level._effect["bow smokestack"] = loadfx ("fx/tagged/tug_smoke1.efx");
	level._effect_rate["bow smokestack"] = 0.3;
	
	// Comes off the tugboats on the left. WE SHOULD PUT THIS ON BARGES TOO.
	level._effect["train smoke"] = loadfx ("fx/tagged/train_smoke.efx");
	level._effect_rate["train smoke"] = 0.3;

	level._effect["sinking boat smoke"] = loadfx ("fx/smoke/scuttled_smoke.efx");
	level._effect_rate["sinking boat smoke"] = 0.8;
	
	//*ATTENTION* This effectorigin angle needs to be turned so that z axis is foreward.
	// Back of the (tug) boat effect.
	level._effect["bow back"] = loadfx ("fx/water/tug_froth.efx");
	level._effect_rate["bow back"] = 0.3;

	// This effect is (or will be) played on the guys that jump out of the boat and into the water:
    level._effect["watersplash"] = loadfx ("fx/water/splash.efx");
	
	// Frothy water as the barge sinks 
    level._effect["froth"] = loadfx ("fx/water/em_froth.efx");
    level._effect_rate["froth"] = 0.2;

	// Barge and plane explosion effect, barge_explosion might be being used for the plane dying too.
	level._effect["barge_explosion"] = loadfx ("fx/explosions/aircraft_down.efx");
	level._effect["stuka explosion"] = loadfx ("fx/explosions/aircraft_down.efx");
	// Flak explosion, for boats blowing up.
	level._effect["new boat explosion"] = loadfx ("fx/explosions/metal_b.efx");
}

spawnWorldFX()
{
	maps\_fx::LoopFx("wildfire1", (-889.00, -7613.00, -110.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (-327.00, 2156.00, 1079.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (1607.00, 2139.00, 1094.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (3314.00, 1004.00, 1225.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (4826.00, -1393.00, 1110.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (-4311.00, 528.00, 362.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (-4570.00, 1065.00, 589.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (2685.00, -1186.00, 939.00), 0.3, undefined);
	maps\_fx::LoopFx("wildfire1", (-1439.00, 2445.00, 1096.00), 0.3, undefined);

/*
    maps\_fx::loopfx("gigantor", (2068, 4430, 1514), .3);
    maps\_fx::loopfx("gigantor", (-2843, 4589, 1713), .3);
    maps\_fx::loopfx("gigantor", (-6797, 3303, 1743), .3);
    maps\_fx::loopfx("smokewall", (6228, 773, 700), 4);
    maps\_fx::loopfx("smokewall", (-4018, 4333, 700), 4);

    maps\_fx::loopfx("medFire", (-26, 2618, 1104), 0.3);

    maps\_fx::loopSound("medfire", (-26, 2618, 1104), 7.7);
    maps\_fx::loopfx("wildfire1", (-4375, 309, 240), 0.3);
    maps\_fx::loopfx("wildfire2", (-3714, 1387, 1479), 0.3);
    maps\_fx::loopfx("wildfire1", (-327, 2156, 1079), 0.3);
    maps\_fx::loopfx("wildfire1", (1607, 2139, 1094), 0.3);
    maps\_fx::loopfx("wildfire1", (3314, 1004, 1225), 0.3);
    maps\_fx::loopfx("wildfire1", (4826, -1393, 1110), 0.3);
    maps\_fx::loopfx("wildfire2", (1094, -17805, -42), 0.3);
   // maps\_fx::loopfx("firetest", (355, -16262, 73), 0.3);

   maps\_fx::gunfireLoopfx("waterhit", (-339, -7899, -128),
											      1, 2,
											   1, 5,
										            1, 5);
   maps\_fx::gunfireLoopfx("waterhit", (-3056, -10063, -128),
											      1, 2,
											   1, 5,
										            1, 5);
   maps\_fx::gunfireLoopfx("waterhit", (-4616, -2708, -128),
											      1, 2,
											   1, 5,
										            1, 5);
    
*/
}


/*
TAG_ORIGIN    Not important for effects but is listed for your convenience.
				
TAG_BOW_LEFT      (fx/tagged/tag_bow_left.efx)
TAG_BOW_RIGHT	(fx/tagged/tag_bow_right.efx)
TAG_SMOKESTACK (fx/tagged/tail_smoke.efx)	We will need to tweak this but we should get it in there.
TAG_BACK		(fx/water/em_froth.efx)  we will need to work with this one too.

For the explosion on the barge use fx/explosions/aircraft_down.efx

We need to get some flashes lighting up the areas in the city.  Not overboard like burnville but definitely
get some action going on within the facade areas.  
This will make them look less static and more like a war is going on ALL AROUND not just at the dock.

Tug needs to be lowered into the water.  Currently it is floating on it's keel...centerline.  
The orange band around the tug's exterior bulkhead is the waterline.  
The water line should be visible just above the water.  I have placed a different effect for the stack.  
After looking at this effect I have come to the conclusion that the origin or tag is completely FUBAR.  
I have attempted to adjust for the origin wierdness but it persists. 
Please check your work to insure we've not missed something.  Brad has placed the tags correctly.  
Therefore it's got to be something we've done.  In the effects editor I place the origin at 0,0,0 yet it still is off.  
Any ideas here?

Stukka smoke play em_stukkasmoke.efx (in the fx/smoke) directory, for the smoke replacement.  
I have the fire comming into the effect about 3 seconds into the event.  
Upon impact play fx/explosions/aircraft_down.efx

fx/cannon/missile_launch.efx this is the single rocket launch effect.  Steve thinks there are 6 to 8 per launcher.  
You decide that since the effect is conveniently singular.  
My only concern is it's visibility from the players POV.  I suppose we should just put it in there and find out.  
Impact: use mutha2.efx in the explosions directory.

NOTE: 2D river facades : facade_bargeside.dds (Barge side with silhouetts of crew.)
				 facade_damagedbarge1.dds (A front-right perspective of a damaged barge.)
				 facade_damagedbarge2.dds (A damaged barge tipped on end.)
				 facade_damagedtug1.dds (A damaged tug tipped up with bow in the air.)
  				 facade_tug.dds (A standard and un-damaged tug.)
You can place these at various heights and orientations for effect.  Of course this technique would not work with the un-damaged facades too well.

Flesh_hit5g.efx in directory \fx\impacts for the barge massacre.

For the guy jumping into the water.....splash.efx \fx\water

For the explosions from the soviet rockets try mutha2.efx in fx\explosions

Stukka cannon dirt hit is dirthit_mega.efx in surfacehits.  It's been adapted to be the mg42 or any LARGE b-type hit.  Let's get rid of those cotton ball stukka hits.
Let's replace this with fx/impacts/stukastrafe_dirt.efx

OLD:  created train_smoke.efx it's in the tagged directory.  Should use this for the train smokestack.
OLD:  created metalhit_dramatic in the impacts directory for the metal spark on the barge ride.
NEW:  created the barge and tug "scuttle" smoke (( fx/smoke/scuttled_smoke.efx )) it won't need to be "keyed" as heavily as the train or the smoke stack.  tagsmoke_1 and tagsmoke_2 same effect different tags.  Boon knows the names.


*/
