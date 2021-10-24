
wool = {}

local mod_path = minetest.get_modpath("wool")

dofile(mod_path.."/wool.lua")

if (minetest.get_modpath("dungeon_loot") ~= nil) then
	dofile(mod_path.."/loot.lua")
end

if (minetest.get_modpath("mobs") ~= nil) and minetest.get_modpath("diamond") ~= nil then
	dofile(mod_path.."/lasso.lua")
end
