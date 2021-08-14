minetest.register_biome({
	name = "bm_tundra_highland",
	node_dust = "snow:snow",
	node_riverbed = "gravel:gravel",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = 31000,
	y_min = 47,
	heat_point = 0,
	humidity_point = 40,
})

minetest.register_biome({
	name = "bm_tundra",
	node_top = "snow:permafrost_with_stones",
	depth_top = 1,
	node_filler = "snow:permafrost",
	depth_filler = 1,
	node_riverbed = "gravel:gravel",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 4,
	y_max = 46,
	y_min = 2,
	heat_point = 0,
	humidity_point = 40,
})

minetest.register_biome({
	name = "bm_tundra_beach",
	node_top = "gravel:gravel",
	depth_top = 1,
	node_filler = "gravel:gravel",
	depth_filler = 2,
	node_riverbed = "gravel:gravel",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 1,
	y_max = 1,
	y_min = -3,
	heat_point = 0,
	humidity_point = 40,
})

minetest.register_biome({
	name = "bm_tundra_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_riverbed = "gravel:gravel",
	depth_riverbed = 2,
	node_cave_liquid = "water:source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 1,
	y_max = -4,
	y_min = -255,
	heat_point = 0,
	humidity_point = 40,
})

local cave_liquid = {"water:source"};
if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:source", "lava:source"};
end

minetest.register_biome({
	name = "bm_tundra_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 0,
	humidity_point = 40,
})

snow.add_permafrost_to_biome("bm_tundra")
snow.add_to_biome("bm_tundra", {
	biomes = {"bm_tundra", "bm_tundra_beach"},
})
