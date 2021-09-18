
local S = minetest.get_translator("apple");

-- DOOR
door.register("apple:door", {
	tiles = {{ name = "apple_door.png", backface_culling = true}},
	inventory_image = "apple_door_item.png",
	wield_image = "apple_door_item.png",
	description = S("Wooden Door"),
	material = "group:wood"   --TODO change to apple:wood when other wooden doors are implimented
})

-- GATE
door.register_gate("apple:gate", {
	description = S("Apple Wood Fence Gate"),
	texture = "apple_wood.png",
	material = "apple:wood",
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

-- TODO change to apple when other trapdoor textures are created
minetest.register_craft({
	output = "apple:trapdoor",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
