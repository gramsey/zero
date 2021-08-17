
local S = minetest.get_translator("wood");

sign.register("wood:sign", {
	description = S("Wooden Sign"), 
	tiles = {"wood_sign_wall.png"},
	inventory_image = "wood_sign.png",
	wield_image = "wood_sign.png",
	sounds = wood.sounds,
	groups = {choppy = 2, attached_node = 1, flammable = 2, oddly_breakable_by_hand = 3},
	recipeitem = "group:wood",
})
