function cancelalltween()
    cancelTween("iconP2ANG")
    cancelTween("iconP1ANG")

    cancelTween("iconP1 1y")
    cancelTween("iconP2 1y")
    cancelTween("iconP1 1x")
    cancelTween("iconP2 1x")

    cancelTween("iconP1 2y")
    cancelTween("iconP2 2y")
    cancelTween("iconP1 2x")
    cancelTween("iconP2 2x")
end

funnies = 1
funnies64 = 0.5
thingymabobo = 'expoOut'

funnies2 = 50
nuhuhy = 0.7
nuhuhx = 1.2
function beat1()
    setProperty('iconP2.angle', funnies2);
    doTweenAngle('iconP2ANG', 'iconP2', 0, funnies, thingymabobo);

    setProperty('iconP1.angle', funnies2);
    doTweenAngle('iconP1ANG', 'iconP1', 0, funnies, thingymabobo);

    setProperty('iconP1.scale.y', nuhuhy)
    setProperty('iconP2.scale.y', nuhuhx)
    setProperty('iconP1.scale.x', nuhuhy)
    setProperty('iconP2.scale.x', nuhuhx)

    doTweenY("iconP1 1y", "iconP1.scale", 1, funnies64, thingymabobo)
    doTweenY("iconP2 1y", "iconP2.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP1 1x", "iconP1.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP2 1x", "iconP2.scale", 1, funnies64, thingymabobo)
end

function beat2()
    setProperty('iconP2.angle', -funnies2);
    doTweenAngle('iconP2ANG', 'iconP2', 0, funnies,'expoOut');

    setProperty('iconP1.angle', -funnies2);
    doTweenAngle('iconP1ANG', 'iconP1', 0, funnies,'expoOut');

    setProperty('iconP1.scale.y', nuhuhx)
    setProperty('iconP2.scale.y', nuhuhy)
    setProperty('iconP1.scale.x', nuhuhx)
    setProperty('iconP2.scale.x', nuhuhy)

    doTweenY("iconP1 2y", "iconP1.scale", 1, funnies64, thingymabobo)
    doTweenY("iconP2 2y", "iconP2.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP1 2x", "iconP1.scale", 1, funnies64, thingymabobo)
    doTweenX("iconP2 2x", "iconP2.scale", 1, funnies64, thingymabobo)
end

function onBeatHit()
    if curBeat % 1 == 0 then
        cancelalltween()
        beat1()
    end
    if curBeat % 2 == 0 then
        cancelalltween()
        beat2()
    end
end

function onSongStart()
    beat2()
end