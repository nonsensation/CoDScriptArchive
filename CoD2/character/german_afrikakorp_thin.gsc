// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_german_afrca_body");
	codescripts\character::attachFromArray(xmodelalias\head_german_afrikakorp::main());
	self.hatModel = "xmodel/helmet_german_africa";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	precacheModel("xmodel/character_german_afrca_body");
	codescripts\character::precacheModelArray(xmodelalias\head_german_afrikakorp::main());
	precacheModel("xmodel/helmet_german_africa");
}
