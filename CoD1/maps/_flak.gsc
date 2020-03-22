#using_animtree("flak88");
main()
{
	maps\_utility::precache ("xmodel/vehicle_tank_flakpanzer_d");
	maps\_utility::precache ("xmodel/turret_flak88_d");
	maps\_utility::precache ("xmodel/bomb");
	maps\_scripted_turrets::main();
	
	level._effect["flak_burst"] = loadfx ("fx/muzzleflashes/flakkflash.efx");

	script_models = getentarray ("script_model","classname");
	script_vehicles = getentarray ("script_vehicle","classname");

	for(i=0;i<script_vehicles.size;i++)
		script_models = maps\_utility::add_to_array ( script_models , script_vehicles[i]);

	for (i=0;i<script_models.size;i++)
	{
		if ((script_models[i].model == "xmodel/turret_flak88"))
		{
			script_models[i].dead_model = ("xmodel/turret_flak88_d");
			script_models[i] thread maps\_scripted_turrets::flak_animation(i);
			script_models[i] UseAnimTree(#animtree);


			if ((isdefined(script_models[i].script_flaktype) && ((script_models[i].script_flaktype == "flakair") || (script_models[i].script_flaktype == "flakairlow"))  ))
			{
				//if (script_models[i].script_flaktype == "flakair")
				//{
					script_models[i].anim_thread = ::flakers_animation_air;
					script_models[i].getFlakAnim = ::getFlakanim;
				//}
				//else
				//if (script_models[i].script_flaktype == "flakairlow")
				//{
				//	script_models[i].anim_thread = ::flakers_animation_airlow;
				//	script_models[i].getFlakAnim = ::getFlakanim;
				//}
			}
			else
			{
				script_models[i].anim_thread = ::flakers_animation_tank;
				script_models[i].getFlakAnim = ::getFlakanim;
			}
		}
	}
}
/*
	if (isdefined (script_models[i].targetname))
	{
		tempnode = getnodearray (script_models[i].targetname, "target");
		if ((!isdefined (tempnode)) || (tempnode.size == 1))
			script_models[i] thread flak_animation(tempnode[0], i);
	}
*/

#using_animtree("generic_human");
flakers_animation_tank(p)
{
	if (p==0)
	{
		self.atype = "passer";
		self.flakanim["preidle"] = %flak88_passer_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_passer_turn_antitank;
		self.flakanim["fire"] = %flak88_passer_fire;
		self.flakanim["idle"] = %flak88_passer_idle;
		self.flakanim["twitch"] = %flak88_passer_twitch;
	}
	if (p==1)
	{
		self.atype = "loader";
		self.flakanim["preidle"] = %flak88_loader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_loader_turn_antitank;
		self.flakanim["fire"] = %flak88_loader_fire_antitank;
		self.flakanim["idle"] = %flak88_loader_idle_antitank;
		self.flakanim["twitch"] = %flak88_loader_twitch_antitank;
	}
	if (p==2)
	{
		self.atype = "ejecter";
		self.flakanim["preidle"] = %flak88_ejecter_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_ejecter_turn_antitank;
		self.flakanim["fire"] = %flak88_ejecter_fire_antitank;
		self.flakanim["idle"] = %flak88_ejecter_idle_antitank;
		self.flakanim["twitch"] = %flak88_ejecter_twitch_antitank;
	}
	if (p==3)
	{
		self.atype = "leader";
		self.flakanim["preidle"] = %flak88_leader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_leader_turn_antitank;
		self.flakanim["fire"] = %flak88_leader_fire;
		self.flakanim["idle"] = %flak88_leader_idle;
		self.flakanim["twitch"] = %flak88_leader_twitch;
	}
}

flakers_animation_air(p)
{
	if (p==0)
	{
		self.atype = "passer";
		self.flakanim["preidle"] = %flak88_passer_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_passer_turn_antitank;
		self.flakanim["fire"] = %flak88_passer_fire;
		self.flakanim["idle"] = %flak88_passer_idle;
		self.flakanim["twitch"] = %flak88_passer_twitch;
	}
	if (p==1)
	{
		self.atype = "loader";
		self.flakanim["preidle"] = %flak88_loader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_loader_turn_antiair;
		self.flakanim["fire"] = %flak88_loader_fire_antiair;
		self.flakanim["idle"] = %flak88_loader_idle_antiair;
		self.flakanim["twitch"] = %flak88_loader_twitch_antiair;
	}
	if (p==2)
	{
		self.atype = "ejecter";
		self.flakanim["preidle"] = %flak88_ejecter_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_ejecter_turn_antiair;
		self.flakanim["fire"] = %flak88_ejecter_fire_antiair;
		self.flakanim["idle"] = %flak88_ejecter_idle_antiair;
		self.flakanim["twitch"] = %flak88_ejecter_twitch_antiair;
	}
	if (p==3)
	{
		self.atype = "leader";
		self.flakanim["preidle"] = %flak88_leader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_leader_turn_antiair;
		self.flakanim["fire"] = %flak88_leader_fire;
		self.flakanim["idle"] = %flak88_leader_idle;
		self.flakanim["twitch"] = %flak88_leader_twitch;
	}
}

flakers_animation_airlow(p)
{
	if (p==0)
	{
		self.atype = "passer";
		self.flakanim["preidle"] = %flak88_passer_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_passer_turn_antitank;
		self.flakanim["fire"] = %flak88_passer_fire;
		self.flakanim["idle"] = %flak88_passer_idle;
		self.flakanim["twitch"] = %flak88_passer_twitch;
	}
	if (p==1)
	{
		self.atype = "loader";
		self.flakanim["preidle"] = %flak88_loader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_loader_turn_antiair;
		self.flakanim["fire"] = %flak88_loader_fire_antiair;
		self.flakanim["idle"] = %flak88_loader_idle_antiair;
		self.flakanim["twitch"] = %flak88_loader_twitch_antiair;
	}
	if (p==2)
	{
		self.atype = "ejecter";
		self.flakanim["preidle"] = %flak88_ejecter_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_ejecter_turn_antiair;
		self.flakanim["fire"] = %flak88_ejecter_fire_antiair;
		self.flakanim["idle"] = %flak88_ejecter_idle_antiair;
		self.flakanim["twitch"] = %flak88_ejecter_twitch_antiair;
	}
	if (p==3)
	{
		self.atype = "leader";
		self.flakanim["preidle"] = %flak88_leader_preturnidle_antitank;
		self.flakanim["turn"] = %flak88_leader_turn_antiair;
		self.flakanim["fire"] = %flak88_leader_fire;
		self.flakanim["idle"] = %flak88_leader_idle;
		self.flakanim["twitch"] = %flak88_leader_twitch;
	}
}

#using_animtree("flak88");
getFlakanim(flaktype)
{
	println ("Flaktype is: " + flaktype);
	if (flaktype == "flaktank")
	{
		println ("GetFlakAnim was tank");
		flakanim["preidle"] 	= %flak88_gun_preturnidle_antitank;
		flakanim["turn"] 	= %flak88_gun_turn_antitank;
		flakanim["fire"] 	= %flak88_gun_fire_antitank;
		flakanim["idle"] 	= %flak88_gun_idle_antitank;
		flakanim["twitch"] 	= %flak88_gun_twitch_antitank;
	}
	if (flaktype == "flakairlow")
	{
		println ("GetFlakAnim was airlow");
		//flakanim["preidle"] 	= %flak88_gun_preturnidle_antitank;
		//flakanim["turn"] 	= %flak88_gun_turn_antitank;
		flakanim["fire"] 	= %flak88_gun_fire_antiairlow;
		flakanim["idle"] 	= %flak88_gun_idle_antiairlow;
		//flakanim["twitch"] 	= %flak88_gun_twitch_antitank;
	}
	else
	{
		println ("GetFlakAnim was air");
		flakanim["preidle"] 	= %flak88_gun_preturnidle_antiair;
		flakanim["turn"] 	= %flak88_gun_turn_antiair;
		flakanim["fire"] 	= %flak88_gun_fire_antiair;
		flakanim["idle"] 	= %flak88_gun_idle_antiair;
		flakanim["twitch"] 	= %flak88_gun_twitch_antiair;
	}

	return flakanim;
}

flak88_playerinit(flak1, flak2)
{
	self endon ("death");
	
	level.fireicon = newHudElem();			
	level.fireicon.alignX = "center";
	level.fireicon.alignY = "middle";
	level.fireicon.x = 590;
	level.fireicon.y = 420;
	level.fireicon setShader("gfx/hud/hud@fire_ready_shell.tga", 64, 64);
	level.fireicon.alpha = 0;
	level.playerusingflak = 0;
	level.flags["FireIcon"] = false;
	
	self thread flak_hud_removeicon();
	
	if ( (isdefined (flak1)) && (isdefined (flak2)) )
	{
		while(1)
		{
			eFlak88_1_user = flak1 getVehicleOwner();
			eFlak88_2_user = flak2 getVehicleOwner();
			if ((isdefined(eFlak88_1_user)) || (isdefined(eFlak88_2_user)))
			{
				level.playerusingflak = 1;
				if (level.flags["FireIcon"] == false)
				{
					flak1 thread flak_hud_fireicon();
					flak2 thread flak_hud_fireicon();
				}
			}
			else
			{
				level.playerusingflak = 0;
				level.fireicon.alpha = 0;
				level notify ("player not on turret");
				level.flags["FireIcon"] = false;
			}
			wait 0.35;
		}
	}
	else
	{
		while(1)
		{
			eFlak88user = self getVehicleOwner();	
			if(isdefined(eFlak88user))
			{
				level.playerusingflak = 1;
				if (level.flags["FireIcon"] == false)
					self thread flak_hud_fireicon();
			}
			else
			{
				level.playerusingflak = 0;
				level.fireicon.alpha = 0;
				level notify ("player not on turret");
				level.flags["FireIcon"] = false;
			}
			wait 0.15;
		}
	}
	
	
}

flak_hud_fireicon()
{
	level endon ("player not on turret");
	level.flags["FireIcon"] = true;
	while (level.playerusingflak == 1)
	{
		level.fireicon.alpha = 1;
		self waittill ("turret_fire");
		level.fireicon.alpha = 0;
		wait 4;
	}
}

flak_hud_removeicon()
{
	self waittill ("death");
	level.fireicon.alpha = 0;
	level notify ("player not on turret");
	level.flags["FireIcon"] = false;
}