package states;


import flixel.math.FlxMath;
import entities.Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.FlxCamera;
import flixel.util.FlxColor;

class PlayState extends FlxState {
    static public var enemies:FlxGroup;
    static public var floors:FlxGroup;
    static public var lvlLoader:LevelManager;
    static public var state:PlayState;

    public function new() {
        super();
        state = this;
    }

    override public function create():Void {
        super.create();
        FlxG.camera.width = 1280;
        FlxG.camera.height = 768;

        enemies = new FlxGroup();
        floors = new FlxGroup();
        Global.player = new entities.Player();
        add(floors);
        add(enemies);
        add(Global.player);
        lvlLoader = new LevelManager(this);
        lvlLoader.loadLevel(0);
    }


    override public function destroy():Void {
        super.destroy();
    }

    override public function update(elapsed:Float):Void {
        if (Global.player.x - FlxG.camera.scroll.x > FlxG.camera.width - 16) {
            Global.pause(true);
            FlxG.camera.scroll.x += FlxG.camera.width - 64;
        }
        else if (Global.player.x - FlxG.camera.scroll.x < 16) {
            Global.pause(true);
            FlxG.camera.scroll.x -= FlxG.camera.width - 64;
        }
        else if (Global.player.y - camera.scroll.y > camera.height - 16) {
            Global.pause(true);
            FlxG.camera.scroll.y += FlxG.camera.height - 64;
        }
        else if (Global.player.y - FlxG.camera.scroll.y < 16) {
            Global.pause(true);
            FlxG.camera.scroll.y -= FlxG.camera.height - 64;
        }

        super.update(elapsed);
    }

}