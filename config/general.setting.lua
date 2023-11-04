if not Config then Config = {} end

local sec = 1000
local min = 60 * sec

--[[

▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▄▄▀█░▄▄▀██░▄▄▀██░███░██░▄▄▄░██░██░██░▄▄▄░██░▄▄░████░▄▄▄░██░▄▄▀██░▄▄▀█▄░▄██░▄▄░█▄▄░▄▄██░▄▄▄░
██░▄▄▀█░▀▀░██░▄▄▀██▄▀▀▀▄██▄▄▄▀▀██░▄▄░██░███░██░▀▀░████▄▄▄▀▀██░█████░▀▀▄██░███░▀▀░███░████▄▄▄▀▀
██░▀▀░█░██░██░▀▀░████░████░▀▀▀░██░██░██░▀▀▀░██░███████░▀▀▀░██░▀▀▄██░██░█▀░▀██░██████░████░▀▀▀░
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

<Discord : AlertX#9397>,
<description 'This resource is created by BABYSHOP\'s Scripts'>

--]]
Config.Framework					= 'ESX'		-- Choose which framework your server is using so kc-unicorn can work with it [ESX, QBCore, Standalone]
Config.UpdateChecker                = true      -- Set to false if you don't want to check for resource update on start
Config.ChangeLog					= true		-- Set to false if you don't want to display the changelog if new version is find

---@type weapons[] ตั่งค่าของ weapons
Config = {
	['general'] = {
		['Command'] 			= 'toggleparticle', -- คำสั่งเปิด/ปิด Particle
	},
	['MythicNotifyExport'] 		= 'mythic_notify',
	['Notify'] = {
		['success'] 			= {'Effect ถูกทำงานแล้ว', 5000},
		['error'] 				= {'Effect ปิดทำงานแล้ว', 10000},
	},
	['WEAPON'] = {
		['WEAPON_MACHETE'] = {
			weaponModels = { -- หากต้องการให้อาวุธ มี Object ขึ้นเมื่อตอนถืออาวุธ เช่นเรากำหนดให้เมื่อถืออาวุธขึ้นมามี Object ที่เรากำหนดไว้ตาม bone ตามที่เราตั้งไว้ตกแต่งได้ สร้างได้ไม่จำกัด
				-- {
				-- 	weaponModel 		= 'w_me_machette_lr', -- ตั้งค่าโมเดล
				-- 	boneIndex 			= 18905, 
				-- 	xOffset 			= 0.108,
				-- 	yOffset 			= 0.000,
				-- 	zOffset 			= 0.013,
				-- 	xRotation 			= 85.400,
				-- 	yRotation 			= -10.400,
				-- 	zRotation 			= -9.800,
				-- },
				{
					weaponModel 		= 'babyshop_fashion_futie_newplayer',
					boneIndex 			= 31086, 
					xOffset 			= 0.146, 
					yOffset 			= 0.019, 
					zOffset 			= 0.011, 
					xRotation 			= -10.400, 
					yRotation 			= -94.400, 
					zRotation 			= 195.000
				},
			},
			----------------------------------------------
			Particle = { -- การตั้งค่า Effect แบบ Custom
				{ 	-- สำหรับ template 'fire มีสีทั้งหมด 8 สี ตามที่มีไว้ให้ อันอื่นมี 7 สี'
					template 	=  'EffectRun3', -- [EffectRun1], [EffectRun2], [FoolfireBlack], [thunder], [fire], [ThunderRgb ปรับ color เป็น Rgb], [FireLoop], [Fool], [custom],
					color 	 	=  "yellow",   -- [red], [yellow], [lightblue], [green], [purple], [blue], [pink] [black]>> เฉพาะ frie, [rgb]>> เฉพาะ ThunderRgb,
					size		=  1.3,
					particle 	=  true,
				}
			}			
		},	
	}
} 