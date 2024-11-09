local exitsong = false
local result = false

function onUpdate(elapsed)
    local accuracy = getProperty('ratingPercent')
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') and result == true then
        exitsong = true
        endSong(true)
    end
end

--[[
function onUpdatePost()
    debugPrint(getProperty('bfsohappy.x'))
    debugPrint(getProperty('bfsohappy.y'))
end
]]

function onEndSong()
    if not exitsong and score > 0 and result == false then
        local accuracy = getProperty('ratingPercent')
        setProperty('inCutscene', true)
        doTweenAlpha("blackborder", "blackborder", 0.6, 1, "linear")
        makeLuaSprite('blackborder', '', 0, 0)
        makeGraphic('blackborder', screenWidth, screenHeight, '000000')
        setProperty('blackborder.alpha', 0)
        setObjectCamera('blackborder', 'other')
        addLuaSprite('blackborder', true)
        setObjectOrder("blackborder", 5)
        doTweenAlpha("blackborder", "blackborder", 1, 1, "linear")

        removeLuaScript("uescript/OPTIONS/Keystrokes")
        doTweenAlpha("UEKEYleft", "leftButton", 0, 1, "linear")
        doTweenAlpha("UEKEYdown", "downButton", 0, 1, "linear")
        doTweenAlpha("UEKEYup", "upButton", 0, 1, "linear")
        doTweenAlpha("UEKEYright", "rightButton", 0, 1, "linear")

        precacheSound("results/resultsEXCELLENT")
        precacheSound("results/resultsEXCELLENT-intro")
        precacheSound("results/resultsSHIT")
        precacheSound("results/resultsSHIT-intro")
        precacheImage("result/bfgreatresult")
        precacheImage("result/bfshitresult")
        --[[
		

        --]]

        runTimer("noblacklol", 2)

        return Function_Stop
    else
        return Function_Continue
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    local accuracy = getProperty('ratingPercent')
    if tag == "noblacklol" then
        doTweenAlpha("blackborder", "blackborder", 0, 1, "linear")
        runTimer("scoreAppear", 0.01)
        result = true
        -- Text
        addGridBG("resultbggrid", 80, 80, 160, 160, 20, 20)
        setObjectCamera("resultbggrid", "other")
        makeLuaText("songText", songName .. " - " .. difficultyName, 1000, (screenWidth/2)-(1000/2), -100)
        setTextSize("songText", 50)
        setTextAlignment("songText", "center")
        setObjectCamera("songText", "other")
        addLuaText("songText")
        doTweenY("songText", "songText", 130, 1, "circOut")
		
        makeLuaText("scoreText", "Score : " .. score .."", 1000, -1000, 200)
        setTextSize("scoreText", 40)
        setObjectCamera("scoreText", "other")
        addLuaText("scoreText")
        setTextAlignment("scoreText", "left")

        makeLuaText("missesText", "Screw-Ups : " .. misses .."", 1000, -1000, 250)
        setTextSize("missesText", 40)
        setObjectCamera("missesText", "other")
        addLuaText("missesText")
        setTextAlignment("missesText", "left")

        makeLuaText("ratingText", "Rating: (" .. ratingFC .. ") " .. round(rating * 100, 2) .. "%", 1000, -1000, 300)
        setTextSize("ratingText", 40)
        setObjectCamera("ratingText", "other")
        addLuaText("ratingText")
        setTextAlignment("ratingText", "left")

        makeLuaText("sickText", "Sicks: " .. getProperty("sicks"), 1000, -1000, 350)
        setTextSize("sickText", 40)
        setObjectCamera("sickText", "other")
        addLuaText("sickText")
        setTextAlignment("sickText", "left")

        makeLuaText("goodText", "Goods: " .. getProperty("goods"), 1000, -1000, 400)
        setTextSize("goodText", 40)
        setObjectCamera("goodText", "other")
        addLuaText("goodText")
        setTextAlignment("goodText", "left")

        makeLuaText("badText", "Bads: " .. getProperty("bads"), 1000, -1000, 450)
        setTextSize("badText", 40)
        setObjectCamera("badText", "other")
        addLuaText("badText")
        setTextAlignment("badText", "left")

        makeLuaText("shitText", "Shits: " .. getProperty("shits"), 1000, -1000, 500)
        setTextSize("shitText", 40)
        setObjectCamera("shitText", "other")
        addLuaText("shitText")
        setTextAlignment("shitText", "left")
        --
        if getPropertyFromClass("ClientPrefs", "darkmode", true) then
            makeLuaSprite('darkbg', 'result/darkmenu', 0, 0)
            setProperty('darkbg.color', getColorFromHex("008BFF"))
            setProperty('darkbg.alpha', 1)
            setObjectCamera('darkbg', 'other')
            addLuaSprite('darkbg', true)
            setObjectOrder("darkbg", 3)
        else
            makeLuaSprite('lightbg', 'result/lightmenu', 0, 0)
            setProperty('lightbg.color', getColorFromHex("008BFF"))
            setProperty('lightbg.alpha', 1)
            setObjectCamera('lightbg', 'other')
            addLuaSprite('lightbg', true)
            setObjectOrder("lightbg", 3)
        end
        if accuracy >= 0.6 then
            playSound("results/resultsEXCELLENT-intro", 0.8, "introresult")
        elseif accuracy < 0.6 then
            playSound("results/resultsSHIT-intro", 0.8, "shitintroresult")
            setProperty('darkbg.color', getColorFromHex("FF0000"))
            setProperty('lightbg.color', getColorFromHex("FF0000"))
        end
    end
    if tag == "scoreAppear" then
        doTweenX("scoreText", "scoreText", 110, 1, "circOut")
        playSound("confirmMenu", 0.8)
        runTimer("missesAppear", 1)
    end
    if tag == "missesAppear" then
        doTweenX("missesText", "missesText", getProperty("scoreText.x") + 10, 1, "circOut")
        playSound("confirmMenu", 0.8)
        runTimer("ratingAppear", 1)
    end
    if tag == "ratingAppear" then
        doTweenX("ratingText", "ratingText", getProperty("scoreText.x") + 20, 1, "circOut")
        playSound("confirmMenu", 0.8)
        runTimer("skillappear", 1)
    end
    if tag == "skillappear" then
        doTweenX("sickText", "sickText", getProperty("scoreText.x") + 30, 1, "circOut")
        doTweenX("goodText", "goodText", getProperty("scoreText.x") + 40, 1, "circOut")
        doTweenX("badText", "badText", getProperty("scoreText.x") + 50, 1, "circOut")
        doTweenX("shitText", "shitText", getProperty("scoreText.x") + 60, 1, "circOut")
        playSound("confirmMenu", 0.8)
        if accuracy < 0.6 then
            runTimer("shitbfcomes", 0.01)
        end
    end
    if tag == "bfcomes" then
        makeAnimatedLuaSprite('bfhappy', 'result/bfgreatresult', 1300, -250)
        addAnimationByPrefix('bfhappy', 'comes', 'come', 10, false)
        addAnimationByPrefix('bfhappy', 'danceloop', 'danceloop', 8, true)
        addLuaSprite('bfhappy', true)
        runTimer("bfstartstodance", 0.27)
        objectPlayAnimation('bfhappy', 'comes', true)
        setObjectCamera('bfhappy', 'other')
        doTweenX("bfhappy", "bfhappy", 720, 1, "circOut")
    end
    if tag == "bfcomesA" then
        makeAnimatedLuaSprite('bfsohappy', 'result/bfamazingresult', 1300, 330)
        addAnimationByPrefix('bfsohappy', 'amazingloop', 'amazingloop', 8, true)
        setProperty('bfsohappy.antialiasing', false)
        addLuaSprite('bfsohappy', true)
        runTimer("bfstartstodanceA", 0.27)
        objectPlayAnimation('bfsohappy', 'comes', true)
        setObjectCamera('bfsohappy', 'other')
        doTweenX("bfsohappy", "bfsohappy", 850, 1, "circOut")

        setProperty('bfsohappy.scale.x', 3)
        setProperty('bfsohappy.scale.y', 3)
    end
    if tag == "shitbfcomes" then
        makeAnimatedLuaSprite('shitbf', 'result/bfshitresult', 1300, 0)
        addAnimationByPrefix('shitbf', 'intro', 'intro', 7, false)
        addAnimationByPrefix('shitbf', 'look', 'look', 8, true)
        addLuaSprite('shitbf', true)
        objectPlayAnimation('shitbf', 'intro', true)
        setObjectCamera('shitbf', 'other')
        setProperty('shitbf.scale.x', 1.9)
        runTimer("gflook", 6)
        setProperty('shitbf.scale.y', 1.9)
        setProperty('shitbf.antialiasing', false)
        doTweenX("shitbf", "shitbf", 750, 1, "circOut")
    end
    if tag == "bfstartstodance" then
        objectPlayAnimation('bfhappy', 'danceloop', true)
    end
    if tag == "bfstartstodanceA" then
        objectPlayAnimation('bfsohappy', 'amazingloop', true)
    end
    if tag == "gflook" then
        objectPlayAnimation('shitbf', 'look', true)
    end
end

function round(x, n) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end

function onSoundFinished(tag)
    local accuracy = getProperty('ratingPercent')
    if tag == "introresult" then
        playSound("results/resultsEXCELLENT", 1, "resultbelike")
        if (accuracy >= 0.6 and accuracy < 0.9) then
            runTimer("bfcomes", 0.01)
        elseif accuracy >= 0.9 then
            runTimer("bfcomesA", 0.01)
        end
    end
    if tag == "shitintroresult" then
        playSound("results/resultsSHIT", 1, "shitresultbelike")
    end
    if tag == "resultbelike" then
        playSound("results/resultsEXCELLENT", 1, "resultbelike")
    end
    if tag == "shitresultbelike" then
        playSound("results/resultsSHIT", 1, "shitresultbelike")
    end
end
