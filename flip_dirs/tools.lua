minetest.register_tool("cdmod:flip", {
    desription = "Flip platform",
    inventory_image = "cdmod_flip.png",
    wield_image = "cdmod_flip.png",
    tool_capabilities = {punch_attack_uses = 0, damage_groups = {flip = 1}}
})

minetest.register_tool("cdmod:enter", {
    desription = "Enter key",
    inventory_image = "cdmod_enter.png",
    wield_image = "cdmod_enter.png",
    tool_capabilities = {punch_attack_uses = 0, damage_groups = {enter = 1}}
})

minetest.register_tool("cdmod:wipe", {
    desription = "Wipe platform",
    inventory_image = "cdmod_wipe.png",
    wield_image = "cdmod_wipe.png",
    tool_capabilities = {punch_attack_uses = 0, damage_groups = {wipe = 1}}
})

minetest.register_tool("cdmod:read", {
    desription = "Read file",
    inventory_image = "cdmod_read.png",
    wield_image = "cdmod_read.png",
    tool_capabilities = {punch_attack_uses = 0, damage_groups = {read = 1}}
})

minetest.register_tool("cdmod:connect", {
    desription = "Connect to inferno",
    inventory_image = "cdmod_connect.png",
    wield_image = "cdmod_connect.png",
    tool_capabilities = {punch_attack_uses = 0, damage_groups = {connect = 1}},

    on_use = function(itemstack, player, pointed_thing)
        local player_name = player:get_player_name()

        local formspec = {
            "formspec_version[3]", "size[10,3,false]",
            "field[0.5,0.5;9,1;conn_string;Enter connection string;]",
            "button_exit[7,1.8;2.5,0.9;connect;connect]"
        }
        local form = table.concat(formspec, "")
        minetest.show_formspec(player_name, "cdmod:connect", form)

    end
})
