Config = Config or {}

Config.QBCoreNewversion = true

if Config.QBCoreNewversion then
    Config.CoreName = "QBCore"
    Config.Core = exports['qb-core']:GetCoreObject()
    Config.CoreNotify = "QBCore:Notify"
else
    Config.CoreName = "QBCore:GetObject"
    Config.Core = nil
    TriggerEvent(Config.CoreName, function(obj) Config.Core = obj end)
    Config.CoreNotify = "QBCore:Notify"
end


Races = {}

Config.APPName = "Race"
Config.VehiclePed = "You must be in the vehicle to create a race"
Config.disqualified = "You have been disqualified from the race"
Config.racealert = "Race Alert :"
Config.laps = "Laps"
Config.Finish = "Finished Race"
Config.Cancel = "Race Cancelled"
Config.Quit = "Quit Race"
Config.RaceMap = "There is already a race in this Map"
Config.RaceMessage = "Race Message: "
Config.MapSettings = "[K] Save | [U] Cancel  | [E] Add | [Shift+E] Remove | ⬆ Radius ⬇ | ⬅ Rotation ➡ "