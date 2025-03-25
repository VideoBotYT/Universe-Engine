package options.ue;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUISlider;
import flixel.ui.FlxButton;
import hxwindowmode.WindowColorMode;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUITabMenu;

using StringTools;

class WindowsColor extends MusicBeatSubstate
{
	var ui_box:FlxUITabMenu;
	var defCol:Array<Int> = [112, 0, 218];
	var sliderRed:FlxUISlider;
	var sliderGreen:FlxUISlider;
	var sliderBlue:FlxUISlider;
	var reset:FlxButton;
	var redraw:FlxButton;

	var r:String;
	var g:String;
	var b:String;

	public function new()
	{
		super();

		var tabs = [
			{name: "Sliders", label: "Sliders"},
			{name: "Windows 10", label: "Windows 10"}
		];

		ui_box = new FlxUITabMenu(null, tabs, true);
		ui_box.resize(300, 300);
		ui_box.x = FlxG.width - 400;
		ui_box.y = 25;
		add(ui_box);

		FlxG.mouse.visible = true;

		addSliderUI();
		addWindows10UI();
	}

	function addSliderUI()
	{
		var sliderGroup = new FlxUI(null, ui_box);
		sliderGroup.name = "Sliders";

		sliderRed = new FlxUISlider(this, 'r', 20, 20, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderRed.nameLabel.text = 'RED';
		sliderRed.value = ClientPrefs.data.windowColor[0];

		sliderGreen = new FlxUISlider(this, 'g', sliderRed.x, sliderRed.y + 60, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderGreen.nameLabel.text = 'GREEN';
		sliderGreen.value = ClientPrefs.data.windowColor[1];

		sliderBlue = new FlxUISlider(this, 'b', sliderGreen.x, sliderGreen.y + 60, 0, 255, 250, null, 5, FlxColor.WHITE, FlxColor.BLACK);
		sliderBlue.nameLabel.text = 'BLUE';
		sliderBlue.value = ClientPrefs.data.windowColor[2];

		reset = new FlxButton(sliderBlue.x, sliderGreen.y + 140, "Reset", function(){
			FlxG.sound.play(Paths.sound('cancelMenu'));
			sliderRed.value = defCol[0];
			sliderGreen.value = defCol[1];
			sliderBlue.value = defCol[2];
		});

		sliderGroup.add(sliderRed);
		sliderGroup.add(sliderGreen);
		sliderGroup.add(sliderBlue);
		sliderGroup.add(reset);
		ui_box.addGroup(sliderGroup);
	}

	function addWindows10UI()
	{
		var windows10Group = new FlxUI(null, ui_box);
		windows10Group.name = "Windows 10";

		redraw = new FlxButton(20, 20, "Redraw Border", function(){
			FlxG.sound.play(Paths.sound('cancelMenu'));
			WindowColorMode.redrawWindowHeader();
		});

		windows10Group.add(redraw);
		ui_box.addGroup(windows10Group);
	}

	override function update(elapsed:Float)
	{
		var colArray:Array<Int> = [Std.int(sliderRed.value), Std.int(sliderGreen.value), Std.int(sliderBlue.value)];
		ClientPrefs.data.windowColor = colArray;
		WindowColorMode.setWindowBorderColor(ClientPrefs.data.windowColor);

		if (controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
			return;
		}

		super.update(elapsed);
	}
}
