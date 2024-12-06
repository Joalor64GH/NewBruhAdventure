package;

import flixel.FlxG;
import flixel.FlxGame;
import haxe.CallStack;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.UncaughtErrorEvent;
import util.Util;

#if studioALLOW
import flixel.addons.studio.FlxStudio;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

#if desktop
import ALSoftConfig;
#end

using StringTools;

class Main extends Sprite
{
	public static var fpsCounter:FPS;
	public static var framerate:Int = 60;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState, framerate, framerate, true, false));
		fpsCounter = new FPS(0, 0, 0xFFFFFF);
		addChild(fpsCounter);

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);

		util.Util.updateFrames();
		#if studioALLOW
		FlxStudio.create();
		#end
	}

	function onCrash(e:UncaughtErrorEvent)
	{
		var stack:Array<String> = [];
		stack.push(e.error);

		for (stackItem in CallStack.exceptionStack(true))
		{
			switch (stackItem)
			{
				case CFunction:
					stack.push('C Function');
				case Module(m):
					stack.push('Module ($m)');
				case FilePos(s, file, line, column):
					stack.push('$file (line $line)');
				case Method(classname, method):
					stack.push('$classname (method $method)');
				case LocalFunction(name):
					stack.push('Local Function ($name)');
			}

			e.preventDefault();
			e.stopPropagation();
			e.stopImmediatePropagation();

			final msg:String = stack.join('\n');

			#if sys
			try
			{
				if (!FileSystem.exists('logs'))
					FileSystem.createDirectory('logs');

				File.saveContent('logs/'
					+ Lib.application.meta.get('file')
					+ '-'
					+ Date.now().toString().replace(' ', '-').replace(':', "'")
					+ '.log',
					msg
					+ '\n');
			}
			catch (e:Dynamic)
				lime.utils.Log.println("Error!\nClouldn't save the crash dump because:\n"
					+ e
					+ "\n\nPlease report this on https://github.com/khuonghoanghuy/Bruh-Adventure/issues");
			#end
		}
	}

	inline public static function updateFrameRate(newFramerate:Int)
	{
		if (newFramerate > FlxG.drawFramerate)
			FlxG.updateFramerate = FlxG.drawFramerate = newFramerate;
		else
			FlxG.drawFramerate = FlxG.updateFramerate = newFramerate;
	}
}
