package lev;

import Coin;
import KindWater.Liquid;
import Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import util.Util;

/**
 * Why i need make this outdate
 * 
 * Since i want to make some non-main level!
 */
class PlayState extends MainState
{
	var player:Player;
	var coins:FlxTypedGroup<Coin>;
	var flag:Flag;
	var liquids:FlxTypedGroup<Liquid>;
	var vases:FlxTypedGroup<Vases>;
	var thorns:FlxTypedGroup<Thorns>;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var trees:FlxTilemap;
	var shop:FlxTilemap;
	var stone:FlxTilemap;

	var jumpTimer:Float = 0;

	var jumping(get, default):Bool;

	function get_jumping():Bool
	{
		if (player.isTouching(DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer > 0 && jumpTimer < 0.25)
			player.velocity.y = -300;

		if (jumpTimer >= 0 && jumping)
			jumpTimer += FlxG.elapsed;
		else
			jumpTimer = -1;

		return false;
	}

	static var jsonPaths:String = '';
	static var curLevel:String = '';

	var score:Int = 0;
	var scoreTxt:FlxText;

	var health:Int = 5;

	@:isVar
	var left(get, never):Bool;

	inline function get_left():Bool
	{
		player.turnLeft(true);
		inLeft = left;
		stepSound.play(true);
		if (slowNow)
			player.velocity.x = -50 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
		else
			player.velocity.x = -100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));

		return FlxG.keys.anyPressed([LEFT, A]);
	}

	@:isVar
	var right(get, never):Bool;

	inline function get_right():Bool
	{
		player.turnRight(false);
		stepSound.play(true);
		if (slowNow)
			player.velocity.x = 50 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
		else
			player.velocity.x = 100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));

		return FlxG.keys.anyPressed([RIGHT, D]);
	}

	@:isVar
	var up(get, never):Bool;

	inline function get_up():Bool
	{
		jumping = up;
		return FlxG.keys.anyPressed([W, UP, SPACE]);
	}

	/**
	 * Level want to run
	 * @param typeLev cur number (since first is 0 = level 1)
	 */
	public static function levRun(typeLev:Int = 0)
	{
		switch (typeLev)
		{
			case 0:
				// curLevel = 'lev1';
				jsonPaths = Paths.lev1__json;
				trace('load: ' + jsonPaths);
		}
	}

	var restart(get, never):Bool;

	inline function get_restart():Bool
	{
		return false;
	}

	var stepSound:FlxSound;
	var coinSound:FlxSound;

	var slowNow(get, never):Bool;

	function get_slowNow():Bool
	{
		final liquid:Liquid = new Liquid('water');
		if (player.overlaps(liquid) && liquid.slowWalk)
		{
			return true;
		}
		return false;
	}

	var inLeft(default, null):Bool = false;
	var inRight(default, null):Bool = false;

	override public function create()
	{
		super.create();

		FlxG.camera.zoom = camZoom;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		bg.scrollFactor.set();
		add(bg);

		map = new FlxOgmo3Loader(Paths.levelProject__ogmo, jsonPaths);
		walls = map.loadTilemap(Paths.tilemap_1__png, 'walls');
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		trees = map.loadTilemap(Paths.moreTree__png, 'tree');
		trees.follow();
		trees.setTileProperties(1, NONE);
		trees.setTileProperties(2, ANY);
		add(trees);

		stone = map.loadTilemap(Paths.stone__png, 'stone');
		stone.follow();
		stone.setTileProperties(1, NONE);
		stone.setTileProperties(2, ANY);
		add(stone);

		shop = map.loadTilemap(Paths.shop__png, 'fruitShop');
		shop.follow();
		shop.setTileProperties(1, NONE);
		shop.setTileProperties(2, ANY);
		add(shop);

		flag = new Flag();
		add(flag);

		liquids = new FlxTypedGroup<Liquid>();
		add(liquids);

		player = new Player();
		add(player);

		vases = new FlxTypedGroup<Vases>();
		add(vases);

		thorns = new FlxTypedGroup<Thorns>();
		add(thorns);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		map.loadEntities(placeEntities, 'entity');

		// FlxG.sound.playMusic(Paths.grass_step__wav);
		stepSound = FlxG.sound.load(Paths.grass_step__wav, 1);
		coinSound = FlxG.sound.load(Paths.arcade_game_jump_coin__wav, 1);
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

			case 'vases_random', 'vases_coin', 'vases_hurt', 'vases_kill':
				vases.add(new Vases(x, y, entity.name));

			case 'coin', 'coin_2', 'coin_super', 'coin_fake', 'coin_rewarded':
				coins.add(new Coin(x, y, entity.name));

			case 'thorns_nor', 'thorns_veryHurt':
				thorns.add(new Thorns(x, y, entity.name));

			case 'water', 'lava', 'poison':
				liquids.add(new Liquid(x, y, entity.name));

			case 'flag':
				flag.x = x;
				flag.y = y;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.camera.follow(player, LOCKON);

		FlxG.overlap(player, coins, touchedCoin);
		FlxG.overlap(player, flag, touchFlag);
		FlxG.overlap(player, liquids, touchedLiquid);
		FlxG.overlap(player, vases, touchedVases);
		FlxG.overlap(player, thorns, touchedThorns);

		// var down:Bool = FlxG.keys.anyPressed([S, DOWN]);

		if (FlxG.keys.justPressed.ESCAPE)
			openSubState(new PauseSubState());

		if (!inLeft && !inRight)
			player.velocity.x = 0;

		if (health <= 0)
			gameOver();
	}

	function touchedThorns(player:Player, thorns:Thorns)
	{
		if (player.alive && player.exists && thorns.alive && thorns.exists)
		{
			if (player.overlaps(vases)) // less lag interaction
			{
				// for normall thorns
				if (thorns.hurtPlayer)
				{
					health--;
				}

				// for thorns was very hurt
				if (thorns.killPlayer)
				{
					gameOver();
				}
			}
		}
	}

	function touchedVases(player:Player, vases:Vases)
	{
		if (player.alive && player.exists && vases.alive && vases.exists)
		{
			if (player.overlaps(vases)) // less lag interaction
			{
				// for vases contains coin
				if (vases.thatCoin)
				{
					score += vases.score;
					vases.kill();
					trace('vases give player ' + vases.score + ' score');
				}

				// for vases contains something to hurt player
				if (vases.hurtPlayer)
				{
					health--;
					vases.kill();
				}

				// for vases contains something to kill player
				if (vases.killPlayer)
				{
					gameOver();
				}
			}
		}
	}

	function touchedCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			if (!coin.isFakeCoin && coin.canBeScored)
			{
				coinSound.play(true);
				coin.kill();
				score += coin.score;
			}

			trace('player got ' + coin.score + ' score');
		}
	}

	function touchedLiquid(player:Player, liquid:Liquid)
	{
		if (liquid.exists && player.alive && player.exists)
		{
			if (player.overlaps(liquid)) // less lag interaction
			{
				// for poison
				if (liquid.killsWhenTouched)
				{
					// player.kill();
					gameOver();
				}

				// for lava
				if (liquid.firesUpPlayer)
				{
					player.animation.play("in_burn");
					liquid.firesUpPlayer = true;
				}
			}
			else
			{
				// lava
				if (liquid.firesUpPlayer)
				{
					player.animation.play("in_normall");
					liquid.firesUpPlayer = false;
				}
				else // if (player.animation.curAnim != 'right')
					player.animation.play("right");
			}
		}
	}

	function touchFlag(player:Player, flag:Flag)
	{
		if (player.alive && player.exists && flag.alive && flag.exists)
		{
			flag.kill();
			sys.io.File.saveContent("assets/data/lev/" + curLevel + "/" + curLevel + ".txt", Std.string(score));
			FlxG.switchState(new MenuSelectLevel());
		}

		trace('complete ' + curLevel + '!');
	}

	function gameOver()
	{
		openSubState(new GameoverSubState());
	}
}
