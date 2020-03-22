#using_animtree ("generic_human");

main()
{
//	precachemodel("xmodel/character_german_tankcrew");
//	precachemodel("xmodel/head_blane");  //head for script dieing models
//	character\German_tankcrew::precache();
	precachemodel("xmodel/v_ge_lnd_elefant(d)");
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_treadfx_gmi::main();
	precachevehicle("Elefant");
	precacheturret("mg42_panzerIV_tank");
	loadfx ("fx/explosions/vehicles/elefant_complete.efx");
	loadfx("fx/smoke/oneshotblacksmokelinger.efx");

}

animonpostion(guy, org ,angles, animation)
{
	guy animscripted("animontagdone", org, angles, animation);
	guy waittillmatch ("animontagdone","end");

}

returnspawnertorigin(thespawner)
{
	thespawner.count = thespawner.originalcount;
	thespawner.origin = thespawner.originalorigin;

}
getrandomspawner()
{
	spawners = getspawnerteamarray("axis");
//	for(i=0;i<spawners.size;i++)
//	{
//		if(spawners[i].team == "axis")
//		{
//			thespawner = spawners[i];
//			break;
//		}
//	}
	thespawner = spawners[level.guyspawnernumber];
	thespawner.originalcount = thespawner.count;
	thespawner.originalorigin = thespawner.origin;
	thespawner.count = 1;
	return thespawner;
}
waitframe()
{
	maps\_spawner_gmi::waitframe();
}

deathspawn(tank)
{
	tank.tankgetout = 1;  // for _tank.gsc to not spaz out if a tank doesn't do deathspaawning
	tankguyspawners = getentarray("tankspawner","targetname");


	position[0]["spawner"] = tankguyspawners[0];
	position[1]["spawner"] = tankguyspawners[1];
	position[2]["spawner"] = tankguyspawners[2];

	position[0]["getout"] = %tankgetout_right;
	position[1]["getout"] = %tankgetout_left;
	position[2]["getout"] = %tankgetout_back;

	position[0]["getoutdeath"] = %tankgetout_rightdeath;
	position[1]["getoutdeath"] = %tankgetout_leftdeath;
	position[2]["getoutdeath"] = %tankgetout_backdeath;

	position[0]["dead"] = randomint(2)-1;
	position[1]["dead"] = randomint(2)-1;
	position[2]["dead"] = randomint(2)-1;

	position[0]["delay"] = 0;
	position[1]["delay"] = randomfloat(1)+2;
	position[2]["delay"] = position[1]["delay"]+randomfloat(1)+2;



	tank waittill ("deadstop");
	if(isdefined(tank.nospawning))
	{
		tank.tankgetout = 0;
		return;
	}

	tagorg = tank gettagOrigin ("tag_hatch");
	tagang = tank gettagAngles ("tag_hatch");


	ai = [];

	for(i=0;i<position.size;i++)
	{
		ai = getaiarray("axis");
		if(ai.size > 10)
			position[0]["dead"] = 1;
		else
			position[0]["dead"] = randomint(2)-1;

	}

	if(!isdefined(position[0]["spawner"]))  //ghetto - everybody dies and uses script_model death animations if there are no tank spawners in the level
	{
		position[0]["dead"] = 1;
		position[1]["dead"] = 1;
		position[2]["dead"] = 1;
	}


//	spawnoffset = (0,0,0);

	for(i=0;i<position.size;i++)
	{
		if(isdefined(position[i]["spawner"]))
		{
			position[i]["spawner"].count = 1;
			position[i]["spawner"].origin = tank.origin;
		}
//		spawnoffset += (0,0,0); //don't spawn inside of eachother..
		thread spawnanddelayanim(position,i,tank,tagorg,tagang);
	}


	wait 10;
	tank notify("animsdone");




//	returnspawnertorigin(guyspawner);
//	guy3 = getrandomspawner();
//	guy3.origin = tank.origin;
///	thirdguy = guy3 stalingradspawn();
//	returnspawnertorigin(guy3);
//	animontag(thirdguy,"tag_hatch",tankgetout_right);


}

#using_animtree( "tankdeadguys" );

spawnanddelayanim(position,num,tank,tagorg,tagang)
{


	if(isdefined(position[num]["delay"]))
		wait position[num]["delay"];

	if(position[num]["dead"] || distance(level.player, tagorg) < 3500)
	{
//		guy = position[num]["spawner"] stalingradspawn();
		orgent = spawn("script_origin",tagorg);
		orgent.angles = tagang;
		guy = spawn("script_model", tagorg-(0,0,128));
//		guy linkto (orgent);
		guy.angles = tagang;
		guy character\German_tankcrew::main();
//		guy setmodel ("xmodel/character_german_tankcrew");
		guy useAnimTree( #animtree );
//		guy attach("xmodel/head_blane");
		position[0]["getoutdeath"] = %tankgetout_rightdeath;
		position[1]["getoutdeath"] = %tankgetout_leftdeath;
		position[2]["getoutdeath"] = %tankgetout_backdeath;

		guy animscripted("animontagdone", tagorg, tagang, position[num]["getoutdeath"]);
//		guy setflaggedanimrestart("deadguy",position[num]["getoutdeath"],1,.1,1);
//		thread animonpostion(guy,tagorg,tagang,position[num]["getoutdeath"]);
//		guy.deathanim = position[num]["getoutdeath"];
//		guy.allowdeath = 1;
//		waitframe();
//		guy doDamage (guy.health + 50, (0,0,0));
		wait 20;
		if (isdefined (guy))
			guy delete();


	}
	else
	{
		guy = position[num]["spawner"] stalingradspawn();
		thread animonpostion(guy,tagorg,tagang,position[num]["getout"]);
		guy animscripts\shared::DoNoteTracks("animontagdone");

	}

}

#using_animtree( "Elefant" );
init(optionalMachinegun)
{
	maps\_tank_gmi::setteam("axis");
	self useAnimTree( #animtree );
	if(isdefined(level.playertank))
		self.startenemy = level.playertank;
	life();
	thread kill();
//	level thread deathspawn(self);
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
	thread maps\_tank_gmi::turret_attack_think(optionalMachinegun);
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_gmi::main();
	thread maps\_treads_gmi::main();
}


init_noattack()
{

	self useAnimTree( #animtree );
	life();
	kill();
	thread shoot();
	thread maps\_tank_gmi::stun(1); //stun( stuntime );
//	thread maps\_tank_gmi::turret_attack_think();
}


// NOTE: I HAVE REMOVED THE ATTACK THINKS FROM THIS INIT!  TANKS USING THIS INIT MUST BE MANUALLY SUPPLIED WITH FIRING INSTRUCTIONS
// (OR, RATHER, THINK FUNCTIONS LOCATED IN THE LEVEL SCRIPTS)
init_Kursk(optionalTurret)
{
	maps\_tank_gmi::setteam("axis");

	self useAnimTree( #animtree );
	if(isdefined(level.playertank))
		self.startenemy = level.playertank;
	life();
	thread kill();
	level thread deathspawn(self);
	thread shoot();
	thread maps\_tank_pi::stun(1); //stun( stuntime );

/*
	if (isDefined(optionalTurret) )
		thread maps\_tank_pi::turret_attack_think_Kursk(optionalTurret);
	else
		thread maps\_tank_pi::turret_attack_think_Kursk("mg34_german_tank");
*/
	self.treaddist = 16;
	if (!isdefined (level._effect["treads_grass"]))
		maps\_treadfx_pi::main();
	thread maps\_treads_pi::main();
}

friend_life()
{
	self.health  = 2500;
	thread maps\_tank_gmi::conechecksamples();


}

life()
{
	if(!isdefined(self.health) || self.health < 10)
	{
		self.health  = (randomint(1000)+500);
	}

	thread maps\_tank_gmi::conechecksamples();

}

kill()
{

	self UseAnimTree(#animtree);
	self.deathmodel = "xmodel/v_ge_lnd_elefant(d)";
	self.deathfx    = loadfx ("fx/explosions/vehicles/elefant_complete.efx");
	self.deathsound = "explo_metal_rand";
	thread maps\_tank_gmi::kill();
	self waittill ("tankkilled");
//	self setAnimKnobRestart( %PanzerIV_d );

}

shoot()
{
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
		self fire();
		self setanimknobrestart(%v_ge_lnd_elefant_fire);
	}
}
fire()
{
	if(self.health <= 0)
		return;
	// fire the turret
	self FireTurret();
	// play the fire animation
	self setAnimKnobRestart( %v_ge_lnd_elefant_fire );
}

spam()
{
	println("********ELEFANT!!!*********");
}