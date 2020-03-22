main()
{
}

get_name(override)
{
	if (!isdefined (override))
	{
		if ((level.script == "stalingrad") || (level.script == "stalingrad_nolight"))
			return;
		if (level.script == "credits")
			return;
	}
	
	if (isdefined (self.script_friendname))
	{
		self.name = self.script_friendname;
		return;
	}		
	
	american_names 	= 180;
	british_names 	= 172;
	russian_names 	= 151;
	
	if ( !(isdefined (game["americannames"]) ) )
		game["americannames"] = randomint (american_names);
	if ( !(isdefined (game["britishnames"]) ) )
		game["britishnames"] = randomint (british_names);
	if ( !(isdefined (game["russiannames"]) ) )
		game["russiannames"] = randomint (russian_names);


	if (level.campaign == "british")
	{
		game["britishnames"]++;
		get_british_name();
	}
	else
	if (level.campaign == "russian")
	{
		game["russiannames"]++;
		get_russian_name();
	}
	else
	{
		game["americannames"]++;
		get_american_name();
	}
}

get_american_name()
{
	// NOTE: DO NOT CHANGE NAMES, INSTEAD ADD THEM TO THE BOTTOM OF THE LIST.
	switch (game["americannames"])
	{
		case  1: self.name = "Weir";break;
		case  2: self.name = "Perlman";break;
		case  3: self.name = "Holm";break;
		case  4: self.name = "Avery";break;
		case  5: self.name = "Fincher";break;
		case  6: self.name = "McManus";break;
		case  7: self.name = "Roe";break;
		case  8: self.name = "Messerly";break;
		case  9: self.name = "Kirkpatrick";break;
		case 10: self.name = "Griffen";break;
		case 11: self.name = "O'Neill";break;
		case 12: self.name = "Farrell";break;
		case 13: self.name = "Jacobs";break;
		case 14: self.name = "Scott";break;
		case 15: self.name = "Vickers";break;
		case 16: self.name = "Silvers";break;
		case 17: self.name = "Vaughn";break;
		case 18: self.name = "Fisher";break;
		case 19: self.name = "Ross";break;
		case 20: self.name = "Rice";break;
		case 21: self.name = "Limon";break;
		case 22: self.name = "Weaver";break;
		case 23: self.name = "Kaplan";break;
		case 24: self.name = "Hicks";break;
		case 25: self.name = "McKinny";break;
		case 26: self.name = "Heath";break;
		case 27: self.name = "Erickson";break;
		case 28: self.name = "Swanson";break;
		case 29: self.name = "Blackwell";break;
		case 30: self.name = "Turner";break;
		case 31: self.name = "Caputo";break;
		case 32: self.name = "Doherty";break;
		case 33: self.name = "Franklin";break;
		case 34: self.name = "Jenkins";break;
		case 35: self.name = "Manne";break;
		case 36: self.name = "Glenn";break;
		case 37: self.name = "Field";break;
		case 38: self.name = "Little";break;
		case 39: self.name = "McCandlish";break;
		case 40: self.name = "Mills";break;
		case 41: self.name = "Olsen";break;
		case 42: self.name = "Sawyer";break;
		case 43: self.name = "Pearson";break;
		case 44: self.name = "Post";break;
		case 45: self.name = "Glasco";break;
		case 46: self.name = "Sweet";break;
		case 47: self.name = "Dominguez";break;
		case 48: self.name = "O'Doyle";break;
		case 49: self.name = "Delarosa";break;
		case 50: self.name = "Smith";break;
		case 51: self.name = "Jones";break;
		case 52: self.name = "Roosevelt";break;
		case 53: self.name = "Carter";break;
		case 54: self.name = "Baker";break;
		case 55: self.name = "Grenier";break;
		case 56: self.name = "Fitzpatrick";break;
		case 57: self.name = "McKnight";break;
		case 58: self.name = "Pacelli";break;
		case 59: self.name = "Conway";break;
		case 60: self.name = "D'Angelo";break;
		case 61: self.name = "Dunn";break;
		case 62: self.name = "Morrison";break;
		case 63: self.name = "Wilson";break;
		case 64: self.name = "Walton";break;
		case 65: self.name = "Fletcher";break;
		case 66: self.name = "Johnson";break;
		case 67: self.name = "Goldberg";break;
		case 68: self.name = "Svendson";break;
		case 69: self.name = "Pierce";break;
		case 70: self.name = "Robertson";break;
		case 71: self.name = "Pinkerton";break;
		case 72: self.name = "Kane";break;
		case 73: self.name = "Bales";break;
		case 74: self.name = "Lopresti";break;
		case 75: self.name = "Reagan";break;
		case 76: self.name = "Hawking";break;
		case 77: self.name = "Peterson";break;	
		case 78: self.name = "Rogers";break;
		case 79: self.name = "Cutler";break;
		case 80: self.name = "Custer";break;
		case 81: self.name = "Manning";break;
		case 82: self.name = "Chevrier";break;
		case 83: self.name = "Hammon";break;
		case 84: self.name = "Zimmerman";break;
		case 85: self.name = "Taylor";break;
		case 86: self.name = "Daniels";break;
		case 87: self.name = "Cox";break;
		case 88: self.name = "Quinn";break;
		case 89: self.name = "O'Toole";break;
		case 90: self.name = "Glave";break;
		case 91: self.name = "Lyman";break;
		case 92: self.name = "Rutledge";break;
		case 93: self.name = "Norman";break;
		case 94: self.name = "Gigliotti";break;
		case 95: self.name = "Harper";break;
		case 96: self.name = "Walker";break;
		case 97: self.name = "Pendleton";break;
		case 98: self.name = "MacDonald";break;
		case 99: self.name = "King";break;
		case 100: self.name = "Collier";break;
		case 101: self.name = "Butler";break;
		case 102: self.name = "Welch";break;
		case 103: self.name = "O'Callaghan";break;
		case 104: self.name = "Conroy";break;
		case 105: self.name = "Davis";break;
		case 106: self.name = "Carmichael";break;
		case 107: self.name = "Irons";break;
		case 108: self.name = "Fishbourne";break;
		case 109: self.name = "Marshall";break;
		case 110: self.name = "Barrett";break;
		case 111: self.name = "Jury";break;
		case 112: self.name = "Ellis";break;
		case 113: self.name = "Irwin";break;
		case 114: self.name = "Matisse";break;
		case 115: self.name = "Barnes";break;
		case 116: self.name = "Woods";break;
		case 117: self.name = "Carpenter";break;
		case 118: self.name = "Stone";break;
		case 119: self.name = "O'Connell";break;
		case 120: self.name = "O'Brian";break;
		case 121: self.name = "Miller";break;
		case 122: self.name = "Long";break;
		case 123: self.name = "Lamia";break;
		case 124: self.name = "Rooney";break;
		case 125: self.name = "Zampella";break;
		case 126: self.name = "Peas";break;
		case 127: self.name = "Alderman";break;
		case 128: self.name = "Bell";break;
		case 129: self.name = "West";break;
		case 130: self.name = "Bennett";break;
		case 131: self.name = "Thomas";break;
		case 132: self.name = "Wright";break;
		case 133: self.name = "Hewitt";break;
		case 134: self.name = "Avalos";break;
		case 135: self.name = "Doornink";break;
		case 136: self.name = "Grossman";break;
		case 137: self.name = "Hagerty";break;
		case 138: self.name = "Callaway";break;
		case 139: self.name = "Kirschenbaum";break;
		case 140: self.name = "Oxnard";break;
		case 141: self.name = "Johnsen";break;
		case 142: self.name = "DeMaria";break;
		case 143: self.name = "Allen";break;
		case 144: self.name = "McCaffrey";break;
		case 145: self.name = "Ford";break;
		case 146: self.name = "Boswell";break;
		case 147: self.name = "Spears";break;
		case 148: self.name = "Mantarro";break;
		case 149: self.name = "Vantine";break;
		case 150: self.name = "Saltzman";break;

		// --- GMI Additions --- //

		case 151: self.name = "Rosman";break;
		case 152: self.name = "Alvey";break;
		case 153: self.name = "Luskus";break;
		case 154: self.name = "Vasquez";break;
		case 155: self.name = "Struhl";break;
		case 156: self.name = "Cervantes";break;
		case 157: self.name = "McClure";break;
		case 158: self.name = "Garcia";break;
		case 159: self.name = "Melen";break;
		case 160: self.name = "Hawkins";break;
		case 161: self.name = "MacDaniel";break;
		case 162: self.name = "Hartman";break;
		case 163: self.name = "Zamperla";break;
		case 164: self.name = "Faircloth";break;
		case 165: self.name = "Villani";break;
		case 166: self.name = "Morton";break;
		case 167: self.name = "Burkett";break;
		case 168: self.name = "McMurray";break;
		case 169: self.name = "Dailey";break;
		case 170: self.name = "Dwyer";break;
		case 171: self.name = "Felner";break;
		case 172: self.name = "Morgan";break;
		case 173: self.name = "Conserva";break;
		case 174: self.name = "Black";break;
		case 175: self.name = "Schwartz";break;
		case 176: self.name = "Beggs";break;
		case 177: self.name = "Bartek";break;
		case 178: self.name = "Robinson";break;	
		case 179: self.name = "Keough";break;
		case 180: self.name = "Angona"; game["americannames"] = 0;break;
	}

	if (self.weapon == "thompson")
		self.name = "Lt. " + self.name;
	else
	{
		rank = randomint (100);
		if (rank > 40)
			self.name = "Pvt. " + self.name;
		else
		if (rank > 20)
			self.name = "Cpl. " + self.name;
		else
			self.name = "Sgt. " + self.name;
	}
}

get_british_name()
{
	// NOTE: DO NOT CHANGE NAMES, INSTEAD ADD THEM TO THE BOTTOM OF THE LIST.
	switch (game["britishnames"])
	{
		case  1: self.name = "Pvt. Baker";break;
		case  2: self.name = "Sgt. Heacock";break;
		case  3: self.name = "Pvt. Farmer";break;
		case  4: self.name = "Pvt. Dowd";break;
		case  5: self.name = "Pvt. Fitzroy";break;
		case  6: self.name = "Pvt. Tennyson";break;
		case  7: self.name = "Pvt. Bartlett";break;
		case  8: self.name = "Pvt. Plumber";break;
		case  9: self.name = "Pvt. Blair";break;
		case  10: self.name = "Pvt. Heath";break;
		case  11: self.name = "Pvt. Neeson";break;
		case  12: self.name = "Pvt. Wallace";break;
		case  13: self.name = "Pvt. Hopkins";break;
		case  14: self.name = "Pvt. Thompson";break;
		case  15: self.name = "Pvt. Grant";break;
		case  16: self.name = "Pvt. Carter";break;
		case  17: self.name = "Pvt. Ackroyd";break;
		case  18: self.name = "Pvt. Adams";break;
		case  19: self.name = "Pvt. Moore";break;
		case  20: self.name = "Pvt. Griffin";break;
		case  21: self.name = "Pvt. Boyd";break;
		case  22: self.name = "Pvt. Harris";break;
		case  23: self.name = "Pvt. Burton";break;
		case  24: self.name = "Pvt. Montgomery";break;
		case  25: self.name = "Pvt. Matthews";break;
		case  26: self.name = "Pvt. Astor";break;
		case  27: self.name = "Pvt. Bishop";break;
		case  28: self.name = "Pvt. Compton";break;
		case  29: self.name = "Pvt. Hawksford";break;
		case  30: self.name = "Pvt. Hoyt";break;
		case  31: self.name = "Pvt. Kent";break;
		case  32: self.name = "Pvt. Rothes";break;
		case  33: self.name = "Pvt. Ross";break;
		case  34: self.name = "Pvt. Smith";break;
		case  35: self.name = "Pvt. Brown";break;
		case  36: self.name = "Pvt. Buttler";break;
		case  37: self.name = "Pvt. Caldwell";break;
		case  38: self.name = "Pvt. Cotterhill";break;
		case  39: self.name = "Pvt. Dowton";break;
		case  40: self.name = "Pvt. Walcroft";break;
		case  41: self.name = "Pvt. Wells";break;
		case  42: self.name = "Pvt. Weisz";break;
		case  43: self.name = "Pvt. Watt";break;
		case  44: self.name = "Pvt. Veale";break;
		case  45: self.name = "Pvt. Abbott";break;
		case  46: self.name = "Pvt. Bowen";break;
		case  47: self.name = "Pvt. Carver";break;
		case  48: self.name = "Pvt. Brocklebank";break;
		case  49: self.name = "Pvt. Peacock";break;
		case  50: self.name = "Pvt. Pearce";break;
		case  51: self.name = "Pvt. Reed";break;
		case  52: self.name = "Pvt. Rogers";break;
		case  53: self.name = "Pvt. Major";break;
		case  54: self.name = "Pvt. Horrocks";break;
		case  55: self.name = "Pvt. Law";break;
		case  56: self.name = "Pvt. Ritchie";break;
		case  57: self.name = "Pvt. Beck";break;
		case  58: self.name = "Pvt. James";break;
		case  59: self.name = "Pvt. Jones";break;
		case  60: self.name = "Pvt. Harrison";break;
		case  61: self.name = "Pvt. Statham";break;
		case  62: self.name = "Pvt. Fletcher";break;
		case  63: self.name = "Pvt. Mackintosh";break;
		case  64: self.name = "Pvt. Sweeney";break;
		case  65: self.name = "Pvt. Moriarty";break;
		case  66: self.name = "Pvt. Leaver";break;
		case  67: self.name = "Pvt. McGregor";break;
		case  68: self.name = "Pvt. Bremner";break;
		case  69: self.name = "Pvt. Miller";break;
		case  70: self.name = "Pvt. Macdonald";break;
		case  71: self.name = "Pvt. Henderson";break;
		case  72: self.name = "Pvt. McQuarrie";break;
		case  73: self.name = "Pvt. Welsh";break;
		case  74: self.name = "Pvt. Murphy";break;
		case  75: self.name = "Pvt. Carlyle";break;
		case  76: self.name = "Pvt. Ross";break;
		case  77: self.name = "Pvt. Eadie";break;
		case  78: self.name = "Pvt. Nestor";break;
		case  79: self.name = "Pvt. Hodge";break;
		case  80: self.name = "Pvt. Fleming";break;
		case  81: self.name = "Pvt. Figg";break;
		case  82: self.name = "Pvt. Donnely";break;
		case  83: self.name = "Pvt. Bell";break;
		case  84: self.name = "Pvt. Browne";break;
		case  85: self.name = "Pvt. Boyle";break;
		case  86: self.name = "Pvt. Burke";break;
		case  87: self.name = "Pvt. Byrne";break;
		case  88: self.name = "Pvt. Nolan";break;
		case  89: self.name = "Pvt. Carroll";break;
		case  90: self.name = "Pvt. Clarke";break;
		case  91: self.name = "Pvt. Collins";break;
		case  92: self.name = "Pvt. Connolly";break;
		case  93: self.name = "Pvt. Connor";break;
		case  94: self.name = "Pvt. Fitzgerald";break;
		case  95: self.name = "Pvt. Flynn";break;
		case  96: self.name = "Pvt. Hughes";break;
		case  97: self.name = "Pvt. Kennedy";break;
		case  98: self.name = "Pvt. Murray";break;
		case  99: self.name = "Pvt. Ryan";break;
		case  100: self.name = "Pvt. Quinn";break;
		case  101: self.name = "Pvt. Shea";break;
		case  102: self.name = "Pvt. Sullivan";break;
		case  103: self.name = "Pvt. Lewis";break;
		case  104: self.name = "Pvt. Walsh";break;
		case  105: self.name = "Pvt. Connery";break;
		case  106: self.name = "Pvt. White";break;
		case  107: self.name = "Pvt. DeWitt";break;
		case  108: self.name = "Pvt. Stewart";break;
		case  109: self.name = "Pvt. Stevenson";break;
		case  110: self.name = "Pvt. Rankin";break;
		case  111: self.name = "Pvt. McDiarmid";break;
		case  112: self.name = "Pvt. Maxwell";break;
		case  113: self.name = "Pvt. Livingstone";break;
		case  114: self.name = "Pvt. Lipton";break;
		case  115: self.name = "Pvt. Liddell";break;
		case  116: self.name = "Pvt. Lennox";break;
		case  117: self.name = "Pvt. Kidd";break;
		case  118: self.name = "Pvt. Hamilton";break;
		case  119: self.name = "Pvt. Coltrane";break;
		case  120: self.name = "Pvt. Burns";break;
		case  121: self.name = "Pvt. Anderson";break;
		case  122: self.name = "Pvt. Lindsay";break;
		case  123: self.name = "Pvt. MacLeod";break;
		case  124: self.name = "Pvt. Sherman";break;
		case  125: self.name = "Pvt. Williamson";break;
		case  126: self.name = "Pvt. Kilgour";break;
		case  127: self.name = "Pvt. Watson";break;
		case  128: self.name = "Pvt. Holmes";break;
		case  129: self.name = "Sgt. Boon";break;
		case  130: self.name = "Pvt. Pritchard";break;
		case  131: self.name = "Pvt. Cook";break;
		case  132: self.name = "Pvt. Mitchell";break;
		case  133: self.name = "Pvt. Kilpatrick";break;
		case  134: self.name = "Sgt. Murphy";break;
		case  135: self.name = "Pvt. Brest";break;
		case  136: self.name = "Pvt. Rockhill";break;
		case  137: self.name = "Pvt. Riley";break;
		case  138: self.name = "Sgt. Hansell";break;
		case  139: self.name = "Pvt. Kieran";break;
		case  140: self.name = "Pvt. McWilliams";break;
		case  141: self.name = "Pvt. Ricketts";break;

		// --- GMI Additions --- //

		case  142: self.name = "Pvt. Meeker";break;
		case  143: self.name = "Pvt. Mandel";break;
		case  144: self.name = "Pvt. Ruth";break;
		case  145: self.name = "Sgt. Condon";break;
		case  146: self.name = "Pvt. Mabilliard";break;
		case  147: self.name = "Pvt. Brinkley";break;
		case  148: self.name = "Pvt. Young";break;
		case  149: self.name = "Pvt. Kneebush";break;
		case  150: self.name = "Pvt. Hartman";break;
		case  151: self.name = "Pvt. Intamin";break;
		case  152: self.name = "Pvt. Brookhyser";break;
		case  153: self.name = "Pvt. Dinn";break;
		case  154: self.name = "Pvt. Toomer";break;
		case  155: self.name = "Pvt. Soiko";break;
		case  156: self.name = "Pvt. Battaglia";break;
		case  157: self.name = "Pvt. Hart";break;
		case  158: self.name = "Pvt. McFarlane";break;
		case  159: self.name = "Pvt. Wiley";break;
		case  160: self.name = "Pvt. Checketts";break;
		case  161: self.name = "Pvt. Soucy";break;
		case  162: self.name = "Pvt. Berman";break;
		case  163: self.name = "Pvt. Feltrin";break;
		case  164: self.name = "Pvt. Jessup";break;
		case  165: self.name = "Pvt. Snyder";break;	
		case  166: self.name = "Pvt. Alton";break;
		case  167: self.name = "Pvt. Montu";break;
		case  168: self.name = "Pvt. Smedsted";break;
		case  169: self.name = "Pvt. Wozny";break;
		case  170: self.name = "Pvt. Lasister";break;
		case  171: self.name = "Sgt. Malamed";break;
		case  172: self.name = "Pvt. Falk"; game["britishnames"] = 0;break;
	}
}

get_russian_name()
{
	// NOTE: DO NOT CHANGE NAMES, INSTEAD ADD THEM TO THE BOTTOM OF THE LIST.
	switch (game["russiannames"])
	{
		case  1: self.name = "Pvt. Ivanov";break;
		case  2: self.name = "Sgt. Smirnov";break;
		case  3: self.name = "Pvt. Vasilev";break;
		case  4: self.name = "Pvt. Petrov";break;
		case  5: self.name = "Pvt. Kyznetsov";break;
		case  6: self.name = "Pvt. Fedorov";break;
		case  7: self.name = "Pvt. Mikhailov";break;
		case  8: self.name = "Pvt. Sokolov";break;
		case  9: self.name = "Pvt. Filatov";break;
		case  10: self.name = "Pvt. Leonov";break;
		case  11: self.name = "Pvt. Danilov";break;
		case  12: self.name = "Pvt. Zaitsev";break;
		case  13: self.name = "Pvt. Ilin";break;
		case  14: self.name = "Pvt. Semenov";break;
		case  15: self.name = "Pvt. Lebedev";break;
		case  16: self.name = "Pvt. Golubev";break;
		case  17: self.name = "Pvt. Lukin";break;
		case  18: self.name = "Pvt. Zhuravlev";break;
		case  19: self.name = "Pvt. Gerasimov";break;
		case  20: self.name = "Pvt. Petrenko";break;
		case  21: self.name = "Pvt. Nikitin";break;
		case  22: self.name = "Pvt. Andropov";break;
		case  23: self.name = "Pvt. Chernenko";break;
		case  24: self.name = "Pvt. Brezhnev";break;
		case  25: self.name = "Pvt. Kalinin";break;
		case  26: self.name = "Pvt. Shvernik";break;
		case  27: self.name = "Pvt. Voroshilov";break;
		case  28: self.name = "Pvt. Mikoyan";break;
		case  29: self.name = "Pvt. Podgorniy";break;
		case  30: self.name = "Pvt. Kuznetsov";break;
		case  31: self.name = "Pvt. Grombyo";break;
		case  32: self.name = "Pvt. Rykov";break;
		case  33: self.name = "Pvt. Malenkov";break;
		case  34: self.name = "Pvt. Bulganin";break;
		case  35: self.name = "Pvt. Kosygin";break;
		case  36: self.name = "Pvt. Tikhonov";break;
		case  37: self.name = "Pvt. Ryzhkov";break;
		case  38: self.name = "Pvt. Vyshinskiy";break;
		case  39: self.name = "Pvt. Shevardnadze";break;
		case  40: self.name = "Pvt. Shepilov";break;
		case  41: self.name = "Pvt. Bessmertnykh";break;
		case  42: self.name = "Pvt. Pankin";break;
		case  43: self.name = "Pvt. Litvinov";break;
		case  44: self.name = "Pvt. Merkulov";break;
		case  45: self.name = "Pvt. Ogoltsov";break;
		case  46: self.name = "Pvt. Fedorchuk";break;
		case  47: self.name = "Pvt. Bakatin";break;
		case  48: self.name = "Pvt. Shebarshin";break;
		case  49: self.name = "Pvt. Semichastniy";break;
		case  50: self.name = "Pvt. Serov";break;
		case  51: self.name = "Pvt. Ustinov";break;
		case  52: self.name = "Pvt. Yazov";break;
		case  53: self.name = "Pvt. Grechko";break;
		case  54: self.name = "Pvt. Aleksandrov";break;
		case  55: self.name = "Pvt. Shatalov";break;
		case  56: self.name = "Pvt. Shonin";break;
		case  57: self.name = "Pvt. Filipchenko";break;
		case  58: self.name = "Pvt. Kubasov";break;
		case  59: self.name = "Pvt. Gorbatko";break;
		case  60: self.name = "Pvt. Volkov";break;
		case  61: self.name = "Pvt. Yeliseyev";break;
		case  62: self.name = "Pvt. Feoktistov";break;
		case  63: self.name = "Pvt. Tereshkov";break;
		case  64: self.name = "Pvt. Bykovsky";break;
		case  65: self.name = "Pvt. Artyukhin";break;
		case  66: self.name = "Pvt. Beregovy";break;
		case  67: self.name = "Pvt. Berezovoy";break;
		case  68: self.name = "Pvt. Demin";break;
		case  69: self.name = "Pvt. Jahn";break;
		case  70: self.name = "Pvt. Khrunov";break;
		case  71: self.name = "Pvt. Kovalyonok";break;
		case  72: self.name = "Pvt. Lazarev";break;
		case  73: self.name = "Pvt. Leonov";break;
		case  74: self.name = "Pvt. Popovich";break;
		case  75: self.name = "Pvt. Romanenko";break;
		case  76: self.name = "Pvt. Rozhdestvensky";break;
		case  77: self.name = "Pvt. Rukavishnikov";break;
		case  78: self.name = "Pvt. Ryumin";break;
		case  79: self.name = "Pvt. Savinykh";break;
		case  80: self.name = "Pvt. Sevastyanov";break;
		case  81: self.name = "Pvt. Titov";break;
		case  82: self.name = "Pvt. Yeliseyev";break;
		case  83: self.name = "Pvt. Gagarin";break;
		case  84: self.name = "Pvt. Kinski";break;
		case  85: self.name = "Pvt. Todoroff";break;
		case  86: self.name = "Pvt. Goernshtein";break;
		case  87: self.name = "Pvt. Bondarachuk";break;
		case  88: self.name = "Pvt. Banionis";break;
		case  89: self.name = "Pvt. Solonitsyn";break;
		case  90: self.name = "Pvt. Grinko";break;
		case  91: self.name = "Pvt. Kerdimun";break;
		case  92: self.name = "Pvt. Kizilov";break;
		case  93: self.name = "Pvt. Malykh";break;
		case  94: self.name = "Pvt. Oganesyan";break;
		case  95: self.name = "Pvt. Ogorodnikov";break;
		case  96: self.name = "Pvt. Sargsyan";break;
		case  97: self.name = "Pvt. Semyonov";break;
		case  98: self.name = "Pvt. Statsinski";break;
		case  99: self.name = "Pvt. Sumenov";break;
		case  100: self.name = "Pvt. Tejkh";break;
		case  101: self.name = "Pvt. Tarasov";break;
		case  102: self.name = "Pvt. Artemyev";break;
		case  103: self.name = "Pvt. Ovchinnikov";break;
		case  104: self.name = "Pvt. Yusov";break;
		case  105: self.name = "Pvt. Kushneryov";break;
		case  106: self.name = "Pvt. Tarkovsky";break;
		case  107: self.name = "Pvt. Chugunov";break;
		case  108: self.name = "Pvt. Murashko";break;
		case  109: self.name = "Pvt. Nevsky";break;
		case  110: self.name = "Pvt. Paramanov";break;
		case  111: self.name = "Pvt. Shvedov";break;
		case  112: self.name = "Pvt. Tarkovsky";break;
		case  113: self.name = "Pvt. Glushenko";break;
		case  114: self.name = "Pvt. Chernogolov";break;
		case  115: self.name = "Pvt. Afanasyev";break;
		case  116: self.name = "Pvt. Bondarenko";break;
		case  117: self.name = "Pvt. Voronov";break;
		case  118: self.name = "Pvt. Gridin";break;
		case  119: self.name = "Pvt. Kiselev";break;
		case  120: self.name = "Pvt. Sarayev";break;
		case  121: self.name = "Pvt. Svirin";break;
		case  122: self.name = "Pvt. Sabgaida";break;
		case  123: self.name = "Pvt. Chernyshenko";break;
		case  124: self.name = "Pvt. Dovzhenko";break;
		case  125: self.name = "Pvt. Ivashenko";break;
		case  126: self.name = "Pvt. Shapovalov";break;
		case  127: self.name = "Pvt. Yakimenko";break;
		case  128: self.name = "Pvt. Masijashvili";break;
		case  129: self.name = "Pvt. Murzaev";break;
		case  130: self.name = "Pvt. Turdyev";break;
		case  131: self.name = "Pvt. Ramazanov";break;
		case  132: self.name = "Pvt. Avagimov";break;
		case  133: self.name = "Pvt. Demchenko";break;
		case  134: self.name = "Pvt. Stepanoshvili";break;
		case  135: self.name = "Pvt. Shkuratov";break;
		case  136: self.name = "Pvt. Yefremov";break;
		case  137: self.name = "Pvt. Ulyanova";break;
		case  138: self.name = "Pvt. Rose";break;
		case  139: self.name = "Pvt. Semenov";break;

		// --- GMI Additions --- //

		case  140: self.name = "Pvt. Bolliger";break;
		case  141: self.name = "Pvt. Yevla";break;
		case  142: self.name = "Pvt. Kernacs";break;
		case  143: self.name = "Pvt. Kumba";break;
		case  144: self.name = "Pvt. Traweek";break;
		case  145: self.name = "Pvt. Yslas";break;
		case  146: self.name = "Pvt. Gerstlauer";break;
		case  147: self.name = "Pvt. Sandler";break;
		case  148: self.name = "Pvt. Drozdz";break;
		case  149: self.name = "Pvt. Gwazi";break;
		case  150: self.name = "Pvt. Elfman";break;
		case  151: self.name = "Pvt. Vekoma"; game["russiannames"] = 0;break;
	}
}