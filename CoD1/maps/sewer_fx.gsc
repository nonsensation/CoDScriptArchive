main()
{
	precacheFX();
	spawnWorldFX();
}

precacheFX()
{
	level._effect["water_mist"]			= loadfx ("fx/water/waterfall_mist1.efx");
	level._effect["waterfroth"]			= loadfx ("fx/water/em_froth.efx");  
}

spawnWorldFX()
{
      maps\_fx::loopfx("water_mist", (3105, 745, -415), 0.25, (3106, 745, -415));
      maps\_fx::loopfx("water_mist", (3105, 795, -415), 0.25, (3106, 795, -415));
      
      maps\_fx::loopfx("water_mist", (2816, 740, -415), 0.2, (2815, 740, -415));
      maps\_fx::loopfx("water_mist", (2816, 790, -415), 0.2, (2815, 790, -415));
      
      maps\_fx::loopfx("water_mist", (2680, 2559, -300), 0.2, (2681, 2559, -300));
      
      maps\_fx::loopfx("waterfroth", (3088, 768, -439), 0.7);
      maps\_fx::loopfx("waterfroth", (2832, 768, -439), 0.7);
      maps\_fx::loopfx("waterfroth", (2680, 2559, -315), 0.7);
      
//    maps\_fx::loopSound("medfire", (5152, 12014, 100), undefined);
}

