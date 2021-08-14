
-- safe defaults when missing optional depends 
local dungeon_stair = "stone:stone";
local dungeon_alt = "stone:mossycobble";
local other_cave_liquid = "water:river_source";

if(minetest.get_modpath("stair")) ~= nil then
	dungeon_stair = "stone:stair_cobble";
end

if(minetest.get_modpath("lava")) ~= nil then
	other_cave_liquid = "lava:source";
end

minetest.register_biome({
	name = "bm_forest",
	node_top = "dirt:grass",
	depth_top = 1,
	node_filler = "dirt:dirt",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = dungeon_alt,
	node_dungeon_stair = dungeon_stair,
	y_max = 31000,
	y_min = 1,
	heat_point = 60,
	humidity_point = 68,
})

minetest.register_biome({
	name = "bm_forest_shore",
	node_top = "dirt:dirt",
	depth_top = 1,
	node_filler = "dirt:dirt",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_dungeon = "stone:cobble",
	node_dungeon_alt = dungeon_alt,
	node_dungeon_stair = dungeon_stair,
	y_max = 0,
	y_min = -1,
	heat_point = 60,
	humidity_point = 68,
})

minetest.register_biome({
	name = "bm_forest_ocean",
	node_top = "sand:sand",
	depth_top = 1,
	node_filler = "sand:sand",
	depth_filler = 3,
	node_riverbed = "sand:sand",
	depth_riverbed = 2,
	node_cave_liquid = "water:source",
	node_dungeon = "stone:cobble",
	node_dungeon_alt = dungeon_alt,
	node_dungeon_stair = dungeon_stair,
	vertical_blend = 1,
	y_max = -2,
	y_min = -255,
	heat_point = 60,
	humidity_point = 68,
})

minetest.register_biome({
	name = "bm_forest_under",
	node_cave_liquid = {"water:source",  other_cave_liquid},
	node_dungeon = "stone:cobble",
	node_dungeon_alt = dungeon_alt,
	node_dungeon_stair = dungeon_stair,
	y_max = -256,
	y_min = -31000,
	heat_point = 60,
	humidity_point = 68,
})

if (minetest.get_modpath("apple") ~= nil) then
	apple.add_to_biome("bm_forest")
	apple.add_log_to_biome("bm_forest")
end

if (minetest.get_modpath("aspen") ~= nil) then
	aspen.add_to_biome("bm_forest")
	aspen.add_log_to_biome("bm_forest")
end

if (minetest.get_modpath("mushroom") ~= nil) then
	mushroom.add_all_to_biome("bm_forest")
end

if (minetest.get_modpath("papyrus") ~= nil) then
	papyrus.add_to_biome_on_dirt("bm_forest_shore")
end
