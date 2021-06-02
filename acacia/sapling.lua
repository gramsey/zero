local S = minetest.get_translator("acacia");

local function start_timer(pos)
	minetest.get_node_timer(pos):start(math.random(300, 1500))
end

function acacia.grow_acacia_sapling(pos) 

	minetest.debug("grow acacia sapling")
	if not wood.check_grow_tree(pos) then
		start_timer(pos)
		return
	end

	minetest.debug("grow acacia sapling")
    local tree_schema = minetest.get_modpath("acacia") .. "/schematics/acacia_tree_from_sapling.mts"
    minetest.place_schematic({x=pos.x-4, y=pos.y-1, z=pos.z-4}, tree_schema, "random", nil, false)
end

minetest.register_node("acacia:sapling", {
    description = S("Apple Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"acacia_sapling.png"},
    inventory_image = "acacia_sapling.png",
    wield_image = "acacia_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = acacia.grow_acacia_sapling,
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 2,
        attached_node = 1, sapling = 1},
    sounds = wood.leaves_sounds,

    on_construct = start_timer,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = wood.sapling_on_place(itemstack, placer, pointed_thing,
            "acacia:sapling",
            -- minp_relative.y = 1 because sapling pos has been checked
            {x = -3, y = 1, z = -3},
            {x = 3, y = 6, z = 3},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

minetest.register_lbm({
    name = "acacia:convert_saplings_to_acacia_tree",
    nodenames = {"acacia:sapling"},
    action = start_timer,
})

