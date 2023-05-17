package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import util.Util;

class Main extends Sprite
{
	public static var fpsCounter:FPS;
	public static var framerate:Int = Std.parseInt(Util.fileString(Paths.framerate__txt));

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState, framerate, framerate));
		fpsCounter = new FPS(0, 0, 0xFFFFFF);
		addChild(fpsCounter);
	}
}
