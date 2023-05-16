package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class MenuState extends MainState
{
	var list:Array<String> = ['play', 'exit'];

	var menu_group:FlxTypedGroup<MenuImage>;
	var select:Int = 0;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var jsonPaths:String = '';

	function menuRun()
	{
		if (FlxG.random.bool(50)) // 50%
			jsonPaths = Paths.menuMap1__json;
		else if (FlxG.random.bool(25)) // 25%
			jsonPaths = Paths.menuMap2__json;
		else if (FlxG.random.bool(15)) // 15%
			jsonPaths = Paths.menuMap3__json;
		else if (FlxG.random.bool(5)) // 5%
			jsonPaths = Paths.menuMap4__json;
		else if (FlxG.random.bool(2)) // 2%
			jsonPaths = Paths.menuMap5__json;
		else
			jsonPaths = Paths.menuMap1__json;
	}

	override public function create()
	{
		super.create();

		menuRun();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.scrollFactor.set();
		add(bg);

		map = new FlxOgmo3Loader(Paths.levelProject__ogmo, jsonPaths);
		walls = map.loadTilemap(Paths.tilemap_1__png, 'walls');
		walls.screenCenter();
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

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

		change();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		menuRun();

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
						spr.animation.play("quit_select");
					else
						spr.animation.play("quit_idle");
			}

			spr.updateHitbox();
		});
	}
}
