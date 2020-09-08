-- register directory entity blueprint
minetest.register_entity("cdmod:directory", {
	initial_properties = {
        physical = true, pointable = true, visual = "sprite", collide_with_objects = true,
        textures = {"cdmod_folder.png"}, spritediv = {x = 1, y = 1}, initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true, makes_footstep_sound = false, nametag_color = "black",
        infotext = "", static_save = true, shaded = true,
    },
    -- path of the folder, set at time of adding
    path = "",
    size = 0,
    -- when hit with appropriate tool, create new platform for this directory
    on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
        if tool_capabilities.damage_groups.enter == 1 then
            local content = read_directory(self.path)
            local size = table.getn(content)
            local level = get_level(puncher)
            local platform_size = math.floor(math.sqrt(size) + size*0.1)
            local posx = math.random(0, 12)
            local posz = math.random(0, 12)
            local result = create_platform(posx, level + 15, posz, platform_size, "h", nil)
            local node = minetest.get_meta({x = result.x; y = result.y; z = result.z})
            puncher:set_pos({x = result.x + 1, y = result.y + 1, z = result.z + 1})
            node:set_string("content", minetest.serialize(content))
            local free_slots = node:get_string("empty")
            local free = minetest.deserialize(free_slots)
            full_slots = {}
            for n, file in pairs(content) do
                local k, v = next(free)
                local entity = nil
                if file.type == 128 then 
                    entity = minetest.add_entity({x = v.x,  
                    y = math.random(result.y + 3, result.y + 11), 
                    z = v.y}, "cdmod:directory")
                    table.insert(full_slots, {x = v.x, y = v.y})
                else
                    entity = minetest.add_entity({x = v.x,  
                    y = math.random(result.y + 3, result.y + 11), 
                    z = v.y}, "cdmod:file")
                    table.insert(full_slots, {x = v.x, y = v.y})
                end
                entity:set_nametag_attributes({color = "black", text = file.name})
                    entity:set_armor_groups({immortal=0})
                    entity:set_acceleration({x = 0, y = -6, z = 0})
                    entity:get_luaentity().path = file.path
                    table.remove(free, k)
            end
            local free_slots = minetest.serialize(free_slots)
            local full = minetest.serialize(full_slots)
            node:set_string("empty", free_slots)
            node:set_string("full", full)

            

        end
        
		-- local level = get_level(puncher)
		-- if tool_capabilities.damage_groups.enter == 1 then 
        --     local path = self.path
        --     print ("path before couneting elements")
        --     local elements = get_number_of_elements(path)
        --     puncher:set_pos({x = 0, y = level + 17, z =  0})
        --     self.size = elements
        --     local square = math.sqrt(elements)
        --     if square > 24 then square = square * 1.5 else square = square * 2 end
        --     platform_side = math.floor(square)
        --     create_platform(level + 15, platform_side)
        --     print(platform_side)
        --     print("create_platform finished")
            
        --     list_directory(level + 15, path, platform_side)
        --     print("list_directory finished")
		-- end
    end,
    -- make directory fall in air
	-- on_activate = function(self, staticdata, dtime_s) 
	-- 	-- self.object:set_acceleration({x = 0, y = -8, z = 0})
	-- end
})

