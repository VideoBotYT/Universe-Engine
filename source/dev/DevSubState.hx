package dev;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.util.FlxGradient;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
//previoulsy used as ShortCut menu
class DevSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	public static var inShortcutMenu = false;

	var menuItems:Array<String> = [];

	var menuItemsDev:Array<String> = ["Stage Editor", "Character Editor"];

	var curSelected:Int = 0;

	public var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

	var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));

	var UI_Box:FlxUITabMenu;
	static var enableStage:Bool;
	public static var animatedIcons:Bool;

	public function new()
	{
		super();

		menuItems = menuItemsDev;

		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		grid.velocity.set(20, 20);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		var tabs = [
			{name: "Dev Options", label: "Dev Options"},
			{name: "Dev States", label:"Dev States"}
		];

		UI_Box = new FlxUITabMenu(null, tabs, true);
		UI_Box.resize(300, 300);
		UI_Box.x = FlxG.width - 400;
		UI_Box.y = 25;
		add(UI_Box);

		FlxG.mouse.visible = true;

		regenMenu();
		addDevStateUI();
		addDevOptionUI();
		UI_Box.selected_tab_id = "Dev States";
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxG.sound.music.fadeIn(2, 0.7, 0.2);
	}

	override function update(elapsed)
	{
		super.update(elapsed);

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var canceled = controls.BACK;

		if (canceled)
		{
			inShortcutMenu = false;
			FlxG.mouse.visible = false;
			UI_Box.destroy();
			for (i in 0...grpMenuShit.members.length)
			{
				var obj = grpMenuShit.members[0];
				obj.kill();
				grpMenuShit.remove(obj, true);
				obj.destroy();
			}
			FlxTween.tween(bg, {alpha: 0}, 1.5, {ease: FlxEase.quartInOut});
			FlxTween.tween(grid, {alpha: 0}, 1, {
				ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					close();
				}
			});
		}
		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		if (accepted && !ClientPrefs.data.controllerMode && enableStage)
		{
			var daSelected:String = menuItems[curSelected];
			switch (daSelected)
			{
				case "Stage Editor":
					LoadingState.loadAndSwitchState(new editors.StageEditor());
				case "Character Editor":
					LoadingState.loadAndSwitchState(new editors.CharacterEditorState(Character.DEFAULT_CHARACTER, false));
			}
		}

		if (stageEditorButton.checked)
			enableStage = true;
		else
			enableStage = false;
		if (iconButton.checked)
			animatedIcons = true;
		else
			animatedIcons = false;
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

	function regenMenu():Void
	{
		for (i in 0...grpMenuShit.members.length)
		{
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length)
		{
			var item = new Alphabet(90, 320, menuItems[i], true);
			item.isMenuItem = true;
			item.targetY = i;
			item.changeX = false;
			item.screenCenter(X);
			grpMenuShit.add(item);
		}
		curSelected = 0;
		changeSelection();
	}

	var stageEditorButton:FlxUICheckBox;

	function addDevStateUI()
	{
		var stateGroup = new FlxUI(null, UI_Box);
		stateGroup.name = "Dev States";

		stageEditorButton = new FlxUICheckBox(20, 20, null, null, "Stage Editor", 100);
		stageEditorButton.checked = enableStage;

		stateGroup.add(stageEditorButton);
		UI_Box.addGroup(stateGroup);
	}

	var iconButton:FlxUICheckBox;

	function addDevOptionUI()
	{
		var optionGroup = new FlxUI(null, UI_Box);
		optionGroup.name = "Dev Options";

		iconButton = new FlxUICheckBox(20, 20, null, null, "Animated Icons");
		iconButton.checked = animatedIcons;

		optionGroup.add(iconButton);
		UI_Box.addGroup(optionGroup);
	}
}
