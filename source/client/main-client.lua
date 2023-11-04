BB_WeaponDual = GetCurrentResourceName()..'.'
local BB_heldWeapon = nil
local BB_spawnedObjects = {}
local BB_isDead = false
local isParticleVisible = true

baby = {}
baby.FN = {}

if BB_WeaponDual == GetCurrentResourceName()..'.' then
	Citizen.CreateThread(function()
		Citizen.Wait(100)

		baby.FN.Init()
        print("^2Success to load The SourceCode script | ScriptName : ^5BB_WeaponEffect")
	end)
else
	print("^1Failed to load The Resource script name is changed | ^0Contact : https://discord.gg/QNrVVHq5DM @AlertX#9397")
end

-- ฟังก์ชันสำหรับการลงทะเบียนเหตุการณ์ใหม่
local BB_newEvent = function(name, handler)
    RegisterNetEvent(name)
    AddEventHandler(name, handler)
end

baby.FN.Init = function()
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)

            RegisterCommand(Config['general']['Command'], function()
                ShowOrHideParticle()
            end)
        end
    end)
        
    -- ฟังก์ชันสำหรับการเปิด Particle
    function ShowOrHideParticle()
        isParticleVisible = not isParticleVisible
        if isParticleVisible then
            exports[Config['MythicNotifyExport']]:DoHudText('success', Config['Notify']['success'][1], Config['Notify']['success'][2])
        else
            exports[Config['MythicNotifyExport']]:DoHudText('error', Config['Notify']['error'][1], Config['Notify']['error'][2])
        end        
    end

    function BB_DeleteObject(player)
        for _, obj in ipairs(BB_spawnedObjects) do
            DeleteObject(obj)
        end
        BB_spawnedObjects = {}  -- เคลียร์ตัวแปรสำหรับเก็บ Object ที่ถูกสร้าง
    end
    
    function BB_SpawnObjectOnPlayerBone(player, objectModel, boneIndex, xOffset, yOffset, zOffset, xRotation, yRotation, zRotation, shouldWait)
        local ped = GetPlayerPed(player)
        local bone = GetPedBoneIndex(ped, boneIndex)
        
        local x, y, z = table.unpack(GetPedBoneCoords(ped, bone))
        
        local obj = CreateObject(GetHashKey(objectModel), x + xOffset, y + yOffset, z + zOffset, true, true, true)
        SetEntityCollision(obj, false, false)
        AttachEntityToEntity(obj, ped, bone, xOffset, yOffset, zOffset, xRotation, yRotation, zRotation, true, false, false, false, 2, true)
        
        table.insert(BB_spawnedObjects, obj)
    end
    
    Citizen.CreateThread(function()
        local player = PlayerId()
        local lastWeaponHash = nil
        local createdObject = false -- เพิ่มตัวแปรสำหรับตรวจสอบว่า Object ถูกสร้างแล้วหรือไม่
    
        while true do
            Citizen.Wait(1000) -- รอ 1 วินาที
    
            local ped = GetPlayerPed(player)
    
            if DoesEntityExist(ped) and IsEntityDead(ped) == false then
                local currentWeapon = GetSelectedPedWeapon(ped)
                local weaponChanged = false
    
                if lastWeaponHash ~= currentWeapon then
                    lastWeaponHash = currentWeapon
                    weaponChanged = true
                end
    
                if weaponChanged then
                    if createdObject then
                        BB_DeleteObject(player)  -- เรียกฟังก์ชันลบ Object
                        createdObject = false
                    end
                end
    
                -- ทำงานเมื่อค้นพบอาวธที่ตรงกับข้อมูลที่คุณต้องการ
                for k, weaponInfo in pairs(Config['WEAPON']) do
                    local weaponHash = GetHashKey(k)
    
                    if currentWeapon == weaponHash then
                        if not createdObject then
                            for _, weaponModelInfo in pairs(weaponInfo.weaponModels) do
                                BB_SpawnObjectOnPlayerBone(player, weaponModelInfo.weaponModel, weaponModelInfo.boneIndex, weaponModelInfo.xOffset, weaponModelInfo.yOffset, weaponModelInfo.zOffset, weaponModelInfo.xRotation, weaponModelInfo.yRotation, weaponModelInfo.zRotation)
                            end
                            createdObject = true
                        end
    
                        local particleData = weaponInfo.Particle
                        particleData.template = weaponInfo.Particle.template
    
                        if isParticleVisible then
                            BB_EffectRun(particleData)
                        end
                    end
                end
            end
        end
    end)    
          
    -- ฟังก์ชันสำหรับการเรียกใช้งาน Particle
    function BB_EffectRun(particleArray)
        local playerPed = PlayerPedId()
        for _, particleData in pairs(particleArray) do
            local template = particleData.template
            if template == 'EffectRun1' then
                BB_EffectRun1(particleData)
            elseif template == 'EffectRun2' then
                BB_EffectRun2(particleData)
            elseif template == 'EffectRun3' then
                BB_EffectRun3(particleData)
            elseif template == 'thunder' then
                thunder(particleData)
            elseif template == 'fire' then
                fire(particleData)
            elseif template == 'Fool' then
                Fool(particleData)
            elseif template == 'FireLoop' then
                FireLoop(particleData)
            elseif template == 'FoolfireBlack' then
                FoolfireBlack(particleData)
            elseif template == 'Custom' then
                Custom(particleData)
            elseif template == 'ThunderRgb' then
                ThunderRgb(particleData)
            end
        end
    end
    
    ------------------ Effect สองข้าง FireBlack and Thunder ------------------
    function BB_EffectRun1(particleData)
        local playerPed = PlayerPedId()
    
        if particleData.particle then

            local colorConfig = {
                red = { particleDictionary = "babyshop_effect_fireblack1", particleName = "babyshop_effect_fireblack1" },
                yellow = { particleDictionary = "babyshop_effect_fireblack2", particleName = "babyshop_effect_fireblack2"},
                lightblue = { particleDictionary = "babyshop_effect_fireblack3", particleName = "babyshop_effect_fireblack3"},
                green = { particleDictionary = "babyshop_effect_fireblack4", particleName = "babyshop_effect_fireblack4"},
                purple = { particleDictionary = "babyshop_effect_fireblack5", particleName = "babyshop_effect_fireblack5"},
                blue = { particleDictionary = "babyshop_effect_fireblack6", particleName = "babyshop_effect_fireblack6"},
                white = { particleDictionary = "babyshop_effect_fireblack7", particleName = "babyshop_effect_fireblack7"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end

                ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                ------------------------------------------------
                SetPtfxAssetNextCall(particleDictionary)
                local effect6 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.00001, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect7 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.05, -0.15, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect8 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.02, -0.25, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect9 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.01, -0.35, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect10 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.05, -0.50, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
            else
                
            end          
        end

        if particleData.particle then

            local colorConfig = {
                red = { particleDictionary = "spakeffect1", particleName = "spakeffect1" },
                yellow = { particleDictionary = "spakeffect2", particleName = "spakeffect2"},
                lightblue = { particleDictionary = "spakeffect3", particleName = "spakeffect3"},
                green = { particleDictionary = "spakeffect4", particleName = "spakeffect4"},
                purple = { particleDictionary = "spakeffect5", particleName = "spakeffect5"},
                blue = { particleDictionary = "spakeffect6", particleName = "spakeffect6"},
                white = { particleDictionary = "spakeffect9", particleName = "spakeffect9"},
            }
    
            local selectedColor = colorConfig[particleData.color]
    
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
    
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.02, -0.4, 0.01, 0.0, 0.5, 70.0, 18905, 0.8, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, 0.8, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.00, -0.3, 0.01, 0.0, 0.05, 70.0, 18905, 0.8, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, 0.8, false, false, false)
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end
        end

    end

    ------------------ Effect ข้างเดียว FireBlack and Thunder ------------------
    function BB_EffectRun2(particleData)
        local playerPed = PlayerPedId()
        
        if particleData.particle then
    
            local colorConfig = {
                red = { particleDictionary = "babyshop_effect_fireblack1", particleName = "babyshop_effect_fireblack1" },
                yellow = { particleDictionary = "babyshop_effect_fireblack2", particleName = "babyshop_effect_fireblack2"},
                lightblue = { particleDictionary = "babyshop_effect_fireblack3", particleName = "babyshop_effect_fireblack3"},
                green = { particleDictionary = "babyshop_effect_fireblack4", particleName = "babyshop_effect_fireblack4"},
                purple = { particleDictionary = "babyshop_effect_fireblack5", particleName = "babyshop_effect_fireblack5"},
                blue = { particleDictionary = "babyshop_effect_fireblack6", particleName = "babyshop_effect_fireblack6"},
                white = { particleDictionary = "babyshop_effect_fireblack7", particleName = "babyshop_effect_fireblack7"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
    
            local colorConfig = {
                red = { particleDictionary = "spakeffect1", particleName = "spakeffect1" },
                yellow = { particleDictionary = "spakeffect2", particleName = "spakeffect2"},
                lightblue = { particleDictionary = "spakeffect3", particleName = "spakeffect3"},
                green = { particleDictionary = "spakeffect4", particleName = "spakeffect4"},
                purple = { particleDictionary = "spakeffect5", particleName = "spakeffect5"},
                blue = { particleDictionary = "spakeffect6", particleName = "spakeffect6"},
                white = { particleDictionary = "spakeffect9", particleName = "spakeffect9"},
            }
        
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
        
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, 0.8, false, false, false)
                    SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, 0.8, false, false, false)
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end
        end

    end

    ------------------ Effect Thunder ข้างเดียว ------------------
    function thunder(particleData)
        local playerPed = PlayerPedId()
            
        if particleData.particle then
    
            local colorConfig = {
                red = { particleDictionary = "spakeffect1", particleName = "spakeffect1" },
                yellow = { particleDictionary = "spakeffect2", particleName = "spakeffect2"},
                lightblue = { particleDictionary = "spakeffect3", particleName = "spakeffect3"},
                green = { particleDictionary = "spakeffect4", particleName = "spakeffect4"},
                purple = { particleDictionary = "spakeffect5", particleName = "spakeffect5"},
                blue = { particleDictionary = "spakeffect6", particleName = "spakeffect6"},
                white = { particleDictionary = "spakeffect9", particleName = "spakeffect9"},
            }
        
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
                    
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
                    SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end
        end

    end

    ------------------ Effect fire ข้างเดียว ------------------
    function fire(particleData)
        local playerPed = PlayerPedId()
        
        if particleData.particle then
    
            local colorConfig = {
                lightblue = { particleDictionary = "alertxeffect1", particleName = "scr_effectalert1" },
                yellow = { particleDictionary = "alertxeffect2", particleName = "scr_effectalert2"},
                blue = { particleDictionary = "alertxeffect3", particleName = "scr_effectalert3"},
                green = { particleDictionary = "alertxeffect4", particleName = "scr_effectalert4"},
                pink = { particleDictionary = "alertxeffect5", particleName = "scr_effectalert5"},
                red = { particleDictionary = "alertxeffect6", particleName = "scr_effectalert6"},
                purple = { particleDictionary = "alertxeffect7", particleName = "scr_effectalert7"},
                black = { particleDictionary = "babyshop_effect_fireblack1", particleName = "babyshop_effect_fireblack1"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

    end

    ------------------ Effect Fool ------------------
    function Fool(particleData)
        local playerPed = PlayerPedId()
        
        if particleData.particle then
    
            local colorConfig = {
                white = { particleDictionary = "fooleffect1", particleName = "fooleffect1" },
                blue = { particleDictionary = "fooleffect2", particleName = "fooleffect2"},
                green = { particleDictionary = "fooleffect4", particleName = "fooleffect4"},
                pink = { particleDictionary = "fooleffect5", particleName = "fooleffect5"},
                lightblue = { particleDictionary = "fooleffect3", particleName = "fooleffect3"},
                purple = { particleDictionary = "fooleffect6", particleName = "fooleffect6"},
                red = { particleDictionary = "fooleffect7", particleName = "fooleffect7"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

    end

    ------------------ Effect FireLoop ------------------
    function FireLoop(particleData)
        local playerPed = PlayerPedId()
        
        if particleData.particle then
    
            local colorConfig = {
                lightblue = { particleDictionary = "alertxeffect1", particleName = "scr_effectalert1" },
                yellow = { particleDictionary = "alertxeffect2", particleName = "scr_effectalert2"},
                blue = { particleDictionary = "alertxeffect3", particleName = "scr_effectalert3"},
                green = { particleDictionary = "alertxeffect4", particleName = "scr_effectalert4"},
                pink = { particleDictionary = "alertxeffect5", particleName = "scr_effectalert5"},
                red = { particleDictionary = "alertxeffect6", particleName = "scr_effectalert6"},
                purple = { particleDictionary = "alertxeffect7", particleName = "scr_effectalert7"},
                black = { particleDictionary = "babyshop_effect_fireblack1", particleName = "babyshop_effect_fireblack1"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                Wait(100)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                Wait(200)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                Wait(300)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                Wait(400)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                Wait(500)
            ------------------------------------------------     
            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

    end

    ------------------ Effect Thuner Rgb  ------------------
    function ThunderRgb(particleData)
        local playerPed = PlayerPedId()
        
        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect1"
                local particleName = "spakeffect1"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect2"
                local particleName = "spakeffect2"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect3"
                local particleName = "spakeffect3"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect4"
                local particleName = "spakeffect4"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect5"
                local particleName = "spakeffect5"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect6"
                local particleName = "spakeffect6"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect7"
                local particleName = "spakeffect7"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect9"
                local particleName = "spakeffect9"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end

        if particleData.particle then
            
            local colorConfig = {
                rgb = {},
            }

            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = "spakeffect10"
                local particleName = "spakeffect10"
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
    
            ------------------------------------------------            
            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.17, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.2, 0.05, 0.0, 0.05, 70.0, 57005, particleData.size, false, false, false)
            ------------------------------------------------     
            else
                Citizen.Wait(400)
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end    
        end
    end

    ------------------ Effect สองข้าง FireBlack and Thunder ------------------
    function FoolfireBlack(particleData)
        local playerPed = PlayerPedId()
    
        if particleData.particle then

            local colorConfig = {
                red = { particleDictionary = "babyshop_effect_fireblack1", particleName = "babyshop_effect_fireblack1" },
                yellow = { particleDictionary = "babyshop_effect_fireblack2", particleName = "babyshop_effect_fireblack2"},
                lightblue = { particleDictionary = "babyshop_effect_fireblack3", particleName = "babyshop_effect_fireblack3"},
                green = { particleDictionary = "babyshop_effect_fireblack4", particleName = "babyshop_effect_fireblack4"},
                purple = { particleDictionary = "babyshop_effect_fireblack5", particleName = "babyshop_effect_fireblack5"},
                blue = { particleDictionary = "babyshop_effect_fireblack6", particleName = "babyshop_effect_fireblack6"},
                white = { particleDictionary = "babyshop_effect_fireblack7", particleName = "babyshop_effect_fireblack7"},
            }
    
            local selectedColor = colorConfig[particleData.color]
        
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
        
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end

                ------------------------------------------------            
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, 2.0, false, false, false)
                ------------------------------------------------
                SetPtfxAssetNextCall(particleDictionary)
                local effect6 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.00001, 0.00001, 0.0, 0.0, 0.0, 18905, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect7 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.05, -0.15, 0.00001, 0.0, 0.0, 0.0, 18905, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect8 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.02, -0.25, 0.00001, 0.0, 0.0, 0.0, 18905, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect9 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.01, -0.35, 0.00001, 0.0, 0.0, 0.0, 18905, 2.0, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect10 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.05, -0.50, 0.00001, 0.0, 0.0, 0.0, 18905, 2.0, false, false, false)
            else
                
            end          
        end

        if particleData.particle then

            local colorConfig = {
                white = { particleDictionary = "fooleffect1", particleName = "fooleffect1" },
                blue = { particleDictionary = "fooleffect2", particleName = "fooleffect2"},
                green = { particleDictionary = "fooleffect4", particleName = "fooleffect4"},
                pink = { particleDictionary = "fooleffect5", particleName = "fooleffect5"},
                lightblue = { particleDictionary = "fooleffect3", particleName = "fooleffect3"},
                purple = { particleDictionary = "fooleffect6", particleName = "fooleffect6"},
                red = { particleDictionary = "fooleffect7", particleName = "fooleffect7"},
            }
    
            local selectedColor = colorConfig[particleData.color]
    
            if selectedColor then
                local particleDictionary = selectedColor.particleDictionary
                local particleName = selectedColor.particleName
                RequestNamedPtfxAsset(particleDictionary)
    
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end

                ----------------------------------------
                SetPtfxAssetNextCall(particleDictionary)
                local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.10, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.15, 0.15, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.20, 0.25, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect4 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.25, 0.35, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect5 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.30, 0.45, 0.00001, 0.0, 0.0, 0.0, 57005, particleData.size, false, false, false)
                ----------------------------------------

                ----------------------------------------
                SetPtfxAssetNextCall(particleDictionary)
                local effect6 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.1, 0.00001, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect7 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.05, -0.15, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect8 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, 0.02, -0.25, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect9 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.01, -0.35, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                SetPtfxAssetNextCall(particleDictionary)
                local effect10 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, -0.05, -0.50, 0.00001, 0.0, 0.0, 0.0, 18905, particleData.size, false, false, false)
                ----------------------------------------

            else
                -- สามารถใส่โค้ดเพิ่มเติมที่ต้องการเมื่อไม่พบสีที่ต้องการใน Config
            end
        end

    end

    ------------------ Custom particle ------------------
    function Custom(particleData)
        local playerPed = PlayerPedId()

        if particleData.particle then
            Wait(particleData.Time)
            local particleDictionary = particleData.particleDictionary
            local particleName = particleData.particleName
            RequestNamedPtfxAsset(particleDictionary)
        
            while not HasNamedPtfxAssetLoaded(particleDictionary) do
                Citizen.Wait(0)
            end

            SetPtfxAssetNextCall(particleDictionary)
            local effect1 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, playerPed, particleData.xOffset, particleData.yOffset, particleData.zOffset, particleData.xRotation, particleData.yRotation, particleData.zRotation, particleData.boneIndex, particleData.size, false, false, false)
        end
    end

end