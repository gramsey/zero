
local S = minetest.get_translator("iron");

minetest.register_node("iron:ladder", {
	description = S("Steel Ladder"),
	drawtype = "signlike",
	tiles = {"iron_ladder.png"},
	inventory_image = "iron_ladder.png",
	wield_image = "iron_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = { type = "wallmounted" },
	groups = {cracky = 2},
	sounds = metal.sounds,
})

minetest.register_craft({
	output = "iron:ladder 15",
	recipe = {
		{"iron:ingot", "", "iron:ingot"},
		{"iron:ingot", "iron:ingot", "iron:ingot"},
		{"iron:ingot", "", "iron:ingot"},
	}
})
