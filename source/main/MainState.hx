package main;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.util.FlxSave;

class MainState extends FlxUIState
{
	private var version:String = "1.0.0";
	var save:FlxSave = new FlxSave();

	private var up:Bool = FlxG.keys.anyPressed([UP, W]);
	private var down:Bool = FlxG.keys.anyPressed([DOWN, S]);
	private var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
	private var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

	override public function create()
	{
		super.create();

		save.bind("huy1234th", "data");
		MainData.checkData();
		if (FlxG.keys.justPressed.F10)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		MainSprite.mouseImg();

		if (MainData.fpsCounter(false))
		{
			FlxG.stage.removeChild(Main.fpsCounter);
		}
		else
		{
			FlxG.stage.addChild(Main.fpsCounter);
		}
	}
}
