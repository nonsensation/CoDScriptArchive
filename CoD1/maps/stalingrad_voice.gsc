main()
{
/*
	Usage:
	add_voiceover ( guy number, sound alias, delay );
*/

//	example: Play commissar4_line27 on guy 45 when the timer says 20
	
	//Conscript panic
	
	add_voiceover (40, "conscript3_line24", 100);	//We must get out of here! Abandon ship!

	//Shooting the fleeing conscripts
// 46 to 45
// 44 to 41
	add_voiceover (39, "commissar4_line41", 103);	//Kill him, death to traitors!
	add_voiceover (45, "commissar1_line40", 105);	//Traitor!
	add_voiceover (41, "commissar3_line28", 106);	//No retreat! Kill them! Kill the deserters!
	add_voiceover (42, "commissar1_line26", 108);	//Traitor! Traitor!
	add_voiceover (39, "commissar1_line29", 109);	//Stop those traitors!
	add_voiceover (42, "commissar4_line27", 110);	//No mercy for deserters! No mercy!
	add_voiceover (45, "commissar1_line40", 112);	//Traitor!
	
	//Get out of the boat!
	
	//add_voiceover (43, "commissar3_line33", 134);	//Let's go comrades, out of the boat!
	//add_voiceover (45, "commissar1_line31", 136);	//Everyone out of the boat!
	//add_voiceover (42, "commissar1_line34", 137.5);	//What are you waiting for? Get off the boat!
	//add_voiceover (39, "commissar2_line51", 139);	//Move, damn you, move! Don't fall back!
	//add_voiceover (46, "commissar4_line35", 140);	//I won't ask you again, comrade, get out of the boat!
	
	add_voiceover (43, "commissar3_line33", 128);	//Let's go comrades, out of the boat!
	add_voiceover (45, "commissar1_line31", 130);	//Everyone out of the boat!
	add_voiceover (42, "commissar1_line34", 132);	//What are you waiting for? Get off the boat!
	add_voiceover (39, "commissar2_line51", 136);	//Move, damn you, move! Don't fall back!
	add_voiceover (43, "commissar4_line35", 134);	//I won't ask you again, comrade, get out of the boat!


	level.commissar_speech["lineofficer"]["generic"][0] = "commissar2_line47";
	level.commissar_speech["lineofficer"]["generic"][1] = "commissar2_line52";
	level.commissar_speech["lineofficer"]["generic"][2] = "commissar2_line54";
	level.commissar_speech["lineofficer"]["worthless_dog"][0] = "commissar2_line51";
	
	level.commissar_speech["commissar3"]["generic"][0] = "commissar3_line49";
	level.commissar_speech["commissar3"]["generic"][1] = "commissar3_charge1";
	level.commissar_speech["commissar3"]["generic"][2] = "commissar3_charge2";
	level.commissar_speech["commissar3"]["worthless_dog"][0] = "commissar3_line7";
	level.commissar_speech["commissar3"]["worthless_dog"][1] = "commissar3_line10";
	level.commissar_speech["commissar3"]["worthless_dog"][2] = "commissar3_line28";

	level.commissar_speech["commissar4"]["generic"][0] = "commissar4_line6";
	level.commissar_speech["commissar4"]["generic"][1] = "commissar4_line9";
	level.commissar_speech["commissar4"]["generic"][2] = "commissar4_line49";
	level.commissar_speech["commissar4"]["generic"][3] = "commissar4_line50";
	level.commissar_speech["commissar4"]["generic"][4] = "commissar4_line51";
	level.commissar_speech["commissar4"]["generic"][5] = "commissar4_line54";
	level.commissar_speech["commissar4"]["generic"][6] = "commissar4_charge1";
	level.commissar_speech["commissar4"]["generic"][7] = "commissar4_charge2";
	level.commissar_speech["commissar4"]["worthless_dog"][0] = "commissar4_line32";
}

add_voiceover (guynum, sound, delay)
{
	obj = spawnstruct();

	if (!isdefined (level._voiceover))
	{
		level._voiceover[0] = obj;
		println ("setup obj 1, size of ", level._voiceover.size);
	}
	else
		level._voiceover[level._voiceover.size] = obj;
	
	level._voiceover[level._voiceover.size-1].guynum = guynum;
	level._voiceover[level._voiceover.size-1].sound = sound;
	level._voiceover[level._voiceover.size-1].delay = delay;
}
