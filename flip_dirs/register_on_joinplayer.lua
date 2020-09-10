minetest.register_on_joinplayer(function(player)
    player:set_pos({x = 0, y = 2, z = 0})
    -- place directory
    

local root = minetest.add_entity({x = 3, y = 7, z = 3}, "cdmod:directory")
    root:set_nametag_attributes({text = "./"})
    root:set_armor_groups({immortal = 0})
    root:get_luaentity().path = "."
    root:set_acceleration({x = 0, y = -6, z = 0})




      -- add basic tools to inventory
	local inventory = player.get_inventory(player)	
    inventory:add_item("main", "cdmod:flip")
    --inventory:add_item("main", "cdmod:read")	
	inventory:add_item("main", "cdmod:enter")
    inventory:add_item("main", "cdmod:connect")
end)


 minetest.register_on_generated(function(minp, maxp, blockseed)
      if minp.x < 0 and minp.y < 0 and minp.z < 0 then
--     --     and 10 < maxp.x and 10 < maxp.y and 10 < maxp.z then
--     --         create_hcircle(5, 1, 5, 5)    
--     --         local node = minetest.get_meta({x = 5,y = 1, z = 5})
--     --         local free_slots_string = node:get_string("empty")
--     --         local free_slots = minetest.deserialize(free_slots_string)
--     --         local k, v = next(free_slots)
--     --         print(dump(v))
--     --         local root = minetest.add_entity({x = v.x, y = 10, z = v.y}, "cdmod:directory")
--     --         root:set_nametag_attributes({text = "./"})
--     --         root:set_armor_groups({immortal = 0})
--     --         root:get_luaentity().path = "."
--     --         root:get_luaentity().size = 10    
--     -- end
--         create_platform(0, 0, 0, 10, "h")
--      end
    local host_info = {type = "tcp", host = "instance1", port = 32000}
    create_platform(0, 0, 0, 7, "h", nil, host_info)

      end
 end)
