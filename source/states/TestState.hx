package states;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxState;

/**
 * ...
 * @author Koncord
 */
class TestState extends FlxState
{
	private var level:LevelLoader;
	public function new() 
	{
		super();
	}
	override public function create():Void 
	{
		super.create();
		/*level = new LevelLoader2(this);
		level.Load("assets/data/lvl1.tmx");*/
	
	}
	
}