local QBCore = exports['qb-core']:GetCoreObject()

-- Puedes añadir más ubicaciones.
local washPoints = {
    {
        coords = vector3(-267.0, -963.0, 31.2), -- cambia estas coordenadas según tus necesidades
        heading = 0.0
    },
    {
        coords = vector3(441.0, -981.0, 30.6),
        heading = 180.0
    }
}

Citizen.CreateThread(function()
    for i, loc in ipairs(washPoints) do
        exports['qb-target']:AddBoxZone("handwash_" .. i, loc.coords, 1.5, 1.5, {
            name = "handwash_" .. i,
            heading = loc.heading,
            debugPoly = false,
            minZ = loc.coords.z - 1,
            maxZ = loc.coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "javo_interact:lavarManos",
                    icon = "fas fa-hand-holding-water",
                    label = "Lavar tus manos"
                }
            },
            distance = 2.0
        })
    end
end)

-- Evento para lavar las manos
RegisterNetEvent("javo_interact:lavarManos", function()
    local ped = PlayerPedId()

    -- Animación sugerida: limpieza de manos
    local animDict = "missheistdockssetup1clipboard@idle_a"
    local animName = "idle_a"

    -- También puedes probar con otras animaciones como:
    -- "amb@world_human_hang_out_street@male_b@idle_a" o similares

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(50)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, 5000, 1, 0, false, false, false) -- 5000 ms = 5 segundos

    -- Mostrar mensaje
    QBCore.Functions.Notify("Te estás lavando las manos...", "primary", 5000)

    -- Esperamos 5 segundos para simular el lavado
    Wait(5000)

    ClearPedTasks(ped)
    QBCore.Functions.Notify("Has terminado de lavarte las manos", "success")
end)
