minetest.register_chatcommand("hcircle", {
    params = "<(x, y, z, radius)>",
    func = function(name, param) 
        local t = {}
        local s = param
        for k, v in string.gmatch(s, "(%w+)=(%w+)") do
          t[k] = v
        end
        create_round_horizontal_platform(tonumber(t.x), tonumber(t.y), tonumber(t.z), tonumber(t.r))
    end
})

minetest.register_chatcommand("vcircle", {
    params = "<(x, y, z, radius)>",
    func = function(name, param) 
        local t = {}
        local s = param
        for k, v in string.gmatch(s, "(%w+)=(%w+)") do
          t[k] = v
        end
        create_round_vertical_platform(tonumber(t.x), tonumber(t.y), tonumber(t.z), tonumber(t.r))
    end
})