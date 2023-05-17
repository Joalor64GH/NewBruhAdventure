package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends MainSprite
{
	public var typeCoin(default, set):String = '';
	
	inline function set_typeCoin(v:String):String {
		if(typeCoin != v) {
			this.typeCoing = v;
			reloadCoin();
		}
		return v;
	}

	public function new(x:Float = 0, y:Float = 0, TypeCoin:String = '')
	{
		super(x, y);

		if(TypeCoin == '')
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

	function reloadCoin() {
		switch(typeCoin) {
			case '2':
				loadGraphic(Paths.coin_2__png, true, 16, 16);
				updateHitbox();
			case 'super':
				loadGraphic(Paths.coin_super__png, true, 16, 16);
				animation.add('idle', [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0], 12, true);
				animation.play('idle');
				updateHitbox();
		}
	}
}
//This must be deprecated.
class Coin_2 extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.coin_2__png, true, 16, 16);
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
}
//This is deprecated
class Coin_Super extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.coin_super__png, true, 16, 16);
		animation.add('idle', [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0], 12, true);
		animation.play('idle');
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
}
