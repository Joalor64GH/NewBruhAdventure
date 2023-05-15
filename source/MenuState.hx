package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class MenuState extends MainState
{
	var list:Array<String> = ['play', 'setting', 'exit'];

	var menu_group:FlxTypedGroup<MenuImage>;
	var select:Int = 0;

	override public function create()
	{
		super.create();

		menu_group = new FlxTypedGroup<MenuImage>();
		add(menu_group);

		for (i in 0...list.length)
		{
			var selectThing:MenuImage = new MenuImage();
			selectThing.ID = i;
			selectThing.screenCenter(Y);
			selectThing.scrollFactor.set();
			menu_group.add(selectThing);
		}

		change();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		menu_group.forEach(function(spr:MenuImage)
		{
			switch (select)
			{
				case 0:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("play_select");
					else
						spr.animation.play("play_idle");

				case 1:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("options_select");
					else
						spr.animation.play("options_idle");

				case 2:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("quit_select");
					else
						spr.animation.play("quit_idle");
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

		menu_group.forEach(function(spr:MenuImage)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed)
			{
				switch (list[select])
				{
					case "play":
						FlxG.switchState(new MenuSelectLevel());

					case "exit":
						FlxG.save.flush();
						Sys.exit(0);
				}
			}
		});
	}

	function change(change:Int = 0)
	{
		select += change;

		if (select < 0)
			select = menu_group.length - 1;
		if (select >= menu_group.length)
			select = 0;

		menu_group.forEach(function(spr:MenuImage)
		{
			switch (select)
			{
				case 0:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("play_select");
					else
						spr.animation.play("play_idle");

				case 1:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("options_select");
					else
						spr.animation.play("options_idle");

				case 2:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("quit_select");
					else
						spr.animation.play("quit_idle");
			}

			spr.updateHitbox();
		});
	}
}
