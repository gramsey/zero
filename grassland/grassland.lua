minetest.register_biome({
	name = "grassland",
	node_top = "grass:dirt",
	depth_top = 1, 
	node_filler = "dirt:dirt",
	depth_filler = 1, 
	node_riverbed = "sand:sand",
	depth_riverbed = 2, 
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_stone",
	y_max = 31000,
	y_min = 6, 
	heat_point = 50,
	humidity_point = 35,
})   

minetest.register_biome({
	name = "grassland_dunes",
	node_top = "sand:sand",
	depth_top = 1, 
	node_filler = "sand:sand",
	depth_filler = 2, 
	node_riverbed = "sand:sand",
	depth_riverbed = 2, 
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	vertical_blend = 1, 
	y_max = 5, 
	y_min = 4, 
	heat_point = 50,
	humidity_point = 35,
})   

minetest.register_biome({
	name = "grassland_ocean",
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
	y_max = 3, 
	y_min = -255,
	heat_point = 50,
	humidity_point = 35,
})   

local cave_liquid = {"water:water_source"};

if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:water_source", "lava:lava_source"};
end

minetest.register_biome({
	name = "grassland_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stone:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 50,
	humidity_point = 35,
})   

grass.add_to_biome("grassland")
flower.add_all_flowers_to_biome("grassland")
bug.add_butterfly_to_biome("grassland")
bug.add_firefly_to_biome("grassland")
papyrus.add_to_biome_on_dirt("grassland_ocean")
