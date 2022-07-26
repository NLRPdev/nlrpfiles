local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1000657323536158772/USxv6QCQNA99gMECPzmqWj8tq8YlLN1IEHQL-IV1dk89rDdUfbwS1mV3exRR4zFeJpRx',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1000657150147842058/W81BXYDBbgh9wHUFj7q1HE7Jekk_6-3vDMqGEdZrTQ2NfBDpgLfYqEaQU8g3BgEYXIqs',
    ['playermoney'] = 'https://discord.com/api/webhooks/1000656850141843486/pwxkuaQo1IKmm3uyRkaCiW2kwzpEO6VyV-UZMM-xQXXmAz1Ootmzehq_DbSrPJ7MvQcX',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1000656558012776459/UKhWXJJl9Dii7CVdkCH92NeuHqFsxejEFwpUpDzoDFMlecVK1w0NdcsfFRgjwq7FdYWH',
    ['robbing'] = 'https://discord.com/api/webhooks/1000656328559181898/CjEfgPNDyHrEKayk7WRJEkxTD1c5eXIHd2fhpsHI73suldTe9xAL-h4cVekj1jB5rYzX',
    ['cuffing'] = 'https://discord.com/api/webhooks/1000656100212871229/iHFs8Cqd2wlDm8bvjM9VTIqqplhtbC3TgmChxhDPlm5TzRZzp8eIGsGJ2LYmxzDMmgkN',
    ['drop'] = 'https://discord.com/api/webhooks/1000655813192458271/1pwFWfMw7lf22wKrRmHdgKmMFQKZmcY-Pv_9ey8JxNnE2gPojhFftmkJMNEzuR9gZVGg',
    ['trunk'] = 'https://discord.com/api/webhooks/1000655624457170944/VgMrEvO8onZDIRf342hBt0LlI4bA8-Ts0GE5sFX-zQhpEKIwCurHF5IpdZYCSOfzcqQB',
    ['stash'] = 'https://discord.com/api/webhooks/1000655422790828103/PiqBy3nT1xVDPG0K9iVwNuJHxLHiruqHiJRWZif7c25Pz8XxAgjLDGSKIxl5psCq88oz',
    ['glovebox'] = 'https://discord.com/api/webhooks/1000655230461038672/nQo7dRU-kfrAivj-3f9g36RpWUuIa7zmJ1wTqBxDyFh3mi4MBpSKyGA8KBLdBeNSF-th',
    ['banking'] = 'https://discord.com/api/webhooks/1000654974524592188/zP8N5l6h1uey8KTWuo_6tm7rJdbxiJ1MeDDs5sqZDcXz8LPi-2xK-2vq_-lSr07D8C6r',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/1000654723608760400/qnNJG87k6jddc-eVe-8III7PbzQaZ8I7rhE4FgYfffazzI852OV0jQQrEzfG72xY7-nN',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/1000654141602922567/Oc-Kf0hzn7up5ZD6HNN1gCotc28rOfDV1hPb7-EuDZk0XHo2qk4GIZl6wZLsZltIRHLv',
    ['shops'] = 'https://discord.com/api/webhooks/1000653817555197984/CprDv5uqe03gB_OXPmj8qOJpsaEjb0l2kA3KRKHaRAffkgO8EBbC9QCB5s6IMuaRjxtf',
    ['dealers'] = 'https://discord.com/api/webhooks/1000562209480527966/__K3ofxdyENclsdFYZBQwOXBHL22i0p4o3n1l-H6g7YUVqygWBSaBCoWSAkznxaRfpcv',
    ['storerobbery'] = 'https://discord.com/api/webhooks/1000561877727854642/8OomJuFT98e-AkjOMP1KZhzFciQKCNc0ZEu8fgkmRFBzYRbiyEeeA5dhvm77qlRjvllI',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/1000561528606564362/2zoHyePcmBmx8Gw6BJYen0EM5NBb7fpq0jQgVFNZZy1aG2mEF3d5KrjFl7HXGBYxrvne',
    ['powerplants'] = 'https://discord.com/api/webhooks/1000561042767740938/3-bP1BQAC1GUpnN7J1IyqrcDfMpQegGZxD_82xVNgqWTFaqZvxNamWQg-iM7s5oKehqO',
    ['death'] = 'https://discord.com/api/webhooks/1000560330646245426/e8XhfkoXRgC29hx9WNTIllBVk98n4fA2t4jPBYPMNRcREiDSD_IIaJ5UFKOvXttGMPs2',
    ['joinleave'] = 'https://discord.com/api/webhooks/1000560050315722772/pGeAu_ubgp2ECHIXDlh6PgnclIS_akc4ItJ-U2HYaVbnelaudhsGG0mVy_Up-GJLZueR',
    ['ooc'] = 'https://discord.com/api/webhooks/1000559786200399933/ui_8-xSWbCkX6_YtA85IMydjg2--xrGowr6t6PHCS-Xv6ZaFPLRxwIGS--8WWrHMhkTN',
    ['report'] = 'https://discord.com/api/webhooks/1000559609607622716/GyY-bmkZ72cNTOb1L7WBxjP6HKJbAOr0Jiwtw9jvyCkgFNW_C7B8bSyyDRhWm3C330a2',
    ['me'] = 'https://discord.com/api/webhooks/1000559338802393118/Xn-23ev9EcbzCB9WgP_MLfIhChEq6tWr9SSr0G5tkhgQzbnrMuwdIEqjKTv0P-SdgBT-',
    ['pmelding'] = 'https://discord.com/api/webhooks/1000559061961551873/F6x7V5Zdud6CgiuS-rT527E8wu1nrH_2RaV7iDLJi3EuO-eeYRw4aco72yODwY__fsFG',
    ['112'] = 'https://discord.com/api/webhooks/1000558676366610432/FGnDoAPWUDiLth8jYAPoMjDUwtlV3EcuMDyFjVmJrM6xTBzO19jfBqOpJFuLsvLfazfI',
    ['bans'] = 'https://discord.com/api/webhooks/1000557926693474335/ot29kEZQxzmhOy8R7GOhGTBHChvzIQmiQV_J2Jvp-NfgcNImjo2ehPFxrmh7DWayLm22',
    ['anticheat'] = 'https://discord.com/api/webhooks/1000557650133647462/kMnGtrXmdtGCGU0AT7eDkmgMqNZU_uCMx2zuiiTQeoN0ehX2TuUCdwBVE22lDas32_OS',
    ['weather'] = 'https://discord.com/api/webhooks/1000557265037832212/2jWFW6uZtuFjTt5Pw8Qzsmc-2hngjnTA_h7jmPIA-9ThQ3--GXNQkyV0K_JIpSjfWrAw',
    ['moneysafes'] = 'https://discord.com/api/webhooks/1000556953774329967/q6eL4J18ExIMhZP2Z6iLNAGO-xYJM9_6jpqGqh0uooDCZ54mK23XBt5rJ35K7lwr2Ozn',
    ['bennys'] = 'https://discord.com/api/webhooks/1000657667632668783/W2HHInMGWLTNQFdAatwhChbUJBiXxtc4IlzFqov-GKE18KTPicSRXYy1j4crSRYdvuMr',
    ['bossmenu'] = 'https://discord.com/api/webhooks/1000556562663878676/QtItOW8rtG7lOOzMJT3tjd8_Ic0eitHnbcNpgANA-oYR2Urfix77rKSewlKXRtUUl2pF',
    ['robbery'] = 'https://discord.com/api/webhooks/1000556076233658499/cRWCJEvgaL4SmLm1luunyBXDRhtN_SuorxT_w6qqufg12zl2HpHb5zr4_fEsWpQBKGnh',
    ['casino'] = 'https://discord.com/api/webhooks/1000555799065661451/MRR9nd7dqYCzLnfbeWzkLUk2846-9PLLIW-XepwFwJimN1hGPqJVQOm067YDlrKqoRY8',
    ['traphouse'] = 'https://discord.com/api/webhooks/1000555262219931720/4F9x6JqkgNP73Q9uUjSjj12nnDlU4dUVzWn3C1Fasb09HEKkT4n-OsnkIW69WhkeBJmq',
    ['911'] = 'https://discord.com/api/webhooks/1000554936037290105/q2ro7QA2yVuPmzFemQxw__fB7FNQKF7-iH0_DaUWw4svi6I0pnH-EPTbTf7BYMHKA60m',
    ['palert'] = 'https://discord.com/api/webhooks/1000554566011601016/aqe1LEXF1EqvRO2mbtOoID0o6ZVWefIsmiLYLfbDWXb4tApKG3SztHvF9Bnr0cg-56dt',
    ['house'] = 'https://discord.com/api/webhooks/1000553328482205727/xKqNIAq-Glt_rTk6z3lCa9P3F-qU4qyEzKAMNRj7axFivOLGj95i6TFUWyr0628mjOAL',
    ['carboosting'] = 'https://discord.com/api/webhooks/998723723412639764/MFV_8B39pugXajVDv3KVXf3H9RDCc83bAG2NIuz_hFo2Kdh5WAJYyHlE5w-EjfK2eI5U'
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
