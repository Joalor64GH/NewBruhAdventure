package items;

import flixel.util.FlxColor;

class Potion extends MainSprite {
	//No, not set.
	public var potionType:String = '';
	
	public function new(x:Float, y:Float, color:FlxColor)
	{
		super(x, y);
		//loadGraphic(potion); // BLANK POTION. WITHOUT ANY COLORS EXCEPT BLACK (border) AND WHITE (in color)
		this.color = color; // no need to make more sprites for more potion colors.
	}
}
