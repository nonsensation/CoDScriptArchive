//Targeting for MG42s on Panzer IV and Tiger Tanks (forward ball MG42)

/*

Instructions:

1. Create a 'misc_turret' entity in Radiant, with 'model = xmodel/vehicle_tank_panzeriv_machinegun', a targetname, and 'weaponinfo = mg42_panzerIV_tank'
2. MG42 properties are adjustable from turretsettings.gdt, for the mg42_panzerIV_tank type under 'turretweapons.'
3. Take the necessary steps to incorporate a standard Panzer IV tank in the level.
4. Attach the MG42 model and set it to manual mode as shown below ('eMG42', 'eTank' and "tankmg42" can be replaced with any names you chose.)

	eMG42 = getent("tankmg42","targetname");
	eMG42 linkto(eTank, "tag_turret2", (0, 0, 0), (0, 0, 0));
	eMG42 setmode("manual");

5. Start the MG42 action with this line, using variable names of your choosing. 'eStartNode' is optional - it is the node you start moving the tank from;
use it to delay the starting of the firing by some amount of time. The numbers are set ideally for Pegasusday.

	level thread maps\_tankmg42::tank_mg42targeting(eTank, eMG42, eStartNode);

6. If you're using a variable called 'level.nFriendlypop' in your own level script, this could cause bad side effects, because this script uses that.

Threads:

tank_mg42targeting(eTank, eMG42, eStartNode)
tank_mg42cycle(eTank, eMG42, nTarget)
tank_mg42sort(eTank)
tank_mg42fire(eTank, eMG42, nTarget)
tank_mg42burstcontrol(eTank, eMG42, nTarget)

*/

tank_mg42targeting(eTank, eMG42, eStartNode)
{
	eTank endon("death");

	if(isdefined(eStartNode) && isdefined(eStartNode.script_noteworthy))
	{
		/*
		if(eStartNode.script_noteworthy == "threeway")
		{
			wait (20 + randomfloatrange(3.3,5.5));	//no firing for a bit
		}
		if(eStartNode.script_noteworthy == "twoway")
		{
			wait (20 + randomfloatrange(3.3,5.5));	//no firing for a bit
		}
		if(eStartNode.script_noteworthy == "doublezone")
		{
			wait (35 + randomfloatrange(3.3,5.5));	//no firing for a bit
		}
		*/

		switch (eStartNode.script_noteworthy)
		{
			case "threeway":
    				wait (20 + randomfloatrange(3.3,5.5)); //no firing for a bit
    				break;
			case "twoway":
    				wait (20 + randomfloatrange(3.3,5.5)); //no firing for a bit
			    	break;
			case "doublezone":
			    	wait (35 + randomfloatrange(3.3,5.5)); //no firing for a bit
			    	break;
		}
	}

	//If any friendlies are alive, find the closest friendly visible within tank MG42's field of fire

	aFriendlies = getaiarray("allies");
	level.nFriendlypop = aFriendlies.size;
	for(i=0; i<aFriendlies.size; i++)
	{
		if(isdefined(aFriendlies[i]) && isalive(aFriendlies[i]))
		{
			level thread tank_mg42_friendlydeathwaiter(aFriendlies[i]);	//monitor deaths of friendlies
		}
	}

	//Scan friendlies at feet, middle, and head, scan for player similarly, then compare ranges to closest friendly and player and shoot the closer of the two
	//If all friendlies are dead or no friendlies exist, just target the player

	while(isdefined(level.nFriendlypop) && level.nFriendlypop != 0)
	{
		nGunPos = eMG42.origin;
		iCheck = 0;
		iCheckFriendly = 0;
		iCheckPlayer = 0;
		iBaseRange = undefined;

		aFodder = getaiarray("allies");

		for(i=0; i<aFodder.size; i++)
		{
			//scan for low, mid, high point of target

			iHeight = 4;

			for(n=0; n<3; n++)
			{
				//println("Scanning for Friendly.");
				nTargetPos = aFodder[i].origin + (0, 0, iHeight);
				nClearShot = bullettrace(nGunPos, nTargetPos, 1, eMG42);
/*
if(nClearShot["fraction"] < 1.0)
{
	line(nGunPos, nClearShot["position"], (1, 0.5, 0));
	line(nClearShot["position"], nTargetPos, (1, 0, 0), 0.5);
}
else
	line(nGunPos, nClearShot["position"], (0, 1, 0));
*/
				if(nClearShot["fraction"] != 1)
				{
					if(isdefined(nClearShot["entity"]) && isdefined(nClearShot["entity"].script_friendname) && isalive(nClearShot["entity"]) && nClearShot["entity"].ignoreme == false)
					{
						iCheckFriendly = 1;
						break;
					}
				}
				iHeight = iHeight + 44;
			}

			if(iCheckFriendly != 0)
			{
				//println("Located friendly.");

				fRange = lengthSquared(nGunPos - nTargetPos);

				//set an initial range from the first applicable friendly

				if(iCheck == 0)
				{
					iBaseRange = fRange;
					nTarget = aFodder[i];
					iCheck = 1;
				}

				//compare to previous friendly and update, determine the closest friendly target

				if(fRange < iBaseRange)
				{
					iBaseRange = fRange;
					nTarget = aFodder[i];
					//println("Acquired a closer friendly.");
					eMG42 settargetentity(nTarget);
				}
			}
		}

		//Check if a visible player is closer than the closest friendly target

		//scan for low, mid, high point of player

		iPlayerHeight = 4;

		for(n=0; n<3; n++)
		{
			//println("Scanning for Player.");
			nPlayerPos = level.player.origin + (0, 0, iPlayerHeight);
			nClearPlayer = bullettrace(nGunPos, nPlayerPos, 1, eMG42);
/*
if(nClearShot["fraction"] < 1.0)
{
	line(nGunPos, nClearShot["position"], (1, 0.5, 0));
	line(nClearShot["position"], nTargetPos, (1, 0, 0), 0.5);
}
else
	line(nGunPos, nClearShot["position"], (0, 1, 0));
*/
			if(nClearShot["fraction"] != 1)
			{
				if(nClearPlayer["fraction"] != 1 && isdefined(nClearPlayer["entity"]) && nClearPlayer["entity"] == level.player)
				{
					iCheckPlayer = 1;
					//println("iCheckPlayer = ", iCheckPlayer);
					break;
				}
			}
			iPlayerHeight = iPlayerHeight + 44;
		}

		if(iCheckPlayer != 0)
		{
			fPlayerRange = lengthSquared(nGunPos - nPlayerPos);

			if(!isdefined(iBaseRange))
			{
				nTarget = level.player;
				eMG42 settargetentity(nTarget);
				//println("No friendlies in sight. ENGAGING PLAYER");
			}
			else
			if(fPlayerRange < iBaseRange)
			{
				nTarget = level.player;
				eMG42 settargetentity(nTarget);
				//println("Player is closest. ENGAGING PLAYER");
			}
			else
			if(isalive(nTarget) && isdefined(nTarget))
			{
				if(isdefined(nTarget.script_friendname))
				{
					//println("Player is farther. ENGAGING FRIENDLY ", nTarget.script_friendname);
				}
				else
				{
					//println("Player is farther. ENGAGING UNNAMED FRIENDLY ");
				}

				eMG42 settargetentity(nTarget);
			}
		}
		else
		if(iCheckPlayer == 0 && iCheckFriendly == 1)
		{
			if(isalive(nTarget) && isdefined(nTarget))
			{
				if(isdefined(nTarget.script_friendname))
				{
					//println("Player is unavailable. ENGAGING FRIENDLY ", nTarget.script_friendname);
				}
				else
				{
					//println("Player is unavailable. ENGAGING UNNAMED FRIENDLY ");
				}

				eMG42 settargetentity(nTarget);
			}
		}
		else
		if(iCheckPlayer == 0 && iCheckFriendly == 0)
		{
			wait 0.1;
			//println("Can't see player or friendlies. Rescanning for targets.");
			continue;
		}

		level thread tank_mg42cycle(eTank, eMG42, nTarget);
		level thread tank_mg42burstcontrol(eTank, eMG42, nTarget);
		level thread tank_mg42sort(eTank);

		level waittill ("retarget");

		if(isdefined(eTank.targ_org1))
		{
			eTank.targ_org1 delete();
		}
		if(isdefined(eTank.targ_org2))
		{
			eTank.targ_org2 delete();
		}
		if(isdefined(eTank.targ_org3))
		{
			eTank.targ_org3 delete();
		}

		//println("Sorting targets again.");
	}

	for(i=0; i<100; i++)
	{
		//println("ALL FRIENDLIES DEAD - SWITCHING TO PLAYER");
	}

	nTarget = level.player;
	eMG42 settargetentity(nTarget);
	level thread tank_mg42burstcontrol(eTank, eMG42, nTarget);

	if(isdefined(eTank.targ_org1))
	{
		eTank.targ_org1 delete();
	}
	if(isdefined(eTank.targ_org2))
	{
		eTank.targ_org2 delete();
	}
	if(isdefined(eTank.targ_org3))
	{
		eTank.targ_org3 delete();
	}

	level thread tank_mg42cycle(eTank, eMG42, nTarget);
}

tank_mg42cycle(eTank, eMG42, nTarget)
{
	//Creates phantom target points for the tank's MG42 so it 'sweeps' from feet to head to improve chance of a hit, and also keeps it from being too perfect
	//if the player is hiding in a window or other partial cover.

	eTank endon ("death");
	level endon ("retarget");
	nTarget endon ("death");

	eTank.targ_org1 = spawn ("script_origin", (0,0,0));
	eTank.targ_org2 = spawn ("script_origin", (0,0,0));
	eTank.targ_org3 = spawn ("script_origin", (0,0,0));
	eTank.targ_org4 = spawn ("script_origin", (0,0,0));
	eTank.targ_org5 = spawn ("script_origin", (0,0,0));
	eTank.targ_org6 = spawn ("script_origin", (0,0,0));

	while(1)
	{
		eTank.targ_org1.origin = nTarget.origin + (0,0,4);
		eTank.targ_org2.origin = nTarget.origin + (0,0,14);
		eTank.targ_org3.origin = nTarget.origin + (0,0,24);
		eTank.targ_org4.origin = nTarget.origin + (0,0,34);
		eTank.targ_org5.origin = nTarget.origin + (0,0,44);
		eTank.targ_org6.origin = nTarget.origin + (0,0,54);

		eMG42 settargetentity(eTank.targ_org1);
		wait 0.1;
		eMG42 settargetentity(eTank.targ_org2);
		wait 0.1;
		eMG42 settargetentity(eTank.targ_org3);
		wait 0.1;
		eMG42 settargetentity(eTank.targ_org4);
		wait 0.1;
		eMG42 settargetentity(eTank.targ_org5);
		wait 0.1;
		eMG42 settargetentity(eTank.targ_org6);
		wait 0.1;
	}
}

tank_mg42sort(eTank)
{
	//Engage target for some time, then send notifications to update all available targets

	eTank endon("death");

	//println("STARTING NEW CYCLE");

	wait 2.88;
	level notify("recycle");
	wait 0.1;
	level notify("retarget");
}

tank_mg42fire(eTank, eMG42, nTarget)
{
	//fires one bullet per loop

	level endon("stopburst");
	level endon("recycle");
	eTank endon("death");

	fFirerate = 0.05;

	while(1)
	{
			eMG42 shootturret();
			wait fFirerate;
	}
}

tank_mg42burstcontrol(eTank, eMG42, nTarget)
{
	//activates firing and regulates bursts

	eTank endon("death");
	level endon("recycle");

	while(1)
	{
		eMG42 thread tank_mg42fire(eTank, eMG42, nTarget);
		wait (0.23 + randomfloat(0.9));	//burst length
		level notify ("stopburst");
		wait (0.4 + randomfloat(0.6));	//pause between bursts
	}
}

tank_mg42_friendlydeathwaiter(nSoldier)
{
	nSoldier waittill ("death");
	level.nFriendlypop--;
}