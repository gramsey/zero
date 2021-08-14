
minetest.register_biome({
	name = "bm_rainforest",
	node_top = "dirt:litter",
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
	name = "bm_rainforest_swamp",
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
	name = "bm_rainforest_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 1,
	y_max = -2,
	y_min = -255,
	heat_point = 86,
	humidity_point = 65,
})

local cave_liquid = {"water:source"};

if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:source", "lava:source"};
end

minetest.register_biome({
	name = "bm_rainforest_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 86,
	humidity_point = 65,
})

if(minetest.get_modpath("grass")) ~= nil then
	grass.add_jungle_to_biome("bm_rainforest")
	grass.add_fern_to_biome("bm_rainforest")
end

if(minetest.get_modpath("jungle")) ~= nil then
	jungle.add_to_biome("bm_rainforest")
	jungle.add_emergent_to_biome("bm_rainforest")
	jungle.add_log_to_biome("bm_rainforest")

	-- add additional trees at water level for swamp
	jungle.add_to_biome("bm_rainforest_swamp", {
		name = "bm_rainforest:swamp_trees",
		place_on = {"dirt:dirt"},
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
end

if(minetest.get_modpath("papyrus")) ~= nil then
	--papyrus.add_to_biome_on_dirt("bm_rainforest_swamp")
end

if (minetest.get_modpath("coral") ~= nil) then
	coral.add_to_biome("bm_rainforest_ocean")
end
