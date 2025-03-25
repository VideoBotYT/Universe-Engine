package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxBasic;
import ueLua.MenuLua;
import flixel.sound.FlxSound;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class MusicBeatState extends modchart.modcharting.ModchartMusicBeatState
{
	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	public static var camBeat:FlxCamera;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	// lua
	public static var instance:MusicBeatState;

	public var menuLuaArray:Array<MenuLua> = [];

	#if (haxe >= "4.0.0")
	public var menuvariables:Map<String, Dynamic> = new Map();
	public var menuTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var menuSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var menuTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var menuSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	//public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	//public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();
	#else
	public var menuvariables:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var menuTweens:Map<String, FlxTween> = new Map();
	public var menuSprites:Map<String, ModchartSprite> = new Map();
	public var menuTimers:Map<String, FlxTimer> = new Map();
	public var menuSounds:Map<String, FlxSound> = new Map();
	//public var modchartTexts:Map<String, ModchartText> = new Map();
	//public var modchartSaves:Map<String, FlxSave> = new Map();
	#end

	override function create()
	{
		// lua
		instance = this;

		camBeat = FlxG.camera;
		var skip:Bool = FlxTransitionableState.skipNextTransOut;

		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('menuScripts/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('menuScripts/'));
		if (Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/menuScripts/'));

		for (mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/menuScripts/'));
		#end

		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if (file.endsWith('.lua') && !filesPushed.contains(file))
					{
						menuLuaArray.push(new MenuLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end

		super.create();

		if (!skip)
		{
			openSubState(new CustomFadeTransition(0.7, true));
		}
		FlxTransitionableState.skipNextTransOut = false;
	}

	override function update(elapsed:Float)
	{
		// everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if (curStep > 0)
				stepHit();

			if (PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}
		}

		if (FlxG.save.data != null)
			FlxG.save.data.fullscreen = FlxG.fullscreen;

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if (stepsToDo < 1)
			stepsToDo = Math.round(getBeatsOnSection() * 4);
		while (curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if (curStep < 0)
			return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if (stepsToDo > curStep)
					break;

				curSection++;
			}
		}

		if (curSection > lastSection)
			sectionHit();
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep / 4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.data.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public static function switchState(nextState:FlxState)
	{
		// Custom made Trans in
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		if (!FlxTransitionableState.skipNextTransIn)
		{
			leState.openSubState(new CustomFadeTransition(0.6, false));
			if (nextState == FlxG.state)
			{
				CustomFadeTransition.finishCallback = function()
				{
					FlxG.resetState();
				};
				// trace('resetted');
			}
			else
			{
				CustomFadeTransition.finishCallback = function()
				{
					FlxG.switchState(nextState);
				};
				// trace('changed state');
			}
			return;
		}
		FlxTransitionableState.skipNextTransIn = false;
		FlxG.switchState(nextState);
	}

	public static function resetState()
	{
		MusicBeatState.switchState(FlxG.state);
	}

	public static function getState():MusicBeatState
	{
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		return leState;
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		// trace('Beat: ' + curBeat);
	}

	public function sectionHit():Void
	{
		// trace('Section: ' + curSection + ', Beat: ' + curBeat + ', Step: ' + curStep);
	}

	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if (PlayState.SONG != null && PlayState.SONG.notes[curSection] != null)
			val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}

	public function getLuaObject(tag:String, text:Bool = true):FlxSprite
	{
		if (menuSprites.exists(tag))
			return menuSprites.get(tag);
		//if (text && menuTexts.exists(tag))
		//	return menuTexts.get(tag);
		if (menuvariables.exists(tag))
			return menuvariables.get(tag);
		return null;
	}
}
