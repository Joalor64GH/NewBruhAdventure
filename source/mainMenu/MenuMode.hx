package mainMenu;

class MenuMode extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.selectMode__png, true, 64, 32);

		animation.add("storyMode_idle", [0]);
		animation.add("storyMode_select", [1]);

		animation.add("freeplay_idle", [2]);
		animation.add("freeplay_select", [3]);

		scale.set(3, 3);
	}
}
