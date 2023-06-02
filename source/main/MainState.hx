package main;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.util.FlxSave;
import util.Util;
#if debug
import flixel.addons.studio.FlxStudio;
#end

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

		#if debug
		FlxStudio.create();
		#end
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

	/**
	 * switch state
	 * @param stageToChange name the state
	 */
	function changeState(stageToChange:FlxState)
	{
		FlxG.switchState(state(stageToChange));
	}

	function state(stageToChange:FlxState):FlxState
	{
		return stageToChange;
	}
}
