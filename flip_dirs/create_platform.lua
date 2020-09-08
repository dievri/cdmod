create_platform = function(posx, posy, posz, size, orientation, content)
    print(posx .. posy .. posz .. size .. orientation)
    local corner = { x = posx, y = posy, z = posz, s = size, o = orientation }
    local empty_nodes = {}
    local corner = minetest.serialize(corner)
    local first_dimension, second_dimension = 0
    if orientation == "h" then 
        first_dimension = posx
        second_dimension = posz
    else 
        first_dimension = posx
        second_dimension = posy
    end
        local first_end = first_dimension + size
        local second_end = second_dimension + size


    for first = first_dimension, first_end do
        for second = second_dimension, second_end do
                table.insert(empty_nodes, {x = first, y = second}) 
                if orientation == "h" then
                    minetest.set_node({x = first, y = posy, z = second}, {name="cdmod:platform"})
                    local node = minetest.get_meta({x = first, y = posy, z = second})
                    node:set_string("corner", corner)
                else
                    minetest.set_node({x = first, y =  second, z = posz}, {name="cdmod:platform"})
                    local node = minetest.get_meta({x = first, y = second, z = posz})
                    node:set_string("corner", corner)
                end
            end
        end

    

    local shuffled = {}
    for i, v in ipairs(empty_nodes) do
        local pos = math.random(1, #shuffled+1)
        table.insert(shuffled, pos, v)
    end

    local full_slots = {}
    local node = minetest.get_meta({x = posx; y = posy; z = posz})
    if content ~= nil then
        for n, file in pairs(content) do
            local k, v = next(shuffled)
            local entity = nil
            if file.type == 128 then 
                entity = minetest.add_entity({x = v.x,  
                y = v.y, 
                z = math.random(posz + 3, posz + 11)}, "cdmod:directory")
                table.insert(full_slots, {x = v.x, y = v.y})
            else
                entity = minetest.add_entity({x = v.x,  
                y = v.y, 
                z = math.random(posz + 3, posz + 11)}, "cdmod:file")
                table.insert(full_slots, {x = v.x, y = v.y})
            end
            entity:set_nametag_attributes({color = "black", text = file.name})
                entity:set_armor_groups({immortal=0})
                entity:set_acceleration({x = 0, y = 0, z = -6})
                entity:get_luaentity().path = file.path
                table.remove(shuffled, k)
        end
        local full = minetest.serialize(full_slots)
        node:set_string("full", full)
    end

    local empty = minetest.serialize(shuffled)
        node:set_string("empty", empty)
        
    return minetest.deserialize(corner)

end


delete_platform = function(posx, posy, posz, size, orientation)
    local node_meta = minetest.get_meta({x = posx, y = posy, z = posz})
    local content_string = node_meta:get_string("content")
    local content = minetest.deserialize(content_string)
    local full_string = node_meta:get_string("full")
    local full = minetest.deserialize(full_string)
    if full ~= nil then
        for k, v in pairs(full) do
            local objects = nil
            if orientation == "h" then
                objects = minetest.get_objects_inside_radius({x = v.x, y = posy, z = v.y}, 2)
            else 
                objects = minetest.get_objects_inside_radius({x = v.x, y = v.y, z = posz}, 2)
         end
            while next(objects) ~= nil do
                local k, v = next(objects)
                v:remove()
                table.remove(objects, k)
            end
        end
    end

    local corner = { x = posx, y = posy, z = posz, s = size, o = orientation }
    local empty_nodes = {}
    local corner = minetest.serialize(corner)
    local first_dimension, second_dimension = 0
    local new_orientation = nil
    if orientation == "h" then 
        new_orientation = "v"
        first_dimension = posx
        second_dimension = posz
    else 
        new_orientation = "h"
        first_dimension = posx
        second_dimension = posy
    end

    local first_end = first_dimension + size
    local second_end = second_dimension + size

    for first = first_dimension, first_end do
        for second = second_dimension,  second_end  do
                table.insert(empty_nodes, {x = first, y = second}) 
                if orientation == "h" then
                    minetest.set_node({x = first, y = posy, z = second}, {name="air"})
                    local node = minetest.get_meta({x = first, y = posy, z = second})
                    node:set_string("corner", nil)
                else
                    minetest.set_node({x = first, y = second, z = posz}, {name="air"})
                    local node = minetest.get_meta({x = first, y = second, z = posz})
                    node:set_string("corner", nil)
                end
        end
    end

    local node = minetest.get_meta({x = posx, y = posy, z = posz})
    node:set_string("empty", nil)
  
    create_platform(posx, posy, posz, size, new_orientation, content)
end
