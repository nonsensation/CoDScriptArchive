// ladder_up.gsc
// Climbs a ladder of any height by using a looping animation, and gets off at the top.

#using_animtree ("generic_human");

main()
{
	// do not do code prone in this script
	self.desired_anim_pose = "crouch";
	animscripts\utility::UpdateAnimPose();
	
	self endon("killanimscript");
	self traverseMode("nogravity");
	self traverseMode("noclip");

	climbAnim = %ladder_climbup;
	endAnim = %ladder_climboff;

	self setFlaggedAnimKnoballRestart("climbanim",climbAnim, %body, 1, .1, 1);

	endAnimDelta = GetMoveDelta (endAnim, 0, 1);
	endPos = self getnegotiationendpos() - endAnimDelta + (0,0,1);	// 1 unit padding
	cycleDelta = GetMoveDelta (climbAnim, 0, 1);
	climbRate = cycleDelta[2] /  getanimlength(climbAnim);
	/#[[anim.println]]("ladder_up: about to start climbing.  Height to climb: " + (endAnimDelta[2] + endPos[2] - self.origin[2]) );#/

	climbingTime = ( endPos[2] - self.origin[2] ) / climbRate;

	self animscripts\shared::DoNoteTracksForTime(climbingTime, "climbanim");
	self setFlaggedAnimKnoballRestart("climbanim",endAnim, %body, 1, .1, 1);
	self animscripts\shared::DoNoteTracks("climbanim");
	self traverseMode("gravity");
	self.anim_movement = "run";
	self.anim_pose = "crouch";
	self.anim_alertness = "alert";
	self setAnimKnobAllRestart(self.anim_crouchrunanim, %body, 1, 0.1, 1);
	/#[[anim.println]]("ladder_up: all done");#/
}

