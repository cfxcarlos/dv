-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec3(316.28,-1416.90,32.25), ["Heading"] = 139.98, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(314.46,-1415.38,32.25), ["Heading"] = 140.38, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(312.58,-1413.79,32.25), ["Heading"] = 140.41, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(310.73,-1412.25,32.25), ["Heading"] = 140.11, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(308.84,-1410.66,32.25), ["Heading"] = 140.05, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(306.99,-1409.10,32.25), ["Heading"] = 139.96, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(304.99,-1407.43,32.25), ["Heading"] = 140.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(303.17,-1405.90,32.25), ["Heading"] = 139.84, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(310.10,-1404.32,32.25), ["Heading"] = 50.000, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(311.68,-1402.43,32.25), ["Heading"] = 50.330, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(313.23,-1400.59,32.25), ["Heading"] = 50.150, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(314.82,-1398.70,32.25), ["Heading"] = 50.020, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(322.02,-1396.00,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(323.84,-1397.53,32.25), ["Heading"] = 320.23, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(325.72,-1399.11,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(327.57,-1400.66,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(329.46,-1402.25,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(331.31,-1403.80,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(333.30,-1405.47,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(335.13,-1407.00,32.25), ["Heading"] = 320.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(326.63,-1408.37,32.25), ["Heading"] = 230.01, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(325.05,-1410.25,32.25), ["Heading"] = 230.17, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(323.50,-1412.09,32.25), ["Heading"] = 230.00, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(321.91,-1413.99,32.25), ["Heading"] = 230.09, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(314.45,-1407.28,32.25), ["Heading"] = 139.96, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(316.35,-1408.88,32.25), ["Heading"] = 139.35, ["Invert"] = 0.0 },
	{ ["Coords"] = vec3(318.19,-1410.42,32.25), ["Heading"] = 139.60, ["Invert"] = 0.0 },
	-- Boolingbroke
	{ ["Coords"] = vec3(1761.87,2591.56,45.50), ["Heading"] = 272.13, ["Invert"] = 180.0 },
	{ ["Coords"] = vec3(1761.87,2594.64,45.50), ["Heading"] = 272.13, ["Invert"] = 180.0 },
	{ ["Coords"] = vec3(1761.87,2597.73,45.50), ["Heading"] = 272.13, ["Invert"] = 180.0 },
	{ ["Coords"] = vec3(1771.98,2597.95,45.50), ["Heading"] = 87.88, ["Invert"] = 180.0 },
	{ ["Coords"] = vec3(1771.98,2594.88,45.50), ["Heading"] = 87.88, ["Invert"] = 180.0 },
	{ ["Coords"] = vec3(1771.98,2591.79,45.50), ["Heading"] = 87.88, ["Invert"] = 180.0 },
	-- Clandestine
	{ ["Coords"] = vec3(-471.87,6287.56,13.63), ["Heading"] = 53.86, ["Invert"] = 180.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,v["Coords"],2.0,1.0,{
			name = "Beds:"..Number,
			["Heading"] = v["Heading"],
			minZ = v["Coords"]["z"] - 0.25,
			maxZ = v["Coords"]["z"] + 0.50
		},{
			shop = Number,
			Distance = 1.50,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:PutBed",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 0.5,false,false,false,false)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Heading"] - Beds[Number]["Invert"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5,false,false,false,false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:Treatment",function(Number,Ignore)
	if not Previous and (Ignore or vSERVER.CheckIn()) then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 0.5,false,false,false,false)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Heading"] - Beds[Number]["Invert"])

		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		TriggerEvent("inventory:preventWeapon")
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")

		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(101)
		end

		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Treatment and GetGameTimer() >= TreatmentTimer then
			local Health = GetEntityHealth(Ped)
			TreatmentTimer = GetGameTimer() + 1000

			if Health < 200 then
				SetEntityHealth(Ped,Health + 1)
			else
				Treatment = false
				NetworkSetFriendlyFireOption(true)
				LocalPlayer["state"]:set("Cancel",false,true)
				LocalPlayer["state"]:set("Buttons",false,true)
				LocalPlayer["state"]:set("Commands",false,true)
				TriggerEvent("Notify","Centro Médico","Tratamento concluido.","sucesso",5000)
			end
		end

		if Previous and not IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5,false,false,false,false)
			Previous = nil
		end

		Wait(1000)
	end
end)