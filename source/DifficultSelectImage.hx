package;

class DifficultSelectImage extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.mode_select__png, true, 64, 32);
		animation.add("easy", [0]);
		animation.add("hard", [2]);
		animation.add("old", [4]);

		scale.set(3, 3);
	}
}
