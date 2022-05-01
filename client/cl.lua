local QBCore = exports['qb-core']:GetCoreObject()

local ricinEntity = {}

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k = 1, #(ricinEntity) do
            SetEntityAsMissionEntity(ricinEntity[k], true, true)
            DeleteObject(ricinEntity[k])
            DeleteEntity(ricinEntity[k])
        end
    end
end)

function CreateRicin(location, id)
    if not DoesEntityExist(ricinEntity[id]) then
        RequestModel("prop_plant_01b")

        while not HasModelLoaded("prop_plant_01b") do
            Wait(0)
        end
        
        ricinEntity[id] = CreateObject(GetHashKey("prop_plant_01b"), location, false, false, false)
        print("created "..ricinEntity[id].." with ID: "..id)

        --PlaceObjectOnGroundProperly(ricinEntity[id])
        SetEntityRotation(ricinEntity[id], 0.0, 0.0, 0.0)
        --FreezeEntityPosition(ricinEntity[id], true)
    else
        exports['qb-target']:AddEntityZone("ricin"..id, ricinEntity[id], {
        name = "ricin"..id,
        debugPoly = false,
      }, {
        options = {
          {
            icon = 'fas fa-leaf',
            label = 'Harvest Ricin Seeds',
            action = function(entity)
                HarvestRicin(id)
            end,
          }
        },
        distance = 2.5,
      })
    end
end

function DeleteRicin(id)
    if DoesEntityExist(ricinEntity[id]) then
        print("deleted "..ricinEntity[id].." with ID: "..id)
        SetEntityAsMissionEntity(ricinEntity[id], true, true)
        DeleteObject(ricinEntity[id])
        DeleteEntity(ricinEntity[id])
        ricinEntity[id] = 0
    end
end

function HarvestRicin(id)
    if DoesEntityExist(ricinEntity[id]) then
        QBCore.Functions.Progressbar("harvest", "Harvesting Ricin Seed", 5500, false, true, {
            TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false),
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
        }, {}, {}, function()
            Config.RicinPlants[id]["harvested"] = true
            SetEntityAsMissionEntity(ricinEntity[id], true, true)
            DeleteObject(ricinEntity[id])
            DeleteEntity(ricinEntity[id])
            ricinEntity[id] = 0
            TriggerServerEvent("qb-ricin:server:GiveRicinSeed")
            ClearPedTasks(PlayerPedId())
            StartReset(id)
        end, function()
            ClearPedTasks(PlayerPedId())
        end)
    end
end

function ProcessRicin()
    QBCore.Functions.Progressbar("harvest", "Processing Ricin Seed", 5500, false, true, {
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false),
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("qb-ricin:server:ProcessRicinSeed")
    end, function()
        ClearPedTasks(PlayerPedId())
    end)
end

function StartReset(id)
    SetTimeout(12500, function()
        Config.RicinPlants[id]["harvested"] = false
    end)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
    SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 1, GetEntityForwardVector(PlayerPedId()), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    SetEntityHealth(PlayerPedId(), 0)
    TriggerServerEvent("hospital:server:SetDeathStatus", true)
    TriggerServerEvent("hospital:server:SetLaststandStatus", true)
end

RegisterNetEvent('qb-ricin:client:KillEmWithRicin', function()
    AlienEffect()
    RestorePlayerStamina(PlayerPedId(), 1.0)
end)

CreateThread(function()
    while true do
        Wait(1)
        for k, v in pairs(Config.RicinPlants) do
            local ped = PlayerPedId()
            local playerPos = GetEntityCoords(ped)
            local plantPos = vector3(v["location"].x, v["location"].y, v["location"].z)
            local dis = #(plantPos - playerPos)
            local harvested = v["harvested"]
            if dis < 25 and not harvested then
                CreateRicin(plantPos, k)
            else
                DeleteRicin(k)
                Wait(2000)
            end
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Config.RicinProcess) do
        local processPos = vector3(v["location"].x, v["location"].y, v["location"].z)
        exports["qb-target"]:AddBoxZone("process"..k, processPos, 1.2, 1.2, { 
            name = "process"..k,
            heading = v["location"].W,
            debugPoly = false, 
            minZ = v["location"].z - 3.0, 
            maxZ = v["location"].z + 6.0,
            }, {
                options = {
                    {
                        icon = "fa-solid fa-vial",
                        label = "Process Ricin Seed",
                        action = function()
                            ProcessRicin()
                        end,
                    },
                },
            distance = 1.5
        })
    end
end)
