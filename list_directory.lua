-- list content of directory to the free slots
list_directory = function(self, level)
        local node = minetest.get_meta({x = 0,y = level, z = 0})
        local free_slots_string = node:get_string("free_slots")
        local free_slots = minetest.deserialize(free_slots_string)
        -- process file line by line and create entity with a given name in file on a random position 
        local path = self.path
        if path == nil then
            return
        end

        -- lists content of directory 
        for file in lfs.dir(path) do 
            if file ~= '.' and file ~= '..' then
                local entity = nil
                fullpath = path .. '/' .. file 
                local attr = lfs.attributes(fullpath)
                local x, z = get_value(free_slots, 20)
                if attr.mode == "directory" then
                    entity = minetest.add_entity({x = x,  y = math.random(level + 3, level + 11), z = z}, "cdmod:directory")
                else
                    entity = minetest.add_entity({x = x,  y = math.random(level + 3, level + 11), z = z}, "cdmod:file")
                end  
                -- set basic attributes
                entity:set_nametag_attributes({color = "black", text = file})
                entity:set_armor_groups({immortal=0})
                entity:get_luaentity().path = fullpath    
            end
        end
        -- save final state of free slots to the corner node
        local free_slots_string = minetest.serialize(free_slots)
        node:set_string("free_slots", free_slots_string)
    end
    
    
    
    