package options.ue;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import MusicBeatState;
import Controls;

using StringTools;

class UEHud extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Universe HUD options';
		rpcTitle = 'HUD options of the engine'; // for Discord Rich Presence

		var option:Option = new Option('Universe Engine HUD', "If unchecked, it just goes back to scoreTxt, what more is there to explain? ", 'ueHud', 'bool',
			true);
		addOption(option);

		if (ClientPrefs.ueHud == true)
		{
			var option:Option = new Option('Hud Pos', "Don't even try to ask me to explain this", 'hudPosUE', 'string', 'LEFT', ['LEFT', 'CENTER', 'RIGHT']);
			addOption(option);

			var option:Option = new Option('Song name and time follow', "If unchecked, The Song name and time doesn't follow the score, rating and misses.",
				'sntf', 'bool', true);
			addOption(option);

			var option:Option = new Option("Hide UE's Timebar", ' If unchecked, the UE time bar is going to dissapear', 'huet', 'bool', false);
			addOption(option);
		}

		var option:Option = new Option('Detached Health Bar', 'When Unchecked, the health bar get sets to camHUD', 'dhb', 'bool', true);
		addOption(option);

		var option:Option = new Option('Combo Counter', "If unchecked, it'll go back to the normal combo coutner", 'cc', 'bool', true);
		addOption(option);

		var option:Option = new Option('Zoomed Out', "If unchecked, it no zoomed out :3", 'hudZoomOut', 'bool', true);
		addOption(option);

		var option:Option = new Option('Icon Bop', "If the mod has a custom icon bop, disable this!", 'ib', 'bool', true);
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;

	function onChangePauseMusic()
	{
		if (ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if (changedMusic)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if (Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	function onChangeHitSound()
	{
		FlxG.sound.play(Paths.sound(ClientPrefs.ht), ClientPrefs.hitsoundVolume);
	}
}
