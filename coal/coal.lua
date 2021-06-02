
local S = minetest.get_translator("coal");

-- coal
minetest.register_node("coal:stone_with_coal", {
	description = S("Coal Ore"),
	tiles = {"stone.png^coal_mineral.png"},
	groups = {cracky = 3},
	drop = "coal:lump",
	sounds = stone.sounds,
})
minetest.register_node("coal:block", {
	description = S("Coal Block"),
	tiles = {"coal_block.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = stone.sounds,
})

minetest.register_craftitem("coal:lump", {
	description = S("Coal Lump"),
	inventory_image = "coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craft({
	output = "coal:lump 9",
	recipe = {
		{"coal:block"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "coal:lump",
	burntime = 40,
})

-- dye (if available)
if(minetest.get_modpath("dye")) ~= nil then

	minetest.register_craft({
		output = "dye:black 4",
		recipe = {
			{"group:coal"}
		},
	})
end

-- ore
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "coal:stone_with_coal",
	wherein        = "mapgen_stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "coal:stone_with_coal",
	wherein        = "mapgen_stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_max          = 64,
	y_min          = -127,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "coal:stone_with_coal",
	wherein        = "mapgen_stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 30,
	clust_size     = 5,
	y_max          = -128,
	y_min          = -31000,
})
