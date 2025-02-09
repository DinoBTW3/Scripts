local has_block, data = turtle.inspect()
if has_block then
    repeat
        turtle.dig(south)
        turtle.digUp()
        has_block, data = turtle.inspect()  -- Re-check the block after each operation
    until data == false
    turtle.up(1)
end
--cowabunga