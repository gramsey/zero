
sand = {};

local mod_path = minetest.get_modpath("sand")

dofile(mod_path.."/sand.lua")
dofile(mod_path.."/alias.lua")

if minetest.get_modpath("stair") ~= nil then
	dofile(mod_path.."/stair.lua")
end
