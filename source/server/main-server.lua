local GithubL, Changelog, ESX, QBCore, inPoleDance

local Version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) -- Do Not Change This Value
local Github = GetResourceMetadata(GetCurrentResourceName(), 'github', 0)
local Updater = false
local INPOLEDANCE = false
local PedNumber = 2
local PoledancePed1, PoledancePed2

-- Server Seat Locales
local GetPlayerSeated = 0
local Seat1Taken = false
local Seat2Taken = false
local Seat3Taken = false
local Seat4Taken = false
local Seat5Taken = false
local Seat6Taken = false
local Seat7Taken = false

-------- Check if new update available
Citizen.CreateThread(function()
    
    local Resources = GetNumResources()

	for i = 0, Resources, 1 do
		local resource = GetResourceByFindIndex(i)
		UpdateResource(resource)
	end

    Citizen.Wait(4000)

    if Updater == false then
        if Config.UpdateChecker then
            Updater = not Updater
            UpdateChecker()
        end
    end

end)

function UpdateResource(resource)
	if resource == 'fivem-checker' then
        if GetResourceState(resource) == 'started' or GetResourceState(resource) == 'starting' then
            if Config.UpdateChecker then
                Updater = true
            end
		end
	end
end

----------------

function UpdateChecker()
    
    if string.find(Github, "github") then
        if string.find(Github, "github.com") then
            GithubL = Github
            Github = string.gsub(Github, "github", "raw.githubusercontent")..'/master/version'
        else
            GithubL = string.gsub(Github, "raw.githubusercontent", "github"):gsub("/master", "")
            Github = Github..'/version'
        end
    else
    end
    PerformHttpRequest(Github, function(Error, V, Header)
        NewestVersion = V
    end)
    repeat
        Citizen.Wait(10)
    until NewestVersion ~= nil
    local _, strings = string.gsub(NewestVersion, "\n", "\n")
    Version1 = NewestVersion:match("[^\n]*"):gsub("[<>]", "")
    if string.find(Version1, Version) then
    else
        if strings > 0 then
            Changelog = NewestVersion:gsub(Version1,""):match("(.*" .. Version .. ")"):gsub(Version,"")
            Changelog = string.gsub(Changelog, "\n", "")
            Changelog = string.gsub(Changelog, "-", " \n-"):gsub("%b<>", ""):sub(1, -2)
            NewestVersion = Version1
        end
    end

    Citizen.Wait(500)
    
    print('')
    if Config.Framework == 'QBCore' then
        print('^8QBCore ^6KC Unicorn Script ('..GetCurrentResourceName()..')')
    elseif Config.Framework == 'Standalone' then
        print('^9Standalone ^6KC Unicorn Script ('..GetCurrentResourceName()..')')
    elseif Config.Framework == 'ESX' then
        print('^3ESX ^6KC Unicorn Script ('..GetCurrentResourceName()..')')
    end
    if Version == Version1 then
        print('^2Version ' .. Version .. ' - Up to date!')
    else
        print('^1Version ' .. Version .. ' - Outdated!')
        print('^1New version: v' .. Version1)
        if Config.ChangeLog then
            print('\n^3Changelog:')
            print('^4'..Changelog..'\n')
        end
        print('^1Please check the GitHub and download the last update')
        print('^2'..GithubL..'/releases/latest')
    end
    print('')
end