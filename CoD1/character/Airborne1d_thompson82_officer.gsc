// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	character\_utility::setModelFromArray(xmodelalias\body_Airborne_82nd::main());
	character\_utility::attachFromArray(xmodelalias\head_allied::main());
	self.hatModel = "xmodel/gear_US_helmet_captain";
	self attach(self.hatModel);
	if (character\_utility::useOptionalModels())
	{
		self attach("xmodel/gear_US_load1");
		self attach("xmodel/gear_US_frnttrnchknf");
		self attach("xmodel/gear_US_thompsonbelt");
	}
	self.voice = "american";
}

precache()
{
	character\_utility::precacheModelArray(xmodelalias\body_Airborne_82nd::main());
	character\_utility::precacheModelArray(xmodelalias\head_allied::main());
	precacheModel("xmodel/gear_US_helmet_captain");
	if (character\_utility::useOptionalModels())
	{
		precacheModel("xmodel/gear_US_load1");
		precacheModel("xmodel/gear_US_frnttrnchknf");
		precacheModel("xmodel/gear_US_thompsonbelt");
	}
}
