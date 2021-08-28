
local S = minetest.get_translator("pine")

minetest.register_node("pine:tree", {
	description = S("Pine Tree"),
	tiles = {"pine_tree_top.png", "pine_tree_top.png",
		"pine_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = wood.sounds,

	on_place = minetest.rotate_node
})

minetest.register_node("pine:wood", {
	description = S("Pine Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"pine_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = wood.sounds,
})

minetest.register_node("pine:needles",{
	description = S("Pine Needles"),
	drawtype = "allfaces_optional",
	tiles = {"pine_needles.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"pine:sapling"}, rarity = 20},
			{items = {"pine:needles"}}
		}
	},
	sounds = wood.leaves_sounds,
	after_place_node = wood.after_place_leaves,
})


wood.register_leafdecay({
	trunks = {"pine:tree"},
	leaves = {"pine:needles"},
	radius = 3,
})

minetest.register_craft({
    output = "pine:wood 4",
    recipe = {
        {"pine:tree"},
    }
})
