local pastFrameName = nil
local pastDadFrameName = nil

-- by cjred
-- modified by an ammar
-- modified by uwenalil
function onCreatePost()
    makeAnimatedLuaSprite('boyfriendTrail', getProperty('boyfriend.imageFile'),getProperty('boyfriend.x'),getProperty('boyfriend.y'))
    addLuaSprite('boyfriendTrail', false)
    setProperty('boyfriendTrail.scale.x',getProperty('boyfriend.scale.x'))
    setProperty('boyfriendTrail.scale.y',getProperty('boyfriend.scale.y'))
    setProperty('boyfriendTrail.flipX', getProperty('boyfriend.flipX'))
    setProperty('boyfriendTrail.color', getProperty('boyfriend.color'))
    setProperty('boyfriendTrail.alpha', 0)

    makeAnimatedLuaSprite('dadTrail', getProperty('dad.imageFile'),getProperty('dad.x'),getProperty('dad.y'))
    addLuaSprite('dadTrail', false)
    setProperty('dadTrail.scale.x',getProperty('dad.scale.x'))
    setProperty('dadTrail.scale.y',getProperty('dad.scale.y'))
    setProperty('dadTrail.flipX', getProperty('dad.flipX'))
    setProperty('dadTrail.color', getProperty('dad.color'))
    setProperty('dadTrail.alpha', 0)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote == false then
        makeAnimatedLuaSprite('boyfriendTrail', getProperty('boyfriend.imageFile'),getProperty('boyfriend.x'),getProperty('boyfriend.y'))
        addLuaSprite('boyfriendTrail', false)
        setProperty('boyfriendTrail.scale.x',getProperty('boyfriend.scale.x'))
        setProperty('boyfriendTrail.scale.y',getProperty('boyfriend.scale.y'))
        setProperty('boyfriendTrail.flipX', getProperty('boyfriend.flipX'))
        setProperty('boyfriendTrail.color', getProperty('boyfriend.color'))
        setProperty('boyfriendTrail.alpha', 0)

        if pastFrameName ~= nil then
            setProperty('boyfriendTrail.animation.frameName', pastFrameName)
            setProperty('boyfriendTrail.offset.x', pastFrameX)
            setProperty('boyfriendTrail.offset.y', pastFrameY)
            setProperty('boyfriendTrail.alpha', 1)
            doTweenAlpha('boyfriendTrailAlpha', 'boyfriendTrail', 0, 0.4)
            cancelTimer('framingnt')
        end
        pastFrameName = getProperty('boyfriend.animation.frameName')
        pastFrameX = getProperty('boyfriend.offset.x')
        pastFrameY = getProperty('boyfriend.offset.y')
        runTimer('framingnt', 0.03, 1)

        doTweenX("boyfriendTrailMoveX" ,'boyfriendTrail.offset', pastFrameX - 50, 0.4, "quadOut")
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote == false then
        makeAnimatedLuaSprite('dadTrail', getProperty('dad.imageFile'),getProperty('dad.x'),getProperty('dad.y'))
        addLuaSprite('dadTrail', false)
        setProperty('dadTrail.scale.x',getProperty('dad.scale.x'))
        setProperty('dadTrail.scale.y',getProperty('dad.scale.y'))
        setProperty('dadTrail.flipX', getProperty('dad.flipX'))
        setProperty('dadTrail.color', getProperty('dad.color'))
        setProperty('dadTrail.alpha', 0)

        if pastDadFrameName ~= nil then
            setProperty('dadTrail.animation.frameName', pastDadFrameName)
            setProperty('dadTrail.offset.x', pastDadFrameX)
            setProperty('dadTrail.offset.y', pastDadFrameY)
            setProperty('dadTrail.alpha', 1)
            doTweenAlpha('dadTrailAlpha', 'dadTrail', 0, 0.4)
            cancelTimer('framingntDad')
        end
        pastDadFrameName = getProperty('dad.animation.frameName')
        pastDadFrameX = getProperty('dad.offset.x')
        pastDadFrameY = getProperty('dad.offset.y')
        runTimer('framingntDad', 0.03, 1)

        doTweenX("dadTrailMoveX" ,'dadTrail.offset', pastDadFrameX + 50, 0.4, "quadOut")
    end
end

function onTimerCompleted(tag)
    if tag == 'framingnt' then
        pastFrameName = nil
    end

    if tag == 'framingntDad' then
        pastDadFrameName = nil
    end
end
