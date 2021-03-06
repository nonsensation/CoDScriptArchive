// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_ally_airborne_medic (0.0 0.25 1.0) (-16 -16 0) (16 16 72) SPAWNER FORCESPAWN UNDELETABLE NOENEMYINFO
defaultmdl="xmodel/Airborne"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
FORCESPAWN -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for FORCESPAWN guys
NOENEMYINFO -- this AI when spawned will not get a snapshot of perfect info about all enemies
*/
main()
{
	self.team = "allies";
	self.accuracy = 0.4;
	self.health = 350;
	self.weapon = "m1carbine_medic";
	self.secondaryweapon = "";
	self.grenadeWeapon = "fraggrenade";
	self.scariness = 1;
	self.bravery = 6;
	self.grenadeAmmo = 0;

	character\Airborne_medic::main();
}

spawner()
{
	self setspawnerteam("allies");
}

precache()
{
	character\Airborne_medic::precache();

	precacheItem("m1carbine_medic");
	precacheItem("fraggrenade");
}
