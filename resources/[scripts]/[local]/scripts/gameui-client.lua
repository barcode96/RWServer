function drawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

local zones = {
	["AIRP"] = "Los Santos International Airport",
	["ALAMO"] = "Alamo Sea",
	["ALTA"] = "Alta",
	["ARMYB"] = "Fort Zancudo",
	["BANHAMC"] = "Banham Canyon Dr",
	["BANNING"] = "Banning",
	["BEACH"] = "Vespucci Beach",
	["BHAMCA"] = "Banham Canyon",
	["BRADP"] = "Braddock Pass",
	["BRADT"] = "Braddock Tunnel",
	["BURTON"] = "Burton",
	["CALAFB"] = "Calafia Bridge",
	["CANNY"] = "Raton Canyon",
	["CCREAK"] = "Cassidy Creek",
	["CHAMH"] = "Chamberlain Hills",
	["CHIL"] = "Vinewood Hills",
	["CHU"] = "Chumash",
	["CMSW"] = "Chiliad Mountain State Wilderness",
	["CYPRE"] = "Cypress Flats",
	["DAVIS"] = "Davis",
	["DELBE"] = "Del Perro Beach",
	["DELPE"] = "Del Perro",
	["DELSOL"] = "La Puerta",
	["DESRT"] = "Grand Senora Desert",
	["DOWNT"] = "Downtown",
	["DTVINE"] = "Downtown Vinewood",
	["EAST_V"] = "East Vinewood",
	["EBURO"] = "El Burro Heights",
	["ELGORL"] = "El Gordo Lighthouse",
	["ELYSIAN"] = "Elysian Island",
	["GALFISH"] = "Galilee",
	["GOLF"] = "GWC and Golfing Society",
	["GRAPES"] = "Grapeseed",
	["GREATC"] = "Great Chaparral",
	["HARMO"] = "Harmony",
	["HAWICK"] = "Hawick",
	["HORS"] = "Vinewood Racetrack",
	["HUMLAB"] = "Humane Labs and Research",
	["JAIL"] = "Bolingbroke Penitentiary",
	["KOREAT"] = "Little Seoul",
	["LACT"] = "Land Act Reservoir",
	["LAGO"] = "Lago Zancudo",
	["LDAM"] = "Land Act Dam",
	["LEGSQU"] = "Legion Square",
	["LMESA"] = "La Mesa",
	["LOSPUER"] = "La Puerta",
	["MIRR"] = "Mirror Park",
	["MORN"] = "Morningwood",
	["MOVIE"] = "Richards Majestic",
	["MTCHIL"] = "Mount Chiliad",
	["MTGORDO"] = "Mount Gordo",
	["MTJOSE"] = "Mount Josiah",
	["MURRI"] = "Murrieta Heights",
	["NCHU"] = "North Chumash",
	["NOOSE"] = "N.O.O.S.E",
	["OCEANA"] = "Pacific Ocean",
	["PALCOV"] = "Paleto Cove",
	["PALETO"] = "Paleto Bay",
	["PALFOR"] = "Paleto Forest",
	["PALHIGH"] = "Palomino Highlands",
	["PALMPOW"] = "Palmer-Taylor Power Station",
	["PBLUFF"] = "Pacific Bluffs",
	["PBOX"] = "Pillbox Hill",
	["PROCOB"] = "Procopio Beach",
	["RANCHO"] = "Rancho",
	["RGLEN"] = "Richman Glen",
	["RICHM"] = "Richman",
	["ROCKF"] = "Rockford Hills",
	["RTRAK"] = "Redwood Lights Track",
	["SANAND"] = "San Andreas",
	["SANCHIA"] = "San Chianski Mountain Range",
	["SANDY"] = "Sandy Shores",
	["SKID"] = "Mission Row",
	["SLAB"] = "Stab City",
	["STAD"] = "Maze Bank Arena",
	["STRAW"] = "Strawberry",
	["TATAMO"] = "Tataviam Mountains",
	["TERMINA"] = "Terminal",
	["TEXTI"] = "Textile City",
	["TONGVAH"] = "Tongva Hills",
	["TONGVAV"] = "Tongva Valley",
	["VCANA"] = "Vespucci Canals",
	["VESP"] = "Vespucci",
	["VINE"] = "Vinewood",
	["WINDF"] = "Ron Alternates Wind Farm",
	["WVINE"] = "West Vinewood",
	["ZANCUDO"] = "Zancudo River",
	["ZP_ORT"] = "Port of South Los Santos",
	["ZQ_UAR"] = "Davis Quartz"
}

local directions = {[0] = "N", [45] = "NW", [90] = "W", [135] = "SW", [180] = "S", [225] = "SE", [270] = "E", [315] = "NE", [360] = "N"}
local isShowUI = false

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if isShowUI then
				local pos = GetEntityCoords(GetPlayerPed(-1))

				for k, v in pairs(directions) do
					direction = GetEntityHeading(GetPlayerPed())
					if (math.abs(direction - k) < 22.5) then
						direction = v
						break
					end
				end

				local t = 0
				for _, player in ipairs(GetActivePlayers()) do
					local ped = GetPlayerPed(player)
					if NetworkIsPlayerTalking(player) then
						t = t + 1
						if (t == 1) then
							drawTxt(0.510, 0.85, 1.0, 1.0, 0.3, "~h~~b~말하는 중", 255, 255, 255, 255)
						end
						drawTxt(0.510, 0.85 + (t * 0.023), 1.0, 1.0, 0.3, "" .. GetPlayerName(player), 255, 255, 255, 255)
					end
				end
			end
		end
	end
)

RegisterNetEvent("gameui:changeShowUI")
AddEventHandler(
    "gameui:changeShowUI",
    function(isShow)
        isShowUI = isShow
    end
)