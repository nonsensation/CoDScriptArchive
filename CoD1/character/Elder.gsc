// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_Elder");
	self attach("xmodel/head_Elder");
	self.hatModel = "xmodel/gear_US_helmet_net";
	self attach(self.hatModel);
	if (character\_utility::useOptionalModels())
	{
		self attach("xmodel/gear_US_Elder");
	}
	self.voice = "elder";
}

precache()
{
	precacheModel("xmodel/character_Elder");
	precacheModel("xmodel/head_Elder");
	precacheModel("xmodel/gear_US_helmet_net");
	if (character\_utility::useOptionalModels())
	{
		precacheModel("xmodel/gear_US_Elder");
	}
}
