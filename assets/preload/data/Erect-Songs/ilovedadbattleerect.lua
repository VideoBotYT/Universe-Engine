local song = "Bopeebo"
local difficulty = nil
local selectedsong = 1
local selecteddifficulty = 0
local selecting = "song"

function onStartCountdown()
    
    playMusic("freakyMenu-"..getPropertyFromClass("ClientPrefs", "mmm"), 1, true)

    createBoyfriend()
    createEnemies()
     
    makeLuaText('SongText', song, 1000, 130, 300)
    setTextFont('SongText', 'funkin.ttf')
    setTextSize('SongText', 70)
	setObjectOrder('SongText', 4);
    setTextAlignment('SongText', 'center')
    addLuaText('SongText')
    setObjectCamera('SongText', 'other')

    makeLuaSprite('Erect', 'erectselect/difficulty/erect', 510, 400)
    setObjectOrder('Erect', 4)
    addLuaSprite('Erect', true)
    setProperty('Erect.alpha', 1)
    setObjectCamera('Erect', 'other')

    makeLuaSprite('nightmare', 'erectselect/difficulty/nightmare', 470, 395)
    setObjectOrder('nightmare', 4)
    addLuaSprite('nightmare', true)
    setProperty('nightmare.alpha', 0)
    setObjectCamera('nightmare', 'other')

    makeLuaText('SelectText', "Select A Song And Difficulty", 1000, 130, 50)
    setTextFont('SelectText', 'funkin.ttf')
    setTextSize('SelectText', 50)
	setObjectOrder('SelectText', 4);
    setTextAlignment('SelectText', 'center')
    addLuaText('SelectText')
    setObjectCamera('SelectText', 'other')

    makeLuaText('<', "<", 1000, getProperty("SongText.text.length") - 140, 300)
    setTextFont('<', 'funkin.ttf')
    setTextSize('<', 70)
	setObjectOrder('<', 10);
    setTextAlignment('<', 'center')
    addLuaText('<')
    setProperty('<.alpha', 1)
    setObjectCamera('<', 'other')

    makeLuaText('>', ">", 1000, getProperty("SongText.text.length") + 390, 300)
    setTextFont('>', 'funkin.ttf')
    setTextSize('>', 70)
	setObjectOrder('>', 10);
    setTextAlignment('>', 'center')
    addLuaText('>')
    setProperty('>.alpha', 1)
    setObjectCamera('>', 'other')

    makeLuaText('<2', "<", 1000, -60, 390)
    setTextFont('<2', 'funkin.ttf')
    setTextSize('<2', 70)
	setObjectOrder('<2', 10);
    setTextAlignment('<2', 'center')
    addLuaText('<2')
    setProperty('<2.alpha', 0)
    setObjectCamera('<2', 'other')

    makeLuaText('>2', ">", 1000, 320, 390)
    setTextFont('>2', 'funkin.ttf')
    setTextSize('>2', 70)
	setObjectOrder('>2', 10);
    setProperty('>2.alpha', 0)
    setTextAlignment('>2', 'center')
    addLuaText('2>')
    setObjectCamera('>2', 'other')

    if getPropertyFromClass("ClientPrefs", "darkmode") == false then
        makeLuaSprite('menug', 'menuDesat', 0, 0)
        setObjectOrder('menug', 1)
        addLuaSprite('menug', true)
        setProperty('menug.alpha', 1)
        setObjectCamera('menug', 'other')
    else
        makeLuaSprite('menugdark', 'aboutMenu', 0, 0)
        setObjectOrder('menugdark', 1)
        --setProperty("menugdark.color", getColorFromHex("907237"))
        addLuaSprite('menugdark', true)
        setProperty('menugdark.alpha', 1)
        setObjectCamera('menugdark', 'other') 
    end
    return Function_Stop
end

function onUpdate(elapsed)
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') then
        exitSong()
    end

    if selecteddifficulty == 0 then
        setProperty("DAD.color", getColorFromHex("FF0099"))
        setProperty("BF.color", getColorFromHex("FF0099"))
        setProperty("menugdark.color", getColorFromHex("FF0099"))
        setProperty("menug.color", getColorFromHex("FF0099"))
        setProperty("MOM.color", getColorFromHex("FF0099"))
        setProperty("PARENT.color", getColorFromHex("FF0099"))
        setProperty("SPOOKY.color", getColorFromHex("FF0099"))
        setProperty("PICO.color", getColorFromHex("FF0099"))
        setProperty("TANKMAN.color", getColorFromHex("FF0099"))
        setProperty("SENPAI.color", getColorFromHex("FF0099"))
    elseif selecteddifficulty == 1 then
        setProperty("DAD.color", getColorFromHex("4219E6"))
        setProperty("BF.color", getColorFromHex("4219E6"))
        setProperty("menugdark.color", getColorFromHex("4219E6"))
        setProperty("menug.color", getColorFromHex("4219E6"))
        setProperty("MOM.color", getColorFromHex("4219E6"))
        setProperty("PARENT.color", getColorFromHex("4219E6"))
        setProperty("SPOOKY.color", getColorFromHex("4219E6"))
        setProperty("PICO.color", getColorFromHex("4219E6"))
        setProperty("TANKMAN.color", getColorFromHex("4219E6"))
        setProperty("SENPAI.color", getColorFromHex("4219E6"))
    end
    if keyJustPressed("right") then
        if selecting == "song" and selectedsong < 16 then
        selectedsong = selectedsong + 1
        playSound("scrollMenu", 1)
        doTweenX(">go", ">", 430, 0.1, "SineInOut")
        runTimer(">back", 0.3)
        elseif selecting == "difficulty" and selecteddifficulty < 1 then
            selecteddifficulty = selecteddifficulty + 1
            playSound("scrollMenu", 1)
            doTweenX(">2go", ">2", 370, 0.1, "SineInOut")
            runTimer(">2back", 0.3)
        end
        if selectedsong >= 1 and selectedsong <= 3 then
            setProperty("DAD.alpha", 1)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 4 and selectedsong <= 5 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 1)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 6 and selectedsong <= 8 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 1)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 9 and selectedsong <= 10 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 1)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 11 and selectedsong <= 12 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 1)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 13 and selectedsong <= 15 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 1)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 16 and selectedsong <= 16 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 1)
        end
    end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
        if selecting == "song" then
        playSound("confirmMenu", 1)
        selecting = "difficulty"
        setProperty('>2.alpha', 1)
        setProperty('<2.alpha', 1)
        setProperty('>.alpha', 0)
        setProperty('<.alpha', 0)
        elseif selecting == "difficulty" then
            playSound("confirmMenu", 1)
            objectPlayAnimation('BF', 'hey', true)
            selecting = "starting"
            runTimer("start", 2)
            setProperty('>2.alpha', 0)
            setProperty('<2.alpha', 0)
        end
    end
    if keyJustPressed("left") then
        if selecting == "song" and selectedsong > 1 then
        selectedsong = selectedsong - 1
        playSound("scrollMenu", 1)
        doTweenX("<go", "<", -170, 0.1, "SineInOut")
        runTimer("<back", 0.3)
    elseif selecting == "difficulty" and selecteddifficulty > 0 then
        selecteddifficulty = selecteddifficulty - 1
        playSound("scrollMenu", 1)
        doTweenX("<2go", "<2", -100, 0.1, "SineInOut")
        runTimer("<2back", 0.3)
        end
        if selectedsong >= 1 and selectedsong <= 3 then
            setProperty("DAD.alpha", 1)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 4 and selectedsong <= 5 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 1)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 6 and selectedsong <= 8 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 1)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 9 and selectedsong <= 10 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 1)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 11 and selectedsong <= 12 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 1)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 13 and selectedsong <= 15 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 1)
            setProperty("TANKMAN.alpha", 0)
        elseif selectedsong >= 16 and selectedsong <= 16 then
            setProperty("DAD.alpha", 0)
            setProperty("SPOOKY.alpha", 0)
            setProperty("PICO.alpha", 0)
            setProperty("MOM.alpha", 0)
            setProperty("PARENT.alpha", 0)
            setProperty("SENPAI.alpha", 0)
            setProperty("TANKMAN.alpha", 1)
        end
    end
    if selectedsong == 1 then
        setTextString("SongText", "Bopeebo")
        song = "Bopeebo"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 2 then
        setTextString("SongText", "Fresh")
        song = "Fresh"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 3 then
        setTextString("SongText", "Dad-Battle")
        song = "Dad-Battle"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 4 then
        setTextString("SongText", "Spookeez")
        song = "Spookeez"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 5 then
        setTextString("SongText", "South")
        song = "South"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 6 then
        setTextString("SongText", "Pico")
        song = "Pico"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 7 then
        setTextString("SongText", "Philly-Nice")
        song = "Philly-Nice"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 8 then
        setTextString("SongText", "Blammed")
        song = "Blammed"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 9 then
        setTextString("SongText", "Satin-Panties")
        song = "Satin-Panties"
        --setProperty("<.x", getProperty("SongText.text.length") - 150)
        --setProperty(">.x", getProperty("SongText.text.length") + 390)
    elseif selectedsong == 10 then
        setTextString("SongText", "High")
        song = "High"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 11 then
        setTextString("SongText", "Cocoa")
        song = "Cocoa"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 12 then
        setTextString("SongText", "Eggnog")
        song = "Eggnog"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 13 then
        setTextString("SongText", "Senpai")
        song = "Senpai"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 14 then
        setTextString("SongText", "Roses")
        song = "Roses"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 15 then
        setTextString("SongText", "Thorns")
        song = "Thorns"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    elseif selectedsong == 16 then
        setTextString("SongText", "Ugh")
        song = "Ugh"

        --setProperty("<.x", getProperty("SongText.text.length") - 90)
        --setProperty(">.x", getProperty("SongText.text.length") + 335)
    end
    if selecteddifficulty == 0 then
        setProperty("Erect.alpha", 1)
        setProperty("nightmare.alpha", 0)
        difficulty = "erect"
    elseif selecteddifficulty == 1 then
        setProperty("Erect.alpha", 0)
        setProperty("nightmare.alpha", 1)

        difficulty = "nightmare"
    end
end

function createBoyfriend()
    makeAnimatedLuaSprite('BF', 'erectselect/characters/Menu_BF', 900, 350)
    addAnimationByPrefix('BF', 'idle', 'M BF Idle0', 24, true)
    addAnimationByPrefix('BF', 'hey', 'M bf HEY', 24, false)
    objectPlayAnimation('BF', 'idle', true)
    addLuaSprite('BF', true)
    setObjectOrder('BF', 2)
    setProperty('BF.alpha', 1)
    setObjectCamera('BF', 'other')
end

function createEnemies()
    makeAnimatedLuaSprite('DAD', 'erectselect/characters/Menu_Dad', 100, 270)
    addAnimationByPrefix('DAD', 'idle', 'M Dad Idle0', 24, true)
    objectPlayAnimation('DAD', 'idle', true)
    addLuaSprite('DAD', true)
    setObjectOrder('DAD', 2)
    setProperty('DAD.scale.x', 1.2)
    setProperty('DAD.scale.y', 1.2)
    setProperty('DAD.alpha', 1)
    setObjectCamera('DAD', 'other')

    makeAnimatedLuaSprite('SPOOKY', 'erectselect/characters/Menu_Spooky_Kids', 50, 370)
    addAnimationByPrefix('SPOOKY', 'idle', 'M Spooky Kids Idle', 24, true)
    objectPlayAnimation('SPOOKY', 'idle', true)
    addLuaSprite('SPOOKY', true)
    setObjectOrder('SPOOKY', 2)
    setProperty('SPOOKY.scale.x', 1.3)
    setProperty('SPOOKY.scale.y', 1.3)
    setProperty('SPOOKY.alpha', 0)
    setObjectCamera('SPOOKY', 'other')

    makeAnimatedLuaSprite('PICO', 'erectselect/characters/Menu_Pico', 70, 420)
    addAnimationByPrefix('PICO', 'idle', 'M Pico Idle0', 24, true)
    objectPlayAnimation('PICO', 'idle', true)
    addLuaSprite('PICO', true)
    setObjectOrder('PICO', 2)
    setProperty('PICO.scale.x', 1.2)
    setProperty('PICO.scale.y', 1.2)
    setProperty('PICO.alpha', 0)
    setObjectCamera('PICO', 'other')

    makeAnimatedLuaSprite('MOM', 'erectselect/characters/Menu_Mom', 100, 270)
    addAnimationByPrefix('MOM', 'idle', 'M Mom Idle0', 24, true)
    objectPlayAnimation('MOM', 'idle', true)
    addLuaSprite('MOM', true)
    setObjectOrder('MOM', 2)
    setProperty('MOM.scale.x', 1.2)
    setProperty('MOM.scale.y', 1.2)
    setProperty('MOM.alpha', 0)
    setObjectCamera('MOM', 'other')

    makeAnimatedLuaSprite('PARENT', 'erectselect/characters/Menu_Parents', -30, 260)
    addAnimationByPrefix('PARENT', 'idle', 'M Parents Idle0', 24, true)
    objectPlayAnimation('PARENT', 'idle', true)
    addLuaSprite('PARENT', true)
    setObjectOrder('PARENT', 2)
    setProperty('PARENT.scale.x', 1.2)
    setProperty('PARENT.scale.y', 1.2)
    setProperty('PARENT.alpha', 0)
    setObjectCamera('PARENT', 'other')
    
    makeAnimatedLuaSprite('SENPAI', 'erectselect/characters/Menu_Senpai', 50, 350)
    addAnimationByPrefix('SENPAI', 'idle', 'M Senpai Idle0', 24, true)
    objectPlayAnimation('SENPAI', 'idle', true)
    addLuaSprite('SENPAI', true)
    setObjectOrder('SENPAI', 2)
    setProperty('SENPAI.scale.x', 1.2)
    setProperty('SENPAI.scale.y', 1.2)
    setProperty('SENPAI.alpha', 0)
    setObjectCamera('SENPAI', 'other')

    makeAnimatedLuaSprite('TANKMAN', 'erectselect/characters/Menu_Tankman', 75, 360)
    addAnimationByPrefix('TANKMAN', 'idle', 'M Tankman Idle0', 24, true)
    objectPlayAnimation('TANKMAN', 'idle', true)
    addLuaSprite('TANKMAN', true)
    setObjectOrder('TANKMAN', 2)
    setProperty('TANKMAN.scale.x', 1.2)
    setProperty('TANKMAN.scale.y', 1.2)
    setProperty('TANKMAN.alpha', 0)
    setObjectCamera('TANKMAN', 'other')
end


function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "start" then
        loadSong(song, selecteddifficulty)
    end
    if tag == ">back" then
        doTweenX(">", ">", getProperty(">.x") - 30, 0.1, "SineInOut")
    end
    if tag == "<back" then
        doTweenX("<", "<", getProperty("<.x") + 30, 0.1, "SineInOut")
    end
    if tag == ">2back" then
        doTweenX(">2", ">2", getProperty(">2.x") - 35, 0.1, "SineInOut")
    end
    if tag == "<2back" then
        doTweenX("<2", "<2", getProperty("<2.x") + 35, 0.1, "SineInOut")
    end
end