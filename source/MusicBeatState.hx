package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;

class MusicBeatState extends FlxUIState
{
	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var totalBeats:Int = 0;
	private var totalSteps:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function create()
	{
		if (transIn != null)
			trace('reg ' + transIn.region);

		#if (!web)
		TitleState.soundExt = '.ogg';
		#end

		super.create();

		FlxG.save.flush();
	}

	override function update(elapsed:Float)
	{
		var oldStep:Int = curStep;

		updateCurStep();

		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	/**
	 * CHECKS EVERY FRAME
	 */
	private function everyStep():Void
	{
		if (Conductor.songPosition > lastStep + Conductor.stepCrochet - Conductor.safeZoneOffset
			|| Conductor.songPosition < lastStep + Conductor.safeZoneOffset)
		{
			if (Conductor.songPosition > lastStep + Conductor.stepCrochet)
			{
				stepHit();
			}
		}
	}

	private function updateCurStep():Void
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		var tempStep = lastStep;
		lastStep = Conductor.songPosition;
		FlxG.watch.addQuick('timeFromLastStep', lastStep - tempStep);
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		var tempBeat = lastBeat;
		lastBeat = Conductor.songPosition;
		FlxG.watch.addQuick('timeFromLastBeat', lastBeat - tempBeat);
		totalBeats += 1;
	}
}
