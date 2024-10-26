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

class UEGamePlay extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Universe Gameplay options';
		rpcTitle = 'Gameplay options of the engine'; // for Discord Rich Presence

		var option:Option = new Option('Keystrokes', "If checked, you can see the keystrokes", 'keystrokes', 'bool', true);
		addOption(option);

		if (ClientPrefs.keystrokes == true)
		{
			var option:Option = new Option('Keystrokes Alpha', 'Keystrokes Alpha, max 50%', 'keyA', 'percent', 0.3);
			addOption(option);
			option.maxValue = 0.5;

			var option:Option = new Option('Keystrokes Fade Time', 'Keystrokes Fade time, max 25%', 'keyFT', 'percent', 0.15);
			addOption(option);
			option.maxValue = 0.25;

			var option:Option = new Option('Keystrokes X Position', 'Keystrokes X Pos, max 640', 'keyXPos', 'int', 90);
			addOption(option);
			option.maxValue = 640;

			var option:Option = new Option('Keystrokes Y Position', 'Keystrokes Y Pos, max 720', 'keyYPos', 'int', 330);
			addOption(option);
			option.maxValue = 720;
		}

		var option:Option = new Option('Smooth HP', 'If there was any bug moving the position X health icons, turn this off!', 'sh', 'bool', true);
		addOption(option);

		var option:Option = new Option('Every 100 combo', 'If every 100 combo, it does a cool thing :D', 'ec', 'bool', true);
		addOption(option);

		if (ClientPrefs.ec)
		{
			var option:Option = new Option('100 Combo sound', 'Select a sound that plays everytime you have 100 combo count', 'css', 'string',
				'GF Sounds', ['GF Sounds', 'Click Text']);
			addOption(option);
		}

		var option:Option = new Option('Shake on miss', "If unchecked, screen doesn't shake on miss", 'snm', 'bool', false);
		addOption(option);

		var option:Option = new Option('Taunt on Go!', "If unchecked, doesn't taunt on go!", 'tng', 'bool', true);
		addOption(option);

		var option:Option = new Option('Darken CamGame', 'If checked, it darkens the camGame, so its easier to read modcharts.', 'dcm', 'bool', false);
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
