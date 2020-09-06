minetest.register_authentication_handler({
        get_auth = function(name)
                -- reading password
                local file = io.open("/users/" .. name .. "/password")
                if file == nil then
                        print("No user, creating new password")
                        return nil
                end
                passwd = file:read("*all")
                file:close()
                -- reading priveleges
                local file = io.open("/users/" .. name .. "/privs")
                privs_string = file:read("*all")
                file:close()
                privs = minetest.string_to_privs(privs_string)
                -- return pass, privs and last_login
                return { password = passwd, privileges = privs, last_login = -1 }
        end, 
        
        create_auth = function(name, password)
                lfs.mkdir("/users/" .. name)
                -- write pass
                local file = io.open("/users/" .. name .. "/password", "w")
                file:write(password)
                file:close()
                -- write default privs
                local privileges = minetest.settings:get("default_privs")
                local file = io.open("/users/" .. name .. "/privs", "w")
                file:write(privileges)
                file:close()
                print("authentication created")
        end, 

        delete_auth = function(name)
                minetest.log("called delete_auth")
                return nil
        end,
        set_password = function(name, password) 
                local file = io.open("/users/" .. name .. "/password", "w")
                file:write(password)
                file:close()
                print("pass written")
                return true
        end,
        set_privileges = function(name, privileges)
                local privs = minetest.privs_to_string(privileges)
                local file = io.open("/users/" .. name .. "/privs", "w")
                file:write(privs)
                file:close()
        end,
        reload = function()
                print("Reloading from storage")
                return true
        end,
        record_login = function(name)
                print("TODO")
        end
})
