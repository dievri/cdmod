
create_relative_platform = function(x, y, z, radius) 
    local parent_platform = minetest.add_entity({x = x, y = y, z = z}, "cdmod:platform")
    for first = -radius, radius do
        for second = -radius, radius do
            if (first*first) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                -- minetest.set_node({x = x + second, y = y, z = z + second}, {name="default:dirt"})
                local posx = x + first
                local posz = z + second
                local child = minetest.add_entity({x = x + first, y = y, z = z + second}, "cdmod:platform")
                child:set_attach(parent_platform, "", {x = first * 10, y = 0,  z = second * 10}, {x = 0, y = 0, z = 0})
            end
        end
    end
end