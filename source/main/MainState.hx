package main;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.util.FlxSave;

class MainState extends FlxUIState
{
	private var version:String = "1.0.0";
	var save:FlxSave = new FlxSave();

	override public function create()
	{
		super.create();

		save.bind("huy1234th", "data");
		FlxG.fullscreen = !FlxG.fullscreen;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
