// this is called when an AI is at a generic cover node and is waiting until time to pop out
// it will usually spend multiple seconds in this script, but can kill it at any time

#using_animtree ("generic_human");

main()
{
    self trackScriptState( "Hide Main", "code" );
	self endon("killanimscript");

	//Just experimenting with hide

	// If I'm wounded, I'll just have a rest
	if (self.anim_pose == "wounded")
	{
		self animscripts\wounded::rest("hide::main");
	}

	self [[anim.SetPoseMovement]]("crouch","stop");
	if ( self.anim_alertness == "aiming" )
		animscripts\aim::keep_aiming();
	else
	{	
		for (;;)
		{	
			self setflaggedanimknoball("_hidedone", %hideLowWall_1, %body, 1, .2, 1);
			self waittill ("_hidedone");
			
			self setflaggedanimknoball("_hidedone", %hideLowWall_2, %body, 1, .2, 1);
			self waittill ("_hidedone");
		}
	}
	//	animscripts\aim::main();
}
