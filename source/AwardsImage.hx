package;

class AwardsImage extends MainSprite
{
	var curInt:Int = 20;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.awards__png, true, 16, 16);
		for (i in 0...curInt)
		{
			animation.add("awards" + Std.string(i + 1), [i]);
		}

		scale.set(6, 6);
	}
}
