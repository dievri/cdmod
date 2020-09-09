-- create platform for a given directory based on provided position 
create_platform = function(self, current_level, size)
    -- set default values
    local next_level = 0
    local path = "/"
    -- check if parent directory is provided
    if self ~= nil then
        next_level = current_level + 15
        path = self.object:get_luaentity().path
    end
	 
    -- define edges of platform
	local min = {x = 0, y = next_level, z = 0}
	local max = {x = size, y = next_level, z = size}
    
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

    local free_slots = generate_grid(size)
    -- write path value to the corner node
    local node = minetest.get_meta({x = 0; y = next_level; z = 0})
    node:set_string("path", path)
    local free_slots_string = minetest.serialize(free_slots)
    node:set_string("free_slots", free_slots_string)
    
    -- if parent directory is present, list it
    if self ~= nil then
        list_directory(self, next_level, size)
    end
end