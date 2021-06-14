
local S = minetest.get_translator("glass")

glass.sounds = {
	footstep = {name = "glass_footstep", gain = 0.3},
    dig = {name = "glass_footstep", gain = 0.5},
    dug = {name = "glass_break", gain = 1.0},
    place = {name = "glass_footstep", gain = 1.0},
}

minetest.register_node("glass:glass", {
    description = S("Glass"),
    drawtype = "glasslike_framed_optional",
    tiles = {"glass.png", "glass_detail.png"},
    use_texture_alpha = "clip", -- only needed for stairs API
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    sunlight_propagates = true,
    is_ground_content = false,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    sounds = glass.sounds,
})

minetest.register_craft({
    type = "cooking",
    output = "glass:glass",
    recipe = "group:sand",
})

minetest.register_craftitem("glass:fragments", {
	description = S("Glass Fragments"),
	inventory_image = "glass_fragments.png",
})

minetest.register_craft({
	type = "cooking",
	output = "glass:glass",
	recipe = "glass:fragments",
})

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		name = "glass:fragments", chance = 0.35, count = {1, 4}
	})
end
