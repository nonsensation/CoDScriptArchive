// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/fallschirmjager_nco");
	character\_utility::attachFromArray(xmodelalias\head_axis::main());
	self.hatModel = "xmodel/germanFallschirmHelmet";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	precacheModel("xmodel/fallschirmjager_nco");
	character\_utility::precacheModelArray(xmodelalias\head_axis::main());
	precacheModel("xmodel/germanFallschirmHelmet");
}
