// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/character_german_normandy_coat_dark");
	self attach("xmodel/head_german_normandy_josh", "", true);
	self.hatModel = "xmodel/helmet_german_normandy_coat_dark";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	precacheModel("xmodel/character_german_normandy_coat_dark");
	precacheModel("xmodel/head_german_normandy_josh");
	precacheModel("xmodel/helmet_german_normandy_coat_dark");
}
