package main;

import flixel.FlxG;
import flixel.addons.studio.FlxStudio;
import flixel.addons.ui.FlxUIState;
import flixel.util.FlxSave;
import util.Util;

class MainState extends FlxUIState
{
	var save:FlxSave = new FlxSave();

	var camZoom:Float = Std.parseFloat(Util.fileString(Paths.camZoom__txt));

	override public function create()
	{
		super.create();

		save.bind("huy1234th", "data");
		MainData.checkData();
		if (FlxG.keys.justPressed.F10)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		FlxStudio.create();
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
