package blocks;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;
/**
 * ...
 * @author Koncord
 */

class BlockMove extends Block
{
	public function new(X:Int, Y:Int) 
	{
		super(X, Y);
		loadGraphic("assets/images/Block_Move.png");

	}
	override public function update(elapsed:Float):Void
	{
		if (Global.paused) return;
		if(FlxG.overlap(this, states.PlayState.enemies))
		{
			acceleration.x = -acceleration.x;
			acceleration.y = -acceleration.y;
			y += acceleration.y;
			x += acceleration.x;
		}
		y += acceleration.y;
		x += acceleration.x;
		super.update(elapsed);
	}
	
}