package;

class MenuSelect extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.level_select__png, true, 64, 32);
		animation.add("lev1", [0]);
		animation.add("lev2", [1]);

		scale.set(3, 3);
	}
}
