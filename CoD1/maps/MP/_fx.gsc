print_org(fxcommand, fxId, fxPos, waittime)
{
	if(getcvar("debug") == "1")
	{
		println("{");
		println("\"origin\" \"" + fxpos[0] + " " + fxpos[1] + " " + fxpos[2] + "\"");
		println("\"classname\" \"script_model\"");
		println("\"model\" \"xmodel/fx\"");
		println("\"script_fxcommand\" \"" + fxcommand + "\"");
		println("\"script_fxid\" \"" + fxid + "\"");
		println("\"script_delay\" \"" + waittime + "\"");
		println("}");
	}
}

OneShotfx(fxId, fxPos, waittime, fxPos2)
{
//	level thread print_org("OneShotfx", fxId, fxPos, waittime);
	level thread OneShotfxthread(fxId, fxPos, waittime, fxPos2);
}

OneShotfxthread( fxId, fxPos, waittime, fxPos2 )
{
	wait .05;	// waitframe

	wait waittime;
	if(isdefined(fxPos2))
		fxPos2 = vectornormalize(fxPos2 - fxPos);
		
	if(isdefined(fxPos2))
		script_playfx(level._effect[fxId], fxPos, fxPos2);
	else
		script_playfx(level._effect[fxId], fxPos);
}

loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop)
{
//	level thread print_org("loopfx", fxId, fxPos, waittime);
	level thread loopfxthread(fxId, fxPos, waittime, fxPos2, fxStart, fxStop);
}

loopfxthread(fxId, fxPos, waittime, fxPos2, fxStart, fxStop)
{
	wait .05;	// waitframe
	
//	println("fx testing running Id: ", fxId);
	if((isdefined(level.scr_sound)) && (isdefined(level.scr_sound[fxId])))
		loopSound(level.scr_sound[fxId], fxPos);

	if(isdefined(fxPos2))
		fxPos2 = vectornormalize (fxPos2 - fxPos);
		
	dist = 0;

	if(isdefined(fxStart))
		level waittill("start fx" + fxStart);
	
	while(1)
	{
		thread loopfxthread_think(fxId, fxPos, waittime, fxPos2, dist, fxStop);
		if(isdefined(fxStop) || isdefined(fxStart))
		{
			level waittill("stop fx" + fxStop);
			level waittill("start fx" + fxStart);
		}
		else
			return;
	}
}

loopfxthread_think(fxId, fxPos, waittime, fxPos2, dist, fxStop)
{
	if(isdefined(fxStop))
		level endon ("stop fx" + fxStop);
		
	if(isdefined(fxPos2))
	{
		for(;;)
		{
			if(dist)
			{
				if(distance(level.player getorigin(), fxPos) < dist)
					playfx(level._effect[fxId], fxPos, fxPos2);
			}
			else
				playfx(level._effect[fxId], fxPos, fxPos2);
						
			wait waittime;
		}
	}
	else
	{		
		for(;;)
		{
			if(dist)
			{
				if (distance(level.player getorigin(), fxPos) < dist)
					script_playfx(level._effect[fxId], fxPos);
			}
			else
				script_playfx(level._effect[fxId], fxPos);
						
			wait waittime;
		}
    }
}

loopSound(sound, Pos, waittime)
{
//	level thread print_org("loopSound", sound, Pos, waittime);
	level thread loopSoundthread(sound, Pos, waittime);
}

loopSoundthread(sound, Pos, waittime)
{
	org = spawn("script_origin", (pos));
	
	org.origin = pos;
//	println ("hello1 ", org.origin, sound);
	org playLoopSound(sound);
}

setup_fx()
{
	if((!isdefined(self.script_fxid)) || (!isdefined(self.script_fxcommand)) || (!isdefined(self.script_delay)))
	{
//		println (self.script_fxid);
//		println (self.script_fxcommand);
//		println (self.script_delay);
//		println ("Effect at origin ", self.origin," doesn't have script_fxid/script_fxcommand/script_delay");
//		self delete();
		return;
	}

//	println ("^a Command:", self.script_fxcommand, " Effect:", self.script_fxID, " Delay:", self.script_delay, " ", self.origin);

	if(isdefined(self.target))
		org = getent (self.target).origin;
		
	if(isdefined(self.script_fxstart))
		fxStart = self.script_fxstart;
		
	if(isdefined(self.script_fxstop))
		fxStop = self.script_fxstop;
	
	if(self.script_fxcommand == "OneShotfx")
		OneShotfx(self.script_fxId, self.origin, self.script_delay, org);
	if(self.script_fxcommand == "loopfx")
		loopfx(self.script_fxId, self.origin, self.script_delay, org, fxStart, fxStop);
	if(self.script_fxcommand == "loopsound")
		loopsound(self.script_fxId, self.origin, self.script_delay, org);

	self delete();		
}

script_print_fx()
{
	if((!isdefined(self.script_fxid)) || (!isdefined(self.script_fxcommand)) || (!isdefined(self.script_delay)))
	{
		println("Effect at origin ", self.origin," doesn't have script_fxid/script_fxcommand/script_delay");
		self delete();
		return;
	}

	if(isdefined(self.target))
		org = getent(self.target).origin;
	else
		org = "undefined";

//	println ("^a Command:", self.script_fxcommand, " Effect:", self.script_fxID, " Delay:", self.script_delay, " ", self.origin);
	if(self.script_fxcommand == "OneShotfx")
		println("maps\_fx::OneShotfx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
	
	if(self.script_fxcommand == "loopfx")
		println("maps\_fx::LoopFx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
	
	if(self.script_fxcommand == "loopsound")
		println("maps\_fx::LoopSound(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
}

script_playfx(id, pos, pos2)
{
	if(!id)
		return;

	if(isdefined(pos2))
		playfx(id, pos, pos2);
	else
		playfx(id, pos);
}

script_playfxontag(id, ent, tag)
{
	if(!id)
		return;
		
	playfxontag(id, ent, tag);
}
