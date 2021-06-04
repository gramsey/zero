
local S = minetest.get_translator("aspen")

minetest.register_node("aspen:tree", {
	description = S("Aspen Tree"),
	tiles = {"aspen_tree_top.png", "aspen_tree_top.png", "aspen_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = wood.sounds,
	on_place = minetest.rotate_node
})

minetest.register_node("aspen:wood", {
	description = S("Aspen Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"aspen_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = wood.sounds,
})

minetest.register_node("aspen:leaves", {
	description = S("Acacia Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"aspen_leaves.png"},
--	special_tiles = {"aspen_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"aspen:sapling"}, rarity = 20},
			{items = {"aspen:leaves"}}
		}
	},
	sounds = wood.leaves_sounds,
	after_place_node = wood.after_place_leaves,
})

wood.register_leafdecay({
	trunks = {"aspen:tree"},
	leaves = {"aspen:leaves"},
	radius = 3,
})
