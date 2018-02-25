package entities;

import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import states.PlayState;
/**
 * ...
 * @author Koncord
 */

class Player extends FlxSprite {
    public function new(X:Int = 0, Y:Int = 0) {
        trace("created");
        super(X, Y);
        loadGraphic("assets/images/Player.png");
    }

    override public function destroy():Void {
        super.destroy();
    }

    /**
	 * Function that is called once every frame.
	 */
    override public function update(elapsed:Float):Void {
        if (FlxG.mouse.pressed && hover())
            Global.pause(false);

        else if (FlxG.mouse.justReleased)
            Global.pause(true);

        trace(FlxG.camera.scroll.x);
        if (!Global.paused) {
            x = FlxG.mouse.screenX + FlxG.camera.scroll.x;
            y = FlxG.mouse.screenY + FlxG.camera.scroll.y;
        }


        if (FlxG.keys.justReleased.LEFT)
            states.PlayState.lvlLoader.prevLevel();

        if (FlxG.keys.justReleased.RIGHT)
            states.PlayState.lvlLoader.nextLevel();

        if (!FlxG.overlap(this, states.PlayState.floors))
            states.PlayState.lvlLoader.restartLevel();

        super.update(elapsed);
    }

    public function hover():Bool {
        var mx:Float = FlxG.mouse.screenX + FlxG.camera.scroll.x;
        var my:Float = FlxG.mouse.screenY + FlxG.camera.scroll.y;
        return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
    }

}