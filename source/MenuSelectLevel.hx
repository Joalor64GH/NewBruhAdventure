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
			var selectThing:MenuSelect = new MenuSelect();
			selectThing.ID = i;
			selectThing.screenCenter(Y);
			selectThing.scrollFactor.set();
			selectThing.x -= 30;
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

		if (FlxG.keys.justPressed.ENTER)
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
			}
		}
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
			switch (select)
			{
				case 0:
					spr.animation.play("lev1");

				case 1:
					spr.animation.play("lev2");

				case 2:
					spr.animation.play("lev3");

				case 3:
					spr.animation.play("lev4");

				case 4:
					spr.animation.play("lev5");

				case 5:
					spr.animation.play("lev6");

				case 6:
					spr.animation.play("lev7");

				case 7:
					spr.animation.play("lev8");

				case 8:
					spr.animation.play("lev9");

				case 9:
					spr.animation.play("lev10");

				case 10:
					spr.animation.play("lev11");

				case 11:
					spr.animation.play("lev12");

				case 12:
					spr.animation.play("lev13");

				case 13:
					spr.animation.play("lev14");

				case 14:
					spr.animation.play("lev15");

				case 15:
					spr.animation.play("lev16");

				case 16:
					spr.animation.play("lev17");

				case 17:
					spr.animation.play("lev18");

				case 18:
					spr.animation.play("lev19");

				case 19:
					spr.animation.play("lev20");
			}

			spr.updateHitbox();
		});
	}
}
