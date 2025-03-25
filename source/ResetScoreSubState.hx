import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import WeekData.AnimIcon;

using StringTools;

class ResetScoreSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var icon:HealthIcon;
	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	var song:String;
	var difficulty:Int;
	var week:Int;
	var iconOptions:AnimIcon;

	// Week -1 = Freeplay
	public function new(song:String, difficulty:Int, character:String, week:Int = -1, ?icons:AnimIcon)
	{
		this.song = song;
		this.difficulty = difficulty;
		this.week = week;
		iconOptions = icons;

		super();

		var name:String = song;
		if (week > -1)
		{
			name = WeekData.weeksLoaded.get(WeekData.weeksList[week]).weekName;
		}
		name += ' (' + CoolUtil.difficulties[difficulty] + ')?';

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var tooLong:Float = (name.length > 18) ? 0.8 : 1; // Fucking Winter Horrorland
		var text:Alphabet = new Alphabet(0, 180, "Reset the score of", true);
		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);
		var text:Alphabet = new Alphabet(0, text.y + 90, name, true);
		text.scaleX = tooLong;
		text.screenCenter(X);
		if (week == -1)
			text.x += 60 * tooLong;
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);
		if (week == -1)
		{
			icon = new HealthIcon(character);
			icon.setGraphicSize(Std.int(icon.width * tooLong));
			icon.updateHitbox();
			icon.setPosition(text.x - icon.width + (10 * tooLong), text.y - 30);
			icon.alpha = 0;
			add(icon);
			if (icons != null)
				animIconCallback(icons, icon, character, text, tooLong);
		}

		yesText = new Alphabet(0, text.y + 150, 'Yes', true);
		yesText.screenCenter(X);
		yesText.x -= 200;
		add(yesText);
		noText = new Alphabet(0, text.y + 150, 'No', true);
		noText.screenCenter(X);
		noText.x += 200;
		add(noText);
		updateOptions();
	}

	function animIconCallback(icons:AnimIcon, leHealthIcon:HealthIcon, character:String, text:Alphabet, tooLong:Float)
	{
		var value:Bool = icons.animIcon;

		if (value)
		{
			try
			{
				@:privateAccess {
					leHealthIcon.char = '';
				} // Stupid bugfix pt.2

				leHealthIcon.changeIcon(character);

				leHealthIcon.frames = Paths.getSparrowAtlas(leHealthIcon.imageFile);

				leHealthIcon.animation.addByPrefix('idle', icons.idle, 24, true);

				leHealthIcon.animation.addByPrefix('losing', icons.lose, 24, true);

				leHealthIcon.animation.play('idle');

				leHealthIcon.offset.set(0, 0);

				@:privateAccess {
					leHealthIcon.iconOffsets = [0, 0];
				}

				leHealthIcon.updateHitbox();

				leHealthIcon.x = text.x - icon.width + (10 * tooLong);

				if (!value)
				{ // Stupid bugfix.

					@:privateAccess {
						leHealthIcon.char = '';
					} // Stupid bugfix pt.2

					leHealthIcon.changeIcon(character);
				}
			}
			catch (e:Dynamic)
			{
				trace('Icon does not have an XML!');

				@:privateAccess {
					leHealthIcon.char = '';
				} // Stupid bugfix pt.2

				leHealthIcon.changeIcon(character);
			}
		}
		else
		{
			@:privateAccess {
				leHealthIcon.char = '';
			} // Stupid bugfix pt.2

			leHealthIcon.changeIcon(character);
		}
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if (bg.alpha > 0.6)
			bg.alpha = 0.6;

		for (i in 0...alphabetArray.length)
		{
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}
		if (week == -1)
			icon.alpha += elapsed * 2.5;

		if (controls.UI_LEFT_P || controls.UI_RIGHT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		}
		else if (controls.ACCEPT)
		{
			if (onYes)
			{
				if (week == -1)
				{
					Highscore.resetSong(song, difficulty);
				}
				else
				{
					Highscore.resetWeek(WeekData.weeksList[week], difficulty);
				}
			}
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		}
		super.update(elapsed);
	}

	function updateOptions()
	{
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
		if (!iconOptions.animIcon)
			if (week == -1)
				icon.animation.curAnim.curFrame = confirmInt;
			else
				switch (confirmInt)

				{
					case 0:
						icon.animation.play(iconOptions.idle);

					case 1:
						icon.animation.play(iconOptions.lose);
				}
	}
}
