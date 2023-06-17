package main;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUISubState;
#if studioALLOW
import flixel.addons.studio.FlxStudio;
#end

class MainSubState extends FlxUISubState
{
	public function new()
	{
		super();
		trace("go sub");

		#if studioALLOW
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
