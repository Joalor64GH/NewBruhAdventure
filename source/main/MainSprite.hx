package main;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class MainSprite extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0, ?Graphic:FlxGraphicAsset)
	{
		super(x, y, Graphic);
	}

	public static function mouseImg()
	{
		FlxG.mouse.load(Paths.mouse__png);
	}
}
