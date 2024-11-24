local pbrgain = 0
local playbackrate = 1

function onCreate()
    setProperty("playbackRate", playbackrate)

    makeLuaText("UEpbrText", "PBR: "..playbackrate, 0, 10, 0)
    setTextAlignment("UEpbrText", "left")
    screenCenter("UEpbrText", "y")
    setTextSize("UEpbrText", 21)
    setObjectCamera("UEpbrText", "other")
    addLuaText("UEpbrText")

    if UEipbrv == "Normal" then
        pbrgain = 0.0005
    end
    if UEipbrv == "High" then
        pbrgain = 0.0010
    end
    if UEipbrv == "Very High" then
        pbrgain = 0.0020
    end
    if UEipbrv == "WTF" then
        pbrgain = 0.05
    end
    if UEipbrv == "Good Luck" then
        pbrgain = 0.5
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote == false then
        playbackrate = playbackrate + pbrgain
        setProperty("playbackRate", playbackrate)
        setTextString("UEpbrText", "PBR: "..playbackrate)
    end
end