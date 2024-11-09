YHpos = 670
XHpos = 30
local uenah = false
function onCreatePost()
    makeLuaText('UEsong', "", 500, XHpos, 30)
    setTextSize('UEsong', 21)
    addLuaText('UEsong')
    setTextFont('UEsong', "funkin.ttf")
    setTextAlignment("UEsong", 'left')

    makeLuaText('UEtimeTxt', '', 500, XHpos, 60)
    setTextSize('UEtimeTxt', 31)
    addLuaText('UEtimeTxt')
    setTextFont('UEtimeTxt', "funkin.ttf")
    setTextAlignment("UEtimeTxt", 'left')
    setProperty("UEtimeTxt.alpha", 0)

    makeLuaText('UEmiss', '', 500, XHpos, YHpos - 40)
    setTextSize('UEmiss', 21)
    addLuaText('UEmiss')
    setTextFont('UEmiss', "funkin.ttf")
    setTextAlignment("UEmiss", 'left')

    makeLuaText('UEscore', '', 500, XHpos, YHpos - 20)
    setTextSize('UEscore', 21)
    addLuaText('UEscore')
    setTextFont('UEscore', "funkin.ttf")
    setTextAlignment("UEscore", 'left')

    makeLuaText('UErating', '', 500, XHpos, YHpos)
    setTextSize('UErating', 21)
    addLuaText('UErating')
    setTextFont('UErating', "funkin.ttf")
    setTextAlignment("UErating", 'left')

    setProperty('scoreTxt.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('UEtimeTxt.x', getProperty("UEsong.x"))

    setTextAlignment('UEtimeTxt', 'left')
    setTextFont('UEtimeTxt', 'funkin.ttf')
    setTextFont('botplayTxt', 'funkin.ttf')

    if UEhudPos == 'left' then

    end

    if UEhudPos == 'CENTER' then
        -- setProperty('UEmiss.x', 390 - 10)
        screenCenter("UEmiss")
        setProperty('UEmiss.y', YHpos - 40)
        setProperty('UEscore.x', getProperty("UEmiss.x"))
        setProperty('UErating.x', getProperty("UEmiss.x"))

        setTextAlignment("UEmiss", 'center')
        setTextAlignment("UEscore", 'center')
        setTextAlignment("UErating", 'center')

        if UEsnTimeFollow then
            setProperty('UEsong.x', getProperty("UEmiss.x"))
            setProperty('UEsong.y', 140)
            if UEDetachedHB then
                setProperty('UEsong.y', 30)
            end
            setProperty('UEtimeTxt.x', getProperty("UEsong.x"))
            setProperty('UEtimeTxt.y', getProperty("UEsong.y") + 30)
            setTextAlignment("UEsong", 'center')
            setTextAlignment("UEtimeTxt", 'center')
        end
    end

    if UEhudPos == 'RIGHT' then
        setProperty('UEmiss.x', 740)
        setProperty('UEscore.x', getProperty("UEmiss.x"))
        setProperty('UErating.x', getProperty("UEmiss.x"))

        setTextAlignment("UEmiss", 'right')
        setTextAlignment("UEscore", 'right')
        setTextAlignment("UErating", 'right')

        if UEsnTimeFollow then
            setProperty('UEsong.x', 740)
            setProperty('UEtimeTxt.x', getProperty("UEsong.x"))
            setTextAlignment("UEsong", 'right')
            setTextAlignment("UEtimeTxt", 'right')
        end
    end

    if uenah then
        setProperty('timeBarBG.visible', true)
        setProperty('timeBar.visible', true)
        setProperty('timeBarBG.x', getProperty("UEtimeTxt.x") - 120)
        setProperty('timeBarBG.y', getProperty("UEtimeTxt.y") + 12)
        setProperty('timeBar.x', getProperty("UEtimeTxt.x") - 120)
        setProperty('timeBar.y', getProperty("UEtimeTxt.y") + 12)
        setProperty('timeBarBG.scale.x', 0.4)
        setProperty('timeBar.scale.x', 0.4)
    end
end

--code from funkin' paradice :3
function startTyping(textObj, str, timeBetweenLetter)
    if not timeBetweenLetter then
        timeBetweenLetter = 0.1
    end
    runTimer('TEXTANIM:' .. textObj .. '--' .. str, timeBetweenLetter, #str)
end

-- code from Bingo Endless :3
function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)
end

function onUpdatePost(elapsed)
    --[[
    for i = 0, 3 do
        arrowUP_x = getPropertyFromGroup('playerStrums', 2, 'x')
        arrowUP_y = getPropertyFromGroup('playerStrums', 2, 'y')
    end

    setProperty('botplayTxt.x', arrowUP_x - 240)
    setProperty('botplayTxt.y', arrowUP_y - 40)
    setProperty('botplayTxt.alpha', 1)
    ]]

    -- code from Bingo Endless :3
    setTextString('UEtimeTxt', formatTime(getSongPosition() - noteOffset) .. ' / ' .. formatTime(songLength))

    -- not from bingo endless
    setProperty('botplayTxt.alpha', 1)

    if hits < 1 then
        setTextString('UErating', 'Rating: (N/A) 0%')
        setTextString('UEscore', 'Score: 0')
    end

    if hits > 0 then
        setTextString('UErating', 'Rating: (' .. ratingFC .. ') ' .. round(rating * 100, 2) .. '%')
        setTextString('UEscore', 'Score: ' .. score)
    end
end

function noteMiss()
    cancelTimer("UEH Disspear")
    cancelTimer("UEHM Disspear")

    cancelTween("UEmiss m")
    cancelTween("UEscore h")
    cancelTween("UErating h")

    setProperty("UEmiss.alpha", 1)
    setProperty("UEscore.alpha", 1)
    setProperty("UErating.alpha", 1)

    runTimer("UEH Disspear", 1, 1)
    runTimer("UEHM Disspear", 1, 1)

    cancelTween("UEmiss red")
    cancelTween("UEscore red")
    cancelTween("UErating red")

    setTextColor('UEscore', 'FF2B2B')
    setTextColor('UEmiss', 'FF2B2B')
    setTextColor('UErating', 'FF2B2B')

    doTweenColor('UEmiss red', 'UEmiss', 'FFFFFF', '1', 'linear')
    doTweenColor('UEscore red', 'UEscore', 'FFFFFF', '1', 'linear')
    doTweenColor('UErating red', 'UErating', 'FFFFFF', '1', 'linear')

    setTextString('UEmiss', 'Screw-Ups: ' .. misses)
end

function goodNoteHit()
    cancelTimer("UEH Disspear")

    cancelTween("UEscore h")
    cancelTween("UErating h")

    setProperty("UEscore.alpha", 1)
    setProperty("UErating.alpha", 1)
    runTimer("UEH Disspear", 1, 1)
end

function onSongStart()
    doTweenAlpha("UEmiss s", "UEmiss", 0.5, 1, "linear")
    doTweenAlpha("UEscore s", "UEscore", 0.5, 1, "linear")
    doTweenAlpha("UErating s", "UErating", 0.5, 1, "linear")
    if not UEhidetimeBar then doTweenAlpha("UEtimeTxt s", "UEtimeTxt", 1, 1, "linear") end

    startTyping('UEsong', songName .. " - " .. difficultyName, 0.1)
end

ueBPTsizeR = 0.75
ueBPTsize = 1.5
ueBPTdur = 0.25
function onBeatHit()
    if curBeat % 1 == 0 then
        --cancelTween("UEMtextSizeX")
        cancelTween("UEMtextSizeY")
        --setProperty('botplayTxt.scale.x', ueBPTsize);
        setProperty('botplayTxt.scale.y', ueBPTsize)
        --doTweenX('UEMtextSizeX', 'botplayTxt.scale', 1, ueBPTdur, 'linear');
        doTweenY('UEMtextSizeY', 'botplayTxt.scale', 1, ueBPTdur, 'linear')
    end

    if curBeat % 2 == 0 then
        cancelTween("UEMtextSizeXR")
        --cancelTween("UEMtextSizeYR")
        setProperty('botplayTxt.scale.x', ueBPTsizeR);
        --setProperty('botplayTxt.scale.y', ueBPTsizeR)
        doTweenX('UEMtextSizeXR', 'botplayTxt.scale', 1, ueBPTdur, 'linear');
        --doTweenY('UEMtextSizeYR', 'botplayTxt.scale', 1, ueBPTdur, 'linear')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "UEH Disspear" then
        doTweenAlpha("UEscore h", "UEscore", 0.5, 1, "linear")
        doTweenAlpha("UErating h", "UErating", 0.5, 1, "linear")
    end

    if tag == "UEHM Disspear" then
        doTweenAlpha("UEmiss m", "UEmiss", 0.5, 1, "linear")
    end

    if (tag:match('^TEXTANIM:')) then
        local obj, str = tag:match('^TEXTANIM:(.-)%-%-(.+)')
        setTextString(obj, str:sub(0, loops - loopsLeft))
    end
end

function round(x, n) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end
