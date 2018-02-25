package floors;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;
/**
 * ...
 * @author Koncord
 */
class FloorHot extends Floor {

    public var heating:Float;
    private var heat_dir:Float;

    public function new(X:Int = 0, Y:Int = 0) {
        super(X, Y);
        loadGraphic("assets/images/Floor_Hot.png");

        heating = 0;
        heat_dir = 0.005;
        //tween = FlxTween.color(this, 5, FlxColor.YELLOW, FlxColor.RED, 1, 1);


    }

    override public function destroy():Void {

    }

    override public function update(elapsed:Float):Void {
        if (Global.paused) return;

        heating += heat_dir;
        if (heating >= 1.0 || heating <= 0.0)
            heat_dir = -heat_dir;

        color = FlxColor.fromHSB(0, heating, 1, 1);

        if (heating > 0.7)
            FlxG.overlap(this, Global.player, boilingPoint);
    }

    private function boilingPoint(Object1:FlxObject, Object2:FlxObject):Void {
        states.PlayState.lvlLoader.restartLevel();
    }
}