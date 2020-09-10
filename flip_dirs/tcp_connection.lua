--[[

tcp = socket:tcp()
 connection, err = tcp:connect("instance1", 32000)
if (err ~= nil) then
print("dump of error newest .. " .. dump(err))
    error("Connection error")
end
conn = np.attach(tcp, "bebebeko", "")

]]