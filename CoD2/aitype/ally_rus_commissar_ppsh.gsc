// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_ally_rus_commissar_ppsh (0.0 0.25 1.0) (-16 -16 0) (16 16 72) SPAWNER FORCESPAWN UNDELETABLE NOENEMYINFO
defaultmdl="xmodel/character_russian_winter_body"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
FORCESPAWN -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for FORCESPAWN guys
NOENEMYINFO -- this AI when spawned will not get a snapshot of perfect info about all enemies
*/
main()
{
	self.team = "allies";
	self.accuracy = 0.2;
	self.health = 150;
	self.weapon = "ppsh";
	self.secondaryweapon = "mosin_nagant";
	self.grenadeWeapon = "RGD-33russianfrag";
	self.grenadeAmmo = 0;

	character\russian_winter_trench_jon::main();
}

spawner()
{
	self setspawnerteam("allies");
}

precache()
{
	character\russian_winter_trench_jon::precache();

	precacheItem("ppsh");
	precacheItem("mosin_nagant");
	precacheItem("RGD-33russianfrag");
}
