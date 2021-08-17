

local S = minetest.get_translator("iron");

sign.register("iron:sign", {
	description = S("Steel Sign"), 
	tiles = {"iron_sign_wall.png"},
	inventory_image = "iron_sign.png",
	wield_image = "iron_sign.png",
	sounds = metal.sounds,
	groups = {cracky = 2, attached_node = 1},
	recipeitem = "iron:ingot",
})
