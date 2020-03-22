main()
{
	precacheFX();
	effects = getentarray ("effect","targetname");
	spawnWorldFX(effects);
}

precacheFX()
{
// Explosions =========================//
	level._effect["brick"]	                = loadfx ("fx/map_mp/mp_wall_destroy.efx");
	level._effect["bell_tower_exp"]		= loadfx ("fx/map_mp/mp_belltower_exp.efx");

// FIRE ===============================//
        level._effect["fireplace1"]		= loadfx ("fx/map_mp/mp_fireplace_fire.efx");

// SMOKE ==============================//
        level._effect["fireplace1_chimney"]	= loadfx ("fx/map_mp/mp_smoke_chimney.efx");
}

spawnWorldFX(effects)
{
	wait(1);

	if (isdefined (effects))
	{
		for (i=0;i<effects.size;i++)
		{
			if (effects[i].script_noteworthy == "fireplace1")
			{
			wait(.3);
				level thread maps\mp\_fx::loopfx(effects[i].script_noteworthy, effects[i].origin, 5);
			}

                        else if (effects[i].script_noteworthy == "fireplace1_chimney")
			{
			wait(.3);
				level thread maps\mp\_fx::loopfx(effects[i].script_noteworthy, effects[i].origin, 5);
			}
		}
	}
}
