
local S = minetest.get_translator("apple");

minetest.register_node("apple:bush_stem", {
	description = S("Bush Stem"),
	drawtype = "plantlike",
	visual_scale = 1.41,
	tiles = {"apple_bush_stem.png"},
	inventory_image = "apple_bush_stem.png",
	wield_image = "apple_bush_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = wood.sounds,
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
	},
})

minetest.register_node("apple:bush_leaves", {
	description = S("Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"apple_leaves_simple.png"},
	paramtype = "light",
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, oddly_breakable_by_hand=3},
	drop = {
		max_items = 1,
		items = {
			{items = {"apple:bush_sapling"}, rarity = 5},
			{items = {"apple:bush_leaves"}}
		}
	},
	sounds = wood.leaves_sounds,

	after_place_node = after_place_leaves,
})
