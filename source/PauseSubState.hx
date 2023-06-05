package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseImage extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.pause_menu__png, true, 64, 32);
		animation.add("resume_normall", [0]);
		animation.add("resume_select", [1]);
		animation.add("restart_normall", [2]);
		animation.add("restart_select", [3]);
		animation.add("return_normall", [4]);
		animation.add("return_select", [5]);

		// scale.set(3, 3);
	}
}

class PauseSubState extends FlxSubState
{
	var text:FlxText;

	var list:Array<String> = ["Resume", "Restart", "Return"];

	// var pause_group:FlxTypedGroup<PauseImage>;
	var select:Int = 0;

	var x:Float = 0;
	var y:Float = 0;

	public function new()
	{
		super();

		MainSprite.mouseImg();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		bg.scrollFactor.set();
		add(bg);

		text = new FlxText(0, 0, 0, "- PAUSE -\n" + "< " + list[select] + " >", 16);
		text.screenCenter();
		text.alignment = CENTER;
		text.scrollFactor.set();
		add(text);

		/*pause_group = new FlxTypedGroup<PauseImage>();
			add(pause_group);

			for (i in 0...list.length)
			{
				var selectThing:PauseImage = new PauseImage(x, y);
				selectThing.ID = i;
				// selectThing.screenCenter();
				pause_group.add(selectThing);
		}*/

		change();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		/*pause_group.forEach(function(spr:PauseImage)
			{
				spr.setPosition(x, y);

				if (FlxG.mouse.overlaps(spr))
				{
					// spr.alpha = 0.6;
					spr.animation.play(list[select] + "_select");
					FlxG.mouse.load(Paths.overlaps_mouse__png);
				}
				else
				{
					spr.animation.play(list[select] + "_normall");
				}

				spr.updateHitbox();
		});*/

		text.text = "- PAUSE -\n" + "< " + list[select] + " >";

		if (FlxG.keys.anyJustPressed([LEFT, A]))
		{
			change(-1);
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]))
		{
			change(1);
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (list[select])
			{
				case "resume":
					close();

				case "restart":
					FlxG.resetState();

				case "return":
					FlxG.switchState(new MenuSelectLevel());
			}
		}
	}

	function change(change:Int = 0)
	{
		select += change;

		if (select < 0)
			select = list.length - 1;
		if (select >= list.length)
			select = 0;

		/*pause_group.forEach(function(spr:PauseImage)
			{
				spr.setPosition(x, y);

				if (FlxG.mouse.overlaps(spr))
				{
					// spr.alpha = 0.6;
					spr.animation.play(list[select] + "_select");
					FlxG.mouse.load(Paths.overlaps_mouse__png);
				}
				else
				{
					spr.animation.play(list[select] + "_normall");
				}

				spr.updateHitbox();
		});*/

		text.text = "- PAUSE -\n" + "< " + list[select] + " >";
	}
}
