function blockInfront()
    local has_block, data = turtle.inspect()
    if has_block then
        print(textutils.serialise(data))
        return true
    else
        return false
    end 
end

blockInfront()