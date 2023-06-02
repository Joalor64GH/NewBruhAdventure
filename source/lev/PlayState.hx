package lev;

import Coin;
import KindWater.Liquid;
import Player;
import flixel.FlxCamera;
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

	public static var gotHardMode:Bool = false;

	var jumpTimer:Float = 0;

	var jumping:Bool = false;

	/**
	 * load tilemap file
	 */
	static var jsonPaths:String = '';

	static var curLevel:String = '';

	var score:Int = 0;
	var scoreTxt:FlxText;

	/**
	 * player health
	 */
	var health(default, set):Int = 5;

	inline function set_health(value:Int):Int
	{
		health = value;
		gameOver(health < value, "");
		return health;
	}

	static var colorInStage:FlxColor;

	var inLeft:Bool = false;
	var inRight:Bool = false;

	// actual controls
	var left:Bool = false;
	var right:Bool = false;
	var up:Bool = false;

	var camHUD:FlxCamera;

	/**
	 * Level want to run
	 * @param typeLev cur number (since first is 0 = level 1)
	 */
	public static function levRun(typeLev:Int = 0)
	{
		switch (typeLev)
		{
			case 0:
				curLevel = 'lev1';
				colorInStage = FlxColor.CYAN;
				if (FlxG.random.bool(30))
				{
					gotHardMode = true;
					jsonPaths = Paths.lev1_hard__json;
				}
				else
				{
					gotHardMode = true;
					jsonPaths = Paths.lev1__json;
				}
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

	override public function create()
	{
		super.create();

		trace("Play game\nLoading json: " + jsonPaths);

		camHUD = new FlxCamera();
		camHUD.bgColor = 0;
		FlxG.cameras.add(camHUD, false);

		FlxG.camera.zoom = camZoom;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, colorInStage);
		bg.scrollFactor.set();
		add(bg);

		map = new FlxOgmo3Loader(Paths.levelProject__ogmo, jsonPaths);
		walls = map.loadTilemap(Paths.tilemap_1__png, 'walls');
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		var bmd = flixel.system.FlxAssets.getBitmapData(Paths.tilemap_1__png);
		if (bmd == null)
			throw "missing asset: " + Paths.tilemap_1__png;
		else
			trace('asset found, width:${bmd.width} height:${bmd.height}'); // should be 48x64

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

		scoreTxt = new FlxText(0, 0, 0, "", 20);
		scoreTxt.scrollFactor.set();
		add(scoreTxt);

		scoreTxt.cameras = [camHUD];
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
		FlxG.camera.follow(player, LOCKON, 0.9);

		FlxG.overlap(player, coins, touchedCoin);
		FlxG.overlap(player, flag, touchFlag);
		FlxG.overlap(player, liquids, touchedLiquid);
		FlxG.overlap(player, vases, touchedVases);
		FlxG.overlap(player, thorns, touchedThorns);

		scoreTxt.text = "Score: " + score;

		if (FlxG.keys.justPressed.ESCAPE)
			openSubState(new PauseSubState());

		if (!inLeft && !inRight)
			player.velocity.x = 0;

		// TODO: find a way to optimize this
		keyInput();
	}

	var speed_file:Float = Std.parseFloat(Util.fileString(Paths.runSpeed__txt));

	/**
	 * Key input moving
	 */
	function keyInput()
	{
		/**
		 * right key
		 */
		if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			player.turnRight(true);
			stepSound.play(true);
			inRight = true;
			if (slowNow)
				player.velocity.x = 50 * speed_file;
			else
				player.velocity.x = 100 * speed_file;
		}
		else
			inRight = false;

		/**
		 * left key
		 */
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			player.turnLeft(true);
			stepSound.play(true);
			inLeft = true;
			if (slowNow)
				player.velocity.x = -50 * speed_file;
			else
				player.velocity.x = -100 * speed_file;
		}
		else
			inLeft = false;

		/**
		 * up key and when jumping
		 */
		if (FlxG.keys.anyPressed([W, UP, SPACE]))
		{
			jumping = true;

			if (jumpTimer > 0 && jumpTimer < 0.25)
				player.velocity.y -= 300;

			// test
			// an attempt to fix a bug where you can only jump once
			// while (player.velocity.y > 0)
			// {
			// 	if (player.velocity.y <= 0)
			// 		break;

			if (jumpTimer >= 0 && jumping)
				jumpTimer += FlxG.elapsed;
			else
				jumpTimer -= 1;

			if (jumpTimer <= 0 && player.isTouching(DOWN) && !jumping)
			{
				jumpTimer = 0;
				jumping = false;
			}
			// }

			// trace("jumping sick!");
		}
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
					health -= 1; // for make sure if the health was drain by thorns
				}

				// for thorns was very hurt
				if (thorns.killPlayer)
				{
					gameOver(true, "thorns");
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
					if (gotHardMode)
					{
						score += 50;
					}
					else
					{
						score += 200;
					}
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
					gameOver(true, "vases");
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
					gameOver(true, "liquid");
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
			FlxG.save.flush();
			// FlxG.switchState(new MenuSelectLevel());
			changeState(new MenuSelectLevel());
		}

		trace('complete ' + curLevel + '!');
	}

	/**
	 * Player got game over
	 * @param shouldKill idk if the game want to kill player
	 * @param reason like was ran out of health, was got very hurt thorns, ...
	 */
	inline function gameOver(?shouldKill:Bool, reason:String):Bool
	{
		switch (reason)
		{
			case "health":
				reason = "ran out of health";
			case "thorns":
				reason = "was just hit by very hurt thorns";
			case "vases" | "vase":
				reason = "dude you got the hurt vases";
			case "liquid":
				reason = "touch a poison...";
			default:
				reason = "unknown how you die";
		}

		if ((shouldKill) || health <= 0)
		{
			trace("player got game over due to: " + reason);
			openSubState(new GameoverSubState());
			return true;
		}

		return false;
	}
}
