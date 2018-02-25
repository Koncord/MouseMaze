package;
import flixel.FlxBasic;
import flixel.FlxSprite;
import states.PlayState;
import flixel.FlxG;

/**
 * ...
 * @author Koncord
 */
class LevelManager extends FlxBasic {

    private var map:LevelLoader;
    private var state:PlayState;

    public function new(state:PlayState) {
        this.state = state;
        super();
    }

    public function nextLevel() {
        if (!isExistsNextLevel()) return;
        loadLevel(++Global.currentLevel);
    }

    public function prevLevel() {
        if (!isExistsPrevLevel()) return;
        loadLevel(--Global.currentLevel);
    }

    public function isExistsNextLevel():Bool {
        return Global.currentLevel < Global.LEVELS - 1;
    }

    public function isExistsPrevLevel():Bool {
        return Global.currentLevel > 0;
    }

    public function restartLevel() {
        loadLevel(Global.currentLevel);
    }

    public function loadLevel(level:Int) {
        var blackscreen = new FlxSprite(0, 0);
        PlayState.state.add(blackscreen);
        blackscreen.makeGraphic(FlxG.camera.width, FlxG.camera.height);
        FlxG.camera.scroll.x = 0; // FIXME: need loading position from level;
        FlxG.camera.scroll.y = 0; // FIXME: need loading position from level;
        Global.paused = true;
        FlxG.mouse.visible = true;
        PlayState.enemies.clear();
        PlayState.floors.clear();
        map = new LevelLoader("assets/levels/lvl" + level + ".tmx", state);
        trace("Loading: \"assets/levels/lvl" + level + ".tmx\"");
        Global.currentLevel = level;
        blackscreen.kill();
    }
}