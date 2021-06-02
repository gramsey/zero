
bug = {};

local mod_path = minetest.get_modpath("bug")

dofile(mod_path.."/firefly.lua")

if minetest.get_modpath("flower") ~= nil then
	dofile(mod_path.."/butterfly.lua")
end
if minetest.get_modpath("wool") ~= nil then
	dofile(mod_path.."/net.lua")
end
if minetest.get_modpath("glass") ~= nil then
	dofile(mod_path.."/bottle.lua")
end
