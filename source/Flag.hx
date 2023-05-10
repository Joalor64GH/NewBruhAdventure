package;

class Flag extends MainSprite
{
	public static var wasTouch:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.flag__png, true, 16, 16);
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8], 12, true);
		animation.add("touch", [9, 10, 11, 12], 12, true);

		if (wasTouch)
		{
			animation.play("touch");
		}
		else
		{
			animation.play("idle");
		}
	}
}
