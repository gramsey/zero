local S = minetest.get_translator("wood");

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

wood.sounds = {
	footstep = {name = "wood_footstep", gain = 0.3},
	dig = {name = "wood_dig", gain = 0.5},
	dug = {name = "wood_dug", gain = 1.0},
	place = {name = "wood_place", gain = 0.5},
}
