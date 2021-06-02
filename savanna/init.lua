
local mod_path = minetest.get_modpath("savanna")
dofile(mod_path.."/savanna.lua")

if minetest.get_modpath("farming") then
	farming.add_cotton_to_biome("savanna", "grass:dirt_dry")
end
