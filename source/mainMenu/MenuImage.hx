package mainMenu;

class MenuImage extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.menu__png, true, 64, 32);
		animation.add("play_idle", [0]);
		animation.add("play_select", [1]);

		animation.add("options_idle", [2]);
		animation.add("options_select", [3]);

		animation.add("quit_idle", [4]);
		animation.add("quit_select", [5]);

		animation.add("credits_idle", [6]);
		animation.add("credits_select", [7]);

		animation.add("awards_idle", [8]);
		animation.add("awards_select", [9]);

		scale.set(3, 3);
	}
}
