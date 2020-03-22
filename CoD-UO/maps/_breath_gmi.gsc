// Breath FX GO!

breath_fx_main()
{
	level._effect["breath_fx"]			= loadfx ("fx/atmosphere/cold_breath.efx");
	//level._effect["breath_fx"]			= loadfx ("fx/smoke/smoke_grenade_blue.efx"); // for debugging breath fx
}

breath_fx_init()
{	
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	
	self endon ("death");
	
	effect = level._effect["breath_fx"];
	
	wait randomint(5);
	
	while (isalive(self))
	{
		//head = self getTagOrigin ("Bip01 Head");
		playfxontag (effect, self, "Bip01 Head");
		//playfx (effect, head);
		wait randomfloatrange(3.5,4.5);
	}
}