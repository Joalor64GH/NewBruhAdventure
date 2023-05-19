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
import flixel.util.FlxColor;
import util.Util;

class PlayState extends MainState
{
	var player:Player;
	var coins:FlxTypedGroup<Coin>;
	var flag:Flag;
	var liquids:FlxTypedGroup<Liquid>;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	static var jsonPaths:String = '';
	static var curLevel:String = '';

	var score:Int = 0;
	var scoreTxt:FlxText;

	public static function levRun(typeLev:Int = 0)
	{
		switch (typeLev)
		{
			case 0:
				curLevel = 'lev1';
				jsonPaths = Paths.lev1__json;
				trace('load: ' + jsonPaths);

			case 1:
				curLevel = 'lev2';
				jsonPaths = Paths.lev2__json;
				trace('load: ' + jsonPaths);

			case 2:
				curLevel = 'lev3';
				jsonPaths = Paths.lev3__json;
				trace('load: ' + jsonPaths);

			case 3:
				curLevel = 'lev4';
				jsonPaths = Paths.lev4__json;
				trace('load: ' + jsonPaths);

			case 4:
				curLevel = 'lev5';
				jsonPaths = Paths.lev5__json;
				trace('load: ' + jsonPaths);

			case 5:
				curLevel = 'lev6';
				jsonPaths = Paths.lev6__json;
				trace('load: ' + jsonPaths);

			case 6:
				curLevel = 'lev7';
				jsonPaths = Paths.lev7__json;
				trace('load: ' + jsonPaths);

			case 7:
				curLevel = 'lev8';
				jsonPaths = Paths.lev8__json;
				trace('load: ' + jsonPaths);

			case 8:
				curLevel = 'lev9';
				jsonPaths = Paths.lev9__json;
				trace('load: ' + jsonPaths);

			case 9:
				curLevel = 'lev10';
				jsonPaths = Paths.lev10__json;
				trace('load: ' + jsonPaths);

			case 10:
				curLevel = 'lev11';
				jsonPaths = Paths.lev11__json;
				trace('load: ' + jsonPaths);

			case 11:
				curLevel = 'lev12';
				jsonPaths = Paths.lev12__json;
				trace('load: ' + jsonPaths);

			case 12:
				curLevel = 'lev13';
				jsonPaths = Paths.lev13__json;
				trace('load: ' + jsonPaths);

			case 13:
				curLevel = 'lev14';
				jsonPaths = Paths.lev14__json;
				trace('load: ' + jsonPaths);

			case 14:
				curLevel = 'lev15';
				jsonPaths = Paths.lev15__json;
				trace('load: ' + jsonPaths);

			case 15:
				curLevel = 'lev16';
				jsonPaths = Paths.lev16__json;
				trace('load: ' + jsonPaths);

			case 16:
				curLevel = 'lev17';
				jsonPaths = Paths.lev17__json;
				trace('load: ' + jsonPaths);

			case 17:
				curLevel = 'lev18';
				jsonPaths = Paths.lev18__json;
				trace('load: ' + jsonPaths);

			case 18:
				curLevel = 'lev19';
				jsonPaths = Paths.lev19__json;
				trace('load: ' + jsonPaths);

			case 19:
				curLevel = 'lev20';
				jsonPaths = Paths.lev20__json;
				trace('load: ' + jsonPaths);

			case 20:
				curLevel = 'lev21';
				jsonPaths = Paths.lev21__json;
				trace('load: ' + jsonPaths);

			case 21:
				curLevel = 'lev22';
				jsonPaths = Paths.lev22__json;
				trace('load: ' + jsonPaths);

			case 22:
				curLevel = 'lev23';
				jsonPaths = Paths.lev23__json;
				trace('load: ' + jsonPaths);

			case 23:
				curLevel = 'lev24';
				jsonPaths = Paths.lev24__json;
				trace('load: ' + jsonPaths);

			case 24:
				curLevel = 'lev25';
				jsonPaths = Paths.lev25__json;
				trace('load: ' + jsonPaths);

			case 25:
				curLevel = 'lev26';
				jsonPaths = Paths.lev26__json;
				trace('load: ' + jsonPaths);

			case 26:
				curLevel = 'lev27';
				jsonPaths = Paths.lev27__json;
				trace('load: ' + jsonPaths);

			case 27:
				curLevel = 'lev28';
				jsonPaths = Paths.lev28__json;
				trace('load: ' + jsonPaths);

			case 40:
				curLevel = 'lev1ex';
				jsonPaths = Paths.lev1ex__json;
				trace('load: ' + jsonPaths);
		}
	}

	var restart:Bool = false;

	var stepSound:FlxSound;
	var coinSound:FlxSound;

	var slowNow:Bool = false;

	override public function create()
	{
		super.create();

		restart = false;

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

		flag = new Flag();
		add(flag);

		liquids = new FlxTypedGroup<Liquid>();
		add(liquids);

		player = new Player();
		add(player);

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

			case 'coin', 'coin_2', 'coin_super', 'coin_fake', 'coin_rewarded':
				coins.add(new Coin(x, y, entity.name));

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
		{
			player.turnLeft(true);
		}

		if (right)
		{
			player.turnRight(false);
		}

		if (left && right)
			left = right = false;

		if (left)
		{
			stepSound.play(true);
			if (slowNow)
				player.velocity.x = -50 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
			else
				player.velocity.x = -100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
			// player.runLeft();
		}
		else if (right)
		{
			stepSound.play(true);
			if (slowNow)
				player.velocity.x = 50 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
			else
				player.velocity.x = 100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
			// player.runRight();
		}
		else
		{
			player.velocity.x = 0;
			// player.stopRunning();
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
			// for poison
			if (liquid.killsWhenTouched && player.overlaps(liquid))
			{
				// player.kill();
				gameOver();
			}

			// for lava
			if (liquid.firesUpPlayer && player.overlaps(liquid))
			{
				player.fireUp(true); // an animation like its burning
			}
			else if (liquid.firesUpPlayer && !player.overlaps(liquid))
			{
				player.fireUp(false);
			}
			else
			{
				player.fireUp(false);
			}

			// for water
			if (liquid.slowWalk && player.overlaps(liquid))
			{
				slowNow = true;
			}
			else if (liquid.slowWalk && !player.overlaps(liquid))
			{
				slowNow = false;
			}
			else
			{
				slowNow = false;
			}
		}
	}

	function touchFlag(player:Player, flag:Flag)
	{
		if (player.alive && player.exists && flag.alive && flag.exists)
		{
			flag.kill();
			sys.io.File.saveContent("assets/data/lev/" + curLevel + "/" + curLevel + ".txt", Std.string(score));
			trace('complete ' + curLevel + '!');
			FlxG.switchState(new MenuSelectLevel());
		}
	}

	function gameOver()
	{
		openSubState(new GameoverSubState());
	}
}
