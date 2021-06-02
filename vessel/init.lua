
vessel = {};

local mod_path = minetest.get_modpath("vessel")

dofile(mod_path.."/glass.lua")
if minetest.get_modpath("wood") ~= nil then
	dofile(mod_path.."/shelf.lua")
end
if minetest.get_modpath("iron") ~= nil then
	dofile(mod_path.."/steel.lua")
end
