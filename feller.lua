local MIN_FUEL_LEVEL = 80

-- Check if the block in front is a log.
function blockInfrontIsLog()
    local has_block, data = turtle.inspect()
    if has_block and data.name and string.find(data.name, "log") then
        return true
    end
    return false
end

function blockInfrontIsAir()
    local has_block, data = turtle.inspect()
    return has_block
end

-- Check if the turtle has coal or charcoal.
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

-- Refuel if the fuel level is below the threshold.
function refuel()
    local level = turtle.getFuelLevel()
    if level == "unlimited" then
        print("Turtle has unlimited fuel.")
        return
    end

    if level < MIN_FUEL_LEVEL then
        print("Fuel level is low, refueling...")
        if hasFuel() then
            for slot = 1, 16 do                         -- Turtle has 16 slots
                local item = turtle.getItemDetail(slot) -- Get item details in the slot
                if item and item.name == "minecraft:coal" or item.name == "minecraft:charcoal" then
                    turtle.select(slot)                 -- Select the slot with coal
                    if turtle.refuel(1) then            -- Refuel using 1 coal item
                        print("Refueled using coal from slot " .. slot)
                        return true
                    end
                end
            end
            print("No coal found in inventory!")
        else
            print("No coal or charcoal found in inventory!")
        end
    else
        print("Fuel level is sufficient: " .. level)
    end
end

-- Move down until the turtle detects the ground.
function moveDownToGround()
    while not turtle.detectDown() do
        turtle.down()
    end

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
end

-- Find a sapling in the inventory.
function findSapling()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and string.find(item.name, "sapling") then
            return slot
        end
    end
    return nil
end

-- Since the turtle always starts facing south,
-- turning right will make it face west.
-- (Later, turning left from west returns it to south.)
function faceRight()
    turtle.turnRight()
end

-- Ensure the turtle faces south.
function faceSouth()
    -- If the turtle is not facing south, this routine should be
    -- adjusted as needed. Here we assume that after our rightward movement,
    -- a left turn makes it face south.
    turtle.turnLeft()
end

print("Starting...")

while true do
    MOVED_STEPS = 0    

    while true do
        refuel()
        -- DIG PHASE: Dig upward as long as a log is in front (facing south).
        while blockInfrontIsLog() do            
            print("Log detected! Digging up...")
            turtle.digUp()
            sleep(0.5)
            turtle.dig() -- Dig the block in front.
            turtle.up() -- Move up.
            turtle.digUp()
            sleep(0.5)
        end

        moveDownToGround()

        -- Now check the right side for a block (we do this *after* digging).
        -- To check the block on its right, the turtle turns right, inspects,
        -- then turns back to face south.
        turtle.turnRight()                 -- Now facing west.
        local rightBlock = blockInfrontIsAir() -- Check block in front (i.e. right side).
        turtle.turnLeft()                  -- Return to facing south.

        if rightBlock then
            -- A block is detected on the right.
            print("Block detected on the right. Moving right 5 blocks and performing side dig...")
            -- Turn right, move 5 blocks, then turn left so the turtle faces south again.
            turtle.turnRight() -- Face west.
            for i = 1, 5 do
                if not turtle.forward() then
                    print("Failed to move forward while moving right.")
                    break
                end
            end
            turtle.turnLeft() -- Now facing south again.

            -- Perform the dig phase on this new side.
            while blockInfrontIsLog() do                
                print("Log detected! Digging up...")
                turtle.digUp()
                sleep(0.5)
                turtle.dig() -- Dig the block in front.
                turtle.up() -- Move up.
                turtle.digUp()
                sleep(0.5)
            end
            moveDownToGround()

            print("Finished side dig. Exiting code.")
            break
        else
            print("No block on the right; moving right 5 blocks and continuing...")
            turtle.turnRight() -- Face west.
            for i = 1, 5 do
                if not turtle.forward() then
                    print("Failed to move forward while moving right.")
                    break
                end
            end
            turtle.turnLeft() -- Face south again.
            MOVED_STEPS = MOVED_STEPS + 1
        end
    end

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

    print("Finished.")

    turtle.turnLeft()
    for i = 1, MOVED_STEPS * 5 do
        turtle.forward()
    end
    turtle.turnRight()
end
