function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        if data.name and string.find(data.name, "log") then
            return true
        end
    end
    
    return false
end

function refuel()
    local level = turtle.getFuelLevel()
    if level == "unlimited" then error("Turtle does not need fuel", 0) end
    
    local ok, err = turtle.refuel()
    if ok then
        local new_level = turtle.getFuelLevel()
        print(("Refueled %d, current level is %d"):format(new_level - level, new_level))
    else
        printError(err)
    end
end 

print(blockInfrontIsLog())

while blockInfrontIsLog() do
    --refuel()
    turtle.dig() -- Dig forward
    turtle.up()
    sleep(1) -- Sleep for 1 second
    turtle.digUp()
end

-- When no more logs are in front, move down until the turtle reaches the ground
while not turtle.detectDown() do
    turtle.down()
end
