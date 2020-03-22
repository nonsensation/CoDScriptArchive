//sicily1.fx
main()
{
	precacheFX();
//	spawnWorldFX();
	spawnSoundfx();
}

precacheFX()
{
	level._effect["guns_shoot"]		= loadfx("fx/map_sicily1/muzzleflash_biggun");	
	level._effect["radio_exp"]		= loadfx("fx/map_sicily1/radio_exp");
	level._effect["light_beam"]		= loadfx("fx/map_sicily1/v_light_lighthouse");
	level._effect["wood"]			= loadfx ("fx/explosions/green_box.efx");
	level._effect["boatwood"]		= loadfx("fx/map_sicily1/boatwood.efx");

	level._effect["debris_trail_50"]	= loadfx ("fx/dirt/dust_trail_50.efx");
	level._effect["debris_trail_25"]	= loadfx ("fx/dirt/dust_trail_25.efx");
	level._effect["debris_trail_100"]	= loadfx ("fx/dirt/dust_trail_100.efx");

	level._effect["lh_bomb1"]		= loadfx ("fx/map_sicily1/lighthouse_bomb_1.efx");
	level._effect["lh_bomb2"]		= loadfx ("fx/map_sicily1/lighthouse_bomb_2.efx");
	level._effect["lh_bomb3"]		= loadfx ("fx/map_sicily1/lighthouse_bomb_3.efx");
	level._effect["lh_bomb4"]		= loadfx ("fx/map_sicily1/lighthouse_bomb_4.efx");

	level._effect["spray"]			= loadfx("fx/vehicle/watersprayboat_spraymain.efx");
	level._effect["wake"]			= loadfx("fx/vehicle/wakeboat_fishing.efx");
	level._effect["kubel_exp"]		= loadfx("fx/explosion/vehicles/kubelwagon_complete.efx");

	level._effect["guns_exp"]		= loadfx("fx/map_sicily1/biggun_exp_interior.efx");
	level._effect["lh_glass"]		= loadfx("fx/map_sicily1/lighthouse_glass.efx");
	level._effect["red_barrel"]		= loadfx("fx/weapon/explosions/rocket_metal.efx");
	
	level._effect["lighthouse_firetrail"]	= loadfx("fx/fire/fire_trail_25.efx");
	level._effect["cliff_impact"]		= loadfx("fx/map_sicily1/cliff_impact.efx");
	level._effect["fire_lighthouse"]	= loadfx("fx/map_sicily1/fire_lighthouse_base.efx");
}

spawnWorldFX()
{
}

spawnSoundfx()
{
	maps\_fx_gmi::loopSound("waterlap", (1714, -4515,-55));
	maps\_fx_gmi::loopSound("dock_creeks", (1714, -4515,-55));
	maps\_fx_gmi::loopSound("waterlap", (3525, -4686,-55));
	maps\_fx_gmi::loopSound("dock_creeks", (3525, -4686,-55));
	maps\_fx_gmi::loopSound("waterlap", (3553, -3841,-55));
	maps\_fx_gmi::loopSound("dock_creeks", (3553, -3841,-55));
	maps\_fx_gmi::loopSound("waterlap", (2508, -2791,-55));
	maps\_fx_gmi::loopSound("dock_creeks", (2508, -2791,-55));
}


boat_wake(dummy)
{

	self endon ("death");
	fullwakespeed = 200.00;  // speed at which the spray effect will be played at 1
	fullsprayspeed = 930.00;  // speed at which the spray effect will be played at 1
	accspraydist = 0.001;  // define accumulated spray distance
	accwakedist = 0.001;  // define accumulated wake distance	
	wakedist = 54; // every wakedist units spit out an a wake effect
	spraydist = 22; // every spraydist units spit out an a spray effect

	while(1)
	{
		oldorg = self.origin;
		wait .15;
		dist = distance(oldorg,self.origin);
		accspraydist += dist;
		accwakedist += dist;
		vectang = (0,0,0);

		self.speed = dist;
		if(self.speed > 1)
		{
			speedtimes = self.speed/fullsprayspeed;
/*
			if(accspraydist > spraydist)
			{
				vectang = anglestoforward(self gettagangles ("tag_spray_fl"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level._effect["spray"], self gettagorigin ("tag_spray_fl"),vectang);
				vectang = anglestoforward(self gettagangles ("tag_spray_fr"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level._effect["spray"], self gettagorigin ("tag_spray_fr"),vectang);
				vectang = anglestoforward(self gettagangles ("tag_backspray"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level._effect["spray"], self gettagorigin ("tag_backspray"),vectang);
				accspraydist -= spraydist;  //reset accumulated distance and start over
			}
*/
			if(accwakedist > wakedist)
			{
				vectang = (0,0,self.angles[2]);
				vectang = vectornormalize(vectang);
				playfx (level._effect["wake"], self gettagorigin ("tag_backspray"),vectang);
				accwakedist -= wakedist;  //reset accumulated distance and start over
			}
		}
	}
}
