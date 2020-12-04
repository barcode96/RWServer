--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
--]]

checkTime = 60 --Minutes
deleteTime = 600 --Seconds

local enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function getVehicles()
  return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Citizen.CreateThread(function()
	while true do
		Wait(checkTime * 10800)
		TriggerEvent("chatMessage", "🚨 차량삭제 알림", {255, 255, 0}, "3시간 마다 진행되는 운전석에 사람이 없는 차량이 약 3분 후 모두삭제 됩니다!")
		SetTimeout(deleteTime * 10980, function()
			theVehicles = getVehicles()
			TriggerEvent("chatMessage", "🚨 차량삭제 알림", {0, 255, 0}, "시간이 지나 차량이 모두 삭제 되었습니다!")
			for veh in theVehicles do
				if ( DoesEntityExist( veh ) ) then 
					if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
						Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( veh ) )
					end
				end
			end
		end)
	end
end)