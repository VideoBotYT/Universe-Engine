function opponentNoteHit(id, direction, noteType, isSustainNote)
    if UEhealthDrain then
        if isSustainNote then
            setProperty('health', getProperty('health') + 0.023 * healthLossMult)
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') - 0.023 * healthGainMult)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.0475 * healthLossMult)
    end
end