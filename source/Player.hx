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

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(Paths.player__png, true, 16, 16);
		animation.add("left", [1], 1);
		animation.add("right", [2], 1);
		animation.play("right");
	}

	// this would use less images...
	/*public function turnRight() {
		if(this.flipX) {
			this.flipX = false;
		}
	}
	public function turnLeft() {
		if(!this.flipX) {
			this.flipX = true;
		}
	}*/

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		this.x += direction.dx * speed.dx;
		this.y += direction.dy * speed.dy;
	}
}
