package;

class AwardsImage extends MainSprite
{
	var curName:Int = 5;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.awards__png, true, 16, 16);
		for (i in 0...curName)
		{
			animation.add("awards" + Std.string(i + 1), [i]);
		}

		scale.set(3, 3);
	}
}
