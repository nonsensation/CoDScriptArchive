getSpawnpoint_Random(spawnpoints)
{
//	level endon("intermission");

	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

	for(i = 0; i < spawnpoints.size; i++)
	{
		j = randomInt(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}
	 
//	for(j = 0; j < spawnpoints.size; j++)
//	{
//		println("^6origin" , j, " is ", spawnpoints[j].origin);
//	}

	for(i = 0; i < spawnpoints.size; i++)
	{
		spawnpoint = spawnpoints[i];
		if(!positionWouldTelefrag(spawnpoint.origin))
			break;
	}

	return spawnpoint;
}

// Picks a non-telefragging spawn point farthest from other players
getSpawnpoint_Farthest(spawnpoints)
{
//	level endon("intermission");
	
	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

// TEMP DISABLED SPAWNING AWAY FROM PLAYERS
/*
	// Make a list of fully connected, non-spectating, alive players
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(player.sessionstate == "spectator" || player.sessionstate == "dead" || player == self)
		{
//			println("### ", player.name, " not considered:");
//			
//			println("    player.sessionstate == ", player.sessionstate);
//			
//			if(player == self)
//				println("    player == self");
				
			continue;
		}

		positions = addorigin_to_array(positions, player);
//		println("*** ", player.name, " added to consider list");
	}
*/
	if(isdefined(level.deatharray))
	{
		if(!isdefined(positions))
		{
			positions[0] = level.deatharray[0];

			for(i = 1; i < level.deatharray.size; i++)
				positions[positions.size] = level.deatharray[i];
		}
		else
		{
			for(i = 0; i < level.deatharray.size; i++)
				positions[positions.size] = level.deatharray[i];
		}
	}	

	// Spawn away from players if they exist, otherwise spawn at a random spawnpoint
	if(isdefined(positions))
	{
//		println("*** SPAWNING FARTHEST: ", self.name);
		
		distsmallest = 33554432;
	
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(positionWouldTelefrag(spawnpoints[i].origin))
				continue;

			dist = 0;
		
			for(j = 0; j < positions.size; j++)
			{
				dist += 1.0 / (distance(spawnpoints[i].origin, positions[j]) + 1.0);
			}
		
			if(dist < distsmallest)
			{
				distsmallest = dist;
				bestposition = spawnpoints[i];
			}
		}
		
		spawnpoint = bestposition;
	}
	else
	{
//		println("*** SPAWNING RANDOM: ", self.name);
		spawnpoint = getSpawnpoint_Random(spawnpoints);
	}

	return spawnpoint;
}

getSpawnpoint_NearTeam(spawnpoints)
{
//	level endon("intermission");

	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

	// Make a list of fully connected, non-spectating, alive players
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(player.sessionstate == "spectator" || player.sessionstate == "dead" || player == self)
		{
//			println("### ", player.name, " not considered:");
//			
//			println("    player.sessionstate == ", player.sessionstate);
//
//			if(player == self)
//				println("    player == self");
				
			continue;
		}

		aliveplayers = add_to_array(aliveplayers, player);
//		println("*** ", player.name, " on team ", player.pers["team"], " added to consider list");
	}

	// Spawn away from players if they exist, otherwise spawn at a random spawnpoint
	if(isdefined(aliveplayers))
	{
//		println("*** SPAWNING FARTHEST: ", self.name);

		distlargest = -33554432;

		for(i = 0; i < spawnpoints.size; i++)
		{
			if(positionWouldTelefrag(spawnpoints[i].origin))
				continue;
				
			dist = 0;

			for(j = 0; j < aliveplayers.size; j++)
			{
				if(aliveplayers[j].pers["team"] == self.pers["team"])
					dist = dist - (distance(spawnpoints[i].origin, aliveplayers[j].origin) * 2);
				else
					dist = dist + distance(spawnpoints[i].origin, aliveplayers[j].origin);
			}

			if(dist > distlargest)
			{
				distlargest = dist;
				bestposition = spawnpoints[i];
			}
		}

		spawnpoint = bestposition;
	}
	else
	{
//		println("*** SPAWNING RANDOM: ", self.name);
		spawnpoint = getSpawnpoint_Random(spawnpoints);
	}
	
	return spawnpoint;
}

// Returns the spawn point closest to the passed in position.
NearestSpawnpoint(aeSpawnpoints, vPosition)
{
	eNearestSpot = aeSpawnpoints[0];
	fNearestDist = distance(vPosition, aeSpawnpoints[0].origin);
	for(i = 1; i < aeSpawnpoints.size; i++)
	{
		fDist = distance(vPosition, aeSpawnpoints[i].origin);
		if(fDist < fNearestDist)
		{
			eNearestSpot = aeSpawnpoints[i];
			fNearestDist = fDist;
		}
	}
	
	return eNearestSpot;
}

getSpawnpoint_SemiRandom(spawnpoints)
{
//	level endon("intermission");

	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

	// Make a list of fully connected, non-spectating, alive players
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(player.sessionstate == "spectator" || player.sessionstate == "dead" || player == self)
			continue;
		aliveplayers = add_to_array(aliveplayers, player);
	}

	// Spawn away from players if they exist, otherwise spawn at a random spawnpoint
	if(isdefined(aliveplayers))
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(positionWouldTelefrag(spawnpoints[i].origin))
				continue;

			for(j = 0; j < aliveplayers.size; j++)
			{
				if ( (aliveplayers[j].pers["team"] != self.pers["team"]) && (distance(spawnpoints[i].origin, aliveplayers[j].origin) > 2000) )
				{
					semirandomspawns = add_to_array(semirandomspawns, spawnpoints[i]);
					continue;
				}
			}
		}
		if (isdefined(semirandomspawns))
		{
			spawnpoint = getSpawnpoint_Random(semirandomspawns);
		}
		else
		{
			for(i = 0; i < spawnpoints.size; i++)
			{
				if(positionWouldTelefrag(spawnpoints[i].origin))
					continue;
	
				for(j = 0; j < aliveplayers.size; j++)
				{
					if ( (aliveplayers[j].pers["team"] != self.pers["team"]) && (distance(spawnpoints[i].origin, aliveplayers[j].origin) > 1000) )
					{
						semirandomspawns = add_to_array(semirandomspawns, spawnpoints[i]);
						continue;
					}
				}
			}
			if (isdefined(semirandomspawns))
				spawnpoint = getSpawnpoint_Random(semirandomspawns);
			else
				spawnpoint = getSpawnpoint_Random(spawnpoints);
		}
	}
	else
	{
//		println("*** SPAWNING RANDOM: ", self.name);
		spawnpoint = getSpawnpoint_Random(spawnpoints);
	}
	
	return spawnpoint;
}

getSpawnpoint_MiddleThird(spawnpoints)
{
	//This scores spawnpoints based on where the enemy is and where people just died.
	//It then throws out the best 1/3 and worst 1/3 spawn points and spawns you at random
	//Using the middle 1/3 rated spawn points.
	
//	level endon("intermission");
	
	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

	// Make an array "badspot" of axis players
	players = getentarray("player", "classname");
	axiscount = -1;
	for(i = 0; i < players.size; i++)
	{
		if(players[i].sessionstate == "spectator" || players[i].sessionstate == "dead" || players[i] == self)
			continue;
		
		if (players[i].pers["team"] != self.pers["team"])
		{
			axiscount++;
			//badspot = add_to_array(badspot, (players[i].origin[0],players[i].origin[1],(players[i].origin[2] * 3)));
			badspot = add_to_array(badspot, (players[i].origin));
		}
	}
	
	// Add the death array to the array "badspot"
	if ( (isdefined(level.deatharray)) && (isdefined(level.deatharray[0])) )
	{
		for (i=0;i<level.deatharray.size;i++)
			badspot = add_to_array(badspot, level.deatharray[i]);
	}
	
	// Give each spawn point a rating
	// Their score is the distance to the closest badspot
	if ( (isdefined (badspot)) && (isdefined (badspot[0])) )
	{	
		for (i=0;i<spawnpoints.size;i++)
		{
			closest = 1000000;
			if(positionWouldTelefrag(spawnpoints[i].origin))
			{
				//println ("THIS SPAWNPOINT WILL TELEFRAG!!!");
				spawnpoints[i].spawnscore = (-1);
				continue;
			}
			
			spawnpoints[i].spawnscore = 0;
			
			for(j = 0; j < badspot.size; j++)
			{
				distancescore = distance((spawnpoints[i].origin[0],spawnpoints[i].origin[1],(spawnpoints[i].origin[2] * 5)), (badspot[j][0],badspot[j][1],(badspot[j][2] * 5)));
				if (j > axiscount) // THIS IS A DEATH BADSPOT - CAN BE WEIGHTED DIFFERENTLY
					distancescore = (distancescore * 4);
				
				if (distancescore < closest)
					closest = distancescore;
			}
			spawnpoints[i].spawnscore = closest;
		}
		
		// Every spawn point has a score now
		
		// Sort them in order
		for(i = 0; i < spawnpoints.size; i++)
		{
			for(j = i; j < spawnpoints.size; j++)
			{
				if(spawnpoints[i].spawnscore > spawnpoints[j].spawnscore)
				{
					temp = spawnpoints[i];
					spawnpoints[i] = spawnpoints[j];
					spawnpoints[j] = temp;
				}
			}
		}
		
		//TEMP - PRINT ALL SCORES
		//for(i = 0; i < spawnpoints.size; i++)
		//	println ("spawnpoint[" + i + "]: " + spawnpoints[i].spawnscore);
		
		// Spawn points are sorted by score now
		firsthalf = (spawnpoints.size / 2);
		lastsixth = (spawnpoints.size - (spawnpoints.size / 6));
		
		//println ("Taking " + firsthalf + " - " + lastsixth);
		
		for (i=firsthalf;i<lastsixth;i++)
		{
			if (!isdefined (GoodSpawnPoints))
				GoodSpawnPoints[0] = spawnpoints[i];
			else
				GoodSpawnPoints[GoodSpawnPoints.size] = spawnpoints[i];
		}
		
		if (GoodSpawnPoints.size < 1)
		{
			spawnpoint = getSpawnpoint_Random(spawnpoints);
			return spawnpoint;
		}
		else
		{
			spawnpoint = getSpawnpoint_Random(GoodSpawnPoints);
			return spawnpoint;
		}
		
	}
	else
	{
		spawnpoint = getSpawnpoint_Random(spawnpoints);
		return spawnpoint;
	}
}

/////////////////////////////////////////////////////////////////////////

getSpawnpoint_DM(spawnpoints)
{
//	level endon("intermission");

	// There are no valid spawnpoints in the map
	if(!isdefined(spawnpoints))
		return undefined;

	// Make a list of fully connected, non-spectating, alive players
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(player.sessionstate == "spectator" || player.sessionstate == "dead" || player == self)
			continue;

		aliveplayers = add_to_array(aliveplayers, player);
	}

	// Spawn away from players if they exist, otherwise spawn at a random spawnpoint
	if(isdefined(aliveplayers))
	{
//		println("====================================");
		
		j = 0;
		for(i = 0; i < spawnpoints.size; i++)
		{
			// Throw out bad spots
			if(positionWouldTelefrag(spawnpoints[i].origin))
			{
//				println("Throwing out WouldTelefrag ", spawnpoints[i].origin);
				continue;
			}

			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i])
			{
//				println("Throwing out last spawnpoint ", spawnpoints[i].origin);
//				println("self.lastspawnpoint.origin: ", self.lastspawnpoint.origin);
				continue;
			}
			
			filteredspawnpoints[j] = spawnpoints[i];
			j++;
		}
		
		// if no good spawnpoint, need to failsafe
		if (!isdefined(filteredspawnpoints))
			return getSpawnpoint_Random(spawnpoints);

		for(i = 0; i < filteredspawnpoints.size; i++)
		{
			shortest = 1000000;
			for(j = 0; j < aliveplayers.size; j++)
			{
				current = distance(filteredspawnpoints[i].origin, aliveplayers[j].origin);
//				println("Current distance ", current);
				
				if (current < shortest)
				{
//					println("^4Old shortest: ", shortest, " ^4New shortest: ", current);
					shortest = current;
				}
			}

			filteredspawnpoints[i].spawnscore = shortest + 1;
//			println("^2Spawnscore: ", filteredspawnpoints[i].spawnscore);
		}

		// TODO: Throw out spawnpoints with negative scores
		
		newsize = filteredspawnpoints.size / 3;
		if(newsize < 1)
			newsize = 1;

		total = 0;
		bestscore = 0;
		
		// Find the top 3rd
		for(i = 0; i < newsize; i++)
		{
			for(j = 0; j < filteredspawnpoints.size; j++)
			{
				current = filteredspawnpoints[j].spawnscore;
//				println("Current distance ", current);

				if (current > bestscore)
					bestscore = current;
			}

			for(j = 0; j < filteredspawnpoints.size; j++)
			{
				if(filteredspawnpoints[j].spawnscore == bestscore)
				{
//					println("^3Adding to newarray: ", bestscore);
					newarray[i]["spawnpoint"] = filteredspawnpoints[j];
					newarray[i]["spawnscore"] = filteredspawnpoints[j].spawnscore;
					filteredspawnpoints[j].spawnscore = 0;
					bestscore = 0;			

//					println("^6Old total: ", total, "^6 New total: ", (total + newarray[i]["spawnscore"]), "^6 Added: ", newarray[i]["spawnscore"]);
					total = total + newarray[i]["spawnscore"];

					break;
				}
			}
		}

		randnum = randomInt(total);
//		println("^3Random Number: ", randnum, " ^3Between 0 and ", total);

		for(i = 0; i < newarray.size; i++)
		{
			randnum = randnum - newarray[i]["spawnscore"];
			spawnpoint = newarray[i]["spawnpoint"];

//			println("^2Subtracted: ", newarray[i]["spawnscore"], "^2 Left: ", randnum);
			
			if(randnum < 0)
				break;
		}
		
		self.lastspawnpoint = spawnpoint;
		return spawnpoint;
	}
	else
		return getSpawnpoint_Random(spawnpoints);
}

add_to_array(array, ent)
{
	if(!isdefined(ent))
		return array;
		
	if(!isdefined(array))
		array[0] = ent;
	else
		array[array.size] = ent;
	
	return array;	
}

addorigin_to_array(array, ent)
{
	if(!isdefined(ent))
		return array;
		
	if(!isdefined(array))
		array[0] = ent.origin;
	else
		array[array.size] = ent.origin;
	
	return array;	
}

