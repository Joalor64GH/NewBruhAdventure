package main;

import flixel.FlxG;

class MainData
{
	public static function fpsCounter(ifbool:Bool)
	{
		if (ifbool)
		{
			ifbool = true;
		}
		else
		{
			ifbool = false;
		}

		FlxG.save.data.fpsCounter = ifbool;

		return ifbool;
	}

	public static function checkData()
	{
		if (FlxG.save.data.fpsCounter == null)
			fpsCounter(true);
	}
}
