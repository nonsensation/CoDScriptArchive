#include codescripts/character;

main()
{
	self setmodel( "c_zom_zombie_buried_miner_body2_nohat" );
	self.headmodel = codescripts/character::randomelement( xmodelalias/c_zom_zombie_buried_male_heads_als::main() );
	self attach( self.headmodel, "", 1 );
	self.hatmodel = codescripts/character::randomelement( xmodelalias/c_zom_zombie_buried_miner_hats_als::main() );
	self attach( self.hatmodel, "", 1 );
	self.voice = "american";
	self.skeleton = "base";
	self.torsodmg1 = "c_zom_zombie_buried_miner_g_upclean2";
	self.torsodmg2 = "c_zom_zombie_buried_miner_g_rarmoff2";
	self.torsodmg3 = "c_zom_zombie_buried_miner_g_larmoff2";
	self.legdmg1 = "c_zom_zombie_buried_miner_g_lowclean2";
	self.legdmg2 = "c_zom_zombie_buried_miner_g_rlegoff2";
	self.legdmg3 = "c_zom_zombie_buried_miner_g_llegoff2";
	self.legdmg4 = "c_zom_zombie_buried_miner_g_legsoff2";
	self.gibspawn1 = "c_zom_buried_g_rarmspawn";
	self.gibspawntag1 = "J_Elbow_RI";
	self.gibspawn2 = "c_zom_buried_g_larmspawn";
	self.gibspawntag2 = "J_Elbow_LE";
	self.gibspawn3 = "c_zom_buried_g_rlegspawn";
	self.gibspawntag3 = "J_knee_RI";
	self.gibspawn4 = "c_zom_buried_g_llegspawn";
	self.gibspawntag4 = "J_knee_LE";
}

precache()
{
	precachemodel( "c_zom_zombie_buried_miner_body2_nohat" );
	codescripts/character::precachemodelarray( xmodelalias/c_zom_zombie_buried_male_heads_als::main() );
	codescripts/character::precachemodelarray( xmodelalias/c_zom_zombie_buried_miner_hats_als::main() );
	precachemodel( "c_zom_zombie_buried_miner_g_upclean2" );
	precachemodel( "c_zom_zombie_buried_miner_g_rarmoff2" );
	precachemodel( "c_zom_zombie_buried_miner_g_larmoff2" );
	precachemodel( "c_zom_zombie_buried_miner_g_lowclean2" );
	precachemodel( "c_zom_zombie_buried_miner_g_rlegoff2" );
	precachemodel( "c_zom_zombie_buried_miner_g_llegoff2" );
	precachemodel( "c_zom_zombie_buried_miner_g_legsoff2" );
	precachemodel( "c_zom_buried_g_rarmspawn" );
	precachemodel( "c_zom_buried_g_larmspawn" );
	precachemodel( "c_zom_buried_g_rlegspawn" );
	precachemodel( "c_zom_buried_g_llegspawn" );
}
