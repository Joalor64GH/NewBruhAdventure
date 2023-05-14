package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class MenuSelectLevel extends MainState
{
	var list:Array<String> = ["lev1", "lev2"];
	var select_lev:FlxTypedGroup<MenuSelect>;
	var select:Int = 0;

	override public function create()
	{
		super.create();

		select_lev = new FlxTypedGroup<MenuSelect>();
		add(select_lev);

		for (i in 0...list.length)
		{
			var selectThing:MenuSelect = new MenuSelect();
			selectThing.ID = i;
			selectThing.screenCenter();
			select_lev.add(selectThing);
		}
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
					FlxG.switchState(new Level1());

				case "lev2":
					FlxG.switchState(new Level2());
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
			}

			spr.updateHitbox();
		});
	}
}
