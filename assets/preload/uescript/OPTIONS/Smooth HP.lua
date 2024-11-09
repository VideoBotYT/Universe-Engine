function onCreatePost()
    setProperty('healthBar.numDivisions', 10000)
end

local flip = false
local percent = 50
function onUpdatePost(e)
    if not hideHud then
        flip = getProperty('healthBar.flipX') or getProperty('healthBar.angle') == 180 or
                   getProperty('healthBar.scale.x') == -1

        percent = math.lerp(percent, math.max((getProperty('health') * 50), 0), (e * 10))
        setProperty('healthBar.percent', percent)
        if percent > 100 then
            percent = 100
        end

        local usePer = (flip and percent or remap(percent, 0, 100, 100, 0)) * 0.01
        local part1 = getProperty('healthBar.x') + ((getProperty('healthBar.width')) * usePer)
        local iconParts = {part1 + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26,
                           part1 - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2}

        for i = 1, 2 do
            setProperty('iconP' .. i .. '.x', iconParts[flip and ((i % 2) + 1) or i])
            setProperty('iconP' .. i .. '.flipX', flip)
        end
    end

    for i = 1, 2 do
        setProperty('iconP' .. i .. '.flipX', flip)
    end
end

function math.lerp(a, b, t)
    return (b - a) * t + a;
end

function remap(v, str1, stp1, str2, stp2)
    return str2 + (v - str1) * ((stp2 - str2) / (stp1 - str1));
end
