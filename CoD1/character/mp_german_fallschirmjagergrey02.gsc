// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/playerbody_german_fallschirmjagergrey");
	character\_utility::attachFromArray(xmodelalias\head_axis::main());
	self.hatModel = "xmodel/gear_german_helmet_falshrm_blk";
	self attach(self.hatModel);
	self setViewmodel("xmodel/viewmodel_hands_fallschirmjager_grey");
	if (character\_utility::useOptionalModels())
	{
		self attach("xmodel/gear_german_load2_falshrm");
		self attach("xmodel/gear_german_bandolier");
	}
	self.voice = "american";
}

precache()
{
	precacheModel("xmodel/playerbody_german_fallschirmjagergrey");
	character\_utility::precacheModelArray(xmodelalias\head_axis::main());
	precacheModel("xmodel/gear_german_helmet_falshrm_blk");
	precacheModel("xmodel/viewmodel_hands_fallschirmjager_grey");
	if (character\_utility::useOptionalModels())
	{
		precacheModel("xmodel/gear_german_load2_falshrm");
		precacheModel("xmodel/gear_german_bandolier");
	}
}
