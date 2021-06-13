
glass = {};

local mod_path = minetest.get_modpath("glass")

dofile(mod_path.."/glass.lua")

if minetest.get_modpath("door") ~= nil then
	dofile(mod_path.."/door.lua")
end
