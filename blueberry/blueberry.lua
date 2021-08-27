
local S = minetest.get_translator("blueberry");

minetest.register_node("blueberry:bush_leaves_with_berries", {
	description = S("Blueberry Bush Leaves with Berries"),
	drawtype = "allfaces_optional",
	tiles = {"blueberry_bush_leaves.png^blueberry_overlay.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1, dig_immediate = 3},
	drop = "blueberry:blueberry",
	sounds = wood.leaves_sounds,
	node_dig_prediction = "blueberry:bush_leaves",

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blueberry:bush_leaves"})
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
})

minetest.register_node("blueberry:bush_leaves", {
	description = S("Blueberry Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"blueberry_bush_leaves.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blueberry:bush_sapling"}, rarity = 5},
			{items = {"blueberry:bush_leaves"}}
		}
	},
	sounds = wood.leaves_sounds,

	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "blueberry:bush_leaves_with_berries"})
		end
	end,

    after_place_node = wood.after_place_leaves,
})

minetest.register_craftitem("blueberry:blueberry", {
	description = S("Blueberries"),
	inventory_image = "blueberry.png",
	groups = {food_blueberries = 1, food_berry = 1},
	on_use = minetest.item_eat(2),
})
