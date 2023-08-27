ESX = nil
local lastSpawnTime = {}

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)


local isAnimationPlaying = false

RegisterNetEvent("callinganimation")
AddEventHandler("callinganimation", function(vehicleModel)
    local playerPed = PlayerPedId()

    if not isAnimationPlaying then
        isAnimationPlaying = true
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_MOBILE", 0, true)
        Citizen.Wait(5000)  -- Wait for 5 seconds
        ClearPedTasks(playerPed)
        isAnimationPlaying = false

        TriggerEvent("spawnIronCarClient", vehicleModel)
    end
end)

function GenerateRandomPlate(inputPlate)
    local plate = inputPlate or Config.ChangePlateName
    local characters = Config.RandomPlateCharacters
    math.randomseed(GetGameTimer())

    local remainingLength = 8 - #plate

    -- Generate the remaining random characters
    for i = 1, remainingLength do
        local charIndex = math.random(1, #characters)
        plate = plate .. characters:sub(charIndex, charIndex)
    end

    return plate
end


RegisterNetEvent("spawnIronCarClient")
AddEventHandler("spawnIronCarClient", function(carModel)
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    -- Check if cooldown is enabled
    if Config.EnableCooldown then
        -- Check if there's a cooldown for this player
        if lastSpawnTime[playerId] and (GetGameTimer() - lastSpawnTime[playerId]) < (Config.SpawnCooldown * 1000) then
            local remainingCooldown = math.floor((Config.SpawnCooldown * 1000 - (GetGameTimer() - lastSpawnTime[playerId])) / 1000)
            local message = string.format(Config.CooldownMessage, remainingCooldown)  -- Use the configured message
            
            if Config.UseESXNotifications then
                ESX.ShowNotification(message)
            else
                SetNotificationTextEntry("STRING")
                AddTextComponentSubstringPlayerName(message)
                DrawNotification(false, false)
            end
            return  -- Exit the event handler, as the player is still on cooldown.
        end
    end

    -- If the player is not on cooldown or cooldown is disabled, proceed with vehicle spawning logic
    RequestModel(carModel)
    while not HasModelLoaded(carModel) do
        Citizen.Wait(0)
    end

    local playerCoords = GetEntityCoords(playerPed)
    local spawnDistance = 4.0
    local spawnCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, spawnDistance, 0.0)

    local isSpaceFree = CheckSpaceForVehicle(spawnCoords)

    if isSpaceFree then
        RequestModel(carModel)
        while not HasModelLoaded(carModel) do
            Citizen.Wait(0)
        end

        local spawnedCar = CreateVehicle(carModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, GetEntityHeading(playerPed), true, false)

        local plate = GenerateRandomPlate()
        SetVehicleNumberPlateText(spawnedCar, plate)

        TriggerEvent('cd_garage:AddKeys', plate)

        SetEntityAsNoLongerNeeded(spawnedCar)

        -- Update the last spawn time for this player
        lastSpawnTime[playerId] = GetGameTimer()
    else
        local configMessage = Config.NoFreeSpaceMessage
        if Config.UseESXNotifications then
            ESX.ShowNotification(configMessage)
        else
            SetNotificationTextEntry("STRING")
            AddTextComponentSubstringPlayerName(configMessage)
            DrawNotification(false, false)
        end
    end
end)
    

function CheckSpaceForVehicle(coords)
    local collision = false
    local foundObjects = ESX.Game.GetObjects()

    for _, object in ipairs(foundObjects) do
        local position = GetEntityCoords(object)
        local distance = #(coords - position)

        if distance < Config.CollisionDistance then
            collision = true
            break
        end
    end

    if not collision then
        local playerPed = PlayerPedId()
        local rayHandle = StartShapeTestCapsule(coords.x, coords.y, coords.z - 1.0, coords.x, coords.y, coords.z + 1.0, Config.CollisionCapsuleRadius, 10, playerPed, 7)

        local _, _, _, _, hit = GetShapeTestResult(rayHandle)
        collision = hit ~= 0
    end

    if not collision then
        local vehicles = ESX.Game.GetVehicles()
        for _, vehicle in ipairs(vehicles) do
            local vehicleCoords = GetEntityCoords(vehicle)
            local distance = #(coords - vehicleCoords)

            if distance < Config.CollisionDistance then
                collision = true
                break
            end
        end
    end

    if not collision then
        local interiorID = GetInteriorFromEntity(PlayerPedId())
        if interiorID ~= 0 and not IsInteriorDisabled(interiorID) then
            collision = true
        end
    end

    return not collision  -- Return true if space is clear
end


RegisterCommand(Config.DeleteCommand, function()
    local playerPed = PlayerPedId()
    local playerVehicle = GetVehiclePedIsIn(playerPed, false)
    local isVehicleLeft = false -- Flag to track if the player left the vehicle
    local initialVehicleCoords = GetEntityCoords(playerVehicle) -- Store initial vehicle coordinates
    
    local function SendCustomNotification(text)
        local handle = RegisterPedheadshot(PlayerPedId())
        while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
            Citizen.Wait(0)
        end
        local txd = GetPedheadshotTxdString(handle)

        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)

        local title = GetPlayerName(PlayerId())
        local subtitle = Config.DeletionSubtitle
        local iconType = 0
        local flash = false
        EndTextCommandThefeedPostMessagetext(txd, txd, flash, iconType, title, subtitle)

        local showInBrief = true
        local blink = false
        EndTextCommandThefeedPostTicker(blink, showInBrief)
        
        UnregisterPedheadshot(handle)
    end

    if playerVehicle ~= 0 then
        local driverSeat = GetPedInVehicleSeat(playerVehicle, -1)

        if driverSeat == playerPed then
            isDeleting = true
            deleteEndTime = GetGameTimer() + Config.DeleteCountdownTime * 1000  -- Convert seconds to milliseconds

            while isDeleting and not isVehicleLeft do
                local remainingTime = math.floor((deleteEndTime - GetGameTimer()) / 1000)

                local displayText = string.format(Config.DeletionNotificationText, remainingTime)

                local currentVehicleCoords = GetEntityCoords(playerVehicle)
                local vehicleMoved = Vdist2(initialVehicleCoords.x, initialVehicleCoords.y, initialVehicleCoords.z, currentVehicleCoords.x, currentVehicleCoords.y, currentVehicleCoords.z) > 0.5
                
                if not IsPedInVehicle(playerPed, playerVehicle, false) then
                    isVehicleLeft = true
                    if Config.UseESXNotifications then
                        ESX.ShowNotification(Config.vehicleMovedCancelMessage)
                    else
                        SendCustomNotification(Config.vehicleMovedCancelMessage)
                    end
                elseif vehicleMoved then
                    isVehicleLeft = true
                    displayText = Config.vehicleMovedCancelMessage
                elseif remainingTime <= 2 then
                    TaskLeaveVehicle(playerPed, playerVehicle, 0)
                elseif remainingTime <= 4 and IsPedInVehicle(playerPed, playerVehicle, false) then
                    TaskLeaveVehicle(playerPed, playerVehicle, 0)
                    isVehicleLeft = true
                    break
                elseif remainingTime <= 5 and not IsPedInVehicle(playerPed, playerVehicle, false) then
                    displayText = Config.leftVehicleCancelMessage
                    isVehicleLeft = true
                    break
                end

                SendCustomNotification(displayText)

                if remainingTime > 30 then
                    Citizen.Wait(10000)  -- Wait 10 seconds
                elseif remainingTime <= 5 then
                    Citizen.Wait(1000)  -- Wait 1 second
                else
                    Citizen.Wait(10000)  -- Wait 10 seconds
                end

                if remainingTime <= 0 then
                    if not isVehicleLeft and not vehicleMoved then
                        DeleteVehicle(playerVehicle)
                    end
                    isDeleting = false
                end
            end
        else
            local displayText = Config.YouNotInDriverSeat
            SendCustomNotification(displayText)

            Citizen.Wait(2000)  -- Wait for 2 seconds
        end
    else
        local displayText = Config.NotInVehicleMessage
        SendCustomNotification(displayText)

        Citizen.Wait(2000)  -- Wait for 2 seconds
    end
end, false)


