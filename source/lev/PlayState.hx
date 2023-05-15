package lev;

import Coin.Coin_2;
import Coin;
import Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends MainState
{
	var player:Player;
	var coin:FlxTypedGroup<Coin>;
	var coin_2:FlxTypedGroup<Coin_2>;
	var flag:Flag;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	static var jsonPaths:String = '';

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

		coin_2 = new FlxTypedGroup<Coin_2>();
		add(coin_2);

		flag = new Flag();
		add(flag);

		map.loadEntities(placeEntities, 'entity');
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

			case 'flag':
				flag.x = x;
				flag.y = y;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);

		var pause:Bool = FlxG.keys.justPressed.ESCAPE;
		var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);
		var up:Bool = FlxG.keys.anyPressed([W, UP, SPACE]);

		if (pause)
		{
			openSubState(new PauseSubState());
		}

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
			player.turnLeft(true);

		if (right)
			player.turnRight(false);

		if (left && right)
			left = right = false;

		if (left)
			player.velocity.x = -100;
		else if (right)
			player.velocity.x = 100;
		else
			player.velocity.x = 0;
	}
}
