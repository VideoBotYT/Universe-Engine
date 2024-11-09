local arrowSwitching = false; -- Arrow switching between singers (Doesn't work if MiddleScroll is enabled)
local oppnoanim = true; -- self explain
local arrowgone = false; -- opp notes gone
local middlescrollye = true -- self exlpain
local mode = 'Extreme';
-- Play mode:
-- Extreme - plays all of the notes in the chart, can be unfair due to overlapping hold notes
-- Camera - plays only the notes of who camera is focusing at the moment

local cameraBotTime = 0.3; -- Amount of seconds that botplay would be active when camera switches it's target (For Camera Mode)

function string:startswith(start)
    return self:sub(1, #start) == start
end

function string:endswith(ending)
    return ending == "" or self:sub(-#ending) == ending
end

local hasMiss = false;
local playerNoteTime = -1000;
local opponentNoteTime = -1000;
local arrowMode = 0;
local curFocus;

function changeNotes()
    -- debugPrint('actiavted'); pico funny
    noteCount = getProperty('notes.length');
    for i = 0, noteCount - 1 do
        setPropertyFromGroup('notes', i, 'mustPress', not getPropertyFromGroup('notes', i, 'mustPress'));
        setPropertyFromGroup('notes', i, 'noAnimation', not getPropertyFromGroup('notes', i, 'noAnimation'));
        if getPropertyFromGroup('notes', i, 'mustPress') and
            (getPropertyFromGroup('notes', i, 'strumTime') - getPropertyFromClass('Conductor', 'songPosition') <=
                cameraBotTime * 1000) then
            setPropertyFromGroup('notes', i, 'mustPress', false);
            setPropertyFromGroup('notes', i, 'noAnimation', true);
        end
    end
    unspawnNotesCount = getProperty('unspawnNotes.length');
    for i = 0, unspawnNotesCount - 1 do
        setPropertyFromGroup('unspawnNotes', i, 'mustPress', not getPropertyFromGroup('unspawnNotes', i, 'mustPress'));
        setPropertyFromGroup('unspawnNotes', i, 'noAnimation',
            not getPropertyFromGroup('unspawnNotes', i, 'noAnimation'));
    end
end

function onCreatePost()
    if mode:lower() ~= 'extreme' and mode:lower() ~= 'camera' then
        mode = 'Extreme';
    end
    -- makeLuaText('warning', 'Playing both sides.\nMode: ' .. mode, 700, screenWidth / 4.2, screenHeight / 2);
    -- setTextSize('warning', 54);
    -- addLuaText('warning');
    hasMiss = getProperty('boyfriend.hasMissAnimations');
    unspawnNotesCount = getProperty('unspawnNotes.length');
    for i = 0, unspawnNotesCount - 1 do
        if mode:lower() == 'extreme' then
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'mustPress', true);
                setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
            end
        end
    end
    setProperty('dad.singDuration', 999);
    setProperty('boyfriend.singDuration', 999);
end

function onSongStart()
    doTweenAlpha('warningTween', 'warning', 0, 1, 'linear');
    curFocus = mustHitSection and 'bf' or 'dad';
end

function onUpdatePost()
    if middlescrollye then
        noteTweenX("NoteMove1", 4, 415, 0.5, cubeInOut)
        noteTweenX("NoteMove2", 5, 525, 0.5, cubeInOut)
        noteTweenX("NoteMove3", 6, 635, 0.5, cubeInOut)
        noteTweenX("NoteMove4", 7, 745, 0.5, cubeInOut)

        noteTweenAngle("NoteAngle1", 4, -360, 0.5, cubeInOut)
        noteTweenAngle("NoteAngle2", 5, -360, 0.5, cubeInOut)
        noteTweenAngle("NoteAngle3", 6, -360, 0.5, cubeInOut)
        noteTweenAngle("NoteAngle4", 7, -360, 0.5, cubeInOut)

        noteTweenAlpha("NoteMove5", 0, 0, 0.5, cubeInOut)
        noteTweenAlpha("NoteMove6", 1, 0, 0.5, cubeInOut)
        noteTweenAlpha("NoteMove7", 2, 0, 0.5, cubeInOut)
        noteTweenAlpha("NoteMove8", 3, 0, 0.5, cubeInOut)
    end

    if (getPropertyFromGroup('opponentStrums', 3, 'alpha') ~= 0) and mode:lower() ~= 'camera' then
        if arrowgone then
            noteTweenAlpha('die1', 0, 0, 0.3, 'linear');
            noteTweenAlpha('die2', 1, 0, 0.3, 'linear');
            noteTweenAlpha('die3', 2, 0, 0.3, 'linear');
            noteTweenAlpha('die4', 3, 0, 0.3, 'linear');
        end
    elseif mode:lower() == 'camera' then
        setPropertyFromGroup('opponentStrums', 0, 'x', getPropertyFromGroup('playerStrums', 0, 'x'));
        setPropertyFromGroup('opponentStrums', 1, 'x', getPropertyFromGroup('playerStrums', 1, 'x'));
        setPropertyFromGroup('opponentStrums', 2, 'x', getPropertyFromGroup('playerStrums', 2, 'x'));
        setPropertyFromGroup('opponentStrums', 3, 'x', getPropertyFromGroup('playerStrums', 3, 'x'));

        if arrowgone then
            noteTweenAlpha('live1', 0, 0.2, 0.3, 'linear');
            noteTweenAlpha('live2', 1, 0.2, 0.3, 'linear');
            noteTweenAlpha('live3', 2, 0.2, 0.3, 'linear');
            noteTweenAlpha('live4', 3, 0.2, 0.3, 'linear');
        end
    end
    playerNoteTime = -1000;
    opponentNoteTime = -1000;
    noteCount = getProperty('notes.length');
    for i = 0, noteCount - 1 do
        if getPropertyFromGroup('notes', i, 'mustPress') and not getPropertyFromGroup('notes', i, 'noAnimation') then
            if playerNoteTime == -1000 or getPropertyFromGroup('notes', i, 'strumTime') < playerNoteTime then
                playerNoteTime = getPropertyFromGroup('notes', i, 'strumTime');
            end
        else
            if opponentNoteTime == -1000 or getPropertyFromGroup('notes', i, 'strumTime') < opponentNoteTime then
                opponentNoteTime = getPropertyFromGroup('notes', i, 'strumTime');
            end
        end
    end
    if arrowSwitching and not middlescroll then
        if arrowMode == 2 then
            for i = 4, 7, 1 do
                noteTweenX('ok' .. i, i, 42 + screenWidth / 2 + ((i - 3) * getPropertyFromClass('Note', 'swagWidth')),
                    0.5, 'linear');
            end
        elseif arrowMode == 1 then
            for i = 4, 7, 1 do
                noteTweenX('ok' .. i, i, 42 + ((i - 3) * getPropertyFromClass('Note', 'swagWidth')), 0.5, 'linear');
            end
        elseif arrowMode == 0 then
            for i = 4, 7, 1 do
                noteTweenX('ok' .. i, i, -330 + screenWidth / 2 + ((i - 3) * getPropertyFromClass('Note', 'swagWidth')),
                    0.5, 'linear');
            end
        end
    end
end

function onMoveCamera(focus)
    if curStep > -1 and curFocus ~= focus and mode:lower() == 'camera' then
        curFocus = focus;
        changeNotes();
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if oppnoanim then
        if getPropertyFromGroup('notes', id, 'noAnimation') == true then
            if direction == 0 then
                characterPlayAnim('dad', 'singLEFT', true);
            elseif direction == 1 then
                characterPlayAnim('dad', 'singDOWN', true);
            elseif direction == 2 then
                characterPlayAnim('dad', 'singUP', true);
            elseif direction == 3 then
                characterPlayAnim('dad', 'singRIGHT', true);
            end
        end
    end
end

function opponentNoteHit(id, direction)
    if oppnoanim then
        if getPropertyFromGroup('notes', id, 'noAnimation') == true then
            if direction == 0 then
                characterPlayAnim('boyfriend', 'singLEFT', true);
            elseif direction == 1 then
                characterPlayAnim('boyfriend', 'singDOWN', true);
            elseif direction == 2 then
                characterPlayAnim('boyfriend', 'singUP', true);
            elseif direction == 3 then
                characterPlayAnim('boyfriend', 'singRIGHT', true);
            end
        end
    end
end

function noteMiss(id, direction)
    if oppnoanim then
        if getPropertyFromGroup('notes', id, 'noAnimation') == true then
            if hasMiss then
                setProperty('boyfriend.hasMissAnimations', false);
                characterPlayAnim('boyfriend', 'idle');
            end
            if getProperty('dad.hasMissAnimations') then
                if direction == 0 then
                    characterPlayAnim('dad', 'singLEFTmiss', true);
                elseif direction == 1 then
                    characterPlayAnim('dad', 'singDOWNmiss', true);
                elseif direction == 2 then
                    characterPlayAnim('dad', 'singUPmiss', true);
                elseif direction == 3 then
                    characterPlayAnim('dad', 'singRIGHTmiss', true);
                end
            end
        else
            if not getProperty('boyfriend.hasMissAnimations') and hasMiss then
                setProperty('boyfriend.hasMissAnimations', true);
                if direction == 0 then
                    characterPlayAnim('boyfriend', 'singLEFTmiss', true);
                elseif direction == 1 then
                    characterPlayAnim('boyfriend', 'singDOWNmiss', true);
                elseif direction == 2 then
                    characterPlayAnim('boyfriend', 'singUPmiss', true);
                elseif direction == 3 then
                    characterPlayAnim('boyfriend', 'singRIGHTmiss', true);
                end
            end
        end
    end
end

function onBeatHit()
    if ((not getProperty('dad.animation.curAnim.name'):startswith('sing') or
        getProperty('dad.animation.curAnim.finished')) or (getProperty('dad.animation.curAnim.name'):endswith('-loop'))) and
        not getProperty('dad.specialAnim') then
        if (getProperty('dad.animation.curAnim.name') == 'idle' and not getProperty('dad.animation.curAnim.finished')) then
            return function_continue;
        end
        characterPlayAnim('dad', 'idle', true);
    end
    if ((not getProperty('dad.animation.curAnim.name'):startswith('sing') or
        getProperty('boyfriend.animation.curAnim.finished')) or
        (getProperty('boyfriend.animation.curAnim.name'):endswith('-loop'))) and
        not getProperty('boyfriend.specialAnim') then
        if (getProperty('boyfriend.animation.curAnim.name') == 'idle' and
            not getProperty('boyfriend.animation.curAnim.finished')) then
            return function_continue;
        end
        characterPlayAnim('boyfriend', 'idle', true);
    end
    if playerNoteTime == -1000 and opponentNoteTime == -1000 then
        arrowMode = 0;
    elseif playerNoteTime - getPropertyFromClass('Conductor', 'songPosition') < 200 and
        (opponentNoteTime == -1000 or opponentNoteTime - getPropertyFromClass('Conductor', 'songPosition') > 200) then
        arrowMode = 2;
    elseif opponentNoteTime - getPropertyFromClass('Conductor', 'songPosition') < 200 and
        (playerNoteTime == -1000 or playerNoteTime - getPropertyFromClass('Conductor', 'songPosition') > 200) then
        arrowMode = 1;
    else
        arrowMode = 0;
    end
end
