function onCreatePost()
    makeLuaText('UEdiffucultyLVL', '???', 500, 960, 30)
    setTextSize("UEdiffucultyLVL", 31)
    setTextAlignment("UEdiffucultyLVL", 'center')
    setTextFont("UEdiffucultyLVL", "funkin.ttf")
    setProperty("UEdiffucultyLVL.alpha", 0)
    setObjectCamera("UEdiffucultyLVL", 'other')
    addLuaText("UEdiffucultyLVL")
end

function onSongStart()
    doTweenAlpha("UEdiffucultyLVL A", "UEdiffucultyLVL", 1, 1, "linear")
    runTimer("UEdiffucultyLVL AT", 3,1)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'UEdiffucultyLVL AT' then
        doTweenAlpha("UEdiffucultyLVL A", "UEdiffucultyLVL", 0, 3, "linear")
    end
end

--[[
on how to use this:

function onUpdate()
    setTextString("UEdiffucultyLVL", "69") --the 69 is where you wanna set your difficulty level at 
end

if you have multiple difficulty then

function onUpdate()
    if difficulty == 0 then -- the first difficulty (easy)
        setTextString("UEdiffucultyLVL", "69") --the 69 is where you wanna set your difficulty level at 
    end
    
    if difficulty == 1 then -- the first difficulty (normal)
        setTextString("UEdiffucultyLVL", "69") --the 69 is where you wanna set your difficulty level at 
    end

    if difficulty == 2 then -- the first difficulty (hard)
        setTextString("UEdiffucultyLVL", "69") --the 69 is where you wanna set your difficulty level at 
    end
end

you can put this on the data files songs!
no need to put the script here :)

]]