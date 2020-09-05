local lfs = require 'lfs'
dofile(minetest.get_modpath("cdmod") .. "/getvalue.lua")


minetest.register_on_joinplayer(function(player)
	player:set_pos({x = 10, y = 2, z = 0})
	local rootdirectory = minetest.add_entity({x = 10, y = 2, z = 10}, "cdmod:directory")
	rootdirectory:set_nametag_attributes({text = "foobar"})
	rootdirectory:set_armor_groups({immortal = 0})
	rootdirectory:get_luaentity().path = "/tmp/foobar"
	local inventory = player.get_inventory(player)	
	--inventory:add_item("main", "cdmod:read")	
	--inventory:add_item("main", "cdmod:enter")
	--inventory:add_item("main", "cdmod:create")
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "cdmod:create_file" then 
		if(fields["filename"] == nil) then return
		end
		print("Player "..player:get_player_name().." submitted fields "..dump(fields))
		local level = tonumber(fields["platform_level"])
		local fullpath = fields["path"] .. "/" .. fields["filename"]
		local file = io.open(fullpath, "w")
		file:close()
		local nodemeta = minetest.get_meta({x = 0,y = level, z = 0})
		local sl_grid = nodemeta:get_string("grid")
		local grid = minetest.deserialize(sl_grid)
		print(grid)
		local posx, posz = getvalue(grid, 19)	
	    local entity = minetest.add_entity({x = posx,  y = math.random(level + 2, level + 10), z = posz}, "cdmod:file")
               entity:set_nametag_attributes({color = "black", text = fields["filename"]})
               entity:set_armor_groups({immortal=0})
               entity:get_luaentity().path = fullpath


	end
end)

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

-- register read file tool
minetest.register_tool("cdmod:read", {
	desription = "Read file",
	inventory_image = "cdmod_read.png",
	wield_image = "cdmod_read.png",
	tool_capabilities = {
		punch_attack_uses = 0,
		damage_groups = {read = 1}
	}

})

-- register create file tool 
minetest.register_tool("cdmod:create", {
	desription = "Create file",
	inventory_image = "cdmod_create.png",
	wield_image = "cdmod_create.png",
	tool_capabilities = {
		punch_attack_uses = 0
	},
	on_use = function(itemstack, player, pointed_thing) 
		local pos = player:get_pos()
		local player_name = player:get_player_name()
		local nodenear = minetest.find_node_near(pos, 6, {"default:glass"})
		local platform_level = nodenear.y
		local meta = minetest.get_meta(nodenear)
		local path = meta:get_string("path")
		print(path)
		local formspec = {
                 "formspec_version[3]",
                 "size[10,3,false]",
				 "field[0,0;0,0;path;;", path, "]",
				 "field[0,0;0,0;platform_level;;", platform_level, "]",
				 "field[0.5,0.5;9,1;filename;Enter file name;]",
				 "button_exit[7,1.8;2.5,0.9;create;create file]"
             }
             local form = table.concat(formspec, "")

              minetest.show_formspec(player_name, "cdmod:create_file", form)

	end

})


create_platform = function(self, parent_y)
	local path = self.object:get_luaentity().path
    local glass= minetest.get_content_id("default:glass")
	min = {x = 0, y = parent_y + 13, z = 0}
	max = {x = 19, y = parent_y + 13, z = 19}
	
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(min, max)
    local a = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()

	for z = min.z, max.z do
    	for y = min.y, max.y do
        	for x = min.x, max.x do
            	-- vi, voxel index, is a common variable name here
            	local vi = a:index(x, y, z)
				data[vi] = glass
				local nodemeta = minetest.get_meta({x = x,y = y, z = z})
				nodemeta:set_string("path", path)
        	end
    	end
	end

	--for i in a:iter(0, p1.y, 0, 19, p2.y, 19) do
    --     data[i] = glass
    --end
    vm:set_data(data)
    vm:write_to_map(true)
	
	list_directory(self, parent_y)
end

list_directory = function(self, parent_y)
-- make grid 20x20 initially fully empty
    local grid = {} for i = 0, 19 do grid[i] = {}
    for j = 0, 19 do  grid[i][j] = 0 end end

    -- process file line by line and create entity with a given name in file on a random position 
    local path = self.path
    local fullpath = ""
	if path == "" then path = "/" end
	-- traverse all files at given path 
    for file in lfs.dir(path) do 
		if file ~= '.' and file ~= '..' and file ~= '/' then
            local posx, posz = getvalue(grid, 19)
            if path == "/" then fullpath = path .. file
			else fullpath = path .. '/' .. file end
            local attr = lfs.attributes(fullpath)
            if attr.mode == "directory" then
            	local entity = minetest.add_entity({x = posx,  y = math.random(parent_y + 15, parent_y + 23), z = posz}, "cdmod:directory")
                entity:set_nametag_attributes({color = "black", text = file})
                entity:set_armor_groups({immortal=0})
				entity:get_luaentity().path = fullpath 
			else
				local entity = minetest.add_entity({x = posx,  y = math.random(parent_y + 15, parent_y + 23), z = posz}, "cdmod:file")
                entity:set_nametag_attributes({color = "black", text = file})
                entity:set_armor_groups({immortal=0})
				entity:get_luaentity().path = fullpath
			end


		end
    end
	local rootnodemeta = minetest.get_meta({x = 0; y = parent_y + 13; z = 0})
	local sl_grid = minetest.serialize(grid)
	rootnodemeta:set_string("grid", sl_grid)
	
	
end





-- register directory entity blueprint
minetest.register_entity("cdmod:directory", {
	initial_properties = 
	 {
        physical = true,
        pointable = true,
        visual = "sprite",
        textures = {"cdmod_folder.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true,
        makes_footstep_sound = false,
        nametag_color = "black",
        infotext = "",
        static_save = true,
        shaded = true,
    },
		path = "",

	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		local parent_y = self.object:get_pos().y
		minetest.log(dump(self))
		if tool_capabilities.damage_groups.enter == 1
			then 
			puncher:set_pos({x = 10, y = parent_y + 15, z =  0})
			create_platform(self, parent_y)			
			end
	end,
	on_activate = function(self, staticdata, dtime_s) 
		self.object:set_acceleration({x = 0, y = -10, z = 0})
	end

})


-- register files entity blueprint
minetest.register_entity("cdmod:file", {
	initial_properties = 
	 {
        physical = true,
        pointable = true,
        visual = "sprite",
        textures = {"cdmod_file.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
        is_visible = true,
        makes_footstep_sound = false,
        nametag_color = "black",
        infotext = "",
        static_save = true,
        shaded = true,
    },
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		 if tool_capabilities.damage_groups.read == 1
		then 
			 local player = puncher:get_player_name()
			 local currentfile = io.open(self.path)
             local content = currentfile:read("*all")
			 minetest.chat_send_all("The file content is following" .. content)

			local formspec = {
        		"formspec_version[3]",
        		"size[13,13,false]",
				"textarea[0.5,0.5;12.0,12.0;;;", minetest.formspec_escape(content),"]"
			}
			local form = table.concat(formspec, "")

			 minetest.show_formspec(player, "cdmod:file_content", form)
		end
	end,
	on_activate = function(self, staticdata, dtime_s) 
		self.object:set_acceleration({x = 0, y = -10, z = 0})
	end

})




-- create initial platform
minetest.register_on_generated(function(minp, maxp,  blockseed)
local start_pos = {x=0, y=0, z=0} -- starting position of platform
    if (minp.x <= start_pos.x and start_pos.x <= maxp.x
        and minp.y <= start_pos.y and start_pos.y <= maxp.y
        and minp.z <= start_pos.z and start_pos.z <= maxp.z)
    then
        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        local data = vm:get_data()
        local a = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
        local c_glass= minetest.get_content_id("default:glass")
    	 min = {x = 0, y = 0, z = 0}
    	 max = {x = 19, y = 0, z = 19}
	
		for z = min.z, max.z do
         for y = min.y, max.y do
             for x = min.x, max.x do
        		local vi = a:index(x, y, z)
				 data[vi] = c_glass
                 local nodemeta = minetest.get_meta({x = x,y = y, z = z})
                 nodemeta:set_string("path", "/tmp")
             end
         end
     end
	
    -- save data to map
    vm:set_data(data)
    vm:write_to_map()
    end	

	local  grid = {} for i = 0, 19 do grid[i] = {}
           for j = 0, 19 do  grid[i][j] = 0 end end
    grid[10][10] = nil

	 local rootnodemeta = minetest.get_meta({x = 0; y = 0; z = 0})
     local sl_grid = minetest.serialize(grid)
     rootnodemeta:set_string("grid", sl_grid)


end)

