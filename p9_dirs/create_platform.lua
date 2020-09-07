-- create platform for a given directory based on provided position 
create_platform = function(level, size)
    -- check if parent directory is provided
	print("create platform is started with size " .. size .. " and level " .. level )
    -- define edges of platform
	local min = {x = 0, y = level, z = 0}
	local max = {x = size, y = level, z = size}
    
    -- populate platform with glass nodes
    local glass = minetest.get_content_id("default:glass")
    local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(min, max)
    local a = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
    for i in a:iter(0, min.y, 0, size, max.y, size) do
        data[i] = glass
    end       
    -- write everything to map
    vm:set_data(data)
    vm:write_to_map(true)

    local free_slots = generate_free_slots(size)
    -- write path value to the corner node
    local node = minetest.get_meta({x = 0; y = level; z = 0})
    local free_slots_string = minetest.serialize(free_slots)
    node:set_string("free_slots", free_slots_string)
end