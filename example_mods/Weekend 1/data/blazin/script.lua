function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'pico-blazin-dead')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'gameplay/gameover/fnf_loss_sfx-pico-gutpunch')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameplay/gameover/gameOver-pico')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameplay/gameover/gameOverEnd-pico')
	setPropertyFromClass('PauseSubState', 'songName', 'breakfast-pico/breakfast-pico')
	
	makeLuaSprite('cutsceneCrutchBlack', 'empty', 0, 0);
	makeGraphic('cutsceneCrutchBlack', 3000, 2000, '000000');
	setObjectCamera('cutsceneCrutchBlack', 'other');
end

local video = true

function onEndSong()
	if video and isStoryMode then
		startVideo('blazinCutscene');
		addLuaSprite('cutsceneCrutchBlack', true);
		video = false
		return Function_Stop;
	end
	return Function_Continue;
end

function onUpdate()
	noteTweenAlpha("NoteAlpha1", 0, 0, 0.01, "linear")
	noteTweenAlpha("NoteAlpha2", 1, 0, 0.01, "linear")
	noteTweenAlpha("NoteAlpha3", 2, 0, 0.01, "linear")
	noteTweenAlpha("NoteAlpha4", 3, 0, 0.01, "linear")
	
	noteTweenX("NoteMove5", 4, 412, 0.01, cubeInOut)
	noteTweenX("NoteMove6", 5, 524, 0.01, cubeInOut)
	noteTweenX("NoteMove7", 6, 636, 0.01, cubeInOut)
	noteTweenX("NoteMove8", 7, 748, 0.01, cubeInOut)
end