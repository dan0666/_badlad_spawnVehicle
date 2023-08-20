Config = {}

Config.UseESXNotifications = true                                                    -- (Only for NoFreeSpaceMessage, becouse all notification is GTA 5 native) Set to true for ESX notification, false for GTA 5 native notification
Config.NoFreeSpaceMessage = "Nėra laisvos vietos transporto priemonei."              -- You can change the text.
Config.NoGradeMessage = "Neturite reikiamo darbo lygio."                             -- You can change the text.
Config.CollisionDistance = 3.0                                                       -- I think 3.0 is a best.
Config.NotInVehicleMessage = "Jus nesate transporto priemonėje."                     -- You can change the text.
Config.DeletionSubtitle = "Parkavimas"                                               -- You can change the text.
Config.DeleteCommand = "parkuoti"                                                    -- Command to delete the vehicle
Config.DeleteCountdownTime = 30                                                      -- Countdown time in seconds / NOTE: MIN SECONDS 10s
Config.DeletionNotificationText = "Parkuojate tr.priemonę.\nLikęs laikas: %ss."      -- You can change the text.
Config.YouNotInDriverSeat = "Parkuoti gali tik vairuotojas."                         -- You can change the text.
Config.leftVechileCancelMessage = "Jus palikote tr.priemone, parkavimas nutrauktas." -- You can change the text.
Config.vehicleMovedCancelMessage = "Parkavimas nutrauktas, transportas juda."        -- You can change the text.
Config.NotificationWaitTime = 30000                                                  -- Default wait time in milliseconds
Config.ChangePlateName = "ABC"                                                       -- You can change the plate name. (It fills automatically up to 8 numbers/letters if you don't set it up)
Config.RandomPlateCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"                -- It generates numbers and letters for the spawned vehicle. (You can change it if needed)


-- Define your items and their corresponding vehicle spawns here
Config.UsableItems = {
    ["audirs6"] = {
        vehicleModel = "ACTRPavant",
        animationEvent = "callinganimation",
        requiredJob = "police",                                                      -- Example: Only police can use this. You can change whatever you want. "ambulance, mechanic and more"
        requiredGrade = 2,                                                           -- Add job grade / If you don't want a required grade, you can set to "false".
        noJobMessage = "Norėdami naudoti šį daigtą, turite būti policijos pareigūnas.", -- Customized message
        removeItemOnUse = false
    },
    ["22porche"] = {
        vehicleModel = "2022pshrb",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
        
    },
    ["astinger"] = {
        vehicleModel = "ACTPOLstinger",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    },
    ["bmwgm5"] = {
        vehicleModel = "vicpol_um",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    },
    ["audir6w"] = {
        vehicleModel = "ACTRPavantum",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    },
    ["bmwgx5"] = {
        vehicleModel = "ACTRPx5",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    },
    ["ehummer"] = {
        vehicleModel = "24humevof",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    },
    ["polvanil"] = {
        vehicleModel = "truroamer",
        animationEvent = "callinganimation",
        requiredJob = "police", 
        requiredGrade = 2,
        noJobMessage = "Norėdami naudoti šį elementą, turite būti policijos pareigūnas.",
        removeItemOnUse = true
    }
    -- Add more items here
}
