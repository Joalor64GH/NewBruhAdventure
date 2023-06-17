package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import util.Util;

using StringTools;

class MenuSelectLevel extends MainState
{
	/*
	 * alot stuff to load
	 */
	var list:Array<String>;
	var mode:Array<String> = ["easy", "hard"];

	var select_lev:FlxTypedGroup<MenuSelect>;
	var select_mode:FlxTypedGroup<DifficultSelectImage>;

	var select:Int = 0;
	var select_mde:Int = 0;

	var arrowSelect:SelectArrow;

	var x:Float = 100;
	var y:Float = 250;

	override public function create()
	{
		super.create();

		// this code will load by list level txt
		list = Util.fileText(Paths.listLevel__txt);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.scrollFactor.set();
		add(bg);

		var text:FlxText = new FlxText(0, 100, 0, "- Select Level -", 20);
		text.screenCenter(X);
		text.scrollFactor.set();
		text.scale.set(1, 1);
		add(text);

		select_lev = new FlxTypedGroup<MenuSelect>();
		add(select_lev);

		for (i in 0...list.length)
		{
			var selectThing:MenuSelect = new MenuSelect(x, y);
			selectThing.ID = i;
			select_lev.add(selectThing);
		}

		select_mode = new FlxTypedGroup<DifficultSelectImage>();
		add(select_mode);

		for (i in 0...mode.length)
		{
			var modeThing:DifficultSelectImage = new DifficultSelectImage(x, y + 125);
			modeThing.ID = i;
			select_mode.add(modeThing);
		}

		arrowSelect = new SelectArrow(x + -100, 0);
		arrowSelect.scrollFactor.set();
		arrowSelect.screenCenter(Y);
		add(arrowSelect);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		select_lev.forEach(function(spr:MenuSelect)
		{
			spr.setPosition(x, y); // shouldnt this be offset like (x, y + (spr.width * spr.ID)) or something??

			if (FlxG.mouse.overlaps(spr))
				spr.alpha = 0.6;

			// spr.animation.play("lev" + Std.string(select + 1));

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});

		select_mode.forEach(function(spr:DifficultSelectImage)
		{
			spr.setPosition(x, y + 125);

			if (FlxG.mouse.overlaps(spr))
				spr.alpha = 0.6;

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});

		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			changeLev(-1);
		}

		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			changeLev(1);
		}

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			changeDiff(-1);
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			changeDiff(1);
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			changeState(new mainMenu.MenuStorySelect());
		}

		select_lev.forEach(function(spr:MenuSelect)
		{
			if (FlxG.keys.justPressed.ENTER || (FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed))
			{
				switch (list[select])
				{
					default:
						PlayState.levRun(Std.parseInt(list[select].replace('lev', '')) - 1, select_mde);
						changeState(new PlayState());
				}
			}
		});
	}

	function changeDiff(change:Int = 0)
	{
		select_mde += change;

		if (select_mde < 0)
			select_mde = select_mode.length - 1;
		if (select_mde >= select_mode.length)
			select_mde = 0;

		select_mode.forEach(function(spr:DifficultSelectImage)
		{
			spr.setPosition(x, y + 125);

			spr.animation.play(mode[select_mde]);
			spr.updateHitbox();
		});
	}

	function changeLev(change:Int = 0)
	{
		select += change;

		if (select < 0)
			select = select_lev.length - 1;
		if (select >= select_lev.length)
			select = 0;

		select_lev.forEach(function(spr:MenuSelect)
		{
			spr.setPosition(x, y);
			spr.animation.play("lev" + Std.string(select + 1));

			if (FlxG.mouse.overlaps(spr))
			{
				spr.alpha = 0.6;
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});
	}
}
