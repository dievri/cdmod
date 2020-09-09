local np = require '9p'
local socket = require 'socket'
local readdir = require 'readdir'
local tcp = socket:tcp()
local connection, err = tcp:connect("instance1", 1916)

if (err ~= nil) then
  error("Connection error")
end

local conn = np.attach(tcp, "bebebeko", "")

for n, file in pairs(readdir(conn, "./")) do
  print(file.name)
end
