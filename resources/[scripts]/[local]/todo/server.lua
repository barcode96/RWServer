local IsTornadoActive = false
local TornadoPosition = nil
local TornadoDestination = nil
local TornadoGirth = 8.0
local PossiblePositions = {
    {x = 185.34, y = -918.41, z = 30.88},
    {x = 185.34, y = -918.41, z = 30.88}
    --{x = -3039.9089355469, y = 341.40008544922, z = 13.486105918884},
    --{x = -2102.1958007813, y = 2530.8842773438, z = 3.0150742530823},
    --{x = 85.679382324219, y = 7032.0244140625, z = 12.286052703857},
    --{x = 1954.2747802734, y = 5191.5024414063, z = 48.200130462646},
    --{x = 3705.4135742188, y = 4651.7333984375, z = 11.050972938538}
}

AddEventHandler(
    "gd_tornado:summon",
    function()
        local start = math.random(#PossiblePositions)
        local destination = math.random(#PossiblePositions - 1)
        if start == destination then
            destination = #PossiblePositions
        end
        start = PossiblePositions[start]
        destination = PossiblePositions[destination]
        TornadoPosition = start
        TornadoDestination = destination
        IsTornadoActive = true
        TriggerClientEvent("gd_tornado:spawn", -1, start, destination)
        print("[Tornado] A tornado has spawned at " .. start.x .. ", " .. start.y .. ", " .. start.z)
    end
)

AddEventHandler(
    "gd_tornado:move_here",
    function(x, y, z)
        x, y, z = tonumber(x), tonumber(y), tonumber(z)
        if x ~= nil and y ~= nil and z ~= nil then
            TornadoDestination = {x = x, y = y, z = z}
            if not IsTornadoActive then
                TornadoPosition = PossiblePositions[math.random(#PossiblePositions)]
                print("[Tornado] A tornado has spawned at " .. TornadoPosition.x .. ", " .. TornadoPosition.y .. ", " .. TornadoPosition.z)
            end
            IsTornadoActive = true
            TriggerClientEvent("gd_tornado:spawn", -1, TornadoPosition, TornadoDestination)
            print("[Tornado] A tornado is moving to " .. x .. ", " .. y .. ", " .. z)
        end
    end
)

AddEventHandler(
    "gd_tornado:summon_right_here",
    function(x, y, z)
        x, y, z = tonumber(x), tonumber(y), tonumber(z)
        if x ~= nil and y ~= nil and z ~= nil then
            TornadoPosition = {x = x, y = y, z = z}
            if not IsTornadoActive then
                TornadoDestination = PossiblePositions[math.random(#PossiblePositions)]
            end
            IsTornadoActive = true
            TriggerClientEvent("gd_tornado:spawn", -1, TornadoPosition, TornadoDestination)
            print("[Tornado] A tornado has spawned at " .. x .. ", " .. y .. ", " .. z)
        end
    end
)

AddEventHandler(
    "gd_tornado:dismiss",
    function()
        IsTornadoActive = false
        TriggerClientEvent("gd_tornado:delete", -1)
    end
)

RegisterCommand(
    "tornado_summon",
    function()
        TriggerEvent("gd_tornado:summon")
    end,
    true
)

RegisterCommand(
    "tornado_dismiss",
    function()
        TriggerEvent("gd_tornado:dismiss")
    end,
    true
)
