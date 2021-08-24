
iron = {}

local mod_path = minetest.get_modpath("iron")
dofile(mod_path.."/iron.lua")
dofile(mod_path.."/ladder.lua")

if (minetest.get_modpath("sign") ~= nil) then
	dofile(mod_path.."/sign.lua")
end

if (minetest.get_modpath("door") ~= nil) then
	dofile(mod_path.."/door.lua")
end
