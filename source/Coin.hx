package;

class Coin extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.coin__png, true, 16, 16);
	}
}

class Coin_2 extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.coin_2__png, true, 16, 16);
	}
}
