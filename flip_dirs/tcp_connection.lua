tcp = socket:tcp()
 connection, err = tcp:connect("instance1", 1916)
if (err ~= nil) then
    error("Connection error")
end
conn = np.attach(tcp, "bebebeko", "")