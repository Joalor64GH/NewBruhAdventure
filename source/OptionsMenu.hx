package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import util.Util;

/**
 * Since this options i have no idea for that so i just make this into a run speed change
 */
class OptionsMenu extends MainState
{
	// var list:Array<String> = ["Run Speed"];
	var text:FlxText;
	var number:Float = Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
	var curPage:Int = 0;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		text = new FlxText(0, 0, 0, "", 22);
		text.scrollFactor.set();
		text.screenCenter(Y);
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		text.text = "Run Speed Change: " + number + "\nPress Left or Right to change\nPress ESC to return Menu";

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			number -= 1;
			sys.io.File.saveContent(Paths.runSpeed__txt, Std.string(number));
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			number += 1;
			sys.io.File.saveContent(Paths.runSpeed__txt, Std.string(number));
		}

		if (number == 0)
		{
			number = 5;
		}

		if (number == 6)
		{
			number = 1;
		}

		if (FlxG.keys.anyJustPressed([ENTER, ESCAPE]))
		{
			FlxG.switchState(new MenuState());
		}
	}
}
