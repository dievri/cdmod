minetest.register_on_joinplayer(function(player)
	player:set_pos({x = 10, y = 2, z = 0})
	create_platform(nil, 0, 20)

	-- put root directory 
	local root = minetest.add_entity({x = 10, y = 2, z = 10}, "cdmod:directory")
	root:set_nametag_attributes({text = "/"})
	root:set_armor_groups({immortal = 0})
	root:get_luaentity().path = "/"

	-- add basic tools to inventory
	local inventory = player.get_inventory(player)	
    inventory:add_item("main", "cdmod:read")	
	inventory:add_item("main", "cdmod:enter")
	inventory:add_item("main", "cdmod:create")
end)