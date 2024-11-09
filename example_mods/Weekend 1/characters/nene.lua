local abotBeatRandom1 = 1
local abotBeatRandom2 = 1
local abotBeatRandom3 = 1
local abotBeatRandom4 = 1
local abotBeatRandom5 = 1
local abotBeatRandom6 = 1
local abotBeatRandom7 = 1
local health = 1
local abotEyes = 0
local viz1Value = 1
local viz2Value = 1
local viz3Value = 1
local viz4Value = 1
local viz5Value = 1
local viz6Value = 1
local viz7Value = 1
local knifeUp = false

function onCreate()

	makeLuaSprite('abotEyeBack', 'empty', getProperty('gf.x') -80, getProperty('gf.y') +550);
	makeGraphic('abotEyeBack', 110, 70, 'FFFFFF');

	makeAnimatedLuaSprite('abotEyes', 'characters/abot/systemEyes', getProperty('gf.x') -76, getProperty('gf.y') +549)
	addAnimationByPrefix('abotEyes', 'l', 'Left', 24, false)
	addAnimationByPrefix('abotEyes', 'r', 'Right', 24, false)

	makeLuaSprite('abotBG', 'characters/abot/stereoBG', getProperty('gf.x') +18, getProperty('gf.y') +318);
	scaleObject('abotBG', 1.05, 1.05);

	makeAnimatedLuaSprite('abotViz1', 'aBotViz', getProperty('gf.x') +66, getProperty('gf.y') +390);
	addAnimationByPrefix('abotViz1', 'viz1', 'viz11', 24, false);
	addAnimationByPrefix('abotViz1', 'viz2', 'viz12', 24, false);
	addAnimationByPrefix('abotViz1', 'viz3', 'viz13', 24, false);
	addAnimationByPrefix('abotViz1', 'viz4', 'viz14', 24, false);
	addAnimationByPrefix('abotViz1', 'viz5', 'viz15', 24, false);
	addAnimationByPrefix('abotViz1', 'viz6', 'viz16', 24, false);
	setProperty('abotViz1.flipX', false);
	scaleObject('abotViz1', 1, 1);

	makeAnimatedLuaSprite('abotViz2', 'aBotViz', getProperty('gf.x') +128, getProperty('gf.y') +383);
	addAnimationByPrefix('abotViz2', 'viz1', 'viz21', 24, false);
	addAnimationByPrefix('abotViz2', 'viz2', 'viz22', 24, false);
	addAnimationByPrefix('abotViz2', 'viz3', 'viz23', 24, false);
	addAnimationByPrefix('abotViz2', 'viz4', 'viz24', 24, false);
	addAnimationByPrefix('abotViz2', 'viz5', 'viz25', 24, false);
	addAnimationByPrefix('abotViz2', 'viz6', 'viz26', 24, false);
	setProperty('abotViz2.flipX', false);
	scaleObject('abotViz2', 1, 1);

	makeAnimatedLuaSprite('abotViz3', 'aBotViz', getProperty('gf.x') +185, getProperty('gf.y') +380);
	addAnimationByPrefix('abotViz3', 'viz1', 'viz31', 24, false);
	addAnimationByPrefix('abotViz3', 'viz2', 'viz32', 24, false);
	addAnimationByPrefix('abotViz3', 'viz3', 'viz33', 24, false);
	addAnimationByPrefix('abotViz3', 'viz4', 'viz34', 24, false);
	addAnimationByPrefix('abotViz3', 'viz5', 'viz35', 24, false);
	addAnimationByPrefix('abotViz3', 'viz6', 'viz36', 24, false);
	setProperty('abotViz3.flipX', false);
	scaleObject('abotViz3', 1, 1);

	makeAnimatedLuaSprite('abotViz4', 'aBotViz', getProperty('gf.x') +251, getProperty('gf.y') +380);
	addAnimationByPrefix('abotViz4', 'viz1', 'viz41', 24, false);
	addAnimationByPrefix('abotViz4', 'viz2', 'viz42', 24, false);
	addAnimationByPrefix('abotViz4', 'viz3', 'viz43', 24, false);
	addAnimationByPrefix('abotViz4', 'viz4', 'viz44', 24, false);
	addAnimationByPrefix('abotViz4', 'viz5', 'viz45', 24, false);
	addAnimationByPrefix('abotViz4', 'viz6', 'viz46', 24, false);
	setProperty('abotViz4.flipX', false);
	scaleObject('abotViz4', 1, 1);

	makeAnimatedLuaSprite('abotViz5', 'aBotViz', getProperty('gf.x') +308, getProperty('gf.y') +380);
	addAnimationByPrefix('abotViz5', 'viz1', 'viz51', 24, false);
	addAnimationByPrefix('abotViz5', 'viz2', 'viz52', 24, false);
	addAnimationByPrefix('abotViz5', 'viz3', 'viz53', 24, false);
	addAnimationByPrefix('abotViz5', 'viz4', 'viz54', 24, false);
	addAnimationByPrefix('abotViz5', 'viz5', 'viz55', 24, false);
	addAnimationByPrefix('abotViz5', 'viz6', 'viz56', 24, false);
	setProperty('abotViz5.flipX', false);
	scaleObject('abotViz5', 1, 1);

	makeAnimatedLuaSprite('abotViz6', 'aBotViz', getProperty('gf.x') +364, getProperty('gf.y') +385);
	addAnimationByPrefix('abotViz6', 'viz1', 'viz61', 24, false);
	addAnimationByPrefix('abotViz6', 'viz2', 'viz62', 24, false);
	addAnimationByPrefix('abotViz6', 'viz3', 'viz63', 24, false);
	addAnimationByPrefix('abotViz6', 'viz4', 'viz64', 24, false);
	addAnimationByPrefix('abotViz6', 'viz5', 'viz65', 24, false);
	addAnimationByPrefix('abotViz6', 'viz6', 'viz66', 24, false);
	setProperty('abotViz6.flipX', false);
	scaleObject('abotViz6', 1, 1);

	makeAnimatedLuaSprite('abotViz7', 'aBotViz', getProperty('gf.x') +416, getProperty('gf.y') +393);
	addAnimationByPrefix('abotViz7', 'viz1', 'viz71', 24, false);
	addAnimationByPrefix('abotViz7', 'viz2', 'viz72', 24, false);
	addAnimationByPrefix('abotViz7', 'viz3', 'viz73', 24, false);
	addAnimationByPrefix('abotViz7', 'viz4', 'viz74', 24, false);
	addAnimationByPrefix('abotViz7', 'viz5', 'viz75', 24, false);
	addAnimationByPrefix('abotViz7', 'viz6', 'viz76', 24, false);
	setProperty('abotViz7.flipX', false);
	scaleObject('abotViz7', 1, 1);

	makeAnimatedLuaSprite('abot', 'characters/abot/abotSystem', getProperty('gf.x') -135, getProperty('gf.y') +310)
	addAnimationByPrefix('abot', 'i', 'Abot System', 24, false)
	setProperty('abot.alpha', 1);

	addLuaSprite('abotEyeBack', false);
	addLuaSprite('abotEyes', false);
	addLuaSprite('abotBG', false);
	addLuaSprite('abotViz1', false);
	addLuaSprite('abotViz2', false);
	addLuaSprite('abotViz3', false);
	addLuaSprite('abotViz4', false);
	addLuaSprite('abotViz5', false);
	addLuaSprite('abotViz6', false);
	addLuaSprite('abotViz7', false);
	addLuaSprite('abot', false);

end

function onUpdate()
	playAnim('abotViz1', 'viz'..viz1Value);
	playAnim('abotViz2', 'viz'..viz2Value); 
	playAnim('abotViz3', 'viz'..viz3Value); 
	playAnim('abotViz4', 'viz'..viz4Value); 
	playAnim('abotViz5', 'viz'..viz5Value);
	playAnim('abotViz6', 'viz'..viz6Value); 
	playAnim('abotViz7', 'viz'..viz7Value);
	if songName ~= "Blazin'" then
		if getProperty('health') <= 0.25 and not knifeUp then
			knifeUp = true
			playAnim('gf', 'raiseKnife', false);
			runTimer('raiseKnifeAnim', (1/24)*19);
			triggerEvent('Alt Idle Animation', 'gf', '-alt')
		elseif getProperty('health') >= 0.251 and knifeUp then
			knifeUp = false
			triggerEvent('Alt Idle Animation', 'gf', '')
			playAnim('gf', 'lowerKnife', false);
			setProperty('gf.specialAnim', true);
		end
	end
end

function onBeatHit()
	playAnim('abot', 'i');
	if curBeat %2 == 0 then
	end
end

function onStepHit()
	abotBeatRandom1 = getRandomInt(1,5);
	abotBeatRandom2 = getRandomInt(1,5);
	abotBeatRandom3 = getRandomInt(1,5);
	abotBeatRandom4 = getRandomInt(1,5);
	abotBeatRandom5 = getRandomInt(1,5);
	abotBeatRandom6 = getRandomInt(1,5);
	abotBeatRandom7 = getRandomInt(1,5);
	if abotBeatRandom1 <= 1 and viz1Value <= 5 then
		viz1Value = viz1Value + getRandomInt(1,2)
	elseif abotBeatRandom1 == 5 and viz1Value >= 1 or abotBeatRandom1 >= 2 and viz1Value >= 6 then
		viz1Value = viz1Value - getRandomInt(1,2)
	end
	if abotBeatRandom2 <= 1 and viz2Value <= 5 then
		viz2Value = viz2Value + getRandomInt(1,2)
	elseif abotBeatRandom2 == 5 and viz2Value >= 1 or abotBeatRandom2 >= 2 and viz2Value >= 6 then
		viz2Value = viz2Value - getRandomInt(1,2)
	end
	if abotBeatRandom3 <= 1 and viz3Value <= 5 then
		viz3Value = viz3Value + getRandomInt(1,2)
	elseif abotBeatRandom3 == 5 and viz3Value >= 1 or abotBeatRandom3 >= 2 and viz3Value >= 6 then
		viz3Value = viz3Value - getRandomInt(1,2)
	end
	if abotBeatRandom4 <= 1 and viz4Value <= 5 then
		viz4Value = viz4Value + getRandomInt(1,2)
	elseif abotBeatRandom4 == 5 and viz4Value >= 1 or abotBeatRandom4 >= 2 and viz4Value >= 6 then
		viz4Value = viz4Value - getRandomInt(1,2)
	end
	if abotBeatRandom5 <= 1 and viz5Value <= 5 then
		viz5Value = viz5Value + getRandomInt(1,2)
	elseif abotBeatRandom5 == 5 and viz5Value >= 1 or abotBeatRandom5 >= 2 and viz5Value >= 6 then
		viz5Value = viz5Value - getRandomInt(1,2)
	end
	if abotBeatRandom6 <= 1 and viz6Value <= 5 then
		viz6Value = viz6Value + getRandomInt(1,2)
	elseif abotBeatRandom6 == 5 and viz6Value >= 1 or abotBeatRandom6 >= 2 and viz6Value >= 6 then
		viz6Value = viz6Value - getRandomInt(1,2)
	end 
	if abotBeatRandom7 <= 1 and viz7Value <= 5 then
		viz7Value = viz7Value + getRandomInt(1,2)
	elseif abotBeatRandom7 == 5 and viz7Value >= 1 or abotBeatRandom7 >= 2 and viz7Value >= 6 then
		viz7Value = viz7Value - getRandomInt(1,2)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'abotEyesLeft1' and abotEyes == 1 then
		abotEyes = 0
		playAnim('abotEyes', 'l');
		doTweenX("abotEyesX", 'abotEyes', getProperty('gf.x') -96, 0.1, 'cubeOut')
		doTweenY("abotEyesY", 'abotEyes', getProperty('gf.y') +552, 0.1, 'cubeOut')
	end
	if tag == 'abotEyesRight1' and abotEyes == 0 then
		abotEyes = 1
		playAnim('abotEyes', 'r');
		doTweenX("abotEyesX", 'abotEyes', getProperty('gf.x') -76, 0.1, 'cubeOut')
		doTweenY("abotEyesY", 'abotEyes', getProperty('gf.y') +549, 0.1, 'cubeOut')
	end
end

function onMoveCamera(focus)
	if focus == 'dad' then
		runTimer('abotEyesLeft1', 0.2);
	elseif focus == 'boyfriend' or 'gf' then
		runTimer('abotEyesRight1', 0.2);
	end
end

function onEvent(name, value1, value2)
    if name == 'Focus Camera' then
        if value1 == '1' then
			runTimer('abotEyesLeft1', 0.2);
        elseif value1 == '2' or '3' then
			runTimer('abotEyesRight1', 0.2);
        end
    end
end