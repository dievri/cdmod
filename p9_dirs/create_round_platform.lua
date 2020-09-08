create_round_horizontal_platform = function(x, y, z, radius) 
    for firts = -radius, radius do
        for second = -radius, radius do
            if (firts*firts) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                minetest.set_node({x = x + firts, y = y, z = z + second}, {name="default:dirt"})
            end
        end
    end
end

create_round_vertical_platform = function(x, y, z, radius) 
    for firts = -radius, radius do
        for second = -radius, radius do
            if (firts*firts) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                minetest.set_node({x = x + firts, y = y + second, z = z}, {name="default:dirt"})
            end
        end
    end
end