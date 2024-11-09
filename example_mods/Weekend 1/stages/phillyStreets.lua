function onCreate()
	makeLuaSprite('phillySkybox', 'phillyStreets/phillySkybox', -650, -375);
	setScrollFactor('phillySkybox', 0.1, 0.1);
	setProperty('phillySkybox.alpha', 1);

	makeLuaSprite('phillySkyline', 'phillyStreets/phillySkyline', -545, -273);
	scaleObject('phillySkyline', 1, 1);
	setScrollFactor('phillySkyline', 0.2, 0.2);
	setProperty('phillySkyline.alpha', 1);

	makeLuaSprite('phillyForegroundCity', 'phillyStreets/phillyForegroundCity', 625, 94);
	scaleObject('phillyForegroundCity', 1, 1);
	setScrollFactor('phillyForegroundCity', 0.3, 0.3);
	setProperty('phillyForegroundCity.alpha', 1);

	makeLuaSprite('phillyConstruction', 'phillyStreets/phillyConstruction', 1800, 364);
	scaleObject('phillyConstruction', 1, 1);
	setScrollFactor('phillyConstruction', 0.7, 1);
	setProperty('phillyConstruction.alpha', 1);

	makeLuaSprite('phillyHighwayLights', 'phillyStreets/phillyHighwayLights', 284, 305);
	scaleObject('phillyHighwayLights', 1, 1);
	setScrollFactor('phillyHighwayLights', 1, 1);
	setProperty('phillyHighwayLights.alpha', 1);

	makeLuaSprite('phillyHighwayLights_lightmap', 'phillyStreets/phillyHighwayLights_lightmap', 284, 305);
	scaleObject('phillyHighwayLights_lightmap', 1, 1);
	setScrollFactor('phillyHighwayLights_lightmap', 1, 1);
	setProperty('phillyHighwayLights_lightmap.alpha', 1);
	setBlendMode('phillyHighwayLights_lightmap','add')

	makeLuaSprite('phillyHighway', 'phillyStreets/phillyHighway', 139, 209);
	scaleObject('phillyHighway', 1, 1);
	setScrollFactor('phillyHighway', 1, 1);
	setProperty('phillyHighway.alpha', 1);

	makeLuaSprite('phillySmog', 'phillyStreets/phillySmog', -6, 245);
	scaleObject('phillySmog', 1, 1);
	setScrollFactor('phillySmog', 1, 1);
	setProperty('phillySmog.alpha', 1);

	makeAnimatedLuaSprite('phillyCars1', 'phillyStreets/phillyCars', 1748, 818);
	addAnimationByPrefix('phillyCars1', 'car1', 'car1', 24, false);
	addAnimationByPrefix('phillyCars1', 'car2', 'car2', 24, false);
	addAnimationByPrefix('phillyCars1', 'car3', 'car3', 24, false);
	addAnimationByPrefix('phillyCars1', 'car4', 'car4', 24, false);
	setProperty('phillyCars1.flipX', false);
	scaleObject('phillyCars1', 1, 1);
	setScrollFactor('phillyCars1', 1, 1);
	setProperty('phillyCars1.alpha', 1);

	makeAnimatedLuaSprite('phillyCars2', 'phillyStreets/phillyCars', 1748, 818);
	addAnimationByPrefix('phillyCars2', 'car1', 'car1', 24, false);
	addAnimationByPrefix('phillyCars2', 'car2', 'car2', 24, false);
	addAnimationByPrefix('phillyCars2', 'car3', 'car3', 24, false);
	addAnimationByPrefix('phillyCars2', 'car4', 'car4', 24, false);
	setProperty('phillyCars2.flipX', true);
	scaleObject('phillyCars2', 1, 1);
	setScrollFactor('phillyCars2', 1, 1);
	setProperty('phillyCars2.alpha', 1);

	makeAnimatedLuaSprite('phillyTraffic', 'phillyStreets/phillyTraffic', 1840, 608);
	addAnimationByPrefix('phillyTraffic', 'tored', 'greentored', 24, false);
	addAnimationByPrefix('phillyTraffic', 'togreen', 'redtogreen', 24, false);
	setProperty('phillyTraffic.flipX', false);
	scaleObject('phillyTraffic', 1, 1);
	setScrollFactor('phillyTraffic', 0.9, 1);
	setProperty('phillyTraffic.alpha', 1);
	runTimer('greentoredTimer', 11);
	playAnim('phillyTraffic', 'togreen', false);
	
	makeLuaSprite('phillyTraffic_lightmap', 'phillyStreets/phillyTraffic_lightmap', 1840, 608);
	scaleObject('phillyTraffic_lightmap', 1, 1);
	setScrollFactor('phillyTraffic_lightmap', 0.9, 1);
	setProperty('phillyTraffic_lightmap.alpha', 1);
	setBlendMode('phillyTraffic_lightmap','add')
	
	makeLuaSprite('phillyForeground', 'phillyStreets/phillyForeground', 88, 317);
	scaleObject('phillyForeground', 1, 1);
	setScrollFactor('phillyForeground', 1, 1);
	setProperty('phillyForeground.alpha', 1);

	makeAnimatedLuaSprite('Spraycan1', 'wked1_cutscene_1_can', 1000, 730)
	addAnimationByPrefix('Spraycan1', 'start', 'can kicked up', 24, false)
	addAnimationByPrefix('Spraycan1', 'start1', 'can kick quick', 10, false)
	setProperty('Spraycan1.alpha', 0);

	makeAnimatedLuaSprite('Spraycan2', 'SpraypaintExplosion', 1000, 100)
	addAnimationByPrefix('Spraycan2', 'i', 'Explosion 1 movie', 24, false)
	setProperty('Spraycan2.alpha', 0);
	
	makeLuaSprite('spraycanPile', 'SpraycanPile', 920, 1045);
	scaleObject('spraycanPile', 1, 1);
	setScrollFactor('spraycanPile', 1, 1);
	setProperty('spraycanPile.alpha', 1);

	addLuaSprite('phillySkybox', false);
	addLuaSprite('phillySkyline', false);
	addLuaSprite('phillyForegroundCity', false);
	addLuaSprite('phillyConstruction', false);
	addLuaSprite('phillyHighwayLights', false);
	addLuaSprite('phillyHighwayLights_lightmap', false);
	addLuaSprite('phillyHighway', false);
	addLuaSprite('phillySmog', false);
	addLuaSprite('phillyCars1', false);
	addLuaSprite('phillyCars2', false);
	addLuaSprite('phillyTraffic', false);
	addLuaSprite('phillyTraffic_lightmap', false);
	addLuaSprite('phillyForeground', false);
	addLuaSprite('Spraycan1', true);
	addLuaSprite('Spraycan2', true);
	addLuaSprite('spraycanPile', true);

	setProperty('phillyCars1.x', 1800);
	setProperty('phillyCars1.y', 480);
	setProperty('phillyCars1.angle', -20);
	setProperty('phillyCars2.x', 1800);
	setProperty('phillyCars2.y', 480);
	setProperty('phillyCars2.angle', 30);

	runTimer('leftCarTween1', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
	runTimer('rightCarTween', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
end

local Light = 0
local carWaiting = 0
local Car1variant = 0
local Car1speed = 1,3
local Car2variant = 0
local Car2speed = 1,3

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'redtogreenTimer' then
		Light = 0
		--playSound('test')
		playAnim('phillyTraffic', 'togreen', false);
		runTimer('greentoredTimer', 11);
		runTimer('leftCarTween1', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
		runTimer('rightCarTween', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
		if carWaiting == 1 then
			carWaiting = 0
			runTimer('leftCarTween11', 0.5);
		end
	end
	if tag == 'leftCarTween11' then
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', 30, 1.7, 'sineIn');
	end
	if tag == 'greentoredTimer' then
		Light = 1
		--playSound('test1')
		playAnim('phillyTraffic', 'tored', false);
		runTimer('redtogreenTimer', 8);
		runTimer('leftCarTween2', getRandomInt(25,55) *0.1);
	end
	if tag == 'leftCarTween1' then
		Car1variant = getRandomInt(1,4)
		if Car1variant == 1 then
			Car1speed = getRandomInt(10, 17) *0.1
		elseif Car1variant == 2 then
			Car1speed = getRandomInt(09, 15) *0.1
		elseif Car1variant == 3 then
			Car1speed = getRandomInt(15, 25) *0.1
		elseif Car1variant == 4 then
			Car1speed = getRandomInt(15, 25) *0.1
		end
		playAnim('phillyCars1', 'car'..Car1variant, false);
		setProperty('phillyCars1.angle', -20);
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', 30, 1.7, 'linear');
	end
	if tag == 'leftCarTween2' then
		carWaiting = 1
		Car1variant = getRandomInt(1,4)
		playAnim('phillyCars1', 'car'..Car1variant, false);
		setProperty('phillyCars1.angle', -20);
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', -5, 1.7, 'sineOut');
	end
	if tag == 'rightCarTween' then
		Car2variant = getRandomInt(1,4)
		if Car2variant == 1 then
			Car2speed = getRandomInt(10, 17) *0.1
		elseif Car2variant == 2 then
			Car2speed = getRandomInt(09, 15) *0.1
		elseif Car2variant == 3 then
			Car2speed = getRandomInt(15, 25) *0.1
		elseif Car2variant == 4 then
			Car2speed = getRandomInt(15, 25) *0.1
		end
		playAnim('phillyCars2', 'car'..Car2variant, false);
		setProperty('phillyCars2.angle', 30);
		doTweenAngle('phillyCars2TweenAngle', 'phillyCars2', -20, Car2speed, 'linear');
	end
	--[[if tag == rainSound then
		playSound('raindrops/raindrop'..getRandomInt(1,16), 10)
		runTimer('rainSound', getRandomInt(1,5)*0.1);
	end]]
end