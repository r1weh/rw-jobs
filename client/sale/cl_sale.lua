local function RNRServer(eventName, parameters)
    local server = TriggerServerEvent
    local kepo = server
    kepo(eventName, parameters)
end

RegisterNetEvent('rnr_jobs:client:salechicken', function()
    lib.registerContext({
        id = 'sale_chicken',
        title = 'Saller Chicken',
        options = {
            {
                title = 'Sale Pack Chicken',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            }
        }
    })
    lib.showContext('sale_chicken')
end)

RegisterNetEvent('rnr_jobs:client:sale:farm', function()
    lib.registerContext({
        id = 'sale_farm',
        title = 'Saller Chicken',
        options = {
            {
                title = 'Sale Cabe',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Coklat',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Garam',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Kopi',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Padi',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Tebu',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
            {
                title = 'Sale Teh',
                onSelect = function()
                    RNRServer('rnr_jobs:server:salechicken')
                end
            },
        }
    })
    lib.showContext('sale_farm')
end)