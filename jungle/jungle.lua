
local S = minetest.get_translator("jungle")

minetest.register_node("jungle:tree", {
	description = S("Jungle Tree"),
	tiles = {"jungle_tree_top.png", "jungle_tree_top.png",
		"jungle_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = wood.sounds,

	on_place = minetest.rotate_node
})

minetest.register_node("jungle:wood", {
	description = S("Jungle Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"jungle_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = wood.sounds,
})

minetest.register_node("jungle:leaves", {
	description = S("Jungle Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"jungle_leaves.png"},
	special_tiles = {"jungle_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"jungle:sapling"}, rarity = 20},
			{items = {"jungle:leaves"}}
		}
	},
	sounds = wood.leaves_sounds,

	after_place_node = wood.after_place_leaves,
})

wood.register_leafdecay({
	trunks = {"jungle:tree"},
	leaves = {"jungle:leaves"},
	radius = 2,
})

minetest.register_craft({
    output = "jungle:wood 4",
    recipe = {
        {"jungle:tree"},
    }
})
