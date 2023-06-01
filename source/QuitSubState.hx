#if desktop
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class QuitSubState extends FlxSubState
{
	var text:FlxText;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		bg.scrollFactor.set();
		add(bg);

		text = new FlxText(0, 0, 0, "- HEY YOU -
            \nAre you sure?\nPress Enter to return\nPress Esc to Quit Game", 16);
		text.screenCenter();
		text.alignment = CENTER;
		text.scrollFactor.set();
		text.scale.set(2, 2);
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			close();
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.save.flush();
			Sys.exit(0);
		}
	}
}
#end
