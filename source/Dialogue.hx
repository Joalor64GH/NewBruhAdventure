package;

class Dialogue extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.dialogue__png, true, 64, 48);
		animation.add("idle", [0]);
		animation.play("idle");

		scale.set(3, 3);
	}
}
