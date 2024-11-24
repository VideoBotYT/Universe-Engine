package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import flixel.util.FlxColor;

class ClientPrefs
{
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var showFPS:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = false;
	public static var lowQuality:Bool = false;
	public static var shaders:Bool = true;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Time Left';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var controllerMode:Bool = false;
	public static var hitsoundVolume:Float = 0;
	public static var pauseMusic:String = 'Tea Time';
	public static var checkForUpdates:Bool = true;
	public static var comboStacking = true;

	public static var splashAlpha:Float = 0.6;

	// UE
	public static var universeEngineCPREF:Bool = true; //this is to check if you running universe engine!
	public static var keystrokes:Bool = true;
	public static var keyA:Float = 0.3;
	public static var keyFT:Float = 0.15;
	public static var keyXPos:Int = 90;
	public static var keyYPos:Int = 330;
	public static var ueHud:Bool = true;
	public static var hudZoomOut:Bool = true;
	public static var hudPosUE:String = 'LEFT';
	public static var sntf:Bool = true;
	public static var mmm:String = 'Universe';
	public static var ft:Bool = false;
	public static var ht:String = 'Classic';
	public static var dhb:Bool = true;
	public static var cc:Bool = true;
	public static var sh:Bool = true;
	public static var ec:Bool = true;
	public static var snm:Bool = false;
	public static var tng:Bool = true;
	public static var ib:Bool = true;
	public static var cm:Bool = false;
	public static var huet:Bool = false;
	public static var css:String = 'GF Sounds';
	public static var dcm:Bool = false;
	public static var uess:Bool = true;
	public static var lhpbgb:Bool = false;
	public static var longnotet:Float = 0.6;
	public static var darkmode:Bool = false;
	public static var ueresultscreen:Bool = true;
	public static var uems:Bool = true;
	public static var loadscreen:Bool = false;

	public static var noteSkin:String = 'Default';
	public static var noteColorStyle:String = 'Normal';

	public static var enableColorShader:Bool = true;
	public static var showNotes:Bool = true;

	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative',
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false,
		'modchart' => true,
		'pbs' => false,
		'sd' => false,
		'hd' => false, // ermm,,,
		'sn' => false, // this is shitty
		'hdp2' => false,
		'ipbr' => false,//
		'ipbrv' => "Normal"

	];

	public static var comboOffset:Array<Int> = [0, 0, 0, 0];
	public static var ratingOffset:Int = 0;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;

	// Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Key Bind, Name for ControlsSubState
		'note_left' => [A, LEFT],
		'note_down' => [S, DOWN],
		'note_up' => [W, UP],
		'note_right' => [D, RIGHT],
		'ui_left' => [A, LEFT],
		'ui_down' => [S, DOWN],
		'ui_up' => [W, UP],
		'ui_right' => [D, RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [BACKSPACE, ESCAPE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R, NONE],
		'volume_mute' => [ZERO, NONE],
		'volume_up' => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],
		'debug_1' => [SEVEN, NONE],
		'debug_2' => [EIGHT, NONE],
		'debug_3' => [NINE, NONE],
		'is' => [K, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static var defaultArrowRGB:Array<Array<FlxColor>>;
	public static var defaultPixelRGB:Array<Array<FlxColor>>;

	public static function loadDefaultStuff()
	{
		defaultKeys = keyBinds.copy();
		defaultArrowRGB = arrowRGB.copy();
		defaultPixelRGB = arrowRGBPixel.copy();
	}

	public static function saveSettings()
	{
		// UE
		FlxG.save.data.keystrokes = keystrokes;
		FlxG.save.data.keyA = keyA;
		FlxG.save.data.keyFT = keyFT;
		FlxG.save.data.keyXPos = keyXPos;
		FlxG.save.data.keyYPos = keyYPos;
		FlxG.save.data.ueHud = ueHud;
		FlxG.save.data.hudZoomOut = hudZoomOut;
		FlxG.save.data.hudPosUE = hudPosUE;
		FlxG.save.data.sntf = sntf;
		FlxG.save.data.mmm = mmm;
		FlxG.save.data.ft = ft;
		FlxG.save.data.ht = ht;
		FlxG.save.data.dhb = dhb;
		FlxG.save.data.cc = cc;
		FlxG.save.data.sh = sh;
		FlxG.save.data.ec = ec;
		FlxG.save.data.snm = snm;
		FlxG.save.data.tng = tng;
		FlxG.save.data.ib = ib;
		FlxG.save.data.cm = cm;
		FlxG.save.data.huet = huet;
		FlxG.save.data.css = css;
		FlxG.save.data.dcm = dcm;
		FlxG.save.data.uess = uess;
		FlxG.save.data.lhpbgb = lhpbgb;
		FlxG.save.data.longnotet = longnotet;
		FlxG.save.data.darkmode = darkmode;
		FlxG.save.data.ueresultscreen = ueresultscreen;
		FlxG.save.data.uems = uems;
		FlxG.save.data.loadscreen = loadscreen;

		FlxG.save.data.arrowRGB = arrowRGB;
		FlxG.save.data.arrowRGBPixel = arrowRGBPixel;

		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.opponentStrums = opponentStrums;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.shaders = shaders;
		FlxG.save.data.framerate = framerate;
		// FlxG.save.data.cursing = cursing;
		// FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;
		FlxG.save.data.achievementsMap = Achievements.achievementsMap;
		FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.pauseMusic = pauseMusic;
		FlxG.save.data.checkForUpdates = checkForUpdates;
		FlxG.save.data.comboStacking = comboStacking;

		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'universe'); // Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs()
	{
		// UE
		if (FlxG.save.data.keystrokes != null)
		{
			keystrokes = FlxG.save.data.keystrokes;
		}
		if (FlxG.save.data.keyA != null)
		{
			keyA = FlxG.save.data.keyA;
		}
		if (FlxG.save.data.keyFT != null)
		{
			keyFT = FlxG.save.data.keyFT;
		}
		if (FlxG.save.data.keyXpos != null)
		{
			keyXPos = FlxG.save.data.keyXPos;
		}
		if (FlxG.save.data.keyYPos != null)
		{
			keyYPos = FlxG.save.data.keyYPos;
		}
		if (FlxG.save.data.ueHud != null)
		{
			ueHud = FlxG.save.data.ueHud;
		}
		if (FlxG.save.data.hudZoomOut != null)
		{
			hudZoomOut = FlxG.save.data.hudZoomOut;
		}
		if (FlxG.save.data.hudPosUE != null)
		{
			hudPosUE = FlxG.save.data.hudPosUE;
		}
		if (FlxG.save.data.sntf != null)
		{
			sntf = FlxG.save.data.sntf;
		}
		if (FlxG.save.data.mmm != null)
		{
			mmm = FlxG.save.data.mmm;
		}
		if (FlxG.save.data.ft != null)
		{
			ft = FlxG.save.data.ft;
		}
		if (FlxG.save.data.ht != null)
		{
			ht = FlxG.save.data.ht;
		}
		if (FlxG.save.data.dhb != null)
		{
			dhb = FlxG.save.data.dhb;
		}
		if (FlxG.save.data.cc != null)
		{
			cc = FlxG.save.data.cc;
		}
		if (FlxG.save.data.sh != null)
		{
			sh = FlxG.save.data.sh;
		}
		if (FlxG.save.data.ec != null)
		{
			ec = FlxG.save.data.ec;
		}
		if (FlxG.save.data.snm != null)
		{
			snm = FlxG.save.data.snm;
		}
		if (FlxG.save.data.tng != null)
		{
			tng = FlxG.save.data.tng;
		}
		if (FlxG.save.data.ib != null)
		{
			ib = FlxG.save.data.ib;
		}
		if (FlxG.save.data.cm != null)
		{
			cm = FlxG.save.data.cm;
		}
		if (FlxG.save.data.huet != null)
		{
			huet = FlxG.save.data.huet;
		}
		if (FlxG.save.data.css != null)
		{
			css = FlxG.save.data.css;
		}
		if (FlxG.save.data.dcm != null)
		{
			dcm = FlxG.save.data.dcm;
		}
		if (FlxG.save.data.arrowRGB != null)
		{
			arrowRGB = FlxG.save.data.arrowRGB;
		}
		if (FlxG.save.data.arrowRGBPixel != null)
		{
			arrowRGBPixel = FlxG.save.data.arrowRGBPixel;
		}
		if (FlxG.save.data.uess != null)
		{
			uess = FlxG.save.data.uess;
		}
		if (FlxG.save.data.lhpbgb != null)
		{
			lhpbgb = FlxG.save.data.lhpbgb;
		}
		if (FlxG.save.data.longnotet != null)
		{
			longnotet = FlxG.save.data.longnotet;
		}
		if (FlxG.save.data.darkmode != null)
		{
			darkmode = FlxG.save.data.darkmode;
		}
		if (FlxG.save.data.ueresultscreen != null)
		{
			ueresultscreen = FlxG.save.data.ueresultscreen;
		}
		if (FlxG.save.data.uems != null)
		{
			uems = FlxG.save.data.uems;
		}
		if (FlxG.save.data.loadscreen != null)
		{
			loadscreen = FlxG.save.data.loadscreen;
		}

		// Normal Psych Stuff
		if (FlxG.save.data.downScroll != null)
		{
			downScroll = FlxG.save.data.downScroll;
		}
		if (FlxG.save.data.middleScroll != null)
		{
			middleScroll = FlxG.save.data.middleScroll;
		}
		if (FlxG.save.data.opponentStrums != null)
		{
			opponentStrums = FlxG.save.data.opponentStrums;
		}
		if (FlxG.save.data.showFPS != null)
		{
			showFPS = FlxG.save.data.showFPS;
			if (Main.fpsVar != null)
			{
				Main.fpsVar.visible = showFPS;
			}
		}
		if (FlxG.save.data.flashing != null)
		{
			flashing = FlxG.save.data.flashing;
		}
		if (FlxG.save.data.globalAntialiasing != null)
		{
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if (FlxG.save.data.noteSplashes != null)
		{
			noteSplashes = FlxG.save.data.noteSplashes;
		}
		if (FlxG.save.data.lowQuality != null)
		{
			lowQuality = FlxG.save.data.lowQuality;
		}
		if (FlxG.save.data.shaders != null)
		{
			shaders = FlxG.save.data.shaders;
		}
		if (FlxG.save.data.framerate != null)
		{
			framerate = FlxG.save.data.framerate;
			if (framerate > FlxG.drawFramerate)
			{
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			}
			else
			{
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
				cursing = FlxG.save.data.cursing;
			}
			if(FlxG.save.data.violence != null) {
				violence = FlxG.save.data.violence;
		}*/
		if (FlxG.save.data.camZooms != null)
		{
			camZooms = FlxG.save.data.camZooms;
		}
		if (FlxG.save.data.hideHud != null)
		{
			hideHud = FlxG.save.data.hideHud;
		}
		if (FlxG.save.data.noteOffset != null)
		{
			noteOffset = FlxG.save.data.noteOffset;
		}
		if (FlxG.save.data.arrowHSV != null)
		{
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if (FlxG.save.data.ghostTapping != null)
		{
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if (FlxG.save.data.timeBarType != null)
		{
			timeBarType = FlxG.save.data.timeBarType;
		}
		if (FlxG.save.data.scoreZoom != null)
		{
			scoreZoom = FlxG.save.data.scoreZoom;
		}
		if (FlxG.save.data.noReset != null)
		{
			noReset = FlxG.save.data.noReset;
		}
		if (FlxG.save.data.healthBarAlpha != null)
		{
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		}
		if (FlxG.save.data.comboOffset != null)
		{
			comboOffset = FlxG.save.data.comboOffset;
		}

		if (FlxG.save.data.ratingOffset != null)
		{
			ratingOffset = FlxG.save.data.ratingOffset;
		}
		if (FlxG.save.data.sickWindow != null)
		{
			sickWindow = FlxG.save.data.sickWindow;
		}
		if (FlxG.save.data.goodWindow != null)
		{
			goodWindow = FlxG.save.data.goodWindow;
		}
		if (FlxG.save.data.badWindow != null)
		{
			badWindow = FlxG.save.data.badWindow;
		}
		if (FlxG.save.data.safeFrames != null)
		{
			safeFrames = FlxG.save.data.safeFrames;
		}
		if (FlxG.save.data.controllerMode != null)
		{
			controllerMode = FlxG.save.data.controllerMode;
		}
		if (FlxG.save.data.hitsoundVolume != null)
		{
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}
		if (FlxG.save.data.pauseMusic != null)
		{
			pauseMusic = FlxG.save.data.pauseMusic;
		}
		if (FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}

		// flixel automatically saves your volume!
		if (FlxG.save.data.volume != null)
		{
			FlxG.sound.volume = FlxG.save.data.volume;
		}
		if (FlxG.save.data.mute != null)
		{
			FlxG.sound.muted = FlxG.save.data.mute;
		}
		if (FlxG.save.data.checkForUpdates != null)
		{
			checkForUpdates = FlxG.save.data.checkForUpdates;
		}
		if (FlxG.save.data.comboStacking != null)
			comboStacking = FlxG.save.data.comboStacking;

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'universe');
		if (save != null && save.data.customControls != null)
		{
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls)
			{
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic
	{
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls()
	{
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}

	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey>
	{
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len)
		{
			if (copiedArray[i] == NONE)
			{
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}

	public static var arrowRGB:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];

	public static var arrowRGBPixel:Array<Array<FlxColor>> = [
		[0xFFE276FF, 0xFFFFF9FF, 0xFF60008D],
		[0xFF3DCAFF, 0xFFF4FFFF, 0xFF003060],
		[0xFF71E300, 0xFFF6FFE6, 0xFF003100],
		[0xFFFF884E, 0xFFFFFAF5, 0xFF6C0000]
	];
}
