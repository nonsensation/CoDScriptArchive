// ----------------------------------------------------------------------------------
//	InitSpawnPoints
//
// 		Registers all of the spawn points
// ----------------------------------------------------------------------------------
InitSpawnPoints(spawnpointname, error_out, dont_drop_to_ground)
{
	spawnpoints = getentarray(spawnpointname, "classname");
	
	if(!spawnpoints.size && isDefined(error_out) && error_out)
	{
		println("Map must contain some spawnpoints of type " + spawnpointname);

		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return false;
	}

	if ( !isdefined(dont_drop_to_ground) || !dont_drop_to_ground )
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			// if the nodestate is set to 1 then do not drop to ground
			if ( isDefined(spawnpoints[i].script_nodestate) && spawnpoints[i].script_nodestate == 1 )
				continue;
				
			spawnpoints[i] placeSpawnpoint();
		}
	}
		
	return true;
}

/*
//	DEBUG STUFF for testing

GMI_box(pointA,pointB)
{
	topL = (pointA[0],pointA[1],pointA[2]);
	topR = (pointB[0],pointA[1],pointA[2]);
	botR = (pointB[0],pointB[1],pointB[2]);
	botL = (pointA[0],pointB[1],pointB[2]);
	line (topL,topR, (1,1,1), 1);
	line (topL,botL, (1,1,1), 1);
	line (botR,topR, (1,1,1), 1);
	line (botL,botR, (1,1,1), 1);
}

GMI_Circle(origin,rad,color)
{
	angle = 0;
	for (q=0;q<36;q++)
	{
		x = sin(angle) * rad;
		y = cos(angle) * rad;

		angle = angle + 10;

		x1 = sin(angle) * rad;
		y1 = cos(angle) * rad;

		pos = (origin[0] - x,origin[1]-y,origin[2]);
		pos1 = (origin[0] - x1,origin[1]-y1,origin[2]);
		line (pos,pos1, color, 1);
	}
}

GMI_Marker(a,b,color,rad)
{
	timer = gettime()+10000;
	while(timer>gettime())
	{
		if (isdefined(b))
			GMI_box(a,b);
		else
			GMI_Circle(a,50,color);
		
		wait(0.05);
	}
}
*/

GMI_distance_sort(point,array)
{

	newarray = [];

	//	first we calculate how far each one is from point
	for(i=0;i<array.size;i++)
	{
		newarray[newarray.size] = array[i];

		if (isdefined(newarray[i].origin))
			newarray[i].distance = distance(newarray[i].origin,point);
		else
		{
			println("something in this array doesn't have an origin");
			println("BAILING");
			return;			
		}
	}
	// Sort them in order
	for(i = 0; i < newarray.size; i++)
	{
		for(j = i; j < newarray.size; j++)
		{
			if(newarray[i].distance > newarray[j].distance)
			{
				temp = newarray[i];
				newarray[i] = newarray[j];
				newarray[j] = temp;
			}
		}
	}
	return(newarray);
}


GMI_SpawnLogic(team,spawns)
{
	players = getentarray("player", "classname");
	axis_players = [];
	allied_players = [];

	
	//	we need to calc a bounding box around the teams

	axMaxX = 0;
	axMinX = axMaxX;
	axMaxY = 0;
	axMinY = axMaxY;
	axMaxZ = 0;
	axMinZ = axMaxZ;

	alMaxX = 0;
	alMinX = alMaxX;
	alMaxY = 0;
	alMinY = alMaxY;
	alMaxZ = 0;
	alMinZ = alMaxZ;

	for(i = 0; i < players.size; i++)
	{
		player = players[i];
				
		if(player.sessionstate == "spectator" || player.sessionstate == "dead" || player == self)
		{
			continue;
		}


		if (players[i].pers["team"] == "axis")
		{
			axis_players[axis_players.size] = player;
			if (player.origin[0] > axMaxX)
				axMaxX = player.origin[0];
			if (player.origin[1] > axMaxY)
				axMaxY = player.origin[1];
			if (player.origin[2] > axMaxZ)
				axMaxZ = player.origin[2];

			if (player.origin[0] < axMinX)
				axMinX = player.origin[0];
			if (player.origin[1] < axMinY)
				axMinY = player.origin[1];
			if (player.origin[2] < axMinZ)
				axMinZ = player.origin[2];
		}
		else
		{
			allied_players[axis_players.size] = player;

			if (player.origin[0] > alMaxX)
				alMaxX = player.origin[0];
			if (player.origin[1] > alMaxY)
				alMaxY = player.origin[1];
			if (player.origin[2] > alMaxZ)
				alMaxZ = player.origin[2];

			if (player.origin[0] < alMinX)
				alMinX = player.origin[0];
			if (player.origin[1] < alMinY)
				alMinY = player.origin[1];
			if (player.origin[2] < alMinZ)
				alMinZ = player.origin[2];
		}
	}

	alliesMin = (alMinX,alMinY,alMinZ);
	alliesMax = (alMaxX,alMaxY,alMaxZ);
	iprintln("allies");
	iprintln(alliesMin);
	iprintln(alliesMax);

	axisMin = (axMinX,axMinY,axMinZ);
	axisMax = (axMaxX,axMaxY,axMaxZ);
	iprintln("axis");
	iprintln(axisMin);
	iprintln(axisMax);

	axisMiddle = (	axisMin[0] + ((axisMax[0] - axisMin[0])/2),
		 	axisMin[1] + ((axisMax[1] - axisMin[1])/2),
		 	axisMin[2] + ((axisMax[2] - axisMin[2])/2));


	alliesMiddle = (alliesMin[0] + ((alliesMax[0] - alliesMin[0])/2),
		 	alliesMin[1] + ((alliesMax[1] - alliesMin[1])/2),
		 	alliesMin[2] + ((alliesMax[2] - alliesMin[2])/2));

	pick_spawns = [];
	
	if (isdefined(spawns))
	{
		near_allied_spawns = 	GMI_distance_sort(alliesMiddle,spawns);
		near_axis_spawns =	GMI_distance_sort(axisMiddle,spawns);

		println(near_allied_spawns.size);
		println(near_axis_spawns.size);

		if (isdefined(near_allied_spawns))
		{
			size = near_allied_spawns.size;
			if (size>5) size = 5;

			for (q=0;q<size;q++)
			{
				pick_spawns[pick_spawns.size] = near_allied_spawns[q];
			}
		}

		if (isdefined(near_axis_spawns))
		{
			size = near_axis_spawns.size;
			if (size>5) size = 5;

			for (q=0;q<size;q++)
			{
				pick_spawns[pick_spawns.size] = near_axis_spawns[q];
			}
		}
	}


	if (isdefined(pick_spawns))
	{
		while(pick_spawns.size<10)
		{
			pick_spawns[pick_spawns.size] = spawns[randomint(spawns.size)];	//	just pick a random spot 
		}

		for (q=0;q<pick_spawns.size;q++)	
		{
			println("pick spawn ",q," ",pick_spawns[q].origin);
		}
		spawnpoint = pick_spawns[randomint(pick_spawns.size)];
	}
	return(spawnpoint);
}

