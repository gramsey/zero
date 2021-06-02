
local S = minetest.get_translator("grass")

minetest.register_node("grass:fern", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_fern_1.png"},
	inventory_image = "grass_fern_1.png",
	wield_image = "grass_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1,
		fern = 1, attached_node = 1},
	sounds = grass.sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("grass:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("grass:fern " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("grass:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"grass_fern_" .. i .. ".png"},
		inventory_image = "grass_fern_" .. i .. ".png",
		wield_image = "grass_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "grass:fern",
		sounds = grass.sounds,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end
