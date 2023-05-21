package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Thorns extends MainSprite
{
	public var typeThorns(default, set):String = '';
	public var hurtPlayer:Bool = false;
	public var killPlayer:Bool = false;

	/**
		How much score does the coin gives when touched.
	 */
	public var score:Int = 200;

	inline function set_typeThorns(v:String):String
	{
		if (typeThorns != v)
		{
			this.typeThorns = v;
			reloadThorns();
		}
		return v;
	}

	public function new(x:Float = 0, y:Float = 0, TypeThorns:String = '')
	{
		super(x, y);
		this.typeThorns = TypeThorns;
	}

	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.22, {ease: FlxEase.circOut, onComplete: _ -> exists = false});
	}

	function reloadThorns()
	{
		switch (typeThorns)
		{
			case 'thorns_nor':
				loadGraphic(Paths.thorns__png, true, 19, 16);
				animation.add("thorns_nor", [0]);
				hurtPlayer = true;
				killPlayer = false;

			case 'thorns_veryHurt':
				loadGraphic(Paths.thorns__png, true, 19, 16);
				animation.add("thorns_veryHurt", [1]);
				hurtPlayer = false;
				killPlayer = true;
		}
	}

	function playerTouched(player:Player) {}
}
