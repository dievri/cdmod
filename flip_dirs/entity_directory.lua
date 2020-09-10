-- register directory entity blueprint
minetest.register_entity("cdmod:directory", {
    initial_properties = {
        physical = true,
        pointable = true,
        visual = "sprite",
        collide_with_objects = true,
        textures = {"cdmod_folder.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true,
        makes_footstep_sound = false,
        nametag_color = "black",
        infotext = "",
        static_save = true,
        shaded = true
    },
    -- path of the folder, set at time of adding
    path = "",
    size = 0,
    -- when hit with appropriate tool, create new platform for this directory
    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities,
                        dir)
        if tool_capabilities.damage_groups.enter == 1 then
            local pos = puncher:get_pos()
            -- find glass in radius of 6
            local node_pos = minetest.find_node_near(pos, 6, {"cdmod:platform"})
            local node = minetest.get_meta(
                             {x = node_pos.x, y = node_pos.y, z = node_pos.z})
            local corner = node:get_string("corner")
            local corner_pos = minetest.deserialize(corner)
            local corner_node = minetest.get_meta(
                                    {
                    x = corner_pos.x,
                    y = corner_pos.y,
                    z = corner_pos.z
                })
            local host_info_string = corner_node:get_string("host")
            local host_info = minetest.deserialize(host_info_string)

            -- connect TODO
            local tcp = socket:tcp()
            local connection, err = tcp:connect(host_info["host"],
                                                host_info["port"])
            if (err ~= nil) then
                print("dump of error newest .. " .. dump(err))
                error("Connection error")
            end
            local conn = np.attach(tcp, "dievri", "")
            local content = read_directory(conn, self.path)
            tcp:close()
            local size = 1
            if content ~= nil then size = table.getn(content) end

            local level = node_pos.y
            local platform_size = math.ceil(math.sqrt((size / 80) * 100))
            if platform_size < 3 then platform_size = 3 end

            local posx = math.random(0, 12)
            local posz = math.random(0, 12)
            local new_level = level + 15
            local result = create_platform(posx, new_level, posz, platform_size,
                                           "h", content, host_info)

            puncher:set_pos({
                x = result.x + 1,
                y = result.y + 1,
                z = result.z + 1
            })

        end
    end
})

