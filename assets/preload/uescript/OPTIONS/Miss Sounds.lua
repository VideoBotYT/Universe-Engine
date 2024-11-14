UEmissSounds = {"missnote1", "missnote2", "missnote3"}
function noteMiss(id, direction, noteType, isSustainNote)
    playSound(UEmissSounds[getRandomInt(1,#UEmissSounds)], getRandomFloat(0.1, 0.2)) -- I hated how loud this was
    if not isSustainNote then
        --playSound(UEmissSounds[getRandomInt(1,#UEmissSounds)])
        --debugPrint("NOTEMISS")
    end
end