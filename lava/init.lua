
lava = {}

local mod_path = minetest.get_modpath("lava")
dofile(mod_path.."/lava.lua")
dofile(mod_path.."/item_entity.lua")

if(minetest.get_modpath("bucket")) ~= nil then
	dofile(mod_path.."/lava_bucket.lua")
end
