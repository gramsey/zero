
iron = {}

local mod_path = minetest.get_modpath("iron")
dofile(mod_path.."/iron.lua")

if (minetest.get_modpath("sign") ~= nil) then
	dofile(mod_path.."/sign.lua")
end
