package;
import entities.Player;
import flixel.util.FlxSave;
import flixel.FlxG;
/**
 * Handy, pre-built Registry class that can be used to store
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */

class Global {
    public static var paused:Bool;
    public static var player:entities.Player;
    public static var currentLevel = 0;
    public static var LEVELS:Int = 7;

    public static function pause(state:Bool):Void {
        paused = state;
        FlxG.mouse.visible = state;
    }
}
