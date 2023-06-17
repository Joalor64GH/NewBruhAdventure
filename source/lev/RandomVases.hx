package lev;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import main.MainSubState;
import util.Util;

class RandomVases extends MainSubState
{
	var titleText:FlxText;
	var text:FlxText;

	// chance
	var common:Float = Std.parseFloat(Util.fileString(Paths.common__txt));
	var uncommon:Float = Std.parseFloat(Util.fileString(Paths.uncommon__txt));
	var rare:Float = Std.parseFloat(Util.fileString(Paths.rare__txt));

	public function new()
	{
		super();

		trace("wow, a random stuff happen!");

		MainSprite.mouseImg();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		bg.scrollFactor.set();
		add(bg);

		titleText = new FlxText(0, 0, 0, "!Random!", 20);
		titleText.scrollFactor.set();
		titleText.screenCenter(X);
		add(titleText);

		text = new FlxText(0, 0, 0, "Press Enter to random", 20);
		text.scrollFactor.set();
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		new FlxTimer().start(Std.parseFloat(Util.fileString(Paths.timer__txt)), function(tmr:FlxTimer)
		{
			if (FlxG.random.bool(rare))
			{
				trace("you got: 1 health plus!");
				PlayState.instance.health += 1;
				text.text = "RARE!\nYou got: 1 health";
				if (FlxG.keys.justPressed.ENTER)
					close();
			}
			else if (FlxG.random.bool(uncommon))
			{
				trace("you got: 500 score");
				PlayState.instance.score += 500;
				text.text = "UNCOMMON!\nYou got: 500 score";
				if (FlxG.keys.justPressed.ENTER)
					close();
			}
			else
			{
				trace("you got: 100 score");
				PlayState.instance.score += 100;
				text.text = "COMMON!\nYou got: 100 score";
				if (FlxG.keys.justPressed.ENTER)
					close();
			}
		});
	}
}
