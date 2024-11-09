function onCreate()
    triggerEvent('Camera Follow Pos', 1500, 800)
    cameraSetTarget('boyfriend')
end

function onEvent(name, value1, value2)
    if name == 'Focus Camera' then
        if value1 == '1' then
            cameraSetTarget('dad')
            abotEyeMove('dad')
        elseif value1 == '2' then
            cameraSetTarget('boyfriend')
            abotEyeMove('boyfriend')
        elseif value1 == '3' then
            cameraSetTarget('gf')
            abotEyeMove('gf')
        end
    end
end