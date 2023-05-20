package;

class DownAble extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.canDownAble__png, true, 16, 16);
		animation.add("cod", [0]);
		animation.play("cod");
	}
}
