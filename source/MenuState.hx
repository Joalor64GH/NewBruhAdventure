package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class MenuState extends MainState
{
	var list:Array<String> = ['play', 'setting', 'exit'];

	var menu_group:FlxTypedGroup<FlxSprite>;
	var select:Int = 0;

	override public function create()
	{
		super.create();

		menu_group = new FlxTypedGroup<FlxSprite>();
		add(menu_group);

		for (i in 0...list.length)
		{
			var selectThing:MenuImage = new MenuImage();
			selectThing.ID = i;
			selectThing.screenCenter();
			menu_group.add(selectThing);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
