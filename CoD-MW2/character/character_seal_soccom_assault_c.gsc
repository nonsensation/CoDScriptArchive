// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("body_seal_soccom_assault_c");
	codescripts\character::attachHead( "alias_seal_soccom_heads", xmodelalias\alias_seal_soccom_heads::main() );
	self.voice = "taskforce";
}

precache()
{
	precacheModel("body_seal_soccom_assault_c");
	codescripts\character::precacheModelArray(xmodelalias\alias_seal_soccom_heads::main());
}
