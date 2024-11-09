local UEmisses = 0
aagth = 20
whataver = 2
UEccY = 520
function onCreatePost()
    makeLuaText("UE ratingTxt", "", 500, 0, 0)
    screenCenter("UE ratingTxt")
    setProperty('UE ratingTxt.y', UEccY)
    setTextSize("UE ratingTxt", 41)
	setTextFont('UE ratingTxt', 'funkin.ttf')
	setTextAlignment('UE ratingTxt', 'center')
    setProperty('UE ratingTxt.alpha', 0.5)
	addLuaText('UE ratingTxt')

    makeLuaText("UE comboTxt", "", 500, getProperty("UE ratingTxt.x"), UEccY + 40)
    setTextSize("UE comboTxt", getProperty('UE ratingTxt.size'))
	setTextFont('UE comboTxt', 'funkin.ttf')
	setTextAlignment('UE comboTxt', 'center')
    setProperty('UE comboTxt.alpha', 0.5)
	addLuaText('UE comboTxt')

    setProperty('showRating', false);
    setProperty('showComboNum', false);

    setTextString("UE ratingTxt", "N/A")
    setTextString("UE comboTxt", "?")
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    --code by silverspringing
    --modified by yours truly, uwenalil
    local rawNoteRating = getPropertyFromGroup('notes', id, 'rating')
	local noteRating = rawNoteRating

    if not isSustainNote then
        if rawNoteRating == 'sick' then
            noteRating = "Sick!"
            colorRating = "86BCFF"

        elseif rawNoteRating == 'good' then
            noteRating = "Good"
            colorRating = "91C53C"
    
        elseif rawNoteRating == 'bad' then
            noteRating = "Bad"
            colorRating = "C7463F"
    
        elseif rawNoteRating == 'shit' then
            noteRating = "?!?!!"
            colorRating = "919191"
        end
    
        if botPlay then
            noteRating = "BOTPLAY"
            colorRating = "FFC802"
        end

        --code by me bla bla bla
        setTextString("UE ratingTxt", noteRating)
        setTextColor("UE ratingTxt", colorRating)
        setTextString("UE comboTxt", getProperty('combo'))
        setTextColor("UE comboTxt", colorRating)
        runTimer("UE comboRatingTXT A", 1, 1)
    end
    UEmisses = 0
    cancelTimer("UE comboRatingTXT D")
    cancelTween("UE ratingTxt A")
    cancelTween("UE comboTxt A")
    setProperty('UE ratingTxt.alpha', 1)
    setProperty('UE comboTxt.alpha', 1)

    setProperty("UE ratingTxt.y", UEccY + aagth)
    setProperty("UE comboTxt.y", UEccY + 40 + aagth)
    doTweenY("UE ratingTxt H", "UE ratingTxt", UEccY, whataver, "expoOut")
    doTweenY("UE comboTxt H", "UE comboTxt", UEccY + 40, whataver, "expoOut")
end

function noteMiss(id, direction, noteType, isSustainNote)
    UEmisses = UEmisses + 1

    cancelTimer("UE comboRatingTXT D")
    cancelTween("UE ratingTxt A")
    cancelTween("UE comboTxt A")
    setProperty('UE ratingTxt.alpha', 1)
    setProperty('UE comboTxt.alpha', 1)

    setTextString("UE ratingTxt", "Miss...")
    setTextColor("UE ratingTxt", 'FF2B2B')
    setTextString("UE comboTxt", "-"..UEmisses)
    setTextColor("UE comboTxt", 'FF2B2B')
    runTimer("UE comboRatingTXT A", 1, 1)

    setProperty("UE ratingTxt.y", UEccY + aagth)
    setProperty("UE comboTxt.y", UEccY + 40 + aagth)
    doTweenY("UE ratingTxt H", "UE ratingTxt", UEccY, whataver, "expoOut")
    doTweenY("UE comboTxt H", "UE comboTxt", UEccY + 40, whataver, "expoOut")
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'UE comboRatingTXT A' then
        doTweenAlpha("UE ratingTxt A", "UE ratingTxt", 0.5, 0.5, "linear")
        doTweenAlpha("UE comboTxt A", "UE comboTxt", 0.5, 0.5, "linear")
    end
end