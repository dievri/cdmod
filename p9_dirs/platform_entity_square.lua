-- register directory entity blueprint
minetest.register_entity("cdmod:platform_glass", {
	initial_properties = {
        physical = true, 
        pointable = true, 
        visual = "cube", 
        textures = {"default_glass.png", 
                    "default_glass.png",
                    "default_glass.png", 
                    "default_glass.png",
                    "default_glass.png",
                    "default_glass.png" },
        spritediv = {x = 1, y = 1}, 
        initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true, makes_footstep_sound = false, nametag_color = "black",
        infotext = "", static_save = true, shaded = true,
    },
    -- path of the folder, set at time of adding
    -- when hit with appropriate tool, create new platform for this directory
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
        if tool_capabilities.damage_groups.flip == 1 then
            local parent = nil 
            if self.object:get_attach() ~= nil then 
                parent = self.object:get_attach()
            else parent = self.object
            end
            rotation = parent:get_rotation()
            parent:set_rotation({x = rotation.x + math.rad(90), y = 0, z = 0})
            
		end
    end,
    -- make directory fall in air
	--on_activate = function(self, staticdata, dtime_s) 
	--	self.object:set_acceleration({x = 0, y = -7, z = 0})
	--end
})

