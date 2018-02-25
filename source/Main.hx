/*import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;*/
import openfl.display.Sprite;
import flixel.FlxGame;
import flixel.FlxState;
import states.PlayState;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 768; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = states.PlayState; // The FlxState the game starts with.
	var zoom:Float = -1.0; // If -1, zoom is automatically calculated to fit the window dimensions.

	var framerate:Int = 60; // How many frames per second the game should run at.

	#if !debug
	var skipSplash:Bool = false;
	#else
	var skipSplash:Bool = true;
	#end

	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.

	/*public static function main():Void
	{
		Lib.current.addChild(new Main());
	}*/

	public function new()
	{
		super();

		/*if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);*/

        setupGame();
	}

	/*private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}*/

	private function setupGame():Void
	{
		var stageWidth:Int = stage.stageWidth;
		var stageHeight:Int =stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

        skipSplash = true;
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}