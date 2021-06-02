
local S = minetest.get_translator("dirt")
dirt.sounds = {};

-- DIRT
dirt.sounds = {
	footstep = {name = "dirt_footstep", gain = 0.4},
	dig = {name = "dirt_dig", gain = 1.0},
	dug = {name = "dirt_footstep", gain = 1.0},
  	place = {name = "dirt_place", gain = 1.0},
}

minetest.register_node("dirt:dirt", {
    description = S("Dirt"),
    tiles = {"dirt.png"},
    groups = {crumbly = 3, soil = 1, oddly_breakable_by_hand=2, blast_loss = 4},
    sounds = dirt.sounds,
})


minetest.register_node("dirt:dry", {
	description = S("Dry Dirt"),
	tiles = {"dirt_dry.png"},
	groups = {crumbly = 3, soil = 1, oddly_breakable_by_hand=2, blast_loss = 4},
	sounds = dirt.sounds,
})

