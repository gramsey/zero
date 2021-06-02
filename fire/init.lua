
fire = {}

local mod_path = minetest.get_modpath("fire")
dofile(mod_path.."/fire.lua")

if (minetest.get_modpath("iron") ~= nil) then
	dofile(mod_path.."/flint_and_steel.lua")
end

if (minetest.get_modpath("coal") ~= nil) then
	dofile(mod_path.."/coal_block.lua")
end
