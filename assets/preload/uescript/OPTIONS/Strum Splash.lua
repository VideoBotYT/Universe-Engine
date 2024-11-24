local strumsplash = true
local strumFile = "strum/"
---@diagnostic disable

function onCreatePost()
    if strumsplash then
        posY = getPropertyFromGroup('playerStrums', 3, 'y')
        for i = 0, 3 do
            posXP = getPropertyFromGroup('playerStrums', 0, 'x')
            posXB = getPropertyFromGroup('playerStrums', 1, 'x')
            posXG = getPropertyFromGroup('playerStrums', 2, 'x')
            posXR = getPropertyFromGroup('playerStrums', 3, 'x')

            makeAnimatedLuaSprite("redthingnote", strumFile .. "holdCoverRed", posXR - 107, posY - 80 - 5)
            addAnimationByPrefix("redthingnote", "push", "holdCoverRed", 24, false)
            makeAnimatedLuaSprite("purple", strumFile .. "holdCoverPurple", posXP - 107, posY - 80 - 5)
            addAnimationByPrefix("purple", "idle", "holdCoverPurple0", 24, false)
            makeAnimatedLuaSprite("blue", strumFile .. "blueShit", posXB - 107, posY - 80 - 5)
            addAnimationByPrefix("blue", "push", "holdCoverBlue", 24, false)
            makeAnimatedLuaSprite("green", strumFile .. "holdCoverGreen", posXG - 107, posY - 80 - 5)
            addAnimationByPrefix("green", "push", "holdCoverGreen", 24, false)

            setProperty("redthingnote.visible", false)
            setProperty("purple.visible", false)
            setProperty("blue.visible", false)
            setProperty("green.visible", false)

            addLuaSprite("redthingnote", true)
            addLuaSprite("purple", true)
            addLuaSprite("blue", true)
            addLuaSprite("green", true)
        end
    end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if strumsplash then
        if noteData == 0 and isSustainNote == true then
            setProperty("purple.visible", true)
            playAnim("purple", "idle", true)
            runTimer("byePurple", 0.56)
        elseif noteData == 2 and isSustainNote == true then
            setProperty("green.visible", true)
            playAnim("green", "push", true)
            runTimer("byeGreen", 0.56)
        elseif noteData == 1 and isSustainNote == true then
            setProperty("blue.visible", true)
            playAnim("blue", "push", true)
            runTimer("byeBlue", 0.56)
        elseif noteData == 3 and isSustainNote == true then
            setProperty("redthingnote.visible", true)
            playAnim("redthingnote", "push", true)
            runTimer("byeredthingnote", 0.56)
        end
    end
end

function onTimerCompleted(tag)
    if strumsplash then
        if tag == "byePurple" then
            setProperty("purple.visible", false)
        end
        if tag == "byeBlue" then
            setProperty("blue.visible", false)
        end
        if tag == "byeGreen" then
            setProperty("green.visible", false)
        end
        if tag == "byeredthingnote" then
            setProperty("redthingnote.visible", false)
        end
    end
end

function onUpdate(elapsed)
    if strumsplash then
        local isPixel = getPropertyFromClass("PlayState", "isPixelStage")
        setObjectCamera("purple", 'hud')
        setObjectCamera("green", 'hud')
        setObjectCamera("blue", 'hud')
        setObjectCamera("redthingnote", 'hud')
        if isPixel == true then
            removeLuaSprite("redthingnote", true);
            removeLuaSprite("blue", true);
            removeLuaSprite("green", true);
            removeLuaSprite("purple", true);
        end
        for i = 0, 3 do
            local newPos0 = getPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0);
            local newPos1 = getPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1);
            local newPos2 = getPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2);
            local newPos3 = getPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3);

            setProperty("redthingnote.x", newPos3 - 107)
            setProperty("blue.x", newPos1 - 107)
            setProperty("purple.x", newPos0 - 107)
            setProperty("green.x", newPos2 - 107)
        end
        for i = 0, 3 do
            local newPos0y = getPropertyFromGroup('playerStrums', 0, 'y', defaultPlayerStrumY0);
            local newPos1y = getPropertyFromGroup('playerStrums', 1, 'y', defaultPlayerStrumY1);
            local newPos2y = getPropertyFromGroup('playerStrums', 2, 'y', defaultPlayerStrumY2);
            local newPos3y = getPropertyFromGroup('playerStrums', 3, 'y', defaultPlayerStrumY3);
            setProperty("redthingnote.y", newPos3y - 80)
            setProperty("blue.y", newPos1y - 80)
            setProperty("purple.y", newPos0y - 80)
            setProperty("green.y", newPos2y - 80)
        end
    end
end
