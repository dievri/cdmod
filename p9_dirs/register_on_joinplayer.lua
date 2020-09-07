minetest.register_on_joinplayer(function(player)
    player:set_pos({x = 10, y = 2, z = 0})
    local root_path = "./"
    local size = get_number_of_elements(root_path)
    create_platform(0, 10)
    local root = minetest.add_entity({x  = 5, y = 2, z = 5}, "cdmod:directory")
    root:set_nametag_attributes({text = root_path})
	root:set_armor_groups({immortal = 0})
	root:get_luaentity().path = "."
    root:get_luaentity().size = size
	-- add basic tools to inventory
	local inventory = player.get_inventory(player)	
    inventory:add_item("main", "cdmod:read")	
	inventory:add_item("main", "cdmod:enter")
	inventory:add_item("main", "cdmod:create")
end)