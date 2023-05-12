package main;

import flixel.FlxG;
import flixel.addons.ui.FlxUISprite;

class MainSprite extends FlxUISprite
{
	// to lazy for this
	private var up:Bool = FlxG.keys.anyPressed([UP, W]);
	private var down:Bool = FlxG.keys.anyPressed([DOWN, S]);
	private var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
	private var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
	}

	public static function mouseImg()
	{
		FlxG.mouse.load(Paths.mouse__png);
	}
}
