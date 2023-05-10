package;

class Player extends MainSprite
{
	public static var wasHurt:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, true, 16, 16);
		animation.add("idle", [0], 1);
		animation.add("hurt", [1, 2, 3, 4, 5, 6, 7, 8], 12, false);

		if (wasHurt)
			animation.play("hurt");
		else
			animation.play("idle");
	}
}
