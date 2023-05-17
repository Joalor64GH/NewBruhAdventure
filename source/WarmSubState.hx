package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class WarmSubState extends FlxSubState
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
            \n!That Level can't play right now!\nPlease wait for a new update\n\nPress Enter to close", 16);
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
	}
}

class WarmSubState2 extends FlxSubState
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
            \n!Level Not Found!\n\nPress Enter to close", 16);
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
	}
}
