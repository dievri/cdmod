function get_level(player)
    local pos = player:get_pos()
    -- find glass in radius of 6
	local node = minetest.find_node_near(pos, 6, {"default:glass"})
    return node.y
end