package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class AwardsMenu extends MainState
{
	var checkAwards:String = '';

	var awards:Array<Array<String>> = [
		["Wow... For sure that was hard...", "Finish Level 1 EX"],
		["Oooh... Shiny!", "Collect 20 Yellow Coins"],
		["Are these... Avocados!?", "Collect 20 Green Coins"],
		["I'm... tired.", "Collect 5 Super Coins"],
		["Is this real?!", "Collect 2 Fake Coins"],
		["So that was what I had to do!", "Collect 1 Rewarded Coin"]
	];

	var awardsImage:FlxTypedGroup<AwardsImage>;
	var textAwards:FlxText;
	var textAwardDescription:FlxText;
	var textCheckAwards:FlxText;
	var curPage:Int = 0;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		textAwards = new FlxText(0, 0, 0, "", 20);
		textAwards.screenCenter(Y);
		add(textAwards);

		awardsImage = new FlxTypedGroup<AwardsImage>();
		add(awardsImage);

		for (i in 0...awards.length)
		{
			var selectThing:AwardsImage = new AwardsImage(500, 0);
			selectThing.ID = i;
			selectThing.screenCenter(Y);
			awardsImage.add(selectThing);
		}

		textAwardDescription = new FlxText(0, 40, 0, "", 20);
		textAwardDescription.screenCenter(Y);
		textAwardDescription.y += 40;
		textAwardDescription.alignment = CENTER;
		add(textAwardDescription);

		textCheckAwards = new FlxText(0, 80, 0, "", 20);
		textCheckAwards.screenCenter(Y);
		textCheckAwards.y += 80;
		textCheckAwards.alignment = CENTER;
		add(textCheckAwards);

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

		textAwards.text = awards[curPage][0];
		textAwardDescription.text = awards[curPage][1];
		textCheckAwards.text = checkAwards;

		awardsImage.forEach(function(spr:AwardsImage)
		{
			spr.animation.play("awards" + Std.string(curPage + 1));
		});
	}
}
