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
	var flag:Flag;

	static inline var SPEED:Float = 100;

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
		FlxG.camera.follow(player, PLATFORMER);
		// FlxG.collide(player, walls);
		FlxG.overlap(player, coin, touchCoin);

		var pause:Bool = FlxG.keys.justPressed.ESCAPE;

		if (pause)
		{
			openSubState(new PauseSubState());
		}

		var up:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		#if FLX_KEYBOARD
		up = FlxG.keys.anyJustPressed([UP, W, SPACE]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		#end

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

		if (left && right)
			left = right = false;

		if (left || right)
		{
			var newAngle:Float = 0;
			if (left)
			{
				newAngle = 180;
				player.facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				player.facing = RIGHT;
			}

			// determine our velocity based on angle and speed
			player.velocity.setPolarDegrees(SPEED, newAngle);
		}
		// check if the player is moving, and not walking into walls

		switch (player.facing)
		{
			case LEFT:
				player.animation.play("left");
			case RIGHT:
				player.animation.play("right");
			case _:
		}
	}

	function touchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
