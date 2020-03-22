#using_animtree("switch_objective");
switch_objective()
{
	level.scr_animtree["switch_objective"] = #animtree;

	level.scr_anim["switch_objective"]["switch_objective_up"]		= (%switch_objective_up);
	level.scr_anim["switch_objective"]["switch_objective_down"]		= (%switch_objective_down);
}

#using_animtree("generic_human");
main()
{
	//iprintlnbold ("Sgt Waters says: We'll head east, destroying any targets of opportunity");
	level.scr_anim["waters"]["headeast_facial"] = (%Rocket_facial_Waters_054_headeast);

	//iprintlnbold ("Sgt Waters says: We'll head east, destroying any targets of opportunity");
	level.scr_anim["waters"]["headeast"] = (%rocket_waters_054_headeast);

	//iprintlnbold ("Sgt Waters says: Martin, Place some explosives on that Flak gun.");
	level.scr_anim["waters"]["destroyflak"] = (%Rocket_facial_Waters_047_needtoblock);

		//iprintlnbold ("Sgt Waters says: Martin, Destroy that Flak gun to the west.");
	level.scr_anim["waters"]["destroyflak_reminder"] = (%Rocket_facial_Waters_048_areyoudeath);

		//iprintlnbold ("Sgt Waters says: Martin, good job on that Flak gun, One more to go.");
	level.scr_anim["waters"]["destroyflak_good"] = (%Rocket_facial_Waters_049_goodshowevans);

	//iprintlnbold ("Sgt Waters says: Excellent use of mines, Jamison.");
	level.scr_anim["waters"]["mines"] = (%Rocket_facial_Waters_050_smashinggooduse);

	//iprintlnbold ("Sgt Waters says: We don’t have enough exposives to destroy these V2s completely.");
	level.scr_anim["waters"]["enoughexplosives"] = (%Rocket_facial_Waters_051_enoughexplosives);

	//iprintlnbold ("Sgt Waters says: Good, now place explosives on those V2s.");
	level.scr_anim["waters"]["placeyourbombs"] = (%Rocket_facial_Waters_052_placeyourbombs);

	///iprintlnbold ("Sgt Waters says: Good, now we escape through the northern bunker.");
	level.scr_anim["waters"]["brilliant"] = (%Rocket_facial_Waters_053_brilliant);
}

