
mese = {}

local mod_path = minetest.get_modpath("mese")
dofile(mod_path.."/mese.lua")

if (minetest.get_modpath("wood") ~= nil and minetest.get_modpath("glass") ~= nil) then
	dofile(mod_path.."/lamp.lua")
end
