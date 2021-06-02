
local S = minetest.get_translator("acacia")

minetest.register_node("acacia:tree", {
	description = S("Acacia Tree"),
	tiles = {"acacia_tree_top.png", "acacia_tree_top.png",
		"acacia_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = wood.sounds,

	on_place = minetest.rotate_node
})

minetest.register_node("acacia:wood", {
	description = S("Acacia Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"acacia_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	jounds = wood.sounds,
})

minetest.register_node("acacia:leaves", {
	description = S("Acacia Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"acacia_leaves.png"},
	special_tiles = {"acacia_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"acacia:sapling"}, rarity = 20},
			{items = {"acacia:leaves"}}
		}
	},
	sounds = wood.leaves_sounds,

	after_place_node = wood.after_place_leaves,
})

wood.register_leafdecay({
	trunks = {"acacia:tree"},
	leaves = {"acacia:leaves"},
	radius = 2,
})
