package lev;

import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import main.MainState;
import main.Util;

class PlayState extends MainState
{
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	static var jsonPaths:String = '';

	var coin:FlxTypedGroup<Coin>;
	var player:Player;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	public static function levRun(typeLev:Int = 0)
	{
		switch (typeLev)
		{
			case 0:
				jsonPaths = Paths.lev1__json;
				trace('load: ' + jsonPaths);

			case 1:
				jsonPaths = Paths.lev2__json;
				trace('load: ' + jsonPaths);
		}
	}

	override public function create()
	{
		super.create();

		map = new FlxOgmo3Loader(Paths.levelProject__ogmo, jsonPaths);
		walls = map.loadTilemap(Paths.tilemap_1__png, 'walls');
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		player = new Player();
		add(player);

		coin = new FlxTypedGroup<Coin>();
		add(coin);
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case 'player':
				player.setPosition(x, y);
				player.acceleration.y = 900;
				player.maxVelocity.y = 300;

			case 'coin':
				coin.add(new Coin(x, y));
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.save.data.runSpeed = Std.parseInt(Util.fileString(Paths.runSpeed__txt));

		FlxG.camera.follow(player, PLATFORMER);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coin, touchCoin);

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
			player.velocity.x = -100 * FlxG.save.data.runSpeed;
		else if (right)
			player.velocity.x = 100 * FlxG.save.data.runSpeed;
		else
			player.velocity.x = 0;
	}

	function touchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
