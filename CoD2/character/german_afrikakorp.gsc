// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\body_german_afrikakorp::main());
	codescripts\character::attachFromArray(xmodelalias\head_german_afrikakorp::main());
	self.hatModel = "xmodel/helmet_german_africa";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\body_german_afrikakorp::main());
	codescripts\character::precacheModelArray(xmodelalias\head_german_afrikakorp::main());
	precacheModel("xmodel/helmet_german_africa");
}
