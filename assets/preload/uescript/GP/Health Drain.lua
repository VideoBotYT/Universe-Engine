function opponentNoteHit(id, direction, noteType, isSustainNote)
    health = getProperty("health")
    if health > 0.05 then
        setProperty("health", health - 0.023 * healthLossMult) -- fun fact, this is the same as the player getting health!
    end
end
