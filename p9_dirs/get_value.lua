-- get coordinates of emply cell
function get_value (free_slots, size)
    if size < 0 then return nil end
	while (true)
    do
        ::continue::
        local posx = math.random(1, size)

        -- check if choosen value is in the table
        if free_slots[posx] == nil
            then
                -- check if any value is in the table. If not - return nil
                if next(free_slots) == nil then
                    return nil
                end
            goto continue
        end
        
        local posz = math.random(1, size)
        -- check z coordinate's
        if free_slots[posx][posz] == nil 
            then
                -- check if any value is in the table. if not - return nil
                if next(free_slots[posx]) == nil then
                    return nil
                end
             goto continue
        end
        -- save values and remove from table
        local x, z = posx, posz
        
        free_slots[posx][posz] = nil
        if next(free_slots[posx]) == nil then
            free_slots[posx] = nil
        end
        -- if reeched there, than we have valid values an we can return them    
        return x,z
    end
end

