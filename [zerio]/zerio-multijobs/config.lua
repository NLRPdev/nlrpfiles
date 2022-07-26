Config = {}

Config.Locale = "en"

-- command, keybind, item or custom
-- command gets triggered through a command. the command name gets decided through Config.CommandName
-- keybind gets triggered when a button is pressed. the button gets decided through Config.Keybind
-- item gets triggered when an item is used. the item gets decided through Config.Item
-- custom gets triggered through a custom script or lua file made by you. Use the following export: exports["zerio-multijobs"]:Open()
Config.OpenType = "keybind"

Config.CommandName = "multijob"
Config.Keybind = "f5"
Config.Item = "radio"

-- Default job + grade, this has to be correct otherwise the system can be exploited if you leave the job you are set as right now
Config.DefaultJob = "unemployed"
Config.DefaultGrade = 0

-- If the job is not in Config.JobIcons here it will default to Config.DefaultIcon
Config.DefaultIcon = "fa-solid fa-question"

-- Max amount of jobs a player can have at a time. Removing this line or putting it as nil / -1 will result in the job amount not having any limit at all
Config.MaxJobs = -1

Config.JobIcons = {
    ["police"] = "fa-solid fa-user"
}
