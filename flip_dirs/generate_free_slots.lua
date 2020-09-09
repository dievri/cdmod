-- generate grid with given size and populate it with zeros
function generate_free_slots(size) 
    local grid = {} 
    print("Generating grid . .. ")
    for i = 0, size do 
        grid[i] = {}
        for j = 0, size do  
            grid[i][j] = 0 
        end 
    end
    return grid
end
     