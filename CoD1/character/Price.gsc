// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_Price");
	self attach("xmodel/head_Price");
	self.hatModel = "xmodel/equipment_british_beret_red";
	self attach(self.hatModel);
	if (character\_utility::useOptionalModels())
	{
		self attach("xmodel/gear_british_price");
	}
	self.voice = "price";
}

precache()
{
	precacheModel("xmodel/character_Price");
	precacheModel("xmodel/head_Price");
	precacheModel("xmodel/equipment_british_beret_red");
	if (character\_utility::useOptionalModels())
	{
		precacheModel("xmodel/gear_british_price");
	}
}
