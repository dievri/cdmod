-- Initialize variable and uncomment needed functionality 
local mode = "/p9"
--[[ Traverse Linux Folders 
local lfs = require 'lfs'
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/get_value.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/get_level.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/register_on_joinplayer.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/register_on_player_receive_fields.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/register_tools.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/create_platform.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/entity_file.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/entity_directory.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/list_directory.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/generate_grid.lua")
dofile(minetest.get_modpath("cdmod") .. "/linux_dirs/authentication_handler.lua")
-- ]]
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/generate_free_slots.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/entity_directory.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/entity_file.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/register_tools.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/list_directory.lua")
data = require 'data'
np = require '9p'
socket = require 'socket'
pprint = require 'pprint'
readdir = require 'readdir'
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/tcp_connection.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/number_of_elements.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/create_platform.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/register_on_joinplayer.lua")
dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/get_level.lua")


dofile(minetest.get_modpath("cdmod") .. mode .. "_dirs/get_value.lua")