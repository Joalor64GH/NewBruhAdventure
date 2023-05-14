package;

import flixel.math.FlxPoint;

class Player extends MainSprite
{
	/**
		Direction of the player.
		If left: FlxPoint.get(-1, 0);
		etc...
	*/
	public var direction:FlxPoint = new FlxPoint(0, 0);

	public var speed:FlxPoint = new FlxPoint(0, 0);

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.player__png, true, 16, 16);
		animation.add("left", [1], 1);
		animation.add("right", [2], 1);
		animation.play("right");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
	}
}
