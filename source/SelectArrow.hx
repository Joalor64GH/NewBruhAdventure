package;

class SelectArrow extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.select_arrow__png, true, 32, 32);
		animation.add("idle", [0]);
		animation.add("choose", [1, 2, 3, 0], 12);
		animation.play("idle");
	}
}
