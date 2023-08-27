Config = {}

Config.UseESXNotifications = false                                                          -- (Only for NoFreeSpaceMessage, becouse all notification is GTA 5 native) Set to true for ESX notification, false for GTA 5 native notification

Config.NoFreeSpaceMessage = "No free space to spawn the vehicle."                           -- Customized message.
Config.NoGradeMessage = "You do not have the required grade."                               -- Customized message.
Config.CollisionDistance = 3.0                                                              -- I believe 3.0 is the best.
Config.NotInVehicleMessage = "You are not in a vehicle."                                    -- Customized message.
Config.DeletionSubtitle = "Deletion Process"                                                -- Customized message.
Config.DeleteCommand = "delete"                                                             -- Command to delete the vehicle. (Don't worry, it won't be deleted from your database.) You can use it as a parking method.
Config.DeleteCountdownTime = 10                                                             -- Countdown time in seconds / NOTE: MIN SECONDS 10s.
Config.DeletionNotificationText = "Deletion process started.\nTime left: %s seconds."       -- Customized message.
Config.YouNotInDriverSeat = "You must be the driver to initiate vehicle deletion."          -- Customized message.
Config.leftVechileCancelMessage = "You left the vehicle, deletion is canceled."             -- Customized message.
Config.vehicleMovedCancelMessage = "Deletion is canceled, vehicle is moved."                -- Customized message.
Config.NotificationWaitTime = 30000                                                         -- Default wait time in milliseconds.
Config.ChangePlateName = "ABC"                                                              -- You can change the plate name. (It fills automatically up to 8 numbers/letters. If you don't set it up to 8 symbols, the code automaticly sets up)
Config.RandomPlateCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"                       -- It generates numbers and letters for the spawned vehicle. (You can change it if needed)

Config.EnableCooldown = true                                                                -- Set to true to enable cooldown, false to disable (default: true)
Config.SpawnCooldown = 120                                                                  -- 2 minutes (you can change this value)
Config.CooldownMessage = "You must wait %s seconds before spawning another vehicle."        -- Cooldown message with a placeholder for the remaining time

Config.EnableUnlockControl = true                                                           -- Set to true to enable the unlock control handler, false to disable it
Config.UnlockKey = 182                                                                      -- Key code for "L" key (you can change this value)
Config.LockedNotification = "Vehicle locked."                                               -- You can change the text.
Config.UnlockedNotification = "Vehicle unlocked."                                           -- You can change the text.

Config.CdGarageKeys = false                                                                 -- Set to true to enable the cd_garage resource (Its only if you use cd_garage) If you set true, please set Config.EnableUnlockControl to false.

-- Define your items and their corresponding vehicle spawns here.
Config.UsableItems = {
    ["your_vehicle_item"] = {                                                               -- Your spawn item name from your database.
        vehicleModel = "your_vehicle_spawn_model",                                          -- Add your vehicle spawn name.
        animationEvent = "callinganimation",                                                -- Please don't touch this.
        requiredJob = "police",                                                             -- Example: Only police can use this. You can change whatever you want. "ambulance, mechanic and more".
        requiredGrade = 0,                                                                  -- Add job grade / If you don't want a required grade, you can set to "false".
        noJobMessage = "You need to be a police officer to use this item.",                 -- Customized message.
        removeItemOnUse = false                                                             -- Selecting "false" means leaving the item in the inventory, while selecting "true" means removing the item.
    },

    -- Add more items here below.

    --[[["your_next_item"] = {
        vehicleModel = "your_next_vehicle_spawn_name",
        animationEvent = "callinganimation",
        requiredJob = "ambulance", 
        requiredGrade = 0,
        noJobMessage = "You need to be a ambulance worker to use this item.",
        removeItemOnUse = true
        
    },]]

    --[[["your_next_item"] = {
        vehicleModel = "your_next_vehicle_spawn_name",
        animationEvent = "callinganimation",
        requiredJob = "mechanic", 
        requiredGrade = 0,
        noJobMessage = "You need to be a mechanic to use this item.",
        removeItemOnUse = true
        
    },]]
}
