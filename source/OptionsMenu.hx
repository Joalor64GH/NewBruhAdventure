package;

import flixel.FlxG;
import flixel.text.FlxText;
import sys.io.File;
import util.Util;

/**
 * Since this options i have no idea for that so i just make this into a run speed change
 */
class OptionsMenu extends MainState
{
	// var list:Array<String> = ["Run Speed"];
	var text:FlxText;
	var number:Float = Std.parseFloat(Util.fileString(Paths.runSpeed__txt));

	override public function create()
	{
		super.create();

		text = new FlxText(0, 0, 0, "", 22);
		text.scrollFactor.set();
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		text.text = "Run Speed Change: " + number + "\nPress Left or Right to change\nPress ESC to return Menu";

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			number -= 0.1;
		}
	}
}
