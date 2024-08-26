NTEYE = {} -- Neurotrauma Eyes
NTEYE.Name="Eyes"
NTEYE.Version = "A1.1.14"
NTEYE.VersionNum = 010101400
NTEYE.MinNTVersion = "A1.9.4h1"
NTEYE.MinNTVersionNum = 01090401
NTEYE.Path = table.pack(...)[1]
Timer.Wait(function() if NTC ~= nil then NTC.RegisterExpansion(NTEYE) end end,1)


Timer.Wait(function() 
	if SERVER and NTC == nil then --checks if NT is installed
		print("Error loading NT Eyes: It SEEms Neurotrauma isn't loaded!")
		return
	end
	
		--server side scripts
	if SERVER or (CLIENT and not Game.IsMultiplayer) then
		
		dofile(NTEYE.Path.."/Lua/Scripts/Server/eyeupdateServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/eyesurgeryServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/eyeondamageServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/spoonServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/eyedecoServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/itemspawnServer.lua")
		dofile(NTEYE.Path.."/Lua/Scripts/Server/eyeNetworkServer.lua")
		
		--Robotrauma Compatibility Patch
		for package in ContentPackageManager.EnabledPackages.All do
				if 
					   tostring(package.UgcId) == "2948488019" --Robotrauma
					or tostring(package.UgcId) == "2952546076" --Robo-Trauma-
					or tostring(package.UgcId) == "3227815460" --Robotrauma (Afflictions Override)
				then
					dofile(NTEYE.Path.."/Lua/Scripts/Compatibility/robotraumaComp.lua")
					print("NT Eyes - Robotrauma Integrated Compatibility Patch")
				break
			end
		end
		
		--Immersive Diving Gear Compatibility Patch
		for package in ContentPackageManager.EnabledPackages.All do
				if 
					tostring(package.UgcId) == "3074045632" 
				then
					dofile(NTEYE.Path.."/Lua/Scripts/Compatibility/immersivedivingComp.lua")
					print("NT Eyes - Immersive Diving Gear Integrated Compatibility Patch")
				break
			end
		end


		
	end
		
		--client side scripts
	if CLIENT then
        dofile(NTEYE.Path.."/Lua/Scripts/Client/eyeupdateClient.lua")
        dofile(NTEYE.Path.."/Lua/Scripts/Client/eyezoomClient.lua")
        dofile(NTEYE.Path.."/Lua/Scripts/Client/medicaleyes.lua") -- testing purpouses
		
	end

end,1)


