// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/playerbody_russian_conscript_winter");
	character\_utility::attachFromArray(xmodelalias\head_allied::main());
	self.hatModel = "xmodel/sovietequipment_sidecap";
	self attach(self.hatModel);
	self setViewmodel("xmodel/viewmodel_hands_russian");
	if (character\_utility::useOptionalModels())
	{
		self attach("xmodel/gear_russian_load_ocoat");
		self attach("xmodel/gear_russian_ppsh_ocoat");
	}
	self.voice = "american";
}

precache()
{
	precacheModel("xmodel/playerbody_russian_conscript_winter");
	character\_utility::precacheModelArray(xmodelalias\head_allied::main());
	precacheModel("xmodel/sovietequipment_sidecap");
	precacheModel("xmodel/viewmodel_hands_russian");
	if (character\_utility::useOptionalModels())
	{
		precacheModel("xmodel/gear_russian_load_ocoat");
		precacheModel("xmodel/gear_russian_ppsh_ocoat");
	}
}
