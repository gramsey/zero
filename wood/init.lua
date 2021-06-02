
wood = {}

local mod_path = minetest.get_modpath("wood")
dofile(mod_path.."/wood.lua")
dofile(mod_path.."/tree.lua")
dofile(mod_path.."/leaves.lua")

if (minetest.get_modpath("tools") ~= nil) then
	dofile(mod_path.."/tools.lua")
end
