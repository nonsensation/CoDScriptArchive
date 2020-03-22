// level.player giveWeapon("m1carbine");
// level.player giveWeapon("m1garand");
// level.player giveWeapon("thompson");
// level.player giveWeapon("bar");
// level.player giveWeapon("mg30cal");
// level.player giveWeapon("springfield");
// level.player giveWeapon("colt");
// level.player giveWeapon("kar98k");
// level.player giveWeapon("gewehr43");
// level.player giveWeapon("mp40");
// level.player giveWeapon("mp44");
// level.player giveWeapon("fg42");
// level.player giveWeapon("mg34");
// level.player giveWeapon("luger");
// level.player giveWeapon("mosin_nagant");
// level.player giveWeapon("ppsh");
// level.player giveWeapon("svt40");
// level.player giveWeapon("dp28");
// level.player giveWeapon("mosin_nagant_sniper");
// level.player giveWeapon("tt33");
// level.player giveWeapon("bren");
// level.player giveWeapon("sten");
// level.player giveWeapon("sten_silenced");
// level.player giveWeapon("enfield");
// level.player giveWeapon("fraggrenade");
// level.player giveWeapon("MK1britishfrag");
// level.player giveWeapon("RGD-33russianfrag");
// level.player giveWeapon("stielhandgranate");
// level.player giveWeapon("flamethrower");
// level.player giveWeapon("binoculars");


give_loadout()
{

	setCvar("cg_victoryscreen_menu","off");


	if(!(isdefined(game["gaveweapons"])))
	{
		game["gaveweapons"] = 0;
	}

	if(!(isdefined (level.campaign)))
	{
		level.campaign = "american";
	}

	if(level.script == "bastogne1")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@bastogne1.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@bastogne1.tga");
		thread setup_american();
		level.campaign = "american";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("m1garand");
		level.player giveWeapon("fraggrenade");
		level.player switchToWeapon("m1garand");

		game["gaveweapons"] = 1;
		return;
	}

	if(level.script == "bastogne2")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@bastogne2.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@bastogne2.tga");
		thread setup_american();
		level.campaign = "american";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("m1garand");
		level.player giveWeapon("thompson");
		level.player giveWeapon("fraggrenade");
		level.player switchToWeapon("m1garand");

		game["gaveweapons"] = 1;
		return;
	}

	if(level.script == "foy")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@foy.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@foy.tga");
		thread setup_american();
		level.campaign = "american";

		level.player setnormalhealth (1);

		if(game["gaveweapons"] == 1)
		{
			thread refill_ammo();
			// weapons carry over but are REFILLED
			return;
		}

		level.player giveWeapon("m1garand");
		level.player giveWeapon("colt");
		level.player giveWeapon("fraggrenade");
		level.player switchToWeapon("m1garand");

		game["gaveweapons"] = 1;
		return;
	}

	if(level.script == "noville")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@noville.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@noville.tga");
		setCvar("cg_victoryscreen_menu","eoc_usa");
		thread setup_american();
		level.campaign = "american";

		level.player setnormalhealth (1);

		if(game["gaveweapons"] == 1)
		{
			thread refill_ammo();
			// weapons carry over but are REFILLED
			return;
		}

		level.player giveWeapon("m1carbine");
		level.player giveWeapon("colt");
		level.player giveWeapon("fraggrenade");
		level.player switchToWeapon("m1carbine");

		game["gaveweapons"] = 1;
		return;
	}

	if( level.script == "bomber" )
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@bomber.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@bomber.tga");
		thread setup_british();
		level.campaign = "british";

		level.player setnormalhealth (1);

		// weapons DONT carry over

		game["gaveweapons"] = 1;
		return;
	}

	if( level.script == "trainbridge" )
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@trainbridge.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@trainbridge.tga");
		thread setup_british();
		level.campaign = "british";

		level.player setnormalhealth (1);

		// weapons DONT carry over

		game["gaveweapons"] = 1;
		return;
	}

	if( level.script == "sicily1" )
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@sicily1.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@sicily1.tga");
		thread setup_british();
		level.campaign = "british";

		level.player setnormalhealth (1);

		// weapons DONT carry over

		game["gaveweapons"] = 1;
		return;
	}

	if( level.script == "sicily2" )
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@sicily2.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@sicily2.tga");
		setCvar("cg_victoryscreen_menu","eoc_british");
		thread setup_british();
		level.campaign = "british";

		level.player setnormalhealth (1);

		if(game["gaveweapons"] == 1)
		{
			thread refill_ammo();
			// weapons carry over but are REFILLED
			return;
		}

		level.player giveWeapon("mp44");
		level.player giveWeapon("Webley");
		level.player giveWeapon("MK1britishfrag");
		level.player switchtoweapon("mp44");

		game["gaveweapons"] = 1;
		return;
	}


	if(level.script == "trenches")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@trenches.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@trenches.tga");
		thread setup_russian();
		level.campaign = "russian";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("mosin_nagant");
		level.player giveWeapon("tt33");
		level.player switchToWeapon("mosin_nagant");

		game["gaveweapons"] = 1;
		return;
	}

	if((level.script == "ponyri") || (level.script == "pon") || (level.script == "yri"))
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@ponyri.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@ponyri.tga");
		thread setup_russian();
		level.campaign = "russian";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("mosin_nagant");
		level.player giveWeapon("tt33");
		level.player giveWeapon("RGD-33russianfrag");
		level.player switchToWeapon("mosin_nagant");

		game["gaveweapons"] = 1;
		return;
	}

	if(level.script == "kursk")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@kursk.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@kursk.tga");
		thread setup_russian();
		level.campaign = "russian";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("tt33");
		level.player switchToWeapon("tt33");

		game["gaveweapons"] = 1;
		return;
	}

	if(level.script == "kharkov1")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@kharkov1.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@kharkov1.tga");
		thread setup_russian();
		level.campaign = "russian";

		level.player setnormalhealth (1);

		// weapons DONT carry over
		level.player giveWeapon("svt40");
		level.player giveWeapon("binoculars");
		level.player giveWeapon("RGD-33russianfrag");
		level.player switchToWeapon("svt40");

		game["gaveweapons"] = 1;
		return;
	}


	if(level.script == "kharkov2")
	{
		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
		setCvar("cg_victoryscreen_menu","eoc_russian");
		thread setup_russian();
		level.campaign = "russian";

		level.player setnormalhealth (1);

		if(game["gaveweapons"] == 1)
		{
			thread refill_ammo();
			// weapons carry over but are REFILLED
			return;
		}

		level.player giveWeapon("svt40");
		level.player giveWeapon("tt33");
		level.player giveWeapon("RGD-33russianfrag");
		level.player switchToWeapon("svt40");

		game["gaveweapons"] = 1;
		return;
	}


//	if(level.script == "credits")
//	{
//		setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
//		setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
//		thread setup_russian();
//		level.campaign = "russian";
//
//		level.player setnormalhealth (1);
//		setCvar("cg_victoryscreen_menu","eoc_russian");
//
//		game["gaveweapons"] = 1;
//		return;
//	}


	//------------------------------------
	// level.script is not a COD:UO single player level. give default weapons.
	println ("Z:     No level listing in _loadout.gsc, giving default guns");

	thread setup_russian();
	level.campaign = "russian";

	level.player giveWeapon("fg42");
	level.player giveWeapon("luger");
	level.player giveWeapon("stielhandgranate");
	level.player switchToWeapon("fg42");
	//------------------------------------
}

refill_ammo()
{
	weapons[0] = "m1carbine";
	weapons[1] = "enfield";
	weapons[2] = "mosin_nagant";
	weapons[3] = "kar98k";
	weapons[4] = "m1garand";
	weapons[5] = "svt40";
	weapons[6] = "gewehr43";
	weapons[7] = "thompson";
	weapons[8] = "sten_silenced";
	weapons[9] = "sten";
	weapons[10] = "ppsh";
	weapons[11] = "mp40";
	weapons[12] = "bar";
	weapons[13] = "bren";
	weapons[14] = "fg42";
	weapons[15] = "mp44";
	weapons[16] = "colt";
	weapons[17] = "tt33";
	weapons[18] = "webley";
	weapons[19] = "luger";
	weapons[20] = "springfield";
	weapons[21] = "kar98k_sniper";
	weapons[22] = "mosin_nagant_sniper";
	weapons[23] = "fraggrenade";
	weapons[24] = "MK1britishfrag";
	weapons[25] = "RGD-33russianfrag";
	weapons[26] = "stielhandgranate";

	for (i=0;i<weapons.size;i++)
	{
		if (level.player hasWeapon(weapons[i]))
		{
			level.player giveMaxAmmo(weapons[i]);
			println ("z:           giving the player max ammo for: ", weapons[i]);
		}
	}
}

setup_british()
{
	setCvar("cg_deadscreen_backdrop", "levelshots/deadscreen/defeat_british.tga");
	setCvar("cg_victoryscreen_backdrop", "levelshots/victoryscreen/victory_british.jpg");
	setCvar("ui_campaign", "british");
	level.player setViewmodel( "xmodel/viewmodel_hands_british_air" );
}

setup_american()
{
	setCvar("cg_deadscreen_backdrop", "levelshots/deadscreen/defeat_american.tga");
	setCvar("cg_victoryscreen_backdrop", "levelshots/victoryscreen/victory_american.jpg");
	setCvar("ui_campaign", "american");
	level.player setViewmodel( "xmodel/viewmodel_hands_us" );
}

setup_russian()
{
	setCvar("cg_deadscreen_backdrop", "levelshots/deadscreen/defeat_russian.tga");
	setCvar("cg_victoryscreen_backdrop", "levelshots/victoryscreen/victory_russian.jpg");
	setCvar("ui_campaign", "russian");
	level.player setViewmodel( "xmodel/viewmodel_hands_russian" );
}
