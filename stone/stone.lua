
local S = minetest.get_translator("stone")

stone.sounds = {
    footstep = {name = "stone_footstep", gain = 0.3},
    dig = {name = "stone_dig", gain = 0.5},
    dug = {name = "stone_footstep", gain = 1.0},
    place = {name = "stone_place", gain = 1.0},
}

-- STONE
minetest.register_node("stone:stone", {
    description = S("Stone"),
    tiles = {"stone.png"},
    groups = {cracky = 3, stone = 1},
    drop = "stone:cobble",
    legacy_mineral = true,
    sounds = stone.sounds,
})

-- COBBLE 
minetest.register_node("stone:cobble", {
    description = S("Cobblestone"),
    tiles = {"stone_cobble.png"},
    is_ground_content = false,
    groups = {cracky = 3, stone = 2, blast_loss = 3},
    sounds = stone.sounds,
})

minetest.register_craft({
	type = "cooking",
	output = "stone:stone",
	recipe = "stone:cobble",
})

-- MOSSY COBBLE
minetest.register_node("stone:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"stone_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = stone.sounds,
})

minetest.register_craft({
	type = "cooking",
	output = "stone:stone",
	recipe = "stone:mossycobble",
})

-- STONE BRICK
minetest.register_node("stone:brick", {
	description = S("Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone.sounds,
})

minetest.register_craft({
	output = "stone:brick 4",
	recipe = {
		{"stone:stone", "stone:stone"},
		{"stone:stone", "stone:stone"},
	}
})

