local S = minetest.get_translator("wood");

wood.sounds = {
	footstep = {name = "wood_footstep", gain = 0.3},
	dig = {name = "wood_dig", gain = 0.5},
	dug = {name = "wood_dug", gain = 1.0},
	place = {name = "wood_place", gain = 0.5},
}

minetest.register_craftitem("wood:stick", {
    description = S("Stick"),
    inventory_image = "stick.png",
    groups = {stick = 1, flammable = 2}, 
})

minetest.register_craft({
    output = "wood:stick 4",
    recipe = {
        {"group:wood"},
    }
})

minetest.register_craft({
    type = "fuel",
    recipe = "group:wood",
    burntime = 7,
})

minetest.register_node("wood:ladder", {
	description = S("Wooden Ladder"),
	drawtype = "signlike",
	tiles = {"wood_ladder.png"},
	inventory_image = "wood_ladder.png",
	wield_image = "wood_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = wood.sounds,
})

minetest.register_craft({
	output = "wood:ladder 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "wood:ladder",
	burntime = 7,
})

