
default = { shim = {}} 

local mod_path = minetest.get_modpath("default")
dofile(mod_path.."/node_alias.lua")
dofile(mod_path.."/sound_alias.lua")
dofile(mod_path.."/sound_play.lua")
