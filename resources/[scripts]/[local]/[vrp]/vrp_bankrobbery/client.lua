local robbing = false
local bank = ""
local secondsRemaining = 0
local incircle = false

function bank_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, false, false, -1)
end

function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

local banks = {}

RegisterNetEvent("es_bank:init")
AddEventHandler(
	"es_bank:init",
	function(bankList)
		banks = bankList
	end
)

RegisterNetEvent("es_bank:currentlyrobbing")
AddEventHandler(
	"es_bank:currentlyrobbing",
	function(robb, time)
		robbing = true
		bank = robb
		secondsRemaining = time
	end
)

RegisterNetEvent("es_bank:toofarlocal")
AddEventHandler(
	"es_bank:toofarlocal",
	function(robb)
		robbing = false
		TriggerEvent("chatMessage", "알림", {255, 0, 0}, "강도가 취소되었습니다. 당신의 수익은 없습니다.")
		robbingName = ""
		secondsRemaining = 0
		incircle = false
	end
)

RegisterNetEvent("es_bank:playerdiedlocal")
AddEventHandler(
	"es_bank:playerdiedlocal",
	function(robb)
		robbing = false
		TriggerEvent("chatMessage", "알림", {255, 0, 0}, "당신은 사망했습니다! 수익은 없습니다.")
		robbingName = ""
		secondsRemaining = 0
		incircle = false
	end
)

RegisterNetEvent("es_bank:robberycomplete")
AddEventHandler(
	"es_bank:robberycomplete",
	function(reward)
		robbing = false
		TriggerEvent("chatMessage", "알림", {255, 0, 0}, "금고를 다 털었습니다! 얼른 도망치세요! [수익 :^2" .. format_num(reward) .. "원]")
		bank = ""
		secondsRemaining = 0
		incircle = false
	end
)

Citizen.CreateThread(
	function()
		while true do
			TriggerServerEvent("es_bank:init")
			Citizen.Wait(10000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if robbing then
				TriggerServerEvent("es_bank:updateOnline")
			end
			Citizen.Wait(1000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if robbing then
				Citizen.Wait(1000)
				if (secondsRemaining > 0) then
					secondsRemaining = secondsRemaining - 1
				end
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			for k, v in pairs(banks) do
				local pos2 = v.position

				if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0) then
					if IsPlayerWantedLevelGreater(PlayerId(), 0) or ArePlayerFlashingStarsAboutToDrop(PlayerId()) then
						local wanted = GetPlayerWantedLevel(PlayerId())
						Citizen.Wait(5000)
						SetPlayerWantedLevel(PlayerId(), wanted, 0)
						SetPlayerWantedLevelNow(PlayerId(), 0)
					end
				end
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		for k, v in pairs(banks) do
			local ve = v.position

			local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
			SetBlipSprite(blip, 278)
			SetBlipScale(blip, 0.8)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Robbable Bank")
			EndTextCommandSetBlipName(blip)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)

			for k, v in pairs(banks) do
				local pos2 = v.position

				if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0) then
					if not robbing then
						DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.2, 1555, 0, 0, 255, 0, 0, 0, 0)
						if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2) then
							if (incircle == false) then
								bank_DisplayHelpText("강도를 진행하려면 ~INPUT_CONTEXT~ 를 누르세요!")
							end
							incircle = true
							if (IsControlJustReleased(1, 51)) then
								TriggerServerEvent("es_bank:rob", k)
							end
						elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2) then
							incircle = false
						end
					end
				end
			end

			if robbing then
				SetPlayerWantedLevel(PlayerId(), 0, 0)
				SetPlayerWantedLevelNow(PlayerId(), 0)

				DrawTxt(0.40, 0.88, 0.00, 0.00, 0.41, "은행강도 성공까지 ~r~" .. secondsRemaining .. "~w~ 초 남았습니다!", 255, 255, 255, 255)

				if bank and banks[bank] then
					local pos2 = banks[bank].position
					local ped = GetPlayerPed(-1)

					if IsEntityDead(ped) then
						TriggerServerEvent("es_bank:playerdied", bank)
					elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15) then
						TriggerServerEvent("es_bank:toofar", bank)
					end
				end
			end

			Citizen.Wait(0)
		end
	end
)
