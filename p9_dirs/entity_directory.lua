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
		local level = get_level(puncher)
		if tool_capabilities.damage_groups.enter == 1 then 
            local path = self.path
            print ("path before couneting elements")
            local elements = get_number_of_elements(path)
            puncher:set_pos({x = 0, y = level + 17, z =  0})
            self.size = elements
            local square = math.sqrt(elements)
            if square > 24 then square = square * 1.5 else square = square * 2 end
            platform_side = math.floor(square)
            create_platform(level + 15, platform_side)
            print(platform_side)
            print("create_platform finished")
            
            list_directory(level + 15, path, platform_side)
            print("list_directory finished")
		end
    end,
    -- make directory fall in air
	on_activate = function(self, staticdata, dtime_s) 
		self.object:set_acceleration({x = 0, y = -3, z = 0})
	end
})

