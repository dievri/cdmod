-- register directory entity blueprint
minetest.register_entity("cdmod:directory", {
	initial_properties = {
        physical = true, pointable = true, visual = "sprite", textures = {"cdmod_folder.png"},
        spritediv = {x = 1, y = 1}, initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true, makes_footstep_sound = false, nametag_color = "black",
        infotext = "", static_save = true, shaded = true,
    },
    -- path of the folder, set at time of adding
	path = "",
    -- when hit with appropriate tool, create new platform for this directory
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		local level = get_level(puncher)
		if tool_capabilities.damage_groups.enter == 1 then 
			puncher:set_pos({x = 10, y = level + 16, z =  0})
			create_platform(self, level, 20)			
		end
    end,
    -- make directory fall in air
	on_activate = function(self, staticdata, dtime_s) 
		self.object:set_acceleration({x = 0, y = -7, z = 0})
	end
})

