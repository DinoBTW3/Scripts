local has_block, data = turtle.inspect()

if has_block then
    repeat
        turtle.refuel()
        print(has_block)
        print(data)
        turtle.dig(south)
    until data == false
end
