--[[
HEY!!

PLEASE credit me if you use this discord rpc cool thing.
PLEASE credit me if you use this discord rpc cool thing.
PLEASE credit me if you use this discord rpc cool thing.
PLEASE credit me if you use this discord rpc cool thing.
PLEASE credit me if you use this discord rpc cool thing.

you get 2 links that you can put on your mod/engine/whatever
linktree: https://linktr.ee/uwenalil
bsky    : https://bsky.app/profile/weirdpersontbh.bsky.social
]]
local symbol = "•"
function onUpdate(elapsed)
    luaDebugMode = true
    if version < "0.7.1" then
        if hits < 1 then
            changePresence(
                "Score: 0 "..symbol.." Misses: 0 "..symbol.." Rating: 0% (N/A)",
                "".. formatTime(getSongPosition() - noteOffset) .. ' - ' .. formatTime(songLength).." "..symbol.." "..songName.. " ("..difficultyName..")"
            )
        end
        if hits > 0 or misses > 1 then
            changePresence(
                "Score: ".. score .." "..symbol.." Misses: ".. misses .." "..symbol.." Rating: ".. round(rating * 100, 2) .. "% (" .. ratingFC .. ")",
                "".. formatTime(getSongPosition() - noteOffset) .. ' - ' .. formatTime(songLength).." "..symbol.." "..songName.. " ("..difficultyName..")"
            )
        end
    end
    if version > "0.6.3" then
        changeDiscordClientID("1312664199666728980")
        if hits < 1 then
            changeDiscordPresence(
                "Score: 0 "..symbol.." Misses: 0 "..symbol.." Rating: 0% (N/A)",
                "".. formatTime(getSongPosition() - noteOffset) .. ' - ' .. formatTime(songLength).." "..symbol.." "..songName.. " ("..difficultyName..")"
            )
        end
        if hits > 0 or misses > 1 then
            changeDiscordPresence(
                "Score: ".. score .." "..symbol.." Misses: ".. misses .." "..symbol.." Rating: ".. round(rating * 100, 2) .. "% (" .. ratingFC .. ")",
                "".. formatTime(getSongPosition() - noteOffset) .. ' - ' .. formatTime(songLength).." "..symbol.." "..songName.. " ("..difficultyName..")"
            )
        end
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
function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)
end