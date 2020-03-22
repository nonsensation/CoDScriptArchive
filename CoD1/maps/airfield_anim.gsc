#using_animtree ("generic_human");

main()
{
	if(!isdefined(level.scr_anim))
		level.scr_anim = [];

	level.scr_anim["airfield_waters_comingupairfield"] = %Airfield_facial_Waters_036_comingup;
	level.scr_anim["airfield_waters_blimeybeauty"] = %Airfield_facial_Waters_037alt_ourplane;
	level.scr_anim["airfield_waters_dontshootplane"] = %Airfield_facial_Waters_038_dontshoot;
	level.scr_anim["airfield_waters_lightupstukas"] = %Airfield_facial_Waters_039alt_bloodystukkas;
	level.scr_anim["airfield_waters_divebombers"] = %Airfield_facial_Waters_040_divebombers;

	level.scr_anim["airfield_waters_keepstukasoff"] = %Airfield_facial_Waters_041alt_offus;
	level.scr_anim["airfield_waters_outoftime"] = %Airfield_facial_Waters_044_intruck;

	level.scr_anim["airfield_price_bloodystukas"] = %Airfield_facial_Price_037alt_takestukkas;
	level.scr_anim["airfield_price_planeisready"] = %Airfield_facial_Price_038alt_planeready;


	level.scr_anim["truckride_waters_germanlorry"] = %Truckride_facial_Waters_015_behindus;
	level.scr_anim["truckride_waters_insights"] = %Truckride_facial_Waters_018alt_takeout;
}
