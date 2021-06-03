
local mod_path = minetest.get_modpath("savanna")
dofile(mod_path.."/savanna.lua")

if minetest.get_modpath("farm") then
	farm.add_cotton_to_biome("savanna", "dirt:grass_dry")
end
