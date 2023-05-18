package;

class Liquid extends MainSprite
{
	public var killsWhenTouched:Bool = false;
	public var liquidType /*(default, set)*/:String = '';

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.liquid__png, true, 16, 16);
		animation.add("posion", [2]);
		animation.play("posion");
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
		animation.add("water", [0]);
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
		animation.add("lava", [1]);
		animation.play("lava");
	}
}
