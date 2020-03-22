// ----------------------------------------------------------------------------------
//	ValidateScore()
//
//		returns the given score after it has been put modified by the valid
//		score range
// ----------------------------------------------------------------------------------
ValidateScore(iScore)
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		// battle rank should not let scores go below zero
		if ( iScore < 0 )
			iScore = 0;
	}

	return iScore;
}

// ----------------------------------------------------------------------------------
//	GetPoints(iRegularPoints, iBattleRankPoints)
//
//		Takes in two parameters that are the points for battle rank and non
//		battle rank modes.  It returns the points for the current game play style
// ----------------------------------------------------------------------------------
GetPoints(iRegularPoints, iBattleRankPoints)
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		return iBattleRankPoints;
	}

	return iRegularPoints;
}

// ----------------------------------------------------------------------------------
//	GetKillPoints()
//
//		returns the points for a kill
// ----------------------------------------------------------------------------------
GetKillPoints()
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		return game["br_points_kill"];
	}

	return 1;
}

// ----------------------------------------------------------------------------------
//	GetTeamKillPoints()
//
//		returns the points for a team kill
// ----------------------------------------------------------------------------------
GetTeamKillPoints()
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		return game["br_points_teamkill"];
	}

	return -1;
}

// ----------------------------------------------------------------------------------
//	GetSuicidePoints()
//
//		returns the points for a suicide
// ----------------------------------------------------------------------------------
GetSuicidePoints()
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		return game["br_points_suicide"];
	}

	return -1;
}

// ----------------------------------------------------------------------------------
//	GetNoAttackerKillPoints()
//
//		returns the points for a getting killed by nobody
// ----------------------------------------------------------------------------------
GetNoAttackerKillPoints()
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		// no penalty in battle rank mode
		return 0;
	}

	return -1;
}


// ----------------------------------------------------------------------------------
//	GetDefensePoints()
//
//		returns points for an objective defense kill
// ----------------------------------------------------------------------------------
GetDefensePoints()
{
	if (isDefined(level.battlerank) && level.battlerank)
	{
		return game["br_points_defense"];
	}

	return 2;
}