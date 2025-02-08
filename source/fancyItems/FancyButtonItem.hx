package fancyItems;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class FancyButtonItem extends FlxSprite
{
	public var targetY:Float = FlxG.height / 2;
	public var targetX:Float = 0;
	public var changeX:Bool = true;
	public var changeY:Bool = true;

	public var distancePerItem:FlxPoint = new FlxPoint(20, 120);
	public var startPosition:FlxPoint = new FlxPoint(FlxG.width / 2 + 200, 320);

	public function new(x:Float, y:Float, option:String = '')
	{
		super(x, y);
		loadGraphic(Paths.image('fancyMain/menu_' + option));
		// trace('Test added: ' + WeekData.getWeekNumber(weekNum) + ' (' + weekNum + ')');
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	override function update(elapsed:Float)
	{
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 9.6, 0, 1);
		if (changeX)
			x = FlxMath.lerp(x, (targetX * distancePerItem.x) + startPosition.x, lerpVal);
		if (changeY)
			y = FlxMath.lerp(y, (targetY * 1.3 * distancePerItem.y) + startPosition.y, lerpVal);
		super.update(elapsed);
	}

	public function snapToPosition()
	{
		if (changeX)
			x = (targetX * distancePerItem.x) + startPosition.x;
		if (changeY)
			y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
	}

    override public function kill()
    {
        super.kill();
    }
    override public function destroy()
    {
        super.destroy();
    }
}
