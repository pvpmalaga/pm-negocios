local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("trabajos:DB", function(source, cb)
    local src = source
    local trabajo = exports['origen_masterjob']:GetBusinesses()
    local negocios = {}  
    
    for k, v in pairs(trabajo) do
        local data = v.Data
        
        if data and data.npcs then
            for _, npc in ipairs(data.npcs) do
                local coords = npc.coords
                
                if coords then
                    local open_status = data.open == 1 and "true" or "false"
                    
                  
                    local negocio = {
                        label = data.label,
                        open = open_status,
                        coords = { x = coords.x, y = coords.y, z = coords.z }
                    }
                    
                    table.insert(negocios, negocio)
                end
            end
        end
    end

    
    cb(negocios)
end)



