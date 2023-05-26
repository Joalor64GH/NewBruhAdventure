package mainMenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class DifficultySelectSubState extends FlxSubState
{
	var mode:Array<String> = ['easy', 'hard'];

	var modeSelect:FlxTypedGroup<FlxSprite>;
	var curMode:Int = 0;

	var x:Float = 0;
	var y:Float = 0;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.screenCenter();
		bg.scrollFactor.set();
		bg.alpha = 0.6;
		add(bg);

		var text:FlxText = new FlxText(0, 100, 0, "- Select Mode -", 20);
		text.screenCenter(X);
		text.scrollFactor.set();
		add(text);

		modeSelect = new FlxTypedGroup<FlxSprite>();
		add(modeSelect);

		for (i in 0...mode.length)
		{
			var inMode:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.mode_select__png, true, 64, 32);
			inMode.animation.add("easy_normall", [0]);
			inMode.animation.add("easy_select", [1]);
			inMode.animation.add("hard_normall", [2]);
			inMode.animation.add("hard_select", [3]);
			// inMode.screenCenter();
			inMode.scrollFactor.set();
			modeSelect.add(inMode);
		}

		change();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		menu_group.forEach(function(spr:MenuMode)
		{
			switch (select)
			{
				case 0:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("easy_select");
					else
						spr.animation.play("easy_normall");

				case 1:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("hard_select");
					else
						spr.animation.play("hard_normall");
			}

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});

		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			change(-1);
		}
		else if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			change(1);
		}
	}

	function change(change:Int = 0)
	{
		curMode += change;

		if (curMode < 0)
			curMode = modeSelect.length - 1;
		if (curMode >= modeSelect.length)
			curMode = 0;

		modeSelect.forEach(function(spr:FlxSprite)
		{
			switch (curMode)
			{
				case 0:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("easy_select");
					else
						spr.animation.play("easy_normall");

				case 1:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("hard_select");
					else
						spr.animation.play("hard_normall");
			}

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});
	}
}
