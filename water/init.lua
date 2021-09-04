water = {}

local mod_path = minetest.get_modpath("water")
dofile(mod_path.."/water.lua")
dofile(mod_path.."/alias.lua")

if minetest.global_exists("bucket") then
	dofile(mod_path.."/water_bucket.lua")
end
