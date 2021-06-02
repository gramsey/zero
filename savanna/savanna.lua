
local cave_liquid = {"water:water_source"};
minetest.register_biome({
		name = "savanna",
		node_top = "grass:dirt_dry",
		depth_top = 1,
		node_filler = "dirt:dry",
		depth_filler = 1,
		node_riverbed = "sand:sand",
		depth_riverbed = 2,
		node_dungeon = "stone:cobble",
		node_dungeon_alt = "stone:mossycobble",
		node_dungeon_stair = "stone:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_shore",
		node_top = "dirt:dry",
		depth_top = 1,
		node_filler = "dirt:dry",
		depth_filler = 3,
		node_riverbed = "sand:sand",
		depth_riverbed = 2,
		node_dungeon = "stone:cobble",
		node_dungeon_alt = "stone:mossycobble",
		node_dungeon_stair = "stone:stair_cobble",
		y_max = 0,
		y_min = -1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_ocean",
		node_top = "sand:sand",
		depth_top = 1,
		node_filler = "sand:sand",
		depth_filler = 3,
		node_riverbed = "sand:sand",
		depth_riverbed = 2,
		node_cave_liquid = cave_liquid,
		node_dungeon = "stone:cobble",
		node_dungeon_alt = "stone:mossycobble",
		node_dungeon_stair = "stone:stair_cobble",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 89,
		humidity_point = 42,
	})

if(minetest.get_modpath("lava")) ~= nil then
	cave_liquid = {"water:water_source", "lava:lava_source"};
end

minetest.register_biome({
	name = "savanna_under",
	node_cave_liquid = cave_liquid,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = "stone:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 89,
	humidity_point = 42,
})

grass.add_dry_to_biome("savanna")
acacia.add_to_biome("savanna")
acacia.add_log_to_biome("savanna")

if minetest.get_modpath("papyrus") then
	papyrus.add_to_biome_on_dry_dirt("savanna_ocean")
end
