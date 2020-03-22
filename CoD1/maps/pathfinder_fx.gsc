main()
{
	precacheFX();
    spawnWorldFX();    
    
	level.earthquake["medium"]["magnitude"] = 0.7;
	level.earthquake["medium"]["duration"] = 2.0;
	level.earthquake["medium"]["radius"] = 2500;
}

precacheFX()
{
    level._effect["medfire"]			= loadfx ("fx/fire/tinybon.efx"); 

    level._effect["antiair single tracer"]	= loadfx ("fx/atmosphere/antiair_single_tracer.efx");
    level._effect["antiair tracers"]	= loadfx ("fx/atmosphere/antiair_tracers.efx");
    level._effect["flak flash"]			= loadfx ("fx/atmosphere/flash2flak.efx");
    level._effect["flak flash 2"]		= loadfx ("fx/atmosphere/flash2flak2.efx");
    level._effect["flak flash 3"]		= loadfx ("fx/atmosphere/flash2flak3.efx");

    level._effect["fireheavysmoke"]		= loadfx ("fx/fire/fireheavysmoke.efx");
    level._effect["flameout"]			= loadfx ("fx/tagged/flameout.efx");      

    level._effect["flak solo"]			= loadfx ("fx/atmosphere/flash2flak_slow.efx");

    level._effect["distant 88s"]		= loadfx ("fx/atmosphere/distant88s.efx");

    level._effect["longrange flash"]	= loadfx ("fx/atmosphere/longrangeflash_altocloud.efx");
    level._effect["c47flyover2d"]		= loadfx ("fx/atmosphere/c47squadron_huge.efx");
    level._effect["low burst"]			= loadfx ("fx/atmosphere/lowlevelburst.efx");
    level._effect["light"]				= loadfx ("fx/misc/dynamic_light.efx");
    
    level._effect["wood"]				= loadfx ("fx/cannon/wood.efx");
    level._effect["dust"]				= loadfx ("fx/cannon/dust.efx");
//    level._effect["fire"]				= loadfx ("fx/tagged/flameout.efx");
    level._effect["fire"]				= loadfx ("fx/fire/pathfinder_flames.efx");
    level._effect["explosion"]			= loadfx ("fx/explosions/pathfinder_explosion.efx");
	level._effect["big explosion"] 		= loadfx ("fx/explosions/pathfinder_explosion.efx");
	
    level._effect["flames"]				= loadfx ("fx/fire/extreme_butwide2.efx");
    level._effect["flames center"]		= loadfx ("fx/fire/pathfinder_extreme.efx");
    level._effect["flames small"]		= loadfx ("fx/fire/pathfinder_tinybon.efx"); 

    level._effect["house smoke"]		= loadfx ("fx/smoke/pathfinder_smoke.efx"); 
    level._effect["special line"]		= loadfx ("fx/impacts/pathfinder_special.efx"); 
    level._effect["special smoke"]		= loadfx ("fx/smoke/pathfinder_special_smoke.efx");
    level._effect["hillflash1"]			= loadfx ("fx/atmosphere/distant88s.efx");
    level._effect["hillflash2"]			= loadfx ("fx/atmosphere/overhill_flash.efx");
    level._effect["mortar distant1"]	= loadfx ("fx/impacts/newimps/minefield_dark.efx");



}

create_effect (msg, num1, num2, num3, num4, num5, num6)
{
	level.effect_index[msg] = 0;
	if ((!isdefined (level.effect_struct)) || (!isdefined (level.effect_struct [msg])))
		level.effect_struct[msg][0] = spawnstruct();
	else
		level.effect_struct[msg][level.effect_struct[msg].size] = spawnstruct();
	
	num = level.effect_struct[msg].size - 1;
	level.effect_struct[msg][num].num1 = num1;
	level.effect_struct[msg][num].num2 = num2;
	level.effect_struct[msg][num].num3 = num3;
	level.effect_struct[msg][num].num4 = num4;
	level.effect_struct[msg][num].num5 = num5;
	level.effect_struct[msg][num].num6 = num6;
}

spawnWorldFX()
{
	create_effect ("antiair tracers", 1, 4, 5.2, 3.4, 3.2, 4.5); 
	create_effect ("antiair tracers", 2, 4, 9.2, 4.4, 1.2, 4.5); 
	create_effect ("antiair tracers", 2, 3, 5.1, 6.4, 2.1, 5.3); 

	create_effect ("longrange flash", 1, 2, 10, 60, 10, 40); 
	create_effect ("longrange flash", 1, 2, 10, 60, 5, 40); 

	create_effect ("flak flash 2", 4, 8, 2.5, 3.6, 5, 20); 
	create_effect ("flak flash 2", 3, 6, 0.2, 1.5, 5, 10); 
	create_effect ("flak flash 2", 3, 6, 0.2, 1.5, 5, 20); 
	create_effect ("distant 88s", 4, 10, 10, 30, 15, 40); 
	create_effect ("distant 88s", 3, 8, 10, 30, 15, 40); 
	create_effect ("distant 88s", 3, 8, 10, 30, 15, 40); 
	create_effect ("low burst", 3, 8, 1, 3, 1, 4); 
	create_effect ("low burst", 3, 8, 0.1, 3, 1, 2); 
}

fieldBattle ()
{
	println ("^2 Field battle 1");
	maps\_fx::gunfireLoopfx("hillflash2", (2567, 6354, 219),
							1, 4,
							1.2, 2.4,
							2.2, 2.5);
	wait (1);
	maps\_fx::gunfireLoopfx("hillflash2", (-4349, 10339, 253),
							1, 4,
							15.2, 3.4,
							3.2, 4.5);
	wait (0.8);
	maps\_fx::gunfireLoopfx("hillflash2", (-8988, 8018, 436),
							1, 4,
							15.2, 3.4,
							3.2, 4.5);
	wait (0.8);
	maps\_fx::gunfireLoopfx("hillflash1", (-9019, 2384, 418),
							1, 2,
							15.2, 23.4,
							23.2, 24.5);
	wait (0.8);
	maps\_fx::gunfireLoopfx("hillflash1", (2595, 9645, 253),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.8);
	maps\_fx::gunfireLoopfx("hillflash2", (2567, 6354, 219),
							1, 4,
							1.2, 2.4,
							2.2, 2.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash2", (-4349, 10339, 253),
							1, 4,
							15.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash2", (-8988, 8018, 436),
							1, 4,
							15.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (-9019, 2384, 418),
							1, 2,
							15.2, 23.4,
							23.2, 24.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (2595, 9645, 253),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (-329, 11002, 1000),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	println ("^2 Field battle 2");	
	maps\_fx::gunfireLoopfx("antiair tracers", (2840, 6596, 341),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (1467, 4401, 212),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	/*						
	maps\_fx::gunfireLoopfx("mortar distant1", (-57, 8212, 33),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-6103, 6648, 224),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-3196, 5532, 14),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-474, 9068, 76),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	*/
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (-329, 11002, 1000),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (2840, 6596, 341),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (1467, 4401, 212),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
/*							
	maps\_fx::gunfireLoopfx("mortar distant1", (-57, 8212, 33),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-6103, 6648, 224),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-3196, 5532, 14),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	maps\_fx::gunfireLoopfx("mortar distant1", (-474, 9068, 76),
							1, 2,
							5.2, 3.4,
							3.2, 14.5);
	*/							
}