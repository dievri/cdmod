create_hcircle = function(x, y, z, radius) 
    local origin = {
        x = x,
        y = y,
        z = z,
        r = radius,
        o = "h"
    }
    local empty_nodes = {}
    local origin = minetest.serialize(origin)
    for first = -radius, radius do
        for second = -radius, radius do
            if (first*first) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                minetest.set_node({x = x + first, y = y, z = z + second}, {name="cdmod:platform"})
                table.insert(empty_nodes, {x = first, y = second}) 
                local node = minetest.get_meta({x = x + first; y = y; z = z + second})
                node:set_string("origin", origin)
            end
        end
    end
    shuffled = {}
    for i, v in ipairs(empty_nodes) do
        local pos = math.random(1, #shuffled+1)
        table.insert(shuffled, pos, v)
        end

    local empty = minetest.serialize(shuffled)
    local node = minetest.get_meta({x = x; y = y; z = z})
                node:set_string("empty", empty)
end

delete_hcircle = function(x, y, z, radius) 
    for first = -radius, radius do
        for second = -radius, radius do
            if (first*first) + (second*second) <= ((radius * radius) + (radius * 1.2)) 
            then
                minetest.set_node({x = x + first, y = y + 0, z = z + second}, {name="air"})
                local node = minetest.get_meta({x = x + first; y = y + 0; z = z + second})
                node:set_string("origin", nil)
            end
        end
    end
    create_vcircle(x, y, z, radius)
end


delete_vcircle = function(x, y, z, radius) 
    for first = -radius, radius do
        for second = -radius, radius do
            if (first*first) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                minetest.set_node({x = x + first, y = y + second, z = z + 0}, {name="air"})
                local node = minetest.get_meta({x = x + first; y = y + second; z = z + 0})
                node:set_string("origin", nil)
            end
        end
    end
   
    print("FLIPPING")
    create_hcircle(x, y, z, radius)
end


create_vcircle = function(x, y, z, radius) 
    local origin = {
        x = x,
        y = y,
        z = z,
        r = radius,
        o = "v"
    }
    local empty_nodes = {}
    local origin = minetest.serialize(origin)
    for first = -radius, radius do
        for second = -radius, radius do
            if (first*first) + (second*second) <= ((radius * radius) + (radius * 1.2)) then
                minetest.set_node({x = x + first, y = y + second, z = z}, {name="cdmod:platform"})
                local node = minetest.get_meta({x = x + first, y = y + second, z = z})
                table.insert(empty_nodes, {x = first, y = second}) 
                node:set_string("origin", origin)
            end
        end
    end

    local empty = minetest.serialize(empty_nodes)
    local node = minetest.get_meta({x = x; y = y; z = z})
                node:set_string("origin", origin)
                node:set_string("empty", empty)


end