// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("body_airborne_assault_a");
	self attach("head_airport_a", "", true);
	self.headModel = "head_airport_a";
	self.voice = "russian";
}

precache()
{
	precacheModel("body_airborne_assault_a");
	precacheModel("head_airport_a");
}
