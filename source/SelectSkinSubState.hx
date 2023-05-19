package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SelectSkinSubState extends FlxSubState
{
	var text:FlxText;
	var player:Player;
	var slotSkin:String = 'normal';
	var curPlayer:Int = 0;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		bg.scrollFactor.set();
		add(bg);

		text = new FlxText(0, 100, 0, "- Select Skin -", 20);
		text.screenCenter(X);
		text.scrollFactor.set();
		text.scale.set(1, 1);
		add(text);

		player = new Player(0, 0, slotSkin);
		player.screenCenter();
		player.animation.play("right");
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
			close();
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.save.flush();
			Sys.exit(0);
		}

		player.updateHitbox();
	}

	function change(change:Int = 0)
	{
		select += change;

		switch (curPlayer)
		{
			case 0:
				slotSkin = 'normal';

			case 1:
				slotSkin = 'cool_glassed';

			case 2:
				slotSkin = 'speedrun';

			case 3:
				slotSkin = 'blueOne';

			case 4:
				slotSkin = 'yellowOne';
		}

		player.updateHitbox();
	}
}
