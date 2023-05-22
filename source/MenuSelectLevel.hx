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
	var list:Array<String> = [
		"lev1", "lev2", "lev3", "lev4", "lev5", "lev6", "lev7", "lev8", "lev9", "lev10", "lev11", "lev12", "lev13", "lev14", "lev15", "lev16", "lev17",
		"lev18", "lev19", "lev20", "lev21", "lev22", "lev23", "lev24", "lev25", "lev26", "lev27", "lev28", "lev29", "lev30", "lev31", "lev32", "lev33",
		"lev34", "lev35", "lev36", "lev37", "lev38", "lev39", "lev40", "lev1ex", "lev2ex", "lev3ex", "lev4ex", "lev5ex"
	]; // too much lol

	var select_lev:FlxTypedGroup<MenuSelect>;
	var select:Int = 0;

	var arrowSelect:SelectArrow;

	var x:Float = 50;
	var y:Float = 180;

	override public function create()
	{
		super.create();

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

		arrowSelect = new SelectArrow(x + -10, 0);
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

			spr.animation.play("lev" + Std.string(select + 1));

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

		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			change(1);
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new mainMenu.MenuStorySelect());
		}

		select_lev.forEach(function(spr:MenuSelect)
		{
			if (FlxG.keys.justPressed.ENTER || (FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed))
			{
				switch (list[select])
				{
					// // all playable level
					// case "lev1", "lev2", "lev3", "lev4", "lev5", "lev6", "lev7", "lev8", "lev9", "lev10", "lev11", "lev12", "lev13", "lev14", "lev15",
					// 	"lev16", "lev17", "lev18", "lev19", "lev20", "lev21", "lev22", "lev23", "lev24", "lev25", "lev26", "lev27", "lev28":
					// 	PlayState.levRun(Std.parseInt(list[select].replace('lev', '')) - 1);
					// 	FlxG.switchState(new PlayState());
					//
					// // all playable ex level
					// case "lev1ex":
					// 	PlayState.levRun(40);
					// 	FlxG.switchState(new PlayState());
					//
					// // all not playable ex level
					// case "lev2ex" | "lev3ex" | "lev4ex" | "lev5ex":
					// 	trace('wait!, you cant play right now!');
					// 	openSubState(new WarmSubState());

					// level didnt not have a json playable file!
					default:
						// trace('level not found!');
						PlayState.levRun(Std.parseInt(list[select].replace('lev', '')) - 1);
						FlxG.switchState(new PlayState());
				}
			}
		});

		/*if (FlxG.keys.justPressed.C)
			{
				openSubState(new SelectSkinSubState());
		}*/
	}

	function change(change:Int = 0)
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
