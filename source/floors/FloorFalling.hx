package floors;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxObject;
/**
 * ...
 * @author Koncord
 */
class FloorFalling extends Floor {
    private var timer:FlxTimer;
    //private var touched:Bool;
    public function new(X:Int = 0, Y:Int = 0) {
        super(X, Y);
        loadGraphic("assets/images/Floor_Falling.png");
        timer = new FlxTimer();
        //timer.active = false;
        //touched = false;
    }

    private function onEnd(timer:FlxTimer) {
        scale.subtract(0.15, 0.15);
        if (scale.x <= 0.0)
            kill();
        else
            timer.start(0.05, onEnd);
    }


    override public function update(elapsed:Float):Void {
        if (Global.paused) {
            if (timer.active && timer.timeLeft != timer.time)
                timer.active = false;
            return;
        }
        if (!timer.active && timer.timeLeft != timer.time)
            timer.active = true;
        if (FlxG.overlap(this, Global.player) && !timer.active)
            timer.start(0.5, onEnd);

        super.update(elapsed);
    }
}