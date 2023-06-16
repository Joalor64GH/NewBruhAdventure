package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import util.Util;
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

	// for skin
	public var fasterInWater:Bool = false;
	public var canHandlerlava:Bool = false;
	public var runFaster:Bool = false;
	public var gainAlotScore:Bool = false;

	public static var burning:Bool = false; // when the player is on fire, gonna use this for skeleton code atm

	var stepSound:FlxSound;

	/**
	 * Player code (i think i will try code skin)
	 * @param x x postion
	 * @param y y postion
	 * @param skin player skin (not working)
	 */
	public function new(x:Float = 0, y:Float = 0 /*, skin:String = 'normal'*/)
	{
		super(x, y);

		stepSound = FlxG.sound.load(Paths.grass_step__wav, 1);

		loadGraphic(Paths.normall__png, true, 16, 16);
		animation.add("left", [0], 1);
		animation.add("right", [1], 1);
		animation.add("in_burn", [2], 1); // when player get burn
		animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
		animation.play("right");
		fasterInWater = false;
		canHandlerlava = false;
		runFaster = false;
		gainAlotScore = false;

		/*switch (skin)
			{
				case "normal":
					loadGraphic(Paths.normall__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = false;
					canHandlerlava = false;
					runFaster = false;
					gainAlotScore = false;

				case "cool_glassed":
					loadGraphic(Paths.cool_glassed__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = false;
					canHandlerlava = false;
					runFaster = false;
					gainAlotScore = true;

				case "speedrun":
					loadGraphic(Paths.speedrun_player__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = false;
					canHandlerlava = false;
					runFaster = true;
					gainAlotScore = false;

				case "blueOne":
					loadGraphic(Paths.blue_player__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = true;
					canHandlerlava = false;
					runFaster = false;
					gainAlotScore = false;

				case "yellowOne":
					loadGraphic(Paths.yellow_player__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = false;
					canHandlerlava = true;
					runFaster = false;
					gainAlotScore = false;

				default:
					loadGraphic(Paths.normall__png, true, 16, 16);
					animation.add("left", [0], 1);
					animation.add("right", [1], 1);
					animation.add("in_burn", [2], 1); // when player get burn
					animation.add("in_normall", [3, 4, 5, 6, 7, 8, 9], 12); // when player after get out of lava
					animation.play("right");
					fasterInWater = false;
					canHandlerlava = false;
					runFaster = false;
					gainAlotScore = false;
		}*/
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
	final speed_file:Float = Std.parseFloat(Util.fileString(Paths.runSpeed__txt));

	var inLeft:Bool = false;
	var inRight:Bool = false;

	var jumpTimer:Float = 0;
	var jumping:Bool = false;

	override public function update(elapsed:Float)
	{
		this.x += direction.dx * speed.dx;
		this.y += direction.dy * speed.dy;

		if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			turnRight(true);
			stepSound.play(true);
			inRight = true;
			if (lev.PlayState.instance.slowNow)
				velocity.x = 50 * speed_file;
			else
				velocity.x = 100 * speed_file;
		}
		else
			inRight = false;

		jump(elapsed);

		if (isTouching(FLOOR) && !FlxG.keys.anyPressed(_jumpKeys))
		{
			_jumpTime = -1;
			// Reset the double jump flag
			_timesJumped = 0;
		}

		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			turnLeft(true);
			stepSound.play(true);
			inLeft = true;
			if (lev.PlayState.instance.slowNow)
				velocity.x = -50 * speed_file;
			else
				velocity.x = -100 * speed_file;
		}
		else
			inLeft = false;

		if (!inLeft && !inRight)
			velocity.x = 0;

		super.update(elapsed);
	}

	// all code from this project: https://haxeflixel.com/demos/ProjectJumper/#:~:text=Controls%3A,Jump%20%2D%20L%20%2F%20C
	public static inline var JUMP_SPEED:Int = 250;
	public static inline var JUMPS_ALLOWED:Int = 2;

	var _jumpTime:Float = -1;
	var _timesJumped:Int = 0;
	var _jumpKeys:Array<FlxKey> = [W, UP, SPACE];

	function jump(elapsed:Float):Void
	{
		if (FlxG.keys.anyJustPressed(_jumpKeys))
		{
			if ((velocity.y == 0) || (_timesJumped < JUMPS_ALLOWED)) // Only allow two jumps
			{
				_timesJumped++;
				_jumpTime = 0;
			}
		}

		// You can also use space or any other key you want
		if ((FlxG.keys.anyPressed(_jumpKeys)) && (_jumpTime >= 0))
		{
			_jumpTime += elapsed;

			// You can't jump for more than 0.25 seconds
			if (_jumpTime > 0.25)
			{
				_jumpTime = -1;
			}
			else if (_jumpTime > 0)
			{
				velocity.y = -0.6 * maxVelocity.y;
			}
		}
		else
			_jumpTime = -1.0;
	}
}
