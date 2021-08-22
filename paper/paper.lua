
local S = minetest.get_translator("paper")

minetest.register_craftitem("paper:paper", {                                                                                                                                                                                           
    description = S("Paper"),
    inventory_image = "paper.png",
    groups = {flammable = 3},
})

minetest.register_craft({
	output = "paper:paper",
	recipe = {
		{"papyrus:papyrus", "papyrus:papyrus", "papyrus:papyrus"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "paper:paper",
	burntime = 1,
})
