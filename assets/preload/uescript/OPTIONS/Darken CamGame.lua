function onCreatePost()
    makeLuaSprite("darken", nil, 0, 0)
    makeGraphic("darken", screenWidth, screenHeight, '000000')
    screenCenter("darken")
    setObjectCamera("darken", "camHud")
    setProperty("darken.alpha", 0.75)
    addLuaSprite("darken", false)
end