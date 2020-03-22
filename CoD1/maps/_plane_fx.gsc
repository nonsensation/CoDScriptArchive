main()
{
	precacheFX();
}

precacheFX()
{



	// For when the stukas shoots dirt or water
 	level._effect["stuka dirt"]	= loadfx ("fx/impacts/stukastrafe_dirt.efx");
	level._effect["stuka water hit"] = loadfx ("fx/impacts/waterhit_large.efx");

	// Effect that plays when the MG42s are trying to shoot you (on the ground).
	// Also plays on AI when they die scripted deaths (like a dust hit).
  	level._effect["ground"]	= loadfx ("fx/impacts/small_gravel.efx");

	// Big version of that effect, used for AI bullet hits.
  	level._effect["big ground"]	= loadfx ("fx/impacts/large_gravel.efx");

	// Mg42 effects from the planes
	level.mg42_effect = loadfx ("fx/muzzleflashes/mg42hv.efx");
	level.mg42_effect2 = loadfx ("fx/muzzleflashes/mg42hv_nosmoke.efx");

//	level.mg42_effect = loadfx ("fx/surfacehits/mortarImpact.efx");
	level._effect["explosion"] = loadfx ("fx/explosions/explosion1_beach.efx");

		// Barge and plane explosion effect, barge_explosion might be being used for the plane dying too.
	level._effect["barge_explosion"] = loadfx ("fx/explosions/aircraft_down.efx");
	level._effect["stuka explosion"] = loadfx ("fx/explosions/aircraft_down.efx");
}

