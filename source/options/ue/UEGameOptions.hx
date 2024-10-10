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

class UEGameOptions extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Universe Game options';
		rpcTitle = 'Game options of the engine'; // for Discord Rich Presence

		var option:Option = new Option('Main Menu Music', 'Change the main menu song', 'mmm', 'string', 'freakymenu', [
			'freakyMenu',
			'FunkinParadise',
			"An Ammar's Creativity V4",
			'VS Impostor V4',
			'VS Shaggy',
			'VS Nonsense V2'
		]);
		addOption(option);

		var option:Option = new Option('Fancy Title', 'Title bounce', 'ft', 'bool', false);
		addOption(option);

		var Option:Option = new Option('Black Dots', 'When checked it shows black dots in the background', 'bd', 'bool', true);
		addOption(Option);

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
