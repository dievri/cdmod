minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "cdmod:create_file" then 
        -- if no file name specified, return
        if(fields["filename"] == nil) then 
            return
        end
        -- convert string to number
        local level = tonumber(fields["level"])
        
        -- write file 
		local fullpath = fields["path"] .. "/" .. fields["filename"]
		local file = io.open(fullpath, "w")
        file:close()
        
        -- find position where to put new file
        local x, z = get_value(level, 20)	
        
        -- add entity to the platform and set basic attributes
        local entity = minetest.add_entity({
            x = x, y = math.random(level + 2, level + 10), z = z}, "cdmod:file")
        entity:set_nametag_attributes({color = "black", text = fields["filename"]})
        entity:set_armor_groups({immortal=0})
        entity:get_luaentity().path = fullpath
	end
end)