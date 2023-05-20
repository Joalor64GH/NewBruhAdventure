package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Vases extends MainSprite
{
	public var typeVases(default, set):String = '';
	public var random:Bool = false;
	public var thatCoin:Bool = false;
	public var hurtPlayer:Bool = false;
	public var killPlayer:Bool = false;

	/**
		How much score does the coin gives when touched.
	 */
	public var score:Int = 200;

	inline function set_typeVases(v:String):String
	{
		if (typeVases != v)
		{
			this.typeVases = v;
			reloadVases();
		}
		return v;
	}

	public function new(x:Float = 0, y:Float = 0, TypeVases:String = '')
	{
		super(x, y);
		this.typeVases = TypeVases;
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

	function reloadVases()
	{
		switch (typeVases)
		{
			case 'vases_random':
				loadGraphic(Paths.vases__png, true, 16, 16);
				animation.add("random", [0]);
				random = true;
				thatCoin = false;
				hurtPlayer = false;
				killPlayer = false;

			case 'vases_coin':
				loadGraphic(Paths.vases__png, true, 16, 16);
				animation.add("coin", [1]);
				random = false;
				thatCoin = true;
				hurtPlayer = false;
				killPlayer = false;

			case 'vases_hurt':
				loadGraphic(Paths.vases__png, true, 16, 16);
				animation.add("hurt", [2]);
				random = false;
				thatCoin = false;
				hurtPlayer = true;
				killPlayer = false;

			case 'vases_kill':
				loadGraphic(Paths.vases__png, true, 16, 16);
				animation.add("kill", [3]);
				random = false;
				thatCoin = false;
				hurtPlayer = false;
				killPlayer = true;
		}
	}

	function playerTouched(player:Player)
	{
		this.kill();
	}
}
