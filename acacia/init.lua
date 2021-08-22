
acacia = {};

local mod_path = minetest.get_modpath("acacia")

dofile(mod_path.."/acacia.lua")
dofile(mod_path.."/sapling.lua")
dofile(mod_path.."/mapgen.lua")

if minetest.get_modpath("fence") ~= nil then
	dofile(mod_path.."/fence.lua")
end
if (minetest.get_modpath("stair") ~= nil) then
	dofile(mod_path.."/stair.lua")
end
if (minetest.get_modpath("mese") ~= nil) then
	dofile(mod_path.."/meselamp.lua")
end
