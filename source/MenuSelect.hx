package;

class MenuSelect extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.level_select__png, true, 64, 32);
		animation.add("lev1", [0]);
		animation.add("lev2", [1]);
		animation.add("lev3", [2]);
		animation.add("lev4", [3]);
		animation.add("lev5", [4]);
		animation.add("lev6", [5]);
		animation.add("lev7", [6]);
		animation.add("lev8", [7]);
		animation.add("lev9", [8]);
		animation.add("lev10", [9]);
		animation.add("lev11", [10]);
		animation.add("lev12", [11]);
		animation.add("lev13", [12]);
		animation.add("lev14", [13]);
		animation.add("lev15", [14]);
		animation.add("lev16", [15]);
		animation.add("lev17", [16]);
		animation.add("lev18", [17]);
		animation.add("lev19", [18]);
		animation.add("lev20", [19]);

		scale.set(3, 3);
	}
}
