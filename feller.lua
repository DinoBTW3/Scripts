local MIN_FUEL_LEVEL = 80

function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        if data.name and string.find(data.name, "log") then
            return true
        end
    end
    
    return false
end

-- Function to check if the turtle has coal or charcoal
function hasFuel()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item then
            if item.name == "minecraft:coal" or item.name == "minecraft:charcoal" then
                return true
            end
        end
    end
    return false
end

function refuel()
    local level = turtle.getFuelLevel()

    -- If fuel level is below the minimum, and the turtle has coal or charcoal, refuel
    if level == "unlimited" then
        error("Turtle does not need fuel", 0)
    elseif level < MIN_FUEL_LEVEL then
        print("Fuel level is low, checking for coal or charcoal...")

        -- Check if the turtle has coal or charcoal
        if hasFuel() then
            local ok, err = turtle.refuel(1)
            if ok then
                local new_level = turtle.getFuelLevel()
                print(("Refueled %d, current level is %d"):format(new_level - level, new_level))
            else
                printError(err)
            end
        else
            print("No coal or charcoal found in inventory!")
        end
    else
        print(("Current fuel level is %d, no need to refuel."):format(level))
    end
end

function findSapling()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and string.find(item.name, "sapling") then
            return slot
        end
    end
    return nil
end

-- Function to make the turtle face south
function faceSouth()
    turtle.turnLeft()
end

print("Starting...")

while blockInfrontIsLog() do
    refuel()
    turtle.dig() -- Dig forward
    turtle.up()
    sleep(1) -- Sleep for 1 second
    turtle.digUp()
end

-- Move down until reaching the ground
while not turtle.detectDown() do
    turtle.down()
end

print("Finished.")

-- Check for saplings and place one in front
local saplingSlot = findSapling()
if saplingSlot then
    turtle.select(saplingSlot)
    if turtle.place() then
        print("Sapling planted.")
    else
        print("Failed to plant sapling.")
    end
else
    print("No saplings found in inventory.")
end

-- Make the turtle face south
faceSouth()

-- You can also perform additional operations if needed after this point
