// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_german_normandy_officer");
	self attach("xmodel/head_german_normandy_ericp", "", true);
	self.hatModel = "xmodel/helmet_german_normandy_officer_hat";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	precacheModel("xmodel/character_german_normandy_officer");
	precacheModel("xmodel/head_german_normandy_ericp");
	precacheModel("xmodel/helmet_german_normandy_officer_hat");
}
