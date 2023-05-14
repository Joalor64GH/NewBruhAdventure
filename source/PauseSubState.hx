package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseSubState extends FlxSubState
{
	var text:FlxText;

	public function new()
	{
		super(FlxColor.BLACK);

		text = new FlxText(0, 0, 0, "- PAUSE -
            \nPress Enter to resume\nPress R to restart\nPress Esc to return", 16);
		text.screenCenter();
		text.alignment = CENTER;
		text.scrollFactor.set();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			close();
		}

		if (FlxG.keys.justPressed.R)
		{
			FlxG.resetState();
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
