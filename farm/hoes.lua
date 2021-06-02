-- support for MT game translation.
local S = minetest.get_translator("farm")

farm.register_hoe(":farm:hoe_wood", {
	description = S("Wooden Hoe"),
	inventory_image = "farm_tool_woodhoe.png",
	max_uses = 30,
	material = "group:wood",
	groups = {hoe = 1, flammable = 2},
})

farm.register_hoe(":farm:hoe_stone", {
	description = S("Stone Hoe"),
	inventory_image = "farm_tool_stonehoe.png",
	max_uses = 90,
	material = "group:stone",
	groups = {hoe = 1}
})

farm.register_hoe(":farm:hoe_steel", {
	description = S("Steel Hoe"),
	inventory_image = "farm_tool_steelhoe.png",
	max_uses = 500,
	material = "iron:ingot",
	groups = {hoe = 1}
})

