package main;

import lime.utils.Assets;

using StringTools;

// just copy fnf code here
class Util
{
	public static function fileText(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function fileString(path:String):String
	{
		var daThing:String = Assets.getText(path).trim();

		return daThing;
	}
}
