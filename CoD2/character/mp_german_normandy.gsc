// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\mp_body_german_normandy::main());
	codescripts\character_mp::attachFromArray(xmodelalias\mp_head_german_normandy::main());
	self.hatModel = "xmodel/helmet_german_normandy";
	self attach(self.hatModel, "", true);
	self setViewmodel("xmodel/viewmodel_hands_german");
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\mp_body_german_normandy::main());
	codescripts\character::precacheModelArray(xmodelalias\mp_head_german_normandy::main());
	precacheModel("xmodel/helmet_german_normandy");
	precacheModel("xmodel/viewmodel_hands_german");
}
