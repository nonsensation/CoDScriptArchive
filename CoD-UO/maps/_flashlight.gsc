#using_animtree("generic_human");

_kill_flashlight()
{
	while(1)
	{
//		if (self.health < 5) break;
		if (self.script_flashlight == 0) break;				
		wait(0.05);
	}
	println("^6 Stopping Flashlight");
	stopattachedfx( self );
	if (isdefined(self.flashlight_model))
	{	
		self.flashlight_model unlink();
		self.flashlight_model delete();
	}
	self.flashlight_thread = undefined;
}

_add_flashlight()
{
	tagstr = "TAG_WEAPON_LEFT";

	println("adding flashlight");

	self.flashlight_model = spawn ("script_model", (0,0,0));
	self.flashlight_model setmodel (level.flashlight_model_on);
	self.flashlight_model linkto(self, tagstr, (0,0,0), (0,0,0));
	wait(0.05);

	playfxOnTag ( level.flashlight_particle , self ,tagstr  );

	if (randomint(2)==0)
		self.run_noncombatanim = %c_flashlight_run_a;
	else
		self.run_noncombatanim = %c_flashlight_run_b;

	if (randomint(2)==0)
		self.walk_noncombatanim = %c_flashlight_walk_a;
	else
		self.walk_noncombatanim = %c_flashlight_walk_b;

	if (randomint(2)==0)
		self.walk_noncombatanim2 = %c_flashlight_walk_a;
	else
		self.walk_noncombatanim2 = %c_flashlight_walk_b;

	self.run_noncombatanim2 = self.run_noncombatanim;


	self waittill ("combat"); 
	self.script_flashlight = 0;

/*
	vec1 = self.flashlight_model.origin;
	vec2 = vec1 + (0,0,-1000);
	trace_result = bulletTrace(vec1, vec2,false,self);
	self.flashlight_model setmodel (level.flashlight_model_off);
	self.flashlight_model.origin = trace_result["position"];

	while(1)
	{
	
//		playfx ( level.flashlight_particle , self.flashlight_model.origin );
		wait(0.05);
	}

	self.flashlight_model waittill("movedone");
*/

}

_flashlights()
{	
	while(1)
	{
		ai = getaiarray ();

		for (i=0;i<ai.size;i++)
		{
 			if (getCvar("scr_debug_flashlight")=="1")
				ai[i].script_flashlight = 1;

			if (isdefined(ai[i].script_flashlight))
			{
				if (ai[i].script_flashlight==1)
				{
					if (!isdefined(ai[i].flashlight_thread))
					{
						ai[i].flashlight_thread = true;
						ai[i] thread _add_flashlight();
						ai[i] thread _kill_flashlight();
					}
				}
			}
		}
		wait(0.05);
	}
}

/*
	just sits in the level , checking for guys with flashlights
 */
main()
{

	if(getCvar("scr_debug_flashlight") == "")		
		setCvar("scr_debug_flashlight", "0");	

	level.flashlight_particle = loadfx("fx/weapon/muzzleflash/mf_flashlight.efx");
	level.flashlight_model_on = "xmodel/c_ge_eqp_flashlight_on";
	level.flashlight_model_off = "xmodel/c_ge_eqp_flashlight_off";
	precachemodel(level.flashlight_model_on);
	precachemodel(level.flashlight_model_off);

	thread _flashlights();
}

