package;

import Coin.Coin_2;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends MainState
{
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var walls_2:FlxTilemap;

	var player:Player;
	var coins:FlxTypedGroup<Coin>;
	var coins_2:FlxTypedGroup<Coin_2>;

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

		walls_2 = map.loadTilemap(AssetPaths.overmap__png, "tile_2");
		walls_2.follow();
		walls_2.setTileProperties(1, NONE);
		walls_2.setTileProperties(2, ANY);
		add(walls_2);

		player = new Player();
		add(player);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		coins_2 = new FlxTypedGroup<Coin_2>();
		add(coins_2);

		map.loadEntities(placeEntities, "entity");
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
		FlxG.camera.follow(player, TOPDOWN);

		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, playerTouchCoin);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up)
			player.velocity.y = -100;
		else if (down)
			player.velocity.y = 100;
		else
			player.velocity.y = 0;

		if (left)
			player.velocity.x = -100;
		else if (right)
			player.velocity.x = 100;
		else
			player.velocity.y = 0;
	}

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
