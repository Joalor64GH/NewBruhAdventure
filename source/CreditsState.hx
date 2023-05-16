package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CreditsState extends MainState
{
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
		textCredits.scrollFactor.set();
		textCredits.alignment = CENTER;
		textCredits.screenCenter(Y);
		add(textCredits);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			curPage -= 1;
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			curPage += 1;
		}

		if (curPage == 2)
		{
			curPage = 0;
		}

		if (curPage == -1)
		{
			curPage = 1;
		}

		switch (curPage)
		{
			case 0:
				textCredits.text = "- PAGE 1 : Coder -" + "\n- Huy1234TH: Code, Art of This Project\n- Wither362: Coder of This Project";
			case 1:
				textCredits.text = "- PAGE 2 : SOUND AND MUSIC (STILL NEED HELP) -" + "\n- Mixkit: (I took the sound from this website since it free)";
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
