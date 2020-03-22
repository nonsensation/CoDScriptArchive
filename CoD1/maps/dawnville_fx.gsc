main()
{
	precacheFX();
    spawnWorldFX();    
}

precacheFX()
{
	level._effect["flesh small"] = loadfx ("fx/impacts/flesh_hit.efx");
    level._effect["ground"]	= loadfx ("fx/impacts/small_gravel.efx");
    
	level.scr_dyingguy["effect"][0] = "ground";
	level.scr_dyingguy["effect"][1] = "flesh small";
	level.scr_dyingguy["sound"][0] = level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] = "bip01 l thigh";
	level.scr_dyingguy["tag"][1] = "bip01 head";
	level.scr_dyingguy["tag"][2] = "bip01 l calf";
	level.scr_dyingguy["tag"][3] = "bip01 pelvis";
	level.scr_dyingguy["tag"][4] = "tag_breastpocket_right";
	level.scr_dyingguy["tag"][5] = "bip01 l clavicle";
	
    level._effect["stone"]	= loadfx ("fx/cannon/stone.efx");
    level._effect["wood"]	= loadfx ("fx/cannon/wood.efx");
    level._effect["dust"]	= loadfx ("fx/cannon/dust.efx");
    level._effect["glass"]	= loadfx ("fx/cannon/glass.efx");
    level._effect["dirt"]	= loadfx ("fx/impacts/stukastrafe_dirt.efx");
    
    level._effect["smoke1"]	= loadfx ("fx/smoke/dawnville_smoke3.efx");
    level._effect["smoke2"]	= loadfx ("fx/smoke/dawnville_smoke.efx");
    level._effect["smoke3"]	= loadfx ("fx/smoke/dawnville_smoke2.efx");
    level._effect["smoke4"]	= loadfx ("fx/smoke/dawnville_smoke1.efx");
    level._effect["small_windy1"]	= loadfx ("fx/smoke/dawn_small_c1.efx");

}


spawnWorldFX()
{
    maps\_fx::loopfx("smoke1", (1776, -16335, 13), 0.3);
    maps\_fx::loopfx("smoke1", (87, -15543, -12), 0.3);
    maps\_fx::loopfx("smoke1", (2634, -14543, 86), 0.3);
    maps\_fx::loopfx("small_windy1", (-13, -17003, 224), 0.3);
    // maps\_fx::loopfx("smoke1", (110, -15829, 164), 0.3);
    maps\_fx::loopfx("smoke1", (970, -14719, -33), 0.3);
    maps\_fx::loopfx("smoke2", (2079, -17550, 90), 0.3);
    maps\_fx::loopfx("smoke4", (-1198, -17377, -70), 0.3);
    maps\_fx::loopfx("smoke3", (-707, -18404, -99), 0.3);
    maps\_fx::loopfx("smoke3", (176, -16747, 195), 0.2);
    maps\_fx::loopfx("smoke3", (-1315, -17211, 134), 0.2);

}
