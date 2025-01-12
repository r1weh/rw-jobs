lib.callback.register('rnr_jobs:server:getItem', function(source)
    for i = 1, 1, 1 do
        local randItem = Config.ItemTable[math.random(1, #Config.ItemTable)]
        local amount = math.random(5, 15)
        RNRFunctions.AddItem(randItem, amount)
        Wait(500)
    end

    local chance = math.random(1, 100)
    if chance < 7 then
        RNRFunctions.AddItem("alumunium", 1)
    end

    local Luck = math.random(1, 10)
    local Odd = math.random(1, 10)
    if Luck == Odd then
        local random = math.random(1, 10)
        RNRFunctions.AddItem("plasticrab", random)
    end
end)