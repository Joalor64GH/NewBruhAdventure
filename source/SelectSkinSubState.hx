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
		player.scale.set(6, 6);
		player.screenCenter();
		player.animation.play("right");
		add(player);

		change();
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

		if (FlxG.keys.anyJustPressed([ENTER, ESCAPE]))
		{
			close();
		}

		if (curPlayer == 5)
		{
			curPlayer = 0;
		}

		if (curPlayer == 0)
		{
			curPlayer = 4;
		}

		player.updateHitbox();
	}

	function change(change:Int = 0)
	{
		curPlayer += change;

		switch (curPlayer)
		{
			case 0:
				slotSkin = 'normal';
				remove(player);
				player = new Player(0, 0, slotSkin);
				player.scale.set(6, 6);
				player.screenCenter();
				player.animation.play("right");
				add(player);

			case 1:
				slotSkin = 'cool_glassed';
				remove(player);
				player = new Player(0, 0, slotSkin);
				player.scale.set(6, 6);
				player.screenCenter();
				player.animation.play("right");
				add(player);

			case 2:
				slotSkin = 'speedrun';
				remove(player);
				player = new Player(0, 0, slotSkin);
				player.scale.set(6, 6);
				player.screenCenter();
				player.animation.play("right");
				add(player);

			case 3:
				slotSkin = 'blueOne';
				remove(player);
				player = new Player(0, 0, slotSkin);
				player.scale.set(6, 6);
				player.screenCenter();
				player.animation.play("right");
				add(player);

			case 4:
				slotSkin = 'yellowOne';
				remove(player);
				player = new Player(0, 0, slotSkin);
				player.scale.set(6, 6);
				player.screenCenter();
				player.animation.play("right");
				add(player);
		}

		player.updateHitbox();
	}
}
