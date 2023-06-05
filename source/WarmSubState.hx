package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class WarmSubState extends FlxSubState
{
	var text:FlxText;

	public static var textType:String = 'cant_play';

	public function new(textType)
	{
		super();

		MainSprite.mouseImg();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		bg.scrollFactor.set();
		add(bg);

		text = new FlxText(0, 0, 0, "", 16);
		text.screenCenter();
		text.alignment = CENTER;
		text.scrollFactor.set();
		add(text);

		switch (textType)
		{
			case "cant_play":
				text.text = "- HEY YOU -
            \n!That Level can't play right now!\nPlease wait for a new update\n\nPress Enter or Click anywhere to close";

			case "not_found":
				text.text = "- HEY YOU -
            \n!Level Not Found!\n\nPress Enter or Click anywhere to close";

			case "story_mode":
				text.text = "- HEY YOU -\nStory Mode is not finished yet!";
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed)
		{
			close();
		}
	}
}
