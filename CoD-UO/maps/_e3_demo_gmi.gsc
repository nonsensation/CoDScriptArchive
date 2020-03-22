// For E3 Only, remove file when we RELEASE!

main()
{
}


// Function Resets if there is no movement from the player for the given duration.
// load_game is the "string" of the loadgame name.
// duration is the time (in seconds) it will take before resetting to the load_game. 
player_move_check(load_game, duration)
{
	old_player_origin = level.player.origin;
	old_player_angles = level.player.angles;

	timer = (gettime() + (duration * 1000));

	while(1)
	{
		if(old_player_origin != level.player.origin || old_player_angles != level.player.angles)
		{
//			println("^5PLAYER MOVED MOUSE!!! RESET TIMER!!");
			old_player_origin = level.player.origin;
			old_player_angles = level.player.angles;
			timer = (gettime() + (duration * 1000));
		}

//		p_timer = timer - gettime();
//		println("^3NO MOVEMENT TIMER: ",p_timer);

		if(timer < gettime())
		{
			break;
		}

		wait 0.5;
	}

//	for(i=5;i>0;i--)
//	{
//		println("^3GOING TO LOAD THE SAVED GAME!!!");
//		wait 1;
//	}
	loadgame(load_game);
}