function onCreatePost()
    local hpStuff = {'healthBar', 'healthBarBG', 'iconP1', 'iconP2', 'scoreTxt'}
    for i, v in pairs(hpStuff) do
        setObjectCamera(v, 'camGame')
        setScrollFactor(v, 1, 1)
        setProperty(v .. ".x", getProperty("boyfriend.x") - 500)
        setProperty(v .. ".y", getProperty("boyfriend.y"))

        setProperty('iconP1.y', getProperty("healthBar.y") - 80)
        setProperty('iconP2.y', getProperty("healthBar.y") - 80)

        setProperty('scoreTxt.x', getProperty("healthBar.x") - 340)
        setProperty('scoreTxt.y', getProperty("healthBar.y") + 60)
        setProperty('scoreTxt.size', 31)
    end
end

--[[
function onUpdate()
    if UEDetachedHB then
        setTextString("UEhealthdisplay",math.floor(getProperty('health') * 500 / 10) .. '%')
        setProperty('UEhealthdisplay.y', getProperty("healthBar.y") + 20)
        setProperty('UEhealthdisplay.x', getProperty("healthBar.x"))
    end
end
]]
