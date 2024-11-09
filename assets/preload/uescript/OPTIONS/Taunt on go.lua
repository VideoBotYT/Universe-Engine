function onCountdownTick(counter)
    if counter == 3 then
        -- taunt on go
        playAnim('boyfriend', 'singUP')
        playAnim('gf', "cheer")
        playAnim('dad', 'singUP')
    end
end

function onSongStart()
    -- idle when the song starts
    playAnim('boyfriend', 'idle')
    playAnim('gf', 'idle')
    playAnim('dad', 'idle')
end