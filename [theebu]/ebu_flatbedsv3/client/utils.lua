--allowed() is the function that determines if the player is allowed to use the dyno. DO NOT RENAME THE FUNCTION
--Place whatever job check code you want in here, return true if allowed, false if not
function allowed()
    return true
end


function LoadCompleteNotif()
	EndTextCommandThefeedPostTickerForced(1,1)
	ThefeedNextPostBackgroundColor(184)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Config.NotiLoadCompleteMessage)
	EndTextCommandThefeedPostTicker(true, true)
	Wait(3000)
	EndTextCommandThefeedPostTickerForced(1,1)
end

function UnLoadCompleteNotif()
	EndTextCommandThefeedPostTickerForced(1,1)
	ThefeedNextPostBackgroundColor(184)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Config.NotiUnLoadCompleteMessage)
	EndTextCommandThefeedPostTicker(true, true)
	Wait(3000)
	EndTextCommandThefeedPostTickerForced(1,1)
end

function FBBlockedNotif()
	EndTextCommandThefeedPostTickerForced(1,1)
	ThefeedNextPostBackgroundColor(6)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Config.NotiFBBlockedMessage)
	EndTextCommandThefeedPostTicker(true, true)
	Wait(3000)
	EndTextCommandThefeedPostTickerForced(1,1)
end

function BlockedMessage()
	EndTextCommandThefeedPostTickerForced(1,1)
	ThefeedNextPostBackgroundColor(6)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Config.NotiBlockedMessage)
	EndTextCommandThefeedPostTicker(true, true)
	Wait(3000)
	EndTextCommandThefeedPostTickerForced(1,1)
end

RegisterKeyMapping('+bedLower', 'bed Lower', 'keyboard', 'DOWN')
RegisterKeyMapping('+bedRaise', 'bed Raise', 'keyboard', 'UP')

RegisterKeyMapping('+flatbedAttach', 'Flatbed Attach', 'keyboard', 'E')
RegisterKeyMapping('+flatbedRope', 'Flatbed Remove Winch', 'keyboard', 'G')

RegisterKeyMapping('+flatbedWarp', 'Flatbed Get In Car', 'keyboard', 'F')

RegisterKeyMapping('+flatbedWind', 'Flatbed Wind', 'keyboard', 'LEFT')
RegisterKeyMapping('+flatbedUnWind', 'Flatbed Unwind', 'keyboard', 'RIGHT')