package;

import flixel.addons.editors.tiled.TiledTileLayer;
import blocks.Block;
import blocks.BlockMove;
import entities.Player;
import flixel.FlxState;
import floors.Floor;
import floors.FloorEnd;
import floors.FloorFalling;
import floors.FloorHot;
import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.editors.tiled.TiledLayer;

import states.PlayState;
/**
 * ...
 * @author Koncord
 */
class LevelLoader extends TiledMap {
    private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/";

    // Array of tilemaps used for collision
    public var state:FlxState;
    /*private var collidableTileLayers:Array<FlxTilemap>;*/

    public function new(tiledLevel:Dynamic, state:FlxState) {
        super(tiledLevel);

        this.state = state;

        FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);
        //FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);

        // Load Tile Maps
        for (tileLayer in layers) {

            if (tileLayer.type != TiledLayerType.TILE)
                continue;
            var tileLayer:TiledTileLayer = cast tileLayer;

            var tileSet:TiledTileSet = null;

            if (tileLayer.name == "FloorLayer")
                loadFloors(tileLayer);
            if (tileLayer.name == "BlockLayer")
                loadBlocks(tileLayer);
        }
        loadObjects();
    }

    public function loadFloors(tileLayer:TiledTileLayer) {
        var x:Int = 0;
        var y:Int = 0;

        for (tile in tileLayer.tileArray) {
            var ts:TiledTileSet = tilesets.get("Floors");

            if (tile != 0) {
                var flr:Floor;
                switch(ts.fromGid(tile))
                {
                    case 1:
                        flr = new Floor(x * 64, y * 64);
                    case 2:
                        flr = new FloorEnd(x * 64, y * 64);
                    case 3:
                        flr = new FloorFalling(x * 64, y * 64);
                    case 4:
                        flr = new FloorHot(x * 64, y * 64);
                    default:
                        throw "Unknown Floor id: " + ts.fromGid(tile) + " on pos " + x + ":" + y;
                }
                PlayState.floors.add(flr);
            }
            if (x == tileLayer.map.width - 1) { y++; x = -1;}
            x++;
        }
    }

    public function loadBlocks(tileLayer:TiledTileLayer) {
        var x:Int = 0;
        var y:Int = 0;

        for (tile in tileLayer.tileArray) {
            var ts:TiledTileSet = tilesets.get("Blocks");
            if (tile != 0) {
                var blk:Block;
                switch(ts.fromGid(tile)) {
                    case 1:
                        blk = new Block(x * 64, y * 64);
                    default:
                        throw "Unknown Block id: " + ts.fromGid(tile) + " on pos " + x + ":" + y;
                }
                PlayState.enemies.add(blk);
            }
            if (x == tileLayer.width - 1) { y++; x = -1;}
            x++;
        }
    }

    public function loadObjects() {
        for (layer in layers) {
            if (layer.type != TiledLayerType.OBJECT)
                continue;

            if (layer.name == "Entities") {
                var objectLayer:TiledObjectLayer = cast layer;
                for (o in objectLayer.objects)
                    loadObject(o, layer);
            }
        }
    }

    private function loadObject(o:TiledObject, g:TiledLayer) {
        var x:Int = o.x;
        var y:Int = o.y;

        // objects in tiled are aligned bottom-left (top-left in flixel)
        if (o.gid != -1)
            y -= g.map.getGidOwner(o.gid).tileHeight;

        switch (o.type.toLowerCase())
        {
            case "player":
                Global.player.x = x;
                Global.player.y = y;
            case "block_move":
                var block:BlockMove = new BlockMove(x, y);
                for (p in o.xmlData.node.properties.nodes.property) {
                    if (p.att.name == "ax")
                        block.acceleration.x = Std.parseInt(p.att.value);
                    if (p.att.name == "ay")
                        block.acceleration.y = Std.parseInt(p.att.value);
                }
                PlayState.enemies.add(block);
        }
    }

    /*public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers != null)
		{
			for (map in collidableTileLayers)
			{
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}*/
}