
local S = minetest.get_translator("iron");

-- DOOR
door.register("iron:door", {
		tiles = {{name = "iron_door.png", backface_culling = true}},
		description = S("Steel Door"),
		inventory_image = "iron_door_item.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = metal.sounds,
})

-- TRAPDOOR
door.register_trapdoor("iron:trapdoor", {
	description = S("Steel Trapdoor"),
	inventory_image = "iron_trapdoor.png",
	wield_image = "iron_trapdoor.png",
	tile_front = "iron_trapdoor.png",
	tile_side = "iron_trapdoor_side.png",
	protected = true,
	groups = {cracky = 1, level = 2, door = 1},
	sounds = metal.sounds,
})
