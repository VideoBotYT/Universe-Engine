function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'pico-dead')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pico')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameplay/gameover/gameOver-pico')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameplay/gameover/gameOverEnd-pico')
	setPropertyFromClass('PauseSubState', 'songName', 'breakfast-pico/breakfast-pico')
	
	makeLuaSprite('cutsceneCrutchBlack', 'empty', 0, 0);
	makeGraphic('cutsceneCrutchBlack', 3000, 2000, '000000');
	setObjectCamera('cutsceneCrutchBlack', 'other');

	makeLuaSprite('shootBlack', 'empty', 0, 0);
	makeGraphic('shootBlack', 3000, 2000, '000000');
	setProperty('shootBlack.alpha', 0);

	makeAnimatedLuaSprite('reloadEffect', 'characters/Pico_Playable', 1980, 755);
	addAnimationByPrefix('reloadEffect', 'cock', 'Pico Reload', 24, false);
	setProperty('reloadEffect.alpha', 0);

	makeLuaSprite('reloadEffectScale', 'empty', 1, 1);
	setProperty('reloadEffectScale.alpha', 0);
	
	makeAnimatedLuaSprite('spraypaintExplosionEZ', 'spraypaintExplosionEZ', 1600, 400);
	addAnimationByPrefix('spraypaintExplosionEZ', 'explosion', 'explosion round 1 short', 24, false);
	setProperty('spraypaintExplosionEZ.flipX', false);
	scaleObject('spraypaintExplosionEZ', 1, 1);
	setScrollFactor('spraypaintExplosionEZ', 1, 1);
	setProperty('spraypaintExplosionEZ.alpha', 0);

	addLuaSprite('shootBlack', false);
	addLuaSprite('reloadEffect', true);
	addLuaSprite('spraypaintExplosionEZ', true);
end

function onUpdate()
	setProperty('reloadEffect.scale.x', getProperty('reloadEffectScale.x'))
	setProperty('reloadEffect.scale.y', getProperty('reloadEffectScale.x'))
end

function onSongStart()
	setProperty('spraypaintExplosionEZ.alpha', 1);
	setProperty('Spraycan2.alpha', 1);
end

local video = true

function onEndSong()
	if video and isStoryMode then
		startVideo('2hotCutscene');
		addLuaSprite('cutsceneCrutchBlack', true);
		video = false
		return Function_Stop;
	end
	return Function_Continue;
end

local isGameOver = false
local darnellAnim = false
local picoAnim = false
local bullet = 0
local reload = false

--[[function onGameOver()
	runTimer('gameOverStart', 91/24);
	isGameOver = true
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'gameOverStart' and picoAnim then
		runHaxeCode([[
			boyfriend.playAnim('deathLoop');
		]]--)
	--end
--end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if direction == 1 and darnellAnim then
		playAnim('dad', 'lightCan', false);
		setProperty('dad.specialAnim', true);
	end
	if direction == 2 and darnellAnim then
		playAnim('dad', 'kickCan', false);
		setProperty('dad.specialAnim', true);
		playAnim('Spraycan1', 'start', false);
		setProperty('Spraycan1.alpha', 1);
	end
	if direction == 3 and darnellAnim then
		playAnim('dad', 'kneeCan', false);
		playAnim('Spraycan1', 'start1', false);
		setProperty('dad.specialAnim', true);
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if direction == 1 and picoAnim then
		reload = true
		bullet = bullet +1
		playAnim('boyfriend', 'cock', false);
		playAnim('reloadEffect', 'cock', false);
		setProperty('boyfriend.specialAnim', true);
		setProperty('reloadEffectScale.x', 1)
		doTweenX('reloadEffectScale', 'reloadEffectScale', 1.1, 0.3, 'linear')
		setProperty('reloadEffect.alpha', 0.5);
		doTweenAlpha('reloadEffect', 'reloadEffect', 0, 0.3, 'linear')
		playSound('Gun_Prep', 1);
		makeAnimatedLuaSprite('PicoBullet'..bullet, 'PicoBullet', 2150, 850);
		addAnimationByPrefix('PicoBullet'..bullet, 'Bullet', 'Bullet', 24, false);
		addAnimationByPrefix('PicoBullet'..bullet, 'Pop', 'Pop', 24, false);
		playAnim('PicoBullet'..bullet, 'Pop', false);
		scaleObject('PicoBullet'..bullet, 1, 1);
		setScrollFactor('PicoBullet'..bullet, 1, 1);
		addLuaSprite('PicoBullet'..bullet, false);
	end
	if direction == 0 and picoAnim and reload then
		reload = false
		playAnim('boyfriend', 'shoot', false);
		setProperty('boyfriend.specialAnim', true);
		playAnim('Spraycan1', 'shooted', false);
		playAnim('Spraycan2', 'i', false);
		setProperty('Spraycan1.alpha', 0);
		playSound('shot'..getRandomInt(1,3), 1);
		setProperty('shootBlack.alpha', 1);
		doTweenAlpha('shootBlack', 'shootBlack', 0, 1, 'linear')
	elseif direction == 0 and picoAnim and not reload then
		health = getProperty('health')
		playAnim('boyfriend', 'CanHit', false);
		setProperty('boyfriend.specialAnim', true);
		playAnim('Spraycan1', 'missed', false);
		setProperty('Spraycan1.alpha', 0);
		playAnim('spraypaintExplosionEZ', 'explosion', false);
		setProperty('health', health -0.5);
		playSound('Pico_Bonk', 1);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if direction == 0 and picoAnim then
		reload = false
		health = getProperty('health')
		playAnim('boyfriend', 'CanHit', false);
		setProperty('boyfriend.specialAnim', true);
		playAnim('Spraycan1', 'missed', false);
		setProperty('Spraycan1.alpha', 0);
		playAnim('spraypaintExplosionEZ', 'explosion', false);
		setProperty('health', health -0.5);
		playSound('Pico_Bonk', 1);
	end
end

function onStepHit()
	if curStep >= 108 and curStep <= 126 or curStep >= 492 and curStep <= 510 or curStep >= 620 and curStep <= 638 or curStep >= 972 and curStep <= 990 or curStep >= 1036 and curStep <= 1054 or curStep >= 1420 and curStep <= 1438 then
		darnellAnim = true
	else
		darnellAnim = false
	end
	if curStep >= 119 and curStep <= 126 or curStep >= 503 and curStep <= 510 or curStep >= 631 and curStep <= 638 or curStep >= 983 and curStep <= 990 or curStep >= 1047 and curStep <= 1054 or curStep >= 1431 and curStep <= 1438 then
		picoAnim = true
	else
		picoAnim = false
	end
	if curStep == 126 or curStep == 510 or curStep == 638 or curStep == 990 or curStep == 1054 or curStep == 1438 then
		doTweenX('PicoBulletTweenX'..bullet, 'PicoBullet'..bullet, 2149 +getRandomInt(1,51), 0.5, 'cubeOut')
	end
end