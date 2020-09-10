-- register flip platform tool
minetest.register_tool("cdmod:flip", {
	desription = "Flip platform",
	inventory_image = "cdmod_flip.png",
	wield_image = "cdmod_flip.png",
	tool_capabilities = {
		punch_attack_uses = 0,
		damage_groups = {flip = 1}
	}
})


-- -- register create file tool 
-- minetest.register_tool("cdmod:create", {
-- 	desription = "Create file",
-- 	inventory_image = "cdmod_create.png",
-- 	wield_image = "cdmod_create.png",
-- 	tool_capabilities = {
-- 		punch_attack_uses = 0
-- 	},
-- 	on_use = function(itemstack, player, pointed_thing) 
-- 		local level = get_level(player)
-- 		local player_name = player:get_player_name()
		
-- 		local meta = minetest.get_meta({x = 0, y = level, z = 0})
-- 		local path = meta:get_string("path")
-- 		local formspec = {
--                  "formspec_version[3]",
--                  "size[10,3,false]",
-- 				 "field[0,0;0,0;path;;", path, "]",
-- 				 "field[0,0;0,0;level;;", level, "]",
-- 				 "field[0.5,0.5;9,1;filename;Enter file name;]",
-- 				 "button_exit[7,1.8;2.5,0.9;create;create file]"
--              }
--              local form = table.concat(formspec, "")
--               minetest.show_formspec(player_name, "cdmod:create_file", form)

-- 	end

-- })

-- register enter key 
minetest.register_tool("cdmod:enter", {
	desription = "Enter key",
	inventory_image = "cdmod_enter.png",
	wield_image = "cdmod_enter.png",
	tool_capabilities = {
		punch_attack_uses = 0,
		damage_groups = {enter = 1}
	}
})

-- -- register read file tool
minetest.register_tool("cdmod:read", {
 	desription = "Read file",
 	inventory_image = "cdmod_read.png",
 	wield_image = "cdmod_read.png",
 	tool_capabilities = {
 		punch_attack_uses = 0,
 		damage_groups = {read = 1}
	 }, 
	 
	on_use = function(itemstack, player, pointed_thing)
		
	
	end
 })



-- register enter key 
minetest.register_tool("cdmod:connect", {
	desription = "Connect to inferno",
	inventory_image = "cdmod_connect.png",
	wield_image = "cdmod_connect.png",
	tool_capabilities = {
		punch_attack_uses = 0,
		damage_groups = {connect = 1}
	},

	on_use = function(itemstack, player, pointed_thing) 
				local player_name = player:get_player_name()
	
				local formspec = {
		                 "formspec_version[3]",
		                 "size[10,3,false]",
						 "field[0.5,0.5;9,1;conn_string;Enter connection string;]",
						 "button_exit[7,1.8;2.5,0.9;connect;connect]"
		             }
		             local form = table.concat(formspec, "")
		              minetest.show_formspec(player_name, "cdmod:connect", form)
		
			end
})