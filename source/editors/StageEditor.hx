package editors;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.sound.FlxSound;
import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import FunkinLua.ModchartSprite;
#if sys
import sys.FileSystem;
import sys.io.File;
import StageData.StageFile;
#end

using StringTools;

class StageEditor extends MusicBeatState
{
	var UI_Box:FlxUITabMenu;

	public var luaArray:Array<FunkinLua> = [];

	public static var ps_instance:PlayState;
	public static var instance:StageEditor;
	public static var curStage:String = 'kidbackground';

	public var camGame:FlxCamera;

	public var camFollow:FlxObject;

	public var camPosBF:Array<Float>; // Optional focus point
	public var camPosGF:Array<Float>; // The point we should focus on by default
	public var camPosDad:Array<Float>; // Optional focus point

	public var charMap:FlxTypedGroup<Character>;
	public var modchartSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();

	override function create()
	{
		// some null fixes so the stage files can be loaded correctly
		if (PlayState.instance != null)
			ps_instance = PlayState.instance;
		else
			ps_instance = new PlayState();

		instance = this; // For FunkinLua later

		if (PlayState.SONG == null)
			PlayState.SONG = Song.loadFromJson('test', 'test');

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		// Load stage JSON (stole from playstate :3)
		var stageData:StageFile = StageData.getStageFile(curStage);
		if (stageData == null)
		{ // Stage couldn't be found, create a dummy stage for preventing a crash
			stageData = {
				directory: "",
				defaultZoom: 0.9,
				isPixelStage: false,
				stageUI: "normal",

				boyfriend: [770, 100],
				girlfriend: [400, 130],
				opponent: [100, 100],
				hide_girlfriend: false,

				camera_boyfriend: [0, 0],
				camera_opponent: [0, 0],
				camera_girlfriend: [0, 0],
				camera_speed: 1
			};
		}

		// Too lazy to have 3 seperate character variables.
		charMap = new FlxTypedGroup<Character>();

		var bf:Boyfriend = new Boyfriend(stageData.boyfriend[0], stageData.boyfriend[1]);
		charMap.add(bf);

		var gf:Character = new Character(stageData.girlfriend[0], stageData.girlfriend[1], 'gf');
		charMap.add(gf);

		var dad:Character = new Character(stageData.opponent[0], stageData.opponent[1], 'dad');
		charMap.add(dad);

		for (key in Reflect.fields(this))
		{
			if (key.startsWith('camPos'))
			{
				switch (key.replace('camPos', ''))
				{
					case 'BF':
						Reflect.setField(this, key, stageData.camera_boyfriend);
						// I Think this is similar to how PlayState does it??????
						camPosBF[0] += bf.cameraPosition[0];
						camPosBF[1] += bf.cameraPosition[1];
					case 'GF':
						Reflect.setField(this, key, stageData.camera_girlfriend);
						camPosGF[0] += gf.cameraPosition[0];
						camPosGF[1] += gf.cameraPosition[1];
					case 'Dad':
						Reflect.setField(this, key, stageData.camera_opponent);
						camPosDad[0] += dad.cameraPosition[0];
						camPosDad[1] += dad.cameraPosition[1];
				}
			}
		}

		camFollow = new FlxObject(camPosGF[0], camPosGF[1]);
		camGame.follow(camFollow, LOCKON, 0); // Proper follow fix

		#if (MODS_ALLOWED && LUA_ALLOWED)
		var doPush:Bool = false;
		var luaFile:String = 'stages/' + curStage + '.lua';
		if (FileSystem.exists(Paths.modFolders(luaFile)))
		{
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		}
		else
		{
			luaFile = Paths.getPreloadPath(luaFile);
			if (doPush)
			{
				luaArray.push(new FunkinLua(luaFile, true));
			}
		}

		if (doPush)
			luaArray.push(new FunkinLua(luaFile, true));
		#end

		var tabs = [{name: "Stage", label: "Stage"}];

		UI_Box = new FlxUITabMenu(null, tabs, true);
		UI_Box.resize(300, 300);
		UI_Box.x = FlxG.width - 400;
		UI_Box.y = 25;
		add(UI_Box);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			MusicBeatState.switchState(new MasterEditorMenu());
		}
		if (FlxG.keys.justPressed.TAB)
		{
			UI_Box.visible != UI_Box.visible;
		}
		super.update(elapsed);
	}

	// Stolen from PlayState.
	override public function getLuaObject(tag:String, text:Bool = true):FlxSprite
	{
		if (modchartSprites.exists(tag))
			return modchartSprites.get(tag);
		if (variables.exists(tag))
			return variables.get(tag);
		return null;
	}
}
