package;

import Coin.Coin_2;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxVirtualPad;

class PlayState extends MainState
{
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var player:Player;
	var coins:FlxTypedGroup<Coin>;
	var coins_2:FlxTypedGroup<Coin_2>;

	var pad:FlxVirtualPad;

	override public function create()
	{
		super.create();

		FlxG.camera.follow(player, TOPDOWN, 1);

		map = new FlxOgmo3Loader(AssetPaths.overworld__ogmo, AssetPaths.lv1__json);
		walls = map.loadTilemap(AssetPaths.overmap__png, "tile");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		player = new Player();
		add(player);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		coins_2 = new FlxTypedGroup<Coin_2>();
		add(coins_2);

		map.loadEntities(placeEntities, "entity");

		#if android
		pad = new FlxVirtualPad(FlxDPadMode.FULL, FlxActionMode.NONE);
		add(pad);
		#end
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "coin")
		{
			coins.add(new Coin(entity.x, entity.y));
		}
		else if (entity.name == "coin_2")
		{
			coins_2.add(new Coin_2(entity.x, entity.y));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, playerTouchCoin);

		var up:Bool = pad.buttonUp.pressed || FlxG.keys.anyPressed([UP, W]);
		var down:Bool = pad.buttonDown.pressed || FlxG.keys.anyPressed([DOWN, S]);
		var left:Bool = pad.buttonLeft.pressed || FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = pad.buttonRight.pressed || FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up)
		{
			player.velocity.y = -100;
			player.animation.play("up");
		}
		else if (down)
		{
			player.velocity.y = 100;
			player.animation.play("down");
		}
		else
		{
			player.velocity.y = 0;
		}

		if (left)
		{
			player.velocity.x = -100;
			player.animation.play("left");
		}
		else if (right)
		{
			player.velocity.x = 100;
			player.animation.play("right");
		}
		else
		{
			player.velocity.x = 0;
		}
	}

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
