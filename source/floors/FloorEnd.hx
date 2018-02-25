package floors;

/**
 * ...
 * @author Koncord
 */

import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;

class FloorEnd extends Floor // наследуем поведение стандартного пола
{
	
	public function new(X:Int=0, Y:Int=0)
	{
		super(X, Y);
		loadGraphic("assets/images/Floor_End.png"); // загрузка спрайта
	}
	
	override public function update(elapsed:Float):Void // перегружаем функцию update
	{
		if (FlxG.overlap(this, Global.player)) // при столкновении с шариком
		{
				states.PlayState.lvlLoader.nextLevel(); // переходим на след. уровень
		}
		super.update(elapsed); // стандартное поведение update
	}
}