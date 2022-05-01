local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("poisoned_sandwich", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", src, "sandwich")
        TriggerClientEvent("qb-ricin:client:KillEmWithRicin", src)
    end
end)

QBCore.Functions.CreateUseableItem("poisoned_twerks_candy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", src, "twerks_candy")
        TriggerClientEvent("qb-ricin:client:KillEmWithRicin", src)
    end
end)

QBCore.Functions.CreateUseableItem("poisoned_snikkel_candy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", src, "snikkel_candy")
        TriggerClientEvent("qb-ricin:client:KillEmWithRicin", src)
    end
end)

QBCore.Functions.CreateUseableItem("poisoned_tosti", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", src, "tosti")
        TriggerClientEvent("qb-ricin:client:KillEmWithRicin", src)
    end
end)

RegisterNetEvent('qb-ricin:server:GiveRicinSeed', function(playerId)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local risinSeedItem = "ricin_seed"
    local itemInfo = QBCore.Shared.Items[risinSeedItem]
    Player.Functions.AddItem(risinSeedItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
end)

RegisterNetEvent('qb-ricin:server:ProcessRicinSeed', function(playerId)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local risinSeedItem = "ricin_seed"
    local risinPowderItem = "ricin_ready"
    local ricin = Player.Functions.GetItemByName(risinSeedItem)
    if ricin ~= nil then
        Player.Functions.RemoveItem(risinSeedItem, 1)
        local itemInfo = QBCore.Shared.Items[risinSeedItem]
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "remove")
        itemInfo = QBCore.Shared.Items[risinPowderItem]
        Player.Functions.AddItem(risinPowderItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
    else
        --no ricin SAd
    end
end)
