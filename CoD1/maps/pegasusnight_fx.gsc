main()
{
	precacheFX();
    	spawnWorldFX();    
}

precacheFX()
{
	level._effect["firesmoke"]			= loadfx ("fx/fire/pathfinder_extreme.efx");
	
	level._effect["hillflash1"]			= loadfx ("fx/atmosphere/distant88s.efx");
	level._effect["hillflash2"]			= loadfx ("fx/atmosphere/overhill_flash.efx");
    	level._effect["antiair tracers"]		= loadfx ("fx/atmosphere/antiair_tracers.efx");
    	level._effect["cloudflash1"]			= loadfx ("fx/atmosphere/cloudflash1.efx");
    	level._effect["longrangeflash_altocloud"]	= loadfx ("fx/atmosphere/longrangeflash_altocloud.efx");
    	level._effect["flash2flak"]			= loadfx ("fx/atmosphere/flash2flak.efx");
    	level._effect["flash2flak2"]			= loadfx ("fx/atmosphere/flash2flak2.efx");
    	level._effect["distant88s"]			= loadfx ("fx/atmosphere/distant88s.efx");
    	level._effect["lowlevelburst"]			= loadfx ("fx/atmosphere/lowlevelburst.efx");
}

spawnWorldFX()
{
}

fieldBattle ()
{
	println ("^2 Field battle 1");
	
	/*
	maps\_fx::gunfireLoopfx("hillflash1", (261, -155, -91),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	*/
	
	maps\_fx::gunfireLoopfx("hillflash2", (2972, -9478, 632),
							1, 4,
							1.2, 2.4,
							2.2, 2.5);
	wait (1);
   	maps\_fx::gunfireLoopfx("distant88s", (1082, -6818, 800),
							      3, 8,
							    10, 30,
						            15, 40);
	wait (0.8);
    	maps\_fx::gunfireLoopfx("lowlevelburst", (-3617, -3349, 1391),
							      3, 8,
							    1, 3,
						            1, 4);
	wait (0.8);
	maps\_fx::gunfireLoopfx("flash2flak2", (2291, -5469, 1557),
							      3, 6,
							    0.2, 1.5,
						            5, 10);
	wait (0.8);
	maps\_fx::gunfireLoopfx("hillflash1", (1274, -6375, 952),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.8);						
	maps\_fx::gunfireLoopfx("longrangeflash_altocloud", (1119, -6727, 512),
							      1, 2,
							    10, 60,
						            10, 40);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash2", (-4305, 4244, 45),
							1, 4,
							15.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (-847, 7316, -33),
							1, 2,
							15.2, 23.4,
							23.2, 24.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("flash2flak", (-1614, -5613, 1508),
							      4, 8,
							    2.5, 3.6,
						            5, 20);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (1955, -5247, 40),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (-1973, -6276, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (4260, -6285, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("hillflash1", (-329, 11002, 1000),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (837, -9761, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	wait (0.2);
	maps\_fx::gunfireLoopfx("antiair tracers", (-5657, -6593, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);						
}

supertracers()
{
	maps\_fx::gunfireLoopfx("antiair tracers", (-1516, -7815, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("antiair tracers", (-216, -6599, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("antiair tracers", (2139, -6168, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("antiair tracers", (2807, -4631, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("antiair tracers", (2450, 6006, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
	maps\_fx::gunfireLoopfx("antiair tracers", (-771, 6375, -100),
							1, 2,
							5.2, 3.4,
							3.2, 4.5);
							
							
	maps\_fx::gunfireLoopfx("longrangeflash_altocloud", (1607, -6270, 424),
							      1, 2,
							    10, 60,
						            5, 40);
						            
						          
}