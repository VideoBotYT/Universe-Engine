package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.sound.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end
import flixel.tweens.FlxEase;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
// search bar
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIInputText;
import haxe.Json;
import flixel.util.FlxTimer;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;

	private static var curSelected:Int = 0;

	var curDifficulty:Int = -1;

	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;

	var lerpScore:Int = 0;
	var lerpMisses:Int = 0;
	var lerpRating:Float = 0;

	var intendedScore:Int = 0;
	var intendedMisses:Int = 0;
	var intendedRating:Float = 0;

	var theXthinglmao:Int = 360;
	var theYthinglmao:Int = 35;

	var searchText:FlxText;
	var songSearchText:FlxUIInputText;
	var buttonTop:FlxButton;

	private var grpIcons:FlxTypedGroup<HealthIcon>;
	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;

	public var cheatText:FlxText = new FlxText(FlxG.width / 2 - 100, FlxG.height - 92, 0, "Scores won't save because of cheating", 32);

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length)
		{
			if (weekIsLocked(WeekData.weeksList[i]))
				continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			if (leWeek.icons == null)
				leWeek.icons = [];

			for (song in 0...leWeek.songs.length)
				leWeek.icons.push({animIcon: false, idle: null, lose: null});

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			var songNum:Int = -1;
			for (song in leWeek.songs)
			{
				songNum++;
				var colors:Array<Int> = song[2];
				if (colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				if (leWeek.icons[songNum] == null)
					leWeek.icons[songNum] = {animIcon: false, idle: null, lose: null};

				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), leWeek.icons[songNum]);
			}
		}
		WeekData.loadTheFirstEnabledMod();

		/*//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

			var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
			for (i in 0...initSonglist.length)
			{
				if(initSonglist[i] != null && initSonglist[i].length > 0) {
					var songArray:Array<String> = initSonglist[i].split(":");
					addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
				}
		}*/

		if (ClientPrefs.data.darkmode)
		{
			bg = new FlxSprite(0, 0).loadGraphic(Paths.image("aboutMenu", "preload"));
			bg.antialiasing = ClientPrefs.data.globalAntialiasing;
			add(bg);
			bg.screenCenter();
		}
		else
		{
			bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
			bg.antialiasing = ClientPrefs.data.globalAntialiasing;
			add(bg);
			bg.screenCenter();
		}

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(40, 20);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);

		if (ClientPrefs.data.mmm == "Normal Collections")
		{
			var square1:FlxBackdrop = new FlxBackdrop(Paths.image("title/SQUARE"));
			square1.alpha = 0.5;
			square1.velocity.set(0, 50);
			add(square1);

			var square2:FlxBackdrop = new FlxBackdrop(Paths.image("title/SQUARE"));
			square2.angle = 180;
			square2.alpha = 0.5;
			square2.velocity.set(0, -50);
			add(square2);

			var bgoverlay:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('overlay', "preload"));
			bgoverlay.alpha = 0.5;
			bgoverlay.antialiasing = ClientPrefs.data.globalAntialiasing;
			bgoverlay.screenCenter();
			bgoverlay.x = bgoverlay.x - 250;
			add(bgoverlay);

			var bgoverlay2:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('overlay', "preload"));
			bgoverlay2.alpha = 0.5;
			bgoverlay2.antialiasing = ClientPrefs.data.globalAntialiasing;
			bgoverlay2.screenCenter();
			add(bgoverlay2);
		}

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);
		grpIcons = new FlxTypedGroup<HealthIcon>();
		add(grpIcons);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(90, 320, songs[i].songName, true);
			songText.isMenuItem = true;
			songText.targetY = i - curSelected;
			songText.targetX = i + curSelected;
			if (ClientPrefs.data.fm)
			{
				songText.x = 320;
			}
			grpSongs.add(songText);

			var maxWidth = 980;
			if (songText.width > maxWidth)
			{
				songText.scaleX = maxWidth / songText.width;
			}

			/*Paths.currentModDirectory = songs[i].folder;
				var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
				icon.sprTracker = songText;

				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon); */

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			checkForAnimIcon(icon, i);
			icon.sprTracker = songText;
			icon.ID = i;
			grpIcons.add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		if (ClientPrefs.data.mmm != "Normal Collections")
		{
			scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
			scoreText.setFormat(Paths.font("funkin.ttf"), 32, FlxColor.WHITE, RIGHT);

			scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
			scoreBG.alpha = 0.6;
			add(scoreBG);
		}
		else
		{
			scoreText = new FlxText(1280 / 2 + theXthinglmao, 720 / 2 - theYthinglmao, 0, "SCORE: 0\nMISSES: 0\nRATING: 0.00%", 20);
			scoreText.setFormat(Paths.font("funkin.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

			scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
			scoreBG.alpha = 0;
			add(scoreBG);
		}

		if (ClientPrefs.data.mmm == "Normal Collections")
		{
			diffText = new FlxText(scoreText.x, scoreText.y + 70, 0, "", 24);
		}
		else
		{
			diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		}
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		if (curSelected >= songs.length)
			curSelected = 0;
		bg.color = songs[curSelected].color;
		intendedColor = bg.color;

		if (lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		songSearchText = new FlxUIInputText(0, scoreBG.y + scoreBG.height + 5, 500, '', 16);
		songSearchText.x = FlxG.width - songSearchText.width;
		add(songSearchText);

		buttonTop = new FlxButton(0, songSearchText.y + songSearchText.height + 5, "", function()
		{
			checkForSongsThatMatch(songSearchText.text);
		});
		buttonTop.setGraphicSize(Std.int(songSearchText.width), 50);
		buttonTop.updateHitbox();
		buttonTop.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, RIGHT);
		buttonTop.x = FlxG.width - buttonTop.width;
		add(buttonTop);

		searchText = new FlxText(975, 110, 100, "Search", 24);
		searchText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK);
		add(searchText);

		changeSelection();
		changeDiff();

		FlxG.mouse.visible = true;

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("funkin.ttf"), size, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		add(text);

		cheatText.scrollFactor.set();
		cheatText.setFormat(Paths.font("funkin.ttf"), 32, FlxColor.WHITE, CENTER);
		add(cheatText);
		cheatText.alpha = 0;

		super.create();
	}

	function checkForAnimIcon(leHealthIcon:HealthIcon, index:Int)
	{
		var value = songs[index].icons.animIcon;

		if (value)
		{
			try
			{
				@:privateAccess {
					leHealthIcon.char = '';
				} // Stupid bugfix pt.2

				leHealthIcon.changeIcon(songs[index].songCharacter);

				leHealthIcon.frames = Paths.getSparrowAtlas(leHealthIcon.imageFile);

				leHealthIcon.animation.addByPrefix('idle', songs[index].icons.idle, 24, true);

				leHealthIcon.animation.addByPrefix('losing', songs[index].icons.lose, 24, true);

				leHealthIcon.animation.play('idle');

				leHealthIcon.offset.set(0, 0);

				@:privateAccess {
					leHealthIcon.iconOffsets = [0, 0];
				}

				if (!value)
				{ // Stupid bugfix.

					@:privateAccess {
						leHealthIcon.char = '';
					} // Stupid bugfix pt.2

					leHealthIcon.changeIcon(songs[index].songCharacter);
				}
			}
			catch (e:Dynamic)
			{
				trace('Icon does not have an XML!');

				@:privateAccess {
					leHealthIcon.char = '';
				} // Stupid bugfix pt.2

				leHealthIcon.changeIcon(songs[index].songCharacter);
			}
		}
		else
		{
			@:privateAccess {
				leHealthIcon.char = '';
			} // Stupid bugfix pt.2

			leHealthIcon.changeIcon(songs[index].songCharacter);
		}
	}

	function checkForSongsThatMatch(?start:String = '')
	{
		var foundSongs:Int = 0;
		final txt:FlxText = new FlxText(0, 0, 0, 'No songs found matching your query', 16);
		txt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		txt.scrollFactor.set();
		txt.screenCenter(XY);
		for (i in 0...WeekData.weeksList.length)
		{
			if (weekIsLocked(WeekData.weeksList[i]))
				continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			for (song in leWeek.songs)
			{
				if (start != null && start.length > 0)
				{
					var songName = song[0].toLowerCase();
					var s = start.toLowerCase();
					if (songName.indexOf(s) != -1)
						foundSongs++;
				}
			}
		}
		if (foundSongs > 0 || start == '')
		{
			if (txt != null)
				remove(txt); // don't do destroy/kill on this btw
			regenerateSongs(start);
		}
		else if (foundSongs <= 0)
		{
			add(txt);
			new FlxTimer().start(5, function(timer)
			{
				if (txt != null)
					remove(txt);
			});
			return;
		}
	}

	function regenerateSongs(?start:String = '')
	{
		songs = [];
		for (i in 0...WeekData.weeksList.length)
		{
			if (weekIsLocked(WeekData.weeksList[i]))
				continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}
			WeekData.setDirectoryFromWeek(leWeek);
			if (leWeek.icons == null)
				leWeek.icons = [];

			for (song in 0...leWeek.songs.length)
				leWeek.icons.push({animIcon: false, idle: null, lose: null});

			var songNum:Int = -1;
			for (song in leWeek.songs)
			{
				songNum++;
				var colors:Array<Int> = song[2];
				if (colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				if (start != null && start.length > 0)
				{
					var songName = song[0].toLowerCase();
					var s = start.toLowerCase();
					if (songName.indexOf(s) != -1)
						addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), leWeek.icons[songNum]);
				}
				else
					addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), leWeek.icons[songNum]); // ??????????
			}
		}
		regenList();
	}

	override function closeSubState()
	{
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int, ?icons:Null<AnimIcon>)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color, icons));
	}

	function weekIsLocked(name:String):Bool
	{
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked
			&& leWeek.weekBefore.length > 0
			&& (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
		{
			if (songCharacters == null)
				songCharacters = ['bf'];

			var num:Int = 0;
			for (song in songs)
			{
				addSong(song, weekNum, songCharacters[num]);
				this.songs[this.songs.length-1].color = weekColor;

				if (songCharacters.length != 1)
					num++;
			}
	}*/
	function regenList()
	{
		grpSongs.forEach(song ->
		{
			grpSongs.remove(song, true);
			song.destroy();
		});
		grpIcons.forEach(icon ->
		{
			grpIcons.remove(icon, true);
			icon.destroy();
		});

		// we clear the remaining ones
		grpSongs.clear();
		grpIcons.clear();

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(90, 320, songs[i].songName, true);
			songText.isMenuItem = true;
			songText.targetY = i - curSelected;
			grpSongs.add(songText);

			var maxWidth = 980;
			if (songText.width > maxWidth)
			{
				songText.scaleX = maxWidth / songText.width;
			}
			songText.snapToPosition();

			Paths.currentModDirectory = songs[i].folder;

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;
			icon.ID = i;
			grpIcons.add(icon);
		}

		changeSelection();
		changeDiff();
	}

	var instPlaying:Int = -1;

	public static var vocals:FlxSound = null;

	var holdTime:Float = 0;

	override function update(elapsed:Float)
	{
		var bot:Bool = ClientPrefs.data.gameplaySettings.get('botplay');
		var practice:Bool = ClientPrefs.data.gameplaySettings.get('practice');

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpMisses = Math.floor(FlxMath.lerp(lerpMisses, intendedMisses, CoolUtil.boundTo(elapsed * 10, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpMisses - intendedMisses) <= 10)
			lerpMisses = intendedMisses;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if (ratingSplit.length < 2)
		{ // No decimals, add an empty space
			ratingSplit.push('');
		}

		while (ratingSplit[1].length < 2)
		{ // Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		if (ClientPrefs.data.cm)
		{
			bg.color = 0xFFfd719b;
		}

		if (ClientPrefs.data.mmm == "Normal Collections")
		{
			scoreText.text = 'SCORE: ' + lerpScore + '\nMISSES: ' + lerpMisses + '\nRATING: ' + ratingSplit.join('.') + '%';
		}
		else
		{
			scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		}
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if (FlxG.keys.pressed.SHIFT)
			shiftMult = 3;

		if (bot || practice)
		{
			FlxTween.tween(cheatText, {alpha: 1}, 1);
		}
		else
		{
			FlxTween.tween(cheatText, {alpha: 0}, 1);
		}

		if (!songSearchText.hasFocus)
		{
			if (songs.length > 1)
			{
				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if (holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						changeDiff();
					}
				}

				if (FlxG.mouse.wheel != 0)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					changeSelection(-shiftMult * FlxG.mouse.wheel, false);
					changeDiff();
				}
			}

			if (controls.UI_LEFT_P)
				changeDiff(-1);
			else if (controls.UI_RIGHT_P)
				changeDiff(1);
			else if (upP || downP)
				changeDiff();

			if (controls.BACK)
			{
				persistentUpdate = false;
				if (colorTween != null)
				{
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				if (ClientPrefs.data.fm)
				{
					MusicBeatState.switchState(new CoolMenuState());
				}
				else
				{
					MusicBeatState.switchState(new MainMenuState());
				}
			}

			if (ctrl)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if (space)
			{
				if (instPlaying != curSelected)
				{
					#if PRELOAD_ALL
					destroyFreeplayVocals();
					FlxG.sound.music.volume = 0;
					Paths.currentModDirectory = songs[curSelected].folder;
					var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
					// The following fixes both missing vocals AND crashing due to missing chart. ShadowMario TO THIS DAY has not fixed the freeplay missing chart crash error.
					try
					{
						PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
						if (PlayState.SONG.needsVoices)
						{
							try
							{
								vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
							}
							catch (e:Dynamic)
							{
								vocals = new FlxSound();
							}
						}
						else
						{
							vocals = new FlxSound();
						}

						FlxG.sound.list.add(vocals);
						FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
						vocals.play();
						vocals.persist = true;
						vocals.looped = true;
						vocals.volume = 0.7;
						instPlaying = curSelected;
					}
					catch (e:Dynamic)
					{
						trace('Error loading/playing file! $e');
						FlxG.sound.play(Paths.sound('cancelMenu'));
					}
					#end
				}
			}
			else if (accepted)
			{
				persistentUpdate = false;
				var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
				var poop:String = Highscore.formatSong(songLowercase, curDifficulty);

				try
				{
					PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				}
				catch (e:Dynamic)
				{
					lime.app.Application.current.window.alert('Error loading song!\n$e');
					return;
				}
				/*#if MODS_ALLOWED
					if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
					#else
					if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
					#end
						poop = songLowercase;
						curDifficulty = 1;
						trace('Couldnt find file');
				}*/
				trace(poop);

				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				if (colorTween != null)
				{
					colorTween.cancel();
				}

				if (FlxG.keys.pressed.SHIFT)
				{
					LoadingState.loadAndSwitchState(new ChartingState());
				}
				else
				{
					LoadingState.loadAndSwitchState(new PlayState());
				}

				FlxG.sound.music.volume = 0;

				destroyFreeplayVocals();
			}
			else if (controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter, songs[curSelected].icons));
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals()
	{
		if (vocals != null)
		{
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length - 1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedMisses = Highscore.getMisses(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if (playSound)
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		var newColor:Int = songs[curSelected].color;
		if (newColor != intendedColor)
		{
			if (colorTween != null)
			{
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween)
				{
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedMisses = Highscore.getMisses(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in grpIcons.members)
		{
			i.alpha = (i.ID == curSelected ? 1 : 0.6);
		}

		for (item in grpSongs.members)
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
			if (ClientPrefs.data.fm && item.targetY != 0)
			{
				item.targetX -= Std.int(Math.abs(item.targetY) * 10);
			}
		}

		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if (diffStr != null)
			diffStr = diffStr.trim(); // Fuck you HTML5

		if (diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if (diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if (diffs[i].length < 1)
						diffs.remove(diffs[i]);
				}
				--i;
			}

			if (diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}

		if (CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		// trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if (newPos > -1)
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore()
	{
		if (ClientPrefs.data.mmm != "Normal Collections")
		{
			scoreText.x = FlxG.width - scoreText.width - 6;

			scoreBG.scale.x = FlxG.width - scoreText.x + 6;
			scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
			diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
			diffText.x -= diffText.width / 2;
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var icons:Null<AnimIcon>;

	public function new(song:String, week:Int, songCharacter:String, color:Int, ?icons:Null<AnimIcon>)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		this.icons = icons;
		if (this.folder == null)
			this.folder = '';
	}
}
