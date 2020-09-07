minetest.register_on_joinplayer(function(player)
    player:set_pos({x = 10, y = 2, z = 0})
    
    local tcp = socket:tcp()
    local connection, err = tcp:connect("instance1", 1916)

    if (err ~= nil) then
        error("Connection error")
    end
 
    local conn = np.attach(tcp, "bebebeko", "")
    local path = "./"
    local root_dir = readdir(conn, "./")
    size = 0
    folders = {}
    sizes = {}
    for n, file in pairs(root_dir) do
        size = size + 1
        print(file.name .. " size: " .. size)
        if (file.qid.type == 128) then
            table.insert(folders, file.name)
        end
    end
    for i, folder in ipairs(folders) do
        size = 0
        print("folder which is causing error " .. folder)
        if folder == "fd" or folder == "prof" or folder == "net.alt" 
           or folder == "chan" or folder == "nvfs"
        then 
            goto continue
        end 
        local current_dir = readdir(conn, path .. folder)
        if current_dir ~= nil then
            for n, file in pairs(current_dir) do
                size = size + 1
            end
        end
        sizes[folder] = size
        ::continue::
    end

    print(dump(sizes))
 
   
end)