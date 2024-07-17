local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('negocios', function()
    local sortedJobs = {}

    QBCore.Functions.TriggerCallback('trabajos:DB', function(JOBDB)
        for _, info in pairs(JOBDB) do
            
            table.insert(sortedJobs, {
                label = info.label,
                coords = info.coords,
                open = info.open
            })
        end
    
        Wait(200)
        table.sort(sortedJobs, function(a, b) return a.label < b.label end)
        Wait(200)

        local joblist = {}
        joblist[#joblist + 1] = { 
            isMenuHeader = true,
            header = 'Negocios',
        }

       

        for _, job in ipairs(sortedJobs) do
            if job.open == "true" then
                statusText = "Abierto"
                estado = false
            elseif job.open == "false" then
                statusText = "Cerrado"
                estado = true
            end
            joblist[#joblist + 1] = {
                header = job.label,
                txt = statusText,
                disabled = estado,
                icon = 'fa-solid fa-user-shield',
                params = {
                    event = 'poner:coords',
                    args = {
                        coords = job.coords
                    }
                }
            }
        end

        exports['qb-menu']:openMenu(joblist) -- open our menu
    end)
end)



RegisterNetEvent('poner:coords', function(data)
    SetNewWaypoint(data.coords.x, data.coords.y)
    QBCore.Functions.Notify("Se asigno un nuevo marcador en el mapa")
end)


