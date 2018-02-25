package;

/**
 * ...
 * @author Koncord
 */
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxG;
import blocks.*;
import floors.*;
import states.PlayState;

class LevelSerializer
{
	private var map:FlxOgmoLoader;
	
	public function new()
	{
		
	}
	
	public function nextLevel()
	{
		if (!isExistsNextLevel()) return;
		loadLevel(++Global.currentLevel);
	}
	
	public function prevLevel()
	{
		if (!isExistsPrevLevel()) return;
		loadLevel(--Global.currentLevel);
	}
	
	public function isExistsNextLevel():Bool
	{
		return Global.currentLevel < Global.LEVELS - 1;
	}
	
	public function isExistsPrevLevel():Bool
	{
		return Global.currentLevel < 0;
	}
	
	public function restartLevel()
	{
		loadLevel(Global.currentLevel);
	}
	
	public function loadLevel(level:Int)
	{
		
		states.PlayState.enemies.clear();
		states.PlayState.floors.clear();
		
		map = new FlxOgmoLoader("assets/levels/" + level + ".oel");
		
		map.loadEntities(placeEntities, "entities");
		map.loadEntities(placeWalls, "staticWalls");
		map.loadEntities(placeFloors, "Floors");
		
		Global.paused = true;
		FlxG.mouse.visible = true;

		PlayState.camera.scroll.x = 0; // FIXME: need loading position from level;
		PlayState.camera.scroll.y = 0; // FIXME: need loading position from level;
	}
	
	// --------------- LOADERS ---------------- //
	private function placeWalls(entityName:String, entityData:Xml):Void
	{
		
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var ax:Float = Std.parseInt(entityData.get("Accel_x"));
		var ay:Float = Std.parseInt(entityData.get("Accel_y"));
		
		var blk:Block;
			
		switch(entityName)
		{
			case "Block":
					blk = new Block(x, y);
			case "BlockMove": 
				blk = new blocks.BlockMove(x, y);
				blk.acceleration.x = ax;
				blk.acceleration.y = ay;
			default:
				throw "Unknown Block type: " + entityName;
		}
		states.PlayState.enemies.add(blk);
	}
	
	private function placeFloors(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		var flr:floors.Floor;
			
		switch(entityName)
		{
			case "Floor": 
				flr = new floors.Floor(x, y);
			case "FloorFalling": 
				flr = new floors.FloorFalling(x, y);
			case "FloorEnd": 
				flr = new floors.FloorEnd(x, y);
			case "FloorHot": 
				flr = new FloorHot(x, y);
			default: 
				throw "Unknown Floor type: " + entityName;
		}
		states.PlayState.floors.add(flr);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch(entityName)
		{
			case "Player":
				Global.player.x = x;
				Global.player.y = y;
			default:
				throw Std.string("Unknown Entity type: " + entityName);
		}
	}
}