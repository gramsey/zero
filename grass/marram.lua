local S = minetest.get_translator("grass")

minetest.register_node("grass:marram", {
	description = S("Marram Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_marram_1.png"},
	inventory_image = "grass_marram_1.png",
	wield_image = "grass_marram_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1, marram = 1,
		attached_node = 1},
	sounds = dirt.grass_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("grass:marram_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("grass:marram " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("grass:marram_" .. i, {
		description = S("Marram Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"grass_marram_" .. i .. ".png"},
		inventory_image = "grass_marram_" .. i .. ".png",
		wield_image = "grass_marram_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, marram = 1, not_in_creative_inventory = 1},
		drop = "grass:marram",
		sounds = dirt.grass_sounds,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

