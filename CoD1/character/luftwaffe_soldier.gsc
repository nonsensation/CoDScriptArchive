// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("xmodel/luftwaffe_soldier");
	character\_utility::attachFromArray(xmodelalias\head_axis::main());
	self.hatModel = "xmodel/germanhelmet";
	self attach(self.hatModel);
	self.voice = "german";
}

precache()
{
	precacheModel("xmodel/luftwaffe_soldier");
	character\_utility::precacheModelArray(xmodelalias\head_axis::main());
	precacheModel("xmodel/germanhelmet");
}
