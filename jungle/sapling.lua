local S = minetest.get_translator("jungle");

local function start_timer(pos)
	minetest.get_node_timer(pos):start(math.random(300, 1500))
end

function jungle.grow_jungle_sapling(pos) 

	minetest.debug("grow jungle sapling")
	if not wood.check_grow_tree(pos) then
		start_timer(pos)
		return
	end

	minetest.debug("grow jungle sapling")
    local tree_schema = minetest.get_modpath("jungle") .. "/schematics/jungle_tree_from_sapling.mts"
    minetest.place_schematic({x=pos.x-4, y=pos.y-1, z=pos.z-4}, tree_schema, "random", nil, false)
end

minetest.register_node("jungle:sapling", {
    description = S("Jungle Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"jungle_sapling.png"},
    inventory_image = "jungle_sapling.png",
    wield_image = "jungle_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = jungle.grow_jungle_sapling,
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
            "jungle:sapling",
            -- minp_relative.y = 1 because sapling pos has been checked
            {x = -3, y = 1, z = -3},
            {x = 3, y = 6, z = 3},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

minetest.register_lbm({
    name = "jungle:grow_sapling",
    nodenames = {"jungle:sapling"},
    action = start_timer,
})

