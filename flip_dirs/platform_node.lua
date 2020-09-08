minetest.register_node("cdmod:platform", {
        drawtype = "glasslike",  -- See "Node drawtypes"

        visual_scale = 1.0,
        -- Supported for drawtypes "plantlike", "signlike", "torchlike",
        -- "firelike", "mesh", "nodebox", "allfaces".
        -- For plantlike and firelike, the image will start at the bottom of the
        -- node. For torchlike, the image will start at the surface to which the
        -- node "attaches". For the other drawtypes the image will be centered
        -- on the node.

        tiles = {"default_glass.png", "default_glass.png", "default_glass.png", "default_glass.png",
        "default_glass.png","default_glass.png"},
        -- Textures of node; +Y, -Y, +X, -X, +Z, -Z
        -- Old field name was 'tile_images'.
        -- List can be shortened to needed length.     

        use_texture_alpha = false,
        -- Use texture's alpha channel
        -- If this is set to false, the node will be rendered fully opaque
        -- regardless of any texture transparency.

        sunlight_propagates = false,
        -- If true, sunlight will go infinitely through this node
        walkable = true,  -- If true, objects collide with node

        pointable = true,  -- If true, can be pointed at

        diggable = true,  -- If false, can never be dug

        node_box = {type="regular"},  -- See "Node boxes
        on_punch = function(pos, node, puncher, pointed_thing)
            -- local node_meta = minetest.get_meta(pos)
            -- local origin_string = node_meta:get_string("origin")
            -- local circle_origin = minetest.deserialize(origin_string)
            -- local origin_meta = minetest.get_meta({x = circle_origin.x, y = circle_origin.y, z = circle_origin.z})
            -- local empty_string = origin_meta:get_string("empty")
            -- print("empty_string: " ..  empty_string)
            -- print(dump(circle_origin))
            -- if circle_origin.o == "h" then
            --     delete_hcircle(circle_origin.x, circle_origin.y, circle_origin.z, circle_origin.r)
            -- else
            --     delete_vcircle(circle_origin.x, circle_origin.y, circle_origin.z, circle_origin.r)
            -- end
            local node_meta = minetest.get_meta(pos)
            local platform_type = nil
            if node_meta:get_string("corner") ~= nil then
                platform_type = "square"
            end
            if platform_type == "square" then
                local c = minetest.deserialize(node_meta:get_string("corner"))
                local corner_info = minetest.get_meta({x = c.x, y = c.y, z = c.z})
                local empty_string = corner_info:get_string("empty")
                print(dump(minetest.deserialize(empty_string)))
                delete_platform(c.x, c.y, c.z, c.s, c.o)
            end


        end
})

