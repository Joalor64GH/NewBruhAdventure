package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class MenuSelectLevel extends MainState
{
	var list:Array<String> = [
		"lev1", "lev2", "lev3", "lev4", "lev5", "lev6", "lev7", "lev8", "lev9", "lev10", "lev11", "lev12", "lev13", "lev14", "lev15", "lev16", "lev17",
		"lev18", "lev19", "lev20"
	];
	var select_lev:FlxTypedGroup<MenuSelect>;
	var select:Int = 0;

	var arrowSelect:SelectArrow;

	override public function create()
	{
		super.create();

		select_lev = new FlxTypedGroup<MenuSelect>();
		add(select_lev);

		for (i in 0...list.length)
		{
			var selectThing:MenuSelect = new MenuSelect(100, 0);
			selectThing.ID = i;
			selectThing.screenCenter(Y);
			selectThing.scrollFactor.set();
			select_lev.add(selectThing);
		}

		arrowSelect = new SelectArrow();
		arrowSelect.scrollFactor.set();
		arrowSelect.screenCenter(Y);
		add(arrowSelect);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
			FlxG.switchState(new MenuState());
		}

		select_lev.forEach(function(spr:MenuSelect)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed)
			{
				switch (list[select])
				{
					case "lev1":
						PlayState.levRun();
						FlxG.switchState(new PlayState());

					case "lev2":
						PlayState.levRun(1);
						FlxG.switchState(new PlayState());

					case "lev3":
						PlayState.levRun(2);
						FlxG.switchState(new PlayState());

					case "lev4":
						PlayState.levRun(3);
						FlxG.switchState(new PlayState());

					case "lev5":
						PlayState.levRun(4);
						FlxG.switchState(new PlayState());

					case "lev6":
						PlayState.levRun(5);
						FlxG.switchState(new PlayState());

					case "lev7":
						PlayState.levRun(6);
						FlxG.switchState(new PlayState());
				}
			}
		});
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
			spr.animation.play("lev" + Std.string(select + 1));
			spr.updateHitbox();
		});
	}
}
