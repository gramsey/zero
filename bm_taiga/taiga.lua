
minetest.register_biome({
	name = "bm_taiga",
	node_dust = "snow:snow",
	node_top = "dirt:snow",
	depth_top = 1,
	node_filler = "dirt:dirt",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = 31000,
	y_min = 4,
	heat_point = 25,
	humidity_point = 70,
})

minetest.register_biome({
	name = "bm_taiga_ocean",
	node_dust = "snow:snow",
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
	y_max = 3,
	y_min = -255,
	heat_point = 25,
	humidity_point = 70,
})

local cave_liquid = {"water:water_source"};
if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:water_source", "lava:lava_source"};
end

minetest.register_biome({
	name = "bm_taiga_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 25,
	humidity_point = 70,
})

if(minetest.get_modpath("pine")) ~= nil then
	pine.add_to_biome("taiga")
	pine.add_small_to_biome("taiga")
	pine.add_log_to_biome("taiga")
end
