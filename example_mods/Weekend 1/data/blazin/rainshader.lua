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
local rainSize11 = 1
local rainSize12 = 1
local rainSize13 = 1
local rainSize14 = 1
local rainSize15 = 1
local rainSize16 = 1
local rainSize17 = 1
local rainSize18 = 1
local rainSize19 = 1
local rainSize20 = 1
local rainSize21 = 1
local rainSize22 = 1
local rainSize23 = 1
local rainSize24 = 1
local rainSize25 = 1
local rainSize26 = 1
local rainSize27 = 1
local rainSize28 = 1
local rainSize29 = 1
local rainSize30 = 1
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

	makeLuaSprite('rain11', 'empty', 0, -100);
	makeGraphic('rain11', 1, 1, '90eeff');
	setObjectCamera('rain11', 'hud');
	setProperty('rain11.alpha', 0.2);
	addLuaSprite('rain11', false);
	setProperty('rain11.angle', 8);

	makeLuaSprite('rain12', 'empty', 0, -100);
	makeGraphic('rain12', 1, 1, '90eeff');
	setObjectCamera('rain12', 'hud');
	setProperty('rain12.alpha', 0.2);
	addLuaSprite('rain12', false);
	setProperty('rain12.angle', 8);

	makeLuaSprite('rain13', 'empty', 0, -100);
	makeGraphic('rain13', 1, 1, '90eeff');
	setObjectCamera('rain13', 'hud');
	setProperty('rain13.alpha', 0.2);
	addLuaSprite('rain13', false);
	setProperty('rain13.angle', 8);

	makeLuaSprite('rain14', 'empty', 0, -100);
	makeGraphic('rain14', 1, 1, '90eeff');
	setObjectCamera('rain14', 'hud');
	setProperty('rain14.alpha', 0.2);
	addLuaSprite('rain14', false);
	setProperty('rain14.angle', 8);

	makeLuaSprite('rain15', 'empty', 0, -100);
	makeGraphic('rain15', 1, 1, '90eeff');
	setObjectCamera('rain15', 'hud');
	setProperty('rain15.alpha', 0.2);
	addLuaSprite('rain15', false);
	setProperty('rain15.angle', 8);

	makeLuaSprite('rain16', 'empty', 0, -100);
	makeGraphic('rain16', 1, 1, '90eeff');
	setObjectCamera('rain16', 'hud');
	setProperty('rain16.alpha', 0.2);
	addLuaSprite('rain16', false);
	setProperty('rain16.angle', 8);

	makeLuaSprite('rain17', 'empty', 0, -100);
	makeGraphic('rain17', 1, 1, '90eeff');
	setObjectCamera('rain17', 'hud');
	setProperty('rain17.alpha', 0.2);
	addLuaSprite('rain17', false);
	setProperty('rain17.angle', 8);

	makeLuaSprite('rain18', 'empty', 0, -100);
	makeGraphic('rain18', 1, 1, '90eeff');
	setObjectCamera('rain18', 'hud');
	setProperty('rain18.alpha', 0.2);
	addLuaSprite('rain18', false);
	setProperty('rain18.angle', 8);

	makeLuaSprite('rain19', 'empty', 0, -100);
	makeGraphic('rain19', 1, 1, '90eeff');
	setObjectCamera('rain19', 'hud');
	setProperty('rain19.alpha', 0.2);
	addLuaSprite('rain19', false);
	setProperty('rain19.angle', 8);

	makeLuaSprite('rain20', 'empty', 0, -100);
	makeGraphic('rain20', 1, 1, '90eeff');
	setObjectCamera('rain20', 'hud');
	setProperty('rain20.alpha', 0.2);
	addLuaSprite('rain20', false);
	setProperty('rain20.angle', 8);

	makeLuaSprite('rain21', 'empty', 0, -100);
	makeGraphic('rain21', 1, 1, '90eeff');
	setObjectCamera('rain21', 'hud');
	setProperty('rain21.alpha', 0.2);
	addLuaSprite('rain21', false);
	setProperty('rain21.angle', 8);

	makeLuaSprite('rain22', 'empty', 0, -100);
	makeGraphic('rain22', 1, 1, '90eeff');
	setObjectCamera('rain22', 'hud');
	setProperty('rain22.alpha', 0.2);
	addLuaSprite('rain22', false);
	setProperty('rain22.angle', 8);

	makeLuaSprite('rain23', 'empty', 0, -100);
	makeGraphic('rain23', 1, 1, '90eeff');
	setObjectCamera('rain23', 'hud');
	setProperty('rain23.alpha', 0.2);
	addLuaSprite('rain23', false);
	setProperty('rain23.angle', 8);

	makeLuaSprite('rain24', 'empty', 0, -100);
	makeGraphic('rain24', 1, 1, '90eeff');
	setObjectCamera('rain24', 'hud');
	setProperty('rain24.alpha', 0.2);
	addLuaSprite('rain24', false);
	setProperty('rain24.angle', 8);

	makeLuaSprite('rain25', 'empty', 0, -100);
	makeGraphic('rain25', 1, 1, '90eeff');
	setObjectCamera('rain25', 'hud');
	setProperty('rain25.alpha', 0.2);
	addLuaSprite('rain25', false);
	setProperty('rain25.angle', 8);

	makeLuaSprite('rain26', 'empty', 0, -100);
	makeGraphic('rain26', 1, 1, '90eeff');
	setObjectCamera('rain26', 'hud');
	setProperty('rain26.alpha', 0.2);
	addLuaSprite('rain26', false);
	setProperty('rain26.angle', 8);

	makeLuaSprite('rain27', 'empty', 0, -100);
	makeGraphic('rain27', 1, 1, '90eeff');
	setObjectCamera('rain27', 'hud');
	setProperty('rain27.alpha', 0.2);
	addLuaSprite('rain27', false);
	setProperty('rain27.angle', 8);

	makeLuaSprite('rain28', 'empty', 0, -100);
	makeGraphic('rain28', 1, 1, '90eeff');
	setObjectCamera('rain28', 'hud');
	setProperty('rain28.alpha', 0.2);
	addLuaSprite('rain28', false);
	setProperty('rain28.angle', 8);

	makeLuaSprite('rain29', 'empty', 0, -100);
	makeGraphic('rain29', 1, 1, '90eeff');
	setObjectCamera('rain29', 'hud');
	setProperty('rain29.alpha', 0.2);
	addLuaSprite('rain29', false);
	setProperty('rain29.angle', 8);

	makeLuaSprite('rain30', 'empty', 0, -100);
	makeGraphic('rain30', 1, 1, '90eeff');
	setObjectCamera('rain30', 'hud');
	setProperty('rain30.alpha', 0.2);
	addLuaSprite('rain30', false);
	setProperty('rain30.angle', 8);
end

function onCreatePost()
    local bfIconColor = getProperty('boyfriend.healthColorArray')
    --debugPrint(string.format('%02x%02x%02x', bfIconColor[1], bfIconColor[2], bfIconColor[3]))
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
	rainSize11 = getRandomInt(3, 8)
	rainSize12 = getRandomInt(3, 8)
	rainSize13 = getRandomInt(3, 8)
	rainSize14 = getRandomInt(3, 8)
	rainSize15 = getRandomInt(3, 8)
	rainSize16 = getRandomInt(3, 8)
	rainSize17 = getRandomInt(3, 8)
	rainSize18 = getRandomInt(3, 8)
	rainSize19 = getRandomInt(3, 8)
	rainSize20 = getRandomInt(3, 8)
	rainSize21 = getRandomInt(3, 8)
	rainSize22 = getRandomInt(3, 8)
	rainSize23 = getRandomInt(3, 8)
	rainSize24 = getRandomInt(3, 8)
	rainSize25 = getRandomInt(3, 8)
	rainSize26 = getRandomInt(3, 8)
	rainSize27 = getRandomInt(3, 8)
	rainSize28 = getRandomInt(3, 8)
	rainSize29 = getRandomInt(3, 8)
	rainSize30 = getRandomInt(3, 8)
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
	setProperty('rain11.scale.x', rainSize11);
	setProperty('rain12.scale.x', rainSize12);
	setProperty('rain13.scale.x', rainSize13);
	setProperty('rain14.scale.x', rainSize14);
	setProperty('rain15.scale.x', rainSize15);
	setProperty('rain16.scale.x', rainSize16);
	setProperty('rain17.scale.x', rainSize17);
	setProperty('rain18.scale.x', rainSize18);
	setProperty('rain19.scale.x', rainSize19);
	setProperty('rain20.scale.x', rainSize20);
	setProperty('rain21.scale.x', rainSize21);
	setProperty('rain22.scale.x', rainSize22);
	setProperty('rain23.scale.x', rainSize23);
	setProperty('rain24.scale.x', rainSize24);
	setProperty('rain25.scale.x', rainSize25);
	setProperty('rain26.scale.x', rainSize26);
	setProperty('rain27.scale.x', rainSize27);
	setProperty('rain28.scale.x', rainSize28);
	setProperty('rain29.scale.x', rainSize29);
	setProperty('rain30.scale.x', rainSize30);
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
	setProperty('rain11.scale.y', rainSize11*30);
	setProperty('rain12.scale.y', rainSize12*30);
	setProperty('rain13.scale.y', rainSize13*30);
	setProperty('rain14.scale.y', rainSize14*30);
	setProperty('rain15.scale.y', rainSize15*30);
	setProperty('rain16.scale.y', rainSize16*30);
	setProperty('rain17.scale.y', rainSize17*30);
	setProperty('rain18.scale.y', rainSize18*30);
	setProperty('rain19.scale.y', rainSize19*30);
	setProperty('rain20.scale.y', rainSize20*30);
	setProperty('rain21.scale.y', rainSize21*30);
	setProperty('rain22.scale.y', rainSize22*30);
	setProperty('rain23.scale.y', rainSize23*30);
	setProperty('rain24.scale.y', rainSize24*30);
	setProperty('rain25.scale.y', rainSize25*30);
	setProperty('rain26.scale.y', rainSize26*30);
	setProperty('rain27.scale.y', rainSize27*30);
	setProperty('rain28.scale.y', rainSize28*30);
	setProperty('rain29.scale.y', rainSize29*30);
	setProperty('rain30.scale.y', rainSize30*30);
	if curStep %10 == 0 and rainDensity >= 0 then
		setProperty('rain1.x', getRandomInt(1, 1301)-1);
		setProperty('rain1.y', -150);
		doTweenX('rain1X', 'rain1', getProperty('rain1.x')-150, 0.3);
		doTweenY('rain1Y', 'rain1', 900, 0.3);

		setProperty('rain11.x', getRandomInt(1, 1301)-1);
		setProperty('rain11.y', -150);
		doTweenX('rain11X', 'rain11', getProperty('rain11.x')-150, 0.3);
		doTweenY('rain11Y', 'rain11', 900, 0.3);

		setProperty('rain21.x', getRandomInt(1, 1301)-1);
		setProperty('rain21.y', -150);
		doTweenX('rain21X', 'rain21', getProperty('rain21.x')-150, 0.3);
		doTweenY('rain21Y', 'rain21', 900, 0.3);
	end
	if curStep %10 == 5 and rainDensity >= 0 then
		setProperty('rain2.x', getRandomInt(1, 1301)-1);
		setProperty('rain2.y', -150);
		doTweenX('rain2X', 'rain2', getProperty('rain2.x')-150, 0.3);
		doTweenY('rain2Y', 'rain2', 900, 0.3);

		setProperty('rain12.x', getRandomInt(1, 1301)-1);
		setProperty('rain12.y', -150);
		doTweenX('rain12X', 'rain12', getProperty('rain12.x')-150, 0.3);
		doTweenY('rain12Y', 'rain12', 900, 0.3);

		setProperty('rain22.x', getRandomInt(1, 1301)-1);
		setProperty('rain22.y', -150);
		doTweenX('rain22X', 'rain22', getProperty('rain22.x')-150, 0.3);
		doTweenY('rain22Y', 'rain22', 900, 0.3);
	end
	if curStep %10 == 3 and rainDensity >= 0 then
		setProperty('rain3.x', getRandomInt(1, 1301)-1);
		setProperty('rain3.y', -150);
		doTweenX('rain3X', 'rain3', getProperty('rain3.x')-150, 0.3);
		doTweenY('rain3Y', 'rain3', 900, 0);

		setProperty('rain13.x', getRandomInt(1, 1301)-1);
		setProperty('rain13.y', -150);
		doTweenX('rain13X', 'rain13', getProperty('rain13.x')-150, 0.3);
		doTweenY('rain13Y', 'rain13', 900, 0.3);

		setProperty('rain23.x', getRandomInt(1, 1301)-1);
		setProperty('rain23.y', -150);
		doTweenX('rain23X', 'rain23', getProperty('rain13.x')-150, 0.3);
		doTweenY('rain23Y', 'rain23', 900, 0.3);
	end
	if curStep %10 == 9 and rainDensity >= 0 then
		setProperty('rain4.x', getRandomInt(1, 1301)-1);
		setProperty('rain4.y', -150);
		doTweenX('rain4X', 'rain4', getProperty('rain4.x')-150, 0.3);
		doTweenY('rain4Y', 'rain4', 900, 0.3);

		setProperty('rain14.x', getRandomInt(1, 1301)-1);
		setProperty('rain14.y', -150);
		doTweenX('rain14X', 'rain14', getProperty('rain14.x')-150, 0.3);
		doTweenY('rain14Y', 'rain14', 900, 0.3);

		setProperty('rain24.x', getRandomInt(1, 1301)-1);
		setProperty('rain24.y', -150);
		doTweenX('rain24X', 'rain24', getProperty('rain24.x')-150, 0.3);
		doTweenY('rain24Y', 'rain24', 900, 0.3);
	end
	if curStep %10 == 7 and rainDensity >= 0 then
		setProperty('rain5.x', getRandomInt(1, 1301)-1);
		setProperty('rain5.y', -150);
		doTweenX('rain5X', 'rain5', getProperty('rain5.x')-150, 0.3);
		doTweenY('rain5Y', 'rain5', 900, 0.3);

		setProperty('rain15.x', getRandomInt(1, 1301)-1);
		setProperty('rain15.y', -150);
		doTweenX('rain15X', 'rain15', getProperty('rain15.x')-150, 0.3);
		doTweenY('rain15Y', 'rain15', 900, 0.3);

		setProperty('rain25.x', getRandomInt(1, 1301)-1);
		setProperty('rain25.y', -150);
		doTweenX('rain25X', 'rain25', getProperty('rain25.x')-150, 0.3);
		doTweenY('rain25Y', 'rain25', 900, 0.3);
	end
	if curStep %10 == 2 and rainDensity >= 0 then
		setProperty('rain6.x', getRandomInt(1, 1301)-1);
		setProperty('rain6.y', -150);
		doTweenX('rain6X', 'rain6', getProperty('rain6.x')-150, 0.3);
		doTweenY('rain6Y', 'rain6', 900, 0.3);

		setProperty('rain16.x', getRandomInt(1, 1301)-1);
		setProperty('rain16.y', -150);
		doTweenX('rain16X', 'rain16', getProperty('rain16.x')-150, 0.3);
		doTweenY('rain16Y', 'rain16', 900, 0.3);

		setProperty('rain26.x', getRandomInt(1, 1301)-1);
		setProperty('rain26.y', -150);
		doTweenX('rain26X', 'rain26', getProperty('rain26.x')-150, 0.3);
		doTweenY('rain26Y', 'rain26', 900, 0.3);
	end
	if curStep %10 == 4 and rainDensity >= 0 then
		setProperty('rain7.x', getRandomInt(1, 1301)-1);
		setProperty('rain7.y', -150);
		doTweenX('rain7X', 'rain7', getProperty('rain7.x')-150, 0.3);
		doTweenY('rain7Y', 'rain7', 900, 0.3);

		setProperty('rain17.x', getRandomInt(1, 1301)-1);
		setProperty('rain17.y', -150);
		doTweenX('rain17X', 'rain17', getProperty('rain17.x')-150, 0.3);
		doTweenY('rain17Y', 'rain17', 900, 0.3);

		setProperty('rain27.x', getRandomInt(1, 1301)-1);
		setProperty('rain27.y', -150);
		doTweenX('rain27X', 'rain27', getProperty('rain27.x')-150, 0.3);
		doTweenY('rain27Y', 'rain27', 900, 0.3);
	end
	if curStep %10 == 6 and rainDensity >= 0 then
		setProperty('rain8.x', getRandomInt(1, 1301)-1);
		setProperty('rain8.y', -150);
		doTweenX('rain8X', 'rain8', getProperty('rain8.x')-150, 0.3);
		doTweenY('rain8Y', 'rain8', 900, 0.3);

		setProperty('rain18.x', getRandomInt(1, 1301)-1);
		setProperty('rain18.y', -150);
		doTweenX('rain18X', 'rain18', getProperty('rain18.x')-150, 0.3);
		doTweenY('rain18Y', 'rain18', 900, 0.3);

		setProperty('rain28.x', getRandomInt(1, 1301)-1);
		setProperty('rain28.y', -150);
		doTweenX('rain28X', 'rain28', getProperty('rain28.x')-150, 0.3);
		doTweenY('rain28Y', 'rain28', 900, 0.3);
	end
	if curStep %10 == 8 and rainDensity >= 0 then
		setProperty('rain9.x', getRandomInt(1, 1301)-1);
		setProperty('rain9.y', -150);
		doTweenX('rain9X', 'rain9', getProperty('rain9.x')-150, 0.3);
		doTweenY('rain9Y', 'rain9', 900, 0.3);

		setProperty('rain19.x', getRandomInt(1, 1301)-1);
		setProperty('rain19.y', -150);
		doTweenX('rain19X', 'rain19', getProperty('rain19.x')-150, 0.3);
		doTweenY('rain19Y', 'rain19', 900, 0.3);

		setProperty('rain29.x', getRandomInt(1, 1301)-1);
		setProperty('rain29.y', -150);
		doTweenX('rain29X', 'rain29', getProperty('rain29.x')-150, 0.3);
		doTweenY('rain29Y', 'rain29', 900, 0.3);
	end
	if curStep %10 == 9 and rainDensity >= 0 then
		setProperty('rain10.x', getRandomInt(1, 1301)-1);
		setProperty('rain10.y', -150);
		doTweenX('rain10X', 'rain10', getProperty('rain10.x')-150, 0.3);
		doTweenY('rain10Y', 'rain10', 900, 0.3);

		setProperty('rain20.x', getRandomInt(1, 1301)-1);
		setProperty('rain20.y', -150);
		doTweenX('rain20X', 'rain20', getProperty('rain20.x')-150, 0.3);
		doTweenY('rain20Y', 'rain20', 900, 0.3);

		setProperty('rain30.x', getRandomInt(1, 1301)-1);
		setProperty('rain30.y', -150);
		doTweenX('rain30X', 'rain30', getProperty('rain30.x')-150, 0.3);
		doTweenY('rain30Y', 'rain30', 900, 0.3);
	end
end