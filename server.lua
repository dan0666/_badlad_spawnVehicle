ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- Register usable items
for itemName, itemConfig in pairs(Config.UsableItems) do
    ESX.RegisterUsableItem(itemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then
            local carModel = itemConfig.vehicleModel
            local animationEvent = itemConfig.animationEvent
            local requiredJob = itemConfig.requiredJob
            local requiredGrade = itemConfig.requiredGrade or 0

            if requiredJob then
                local playerJob = xPlayer.job.name
                local playerGrade = xPlayer.job.grade

                if playerJob == requiredJob and playerGrade >= requiredGrade then
                    if itemConfig.removeItemOnUse then
                        xPlayer.removeInventoryItem(itemName, 1)
                    end

                    TriggerClientEvent(animationEvent, source, carModel)
                else
                    local message = itemConfig.noJobMessage
                    if playerGrade < requiredGrade then
                        message = Config.NoGradeMessage
                    end

                    xPlayer.showNotification(message)
                end
            else
                if itemConfig.removeItemOnUse then
                    xPlayer.removeInventoryItem(itemName, 1)
                end

                TriggerClientEvent(animationEvent, source, carModel)
            end
        end
    end)
end
