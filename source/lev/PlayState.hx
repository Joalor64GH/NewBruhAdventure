package lev;

class PlayState extends MainState
{
	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.camera.follow(player, PLATFORMER);
		// FlxG.collide(player, walls);
		FlxG.overlap(player, coin, touchCoin);

		var pause:Bool = FlxG.keys.justPressed.ESCAPE;

		if (pause)
		{
			openSubState(new PauseSubState());
		}

		var up:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		#if FLX_KEYBOARD
		up = FlxG.keys.anyJustPressed([UP, W, SPACE]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		#end

		if (jumping && !up)
			jumping = false;

		if (player.isTouching(DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && up)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		if (jumpTimer > 0 && jumpTimer < 0.25)
			player.velocity.y = -300;

		if (left && right)
			left = right = false;

		if (left || right)
		{
			var newAngle:Float = 0;
			if (left)
			{
				newAngle = 180;
				player.facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				player.facing = RIGHT;
			}

			// determine our velocity based on angle and speed
			player.velocity.setPolarDegrees(SPEED, newAngle);
		}
		// check if the player is moving, and not walking into walls

		switch (player.facing)
		{
			case LEFT:
				player.animation.play("left");
			case RIGHT:
				player.animation.play("right");
			case _:
		}
	}

	function touchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
