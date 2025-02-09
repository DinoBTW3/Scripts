function printTable(tbl, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        if type(value) == "table" then
            print(prefix .. key .. ":")
            printTable(value, indent + 1) -- Recursively print nested tables
        else
            print(prefix .. key .. ": " .. tostring(value))
        end
    end
end

function blockInfrontIsLog()
    local has_block, data = turtle.inspect()

    if has_block then
        printTable(data)
    end
end

blockInfrontIsLog()
