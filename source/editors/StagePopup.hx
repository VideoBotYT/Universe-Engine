package editors;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class StagePopup extends MusicBeatState
{
    var stageInfo:FlxText;
	override function create()
	{
		stageInfo = new FlxText(0, 0, FlxG.width, "Hi, \n\n Sorry but the Stage Editor is in the works. \n In a later SnapShot the Stage Editor will hopefully be a thing. \n\n Thank you for your patience \n\n Press ACCEPT/BACK to go back.", 32);
		stageInfo.setFormat(Paths.font('funkin.ttf'), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		stageInfo.screenCenter(Y);
		add(stageInfo);
		super.create();
	}

    override function update(elapsed:Float)
    {
        if (controls.BACK || controls.ACCEPT)
        {
            FlxG.sound.play(Paths.sound("confirmMenu"));
            FlxG.sound.playMusic(Paths.music("freakyMenu-" + ClientPrefs.mmm));
            MusicBeatState.switchState(new MasterEditorMenu());
        }
        super.update(elapsed);
    }
}
