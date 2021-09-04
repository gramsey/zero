local S = minetest.get_translator("aspen");

local function start_timer(pos)
	minetest.get_node_timer(pos):start(math.random(300, 1500))
end

function aspen.grow_aspen_sapling(pos) 

	if not wood.check_grow_tree(pos) then
		start_timer(pos)
		return
	end

    local tree_schema = minetest.get_modpath("aspen") .. "/schematics/aspen_tree_from_sapling.mts"
    minetest.place_schematic({x=pos.x-4, y=pos.y-1, z=pos.z-4}, tree_schema, "random", nil, false)
end

minetest.register_node("aspen:sapling", {
	description = S("Aspen Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"aspen_sapling.png"},
    inventory_image = "aspen_sapling.png",
    wield_image = "aspen_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = aspen.grow_aspen_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
	},
    groups = {snappy = 2, dig_immediate = 3, flammable = 3,
        attached_node = 1, sapling = 1},
    sounds = wood.leaves_sounds,

    on_construct = start_timer,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = wood.sapling_on_place(itemstack, placer, pointed_thing,
            "aspen:sapling",
            -- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 12, z = 2},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

minetest.register_lbm({
    name = "aspen:convert_saplings_to_aspen_tree",
    nodenames = {"aspen:sapling"},
    action = start_timer,
})

