UEtheypopup = 160
UEtheygone = 570
UEtheypopuphi = 1
UEtheypopuppos = 10
function onCreatePost(value1)
    makeLuaText("UE song name popup", songName.. "\n " ..difficultyName.. "\n  " ..bpm.. " BPM", 0, -1000, UEtheypopup)
    setTextSize("UE song name popup", 31)
    setTextAlignment("UE song name popup", "left")
    setObjectCamera("UE song name popup", 'other')
    setTextFont("UE song name popup", "funkin.ttf")
    addLuaText("UE song name popup")

    --[[
    makeLuaText("UE difficulty popup", difficultyName, 0, getProperty("UE song name popup.x"), UEtheypopup + 40)
    setTextSize("UE difficulty popup", 31)
    setObjectCamera('UE difficulty popup', 'other')
    setTextFont("UE difficulty popup", "funkin.ttf")
    addLuaText("UE difficulty popup")
    ]]

    makeLuaText("UE info 1", "", 0, getProperty("UE song name popup.x"), UEtheypopup + 110)
    setTextSize("UE info 1", 21)
    setTextAlignment("UE info 1", "left")
    setObjectCamera('UE info 1', 'other')
    setTextFont("UE info 1", "funkin.ttf")
    addLuaText("UE info 1")

    makeLuaText("UE info 2", "", 0, getProperty("UE song name popup.x"), getProperty("UE info 1.y") + 25)
    setTextSize("UE info 2", 21)
    setTextAlignment("UE info 2", "left")
    setObjectCamera('UE info 2', 'other')
    setTextFont("UE info 2", "funkin.ttf")
    addLuaText("UE info 2")
end

function onSongStart()
    doTweenX("UE song name popup hi", "UE song name popup", UEtheypopuppos, UEtheypopuphi, "expoOut")
    --doTweenX("UE difficulty popup hi", "UE difficulty popup", UEtheypopuppos, UEtheypopuphi, "expoOut")
    doTweenX("UE info 1 hi", "UE info 1", UEtheypopuppos, UEtheypopuphi, "expoOut")
    doTweenX("UE info 2 hi", "UE info 2", UEtheypopuppos, UEtheypopuphi, "expoOut")
    runTimer("UE they go bye", 3, 1)
    runTimer("UE text remove bye", 10, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'UE they go bye' then
        doTweenX("UE song name popup hi", "UE song name popup", -1000, UEtheypopuphi, "expoIn")
        --doTweenX("UE difficulty popup hi", "UE difficulty popup", -1000, UEtheypopuphi, "expoIn")
        doTweenX("UE info 1 hi", "UE info 1", -1000, UEtheypopuphi, "expoIn")
        doTweenX("UE info 2 hi", "UE info 2", -1000, UEtheypopuphi, "expoIn")
    end
    if tag == 'UE text remove bye' then
        removeLuaText("UE song name popup")
        --removeLuaText("UE difficulty popup")
        removeLuaText("UE info 1")
        removeLuaText("UE info 2")
    end
end

function onEvent(name, value1, value2)
    if name == "Song Name Info" then
        setTextString("UE info 1", "   "..value1)
        setTextString("UE info 2", "    "..value2)
    end
end