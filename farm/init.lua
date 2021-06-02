
farm = {};

local mod_path = minetest.get_modpath("farm")

dofile(mod_path.."/api.lua")
dofile(mod_path.."/farm.lua")
dofile(mod_path.."/nodes.lua")
dofile(mod_path.."/hoes.lua")

if minetest.get_modpath("farm") ~= nil then
	dofile(mod_path.."/stair.lua")
end
