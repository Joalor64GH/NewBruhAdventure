package main;

import flixel.FlxG;
import flixel.addons.ui.FlxUISprite;

class MainSprite extends FlxUISprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
	}

	public static function mouseImg()
	{
		FlxG.mouse.load(Paths.mouse__png);
	}
}
