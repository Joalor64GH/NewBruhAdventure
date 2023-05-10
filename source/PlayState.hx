package;

import Coin.Coin_2;
import KindWater.Lava;
import KindWater.Water;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;

class PlayState extends MainState
{
	var map:FlxOgmo3Loader;
	var tile:FlxTilemap;

	// coin stuff
	var coin:FlxTypedGroup<Coin>;
	var coin_2:FlxTypedGroup<Coin_2>;

	// water kind stuff
	var water:FlxTypedGroup<Water>;
	var lava:FlxTypedGroup<Lava>;

	// flag
	var flag:FlxTypedGroup<Flag>;

	var player:Player;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	override public function create()
	{
		super.create();

		map = new FlxOgmo3Loader(AssetPaths.level__ogmo, AssetPaths.lv1__json);
		tile = map.loadTilemap(AssetPaths.tilemap_1__png, "tile");
		tile.follow();
		tile.setTileProperties(1, NONE);
		tile.setTileProperties(2, ANY);
		add(tile);

		player = new Player();
		add(player);

		coin = new FlxTypedGroup<Coin>();
		add(coin);

		coin_2 = new FlxTypedGroup<Coin_2>();
		add(coin_2);

		water = new FlxTypedGroup<Water>();
		add(water);

		lava = new FlxTypedGroup<Lava>();
		add(lava);

		flag = new FlxTypedGroup<Flag>();
		add(flag);

		map.loadEntities(placeEntities, "en");
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);
				player.acceleration.y = 900;
				player.maxVelocity.y = 300;

			case "coin":
				coin.add(new Coin(x, y));

			case "flag":
				flag.add(new Flag(x, y));

			case "coin_2":
				coin_2.add(new Coin_2(x, y));

			case "lava":
				lava.add(new Lava(x, y));

			case "water":
				water.add(new Water(x, y));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.camera.zoom = 2;
		FlxG.camera.follow(player, PLATFORMER);
		FlxG.collide(player, tile);
		FlxG.overlap(player, coin, touchCoin_1);
		FlxG.overlap(player, coin_2, touchCoin_2);

		var up:Bool = FlxG.keys.anyPressed([UP, W]);
		var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right)
			left = right = false;

		// From Haxe Snippests
		if (jumping && !up)
			jumping = false;

		if (player.isTouching(DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && up)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		if (jumpTimer > 0 && jumpTimer < 0.25)
			player.velocity.y = -300;

		if (left)
			player.velocity.x = -100;
		else if (right)
			player.velocity.x = 100;
		else
			player.velocity.x = 0;
	}

	function touchCoin_1(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}

	function touchCoin_2(player:Player, coin_2:Coin_2)
	{
		if (player.alive && player.exists && coin_2.alive && coin_2.exists)
		{
			coin_2.kill();
		}
	}
}
