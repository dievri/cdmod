-- get coordinates of emply cell
function getvalue (grd, size)
    while (true)
    do
        ::continue::
        local posx = math.random(1, size)

        -- check if choosen value is in the table
        if grd[posx] == nil
            then
                -- check if any value is in the table. If not - return nil
                if next(grd) == nil then
                    return nil
                end
            goto continue
        end
        
        local posz = math.random(1, size)
        -- check z coordinate's
        if grd[posx][posz] == nil 
            then
                -- check if any value is in the table. if not - return nil
                if next(grd[posx]) == nil then
                    return nil
                end
             goto continue
        end
        -- save values and remove from table
        local x, z = posx, posz
        
        grd[posx][posz] = nil
        if next(grd[posx]) == nil then
            grd[posx] = nil
        end
        -- if reeched there, than we have valid values an we can return them    
        return x,z
    end
end

