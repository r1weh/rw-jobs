local HasProgressbar = false

Citizen.CreateThread(function()
    for Index, Coords in pairs(Config.Penjahit.GrabWool) do
        local interactOptions = {
            {
                name = "interact:penjahit:wool",
                label = "Mengambil Wool",
                action = function(entity, coords, args)
                    local berhasil = lib.skillCheck({'easy'}, {'e'})
                    if berhasil then
                        TakeWool()
                    else
                        RNRFunctions.CLNotify("Yah Payah Kamu Gagal", 'success')
                    end
                end,
            },
        }
    
        exports.interact:AddInteraction({
            coords = Coords,
            distance = 2.0, -- optional
            interactDst = 3.0, -- optional
            id = "penjahit-wool-" .. Index, -- needed for removing interactions
            options = interactOptions,
        })
    end

    for Index, Coords in pairs(Config.Penjahit.GrabCloth) do
        local interactOptions = {
            {
                name = "interact:penjahit:kain",
                label = "Pembuatan Kain",
                action = function(entity, coords, args)
                    local berhasil = lib.skillCheck({'easy'}, {'e'})
                    if berhasil then
                        MakeCloth()
                    else
                        RNRFunctions.CLNotify("Yah Payah Kamu Gagal", 'success')
                    end
                end,
            },
        }
    
        exports.interact:AddInteraction({
            coords = Coords,
            distance = 2.0, -- optional
            interactDst = 3.0, -- optional
            id = "pembuatan-kain-" .. Index, -- needed for removing interactions
            options = interactOptions,
        })
    end

    for Index, Coords in pairs(Config.Penjahit.MakeClothes) do
        local interactOptions = {
            {
                name = "interact:penjahit:pakaian",
                label = "Pembuatan Pakaian",
                action = function(entity, coords, args)
                    local berhasil = lib.skillCheck({'easy'}, {'e'})
                    if berhasil then
                        MakeClothes()
                    else
                        RNRFunctions.CLNotify("Yah Payah Kamu Gagal", 'success')
                    end
                end,
            },
        }
    
        exports.interact:AddInteraction({
            coords = Coords,
            distance = 2.0, -- optional
            interactDst = 3.0, -- optional
            id = "pembuatan-pakaian-" .. Index, -- needed for removing interactions
            options = interactOptions,
        })
    end

    local interactOptions = {
        {
            name = "interact:penjahit:penjual",
            label = "Penjual Pakaian",
            action = function(entity, coords, args)
                SellingClothes()
            end,
        },
    }

    exports.interact:AddInteraction({
        coords = vec3(452.1025, -783.4636, 27.3578),
        distance = 2.0, -- optional
        interactDst = 3.0, -- optional
        id = "penjual-pakaian", -- needed for removing interactions
        options = interactOptions,
    })
end)

function TakeWool()
    if HasProgressbar then return end
    local success = lib.progressBar({
        duration = 10000, -- Durasi proses
        label = "Mengambil Wool ..",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        }
    })

    if success then
        HasProgressbar = false
        ClearPedTasks(cache.ped)
        for k, v in pairs(Config.PenjahitItem['ambilwool'].dapet) do
            lib.callback.await('dn-penjahit:Server:Addeditemnya', false, {
                item = v.item,
                amount = v.amount
            })
        end
        RNRFunctions.CLNotify("Wol berhasil diambil!", 'success')
    else
        HasProgressbar = false
        RNRFunctions.CLNotify("Pembatalan pengambilan wool!", 'error')
    end
end

function MakeCloth()
    for k, v in pairs(Config.PenjahitItem['proseswool'].butuh) do
        local a = exports.ox_inventory:Search('count', v.item)
        if a < v.amount then
            RNRFunctions.CLNotify('Kamu kekurangan/tidak punya : '..exports.ox_inventory:Items()[v.item].label, "info")
            RNRFunctions.CLNotify('Minimal Proses '..v.amount, "info")
            return
        end
    end
    if HasProgressbar then return end
    local success = lib.progressBar({
        duration = 6000, -- Durasi proses
        label = "Membuat Kain ..",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        }
    })
    if success then
        for k, v in pairs(Config.PenjahitItem['proseswool'].dapet) do
            lib.callback.await('dn-penjahit:Server:Addeditemnya', false, {
                item = v.item,
                amount = v.amount
            })
        end
        for k, v in pairs(Config.PenjahitItem['proseswool'].butuh) do
            lib.callback.await('item:penjahitremove', false, {
                item = v.item,
                amount = v.amount
            })
        end
        HasProgressbar = false
        ClearPedTasks(cache.ped)
        RNRFunctions.CLNotify("Kain telah berhasil dibuat!", 'success')
    else
        HasProgressbar = false
        RNRFunctions.CLNotify("Pembuatan kain telah dibatalkan!", 'error')
    end
end

function MakeClothes()
    for k, v in pairs(Config.PenjahitItem['jadipakain'].butuh) do
        local a = exports.ox_inventory:Search('count', v.item)
        if a < v.amount then
            RNRFunctions.CLNotify('Kamu kekurangan/tidak punya : '..exports.ox_inventory:Items()[v.item].label, "info")
            RNRFunctions.CLNotify('Minimal Proses '..v.amount, "info")
            return
        end
    end
    if HasProgressbar then return end
    local success = lib.progressBar({
        duration = 6000,
        label = "Membuat Pakaian ..",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        }
    })

    if success then
        for k, v in pairs(Config.PenjahitItem['jadipakain'].dapet) do
            lib.callback.await('dn-penjahit:Server:Addeditemnya', false, {
                item = v.item,
                amount = v.amount
            })
        end
        for k, v in pairs(Config.PenjahitItem['jadipakain'].butuh) do
            lib.callback.await('item:penjahitremove', false, {
                item = v.item,
                amount = v.amount
            })
        end
        HasProgressbar = false
        ClearPedTasks(cache.ped)
        RNRFunctions.CLNotify("Pakaian telah berhasil dibuat!", 'success')
    else
        HasProgressbar = false
        RNRFunctions.CLNotify("Pembuatan pakaian telah dibatalkan!", 'error')
    end
end

function SellingClothes()
    if exports.ox_inventory:GetItemCount("pakaian") >= 2 then
        if HasProgressbar then return end

        local success = lib.progressBar({
            duration = 10000,
            label = "Menjual Pakaian ..",
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = false,
                mouse = false,
                combat = true,
            },
        })

        if success then
            TaskStartScenarioInPlace(cache.ped, 'WORLD_HUMAN_CLIPBOARD', 0, false)
            HasProgressbar = true
            Wait(5000)
            HasProgressbar = false
            ClearPedTasks(cache.ped)
            TriggerServerEvent("dn-penjahit:Server:SellClothes", "pakaian")
            RNRFunctions.CLNotify("Pakaian telah berhasil dijual!", 'success')
        else
            HasProgressbar = false
            RNRFunctions.CLNotify("Penjualan pakaian telah dibatalkan!", 'error')
        end
    else
        RNRFunctions.CLNotify("Tidak mempunyai bahan yang dibutuhkan!", 'error')
    end
end



