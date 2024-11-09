local healthdrain = 0.000

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    health = getProperty("health")
    healthdrain = healthdrain + 0.002
end

function onUpdate(elapsed)
    health = getProperty("health")
    --debugPrint(healthdrain)
    if healthdrain < 0 then
        healthdrain = 0
    end
    if health > 0.05 then
        setProperty("health", health - healthdrain) 
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    health = getProperty("health")
    healthdrain = healthdrain - 0.002
end