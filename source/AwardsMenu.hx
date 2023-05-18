package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class AwardsMenu extends MainState
{
	final awards:Array<String> = [
		"Finish Level 1 EX",
		"Collect 20 Yellow Coin",
		"Collect 20 Green Coin",
		"Collect 5 Super Coin",
		"Collect 2 Fake Coin",
		"Collect 1 Rewarded Coin"
	];
	var textAwards:FlxText;
	var curPage:Int = 0;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		textAwards = new FlxText(0, 0, 0, "", 20);
		// textCredits.scrollFactor.set();
		// textCredits.alignment = CENTER;
		textAwards.screenCenter(Y);
		add(textAwards);

		changeText();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			changeText(-1);
		}

		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			changeText(1);
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}

	function changeText(change:Int = 0)
	{
		curPage += change;
		if (curPage >= awards.length)
			curPage = 0;
		if (curPage < 0)
			curPage = awards.length - 1;

		textAwards.text = awards[curPage];
	}
}
