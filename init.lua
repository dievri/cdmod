minetest.register_on_joinplayer(function(player)
	player:set_pos({x = 10, y = 2, z = 0})
	local rootdirectory = minetest.add_entity({x = 10, y = 2, z = 10}, "cdmod:directory")
	rootdirectory:set_nametag_attributes({text = "/"})
	rootdirectory:set_armor_groups({immortal = 0})
	local inventory = player.get_inventory(player)	
	
	--inventory:add_item("main", "cdmod:enter")
end)


-- register enter key 
minetest.register_tool("cdmod:enter", {
	desription = "Enter key",
	inventory_image = "cdmod_enter.png",
	wield_image = "cdmod_enter.png",
	tool_capabilities = {
		punch_attack_uses = 0,
		damage_groups = {enter = 1}
	}

})

create_platform = function(parent_y) 
    local glass= minetest.get_content_id("default:glass")
	p1 = {x = 0, y = parent_y + 13, z = 0}
	p2 = {x = 20, y = parent_y + 13, z = 20}
	
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(p1, p2)
    local a = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	
	for z = p1.z, p2.z do
		for y = p1.y, p2.y do
			for x = p1.x, p2.x do
				local vi = a:index(x, y, z)
				data[vi] = glass
			end
		end
	end
    vm:set_data(data)
    vm:write_to_map(true)
end


-- register directory entity blueprint
minetest.register_entity("cdmod:directory", {
	initial_properties = 
	 {
        physical = false,
        pointable = true,
        visual = "sprite",
        textures = {"cdmod_folder.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true,
        makes_footstep_sound = false,
        nametag_color = "black",
        infotext = "",
        static_save = true,
        shaded = true,
    },

	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		local parent_y = self.object:get_pos().y
		print(parent_y)
		if tool_capabilities.damage_groups.enter == 1
			then print('creating new platform')
			puncher:set_pos({x = 10, y = parent_y + 15, z =  0})
			create_platform(parent_y)			
			end
	end
})


-- create initial platform
minetest.register_on_generated(function(minp, maxp,  blockseed)
local start_pos = {x=0, y=0, z=0} -- starting position of platform
    if (minp.x <= start_pos.x and start_pos.x <= maxp.x
        and minp.y <= start_pos.y and start_pos.y <= maxp.y
        and minp.z <= start_pos.z and start_pos.z <= maxp.z)
    then
        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        local data = vm:get_data()
        local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}

    -- iterave over starting and ending positions of platform
    for i in area:iter(0, 0, 0,
              20, 0, 20) do
        -- set node
        local c_glass= minetest.get_content_id("default:glass")
        data[i] = c_glass
    end

    -- save data to map
    vm:set_data(data)
    vm:write_to_map()
    end
end)

