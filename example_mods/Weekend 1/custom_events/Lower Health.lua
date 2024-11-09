function onEvent(name, value1, value2)
    if name == 'Lower Health' then
        if value1 == '' then
            if getProperty("health") > 0.05 then
                setProperty("health", getProperty("health") - 0.023)
            end
        end

        if value1 == 'hit' then
            if getProperty("health") > 0.05 then
                setProperty("health", getProperty("health") - 0.2)
            end
            
            if value2 == 'opp' then
                setProperty("health", getProperty("health") + 0.2)

                if noteMiss then
                    setProperty("health", getProperty("health") - 0.2)
                end
            end
        end
    end
end