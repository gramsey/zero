stone = {};

local mod_path = minetest.get_modpath("stone")
dofile(mod_path.."/stone.lua")
dofile(mod_path.."/alias.lua")

if(minetest.get_modpath("stair")) ~= nil then
	dofile(mod_path.."/stair.lua")
end

if(minetest.get_modpath("tools")) ~= nil then
	dofile(mod_path.."/tools.lua")
end

if(minetest.get_modpath("fence")) ~= nil then
	dofile(mod_path.."/wall.lua")
end
