local rainSize1 = 1
local rainSize2 = 1
local rainSize3 = 1
local rainSize4 = 1
local rainSize5 = 1
local rainSize6 = 1
local rainSize7 = 1
local rainSize8 = 1
local rainSize9 = 1
local rainSize10 = 1
local rainDensity = 0

function onCreate()

	makeLuaSprite('rain1', 'empty', 0, -100);
	makeGraphic('rain1', 1, 1, '90eeff');
	setObjectCamera('rain1', 'hud');
	setProperty('rain1.alpha', 0.2);
	addLuaSprite('rain1', false);
	setProperty('rain1.angle', 8);

	makeLuaSprite('rain2', 'empty', 0, -100);
	makeGraphic('rain2', 1, 1, '90eeff');
	setObjectCamera('rain2', 'hud');
	setProperty('rain2.alpha', 0.2);
	addLuaSprite('rain2', false);
	setProperty('rain2.angle', 8);

	makeLuaSprite('rain3', 'empty', 0, -100);
	makeGraphic('rain3', 1, 1, '90eeff');
	setObjectCamera('rain3', 'hud');
	setProperty('rain3.alpha', 0.2);
	addLuaSprite('rain3', false);
	setProperty('rain3.angle', 8);

	makeLuaSprite('rain4', 'empty', 0, -100);
	makeGraphic('rain4', 1, 1, '90eeff');
	setObjectCamera('rain4', 'hud');
	setProperty('rain4.alpha', 0.2);
	addLuaSprite('rain4', false);
	setProperty('rain4.angle', 8);

	makeLuaSprite('rain5', 'empty', 0, -100);
	makeGraphic('rain5', 1, 1, '90eeff');
	setObjectCamera('rain5', 'hud');
	setProperty('rain5.alpha', 0.2);
	addLuaSprite('rain5', false);
	setProperty('rain5.angle', 8);

	makeLuaSprite('rain6', 'empty', 0, -100);
	makeGraphic('rain6', 1, 1, '90eeff');
	setObjectCamera('rain6', 'hud');
	setProperty('rain6.alpha', 0.2);
	addLuaSprite('rain6', false);
	setProperty('rain6.angle', 8);

	makeLuaSprite('rain7', 'empty', 0, -100);
	makeGraphic('rain7', 1, 1, '90eeff');
	setObjectCamera('rain7', 'hud');
	setProperty('rain7.alpha', 0.2);
	addLuaSprite('rain7', false);
	setProperty('rain7.angle', 8);

	makeLuaSprite('rain8', 'empty', 0, -100);
	makeGraphic('rain8', 1, 1, '90eeff');
	setObjectCamera('rain8', 'hud');
	setProperty('rain8.alpha', 0.2);
	addLuaSprite('rain8', false);
	setProperty('rain8.angle', 8);

	makeLuaSprite('rain9', 'empty', 0, -100);
	makeGraphic('rain9', 1, 1, '90eeff');
	setObjectCamera('rain9', 'hud');
	setProperty('rain9.alpha', 0.2);
	addLuaSprite('rain9', false);
	setProperty('rain9.angle', 8);

	makeLuaSprite('rain10', 'empty', 0, -100);
	makeGraphic('rain10', 1, 1, '90eeff');
	setObjectCamera('rain10', 'hud');
	setProperty('rain10.alpha', 0.2);
	addLuaSprite('rain10', false);
	setProperty('rain10.angle', 8);
end

function onStepHit()
	rainDensity = getProperty("songPercent")
	rainSize1 = getRandomInt(3, 8)
	rainSize2 = getRandomInt(3, 8)
	rainSize3 = getRandomInt(3, 8)
	rainSize4 = getRandomInt(3, 8)
	rainSize5 = getRandomInt(3, 8)
	rainSize6 = getRandomInt(3, 8)
	rainSize7 = getRandomInt(3, 8)
	rainSize8 = getRandomInt(3, 8)
	rainSize9 = getRandomInt(3, 8)
	rainSize10 = getRandomInt(3, 8)
	setProperty('rain1.scale.x', rainSize1);
	setProperty('rain2.scale.x', rainSize2);
	setProperty('rain3.scale.x', rainSize3);
	setProperty('rain4.scale.x', rainSize4);
	setProperty('rain5.scale.x', rainSize5);
	setProperty('rain6.scale.x', rainSize6);
	setProperty('rain7.scale.x', rainSize7);
	setProperty('rain8.scale.x', rainSize8);
	setProperty('rain9.scale.x', rainSize9);
	setProperty('rain10.scale.x', rainSize10);
	setProperty('rain1.scale.y', rainSize1*30);
	setProperty('rain2.scale.y', rainSize2*30);
	setProperty('rain3.scale.y', rainSize3*30);
	setProperty('rain4.scale.y', rainSize4*30);
	setProperty('rain5.scale.y', rainSize5*30);
	setProperty('rain6.scale.y', rainSize6*30);
	setProperty('rain7.scale.y', rainSize7*30);
	setProperty('rain8.scale.y', rainSize8*30);
	setProperty('rain9.scale.y', rainSize9*30);
	setProperty('rain10.scale.y', rainSize10*30);
	if curStep %10 == 0 and rainDensity >= 0.1 then
		setProperty('rain1.x', getRandomInt(1, 1301)-1);
		setProperty('rain1.y', -150);
		doTweenX('rain1X', 'rain1', getProperty('rain1.x')-150, 0.3);
		doTweenY('rain1Y', 'rain1', 900, 0.3);
	end
	if curStep %10 == 5 and rainDensity >= 0.2 then
		setProperty('rain2.x', getRandomInt(1, 1301)-1);
		setProperty('rain2.y', -150);
		doTweenX('rain2X', 'rain2', getProperty('rain2.x')-150, 0.3);
		doTweenY('rain2Y', 'rain2', 900, 0.3);
	end
	if curStep %10 == 3 and rainDensity >= 0.3 then
		setProperty('rain3.x', getRandomInt(1, 1301)-1);
		setProperty('rain3.y', -150);
		doTweenX('rain3X', 'rain3', getProperty('rain3.x')-150, 0.3);
		doTweenY('rain3Y', 'rain3', 900, 0.3);
	end
	if curStep %10 == 9 and rainDensity >= 0.4 then
		setProperty('rain4.x', getRandomInt(1, 1301)-1);
		setProperty('rain4.y', -150);
		doTweenX('rain4X', 'rain4', getProperty('rain4.x')-150, 0.3);
		doTweenY('rain4Y', 'rain4', 900, 0.3);
	end
	if curStep %10 == 7 and rainDensity >= 0.5 then
		setProperty('rain5.x', getRandomInt(1, 1301)-1);
		setProperty('rain5.y', -150);
		doTweenX('rain5X', 'rain5', getProperty('rain5.x')-150, 0.3);
		doTweenY('rain5Y', 'rain5', 900, 0.3);
	end
	if curStep %10 == 2 and rainDensity >= 0.6 then
		setProperty('rain6.x', getRandomInt(1, 1301)-1);
		setProperty('rain6.y', -150);
		doTweenX('rain6X', 'rain6', getProperty('rain6.x')-150, 0.3);
		doTweenY('rain6Y', 'rain6', 900, 0.3);
	end
	if curStep %10 == 4 and rainDensity >= 0.7 then
		setProperty('rain7.x', getRandomInt(1, 1301)-1);
		setProperty('rain7.y', -150);
		doTweenX('rain7X', 'rain7', getProperty('rain7.x')-150, 0.3);
		doTweenY('rain7Y', 'rain7', 900, 0.3);
	end
	if curStep %10 == 6 and rainDensity >= 0.8 then
		setProperty('rain8.x', getRandomInt(1, 1301)-1);
		setProperty('rain8.y', -150);
		doTweenX('rain8X', 'rain8', getProperty('rain8.x')-150, 0.3);
		doTweenY('rain8Y', 'rain8', 900, 0.3);
	end
	if curStep %10 == 8 and rainDensity >= 0.9 then
		setProperty('rain9.x', getRandomInt(1, 1301)-1);
		setProperty('rain9.y', -150);
		doTweenX('rain9X', 'rain9', getProperty('rain9.x')-150, 0.3);
		doTweenY('rain9Y', 'rain9', 900, 0.3);
	end
	if curStep %10 == 9 and rainDensity >= 1 then
		setProperty('rain10.x', getRandomInt(1, 1301)-1);
		setProperty('rain10.y', -150);
		doTweenX('rain10X', 'rain10', getProperty('rain10.x')-150, 0.3);
		doTweenY('rain10Y', 'rain10', 900, 0.3);
	end
end