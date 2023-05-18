package lev;

import Coin.Coin_2;
import Coin.Coin_Super;
import Coin;
import KindWater.Lava;
import KindWater.Liquid;
import KindWater.Water;
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
	var coin:FlxTypedGroup<Coin>;
	var coin_2:FlxTypedGroup<Coin_2>;
	var coin_super:FlxTypedGroup<Coin_Super>;
	var flag:Flag;

	var water:FlxTypedGroup<Water>;
	var lava:FlxTypedGroup<Lava>;
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
		}
	}

	var restart:Bool = false;

	var stepSound:FlxSound;
	var coinSound:FlxSound;

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

		player = new Player();
		add(player);

		coin = new FlxTypedGroup<Coin>();
		add(coin);

		coin_2 = new FlxTypedGroup<Coin_2>();
		add(coin_2);

		coin_super = new FlxTypedGroup<Coin_Super>();
		add(coin_super);

		flag = new Flag();
		add(flag);

		water = new FlxTypedGroup<Water>();
		water.forEach(function(water2:Water)
		{
			water2.slowWalk = false;
		});
		add(water);

		liquids = new FlxTypedGroup<Liquid>();
		add(liquids);

		lava = new FlxTypedGroup<Lava>();
		lava.forEach(function(lava2:Lava)
		{
			lava2.killsWhenTouched = false;
		});
		add(lava);

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

			case 'coin':
				coin.add(new Coin(x, y));

			case 'coin_2':
				coin_2.add(new Coin_2(x, y));

			case 'coin_super':
				coin_super.add(new Coin_Super(x, y));

			case 'water', 'lava', 'poison':
				liquids.add(new Liquid(x, y, entity.name));
				
			/*case 'water':
				water.add(new Water(x, y));

			case 'lava':
				lava.add(new Lava(x, y));

			case 'posion':
				liquid.add(new Liquid(x, y, 'poison'));*/

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

		FlxG.overlap(player, coin, touchCoin);
		FlxG.overlap(player, coin_2, touchCoin2);
		FlxG.overlap(player, coin_super, touchCoinSuper);
		FlxG.overlap(player, flag, touchFlag);
		FlxG.overlap(player, water, touchWater);
		FlxG.overlap(player, lava, touchLava);
		FlxG.overlap(player, liquids, touchPosion);
		//FlxG.overlap(player, liquids, touchedLiquid); // interesting... i have to give it a look...

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
			player.velocity.x = -100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
		}
		else if (right)
		{
			stepSound.play(true);
			player.velocity.x = 100 * Std.parseFloat(Util.fileString(Paths.runSpeed__txt));
		}
		else
			player.velocity.x = 0;
	}

	function touchedCoin(player:Player, coin:Coin) {
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			//if (!coin.isFake)
			//{
				coinSound.play(true);
				/*coin.onPlayerTouch(player);*/coin.kill();
				//score += coin.score;
				trace('player got ' + coin.score + ' score');
			//}
		}
	}
	function touchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coinSound.play(true);
			coin.kill();
			score += 10;
			trace('player got 10 score');
		}
	}

	function touchCoin2(player:Player, coin_2:Coin_2)
	{
		if (player.alive && player.exists && coin_2.alive && coin_2.exists)
		{
			coinSound.play(true);
			coin_2.kill();
			score += 50;
			trace('player got 50 score');
		}
	}

	function touchCoinSuper(player:Player, coin_super:Coin_Super)
	{
		if (player.alive && player.exists && coin_super.alive && coin_super.exists)
		{
			coinSound.play(true);
			coin_super.kill();
			score += 100;
			trace('player got 100 score');
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
	}

	function touchedLiquid(player:Player, liquid:Liquid)
	{
		if(liquid.exists && player.alive && player.exists)
		{
			if(liquid.killsWhenTouched)
			{
				//player.kill();
			}
			if(liquid.firesUpPlayer)
			{
				//player.fireUp(); // an animation like its burning
			}
		}
	}
	function touchWater(player:Player, water:Water)
	{
		if (player.alive && player.exists && water.alive && water.exists)
		{
			water.slowWalk = true;
		}
		else
		{
			water.slowWalk = false;
		}
	}

	function touchLava(player:Player, lava:Lava)
	{
		if (player.alive && player.exists && lava.alive && lava.exists)
		{
			openSubState(new GameoverSubState());
		}
	}

	function touchPosion(player:Player, liquid:Liquid)
	{
		if (player.alive && player.exists && liquid.alive && liquid.exists)
		{
			openSubState(new GameoverSubState());
		}
	}

	function gameOver()
	{
		openSubState(new GameoverSubState());
	}
}
