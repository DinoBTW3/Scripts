function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        for k, v in pairs(data) do
            if v[1] == "minecraft:log" then
                return true
            else
                return false
            end
        end
    end
end

print(blockInfrontIsLog())