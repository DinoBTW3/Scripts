function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        for key, value in pairs(data) do
            print(key .. ": " .. tostring(value))
        end
    end
end

blockInfrontIsLog()
