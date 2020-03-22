/********************************************
	PONYRI.GSC -- Pi Studios
*********************************************/

main()
{
	// PRECACHING / SETUP
	// PGM FIXME - make sure we're not precaching anything we don't need...
	maps\_load_gmi::main();

//---------------------------------------------------------------------

	maps\ponyri_weather::main();

	level.rail_obj_num = 1;
	level.town_obj_num = 2;
	level.school_obj_num = 3;
	level.fapp_obj_num = 4;
	level.factory_obj_num = 5;

	maps\ponyri_anim::main();
	maps\ponyri_fx::main();
	maps\ponyri_sound::main();		// PGM commented out until ponyri_sound.gsc appears
	maps\ponyri_dummies::main();

	maps\_treadfx_gmi::main();
	maps\_t34_gmi::main();
	maps\_panzeriv_gmi::main();

	precachemodel("xmodel/vehicle_tank_t34_destroyed");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");

	// characters
	Setup_Characters();

//-----ACTUAL STUFF HAPPENING BELOW HERE-----

	thread maps\Ponyri_Rail::main();
	thread maps\Ponyri_Factory::main();
	thread maps\ponyri_fa::main();
	thread maps\ponyri_school::main();
	thread maps\ponyri_watertower::main();

	// set environment fog values
	setCullFog (700, 10000, .35, .36, .36, 0 );
}

// Sets up all of the friendly characters that will be with
// the player the entire level.
Setup_Characters()
{
	// Setup friends
	// Vassili
	character\RussianArmyVassili::precache();
	vassili = getent("vassili","targetname");
	vassili.groupname = "friends";
	vassili.goalradius = 64;
	vassili.accuracy = 0.75;
	vassili.animname = "vassili";
	vassili.original_animname = "vassili";
	vassili.bravery = 100;
	vassili.threatbias = -200;
	vassili.grenadeammo = 0;
	vassili.suppressionwait = 1;
	vassili.maxsightdistsqrd = 9000000; // 3000 units
	vassili character\_utility::new();
	vassili character\RussianArmyVassili::main();
	vassili thread maps\_utility_gmi::magic_bullet_shield();
	level.vassili = vassili;

	// Miesha
	character\RussianArmyMiesha::precache();
	miesha = getent("miesha","targetname");
	miesha.groupname = "friends";
	miesha.goalradius = 64;
	miesha.animname = "miesha";
	miesha.original_animname = "miesha";
	miesha.current_spot = 0;
	miesha.accuracy = 0.75;
	miesha.bravery = 100;
	miesha.threatbias = -200;
	miesha.grenadeammo = 0;
	miesha.maxsightdistsqrd = 9000000; // 3000 units
	miesha character\_utility::new();
	miesha character\RussianArmyMiesha_radio::main();
	miesha thread maps\_utility_gmi::magic_bullet_shield();
	level.miesha = miesha;

	// Antonov
	character\RussianArmyAntonov::precache();
	antonov = getent("antonov","targetname");
	antonov.animname = "antonov";
	antonov.groupname = "friends";
	antonov.goalradius = 64;
	antonov.accuracy = 0.15;
	antonov.bravery = 100;
	antonov.threatbias = -200;
	antonov.grenadeammo = 0;
	antonov.name = "Sgt. Antonov";
	antonov.maxsightdistsqrd = 9000000; // 3000 units
	antonov character\_utility::new();
	antonov character\RussianArmyAntonov::main();
	antonov thread maps\_utility_gmi::magic_bullet_shield();
	level.antonov = antonov;

	// Boris
	character\RussianArmyBoris::precache();
	boris = getent("boris","targetname");
	boris.groupname = "friends";
	boris.goalradius = 64;
	boris.animname = "boris";
	boris.original_animname = "boris";
	boris.accuracy = 0.75;
	boris.bravery = 100;
	boris.threatbias = -200;
	boris.grenadeammo = 0;
	boris.maxsightdistsqrd = 9000000; // 3000 units
	boris character\_utility::new();
	boris character\RussianArmyBoris::main();
	boris thread maps\_utility_gmi::magic_bullet_shield();
	level.boris = boris;

	level.friends = getentarray("friends","groupname");
}
