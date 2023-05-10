package;

class KindWater extends MainSprite {}

class Water extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.water_lava__png, true, 16, 16);
		animation.add("water", [2]);
		animation.play("water");
	}
}

class Lava extends MainSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.water_lava__png, true, 16, 16);
		animation.add("lava", [3]);
		animation.play("lava");
	}
}
