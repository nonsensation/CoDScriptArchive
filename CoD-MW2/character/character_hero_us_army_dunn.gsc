// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("body_us_army_lmg");
	self attach("head_hero_dunn", "", true);
	self.headModel = "head_hero_dunn";
	self.voice = "american";
}

precache()
{
	precacheModel("body_us_army_lmg");
	precacheModel("head_hero_dunn");
}