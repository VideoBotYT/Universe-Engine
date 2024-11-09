UEmissSounds = {"missnote1", "missnote2", "missnote3"}
function noteMiss(id, direction, noteType, isSustainNote)
    playSound(UEmissSounds[getRandomInt(1,#UEmissSounds)])
    if not isSustainNote then
        --playSound(UEmissSounds[getRandomInt(1,#UEmissSounds)])
        --debugPrint("NOTEMISS")
    end
end