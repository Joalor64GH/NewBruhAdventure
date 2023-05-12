package;

class Player extends MainSprite
{
	static inline var SPEED:Float = 100;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.player__png, true, 16, 16);
		animation.add("down", [0], 1);
		animation.add("left", [1], 1);
		animation.add("right", [2], 1);
		animation.add("up", [3], 1);
		animation.play("right");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
