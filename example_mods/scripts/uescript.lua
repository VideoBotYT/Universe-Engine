--File Locations << << << << <<
UEenginescriptlocateOPTIONS = "uescript/OPTIONS/"
UEenginescriptlocateFORCE = "uescript/FORCE/"
UEenginescriptlocateGP = "uescript/GP/"
function onCreatePost()
    -- Force on << << << << <<
    addLuaScript(UEenginescriptlocateFORCE.."DifficultyLVL")
    addLuaScript(UEenginescriptlocateFORCE.."Song Name")
    addLuaScript(UEenginescriptlocateFORCE.."Trail Double Note")
    addLuaScript(UEenginescriptlocateFORCE.."fire")
    addLuaScript(UEenginescriptlocateFORCE.."baldi")
    
    -- Options << << << << <<
    if UEHud then addLuaScript(UEenginescriptlocateOPTIONS.."Hud") end
    if UEDetachedHB then addLuaScript(UEenginescriptlocateOPTIONS..'Detached HealthBar') end
    if UEhudZoomOut then addLuaScript(UEenginescriptlocateOPTIONS..'Zoomed Out') end
    if UEkeystrokes then addLuaScript(UEenginescriptlocateOPTIONS..'Keystrokes') end
    if UEcCounter then addLuaScript(UEenginescriptlocateOPTIONS..'Combo Counter') end
    if UESmoothHP then addLuaScript(UEenginescriptlocateOPTIONS..'Smooth HP') end
    if UEe100C then addLuaScript(UEenginescriptlocateOPTIONS..'Every 100 combo') end
    if UEiconBop then addLuaScript(UEenginescriptlocateOPTIONS..'Icon Bop') end
    if UEtauntGo then addLuaScript(UEenginescriptlocateOPTIONS..'Taunt on go') end
    if UEshakeMiss then addLuaScript(UEenginescriptlocateOPTIONS..'Shake on miss') end
    if UEdarkenCamGame then addLuaScript(UEenginescriptlocateOPTIONS..'Darken CamGame') end
    if UEstrumsplash then addLuaScript(UEenginescriptlocateOPTIONS.."Strum Splash") end
    if UEresultscreen then addLuaScript(UEenginescriptlocateOPTIONS.."Results Screen") end
    if UEmisssounds then addLuaScript(UEenginescriptlocateOPTIONS.."Miss Sounds") end
    
    -- GP mods << << << << <<
    if UEplayBothSides then addLuaScript(UEenginescriptlocateGP..'Play Both Sides') end
    if UEhealthDrain then addLuaScript(UEenginescriptlocateGP..'Health Drain') end
    if UEsustainOneNote then addLuaScript(UEenginescriptlocateGP..'Sustain as one note') end
    if UEsd then addLuaScript(UEenginescriptlocateGP..'Crash on miss') end
    --note, the lua of UE shut down didn't change.
    if UEhealthdrainp2 then addLuaScript(UEenginescriptlocateGP..'Health Drain Part 2') end

    -- Chaning the FPS Font << << << << <<
    addHaxeLibrary('Main'); runHaxeCode([[ Main.fpsVar.defaultTextFormat = new openfl.text.TextFormat("funkin.ttf", 15, 10); ]]);

    -- Other non important << << << << <<
    --luaDebugMode = true
end

--[[

Little tutorial on how to use the custom function!

function onCreatePost()
    addLuaScript("scripts/UE engine/customFunction")
end

add that line to your lua script!
here are some avalible functions for now!

UEAlphaHud(DURATION,VALUE)
UEAlphaCombo(DURATION,VALUE)
UEHideKeystrokes(DURATION,TRUE/FALSE)

]]