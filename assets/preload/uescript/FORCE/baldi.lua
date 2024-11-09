local totalhit = 0

function onCreatePost()
    precacheSound("baldi/oh")
    precacheSound("baldi/hi")
    precacheSound("baldi/welcome")
    precacheSound("baldi/to")
    precacheSound("baldi/my")
    precacheSound("baldi/school")
    precacheSound("baldi/house")
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    local hitsoundvolume = getPropertyFromClass("ClientPrefs", "hitsoundVolume")
    if UEhitsound == 'Baldi' then
        if isSustainNote == false then
            if totalhit == 0 then
                playSound("baldi/oh", hitsoundvolume, "oh")
                totalhit = 1

                stopSound("hi")
                stopSound("welcome")
                stopSound("to")
                stopSound("my")
                stopSound("school")
                stopSound("house")
            elseif totalhit == 1 then
                playSound("baldi/hi", hitsoundvolume, "hi")
                totalhit = 2
                stopSound("oh")
                stopSound("welcome")
                stopSound("to")
                stopSound("my")
                stopSound("school")
                stopSound("house")
            elseif totalhit == 2 then
                playSound("baldi/welcome", hitsoundvolume, "welcome")
                totalhit = 3
                stopSound("oh")
                stopSound("hi")
                stopSound("to")
                stopSound("my")
                stopSound("school")
                stopSound("house")
            elseif totalhit == 3 then
                playSound("baldi/to", hitsoundvolume, "to")
                totalhit = 4
                stopSound("oh")
                stopSound("hi")
                stopSound("welcome")
                stopSound("my")
                stopSound("school")
                stopSound("house")
            elseif totalhit == 4 then
                playSound("baldi/my", hitsoundvolume, "my")
                totalhit = 5

                stopSound("oh")
                stopSound("hi")
                stopSound("welcome")
                stopSound("to")
                stopSound("school")
                stopSound("house")
            elseif totalhit == 5 then
                playSound("baldi/school", hitsoundvolume, "school")
                totalhit = 6

                stopSound("oh")
                stopSound("hi")
                stopSound("welcome")
                stopSound("to")
                stopSound("my")
                stopSound("house")
            elseif totalhit == 6 then
                playSound("baldi/house", hitsoundvolume, "house")
                totalhit = 0

                stopSound("oh")
                stopSound("hi")
                stopSound("welcome")
                stopSound("to")
                stopSound("my")
                stopSound("school")
            end
        end
    end
end
