
minetest.register_biome({
	name = "rainforest",
	node_top = "jungle:litter",
	depth_top = 1,
	node_filler = "dirt:dirt",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 86,
	humidity_point = 65,
})

minetest.register_biome({
	name = "rainforest_swamp",
	node_top = "dirt:dirt",
	depth_top = 1,
	node_filler = "dirt:dirt",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = 0,
	y_min = -1,
	heat_point = 86,
	humidity_point = 65,
})

minetest.register_biome({
	name = "rainforest_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:water_source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 1,
	y_max = -2,
	y_min = -255,
	heat_point = 86,
	humidity_point = 65,
})

local cave_liquid = {"water:water_source"};

if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:water_source", "lava:lava_source"};
end

minetest.register_biome({
	name = "rainforest_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 86,
	humidity_point = 65,
})

jungle.add_to_biome("rainforest")
jungle.add_emergent_to_biome("rainforest")
jungle.add_log_to_biome("rainforest")

-- add additional trees at water level for swamp
jungle.add_to_biome("rainforest_swamp", {
	name = "rainforest:swamp_trees",
	place_on = {"default:dirt"},
	sidelen = 16,
	noise_params = { 
		offset = 0.0, 
		scale = -0.1, 
		spread = {x = 200, y = 200, z = 200},
		seed = 354, 
		octaves = 1, 
		persist = 0.5 
	},
	y_max = 0,
	y_min = -1,
})

if(minetest.get_modpath("papyrus")) ~= nil then
	--papyrus.add_to_biome_on_dirt("rainforest_swamp")
end
