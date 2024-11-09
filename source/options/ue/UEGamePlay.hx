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

		var option:Option = new Option('Smooth HP', 'If there was any bug moving the position X health icons, turn this off!', 'sh', 'bool', true);
		addOption(option);

		var option:Option = new Option('Every 100 combo', 'If every 100 combo, it does a cool thing :D', 'ec', 'bool', true);
		addOption(option);

		if (ClientPrefs.ec)
		{
			var option:Option = new Option('100 Combo sound', 'Select a sound that plays everytime you have 100 combo count', 'css', 'string', 'GF Sounds',
				['GF Sounds', 'Click Text']);
			addOption(option);
		}

		var option:Option = new Option('Shake on miss', "If unchecked, screen doesn't shake on miss", 'snm', 'bool', false);
		addOption(option);

		var option:Option = new Option('Taunt on Go!', "If unchecked, doesn't taunt on go!", 'tng', 'bool', true);
		addOption(option);

		var option:Option = new Option('Darken CamGame', 'If checked, it darkens the camGame, so its easier to read modcharts.', 'dcm', 'bool', false);
		addOption(option);

		var option:Option = new Option('Long note Transparency', 'How much the transparency for the long notes be.', 'longnotet', 'percent', 0.6);
		addOption(option);
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.scrollSpeed = 1.6;

		var option:Option = new Option('Results Screen', 'If unchecked, the results screen wont appear on end song.', 'ueresultscreen', 'bool', true);
		addOption(option);

		var option:Option = new Option('Strum Splashes', 'If unchecked, Strum splashes wont be visible anymore.', 'uess', 'bool', true);
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
			FlxG.sound.playMusic(Paths.music("freakyMenu-" + ClientPrefs.mmm));
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
		FlxG.sound.play(Paths.sound("hitsound-" + ClientPrefs.ht), ClientPrefs.hitsoundVolume);
	}
}
