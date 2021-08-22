
apple = {}

local mod_path = minetest.get_modpath("apple")

dofile(mod_path.."/apple.lua")
dofile(mod_path.."/sapling.lua")
dofile(mod_path.."/bush.lua")
dofile(mod_path.."/bush_sapling.lua")
dofile(mod_path.."/mapgen.lua")

if (minetest.get_modpath("fence") ~= nil) then
	dofile(mod_path.."/fence.lua")
end

if (minetest.get_modpath("door") ~= nil) then
	dofile(mod_path.."/door.lua")
end

if (minetest.get_modpath("stair") ~= nil) then
	dofile(mod_path.."/stair.lua")
end

if (minetest.get_modpath("paper") ~= nil) then
	dofile(mod_path.."/bookshelf.lua")
end

if (minetest.get_modpath("mese") ~= nil) then
	dofile(mod_path.."/meselamp.lua")
end
