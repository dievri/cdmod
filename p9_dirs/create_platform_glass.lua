-- create platform for a given directory based on provided position 
create_platform_glass = function(level, size)
    -- check if parent directory is provided
	print("create platform glass is started with size " .. size .. " and level " .. level )
    -- define edges of platform
	local min = {x = 0, y = level, z = 0}
    local max = {x = size, y = level, z = size}
    local parent_platform = minetest.add_entity(min, "cdmod:platform")
    -- populate platform with glass nodes
    for second = min.z, max.z do
        for first = min.x, max.x do
                local child = minetest.add_entity({x = first, y = level, z = second}, "cdmod:platform")
                child:set_attach(parent_platform, "", {x = first * 10, y = 0,  z = second * 10}, {x = 0, y = 0, z = 0})
        end
    end

    local free_slots = generate_free_slots(size)
    -- write path value to the corner node
    local node = minetest.get_meta({x = 0; y = level; z = 0})
    local free_slots_string = minetest.serialize(free_slots)
    node:set_string("free_slots", free_slots_string)
end