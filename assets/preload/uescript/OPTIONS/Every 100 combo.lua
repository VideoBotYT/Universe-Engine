local UEE100combo = 0

function onCreatePost()
    makeLuaSprite('UEE100comboF', nil, 0, 0)
    makeGraphic('UEE100comboF', screenWidth, screenHeight, '00FF00')
    addLuaSprite('UEE100comboF', true)
    setObjectCamera('UEE100comboF', 'other')
    setProperty("UEE100comboF.alpha", 0)
end

UE100combosound = {"GF_1", "GF_2", "GF_3", "GF_4"}
function goodNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
        UEE100combo = UEE100combo + 1
    end

    if UEE100combo == 100 then
        playAnim("gf", "cheer")

        if UE100comboSounds == "GF Sounds" then
            playSound(UE100combosound[getRandomInt(1,#UE100combosound)])
        end

        if UE100comboSounds == "Click Text" then
            playSound("clickText")
        end

        setProperty("UEE100comboF.alpha", 0.25)
        doTweenAlpha("UEE100comboF A", "UEE100comboF", 0, 1, "linear")

        UEE100combo = 0
    end
end

function noteMiss()
    UEE100combo = 0
end