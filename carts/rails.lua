-- carts/rails.lua

-- support for MT game translation.
local S = carts.get_translator

carts:register_rail("carts:rail", {
	description = S("Rail"),
	tiles = {
		"carts_rail_straight.png", "carts_rail_curved.png",
		"carts_rail_t_junction.png", "carts_rail_crossing.png"
	},
	inventory_image = "carts_rail_straight.png",
	wield_image = "carts_rail_straight.png",
	groups = carts:get_rail_groups(),
}, {})

minetest.register_craft({
	output = "carts:rail 18",
	recipe = {
		{"iron:ingot", "group:wood", "iron:ingot"},
		{"iron:ingot", "", "iron:ingot"},
		{"iron:ingot", "group:wood", "iron:ingot"},
	}
})

carts:register_rail("carts:powerrail", {
	description = S("Powered Rail"),
	tiles = {
		"carts_rail_straight_pwr.png", "carts_rail_curved_pwr.png",
		"carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = 5})

minetest.register_craft({
	output = "carts:powerrail 18",
	recipe = {
		{"iron:ingot", "group:wood", "iron:ingot"},
		{"iron:ingot", "mese:crystal", "iron:ingot"},
		{"iron:ingot", "group:wood", "iron:ingot"},
	}
})


carts:register_rail("carts:brakerail", {
	description = S("Brake Rail"),
	tiles = {
		"carts_rail_straight_brk.png", "carts_rail_curved_brk.png",
		"carts_rail_t_junction_brk.png", "carts_rail_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = -3})

minetest.register_craft({
	output = "carts:brakerail 18",
	recipe = {
		{"iron:ingot", "group:wood", "iron:ingot"},
		{"iron:ingot", "coal:lump", "iron:ingot"},
		{"iron:ingot", "group:wood", "iron:ingot"},
	}
})
