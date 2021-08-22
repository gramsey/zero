local S = minetest.get_translator("blueberry");

function blueberry.grow_sapling(pos) 

	if not wood.check_grow_tree(pos) then
        minetest.get_node_timer(pos):start(math.random(300, 1500))
		return
	end

    local tree_schema = minetest.get_modpath("blueberry") .. "/schematics/blueberry_tree_from_sapling.mts"
    minetest.place_schematic({x=pos.x-3, y=pos.y-1, z=pos.z-3}, tree_schema, "random", nil, false)
end

minetest.register_node("blueberry:bush_sapling", {
	description = S("Blueberry Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"blueberry_bush_sapling.png"},
	inventory_image = "blueberry_bush_sapling.png",
	wield_image = "blueberry_bush_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = blueberry.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = wood.leaves_sounds,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = wood.sapling_on_place(itemstack, placer, pointed_thing,
			"blueberry:bush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})

minetest.register_lbm({
    name = "blueberry:convert_saplings_to_blueberry_tree",
    nodenames = {"blueberry:sapling"},
    action = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end
})
