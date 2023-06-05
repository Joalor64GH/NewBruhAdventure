package main;

import flixel.FlxG;

class MainData
{
	public static function fpsCounter(ifbool:Bool)
	{
		return FlxG.save.data.fpsCounter = ifbool;
	}

	/**
	 * Check data to loading data game
	 */
	public static function checkData()
	{
		if (FlxG.save.data.fpsCounter == null)
			fpsCounter(true);
	}
}
