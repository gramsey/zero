local S = minetest.get_translator("apple");

function apple.grow_apple_bush_sapling(pos) 
	if not wood.check_grow_tree(pos) then
        minetest.get_node_timer(pos):start(math.random(300, 1500))
		return
	end

    local tree_schema = minetest.get_modpath("apple") .. "/schematics/apple_bush.mts"
    minetest.place_schematic({x=pos.x-1, y=pos.y-1, z=pos.z-1}, tree_schema, "0", nil, false)
end

minetest.register_node("apple:bush_sapling", {
	description = S("Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"apple_bush_sapling.png"},
	inventory_image = "apple_bush_sapling.png",
	wield_image = "apple_bush_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
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
			"apple:bush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})


minetest.register_lbm({
    name = "apple:convert_saplings_to_apple_bush",
    nodenames = {"apple:bush_sapling"},
    action = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end
})


