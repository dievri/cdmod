function get_number_of_elements(conn, path)
    if path == "." then path = "./" end
    local root_dir = readdir(conn, path)
    print("counting number of elements")
    local size = 0
    if root_dir == nil then return 0 end
    for n, file in pairs(root_dir) do
        size = size + 1       
    end
    return size
end
