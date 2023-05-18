package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends MainSprite
{
	public var typeCoin(default, set):String = '';
	public var isFakeCoin:Bool = false;

	/**
		How much score does the coin gives when touched.
	 */
	public var score:Int = 10;

	// Maybe... like... you have to do something to take this coin.
	public var canBeScored:Bool = true;

	inline function set_typeCoin(v:String):String
	{
		if (typeCoin != v)
		{
			this.typeCoin = v;
			reloadCoin();
		}
		return v;
	}

	public function new(x:Float = 0, y:Float = 0, TypeCoin:String = '')
	{
		super(x, y);

		if (TypeCoin == '')
			loadGraphic(Paths.coin__png, true, 16, 16);
		this.typeCoin = TypeCoin;
	}

	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.22, {ease: FlxEase.circOut, onComplete: finishKill});
	}

	function finishKill(_)
	{
		exists = false;
	}

	function reloadCoin()
	{
		switch (typeCoin)
		{
			case 'coin':
				loadGraphic(Paths.coin__png, true, 16, 16);
				updateHitbox();
				isFakeCoin = false;
				canBeScored = true;
				score = 10;

			case 'coin_2':
				loadGraphic(Paths.coin_2__png, true, 16, 16);
				updateHitbox();
				isFakeCoin = false;
				canBeScored = true;
				score = 50;

			case 'coin_super':
				loadGraphic(Paths.coin_super__png, true, 16, 16);
				animation.add('idle', [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0], 12, true);
				animation.play('idle');
				updateHitbox();
				isFakeCoin = false;
				canBeScored = true;
				score = 100;

			case 'coin_fake': // a black coin that you will get -10 score
				loadGraphic(Paths.coin_black__png, true, 16, 16);
				updateHitbox();
				isFakeCoin = false;
				canBeScored = true;
				score = -20;

			case 'coin_rewarded': // a red one that have a animtion png
				loadGraphic(Paths.coin_red__png, true, 16, 16);
				animation.add('idle', [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0], 12, true);
				animation.play('idle');
				updateHitbox();
				isFakeCoin = false;
				canBeScored = true;
				score = 150;
		}
	}

	function playerTouched(player:Player)
	{
		this.kill();
	}
}
