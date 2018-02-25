package blocks;

import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import states.PlayState;

/**
 * ...
 * @author Koncord
 */

class Block extends FlxSprite
{

	public function new(X:Int, Y:Int)
	{
		super(X, Y);
		loadGraphic("assets/images/Block.png");
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.overlap(this, Global.player))
			states.PlayState.lvlLoader.restartLevel();
	}
	
}