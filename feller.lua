function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        for key, value in pairs(data) do
            if key == "name" then
                if string.find(tostring(value), "log") then
                    return true
                end
            end
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
      print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
    else
      printError(err)
    end
end 

print(blockInfrontIsLog())

while blockInfrontIsLog do
    refuel()
    turtle.dig(south)
    turtle.up()
    turtle.sleep(1)
    turtle.digUp()
end