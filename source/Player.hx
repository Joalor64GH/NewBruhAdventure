package;

import util.Vector;

class Player extends MainSprite
{
	/**
		Direction of the player.
		If left: FlxPoint.get(-1, 0);
		etc...
	 */
	public var direction:Vector = new Vector(0, 0);

	public var speed:Vector = new Vector(0, 0);

	public function new(x:Float = 0, y:Float = 0, skin:String)
	{
		super(x, y);

		switch (skin)
		{
			case "normal":
				loadGraphic(Paths.normall__png, true, 16, 16);
				animation.add("left", [0], 1);
				animation.add("right", [1], 1);
				animation.add("in_burn", [2], 1); // when player get burn
				animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
				animation.play("right");

			case "cool_glassed":
				loadGraphic(Paths.cool_glassed__png, true, 16, 16);
				animation.add("left", [0], 1);
				animation.add("right", [1], 1);
				animation.add("in_burn", [2], 1); // when player get burn
				animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
				animation.play("right");

			case "speedrun":
				loadGraphic(Paths.speedrun_player__png, true, 16, 16);
				animation.add("left", [0], 1);
				animation.add("right", [1], 1);
				animation.add("in_burn", [2], 1); // when player get burn
				animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
				animation.play("right");
		}
	}

	// this would use less images...
	public function turnRight(flip:Bool = true)
	{
		flipX = flip;

		if (this.flipX)
		{
			this.flipX = false;
		}

		return flip;
	}

	public function turnLeft(flip:Bool = false)
	{
		flipX = flip;

		if (!this.flipX)
		{
			this.flipX = true;
		}

		return flip;
	}

	/*public function fireUp(enable:Bool = false)
		{
			if (enable)
			{
				animation.play("in_burn");
			}
			else if (enable)
			{
				animation.play("in_normall");
			}

			return enable;
	}*/
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		this.x += direction.dx * speed.dx;
		this.y += direction.dy * speed.dy;
	}
}
