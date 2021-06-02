
farming = {};

local mod_path = minetest.get_modpath("farming")

dofile(mod_path.."/farming.lua")
dofile(mod_path.."/nodes.lua")
dofile(mod_path.."/hoes.lua")
dofile(mod_path.."/api.lua")

if minetest.get_modpath("farming") ~= nil then
	dofile(mod_path.."/stair.lua")
end
