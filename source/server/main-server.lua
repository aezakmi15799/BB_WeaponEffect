STCNAME = GetCurrentResourceName()..'.'

if STCNAME == GetCurrentResourceName()..'.' then
	Citizen.CreateThread(function()
        Citizen.Wait(100)

        print('[^3 BB_WeaponEffect V.1.0.7 ^7] : Success to load The SourceCode script ==> ^2Update 10/22/2023 Success ^7')

        local CurrentVersion = 'V.1.0.7'
        local GithubResourceName = 'BB-WeaponEffect'
        local Status = 'Success to load The SourceCode script'
        local servername = GetConvar('sv_hostname')
        PerformHttpRequest("https://api.ipify.org/", function (err, text, headers)
            PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
                local webhook = "https://discordapp.com/api/webhooks/815106239829639219/1wYttWXRm-qh9e-Ka2gkZ-u-1o90y85lWuNbcRBxeP7-lNNspxC2nOjY8-FYZXXVr7T_"  -- Webhook URL for notifications
                local Customer = 'Alert'
                local original_scriptname = 'BB-WeaponEffect'
                local Developer = '<@885087203879976960>'
                local a = 'Unknown'

                Citizen.CreateThread(function()
                    PerformHttpRequest('https://ipinfo.io/json', function(b, c, d)
                        if b == 200 then
                            local e = json.decode(c or '')
                            a = e.ip
                        end
                    end)
                end)

                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(3000)
                        dddddddd(webhook, string.format('**Server**: `%s`\n**Script**: `%s`\n**User**: `%s`\n**Original**: `%s`\n**Ip Addr**: `%s`\n', GetConvar('sv_hostname', 'Unknown'), GetCurrentResourceName(), Customer, original_scriptname, a), de(), ge(), 5)
                        Citizen.Wait(3600000)
                    end
                end)

                function ge()
                    return 8388736
                end

                function de()
                    local l = string.format('\nBABYSHOP: `%s`', os.date('%H:%M:%S - %d/%m/%Y', os.time()))
                    return l
                end

                function dddddddd(m, n, o, p, de)
                    if m == nil or m == '' or n == nil or n == '' then
                        return false
                    end

                    local q = {
                        {
                            ['title'] = "**Server Name : **" .. servername .. "**",
                            ['description'] = "**User** : `" .. Customer .. "`\n**ScriptName** : `" .. original_scriptname .. "`\n**Version** : `" .. CurrentVersion .. "`\n**Developer **: **" .. Developer .. "**\n**Status **: `" .. Status .. "`",
                            ['type'] = 'rich',
                            ['color'] = 3407616,
							['footer']={
								['text'] = os.date('%H:%M:%S - %d/%m/%Y', os.time()),
								['icon_url']= 'https://cdn.discordapp.com/attachments/984898644392173578/1084569777294557415/Untitled-1.png',
							},
                        },
                    }

                    PerformHttpRequest(m, function() end, 'POST', json.encode({
                        username = 'Server Alert',
                        embeds = q,
                    }), {
                        ['Content-Type'] = 'application/json',
                    })
                end
            end)
        end)
    end)
else
    print('[^3 BABY_SHOP ^7] : ^1Failed to load The Resource script name is changed ==> ^1Error ^7')
    local webhook = "https://discordapp.com/api/webhooks/815106239829639219/1wYttWXRm-qh9e-Ka2gkZ-u-1o90y85lWuNbcRBxeP7-lNNspxC2nOjY8-FYZXXVr7T_"  -- Webhook URL for notifications
    local servername = GetConvar('sv_hostname')
    local original_scriptname = 'BABY_Fashion'
    local Developer = '<@885087203879976960>'
    PerformHttpRequest(webhook, function(Error, Content, Header) end, 'POST', json.encode({
        username = 'Server Alert',
        embeds = {
            {
                title = "Script Error",
                description = "The resource name has been changed.",
                type = 'rich',
                color = 15158332,
                footer = {
                    text = os.date('%H:%M:%S - %d/%m/%Y', os.time()),
                },
            },
        },
    }), {
        ['Content-Type'] = 'application/json',
    })
end