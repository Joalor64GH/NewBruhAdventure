package lev;

import Coin.Coin_2;
import Coin;
import Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends MainState
{
	var player:Player;
	var coin:FlxTypedGroup<Coin>;
	var coin_2:FlxTypedGroup<Coin_2>;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
