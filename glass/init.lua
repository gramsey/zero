
glass = {};

local mod_path = minetest.get_modpath("glass")

dofile(mod_path.."/glass.lua")
dofile(mod_path.."/obsidian.lua")

if minetest.get_modpath("door") ~= nil then
	dofile(mod_path.."/door.lua")
end

if minetest.get_modpath("stair") ~= nil then
	dofile(mod_path.."/stair.lua")
end
