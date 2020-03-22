
main()
{
	precachemodel("xmodel/vehicle_german_condor_destroyed");
	loadfx("fx/explosions/metal_b.efx");
	loadfx("fx/tagged/tailsmoke_flameout2.efx");
	loadfx("fx/tagged/stukka_boom1.efx ");
	loadfx("fx/tagged/stukka_firestream.efx");
}

init()
{
	life();
	thread kill();
}

life()
{
	self.health = 7000;
}

kill()
{
	self.crashfx = loadfx("fx/explosions/metal_b.efx");
	self.smokefx = loadfx("fx/tagged/tailsmoke_flameout2.efx");
	self.explode1 = loadfx("fx/tagged/stukka_boom1.efx ");
	self.explode2 = loadfx("fx/tagged/stukka_firestream.efx");
	self waittill( "death", attacker );
	self playsound ("explo_metal_rand");
	self setmodel("xmodel/vehicle_german_condor_destroyed");

	earthquake(0.25, 3, self.origin, 1050);
	explodesequence();
}

explodesequence()
{
	playfx (self.explode1, self.origin);
	wait .2;
	playfx (self.explode1, self.origin);
	wait .4;
	playfx (self.explode1, self.origin);
}

waitframe()
{
	maps\_spawner::waitframe();
}