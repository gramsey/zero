
local S = minetest.get_translator("stone")

fence.register_wall("stone:cobble_wall", {
	description = S("Cobblestone Wall"),
	texture = "stone_cobble.png",
	repcipe_item = "stone:cobble",
})

fence.register_wall("stone:mossycobble_wall", {
	description = S("Mossy Cobblestone Wall"),
	texture = "stone_mossycobble.png",
	repcipe_item = "stone:mossycobble",
})
