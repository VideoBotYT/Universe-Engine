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
import lime.app.Application;

using StringTools;

class UEGameOptions extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Universe Game options';
		rpcTitle = 'Game options of the engine'; // for Discord Rich Presence

		var option:Option = new Option('Main Menu Music', 'Change the main menu song', 'mmm', 'string', 'Universe', [
			'Universe',
			'FunkinParadise',
			"AAC V4",
			'VS Impostor V4',
			'VS Shaggy',
			'VS Nonsense V2',
			'DNB Old',
			'Stay Funky',
			'Marked Engine',
			'idiotxd'
		]);
		addOption(option);

		var option:Option = new Option('Fancy Title', 'Title bounce', 'ft', 'bool', false);
		addOption(option);

		var option:Option = new Option('Cute Mode', if (ClientPrefs.cm == true)
		{
			'i coded this UwU';
		} else
		{
			'What is this option i never coded this';
		}, 'cm', 'bool', false);
		addOption(option);
		option.onChange = restart;

		var option:Option = new Option('Check for Updates', 'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates', 'bool', true);
		addOption(option);

		var option:Option = new Option('Dark Mode', 'Basically dark mode on every website, but cooler', 'darkmode', 'bool', false);
		addOption(option);

		var option:Option = new Option('Loading Screen', 'Loading screen!\nalso, this just does nothing lol', 'loadscreen', 'bool', false);
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

	function restart()
	{
		ClientPrefs.saveSettings();
		TitleState.initialized = false;
		TitleState.closedState = false;
		if (FreeplayState.vocals != null)
		{
			FreeplayState.vocals.fadeOut(0.3);
			FreeplayState.vocals = null;
		}
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
	}
}
