main()
{
	precacheFX();
    spawnWorldFX();    
}


	precacheFX()
{
     
      //level._effect["smallbon"]			= loadfx ("fx/fire/smallbon.efx"); 
      level._effect["smoke"]			= loadfx ("fx/smoke/underlitsmoke.efx");
      level._effect["smoke_window"]			= loadfx ("fx/smoke/windowsmoke_col1.efx");
      level._effect["medfire"]			= loadfx ("fx/fire/tinybon.efx"); 
      level._effect["fireWall1"]			= loadfx ("fx/fire/firewallfacade_1.efx");
}

      spawnWorldFX()
{   

       maps\_fx::loopfx("medfire", (-14583, -19397, -45), 0.3);
       maps\_fx::loopfx("medfire", (-18183, -19832, -89), 0.3);
       maps\_fx::loopfx("smoke", (-14847, -19203, 1), 0.3);
       maps\_fx::loopfx("smoke_window", (-17270, -19504, 87), 0.3);
       maps\_fx::loopfx("fireWall1", (-17677, -19565, -82), 0.3);     // -19565
}

