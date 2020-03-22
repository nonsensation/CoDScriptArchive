//-------------------------------------
// Kursk_Infantry.gsc
// 
// Handle infantry-tank interactions and combat buffers
// 
// Initial Version: DAY @ 6-29-04
//

#using_animtree("generic_human");

main() {

	// Load explosion death animations
	level.scr_anim["generic"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["generic"]["explode death back"] = %death_explosion_back13;
	level.scr_anim["generic"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["generic"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["generic"]["explode death right"] = %death_explosion_right13;

	// FIX - Run these as needed, once at init!!

	// pak death watch for each of the paks in the level
//	thread watch_pak_death("river_pak_damage_1", "pak43_1");
//	thread watch_pak_death("river_pak_damage_2", "pak43_2");
//	thread watch_pak_death("barrier_pak_damage_1", "barrier_pak");

}


river_init() {

//	spawn_trig = getent("river_farm_spawner", "targetname");

//	if (isdefined(spawn_trig)) {
//		spawn_trig waittill("trigger");
//	}

	// RIVER ---

	// spawn guys at the river, attaching them to damage triggers

	pzs_spawner = getent("river_farm_pzs","targetname");
	guy = pzs_spawner stalingradspawn();

	if(isdefined(guy))
	{
//		FIXME -- for some reason this is being totally ignored by the panzerschrek guy
//		ah HA, the reason is pnazerschreck guys are ignoring their sight distance on corner nodes!!  -- yes it's a bug, no it won't be fixed
//		guy thread run_blind_to_goal(guy.target);
		wait(1);
		guy.maxsightdistsqrd = 10000000;
		guy thread watch_rollover_trigger( "river_roll_2" ); // Fence guys go with the house too
		guy.targetname = "river_death_1";
	}

	spawner1 = getent("river_farm_guy1", "targetname");
	if (isdefined(spawner1)) {
		guy1 = spawner1 stalingradspawn();
		guy1 thread watch_rollover_trigger( "river_roll_1" ); // Fence guys go with the house too
		guy1 thread bind_life_to_parent(guy);
		guy1.targetname = "river_death_1";
	}

	// set up the death trigger for the nearest vehicle
	thread set_life_to_trigger("river_death_1", "targetname", "river_truck3_damage", "river_end");


	spawner2 = getent("river_farm_guy2", "targetname");
	if (isdefined(spawner2)) {
		guy2 = spawner2 stalingradspawn();
		guy2 thread watch_death_trigger( "dam_trig_1a" );
		guy2 thread watch_rollover_trigger( "contact_fence", "103" ); // Fence guys go with the house too
		guy2.targetname = "river_death_2";
	}

	spawner3 = getent("river_farm_guy3", "targetname");
	if (isdefined(spawner3)) {
		guy3 = spawner3 stalingradspawn();
		guy3 thread watch_death_trigger( "dam_trig_1b" );
		guy3 thread watch_rollover_trigger( "contact_fence", "102" ); // Fence guys go with the house too
		guy3.targetname = "river_death_2";
	}

	// set up the death trigger for the house
	thread set_life_to_trigger("river_death_2", "targetname", "dam_trig_1c", "river_end");


}


tunnel_init() {

	// TUNNEL ---

	spawner1 = getent("tunnel_ai_1", "targetname");
	guy1 = undefined;
	if (isdefined(spawner1)) {
		guy1 = spawner1 stalingradspawn();
		wait(1);
		guy1.maxsightdistsqrd = 100000000;
		guy1 thread watch_rollover_trigger( "contact_fence", "215" ); // Fence guys go with the house too
		guy1.targetname = "tunnel_death";
	}

	spawner1 = getent("tunnel_ai_2", "targetname");
	if (isdefined(spawner1)) {
		guy2 = spawner1 stalingradspawn();
		guy2 thread bind_life_to_parent(guy1);
		guy2 thread watch_rollover_trigger( "contact_fence", "215" ); // Fence guys go with the house too
		guy2.targetname = "tunnel_death";
	}

	// set up the death trigger
	thread set_life_to_trigger("tunnel_death", "targetname", "dam_trig_asstunnel_1a", "tunnel_end");
	thread set_life_to_trigger("tunnel_death", "targetname", "dam_trig_asstunnel_1b", "tunnel_end");

}

manage_farm_infantry() {

	// FARM ---

	// spawn guys in the farm houses, attaching them to damage triggers
	// we also attach riffle infantry to panzerfaust infantry

	spawner1 = getent("farm_pzs_guy_1", "targetname");
	guy1 = undefined; // we need this to stay in scope
	if (isdefined(spawner1)) {
		guy1 = spawner1 stalingradspawn();
		guy1.targetname = "farm_death_1";
	}

	spawner5 = getent("farm_guy_1b", "targetname");
	if (isdefined(spawner5)) {
		guy5 = spawner5 stalingradspawn();
		guy5 thread bind_life_to_parent(guy1);
		guy5.targetname = "farm_death_1";
	}

	// set up the death trigger for the house
	thread set_life_to_trigger("farm_death_1", "targetname", "dam_trig_2a", "farm_end");


	spawner3 = getent("farm_pzs_guy_3", "targetname");
	guy3 = undefined;
	if (isdefined(spawner3)) {
		guy3 = spawner3 stalingradspawn();
		guy3 thread watch_death_trigger( "dam_trig_2b" );
	}

	spawner2 = getent("farm_pzs_guy_2", "targetname");
	if (isdefined(spawner2)) {
		guy2 = spawner2 stalingradspawn();
		guy2 thread watch_death_trigger( "dam_trig_2c" );
		guy2 thread bind_life_to_parent(guy3);
	}
}


manage_tunnel_infantry() {

	// TUNNEL ---

	// spawn guys in the tunnel path, attacing them to damage triggers

	// attach these guys to the elephant that is near
	elephant = getent("tunnel_elefant", "targetname" );

	spawner3 = getent("tunnel_guys_3", "targetname");
	guy3 = undefined;
	if (isdefined(spawner3)) {
		guy3 = spawner3 stalingradspawn();
		guy3 thread watch_death_trigger( "tunnel_truck_trigger" );
		guy3 thread watch_rollover_trigger( "tunnel_roll_2"); // Fence guys go with the house too
		guy3 thread bind_life_to_parent(elephant);
	}

	spawner1 = getent("tunnel_guys_1", "targetname");
	if (isdefined(spawner1)) {
		guy1 = spawner1 stalingradspawn();
		guy1 thread watch_death_trigger( "dam_trig_4a" );
		guy1 thread watch_rollover_trigger( "tunnel_roll_1"); // Fence guys go with the house too
		guy1 thread bind_life_to_parent(guy3);
		guy1 thread bind_life_to_parent(elephant);
	}

	spawner2 = getent("tunnel_guys_2", "targetname");
	if (isdefined(spawner2)) {
		guy2 = spawner2 stalingradspawn();
		guy2 thread watch_death_trigger( "dam_trig_4b" );
		guy2 thread watch_rollover_trigger( "tunnel_roll_1"); // Fence guys go with the house too
		guy2 thread bind_life_to_parent(guy3);
		guy2 thread bind_life_to_parent(elephant);
	}


}

// Get a proper death animation
// Taken from 'Bastogne1.gsc' on 6-29-04

getExplodeDeath(msg, org, dist)
{
	if (isdefined (org))
	{
		if (dist < 50)
			return level.scr_anim[msg]["explode death up"];

		ang = vectornormalize ( self.origin - org );
		ang = vectorToAngles (ang);
		ang = ang[1];
		ang -= self.angles[1];
		if (ang <= -180)
			ang += 360;
		else
		if (ang > 180)
			ang -= 360;

		if ((ang >= 45) && (ang <= 135))
			return level.scr_anim[msg]["explode death forward"];
		if ((ang >= -135) && (ang <= -45))
			return level.scr_anim[msg]["explode death back"];
		if ((ang <= 45) && (ang >= -45))
			return level.scr_anim[msg]["explode death right"];

		return level.scr_anim[msg]["explode death left"];
	}

	randdeath = randomint(5);
	if (randdeath == 0)
		return level.scr_anim[msg]["explode death up"];
	else
	if (randdeath == 1)
		return level.scr_anim[msg]["explode death back"];
	else
	if (randdeath == 2)
		return level.scr_anim[msg]["explode death forward"];
	else
	if (randdeath == 3)
		return level.scr_anim[msg]["explode death left"];

	return level.scr_anim[msg]["explode death right"];
}


// Apply explosion death to all of the infantry in the array
// originally - 'do_mortar_deaths ()' from 'Bastogne1.gsc' on 6-29-04

do_explosion_deaths (ai, org)
{
	for (i=0;i<ai.size;i++)
	{
		if (!isalive(ai[i])) continue;
		if (isdefined (ai[i].magic_bullet_shield))
			continue;

		dist = distance (ai[i].origin, org);
		if (dist < 190)
		{
			ai[i].allowDeath = true;
			ai[i].deathAnim = ai[i] getExplodeDeath("generic", org, dist);
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
//			println ("Killing an AI");
			continue;
		}

	}
}

// Set a trigger to watch for the player death
// All deaths will be from explosion

// trig_name: targetname of the trigger, usually a damage trigger
// self: This method should be called on AI ents

watch_death_trigger(trig_name) {

	self endon("death");

	death_trig = getent(trig_name, "targetname");

	if ( !isdefined(death_trig) ) {
		return;
	}

	death_trig waittill("trigger");
	
	self.allowDeath = true;
	self.deathAnim = self getExplodeDeath("generic", blast_pos, dist);
	self DoDamage ( self.health + 50, (0,0,0) );
}


// set "death" on an array of ents upon trigger use 

// ent_array_str - the string used for a specific identifier (i.e. "farm_guy" for groupname)
// ent_array_id  - the entity identifier (i.e. groupname or targetname)
// trig_name     - the targetname for the trigger
// end_condition - an optional level notification

set_life_to_trigger(ent_array_str, ent_array_id, trig_name, end_condition) {

	// optional end cindition
	if (isdefined(end_condition)) {
		level endon(end_condition);
	}

	death_trig = getent(trig_name, "targetname");

	ent_array = getentarray( ent_array_str, ent_array_id );

	if ( !isdefined(death_trig) ) {
		println("^6DEATH TRIGGER: TRIGGER NOT FOUND");
		return;
	} else {
		println("^6DEATH TRIGGER: TRIGGER FOUND");
	}

	if ( !isdefined(ent_array) ) {
		println("^6ENT ARRAY: NOT DEFINED");
		return;
	} else {
		println("^6ENT ARRAY: DEFINED");
	}


	death_trig waittill("trigger");

	// now kill all ents in this array

	for (i = 0; i < ent_array.size; i++) {

		if (isdefined(ent_array[i]) && isalive(ent_array[i])) {

			ent_array[i].allowDeath = true;
			ent_array[i].deathAnim = ent_array[i] getExplodeDeath("generic", blast_pos, dist);
			ent_array[i] DoDamage ( ent_array[i].health + 50, (0,0,0) );
			println("^6DEATH TRIGGER: TRIGGER IS WORKING");
		} else {
			println("^6DEATH TRIGGER: TRIGGER NOT WORKING");
		}
	}

}


// kill infantry on a particular roll over trigger
// This death trigger may be just a normal trigger or 
// it may be trigger that is associated with a roll over
// exploder. In the  exploder case, the exploder id number is 
// pulled in from the groupname.

watch_rollover_trigger(trig_name, exploder_id) {

	self endon("death");

	// if an exploder, find the specific trigger
	death_trig = undefined;
	if (isdefined(exploder_id)) {
		death_trig_array = getentarray(trig_name, "targetname");
		for (i = 0; i < death_trig_array.size; i++) {
			if (death_trig_array[i].groupname == exploder_id) {
				death_trig = death_trig_array[i];
				break;
			}
		}
	} else {
		death_trig = getent(trig_name, "targetname" );
	}

	if ( !isdefined(death_trig) ) {
		return;
	}

	// assume the explosion to be at the center of the trigger
	blast_pos = death_trig.origin;

	death_trig waittill("trigger");

	// make sure the ent is still close to the explosion
	dist = distance (self.origin, blast_pos);

	self.allowDeath = true;
	self.deathAnim = self getExplodeDeath("generic", blast_pos, dist);
	self DoDamage ( self.health + 50, (0,0,0) );

}


// pass in the parent to watch, and self will die with the parent

bind_life_to_parent(parent_ent) {

	self endon ("death");
	
	parent_ent waittill ( "death" );
	println("^6-- PARENT DEATH --");
	self DoDamage ( self.health + 50, (0,0,0) );
}


watch_pak_death(trig_array_name, pak_name) {

	pak_ent = getent(pak_name, "targetname");

	if (!isdefined(pak_ent)) {
		println("^6PAK NOT FOUND: ", pak_name);
		return;
	}

	pak_ent endon("death");

	death_trig_array = getentarray(trig_array_name, "targetname");

	if ( !isdefined(death_trig_array) ) {
		println("^6DEATH TRIGGER ARRAY: TRIGGER NOT FOUND");
		return;
	}

	// build the string that we will wait for
	notify_string = pak_name + "_death";

	// set up all of the death trigger waits
	for (i = 0; i < death_trig_array.size; i++) {
		thread set_trigger_notify(death_trig_array[i], notify_string);
	}

	level waittill(notify_string);

	// kill the pak
	println("^6KILLING PAK");
	pak_ent notify ("death");

}

// raise the notify string once the trigger is triggered
// - Pass in the trigger (not the targetname)

set_trigger_notify(trigger, notify_string) {

	// kill this thread since this routine is, more than likely,
	// called for an array of triggers.

	level endon (notify_string);

	trigger waittill("trigger");
	level notify(notify_string);
}


// when triggername is triggered, set nodename as the goalnode 
triggered_goalnode(triggername,nodename)
{
	self endon("death");

	trigger = getent(triggername,"targetname");
	node = getnode(nodename,"targetname");

	if(isdefined(trigger))
	{
		if(isdefined(node))
		{
			trigger waittill("trigger");
			self thread run_blind_to_goal(nodename);
		}
		else
		{
//			println("kursk_infantry::triggered_goalnode node undefined");
		}
	}
	else
	{
//		println("kursk_infantry::triggered_goalnode trigger undefined");
	}
}

// when triggername is triggered, set the guy's maxsightdistsqrd to 10000000
triggered_wake(triggername)
{
	self endon("death");

	trigger = getent(triggername,"targetname");

	if(isdefined(trigger))
	{
		self waittill("ran_blind_to_goal");
		self.maxsightdistsqrd = 100;
		trigger waittill("trigger");
		self.maxsightdistsqrd = 10000000;
	}
}

run_blind_to_goal( node_name ) {

	self endon ("death");

	// allow the AI to initialize
	wait(0.1);

	// run blindly, do not stop to fight
	self.pacifist = true;
	self.maxsightdistsqrd = 10;
	self.suppressionwait = 0;
	self.goalradius = 64;

	// then force our desired settings
	node = getnode(node_name, "targetname");

	if (!isdefined(node)) {
//		println("^5run_blind_to_goal(): Goal node ", node_name, "^5 not found.");
		return;
	}

	// start running to the node
	self setgoalnode(node);

	// open eyes when we get to the node
	self waittill ( "goal" );

//	println("^5FOUND: Goal node. (me llamo)", self.targetname);

	self.pacifist = false;
	self.maxsightdistsqrd = 10000000;
	self.suppressionwait = 1;

	self notify("ran_blind_to_goal");

}
