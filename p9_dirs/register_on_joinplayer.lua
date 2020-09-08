minetest.register_on_joinplayer(function(player)
    player:set_pos({x = -3, y = 9, z = 0})
    local level = 0

    local root_path = "./"
    local size = get_number_of_elements(root_path)
    create_platform_glass(level, size)
    local node = minetest.get_meta({x = 0,y = level, z = 0})
    local free_slots_string = node:get_string("free_slots")
    local free_slots = minetest.deserialize(free_slots_string)
    local x, z = get_value(free_slots, size)

    local root = minetest.add_entity({x = 0, y = 20, z = 0}, "cdmod:directory")
    root:set_nametag_attributes({text = root_path})
	root:set_armor_groups({immortal = 0})
	root:get_luaentity().path = "."
    root:get_luaentity().size = size


	-- add basic tools to inventory
	local inventory = player.get_inventory(player)	
    inventory:add_item("main", "cdmod:read")	
	inventory:add_item("main", "cdmod:enter")
    inventory:add_item("main", "cdmod:create")
    inventory:add_item("main", "cdmod:flip")
   
end)