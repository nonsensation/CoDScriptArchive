// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_us_wet_ranger_sgt_randall");
	self attach("xmodel/head_us_ranger_randall", "", true);
	self.hatModel = "xmodel/helmet_us_wet_ranger_randall";
	self attach(self.hatModel);
	self.voice = "american";
}

precache()
{
	precacheModel("xmodel/character_us_wet_ranger_sgt_randall");
	precacheModel("xmodel/head_us_ranger_randall");
	precacheModel("xmodel/helmet_us_wet_ranger_randall");
}
