
local river_bed = {"snow:ice"};
if(minetest.get_modpath("gravel")) ~= nil then
	river_bed = {"gravel:gravel"};
end

minetest.register_biome({
	name = "icesheet",
	node_dust = "snow:block",
	node_top = "snow:block",
	depth_top = 1,
	node_filler = "snow:block",
	depth_filler = 3,
	node_stone = "snow:cave_ice",
	node_water_top = "snow:ice",
	depth_water_top = 10,
	node_river_water = "snow:ice",
	node_riverbed = "gravel:gravel",
	depth_riverbed = 2,
	node_dungeon = "snow:ice",
	node_dungeon_stair = "snow:stair_ice",
	y_max = 31000,
	y_min = -8,
	heat_point = 0,
	humidity_point = 73,
})

minetest.register_biome({
	name = "icesheet_ocean",
	node_dust = "snow:block",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_water_top = "snow:ice",
	depth_water_top = 10,
	node_cave_liquid = "water:water_source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -9,
	y_min = -255,
	heat_point = 0,
	humidity_point = 73,
})

local cave_liquid = {"water:water_source"};
if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:water_source", "lava:lava_source"};
end

minetest.register_biome({
	name = "icesheet_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 0,
	humidity_point = 73,
})

