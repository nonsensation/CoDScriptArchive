#include maps\_ambient;
main()
{
	//Set the underlying ambient track

	level.ambient_track ["exterior"] = "ambient_rhine_ext";
	level.ambient_track ["interior"] = "ambient_rhine_int";
	thread maps\_utility::set_ambient("exterior");
	
		
	ambientDelay("exterior", 6.0, 10.0); // Trackname, min and max delay between ambient events
	ambientEvent("exterior", "elm_windgust1",	0.4);
	ambientEvent("exterior", "elm_windgust2",	0.4);
	ambientEvent("exterior", "elm_windgust3",	0.4);
	ambientEvent("exterior", "elm_distant_explod1",	0.6);
	ambientEvent("exterior", "elm_distant_explod2",	0.6);
	ambientEvent("exterior", "elm_distant_explod3",	0.6);
	ambientEvent("exterior", "elm_distant_explod4",	0.6);
	ambientEvent("exterior", "elm_distant_explod5",	0.6);
	ambientEvent("exterior", "elm_distant_explod6",	0.6);
	ambientEvent("exterior", "elm_distant_explod7",	0.6);
	ambientEvent("exterior", "elm_distant_explod8",	0.6);
	ambientEvent("exterior", "elm_battle_bren1",	0.6);
	ambientEvent("exterior", "elm_battle_bren2",	0.6);
	ambientEvent("exterior", "elm_battle_bren3",	0.6);
	ambientEvent("exterior", "elm_battle_bren4",	0.6);
	ambientEvent("exterior", "elm_battle_bren5",	0.6);
	ambientEvent("exterior", "elm_battle_sten1",	0.6);
	ambientEvent("exterior", "elm_battle_sten2",	0.6);
	ambientEvent("exterior", "elm_battle_rifle1",	0.6);
	ambientEvent("exterior", "elm_battle_rifle2",	0.6);
	ambientEvent("exterior", "elm_battle_rifle3",	0.6);
	ambientEvent("exterior", "elm_battle_rifle4",	0.6);
	ambientEvent("exterior", "null",			0.3);
	
	ambientDelay("interior", 18.0, 30.0); // Trackname, min and max delay between ambient events
	ambientEvent("interior", "elm_distant_explod1",	0.6);
	ambientEvent("interior", "elm_distant_explod2",	0.6);
	ambientEvent("interior", "elm_distant_explod3",	0.6);
	ambientEvent("interior", "elm_distant_explod4",	0.6);
	ambientEvent("interior", "elm_distant_explod5",	0.6);
	ambientEvent("interior", "elm_distant_explod6",	0.6);
	ambientEvent("interior", "elm_distant_explod7",	0.6);
	ambientEvent("interior", "elm_distant_explod8",	0.6);
	ambientEvent("interior", "null",			0.3);
	
	thread ambientEventStart("exterior");	
}	
	