local cutscene = true
local neneIdle = true
local video = true

function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'pico-dead')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pico')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameplay/gameover/gameOver-pico')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameplay/gameover/gameOverEnd-pico')
	setPropertyFromClass('PauseSubState', 'songName', 'breakfast-pico/breakfast-pico')
	
	makeAnimatedLuaSprite('PicoBullet', 'PicoBullet', 2100, 850);
	addAnimationByPrefix('PicoBullet', 'Pop', 'Pop', 24, false);
	setProperty('PicoBullet.flipX', false);
	scaleObject('PicoBullet', 1, 1);
	setScrollFactor('PicoBullet', 1, 1);
	setProperty('PicoBullet.alpha', 1);


	makeLuaSprite('cutsceneShootBlack', 'empty', 0, 0);
	makeGraphic('cutsceneShootBlack', 3000, 2000, '000000');
	setProperty('cutsceneShootBlack.alpha', 0);
	addLuaSprite('cutsceneShootBlack', false);

	makeLuaSprite('cutsceneOpenBlack', 'empty', 0, 0);
	makeGraphic('cutsceneOpenBlack', 1280, 720, '000000');
	setObjectCamera('cutsceneOpenBlack', 'other');
	setProperty('cutsceneOpenBlack.alpha', 1);
	
	if cutscene and isStoryMode and not seenCutscene then
		addLuaSprite('cutsceneOpenBlack', true);
	else
		triggerEvent("Change Character", 'bf', 'pico-playable')
	end
end

function onStartCountdown()
	if cutscene and isStoryMode and not seenCutscene then
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('scoreTxt.visible', false);
		triggerEvent('Camera Follow Pos', 2050, 900)
		if video then
			startVideo('darnellCutscene');
			runTimer('video', 87); --86
			video = false
		end
		return Function_Stop;
	end
	if not cutscene then
		setProperty('healthBar.visible', true)
		setProperty('healthBarBG.visible', true)
		setProperty('iconP1.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('scoreTxt.visible', true);
		playAnim('boyfriend', 'return', false);
	runHaxeCode([[
	var cameraTwn:FlxTween;
			cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 0.77}, 2, {ease: FlxEase.sineInOut, onComplete:
				function (twn:FlxTween) {
					cameraTwn = null;
				}
			});
		]])
		return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'video' and cutscene then
		triggerEvent('Camera Follow Pos', 2050, 900)
		runTimer('videoWait', 2);
	end
	if tag == 'videoWait' and cutscene then
		playMusic('darnellCanCutscene/darnellCanCutscene', 1, false)
		runTimer('startSong', 9.2);
		runTimer('darnellAnim1', 4.2);
		runTimer('cameraTween', 1);
		runTimer('neneIdle1', 0.6);
		playAnim('gf', 'danceRight', false);
		playAnim('boyfriend', 'pissed', false);
		doTweenAlpha('cutsceneOpenBlack', 'cutsceneOpenBlack', 0, 1, 'linear')
		runHaxeCode([[
			FlxG.camera.zoom = 1.3
		]])
	end
	if tag == 'cameraTween' and cutscene then
		triggerEvent('Camera Follow Pos', 1500, 900)
		runHaxeCode([[
	var cameraTwn:FlxTween;
			cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 0.7}, 3, {ease: FlxEase.sineInOut, onComplete:
				function (twn:FlxTween) {
					cameraTwn = null;
				}
			});
		]])
	end
	if tag == 'neneIdle1' and cutscene and neneIdle == true then
		playAnim('gf', 'danceLeft', false);
		runTimer('neneIdle2', 0.6);
	end
	if tag == 'neneIdle2' and cutscene and neneIdle == true then
		playAnim('gf', 'danceRight', false);
		runTimer('neneIdle1', 0.6);
	end
	if tag == 'darnellAnim1' and cutscene then
		playAnim('dad', 'lightCan', false);
		playSound('Darnell_Lighter', 1)
		runTimer('picoAnim1', 1);
	end
	if tag == 'picoAnim1' and cutscene then
		triggerEvent('Camera Follow Pos', 1700, 900)
		playAnim('boyfriend', 'cock', false);
		playSound('Gun_Prep', 1)
		addLuaSprite('PicoBullet', true);
		runTimer('darnellAnim2', 0.3);
	end
	if tag == 'darnellAnim2' and cutscene then
		playAnim('dad', 'kickCan', false);
		playSound('Kick_Can_UP', 1)
		playAnim('cutsceneSpraycan', 'i', false);
		setProperty('cutsceneSpraycan.alpha', 1);
		runTimer('darnellAnim3', 0.3);
	end
	if tag == 'darnellAnim3' and cutscene then
		playAnim('dad', 'kneeCan', false);
		playSound('Kick_Can_FORWARD', 1)
		runTimer('picoAnim2', 0.3);
	end
	if tag == 'picoAnim2' and cutscene then
		triggerEvent('Camera Follow Pos', 1500, 900)
		setProperty('cutsceneShootBlack.alpha', 1);
		doTweenAlpha('cutsceneShootBlack', 'cutsceneShootBlack', 0, 1, 'linear')
		playAnim('boyfriend', 'return', false);
		playSound('shot'..getRandomInt(1, 3), 1)
		runTimer('cutsceneLaugh', 0.5);
		runTimer('picoReturn', (1/24)*139);
	end
	if tag == 'cutsceneLaugh' and cutscene then
		neneIdle = false
		playAnim('dad', 'laughCutscene', false);
		playAnim('gf', 'laughCutscene', false);
		playSound('cutscene/darnell_laugh', 1)
		playSound('cutscene/nene_laugh', 1)
	end
	if tag == 'startSong' and cutscene then
		cutscene = false
		startCountdown()
	end
	if tag == 'picoReturn' then
		triggerEvent("Change Character", 'bf', 'pico-playable')
	end
end

--TROLL THING

function onEndSong()
	makeLuaSprite('Error', 'TROLLING', 565, 300);
	setObjectCamera('Error', 'other');
	addLuaSprite('Error', true);
end