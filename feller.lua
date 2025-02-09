local has_block, data = turtle.inspect()
if has_block then
    repeat
        turtle.refuel()
        turtle.dig(south)
        turtle.digUp()
        turtle.dance()
        turtle.up(1)
    until data == false
end
