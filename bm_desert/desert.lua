
-- Desert
local dungeon_stair = "stone:cobble"
local desert_dungeon_stair = "sand:desert_sandstone"

if(minetest.get_modpath("stair")) ~= nil then
	sand_dungeon_stair = "sand:stair_desert_sandstone"
	dungeon_stair = "stone:stair_cobble"
end

if(minetest.get_modpath("lava")) ~= nil then
	other_cave_liquid = "lava:lava_source";
end

minetest.register_biome({
	name = "desert",
	node_top = "sand:desert",
	depth_top = 1,
	node_filler = "sand:desert",
	depth_filler = 1,
	node_stone = "sand:desert_sandstone",
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "sand:desert_sandstone",
	node_dungeon_stair = sand_dungeon_stair,
	y_max = 31000,
	y_min = 4,
	heat_point = 92,
	humidity_point = 16,
})

minetest.register_biome({
	name = "desert_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_stone = "sand:desert_sandstone",
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:water_source",
	node_dungeon = "sand:desert_sandstone",
	node_dungeon_stair = sand_dungeon_stair,
	vertical_blend = 1,
	y_max = 3,
	y_min = -255,
	heat_point = 92,
	humidity_point = 16,
})

minetest.register_biome({
	name = "desert_under",
	node_cave_liquid = {"water:water_source", other_cave_liquid},
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = dungeon_stair,
	y_max = -256,
	y_min = -31000,
	heat_point = 92,
	humidity_point = 16,
})

if(minetest.get_modpath("stair")) ~= nil then
	sand_dungeon_stair = "sand:stair_sandstone_block"
end
	-- Sandstone desert

minetest.register_biome({
	name = "sandstone_desert",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 1,
	node_stone = "sand:sandstone",
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "sand:sandstonebrick",
	node_dungeon_stair = sand_dungeon_stair,
	y_max = 31000,
	y_min = 4,
	heat_point = 60,
	humidity_point = 0,
})

minetest.register_biome({
	name = "sandstone_desert_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_stone = "sand:sandstone",
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:water_source",
	node_dungeon = "sand:sandstonebrick",
	node_dungeon_stair = sand_dungeon_stair,
	y_max = 3,
	y_min = -255,
	heat_point = 60,
	humidity_point = 0,
})

minetest.register_biome({
	name = "sandstone_desert_under",
	node_cave_liquid = {"water:water_source", other_cave_liquid},
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = dungeon_stair,
	y_max = -256,
	y_min = -31000,
	heat_point = 60,
	humidity_point = 0,
})

-- Cold desert
minetest.register_biome({
	name = "cold_desert",
	node_top = "sand:silver",
	depth_top = 1,
	node_filler = "sand:silver",
	depth_filler = 1,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = dungeon_stair,
	y_max = 31000,
	y_min = 4,
	heat_point = 40,
	humidity_point = 0,
})

minetest.register_biome({
	name = "cold_desert_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:water_source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = dungeon_stair,
	vertical_blend = 1,
	y_max = 3,
	y_min = -255,
	heat_point = 40,
	humidity_point = 0,
})

minetest.register_biome({
	name = "cold_desert_under",
	node_cave_liquid = {"water:water_source", other_cave_liquid},
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = dungeon_stair,
	y_max = -256,
	y_min = -31000,
	heat_point = 40,
	humidity_point = 0,
})
