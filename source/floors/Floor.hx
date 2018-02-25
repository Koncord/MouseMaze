package floors;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

/**
 * ...
 * @author Koncord
 */
class Floor extends FlxSprite {

    public function new(X:Int = 0, Y:Int = 0) {
        super(X, Y);
        loadGraphic("assets/images/Floor.png");
    }

    override public function destroy():Void {

    }

    override public function update(elapsed:Float):Void {

    }
}