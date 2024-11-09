function onStepHit()
    if (curStep >= 672 and curStep < 800) or (curStep >= 928 and curStep < 1056) then
        if curStep % 4 == 0 then
            triggerEvent("Add Camera Zoom", "0.035", "0.04")
        end
    end
    if (curStep >= 1312 and curStep < 1440) then
        if curStep % 4 == 0 then
            triggerEvent("Add Camera Zoom", "0.035", "0.04")
        end
    end
end