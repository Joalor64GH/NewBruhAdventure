package util;

import flixel.FlxG;
import lime.utils.Assets;
import openfl.Lib;
import openfl.events.Event;

using StringTools;

// just copy fnf code here
class Util
{
	inline public static function fileText(path:String):Array<String>
	{
		return [
			for (i in Assets.getText(path).trim().split('\n')) i.trim()
		];
	}

	inline public static function fileString(path:String):String
	{
		return Assets.getText(path).trim();
	}

	inline public static function updateFrames(){
		Lib.current.addEventListener(Event.ENTER_FRAME, _ -> {
			if (FlxG.stage != null) // so we don't update it every frame to prevent lag
				Main.updateFrameRate(60);
		});
	}
}
