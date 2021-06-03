
jungle = {};

local mod_path = minetest.get_modpath("jungle")

dofile(mod_path.."/jungle.lua")
dofile(mod_path.."/sapling.lua")
dofile(mod_path.."/mapgen.lua")

if minetest.get_modpath("fence") ~= nil then
	dofile(mod_path.."/fence.lua")
end
