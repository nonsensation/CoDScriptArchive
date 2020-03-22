main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
	level._effect["smallbon"]			= loadfx ("fx/fire/smallbon.efx"); 
	level._effect["lowFire"]			= loadfx ("fx/fire/em_fire1.efx");
	level._effect["gigantor"]	  		= loadfx ("fx/smoke/gigantor.efx"); 
}

spawnWorldFX()
{
      maps\_fx::loopfx("smallbon", (5152, 12014, 150), 0.3);
      maps\_fx::loopfx("smallbon", (3911, 12916, 390), 0.3);
      maps\_fx::loopfx("smallbon", (4793, 12794, 400), 0.3);
      maps\_fx::loopfx("lowFire", (3841, 11850, 390), 0.4);
      maps\_fx::loopfx("lowFire", (4953, 12733, 564), 0.4);
      maps\_fx::loopfx("gigantor", (8561, 14442, 162), 0.4);  
      maps\_fx::loopfx("gigantor", (2849, 15505, 702), 0.4); 
      maps\_fx::loopfx("gigantor", (4528, 20952, 396), 0.4);
      maps\_fx::loopfx("gigantor", (2810, 17402, 892), 0.4);  
      maps\_fx::loopfx("gigantor", (-613, 22498, 408), 0.4);
      maps\_fx::loopfx("gigantor", (784, 20457, 552), 0.4);
      maps\_fx::loopfx("gigantor", (3913, 23046, 380), 0.4);
      maps\_fx::loopfx("gigantor", (1607, 19809, 400), 0.4);
      maps\_fx::loopfx("smallbon", (5971, 18798, 65), 0.3);
      
      maps\_fx::loopSound("medfire", (5152, 12014, 100), undefined);
      maps\_fx::loopSound("medfire", (3911, 12916, 350), undefined); 
      maps\_fx::loopSound("medfire", (4793, 12794, 360), undefined);
      maps\_fx::loopSound("medfire", (3841, 11867, 390), undefined); 
      maps\_fx::loopSound("medfire", (5971, 18798, 65), undefined); 
}
