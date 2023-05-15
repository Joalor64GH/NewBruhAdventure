package;

class MenuSelect extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.level_select__png, true, 64, 32);
		for (i in 0...20)
			animation.add("lev" + Std.string(i + 1), [i]);

		scale.set(3, 3);
	}
}
