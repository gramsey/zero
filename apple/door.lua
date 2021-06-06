
local S = minetest.get_translator("apple");

-- DOOR
door.register("apple:door", {
	tiles = {"apple_door.png"},
	description = S("Wooden Door"),
})

-- GATE
door.register_gate("apple:gate", {
	description = S("Apple Wood Fence Gate"),
	texture = "apple_wood.png",
	recipeitem = "apple:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- TRAPDOOR
door.register_trapdoor("apple:trapdoor", {
	description = S("Wooden Trapdoor"),
	inventory_image = "apple_trapdoor.png",
	wield_image = "apple_trapdoor.png",
	tile_front = "apple_trapdoor.png",
	tile_side = "apple_trapdoor_side.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
})
