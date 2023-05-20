package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import main.MainData;
import mainMenu.MenuImage;
import mainMenu.MenuStorySelect;

class MenuState extends MainState
{
	var list:Array<String> = ['play', 'credits', 'options', 'awards', 'exit'];

	var menu_group:FlxTypedGroup<MenuImage>;
	var select:Int = 0;

	override public function create()
	{
		super.create();

		MainData.checkData();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.scrollFactor.set();
		add(bg);

		menu_group = new FlxTypedGroup<MenuImage>();
		add(menu_group);

		for (i in 0...list.length)
		{
			var selectThing:MenuImage = new MenuImage(300, 0);
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

		var text:FlxText = new FlxText(0, 100, 0, "- Version: " + Application.current.meta.get('version') + " -", 20);
		text.screenCenter(X);
		text.scrollFactor.set();
		add(text);

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
						spr.animation.play("credits_select");
					else
						spr.animation.play("credits_idle");

				case 2:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("options_select");
					else
						spr.animation.play("options_idle");

				case 3:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("awards_select");
					else
						spr.animation.play("awards_idle");

				case 4:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("quit_select");
					else
						spr.animation.play("quit_idle");
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

		menu_group.forEach(function(spr:MenuImage)
		{
			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed)
			{
				switch (list[select])
				{
					case "play":
						FlxG.switchState(new MenuStorySelect());

					case "credits":
						FlxG.switchState(new CreditsState());

					case "options":
						FlxG.switchState(new OptionsMenu());

					case "awards":
						FlxG.switchState(new AwardsMenu());

					case "exit":
						openSubState(new QuitSubState());
				}
			}
		});

		if (FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new QuitSubState());
		}
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
						spr.animation.play("credits_select");
					else
						spr.animation.play("credits_idle");

				case 2:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("options_select");
					else
						spr.animation.play("options_idle");

				case 3:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("awards_select");
					else
						spr.animation.play("awards_idle");

				case 4:
					if (FlxG.mouse.overlaps(spr))
						spr.animation.play("quit_select");
					else
						spr.animation.play("quit_idle");
			}

			if (FlxG.mouse.overlaps(spr))
			{
				FlxG.mouse.load(Paths.overlaps_mouse__png);
			}

			spr.updateHitbox();
		});
	}
}
