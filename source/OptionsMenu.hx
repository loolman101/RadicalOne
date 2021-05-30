package;

import Controls.Control;
import Controls.KeyboardScheme;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;
	var coolInputs:Bool = false;
	var controlsStrings:Array<String>;

	var inputSysTxt:FlxText;
	var pressThis:FlxText;

	private var grpControls:FlxTypedGroup<Alphabet>;

	override function create()
	{
		controlsStrings = ['Input System', doThatThing(FlxG.save.data.DFJK)];
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/UI/menuDesat.png');
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		inputSysTxt = new FlxText(FlxG.width - 200, 0, 0, FlxG.save.data.inputSystem, 85);
		inputSysTxt.setFormat("assets/fonts/vcr.ttf", 85, FlxColor.BLACK, RIGHT);
		inputSysTxt.screenCenter();
		inputSysTxt.x += 300;
		add(inputSysTxt);

		pressThis = new FlxText(FlxG.width - 200, 0, 0, 'Press "G" to set offest.', 85);
		pressThis.setFormat("assets/fonts/vcr.ttf", 45, FlxColor.BLACK, RIGHT);
		pressThis.screenCenter();
		pressThis.x += 300;
		pressThis.y += 70;
		pressThis.visible = false;
		add(pressThis);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT && !paused)
		{
			switch(curSelected) {
				case 0:
					if (FlxG.save.data.inputSystem == 'RadicalOne')
						FlxG.save.data.inputSystem = 'Kade Engine';
					else if (FlxG.save.data.inputSystem == 'Kade Engine')
						FlxG.save.data.inputSystem = 'RadicalOne';
					trace(FlxG.save.data.inputSystem);
					inputSysTxt.text = FlxG.save.data.inputSystem;
					inputSysTxt.screenCenter();
					inputSysTxt.x += 300;
					FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);
				case 1:
					FlxG.save.data.DFJK = !FlxG.save.data.DFJK;
					grpControls.remove(grpControls.members[curSelected]);
					var stupid:Alphabet = new Alphabet(0, (70 * curSelected) + 30, doThatThing(FlxG.save.data.DFJK), true, false);
					stupid.isMenuItem = true;
					stupid.targetY = curSelected - 1;
					grpControls.add(stupid);
			}
		}

		if (FlxG.save.data.inputSystem == 'Kade Engine' && curSelected == 0)
			pressThis.visible = true;
		else
			pressThis.visible = false;

		if (FlxG.keys.justPressed.G)
		{
			openSubState(new OffsetThing());
		}

		if (isSettingControl)
			waitingInput();
		else
		{
			if (controls.BACK && !paused)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P && !paused)
				changeSelection(-1);
			if (controls.DOWN_P && !paused)
				changeSelection(1);
		}
	}

	override function openSubState(SubState:FlxSubState)
	{
        if (!paused)
        {
            paused = true;
        }

		super.openSubState(SubState);
	}

    private var paused:Bool = false;

	override function closeSubState()
    {
        if (paused)
        { 
            paused = false;
        }
		super.closeSubState();
	}

	function waitingInput():Void
	{
		if (FlxG.keys.getIsDown().length > 0)
		{
			PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
		}
		// PlayerSettings.player1.controls.replaceBinding(Control)
	}

	var isSettingControl:Bool = false;

	function changeBinding():Void
	{
		if (!isSettingControl)
		{
			isSettingControl = true;
		}
	}

	function doThatThing(yesOrNo:Bool)
	{
		if (yesOrNo == true)
			return 'DFJK';
		else
			return 'WASD';
	}

	function changeSelection(change:Int = 0)
	{
/*		#if !switch
		NGio.logEvent('Fresh');
		#end*/

		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		if (curSelected == 0)
			inputSysTxt.visible = true;
		else
			inputSysTxt.visible = false;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}