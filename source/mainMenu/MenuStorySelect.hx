package mainMenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuStorySelect extends MainState
{
	var list:Array<String> = ['storyMode', 'freeplayMode'];

	var menu_group:FlxTypedGroup<MenuMode>;
	var select:Int = 0;
	var desc:FlxText;

	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.scrollFactor.set();
		add(bg);

		menu_group = new FlxTypedGroup<MenuMode>();
		add(menu_group);

		for (i in 0...list.length)
		{
			var selectThing:MenuMode = new MenuMode(300, 0);
			selectThing.ID = i;
			selectThing.screenCenter(Y);
			selectThing.scrollFactor.set();
			menu_group.add(selectThing);
		}

		var pngTitle:FlxSprite = new FlxSprite(0, 100).loadGraphic(Paths.title_png__png);
		pngTitle.screenCenter(X);
		pngTitle.scrollFactor.set();
		pngTitle.scale.set(3, 3);
		add(pngTitle);

		var text:FlxText = new FlxText(0, 100, 0, "- Select Mode -", 20);
		text.screenCenter(X);
		text.scrollFactor.set();
		add(text);

		desc = new FlxText(0, 160, 0, "", 20);
		desc.screenCenter(Y);
		desc.y += 160;
		desc.alignment = CENTER;
		add(desc);

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
						spr.animation.play("storyMode_select");
					else
						spr.animation.play("storyMode_idle");

				case 1:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("freeplay_select");
					else
						spr.animation.play("freeplay_idle");
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

		menu_group.forEach(function(spr:MenuMode)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed)
			{
				switch (list[select])
				{
					case "storyMode":
						trace('story mode open');
						PlayState.levRun(45);
						FlxG.switchState(new PlayState());

					case "freeplayMode":
						FlxG.switchState(new MenuSelectLevel());
				}
			}
		});

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}

	function change(change:Int = 0)
	{
		select += change;

		if (select < 0)
			select = menu_group.length - 1;
		if (select >= menu_group.length)
			select = 0;

		menu_group.forEach(function(spr:MenuMode)
		{
			switch (select)
			{
				case 0:
					desc.text = "Play thought story mode";
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("storyMode_select");
					else
						spr.animation.play("storyMode_idle");

				case 1:
					desc.text = "Play all non-main stage (level)";
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("freeplay_select");
					else
						spr.animation.play("freeplay_idle");
			}

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});
	}
}
