package options.ue;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUISlider;
import flixel.ui.FlxButton;
import hxwindowmode.WindowColorMode;

using StringTools;

class WindowsColor extends MusicBeatSubstate
{
	var defCol:Array<Int> = [112, 0, 218];
	var sliderRed:FlxUISlider;
	var sliderGreen:FlxUISlider;
	var sliderBlue:FlxUISlider;
	var reset:FlxButton;

	var r:String;
	var g:String;
	var b:String;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		sliderRed = new FlxUISlider(this, 'r', FlxG.width / 2, FlxG.height / 2 - 40, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderRed.nameLabel.text = 'RED';
		sliderRed.value = ClientPrefs.windowColor[0];
		sliderRed.screenCenter(X);
		add(sliderRed);

		sliderGreen = new FlxUISlider(this, 'g', FlxG.width / 2, sliderRed.y + 40, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderGreen.nameLabel.text = 'GREEN';
		sliderGreen.value = ClientPrefs.windowColor[1];
		sliderGreen.screenCenter(X);
		add(sliderGreen);

		sliderBlue = new FlxUISlider(this, 'b', FlxG.width / 2, sliderGreen.y + 40, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderBlue.nameLabel.text = 'BLUE';
		sliderBlue.value = ClientPrefs.windowColor[2];
		sliderBlue.screenCenter(X);
		add(sliderBlue);

		reset = new FlxButton(0, sliderBlue.y + 40, "Reset", function()
		{
			sliderRed.value = defCol[0];
			sliderGreen.value = defCol[1];
			sliderBlue.value = defCol[2];
		});
		reset.screenCenter(X);
		add(reset);

		FlxG.mouse.visible = true;
	}

	override function update(elapsed:Float)
	{
		var colArray:Array<Int> = [Std.int(sliderRed.value), Std.int(sliderGreen.value), Std.int(sliderBlue.value)];
		ClientPrefs.windowColor = colArray;
		WindowColorMode.setWindowBorderColor(ClientPrefs.windowColor);

		if (controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
			return;
		}
		if (controls.RESET)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			sliderRed.value = defCol[0];
			sliderGreen.value = defCol[1];
			sliderBlue.value = defCol[2];
		}

		super.update(elapsed);
	}
}
