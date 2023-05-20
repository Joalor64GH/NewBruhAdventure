package;

import flixel.util.FlxTimer;

class Liquid extends MainSprite
{
	// Getters and setters
	public var killsWhenTouched(get, default):Bool = false;
	
	function get_killsWhenTouched():Bool {
		if (liquidType == 'poison'){
			return true;
		}
		return false;
	}

	// In development
	public var firesUpPlayer(get, default):Bool = false;

	function get_firesUpPlayer():Bool {
		if (liquidType == 'lava'){
			return true;
		}
		return false;
	}

	public var stopsBurningPlayer(get, default):Bool = false;

	function get_stopsBurningPlayer():Bool{
		Player.burning = !stopsBurningPlayer;
		new FlxTimer().start(1, _ -> {
			if (Player.burning)
				stopsBurningPlayer = true;
		});
		stopsBurningPlayer = false;
		return stopsBurningPlayer;
		
	}

	public var slowWalk(get, default):Bool = false;

	function get_slowWalk():Bool{
		if (liquidType == 'water'){
			return true;
		}
		return false;
	}

	public var liquidType(default, set):String = '';

	inline function set_liquidType(v:String):String
	{
		if (liquidType != v)
		{
			liquidType = v;
			reload();
		}
		return v;
	}

	// end of getters/setters

	public function new(x:Float = 0, y:Float = 0, LiquidType:String = '')
	{
		super(x, y);
		this.liquidType = LiquidType;
	}

	function reload()
	{
		switch (liquidType)
		{
			case 'poison':
				loadGraphic(Paths.liquid__png, true, 16, 16);
				animation.add("posion", [2]);
				animation.play("posion");
				// killsWhenTouched = true;
				// slowWalk = false;
				// firesUpPlayer = false;
			case 'water':
				loadGraphic(Paths.liquid__png, true, 16, 16);
				animation.add("water", [1]);
				animation.play("water");
				// killsWhenTouched = false;
				//stopsBurningPlayer = true; // stops the player for burning if its in flames. For that we need a "fire" timer.
				// slowWalk = true;
				// firesUpPlayer = false;
			case 'lava':
				loadGraphic(Paths.liquid__png, true, 16, 16);
				animation.add("lava", [0]);
				animation.play("lava");
				// killsWhenTouched = false;
				// slowWalk = false;
				// firesUpPlayer = true;
		}
	}
}

/**
 * Just a empty class but using this for other stuff
 */
class KindWater extends MainSprite {}

class Water extends MainSprite
{
	public var slowWalk:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.liquid__png, true, 16, 16);
		animation.add("water", [1]);
		animation.play("water");
	}
}

class Lava extends MainSprite
{
	public var killsWhenTouched:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.liquid__png, true, 16, 16);
		animation.add("lava", [0]);
		animation.play("lava");
	}
}
