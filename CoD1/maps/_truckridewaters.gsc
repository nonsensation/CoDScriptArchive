#using_animtree ("generic_human");
main()
{
	level.panzerregencount = 0;
	level.maxpanzerregens = 5;
	level.player giveweapon ("panzerfaust");
	level.player takeweapon ("panzerfaust");
	level.player thread panzermonitor();
	waters = getent ("waters","targetname");
	waters = waters dospawn();
	level.waters = waters;
	waters thread maps\_utility::magic_bullet_shield();
	truck = getent("player_vehicle","targetname");
	level.playertruck = truck;  // someday I'll define this in only one spot!!
	truck truck_panzers_andstuff();
	truck thread buddy_handle(waters);
	truck thread playerdeath();
	truck thread watersattackthink(level.waters);
	triggers = getentarray("watersattack","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_attacktrigger_wait();
	}

}

waitframe()
{
	maps\_spawner::waitframe();
}

startsequence(guy)
{
	level.bridgeholdpanzer = 0;
	level endon ("endstartsequence");
	level endon ("nomorepanzers");
	guy thread talkaboutlastpanzer();
	guy waittill ("buddyidle");
//	if(guy.anim_gunHand == "none")
//	{
//		self notify ("buddyevent","get");
//		guy waittill ("buddyidle");
//	}
	round = 0;
	while(1)
	{
		if(level.player hasweapon("Panzerfaust"))
		{
			level waittill ("nopanzer");
		}
		if(!(level.bridgeholdpanzer))
		{
			self notify ("buddyevent","get");
			guy waittill ("buddyidle");
		}
		else
			break;

	}
}

playerlookatwatersandsetpanzerorg(org,playerorg)
{
	angles = vectortoangles(org-playerorg);
	dist = distance(playerorg,org);
	forwardvector = anglestoforward(angles);
	rightvector = anglestoright(angles);
	rightvectorofset = maps\_utility::vectormultiply(rightvector ,-2); // used to be 12
	vectorofset = maps\_utility::vectormultiply(forwardvector ,84); // used to be 120
	panzerorg = playerorg + vectorofset+rightvectorofset;
	level.panzerorg = spawn("script_origin",panzerorg);
	level.panzerorg.origin += (0,0,10); // used to be 15
	level.panzerorg linkto (self);


	level.player setplayerangles(angles);
}

buddy_handle(guy)
{
	guy endon ("death");
	level.buddyevents = 0;
	level.buddyevent = [];
	guy.sittag = "tag_waters";
	guy teleport (self gettagorigin("tag_waters"),self gettagorigin("tag_waters"));
	guy linkto (self, guy.sittag);
//	playerlookatwatersandsetpanzerorg(self gettagorigin("tag_pf02"),self gettagorigin("tag_player"));
//	playerlookatwatersandsetpanzerorg(self gettagorigin("tag_pf02"),level.player.origin);
	playerlookatwatersandsetpanzerorg(self gettagorigin("tag_pf02"),self gettagorigin("tag_driver"));

	guy.hasweapon = false;
	guy animscripts\shared::PutGunInHand("none");


	guy.weapon = "panzerfaust";
	guy.attachtrack = [];
	guy.detachtrack = [];
	guy.attachtrack[0] = "attach pf = \"right\"";
	guy.detachtrack[0] = "detach pf = \"right\"";
	guy.attachthread[0] = ::givew;
	guy.detachthread[0] = ::takew;

	guy.attachsniper[0] = "attach sniper rifle = 'right'";
	guy.startanim = %truckride_waters_start_unarmed2giveidle;
	guy.startanimtracks["notetracks"][0] = guy.attachtrack[0];
	guy.startanimtracks["thread"][0] = guy.attachthread[0];
//	guy.startgivereturn = %truckride_waters_start_giveidle2attackidle;
//	guy.startgivereturn = %truckride_waters_give2unarmedidle;
	guy.removelidandget = %truckride_waters_start_unarmed2attackidle;
	guy.attackidle[0] = %truckride_waters_attackidleA;
	guy.attackidle[1] = %truckride_waters_attackidleB;
	guy.giveidle = %truckride_waters_giveidle;
	guy.attackoccurrence[0] = 200;
	guy.attackoccurrence[1] = 100;
	guy.pain[0] = %truckride_waters_painA;
	guy.pain[1] = %truckride_waters_painB;
	guy.painoccurrence[0] = 200;
	guy.painoccurrence[1] = 200;
	guy.cowerin = %truckride_waters_unarmedidle2cower;
	guy.cowerout = %truckride_waters_coweridle2unarmedidle;
	guy.coweranim[0] = %truckride_waters_coweridleA;
	guy.coweranim[1] = %truckride_waters_coweridleB;
	guy.coweranimoccurrence[0] = 200;
	guy.coweranimoccurrence[1] = 200;
	guy.giveanim = %truckride_waters_give;
	guy.givereturn = %truckride_waters_give2unarmedidle;
	guy.unarmedidle = %truckride_waters_unarmedidle;
	guy.getanim = %truckride_waters_grab;
	guy.jumpout = %truckride_waters_jumpout;
	guy.jumpin = %truckride_waters_climbin;
	guy.panzeraimidle = %truckride_waters_aimidle;
	guy.panzer2aimidle = %truckride_waters_attackidle2aim;
	guy.panzeraimfire = %truckride_waters_fire;

	guy.soggy = %truckride_waters_029_damnit;
	guy.soggytracks[0] = "dialogue";
	guy.soggythreads[0] = ::soggydialog;
	guy.soggytracks[1] = "attach sniper rifle = 'right'";
	guy.soggythreads[1] = ::soggyrifleright;
	guy.soggytracks[2] = "detach sniper rifle = \"right\"";
	guy.soggythreads[2] = ::soggydetachrifleright;
	guy.airfieldstart = %airfield_waters_036_comingup;


	guy.pistolattackr = %truckride_waters_pistol_shootr;
	guy.pistolattackl = %truckride_waters_pistol_shootl;
	guy.pistolattacks = %truckride_waters_pistol_shoots;
	guy.pistolreload = %truckride_waters_pistol_reload;
	guy.pistolattack = %truckride_waters_pistol_shoots;
	guy.pistolidle = %truckride_waters_pistol_idle;

	guy.idling = 1;

	guy thread fireingdirection(self);
	if(isdefined(level.nowatersstartsequence))
	{
		thread buddy_idle_noammo(guy);
	}
	else
	{

		thread buddy_start(guy);
	}
	guy endon ("death");
	while (1)
	{
		self waittill ("buddyevent",other);
		if(guy.idling == 1)
		{
			guy.idling = 0;
			if(other == "idle")
			{
				thread buddy_idle(guy);
			}
			else if(other == "idlenoammo")
			{
				thread buddy_idle_noammo(guy);
			}
			else if(other == "start")
			{
				thread buddy_start(guy);
			}
			else if(other == "get")
			{
				thread buddy_get(guy);
			}
			else if(other == "jumpout")
			{
				thread buddy_jumpout(guy);
			}
			else if(other == "jumpin")
			{
				thread buddy_jumpin(guy);
			}
			else if(other == "cower")
			{
				thread buddy_cower(guy);
			}
			else if(other == "soggybastard")
			{
				thread buddy_soggybastard(guy);
			}
			else if(other == "attack")
			{
				thread buddy_attack(guy);
			}
			else if(other == "panzertime")
			{
				thread buddy_panzertime(guy);
			}
			else if(other == "airfieldintro")
			{
				thread buddy_airfieldintro(guy);
			}
			else if(other == "getpanzerforself")
			{
				thread buddy_get(guy,"dontgive");
			}
		}
		else
		{
			println("buddynotidling for event ;", other);
		}
	}
}

buddy_airfieldintro(guy)
{
	guy thread maps\airfield::threadwaitsay("airfield_waters_comingupairfield",0);
	animontag(guy,guy.sittag,guy.airfieldstart);
	thread buddy_idle_noammo(guy);
}

buddy_soggybastard(guy)
{
	println("soggybastard");
	animontag(guy,guy.sittag,guy.soggy,guy.soggytracks,guy.soggythreads);
	self notify ("soggy");
	thread buddy_idle_noammo(guy);
}

buddy_cower(guy)
{
	self endon ("buddypain");
	animontag(guy,guy.sittag,guy.cowerin);
	theanim = randomoccurrance(guy,guy.coweranimoccurrence);
	animontag(guy,guy.sittag,guy.coweranim[theanim]);
	thread buddy_cower_idle(guy);
}

buddy_cower_idle(guy)
{
	timer = gettime() +2000;
	while(gettime() < timer)
	{
		theanim = randomoccurrance(guy,guy.coweranimoccurrence);
		animontag(guy,guy.sittag,guy.coweranim[theanim]);
	}
	animontag(guy,guy.sittag,guy.cowerout);
	thread buddy_idle_noammo(guy,"cycleanimationoncebeforenotifyingidle");
}

buddy_jumpin(guy)
{
	self endon ("buddypain");
	guy linkto(self,guy.sittag);
	thread truck_jumpin();
	animontag(guy,guy.sittag,guy.jumpin);
	guy notify ("jumpedin");
	thread buddy_idle_noammo(guy);
}

buddy_jumpout(guy)
{
	animontag(guy,guy.sittag,guy.jumpout);
	guy notify ("jumpedout");
	guy unlink();
	guy.idling = 1;
}

buddy_get(guy,nogive)
{
	if(!isdefined(level.nopanzersleft))
	{
		if(isdefined(nogive))
		{
			self notify ("panzerfausttime");
			level.panzershootingtime = 1;
		}
		else
			level.panzershootingtime = 0;
		self endon ("buddypain");
		guy.weapon = "panzerfaust";
		guy.hasweapon = false;  // todo.. maybe do a quick put away pistol animation.
		guy animscripts\shared::PutGunInHand("none");

		if(level.getpanzercount == 0)
		{
		//	println("^3first get Panzerfaust");
			thread truck_start();
			animontag(guy,guy.sittag,guy.startanim,guy.startanimtracks["notetracks"],guy.startanimtracks["thread"]);
			//animontag(guy,guy.sittag, guy.getanim, guy.attachtrack ,guy.attachthread);
			level.getpanzercount++;
			firstget = 1;

		}
		else if(level.getpanzercount == 1)
		{
		//	println("^3second get panzerfaust");
		//	animontag(guy,guy.sittag, guy.getanim, guy.attachtrack ,guy.attachthread);
			thread truck_start2();
			animontag(guy,guy.sittag,guy.removelidandget, guy.attachtrack ,guy.attachthread);
			level.getpanzercount++;
		}
		else
			animontag(guy,guy.sittag, guy.getanim, guy.attachtrack ,guy.attachthread);


		guy notify ("got");
		if(!isdefined(nogive))
			thread buddy_give(guy,firstget);
		else
		{
			buddy_panzertime(guy);
			thread buddy_idle_noammo(guy);
		}

	}
	else
	{
		level notify ("nomorepanzers");
		level.nopanzersleft = 1;
		thread buddy_idle_noammo(guy);
	}
}

buddy_give(guy,firstgive)
{
	self endon ("buddypain");
	println("^2giving");
	if(!isdefined(firstgive))
	{
		animontag(guy,guy.sittag,guy.giveanim);
		guy thread maps\truckride::talker("truckride_waters_hereyougo",.5);
	}
	thread used_panzer(guy);
	animloopontag(guy,guy.sittag,guy.giveidle,u,u,"usedpanzer");
	guy takew(self);
	animontag(guy,guy.sittag,guy.givereturn);
	thread buddy_idle_noammo(guy);
}

startwaitevent(guy)
{
	level waittill ("nopanzer");
	guy notify("panzershot");

}

buddy_attack(guy)
{
	self endon ("buddypain");
	self endon ("buddyevent");
	self endon ("panzerfausttime");
	guy.idling = 1;
	if(isdefined(self.enemyque))
	{
//		guy linkto (level.playertruck,"tag_waters",(0,0,0),(0,-90,0));
		guy.weapon = "colt";
		guy.hasweapon = true;
		guy animscripts\shared::PutGunInHand("right");
		tag = "tag_waters";
	}
	while(isdefined(self.enemyque))
	{
		for(i=0;i<7;i++)
		{
			if(!isdefined(self.enemyque) )
				break;
			guy shoot();
			org = self gettagOrigin (tag);
			angles = self gettagAngles (tag);

			//animontag(guy,guy.sittag,guy.pistolattack);
			//org = self gettagOrigin (tag);
			//angles = guy.angles;
			guy animscripted("pistoling", org, angles, guy.pistolattack);
			guy waittillmatch("pistoling","end");
		}
		if(!isdefined(self.enemyque) )
			break;
		org = self gettagOrigin (tag);
		angles = self gettagAngles (tag);
		guy animscripted("pistoling", org, angles, guy.pistolreload);
		guy waittillmatch("pistoling","end");
		if(!isdefined(self.enemyque))
			break;
		org = self gettagOrigin (tag);
		angles = self gettagAngles (tag);
		guy animscripted("pistolidle", org, angles, guy.pistolidle);
		guy waittillmatch("pistolidle","end");
	}
	thread buddy_idle_noammo(guy);
}

used_panzer(guy,firstshot)
{
	self endon ("buddypain");
	level.panzerfaustthing = spawn ("weapon_panzerfaust", (1,1,1));
	level.panzerfaustthing hide();
	level.panzerfaustthing.origin = level.panzerorg.origin;
	level.panzerfaustthing linkto (self, "tag_driver");
	thread remindplayerofpanzerfaust(firstshot);
	waitdead(panzer);
	thread remindplayertousepanzer();
	guy notify ("usedpanzer");
}

remindplayerofpanzerfaust(firstshot)
{
	self endon ("buddypain");
	level.waters endon ("death");
	level.waters endon ("usedpanzer");
	if(!isdefined(firstshot))
		timer = gettime()+10000;
	else
		timer = gettime()+2000;
	while(timer>gettime())
	{
		wait (randomfloat(2)+3);
		if(timer>gettime())
			level.waters maps\truckride::talker("truckride_waters_takeit");
	}
	level.panzershootingtime = true;
	level.panzerfaustthing delete();
	level.waters notify ("usedpanzer");
}

waitdead(panzer)
{
	level waittill ("yespanzer");  //panzermonitor yespanzer notified everyframe that the player has a panzer. woooh
	thread waitregenpanzer(1);
	return;
}
waitregenpanzer(time)
{
	wait time;
	if(level.panzerregencount < level.maxpanzerregens)
	{
		level.panzerregencount++;
		thread regenapanzer();
	}


}


regenapanzer()
{
	println("^cregening panzer");
	if(!(isdefined(level.ignorefirstpanzerforregen)))
	{
		level.ignorefirstpanzerforregen = true;
		return;
	}
	restartnopanzers = false;
	if(isdefined(level.nopanzersleft))
	{
		level.nopanzersleft = undefined;  // revives getting the panzerfausts hopefully
		restartnopanzers = true;
	}
	level.pfmodelcycle--;
	self.pfmodel[level.pfmodelcycle] show();
	if(restartnopanzers)
		self thread maps\_truckridewaters::pfmodelremove();
}

takew(vehicle)
{
	give = 1;
	println("panzershootimetime is", level.panzershootingtime);
	if(level.panzershootingtime)
	{
		level.playertruck buddy_panzertime(self);
		vehicle thread waitregenpanzer(2);
		give = 0;
	}
	self.hasweapon = false;
	self animscripts\shared::PutGunInHand("none");
	if(give)
	{
//		level.player giveweapon ("panzerfaust");
		level.player switchtoweapon ("panzerfaust");

		if(!isdefined(level.firstfaust))
		{
			level.firstfaust = 1;
			thread firstfausttalker();
		}

	}
}

firstfausttalker()
{
	if(!level.player hasweapon ("panzerfaust"))
		level waittill ("yespanzer");
	level.waters thread maps\truckride::talkerque("truckride_waters_knowwhattodo");
}

givew()
{
	level notify ("pfremove");
	self.weapon = "panzerfaust";
	self.hasweapon = true;
	self animscripts\shared::PutGunInHand("right");
}

buddy_idle_noammo(guy,reverse)
{
	guy.idling = 1;
	self endon ("buddypain");
	self endon ("buddyevent");
	while(1)
	{
//		println("buddyidle!");
//		// reverse is teh ghetto hack.. shoot animation is using animation that is not oriented on the tag. this makes it so guy can animate and be oriented before he lets other parts of the script know he's idle.
//		if(!isdefined(reverse))
//		{
			guy notify ("buddyidle");
//		}
		animontag(guy,guy.sittag,guy.unarmedidle);
//		if(isdefined(reverse))
//		{
//			guy notify ("buddyidle");
//		}

	}
}

buddy_idle(guy)
{
	guy.idling = 1;
	self endon ("buddypain");
	self endon ("buddyevent");
	while(1)
	{
		guy notify ("buddyidle");
		theanim = randomoccurrance(guy,guy.attackoccurrence);
		animontag(guy,guy.sittag,guy.attackidle[theanim]);
	}
}

buddy_start(guy)
{
//	level.panzershootingtime = 0;
//	level endon ("endstartsequence");
//	guy.idling = 0;
//	thread truck_start();
//	animontag(guy,guy.sittag,guy.startanim,guy.startanimtracks["notetracks"],guy.startanimtracks["thread"]);
//	thread used_panzer(guy,"firstshot");
//	animloopontag(guy,guy.sittag,guy.giveidle,u,u,"usedpanzer");
//	guy takew(self);
//	animontag(guy,guy.sittag,guy.givereturn);
//	if(level.player hasweapon ("panzerfaust"))
//	{
//		self thread buddy_idle_noammo(guy);
//		level waittill ("nopanzer");
//		self notify ("buddyevent","nothing"); //stops his idle
//	}
//	println("starttingtruck");
//	thread truck_start2();
//	animontag(guy,guy.sittag,guy.removelidandget, guy.attachtrack ,guy.attachthread);
//	thread buddy_give(guy);
	level.getpanzercount = 0;

	thread startsequence(guy);
	self thread buddy_idle_noammo(guy);
//	thread startwaitevent(guy);
//	animloopontag(guy,guy.sittag,guy.giveidle,u,u,"panzershot");

//	guy playsound ("truckride_waters_takethispanzerfaust");
//	thread used_panzer(guy);
//	animloopontag(guy,guy.sittag,guy.giveidle,u,u,"usedpanzer");

//	guy takew(self);
//	animontag(guy,guy.sittag,guy.givereturn);


}

leak(msg)
{
	if(isdefined(msg))
		println("leak",msg);
	else
		println("leak");
}


animontag(guy, tag , animation, notetracks, sthreads)
{

	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(notetracks))
	{
		for(i=0;i<notetracks.size;i++)
		{
			if(!isdefined(notetracks[i]))
			{
				println("notetrack is undefined");

			}
			guy waittillmatch ("animontagdone",notetracks[i]);
			guy thread [[sthreads[i]]]();
		}

	}
	guy waittillmatch ("animontagdone","end");
	guy notify ("dothestuff");
}

waitevent(guy,event)
{
	guy waittill (event);
	guy.loopendevent = 1;
}

animloopontag(guy, tag , animation, notetracks, sthreads,event)
{
	thread waitevent(guy,event);
	guy.loopendevent = 0;
	while(guy.loopendevent == 0)
	{
		org = self gettagOrigin (tag);
		angles = self gettagAngles (tag);
		guy animscripted("animontagdone", org, angles, animation);
		if(isdefined(notetracks))
		{
			for(i=0;i<notetracks.size;i++)
			{
				if(!isdefined(notetracks[i]))
				{
					println("notetrack is undefined");

				}
				guy waittillmatch ("animontagdone",notetracks[i]);
				guy thread [[sthreads[i]]]();
			}
		}
		guy waittillmatch ("animontagdone","end");
		guy notify ("dothestuff");
	}
}

randomoccurrance(guy,occurrences)
{
	range = [];
	totaloccurrance = 0;
	for(i=0;i<occurrences.size;i++)
	{
		totaloccurrance += occurrences[i];
		range[i] = totaloccurrance;
	}
	pick = randomint(totaloccurrance);
	for(i=0;i<occurrences.size;i++)
	{
		if(pick < range[i])
		{
			return i;
		}
	}
	leak("randomoccurrance");
}

playerdeath()
{


	level.waters endon ("jumpedout");
	level.player waittill ("death");
	angles = vectortoangles(level.waters.origin-level.player.origin);
	level.player unlink();
	level.player setplayerangles(angles);
	level.player playerlinkto (self, "tag_player", ( 1, 1, 1 ));
	if(isalive(level.waters))
	{
		self notify ("buddypain");
		while(1)
			animontag(level.waters, level.waters.sittag , %truckride_waters_checkdeadplayer);
	}
}

soggydialog()
{
	self animscripts\face::sayspecificdialogue(level.scr_anim["truckride_waters_soggybastard"],"truckride_waters_soggybastard",1);
}

soggyrifleright()
{
	self.weapon = "kar98k_sniper";
	self.hasweapon = true;
	self animscripts\shared::PutGunInHand("right");
}
soggydetachrifleright()
{
	self.hasweapon = false;
	self animscripts\shared::PutGunInHand("none");
}




//************************************************
//************************************************
//*******<<<<<<<<<>>>>>>>>>>>*********************
//*******<<<<GERMAN TRUCK>>>>*********************
//*******<<<<<<<<<>>>>>>>>>>>*********************
//************************************************
//************************************************

#using_animtree ("germantruck");

truck_panzers_andstuff()
{
	if(level.script != "dam")
	{
		precachemodel("xmodel/prop_panzerfaust");
		precachemodel("xmodel/prop_panzerfaust_lid");
		precachemodel("xmodel/prop_panzerfaust_emptybox");
	}
	self UseAnimTree(#animtree);
	self.startanim = %truckride_truck_start_unarmed2giveidle;

	self.startanimreturn = %truckride_truck_start_giveidle2attackidle;
//	self.startanimreturn = %truckride_truck_start2attackidle;
	self.jumpinanim = %truckride_truck_climbin;
	self.pfmodel = [];

	pfmodel = ("xmodel/prop_panzerfaust");
	if(level.script != "airfield")
	{
		self.pfmodel[0] = spawn("script_model", (1,1,1));
		self.pfmodel[1] = spawn("script_model", (1,1,1));
		self.pfmodel[2] = spawn("script_model", (1,1,1));
		self.pfmodel[3] = spawn("script_model", (1,1,1));
		self.pfmodel[4] = spawn("script_model", (1,1,1));

	}

	thread pfmodelremove();
	self.pftag[0] = "TAG_pf01";
	self.pftag[1] = "tag_pf02";
	self.pftag[2] = "tag_pf03";
	self.pftag[3] = "tag_pf04";
	self.pftag[4] = "tag_pf05";

	for(i=0;i<self.pfmodel.size;i++)
	{
		org = self gettagorigin(self.pftag[i]);
		ang = self gettagangles(self.pftag[i]);
		self.pfmodel[i] setmodel (pfmodel);
		self.pfmodel[i].origin = org;
		self.pfmodel[i].angles = ang;
		self.pfmodel[i] linkto (self,self.pftag[i]);
	}


	lidmodel = "xmodel/prop_panzerfaust_lid";
	self.pflidmodel[0] = spawn("script_model", (1,1,1));
	self.pflidmodel[1] = spawn("script_model", (1,1,1));
	self.pflidmodel[2] = spawn("script_model", (1,1,1));
	self.pflidmodel[3] = spawn("script_model", (1,1,1));
	self.pflidmodel[4] = spawn("script_model", (1,1,1));
	self.pflidmodel[5] = spawn("script_model", (1,1,1));

	self.pflidtag[0] = "TAG_pfause_lid01";
	self.pflidtag[1] = "TAG_pfause_lid02";
	self.pflidtag[2] = "TAG_pfause_lid03";
	self.pflidtag[3] = "TAG_pfause_lid04";
	self.pflidtag[4] = "TAG_pfause_lid05";
	self.pflidtag[5] = "TAG_pfause_lid06";

	for(i=0;i<self.pflidmodel.size;i++)
	{
		org = self gettagorigin(self.pflidtag[i]);
		ang = self gettagangles(self.pflidtag[i]);
		self.pflidmodel[i] setmodel (lidmodel);
		self.pflidmodel[i].origin = org;
		self.pflidmodel[i].angles = ang;
		self.pflidmodel[i] linkto (self,self.pflidtag[i]);
	}

	boxmodel = "xmodel/prop_panzerfaust_emptybox";
	self.pfboxmodel[0] = spawn("script_model", (1,1,1));
	self.pfboxmodel[1] = spawn("script_model", (1,1,1));
	self.pfboxmodel[2] = spawn("script_model", (1,1,1));
	self.pfboxmodel[3] = spawn("script_model", (1,1,1));
	self.pfboxmodel[4] = spawn("script_model", (1,1,1));
	self.pfboxmodel[5] = spawn("script_model", (1,1,1));
	self.pfboxmodel[6] = spawn("script_model", (1,1,1));

	self.pfboxtag[0] = "TAG_pfaust_box";
	self.pfboxtag[1] = "TAG_pfaust_box01";
	self.pfboxtag[2] = "TAG_pfaust_box02";
	self.pfboxtag[3] = "TAG_pfaust_box03";
	self.pfboxtag[4] = "TAG_pfaust_box04";
	self.pfboxtag[5] = "TAG_pfaust_box05";
	self.pfboxtag[6] = "TAG_pfaust_box06";

	for(i=0;i<self.pfboxmodel.size;i++)
	{
		org = self gettagorigin(self.pfboxtag[i]);
		ang = self gettagangles(self.pfboxtag[i]);
		self.pfboxmodel[i] setmodel (boxmodel);
		self.pfboxmodel[i].origin = org;
		self.pfboxmodel[i].angles = ang;
		self.pfboxmodel[i] linkto (self,self.pfboxtag[i]);
	}
}

truck_start()
{
	self truckanim(self.startanim,"start1");
}

truck_start2()
{
	self truckanim(self.startanimreturn,"start2");
}

truck_jumpin()
{
	self truckanim(self.jumpinanim,"jumpin");
}

truckanim(animation,name)
{
//	self setflaggedanimknob("knob",animation);
	self setflaggedanimknobrestart("knob",animation);
	self waittill ("knob");
}

pfmodelremove()
{
	if(!isdefined(level.pfmodelcycle))
		level.pfmodelcycle = 0;

	while(1)
	{
		level waittill ("pfremove");
		self.pfmodel[level.pfmodelcycle] hide();
		level.pfmodelcycle++;
		if(!(isdefined(self.pfmodel[level.pfmodelcycle])))
			break;

	}
//	for(i=0;i<models.size;i++)
//	{
//		level waittill ("pfremove");
//		models[i] delete();
//	}
	level notify ("nomorepanzers");
	level.nopanzersleft = 1;
}

//panzermonitor from the ghetto, I writes teh l3eT scrpT
panzermonitor()
{
	while(1)
	{
		if(level.player hasweapon ("Panzerfaust") == 0)
		{
			level notify ("nopanzer");
		}
		else
		{
			level notify ("yespanzer");
		}
		waitframe();
	}
}

trigger_attacktrigger_wait()
{
	targ = getent(self.target,"targetname");
	self waittill ("trigger");
	if(isdefined(self.script_delay))
		wait self.script_delay;
	vehicle = getent(targ.target,"targetname");
	vehicle endon ("death");
	if(vehicle.health > 0)
	{
		level.playertruck thread removefromqueondeath(vehicle);
		level.playertruck thread removefromqueoncrash(vehicle);
		level.playertruck thread queadd(vehicle);
	}
	targ waittill("trigger");
	level.playertruck thread queremove(vehicle);
}

removefromqueondeath(vehicle)
{
	vehicle waittill ("death");
	thread queremove(vehicle);
}

removefromqueoncrash(vehicle)
{
	vehicle waittill("crashpath");
	thread queremove(vehicle);
}

queremove(target)
{
	if(!isdefined(self.enemyque))
	{
		return;
	}
	self.enemyque = maps\_utility::array_remove(self.enemyque,target);
}

queadd(target)
{
	if(!isdefined(target))
		return;
	if(target.health > 0)
	{
		if(isdefined(self.enemyque))
			prequeaddque = true;
		else
			prequeaddque = false;
		self.enemyque = add_to_arrayfinotinarray( self.enemyque, target );
		if(isdefined(self.enemyque) && !prequeaddque)
			level.waters notify ("newenemy");
	}
}

add_to_arrayfinotinarray(array,ent)
{
	doadd = 1;
	if(isdefined(array))
		for(i=0;i<array.size;i++)
		{
			if(array[i] == ent)
				doadd = 0;
		}
	if(doadd == 1)
	{

		array = maps\_utility::add_to_array (array, ent);

	}
	return array;
}

watersattackthink(guy)
{
	thread watersattackwhenidle(guy);
//	thread showque();
	while(1)
	{
		guy waittill ("newenemy");
		if(level.player hasweapon("Panzerfaust") || isdefined(level.nopanzersleft) )
		level.playertruck notify ("buddyevent","attack");
	}
}

watersattackwhenidle(guy)
{
	while(1)
	{
		guy waittill("buddyidle");
		if(isdefined(self.enemyque))
		{
			guy notify ("newenemy");
		}
	}
}

showque()
{
	while(1)
	{
		println("enemy que is ", self.enemyque);
		if(isdefined(self.enemyque))
		println("self.enemyquesize is ",self.enemyque.size);
		wait .2;
	}
}

buddy_panzertime(guy)
{
	level.panzershootingtime = 0;
	animontag(guy,guy.sittag,guy.panzer2aimidle);
	while(!isdefined(self.enemyque))
		animontag(guy,guy.sittag,guy.panzeraimidle);
	guy shoot();
	animontag(guy,guy.sittag,guy.panzeraimfire);

}

remindplayertousepanzer()
{
	self endon ("buddypain");
	level endon ("nopanzer");
	level endon ("endstartsequence");
	timer = gettime()+10000;
	while(timer>gettime())
	{
		wait 4;
		if(level.player hasweapon ("panzerfaust") && isdefined(self.enemyque))
			level.waters maps\truckride::talker("truckride_waters_fireitdammit");
	}
	self notify("buddyevent","getpanzerforself");
}

talkaboutlastpanzer()
{
	level waittill ("nomorepanzers");
	if(!isdefined(level.talkedoflastpanzerfaust))
		level.talkedoflastpanzerfaust = 1;
	else
		return;
	if(level.waters.talking)
		level.waters waittill("quetalked");
	level.waters maps\truckride::talker("truckride_waters_lastfausts",.7);
}

fireingdirection(vehicle)
{
	vehicle endon ("unload");
	while(1)
	{
		if(isdefined(vehicle.enemyque))
		{
			org1 = self.origin;
//			org2 = self.enemy.origin;
			org2 = vehicle.enemyque[0].origin;
			flipped = vehicle.angles+(0,180,0);
			forwardvec = anglestoforward(flat_angle(flipped));
			rightvec = anglestoright(flat_angle(flipped));
			normalvec = vectorNormalize(org2-org1);
			vectordotup = vectordot(forwardvec,normalvec);
			vectordotright = vectordot(rightvec,normalvec);
			if(vectordotup > .866)
			{
				if(self.pistolattack != self.pistolattacks)
				{
					self.pistolattack = self.pistolattacks;
					self notify ("pistoling","end");  // cancels old animation
				}
			}
			else if(vectordotright > 0)
			{
				if(self.pistolattack != self.pistolattackr)
				{
					self.pistolattack = self.pistolattackr;
					self notify ("pistoling","end");
				}

			}
			else if(vectordotright < 0)
			{
				if(self.pistolattack != self.pistolattackl)
				{
					self.pistolattack = self.pistolattackl;
					self notify ("pistoling","end");
				}

			}
		}
		waitframe();
	}
}

flat_angle(angle)
{
	rangle = (0,angle[1],0);
	return rangle;
}

flat_origin(org)
{
	rorg = (org[0],org[1],0);
	return rorg;

}