list_directory = function(level, path, size)
    for n, file in pairs(root_dir) do
        local x, z = get_value(free_slots, size)
        local entity = nil
        if file.qid.type == 128 then 
            entity = minetest.add_entity({x = x,  
            y = math.random(level + 3, level + 11), 
            z = z}, "cdmod:directory")
        else
            entity = minetest.add_entity({x = x,  
            y = math.random(level + 3, level + 11), 
            z = z}, "cdmod:file")
        end
        entity:set_nametag_attributes({color = "black", text = file.name})
            entity:set_armor_groups({immortal=0})
            if fullpath == "./" then path = "." end
            print("Path which is set to entity: " .. path .. "/" .. file.name)
            entity:get_luaentity().path = path .. "/" .. file.name
    end

    local free_slots_string = minetest.serialize(free_slots)
    node:set_string("free_slots", free_slots_string)

   
end



