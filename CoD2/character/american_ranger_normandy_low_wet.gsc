// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\body_US_Ranger_American_low_wet::main());
	codescripts\character::attachFromArray(xmodelalias\head_US_Ranger_American_low::main());
	self.hatModel = "xmodel/helmet_us_wet_ranger_generic_low";
	self attach(self.hatModel);
	self.voice = "american";
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\body_US_Ranger_American_low_wet::main());
	codescripts\character::precacheModelArray(xmodelalias\head_US_Ranger_American_low::main());
	precacheModel("xmodel/helmet_us_wet_ranger_generic_low");
}
