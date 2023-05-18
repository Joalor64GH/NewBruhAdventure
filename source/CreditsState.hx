package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CreditsState extends MainState
{
	final credits:Array<String> = [
		"- PAGE 1 : MAIN -" + "\n- Huy1234TH: Code, Art of This Project\n- Wither362: Coder of This Project",
		"- PAGE 2 : SOUND AND MUSIC (STILL NEED HELP) -" +
		"\n- Mixkit: (I took the sound from this website since it free)\n\n\nPress Enter to Enter Mixkit Website!"
	];
	var textCredits:FlxText;
	var curPage:Int = 0;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		textCredits = new FlxText(0, 0, 0, "", 20);
		// textCredits.scrollFactor.set();
		// textCredits.alignment = CENTER;
		textCredits.screenCenter(Y);
		add(textCredits);

		changeText();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			changeText(-1);
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			changeText(1);
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}

		if (FlxG.keys.justPressed.ENTER && curPage == 1)
		{
			FlxG.openURL("https://mixkit.co/");
		}
	}

	function changeText(change:Int = 0)
	{
		curPage += change;
		if (curPage >= credits.length)
			curPage = 0;
		if (curPage < 0)
			curPage = credits.length - 1;

		textCredits.text = credits[curPage];
	}
}
