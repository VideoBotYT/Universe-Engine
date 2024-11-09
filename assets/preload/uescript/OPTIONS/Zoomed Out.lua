if UEhudZoomOut == false then
    UEhudZoomOut = true
end

if UEhudZoomOut == true then
    UEhudZoomOut = false
end

function onUpdate(elapsed)
    if UEhudZoomOut then
        setProperty('camHUD.zoom', lerp(getProperty('camHUD.zoom'), 0.9, elapsed))
        setProperty('camGame.zoom', lerp(getProperty('camGame.zoom'), getProperty('defaultCamZoom'), elapsed))
        setProperty('camZooming', false)
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        triggerEvent("Add Camera Zoom", 0.025, 0.025)
    end
end

function onChange()
    if UEhudZoomOut then
        UEhudZoomOut = false
        setProperty('camZooming', true)
        setProperty('ratings.alpha', 1)
        doTweenAlpha('ratingsin', 'ratings', 1, 0.3, 'linear')
    else
        UEhudZoomOut = true
        doTweenAlpha('ratingsout', 'ratings', 0, 0.5, 'linear')
    end
end

function lerp(a, b, ratio)
    return a + ratio * (b - a)
end
function onEvent(n)
    if n == 'Cinema' then
        onChange()
    end
end
