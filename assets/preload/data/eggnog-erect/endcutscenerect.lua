function onCreate()
    precacheImage("week5/santatalkass")
    precacheSound("week5/santatalk")
    precacheSound("week5/santadedlol")
    precacheImage("week5/momdadparentend")

    makeAnimatedLuaSprite('dadshot', 'week5/momdadparentend', getProperty("dad.x") - 65, getProperty("dad.y") + 70)
    addAnimationByPrefix('dadshot', 'talk', 'talk', 28, false)
    objectPlayAnimation('dadshot', 'talk', true)
    addLuaSprite('dadshot', true)
    setProperty('dadshot.scale.x', 1.35)
    setProperty('dadshot.scale.y', 1.35)
    setProperty('dadshot.alpha', 0.001)

    makeLuaSprite('blackScreenn', 'nil', 0, 0)
    setObjectOrder('blackScreenn', 800);
    makeGraphic('blackScreenn', screenWidth, screenHeight, '000000')
    addLuaSprite('blackScreenn', true)
    setProperty('blackScreenn.alpha', 0)
    setObjectCamera('blackScreenn', 'other')

    makeAnimatedLuaSprite('santatalk', 'week5/santatalkass', getProperty("santa.x") - 220, getProperty("santa.y") + 180)
    addAnimationByPrefix('santatalk', 'talk', 'talk', 12.4, false)
    objectPlayAnimation('santatalk', 'talk', true)
    addLuaSprite('santatalk', true)
    setProperty('santatalk.scale.x', 1.6)
    setProperty('santatalk.scale.y', 1.6)
    setProperty('santatalk.alpha', 0.001)
end

function onEvent(name, value1, value2)
    if name == 'Play Animation' then
        if value1 == 'endstart' then
            setProperty('dad.alpha', 0)
            setProperty('santa.alpha', 0)
            setProperty('dadshot.alpha', 1)
            setProperty('santatalk.alpha', 1)
            objectPlayAnimation('santatalk', 'talk', true)
            objectPlayAnimation('dadshot', 'talk', true)
            playSound("week5/santatalk", 1)
            runTimer("shot", 9.5)
            doTweenAlpha("byebyecam", "camHUD", 0, 1, "linear")
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'shot' then
        playSound("week5/santadedlol")
    end
end
