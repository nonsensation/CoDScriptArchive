
// NOTE: entity.closespeed can be used as a maxspeed multiplier for each individual vehicle

main()
{

	level.watereffects 	= loadfx ("fx/water/tug_froth.efx");
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");

	level.jeep_hud_bar = "gfx/hud/hud@health_bar.dds";
	
	// this is an ugly hack since we can't set an engine field to null
	level.vehicle_no_owner = spawn("script_origin", (0,0,0) );
	
	precacheShader( "gfx/hud/hud@littlejeep.dds" );
	precacheShader( "gfx/hud/hud@fire_ready_shell.tga" );
	precacheShader( "gfx/hud/hud@vehiclehealth.dds");
	precacheShader( "gfx/hud/tankhudhealthbar" );
	precacheShader( level.tank_hud_bar );

	precacheShader( "gfx/hud/tankhudhealthbar" );
	precacheShader( "gfx/hud/tankhudback" );
	precacheShader( "white" );
	precacheShader( "black" );

	initVehicleCvars();
	restrictPlacedVehicles();

	// precache everything for the jeeps
	jeeps = getentarray("script_vehicle","classname");

	for(i=0;i<jeeps.size;i++)
	{
		if (	   jeeps[i].vehicletype == "willyjeep_mp" 
			|| jeeps[i].vehicletype == "horch_mp" 
			|| jeeps[i].vehicletype == "gaz67b_mp")
		{
			// precache effects and setup for death model change
			jeeps[i] maps\mp\_jeepeffects_gmi::init( 1 );
		}
	}
	
	// this wait is necessary otherwise if there are to many trees then the game crashes 
	// with all sorts of odd client/server connection problems.  There may still be a problem
	// and this just masks it so if there are any problems in the future we may need to revisit this
	wait(1);
	
	// start each tank thinking
	jeeps = getentarray("script_vehicle","classname");
	for(i=0;i<jeeps.size;i++)
	{
		if (	   jeeps[i].vehicletype == "willyjeep_mp" 
			|| jeeps[i].vehicletype == "horch_mp" 
			|| jeeps[i].vehicletype == "gaz67b_mp")
		{
			jeeps[i].spawn_count = 1;
			jeeps[i] thread init( 1 );
			
			// purely for debug
			jeeps[i].tank_num = i;
		}
	}

}

init(precache)
{
	// give us some health, and manage hud elements
	self thread init_hud();

	self.spawn_origin = self.origin;

	if (!isdefined( self.spawn_count ))
		self.spawn_count = 1;
		
	// init the riding_count
	self.riding_count = 0;

	// start the respawn thread
	self thread respawn();

	// setup death model and wait for tank death
	if (	self.vehicletype == "willyjeep_mp" 
		||	self.vehicletype == "horch_mp" 
		||	self.vehicletype == "gaz67b_mp")
	{
		// precache effects and setup for death model change
		self maps\mp\_jeepeffects_gmi::init( 0 );
	}
	self thread maps\mp\_jeepeffects_gmi::damaged_smoke();
	self thread maps\mp\_jeepeffects_gmi::death();

	// jeeps can be used by anyone
	self.tank_team = "all";
	
	// for team restrictions
	jeep_set_team();

	// wait for a player to jump in
	self thread wait_for_activate();
}

jeep_set_team()
{
	game_type = getcvar("g_gametype");
	// if this is deathmatch, tdm, or hq then vehicles do not have a team because we
	// can not control where people spawn in these modes
	if ( game_type == "dm" || game_type == "tdm" || game_type == "hq")
	{
		self.team = "all";
		return;
	}

	if (self.vehicletype == "horch_mp")
	{
		self.team = "axis";
	} else {
		self.team = "allies";
	}
}

respawn()
{
	self waittill("death");

	wait self.delay;

	// check for a NO_RESPAWN flag	
	if (!(self.spawnflags & 2) && (!isdefined(self.respawn) || self.respawn == 1))
	{
		dupe = self spawnduplicate();
		dupe.spawn_count = self.spawn_count;
		dupe.spawn_origin = dupe.origin;
		
		// this is for debuggin
		dupe.tank_num = self.tank_num;
		
		dupe thread wait_for_safe_respawn();
		
		// let us disappear
		self notify("allow_explode");
	}
	else
	{
		// let us disappear
		self notify("allow_explode");
	}
}

wait_for_safe_respawn( force_respawn )
{
	self unlinkfromworld();
	
	spawn_limit = getCvarInt("scr_vehicle_spawn_limit");
	
	// dont respawn this vehicle if it is over the spawn_limit
	if ( spawn_limit > 0 && self.spawn_count >= spawn_limit )
	{
		self delete();
		return;
	}
		
	self.allow_respawn = 1;
		
	if (!isdefined( level.no_auto_vehicle_respawn ) || !level.no_auto_vehicle_respawn)
	{
		// now wait for a safe time to respawn
		wait_time = getCvarInt("scr_jeep_respawn_wait");
		wait wait_time;
	} else if (!isdefined( force_respawn ) || !force_respawn)
	{
		self.allow_respawn = 0;
	}

	self.waiting_for_respawn = 1;

	while (1)
	{
		self clearvehicleposition();
		
		if (!isdefined( level.no_auto_vehicle_respawn ) || !level.no_auto_vehicle_respawn)
		{
			self clearvehicleposition();
			if (self verifyposition())
				break;
		} else
		{
			if (self.allow_respawn && (self verifyposition())) {
				self clearvehicleposition();
				break;
			}
		}
		
		wait 0.2;
	}
	self.waiting_for_respawn = 0;
	self.spawn_count++;
	
	self linkintoworld();
	
	// if we haven't already, starthud elements, etc
	if (!isdefined( self.riding_count ))
		self thread init( 0 );
}

wait_for_activate()
{
	self endon("death");

	while (1)
	{
		self waittill("activated", vehpos, activator);

		self thread delayed_process_activate( vehpos, activator );
	}
}

delayed_process_activate( vehpos, activator )
{

	// wait one frame to make sure a simultaneous deactivate is processed first
	wait 0.1;

	self notify("kill_vehicle_owner");
	
	// if the tank is set to self-destruct, then abort it if this person is of the correct team
//	if (isdefined(self.self_destruct_team) && (self.self_destruct_team == activator.pers["team"])) 
//	{
		self notify("stop_self_destruct");
//	}

	self.riding_count++;

	activator.vehpos = vehpos;

	if (vehpos == 1)
	{	
		self.has_been_driven = 1;
	
		self.driver = activator;
		//self thread player_shoot();
		//self thread player_shoot_alt();
	}
	else if (vehpos == 2)
	{
		self.gunner = activator;
		self thread player_shoot_gunner();
	}

	// if they got in and out on the same frame make sure we dont do the rest of this stuff
	if ( !(activator isinvehicle()) )
		return;
		
	// give them a hud display for the tank
	self thread hud_activated( activator );
	
	// wait for the tank to be deactivated
	self thread deactivated( activator );
	
	// blow us up if the tank dies while we're in it
	activator thread death_player_damage( self );
	
	// do tank capturing stuff
	self check_capture( activator );
}

check_capture( activator )
{
	if (!isdefined( self.tank_team ))
		return;

	if (self.tank_team == "all")
		return;
		
	if (activator.vehpos == 1 && self.tank_team != activator.pers["team"]) {
		// this person needs to capture the tank before it can be driven
		self thread capture_think( activator );
	}
}

capture_hud_destroy_thread(tank, driver, capturehud, capturehud2, capturehudtext)
{
	driver waittill("stop_capture_hud");

	tank.capturing = 0;

	if (!isValidPlayer( driver ))
	{
		// already disconnected, hudelem's must have been destroyed
		return;
	}

	capturehud destroy();
	capturehud2 destroy();
	capturehudtext destroy();
}

capture_think( activator )
{
	hud_top		= 310;
	hud_bar_height	= 12;

	activator endon("stop_capture_hud");

	self.capturing = 1;
	
	capture_time = 10000;		// todo: capture time should be a cvar
	capture_starttime = gettime();
	capture_endtime = capture_starttime + capture_time;

	self.capture_hud_maxwidth = 140;
	self.capture_hud_width = 1;

	capturehudtext = newClientHudElem( activator );
	capturehudtext setText(&"GMI_MP_TANK_CAPTURING");
	capturehudtext.alignX = "center";
	capturehudtext.alignY = "top";
	capturehudtext.x = 320;
	capturehudtext.y = hud_top;
		
	// background
	capturehud2 = newClientHudElem( activator );
	capturehud2 setShader("black", self.capture_hud_maxwidth + 2, hud_bar_height + 2);
	capturehud2.alignX = "left";
	capturehud2.alignY = "top";
	capturehud2.x = 320 - self.capture_hud_maxwidth/2 - 1;
	capturehud2.y = hud_top + 19;

	// foreground
	capturehud = newClientHudElem( activator );
	capturehud setShader("white", self.capture_hud_width, hud_bar_height);
	capturehud.alignX = "left";
	capturehud.alignY = "top";
	capturehud.x = 320 - self.capture_hud_maxwidth/2;
	capturehud.y = hud_top + 20;

	level thread capture_hud_destroy_thread( self, activator, capturehud, capturehud2, capturehudtext );
	
	while (gettime() < capture_endtime)
	{
		wait 0.2;
		
		if ( !isAlive(self) || !isDefined(capturehud) )
			return;
			
		// update the capture hud
		self.capture_hud_width = (1.0 * self.capture_hud_maxwidth * (gettime() - capture_starttime)) / capture_time;
		if (self.capture_hud_width > self.capture_hud_maxwidth) self.capture_hud_width = self.capture_hud_maxwidth;
		capturehud setShader("white", self.capture_hud_width, hud_bar_height);
	}

	// success!
	self.tank_team = "all";

	// give us props
	clientAnnouncement( activator, &"GMI_MP_TANK_CAPTURED" );

	// message to all teammates
	players = getentarray("player", "classname"); 
	for(i = 0; i < players.size; i++) 
	{ 
		player = players[i]; 
		if (activator.pers["team"] == player.pers["team"])
		{
			if (player.pers["team"] == "AXIS")
				player iprintln(&"GMI_MP_CAPTURED_ALLIED_TANK_BROADCAST", activator);
			else
				player iprintln(&"GMI_MP_CAPTURED_AXIS_TANK_BROADCAST", activator);
		}
	}
      	
     	self notify("stop_self_destruct");
	activator notify("stop_capture_hud");
}

death_player_damage( tank )
{
	self endon ("deactivated_player");
	
	tank waittill("death");

	mod = "MOD_EXPLOSIVE";
	
	if ( isDefined(self.deepwater) && self.deepwater )
		mod = "MOD_WATER";
		
	// kill the tank
	if (isDefined( tank.last_attacker ) && isValidPlayer( tank.last_attacker ))
	{
		inflictor = tank.last_attacker;
		if (isDefined( tank.last_inflictor ))
		{
			inflictor = tank.last_inflictor;
		}
		self DoDamage( 10000, tank.origin,  tank.last_attacker, inflictor, mod );
	}
	else
	{
		self DoDamage( 10000, tank.origin, tank, tank, mod );
	}
}

send_delayed_player_deactivate()
{
	// wait for a bit, so that the deactivate on tank death doesnt abort the damage function before the tank death can be processed
	wait 0.1;
	self notify("deactivated_player");
}
		
deactivated( activator )
{
	while (1)
	{
		self waittill("deactivated", deactivator);
		
		if (activator != deactivator)
		{
			// someone else, so go back to waiting
			continue;
		}

		// the activator, has deactivated
		
		self.riding_count--;
		
		// send this so they can end player-oriented threads
		if ( isValidPlayer(activator) )
			activator thread send_delayed_player_deactivate();
		
		self thread process_deactivate(deactivator);
		break;
	}
}
	
process_deactivate(deactivator)
{
	if (isdefined(deactivator) && deactivator.vehpos == 1) {	// driver
		self.driver = undefined;
	}
	if (isdefined(deactivator) && deactivator.vehpos == 2) {	// gunner
		self.gunner = undefined;
	}

	if ( isValidPlayer( deactivator ) )
	{
		deactivator notify ("stop_capture_hud");
		deactivator notify ("stop_hud");
		self.self_destruct_team = deactivator.pers["team"];
	}
	else
	{
		self.self_destruct_team = "all";
	}

	if (self.riding_count == 0 && isdefined(self.has_been_driven) && (self.tank_team == "all" || self.tank_team == self.self_destruct_team)) 
	{
		if (getCvarInt("scr_selfDestructJeepTime") == 0)
			setCvar("scr_selfDestructJeepTime", "90");
			
		if (getCvarInt("scr_selfDestructJeepTime") > 0)
		{
			// now start a timer to self destruct
			self endon("stop_self_destruct");
			
			// wait and then if not being used blow up
			wait(getCvarInt("scr_selfDestructJeepTime"));

			// only blow up if it is empty
			self dodamage( 10000, self.origin+(0,0,1), self, self, "MOD_EXPLOSIVE" );
		}
	}
}

init_hud()
{
	self.healthbuffer = 2000;
	self.basehealth = 900;
	self.health = self.basehealth + self.healthbuffer;
	self.currenthealth = self.health;

	self.hud_width = 128;
	self.hud_maxwidth = self.hud_width;
	basewidth = self.hud_width;
	minwidth = 1;

	while(self.hud_width > minwidth)
	{
		self waittill ("damage",ammount,attacker,dir, point, mod,inflictor);

		// if we are in ceasefire mode vehicles can not be damaged
		if(level.ceasefire)
		{
			self.health = self.health + ammount;
			continue;
		}

		if ( !isdefined(inflictor) )
			inflictor = attacker;
			
		owner = self getvehicleowner();

		// no damage if friendly fire
		if(isdefined(attacker) && isPlayer(attacker) && isdefined(owner) 
			&& (self != inflictor) && (owner.pers["team"] == attacker.pers["team"])
			&& level.friendlyfire == "0" && getcvar("g_gametype") != "dm" )
		{
			self.health = self.health + ammount;
			continue;
		}
		
		self.tank_attacker = attacker;

		self.currenthealth = self.health;

		if(!(self.health < self.healthbuffer))
			self.hud_width = ((self.health - self.healthbuffer)*basewidth)/self.basehealth;
		else
			self.hud_width = 0;

		self notify("hud_update");
	}

	// save who the last attacker was so we can give them credit for the driverkill
	self.last_attacker = attacker;
	self.last_inflictor = inflictor;	
		
	if ( mod != "MOD_WATER")
	{
		explosion_origin = (self.origin[0],self.origin[1],self.origin[2]+25);
		// big explosion
		if (isDefined( attacker ))
		{
			self DoDamage( 10000, explosion_origin,  attacker, inflictor, mod );
			radiusDamage ( explosion_origin, 300, 80, 10, attacker, inflictor);
		}
		else
		{
			self DoDamagemod( 10000, explosion_origin, mod );
			radiusDamage ( explosion_origin, 300, 80, 10);
		}
	}
}

hud_destroy_player_death(tank, driver)
{
	driver endon("abort_hud_destroy_player_death");
	
	// this an added precaution, if the player dies, make sure the hud gets killed
	while (driver.health > 0)
	{
		driver waittill("damage");
		if (driver.health <= 0)
			driver notify("stop_hud");
	}
}

hud_destroy_thread(tank, driver, tankhud, tankhud2, overheat,littlejeep)
{
	level thread hud_destroy_player_death( tank, driver );

	driver waittill("stop_hud");

	if (!isValidPlayer( driver ))
	{
		// already disconnected, hudelem's must have been destroyed
		return;
	}

	driver notify("abort_hud_destroy_player_death");

	if (isdefined(littlejeep))
		littlejeep destroy();

	if (isdefined( tankhud ))
		tankhud destroy();
	tankhud2 destroy();
	if (isdefined( overheat ))
		overheat destroy();
}

hud_activated(activator)
{
	littlejeep = newClientHudElem(activator);
	littlejeep setShader("gfx/hud/hud@littlejeep.dds", 12, 10);
	littlejeep.alignX = "left";
	littlejeep.alignY = "top";
	littlejeep.x = 488;
	littlejeep.y = 445;

	// if this is the gunner give them the overheat bar as well
	if (activator.vehpos == 1 || activator.vehpos == 2)
	{
		overheat = newClientHudElem( activator );
		overheat setShader(level.jeep_hud_bar, 128, 4);
		overheat.alignX = "left";
		overheat.alignY = "top";
		overheat.x = 488+14;
		overheat.y = 437;
	}

	// create the hud elements

	tankhud = newClientHudElem( activator );
	tankhud.color = (1.0,0.0,0.0);
	tankhud setShader(level.tank_hud_bar, self.hud_width,8);
	tankhud.alignX = "left";
	tankhud.alignY = "top";
	tankhud.x = 488+13;
	tankhud.y = 446;

	tankhud2 = newClientHudElem( activator );
	tankhud2 setShader("gfx/hud/hud@vehiclehealth.dds", 128, 32);
	tankhud2.alignX = "left";
	tankhud2.alignY = "top";
	tankhud2.x = 488+13;
	tankhud2.y = 452-16;
		
	// while the player is using the tank, keep updating the hud	
	self thread hud_run( activator, tankhud );
	
	// if this is the gunner give them the overheat bar as well
	if (activator.vehpos == 1 || activator.vehpos == 2)
	{
		self thread hud_overheat_run(activator, overheat);
		level thread hud_destroy_thread( self, activator, tankhud, tankhud2, overheat , littlejeep );
	}
	else 
	{
		level thread hud_destroy_thread( self, activator, tankhud, tankhud2, undefined, littlejeep );
	}
	

}

hud_run(driver, tankhud)
{
	self endon("death");
	driver endon ("death");
	driver endon("stop_hud");
	
	minwidth = 0;

	while(1)
	{
		self waittill("hud_update");

		if ( !isAlive(self) || !isDefined(tankhud) )
			continue;

		if(self.hud_width > minwidth)
			tankhud setShader(level.tank_hud_bar, self.hud_width,8);
		else
		{
			tankhud setShader(level.tank_hud_bar, minwidth,8);
			break;
		}			
	}
}

hud_overheat_run(activator, overheat)
{
	self endon("death");
	activator endon("death");
	activator endon("stop_tank_hud");
	
	minheight = 0;
	max_width = 126;
	
	while(1)
	{
		wait (0.1);
		if ( !isAlive(self) || !isDefined(overheat) )
			continue;
		
		if ( activator.vehpos == 1)
		{
			heat = self getaltheat();
			overheating = self getaltoverheating();
		}
		else
		{
			heat = self getgunnerheat();
			overheating = self getgunneroverheating();
		}
		
		if ( overheating )
		{
			overheat.color = ( 1.0, 0.0, 0.0);
		}
		else
		{
			overheat.color = ( 1.0, 1.0-heat,1.0-heat);
		}
	
		hud_width = (1.0 - heat) * max_width;
		
		if ( hud_width < 1 )
			hud_width = 1;
			
		overheat setShader(level.tank_hud_bar, hud_width, 5);
	}
}


hud_fireicon_run( driver, fireicon )
{
	self endon ("death");
	driver endon ("death");
	driver endon ("stop_hud");

	while (1)
	{
		fireicon.alpha = 1;
		self waittill ("turret_fire");
		fireicon.alpha = 0;
		wait .5;
		self playsound ("tank_reload");
		while (self isTurretReady() != true)
			wait .2;
	}
}

deathrollon()
{
	if(self.health > 0)
		self.rollingdeath = 1;
}

deathrolloff()
{
	self.rollingdeath = undefined;
	self notify("deathrolloff");
}

player_shoot()
{
	self notify("kill_existing_player_shoot");
	self endon("kill_existing_player_shoot");
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
		self fire();
	}
}

fire()
{
	if(self.health <= 0)
		return;

	if(self.capturing)
		return;

	if(level.ceasefire == 2)
		return;
	
	// fire the turret
	self FireTurret();
}

player_shoot_alt()
{
	self notify("kill_existing_player_shoot_alt");
	self endon("kill_existing_player_shoot_alt");
	while(self.health > 0)
	{
		self waittill( "turret_alt_fire" );
		self fire_alt();
	}
}

fire_alt()
{
	if(self.health <= 0)
		return;

	if(self.capturing)
		return;

	if(level.ceasefire == 2)
		return;

	// fire the turret
	self FireAltTurret();
}

player_shoot_gunner()
{
	self notify("kill_existing_player_shoot_gunner");
	self endon("kill_existing_player_shoot_gunner");
	while(self.health > 0)
	{
		self waittill( "turret_gunner_fire" );
		self fire_gunner();
	}
}

fire_gunner()
{
	if(self.health <= 0)
		return;

	if(level.ceasefire == 2)
		return;

	// fire the turret
	self FireGunner();
}

initVehicleCvars()
{
	if(getCvar("scr_jeep_respawn_wait") == "")
		setCvar("scr_jeep_respawn_wait", "5");

	if(getCvar("scr_jeep_spawn_limit") == "")
		setCvar("scr_jeep_spawn_limit", "0");

	level.allow_jeeps = getCvar("scr_allow_jeeps");
	if(level.allow_jeeps == "")
		level.allow_jeeps = "1";
	setCvar("scr_allow_jeeps", level.allow_jeeps);
	setCvar("ui_allow_jeeps", level.allow_jeeps);
	makeCvarServerInfo("ui_allow_jeeps", "1");

	level.allow_willyjeep = getCvar("scr_allow_willyjeep");
	if(level.allow_willyjeep == "")
		level.allow_willyjeep = "1";
	setCvar("scr_allow_willyjeep", level.allow_willyjeep);
	setCvar("ui_allow_willyjeep", level.allow_willyjeep);
	makeCvarServerInfo("ui_allow_willyjeep", "1");

	level.allow_gaz67b = getCvar("scr_allow_gaz67b");
	if(level.allow_gaz67b == "")
		level.allow_gaz67b = "1";
	setCvar("scr_allow_gaz67b", level.allow_gaz67b);
	setCvar("ui_allow_gaz67b", level.allow_gaz67b);
	makeCvarServerInfo("ui_allow_gaz67b", "1");

	level.allow_horch = getCvar("scr_allow_horch");
	if(level.allow_horch == "")
		level.allow_horch = "1";
	setCvar("scr_allow_horch", level.allow_horch);
	setCvar("ui_allow_horch", level.allow_horch);
	makeCvarServerInfo("ui_allow_horch", "1");
}

restrictPlacedVehicles()
{
	if(level.allow_jeeps == "0")
	{
		deletePlacedEntity("willyjeep_mp");
		deletePlacedEntity("gaz67b_mp");
		deletePlacedEntity("horch_mp");
		return;
	}
	
	if(level.allow_willyjeep != "1")
		deletePlacedEntity("willyjeep_mp");
	if(level.allow_gaz67b != "1")
		deletePlacedEntity("gaz67b_mp");
	if(level.allow_horch != "1")
		deletePlacedEntity("horch_mp");
		
	level.vehicle_limit_jeep = getCvarInt("scr_vehicle_limit_jeep");
	if (level.vehicle_limit_jeep)
	{
		maps\mp\_util_mp_gmi::restrict_vehicle_count( "willyjeep_mp", level.vehicle_limit_jeep );
		maps\mp\_util_mp_gmi::restrict_vehicle_count( "gaz67b_mp", level.vehicle_limit_jeep );
		maps\mp\_util_mp_gmi::restrict_vehicle_count( "horch_mp", level.vehicle_limit_jeep );
	}
}

deletePlacedEntity(vehicletype)
{
	tanks = getentarray("script_vehicle","classname");

	for(i=0;i<tanks.size;i++)
	{
		if (tanks[i].vehicletype == vehicletype)
		{
			// precache effects and setup for death model change
			println("DELETED: ", tanks[i].vehicletype);
			tanks[i] delete();
		}
	}
}

// returns 0 if this vehicle can be spawned in the current map
canSpawnVehicleType(vehicletype)
{
	tanks = getentarray("script_vehicle","classname");

	for(i=0;i<tanks.size;i++)
	{
		if (tanks[i].vehicletype == vehicletype)
			return 1;
	}
	
	return 0;
}

// returns the vehicle entity that was spawned, undefined if the position is invalid
spawnVehicle( vehicletype, range_origin, range_limit, spawner_origin )
{
	if (!canSpawnVehicleType( vehicletype ))
		return undefined;
		
	if (!isdefined( level.spawnVehicle_CheckNum ) || (level.spawnVehicle_CheckNum > 9999))
		level.spawnVehicle_CheckNum = 0;
	level.spawnVehicle_CheckNum += 1;
	if (level.spawnVehicle_CheckNum > 9999)	// prevent overrun issues
		level.spawnVehicle_CheckNum = 1;

	tanks = getentarray("script_vehicle","classname");
	vehspawns = getentarray("script_vehicle_spawn","targetname");
	
	valid_count = 0;
	level.spawnVehicleError = &"";

	for (;;)
	{
		tank = undefined;
		best_dist = 99999;
		dist = best_dist;
		spawn_type = "";
	
		// just find an example vehicle to duplicate
		for(i=0;i<tanks.size;i++)
		{
			if (isdefined(tanks[i].spawnVehicle_CheckNum) && tanks[i].spawnVehicle_CheckNum == level.spawnVehicle_CheckNum)
				continue;	// already tried this vehicle
			if (tanks[i].vehicletype != vehicletype)
				continue;
			spawner = tanks[i];
			break;
		}

		if (!isdefined( spawner ))
			return undefined;
			
		// first try map placed vehicles
		for(i=0;i<tanks.size;i++)
		{
			if (isdefined(tanks[i].spawnVehicle_CheckNum) && tanks[i].spawnVehicle_CheckNum == level.spawnVehicle_CheckNum)
				continue;	// already tried this vehicle
			if (isdefined( range_origin ) && isdefined( range_limit ))
			{
				if (!isdefined( tanks[i].spawn_origin ))
					tanks[i].spawn_origin = tanks[i].origin;
				dist = distance( range_origin, tanks[i].spawn_origin );
				if (dist > range_limit)
					continue;
			}
			valid_count++;
			if (isdefined( spawner_origin ))
			{
				dist = distance( spawner_origin, tanks[i].spawn_origin );
			}			
			if (dist > best_dist)
				continue;

			// try this one			
			tank = tanks[i];
			best_dist = dist;
			spawn_type = "vehicle";
		}

		// now check spawn points
		for(i=0;i<vehspawns.size;i++)
		{
			if (isdefined(vehspawns[i].spawnVehicle_CheckNum) && vehspawns[i].spawnVehicle_CheckNum == level.spawnVehicle_CheckNum)
				continue;	// already tried this vehicle
			if (isdefined( range_origin ) && isdefined( range_limit ))
			{
				dist = distance( range_origin, vehspawns[i].spawn_origin );
				if (dist > range_limit)
					continue;
			}
			valid_count++;
			if (isdefined( spawner_origin ))
			{
				dist = distance( spawner_origin, vehspawns[i].spawn_origin );
			}			
			if (dist > best_dist)
				continue;

			// try this one			
			tankspawn = vehspawns[i];
			best_dist = dist;
			spawn_type = "spawnpoint";
		}
		
		if (spawn_type == "")
		{
			if (!valid_count)
				level.spawnVehicleError = &"PURCHASE_VEHICLE_UNAVAILABLE_AT_LOCATION";
			else
				level.spawnVehicleError = &"PURCHASE_VEHICLE_CANNOT_SPAWN";
			return undefined;
		}
		
		// dont check this one again
		if (spawn_type == "vehicle")
			tank.spawnVehicle_CheckNum = level.spawnVehicle_CheckNum;
		else
			tankspawn.spawnVehicle_CheckNum = level.spawnVehicle_CheckNum;
			
		newtank = spawner spawnduplicate();

		if (isdefined( veh_origin ) && !isdefined( range_limit)) {
			newtank.origin = veh_origin;
		} else if (spawn_type == "spawnpoint") {
			newtank.origin = tankspawn.origin;
			newtank.angles = tankspawn.angles;
		} else {
			newtank.origin = tank.origin;
			newtank.angles = tank.angles;
		}

		if (!(newtank verifyposition(1)))	// if it's valid, then set the new position
		{	// not a valid position
			newtank delete();
			continue;
		}
		
		// got to here, so keep it
		break;
	}

	// make sure this vehicle deletes itself when it dies, rather than waiting around to be respawned
	newtank.respawn = 0;

	newtank unlinkfromworld();
	
	wait 0.2;	// let it drop to the ground

	newtank clearvehicleposition();
	
	newtank thread init( 0 );

	newtank linkintoworld();
	
	return newtank;
}
timeoutVehicleOwner( timeout )
{
	self endon("kill_vehicle_owner");
	
	wait timeout;
	
	self.vehicle_owner = level.vehicle_no_owner;
	
	if (isdefined( self.purchase_indicator ))
		self.purchase_indicator delete();
}

clearVehicleOwner()
{
	self waittill("kill_vehicle_owner");
	
	self.vehicle_owner = level.vehicle_no_owner;
	
	if (isdefined( self.purchase_indicator ))
		self.purchase_indicator delete();
}

setVehicleOwner( owner, timeout )
{
	if (!isvalidplayer( owner ))
		return;
		
	self.vehicle_owner = owner;
	
	if (isdefined( timeout )) {
		self thread timeoutVehicleOwner( timeout );
		self thread clearVehicleOwner();
	}
}