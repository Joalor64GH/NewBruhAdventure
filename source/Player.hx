package;

class Player extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, true, 16, 16);
		animation.add("down", [0], 1);
		animation.add("left", [1], 1);
		animation.add("right", [2], 1);
		animation.add("up", [3], 1);
		animation.play("down");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (up)
			animation.play("up");
		else if (down)
			animation.play("down");
		else if (left)
			animation.play("left");
		else if (right)
			animation.play("right");
	}
}
