// ----------------------------------------------------------------------------------
//	Initialize
//
// 		Sets up defaults for all of the values
// ----------------------------------------------------------------------------------
Initialize()
{
	// set up the points
	if(!isdefined(game["sec_defaultteam"]))	// what team holds the single secondary objective at start
		game["sec_defaultteam"] = "neutral";
}

// ----------------------------------------------------------------------------------
//	Precache
//
// 		Precaches anything needed for secondary objectives
// ----------------------------------------------------------------------------------
Precache()
{
	precacheString(&"GMI_MP_ALLIES_DESTROY_OBJECTIVE_TAKEN");
	precacheString(&"GMI_MP_AXIS_DESTROY_OBJECTIVE_TAKEN");
	precacheString(&"GMI_MP_ALLIES_HOLD_OBJECTIVE_TAKEN");	
	precacheString(&"GMI_MP_AXIS_HOLD_OBJECTIVE_TAKEN");	
	precacheString(&"GMI_MP_CAPTURING_SECONDARY_SPAWN");	

	precacheShader("gfx/hud/hud@neutralobjective.dds");
	precacheShader("gfx/hud/hud@neutralobjective_up.dds");
	precacheShader("gfx/hud/hud@neutralobjective_down.dds");
	precacheShader("gfx/hud/hud@alliesobjective.dds");
	precacheShader("gfx/hud/hud@alliesobjective_up.dds");
	precacheShader("gfx/hud/hud@alliesobjective_down.dds");
	precacheShader("gfx/hud/hud@axisobjective.dds");
	precacheShader("gfx/hud/hud@axisobjective_up.dds");
	precacheShader("gfx/hud/hud@axisobjective_down.dds");
}

// ----------------------------------------------------------------------------------
//	SetupSecondaryObjectives
//
// 		This determines which type of secondary objectives there are in the 
//		map and sets them up appropriately.  You should call this function as
//		its own thread.
// ----------------------------------------------------------------------------------
SetupSecondaryObjectives()
{
	// sets up the destroy type secondary objective
	if(isdefined(getent("allied_objective_trigger", "targetname")))
	{
		SetupDestroyObjective( "allied_objective_trigger", "gfx/hud/hud@alliesobjective.tga",
					"allied_target_before", "allied_target_after", 14 );
		thread MonitorDestroyObjective( "allied_objective_trigger",
					"allied_target_before", "allied_target_after", "allies", 14 );
	}
	
	if(isdefined(getent("axis_objective_trigger", "targetname")))
	{
		SetupDestroyObjective( "axis_objective_trigger", "gfx/hud/hud@axisobjective.tga",
					"axis_target_before", "axis_target_after", 15 );
		thread MonitorDestroyObjective( "axis_objective_trigger",
					"axis_target_before", "axis_target_after", "axis", 15 );
	}
	if(isdefined(getent("objective_trigger", "targetname")))
	{
		SetupHoldObjective( "objective_trigger", 14, game["sec_defaultteam"] );
		getent("objective_trigger", "targetname") thread MonitorHoldObjective( 14 );
	}
}

// ----------------------------------------------------------------------------------
//	SetupDestroyObjective
//
//		Adds the objective to the radar.  Also turns on all before destroyed parts
//		and turns off after destroyed parts.
// ----------------------------------------------------------------------------------
SetupDestroyObjective(triggername,radaricon, beforeparts, afterparts, objectivenum)
{
	target_before = getentarray (beforeparts,"targetname");
	target_after = getentarray (afterparts,"targetname");

	obj_ent = getent(triggername, "targetname");
	objective_add(objectivenum, "current", obj_ent.origin, radaricon);
	obj_ent.team = neutral;
	
	for (i=0;i<target_after.size;i++)
		target_after[i] hide();

	for (i=0;i<target_before.size;i++)
		target_before[i] show();
}

// ----------------------------------------------------------------------------------
//	MonitorDestroyObjective
//
//		Checks to see if the destroy objective has been destroyed
// ----------------------------------------------------------------------------------
MonitorDestroyObjective(triggername, beforeparts, afterparts, team, objectivenum)
{
	if(game["matchstarted"] == true)
	{
		while ( !level.roundstarted )
		{
			wait(0.1);
		}
		
		trigger = getent(triggername, "targetname");
		
		trigger waittill("trigger", other);

		// if we get here then the objective has been destroyed
		target_before = getentarray (beforeparts,"targetname");
		target_after = getentarray (afterparts,"targetname");

		// turn on anything in the target after list
		for (i=0;i<target_after.size;i++)
			target_after[i] show();
	
		// remove everything from the target before list
		for (i=0;i<target_before.size;i++)
			target_before[i] delete();
			
		trigger.team = other.team;
		
		// go through all of the players
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			
			//JS play the sound on all players of the same team.  NOTE!  This needs to be made to determine which Allied nationality!
			if(player.pers["team"] == team)
				player playLocalSound("sec_obj_complete");
		}

		if ( team == "allies" )
		{
			// display the appropriate message to the players
			iprintln(&"GMI_MP_ALLIES_DESTROY_OBJECTIVE_TAKEN", other);	
		}
		else
		{
			// display the appropriate message to the players
			iprintln(&"GMI_MP_AXIS_DESTROY_OBJECTIVE_TAKEN", other);	
		}

		// give the person who did it points
		other.pers["score"] += game["br_points_objective"];
		other.score = other.pers["score"];

		objective_delete(objectivenum);
	}
}

// ----------------------------------------------------------------------------------
//	SetupHoldObjective
//
//		Adds the objective to the radar.
// ----------------------------------------------------------------------------------
SetupHoldObjective(triggername, objectivenum, team)
{
	obj_ent = getent(triggername, "targetname");
	
	if ( !isDefined(team) )
		team = "neutral";
		
	obj_ent.team = team;
	obj_ent.allies = 0;
	obj_ent.axis = 0;
	obj_ent.progresstime = 0;
	obj_ent.axis_capping = 0;
	obj_ent.allies_capping = 0;
	obj_ent.capping = 0;
	obj_ent.last_capping = 0;
	obj_ent.cap_speed_mod = 0.5;
	obj_ent.scale = 0;
	obj_ent.yellow = 0;
	obj_ent.beingcapped = false;

	// this should default to a neutral
	radaricon = "gfx/hud/hud@neutralobjective.dds";
	turnon_stuff = "objstuff_neutral";
	turnoff_stuff_1 = "objstuff_allies";
	turnoff_stuff_2 = "objstuff_axis";
	
	// setup the default variables to the correct team
	if ( team  == "allies" )
	{
		radaricon = "gfx/hud/hud@alliesobjective.dds";
		turnon_stuff = "objstuff_allies";
		turnoff_stuff_1 = "objstuff_neutral";
	}
	else if ( team == "axis" )
	{
		radaricon = "gfx/hud/hud@axisobjective.dds";
		turnon_stuff = "objstuff_axis";
		turnoff_stuff_2 = "objstuff_neutral";
	}
	
	// set up the objective
	objective_add(objectivenum, "current", obj_ent.origin, radaricon);
	
	// now see if we can find any props that need to be turned off 
	props = getentarray(turnoff_stuff_1, "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray(turnoff_stuff_2, "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] hide();
	}

	// now see if we can find any props that need to be turned on 
	props = getentarray(turnon_stuff, "targetname");
	for ( i = 0; i < props.size; i++ )
	{
		props[i] show();
	}
	
}

// ----------------------------------------------------------------------------------
//	MonitorHoldObjective
//
//		Checks to see if the hold objective has been taken
// ----------------------------------------------------------------------------------
MonitorHoldObjective(objectivenum)
{
	if(!isdefined(self.script_timer))
		self.script_timer = 10;

	count = 1;
	
	for(;;)
	{
		if(self.capping == 0 || level.roundended)
		{
			self CaptureCanceled();
			self waittill("trigger", other);		
		}

		if(game["matchstarted"] == false)
		{
			count -= 1;
			if(count == 0)
			{
				iprintln(&"GMI_DOM_WAIT_TILL_MATCHSTART");
				count = 100;
			}
			wait 0.05;
			continue;
		}

		// zero out the flag capping count
		self.capping = 0;
		self.allied_capping = 0;
		self.axis_capping = 0;
		
		players = getentarray("player", "classname");
		
		// count up the people in the objective area
		for(i = 0; i < players.size; i++)
		{
			player = players[i];

			if(isalive(player) && player istouching(self))
			{
				if(player.pers["team"] == "allies")
				{
					self.allied_capping++;
				}
				else if(player.pers["team"] == "axis")					
				{
					self.axis_capping++;		
				}
			}
		}
		
		self.capping = self.allied_capping - self.axis_capping;	
	
		// set this variable if only one team is currently trying to cap
		one_team = 0;
		if ( self.allied_capping == 0 || self.axis_capping == 0 )
		{ 
			if ( self.allied_capping != 0 && self.team != "allies" )
			{
				one_team = 1;
			}
			else if ( self.axis_capping != 0 && self.team != "axis" )
			{
				one_team = 1;
			}
		}
		
		// is only one team trying to cap?
		if ( one_team )
		{
			// now each player need to have their capture progress bar started
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
	
				if(isalive(player) && player istouching(self))
				{
					if(!isdefined(player.pers["capture_process_thread"]))
						player.pers["capture_process_thread"] = 0;
	
					// if this flag is set then the player is currently already displaying the flag info
					if (player.pers["capture_process_thread"] == 1)
						continue;
						
					player.pers["capture_process_thread"] = 1;
					player thread PlayerCappingObjective(self);
				}
			}
	
			self.beingcapped = true;
			
			if (self.capping > 0)
			{
				self.progresstime += (0.05) * ((1 + (self.capping - 1) * self.cap_speed_mod ));
				if(self.capping == 1)
				{
					name = other;
				}
			}
			else if (self.capping < 0)
			{
				self.progresstime +=  (0.05) * ((1 + (-1 * self.capping - 1) * self.cap_speed_mod ));
				if(self.capping == -1)
				{
					name = other;
				}
			}

			self.scale = (self.progresstime / self.script_timer);
		}
		else
		{
			self CaptureCanceled();
			wait 0.05;
		}	
		
		self.last_capping = self.capping;
		if(self.scale >= 0.999)
		{
			self CaptureCanceled();
	

			if(self.capping > 0)
			{
				cappers = self.capping;
				SetupHoldObjective( self.targetname, objectivenum, "allies" );
				other.pers["score"] += game["br_points_objective"];
				other.score = other.pers["score"];
				iprintln(&"GMI_MP_ALLIES_HOLD_OBJECTIVE_TAKEN");	//JS- let the people in the game know the objective has changed hands
			}
			else
			{
				cappers = self.capping;
				SetupHoldObjective( self.targetname, objectivenum, "axis" );
				other.pers["score"] += game["br_points_objective"];
				other.score = other.pers["score"];
				iprintln(&"GMI_MP_AXIS_HOLD_OBJECTIVE_TAKEN");	//JS- let the people in the game know the objective has changed hands	
			}
		}
		wait 0.05;
	}
}

// ----------------------------------------------------------------------------------
//	CaptureCanceled
//
// 		Called when the hold objective capture is canceled for any reason
// ----------------------------------------------------------------------------------
CaptureCanceled()
{
	if ( self.beingcapped == false )
		return;
		
	self.beingcapped = false;
	self.yellow = 0;

	if (isdefined(self.progresstext))
	{
		self.progresstext destroy();
	}
	if (isdefined(self.progressbar))
	{
		self.progressbar destroy();
	}
	if (isdefined(self.progressbackground))
	{
		self.progressbackground destroy();
	}
	self.progresstime = 0;
	self.scale = 0;

	if(isdefined(self.capping_icon))
	{
		self.capping_icon destroy();
	}
}

// ----------------------------------------------------------------------------------
//	PlayerCappingObjective
//
// 		Gets called when a player starts capping the objective.  This displays the 
//		progress bar.
// ----------------------------------------------------------------------------------
PlayerCappingObjective(objective)
{
	InitProgressbar(self);
		
	barsize = maps\mp\_util_mp_gmi::get_progressbar_maxwidth();
	height = maps\mp\_util_mp_gmi::get_progressbar_height();

	// loop until done displaying the progress bar
	// dump out if:
	//	1: Not touching the objective anymore
	//	2: not alive
	//	3: There are both teams in the flag area
	//	4: Your team is the same as the flag team.
	//	5: You are a spectator
	while((level.roundstarted == true)
		&& self istouching(objective) 
		&& isalive(self) 
		&& ((objective.axis_capping == 0) || (objective.allied_capping == 0))
		&& self.pers["team"] != objective.team 
		&& self.pers["team"] != "spectator")
	{
		if (objective.scale > 0)
		{
			self.progressbar setShader("white", objective.scale * barsize, height);
		}
		wait .01;
	}

	// we are done so destroy the progress bars
	if (isdefined(self.progresstext))
	{
		self.progresstext destroy();
	}
	if (isdefined(self.progressbar))
	{
		self.progressbar destroy();
	}
	if (isdefined(self.progressbackground))
	{
		self.progressbackground destroy();
	}
	
	self.view_bar = 0;
	self.pers["capture_process_thread"] = 0;
}

// ----------------------------------------------------------------------------------
//	GetSecondaryTriggers
//
// 		Returns an array of secondary triggers belonging to team.
// ----------------------------------------------------------------------------------
GetSecondaryTriggers(team)
{
	array = [];
	
	if (!isDefined(team))
	{
		team = "neutral";
	}
	
	trigger = getent("objective_trigger", "targetname");
	// get the objective trigger
	if(isdefined(trigger) && isDefined(trigger.team) && team == trigger.team)
	{
		array[array.size] = getent("objective_trigger", "targetname");
	}
	if(isdefined(getent("allied_objective_trigger", "targetname")) && team == "allies")
	{
		array[array.size] = getent("allied_objective_trigger", "targetname");
	}
	
	if(isdefined(getent("axis_objective_trigger", "targetname")) && team == "axis")
	{
		array[array.size] = getent("axis_objective_trigger", "targetname");
	}

	return array;
}

// ----------------------------------------------------------------------------------
//	InitProgressbar
//
// 		Sets up the flag capture progress bar on the passed in player
// ----------------------------------------------------------------------------------
InitProgressbar(player)
{
	if(isdefined(player.progressbackground))
	{					
		player.progressbackground destroy();
	}
	if(isdefined(player.progressbar))
	{					
		player.progressbar destroy();
	}
	if(isdefined(player.progresstext))
	{					
		player.progresstext destroy();
	}
	
	player.progresstext = maps\mp\_util_mp_gmi::get_progressbar_text(player,&"GMI_MP_CAPTURING_SECONDARY_SPAWN");
		
	// background
	player.progressbackground=  maps\mp\_util_mp_gmi::get_progressbar_background(player);

	// foreground
	player.progressbar = maps\mp\_util_mp_gmi::get_progressbar(player);
	player.view_bar = 1;	
}
