package playstate;

import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import main.Util;

class Level2 extends MainState
{
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var walls_2:FlxTilemap;

	var player:Player;
	var coins:FlxTypedGroup<Coin>;
	var flag:FlxTypedGroup<Flag>;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	var lev:Int = 1;

	override public function create()
	{
		super.create();

		map = new FlxOgmo3Loader(Paths.levelProject__ogmo, Paths.lev1__json);

		FlxG.camera.follow(player, LOCKON, 1);

		walls = map.loadTilemap(Paths.tilemap_1__png, "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		player = new Player();
		add(player);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		flag = new FlxTypedGroup<Flag>();
		add(flag);

		map.loadEntities(placeEntities, "entity");
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
				coins.add(new Coin(x, y));

			case "flag":
				flag.add(new Flag(x, y));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.save.data.runSpeed = Std.parseInt(Util.fileString(Paths.runSpeed__txt));

		FlxG.camera.zoom = camZoom;
		FlxG.camera.follow(player, TOPDOWN);

		FlxG.collide(player, walls);

		FlxG.overlap(player, coins, playerTouchCoin);
		FlxG.overlap(player, flag, playerTouchFlag);

		var up:Bool = FlxG.keys.anyPressed([UP, W]);
		var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right)
			left = right = false;

		if (left)
			player.animation.play("left");

		if (right)
			player.animation.play("right");

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

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}

	function playerTouchFlag(player:Player, flag:Coin)
	{
		if (player.alive && player.exists && flag.alive && flag.exists)
		{
			flag.kill();

			FlxG.switchState(new MenuState());
		}
	}
}
