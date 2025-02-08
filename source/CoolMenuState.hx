package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.sound.FlxSound;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.FlxSubState;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import flixel.effects.FlxFlicker;
import lime.app.Application;
#if desktop
import Discord.DiscordClient;
#end
import editors.MasterEditorMenu;
import fancyItems.FancyButtonItem;
import flixel.util.FlxGradient;

using StringTools;

class CoolMenuState extends MusicBeatState
{
	var bg:FlxSprite;

	var phillyLightsColors:Array<FlxColor>;
	var phillyWindow:FlxSprite;
	var phillyStreet:FlxSprite;
	var streetBehind:FlxSprite;
	var phillyTrain:FlxSprite;
	var city:FlxSprite;
	var discLeft:FlxSprite;
	var discRight:FlxSprite;
	var gradient:FlxSprite;

	var dots:FlxBackdrop;

	var grid:FlxBackdrop;

	var curSelected:Int = 0;
	var menuItems:FlxTypedGroup<FancyButtonItem>;
	var selectedSomething:Bool = true;

	var curPage:String = "main";

	var menuPos:Float;

	var menuList:Array<String>;

	var debugKeys:Array<FlxKey>;

	var textBG:FlxSprite;
	var text:FlxText;

	var versionShitUE:FlxText;
	var versionShitPE:FlxText;
	var versionShitFNF:FlxText;

	var menuTween:Bool = false;
	var textTween:Bool = false;
	var versionTween:Bool = false;
	var switching:Bool = false;

	var targetX:Float = 12;
	var scale:Float = 1;

	override function create()
	{
		if (ClientPrefs.moveCreditMods)
			menuList = ['story_mode', 'freeplay', 'awards', 'donate', 'options'];
		else
			menuList = ['story_mode', 'freeplay', 'mods', 'credits', 'awards', 'donate', 'options'];

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.music("freakyMenu-" + ClientPrefs.mmm), 0.7);
		}

		ShortcutMenuSubState.inShortcutMenu = false;
		var yScroll:Float = Math.max(0.25 - (0.05 * (menuList.length - 4)), 0.1);
		bg = new FlxSprite(-100).loadGraphic(Paths.image('fancyMain/bg/sky'));
		bg.scrollFactor.set(0, yScroll);
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		city = new FlxSprite(-10).loadGraphic(Paths.image('fancyMain/bg/city'));
		city.scrollFactor.set(0, yScroll);
		city.setGraphicSize(Std.int(city.width * 0.85));
		city.updateHitbox();
		city.antialiasing = ClientPrefs.globalAntialiasing;
		add(city);

		phillyWindow = new FlxSprite(city.x, city.y).loadGraphic(Paths.image('fancyMain/bg/window'));
		phillyWindow.scrollFactor.set(0, yScroll);
		phillyWindow.setGraphicSize(Std.int(phillyWindow.width * 0.85));
		phillyWindow.updateHitbox();
		add(phillyWindow);

		streetBehind = new FlxSprite(-40, 50).loadGraphic(Paths.image('fancyMain/bg/behindTrain'));
		add(streetBehind);

		phillyStreet = new FlxSprite(-40, 50).loadGraphic(Paths.image('fancyMain/bg/street'));
		add(phillyStreet);

		grid = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(40, 20);
		add(grid);

		dots = new FlxBackdrop(Paths.image("blackDots"), X);
		dots.velocity.x = 24;
		dots.screenCenter();
		dots.alpha = 0.25;
		dots.y = 200;
		dots.scrollFactor.set(1, 3.5);
		add(dots);

		discLeft = new FlxSprite(FlxG.width / 2 - 1100, 0).loadGraphic(Paths.image("fancyMain/disc"));
		discLeft.scrollFactor.set(0, 0);
		discLeft.screenCenter(Y);
		discLeft.antialiasing = ClientPrefs.globalAntialiasing;
		discLeft.scale.set(3, 3);
		add(discLeft);

		discRight = new FlxSprite(FlxG.width / 2 + 600, 0).loadGraphic(Paths.image("fancyMain/disc"));
		discRight.scrollFactor.set(0, 0);
		discRight.screenCenter(Y);
		discRight.antialiasing = ClientPrefs.globalAntialiasing;
		discRight.scale.set(3, 3);
		add(discRight);

		menuItems = new FlxTypedGroup<FancyButtonItem>();
		add(menuItems);

		for (i in 0...menuList.length)
		{
			var offset:Float = 108 - (Math.max(menuList.length, 4) - 4) * 80;
			var menuItem:FancyButtonItem = new FancyButtonItem(FlxG.width / 2 + 200, (i * 140) + offset, menuList[i]);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.targetY = i - curSelected;
			menuItem.targetX = i + curSelected;
			menuItem.ID = i;
			menuItems.add(menuItem);
			var scr:Float = (menuList.length - 4) * 0.135;
			if (menuList.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		gradient = FlxGradient.createGradientFlxSprite(Std.int(FlxG.width), Std.int(FlxG.height / 2 - 40), [0x0, FlxColor.BLACK]);
		gradient.scrollFactor.set();
		gradient.y = FlxG.height - gradient.height;
		gradient.screenCenter(X);
		gradient.antialiasing = ClientPrefs.globalAntialiasing;
		add(gradient);

		versionShitUE = new FlxText(FlxG.width - 2000, FlxG.height - 92, 0, "Universe Engine v: " + MainMenuState.ueVersion, 12);
		versionShitUE.scrollFactor.set();
		versionShitUE.setFormat(Paths.font('funkin.ttf'), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShitUE);
		FlxTween.tween(versionShitUE, {x: targetX}, 2, {
			ease: FlxEase.backOut
		});
		versionShitPE = new FlxText(FlxG.width - 2000, FlxG.height - 72, 0, "Psych Engine v: " + MainMenuState.psychEngineVersion, 12);
		versionShitPE.scrollFactor.set();
		versionShitPE.setFormat(Paths.font('funkin.ttf'), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShitPE);
		FlxTween.tween(versionShitPE, {x: targetX}, 2, {
			ease: FlxEase.backOut,
			startDelay: 0.5
		});
		versionShitFNF = new FlxText(FlxG.width - 2000, FlxG.height - 52, 0, "Friday Night Funkin' v: " + Application.current.meta.get('version'), 12);
		versionShitFNF.scrollFactor.set();
		versionShitFNF.setFormat(Paths.font('funkin.ttf'), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShitFNF);
		FlxTween.tween(versionShitFNF, {x: targetX}, 2, {
			ease: FlxEase.backOut,
			startDelay: 1
		});

		textBG = new FlxSprite(0, FlxG.height + 100).makeGraphic(FlxG.width, 30, 0xFF000000);
		textBG.scrollFactor.set();
		textBG.alpha = 0;
		add(textBG);
		var leText:String = "Press TAB to open the shortcut menu / Press RESET to restart the game";
		var size:Int = 18;
		text = new FlxText(textBG.x + 800, FlxG.height - 30, FlxG.width, leText, size);
		text.setFormat(Paths.font("funkin.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);

		FlxTween.tween(textBG, {alpha: 0.6, y: FlxG.height - 30}, 1, {
			ease: FlxEase.circOut,
			onComplete: function(tween:FlxTween)
			{
				FlxTween.tween(text, {x: textBG.x - 4, y: textBG.y + 4}, 1, {ease: FlxEase.circOut});
			}
		});

		changeItem(0);

		selectedSomething = false;

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!ShortcutMenuSubState.inShortcutMenu && !selectedSomething)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
			if (controls.ACCEPT)
			{
				doShish();
			}
			if (controls.RESET)
			{
				TitleState.initialized = false;
				TitleState.closedState = false;
				if (FreeplayState.vocals != null)
				{
					FreeplayState.vocals.fadeOut(0.3);
					FreeplayState.vocals = null;
				}
				FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
			}

			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (FlxG.keys.justPressed.TAB)
			{
				openSubState(new ShortcutMenuSubState());
				ShortcutMenuSubState.inShortcutMenu = true;
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				debugTween();
			}
			#end
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (menuTween && textTween && versionTween)
		{
			MusicBeatState.switchState(new MasterEditorMenu());
		}

		super.update(elapsed);
	}

	function changeItem(amount:Int = 0):Void
	{
		var prevSelect:Int = curSelected;
		curSelected += amount;

		curSelected = FlxMath.wrap(curSelected, 0, menuItems.length - 1);

		var bullShit:Int = 0;

		for (item in menuItems.members)
		{
			item.targetY = bullShit - curSelected;
			item.targetX = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
			if (item.targetY != 0)
			{
				item.targetX += Std.int(Math.abs(item.targetY) * 5);
			}
		}
	}

	function doShish()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		selectedSomething = true;

		menuItems.forEach(function(spr:FlxSprite)
		{
			if (curSelected != spr.ID && menuList[curSelected] != 'donate')
			{
				FlxTween.tween(spr, {x: menuPos + 2000}, 2, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						spr.kill();
					}
				});
			}
			else
			{
				FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					selectItem();
				});
			}
		});

		FlxTween.tween(textBG, {y: FlxG.height + 100}, 1, {ease: FlxEase.backInOut});
		FlxTween.tween(text, {x: textBG.x + 800}, 1, {ease: FlxEase.backInOut, startDelay: 0.25});
		FlxTween.tween(versionShitUE, {x: FlxG.width + 200}, 1, {ease: FlxEase.backInOut, startDelay: 0.5});
		FlxTween.tween(versionShitPE, {x: FlxG.width + 200}, 1, {ease: FlxEase.backInOut, startDelay: 0.75});
		FlxTween.tween(versionShitFNF, {x: FlxG.width + 200}, 1, {ease: FlxEase.backInOut, startDelay: 1});
	}

	function selectItem():Void
	{
		var selectedButton:String = "";

		selectedButton = menuList[curSelected].toLowerCase().trim();

		switch (selectedButton)
		{
			case 'story_mode':
				LoadingState.loadAndSwitchState(new CoolStoryState());
			case 'freeplay':
				LoadingState.loadAndSwitchState(new FreeplayState());
			case 'mods':
				LoadingState.loadAndSwitchState(new ModsMenuState());
			case 'credits':
				LoadingState.loadAndSwitchState(new CreditsState());
			case 'options':
				LoadingState.loadAndSwitchState(new options.SelectThing());
			case 'awards':
				LoadingState.loadAndSwitchState(new AchievementsMenuState());
			case 'donate':
				CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				selectedSomething = false;
		}
	}

	function debugTween()
	{
		menuItems.forEachAlive(function(member:FlxSprite)
		{
			FlxTween.cancelTweensOf(member);
			FlxTween.tween(member, {x: menuPos + 2000}, 2, {
				ease: FlxEase.backInOut,
				onComplete: function(tween:FlxTween)
				{
					member.destroy();
					menuTween = true;
				}
			});
		});
		FlxTween.tween(textBG, {y: FlxG.height + 100}, 1, {ease: FlxEase.backInOut});
		FlxTween.tween(text, {x: textBG.x + 800}, 1, {
			ease: FlxEase.backInOut,
			startDelay: 0.25,
			onComplete: function(tween:FlxTween)
			{
				textTween = true;
			}
		});
		FlxTween.tween(versionShitUE, {x: FlxG.width + 200}, 1, {ease: FlxEase.backInOut, startDelay: 0.5});
		FlxTween.tween(versionShitPE, {x: FlxG.width + 200}, 1, {ease: FlxEase.backInOut, startDelay: 0.75});
		FlxTween.tween(versionShitFNF, {x: FlxG.width + 200}, 1, {
			ease: FlxEase.backInOut,
			startDelay: 1,
			onComplete: function(tween:FlxTween)
			{
				versionTween = true;
			}
		});
	}
}
