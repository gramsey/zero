local S = minetest.get_translator("pine");

local function start_timer(pos)
	minetest.get_node_timer(pos):start(math.random(300, 1500))
end

function pine.grow_sapling(pos) 
	if not wood.check_grow_tree(pos) then
		start_timer(pos)
		return
	end
	local schema
	if math.random() > 0.5 then
		schema = minetest.get_modpath("pine").."/schematics/pine_tree_from_sapling.mts"
	else
		schema = minetest.get_modpath("pine").."/schematics/pine_tree_small_from_sapling.mts"
	end
	minetest.place_schematic({x=pos.x-4, y=pos.y-1, z=pos.z-4}, schema, "0", nil, false) 
end

minetest.register_node("pine:sapling", {
	description = S("Pine Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"pine_sapling.png"},
	inventory_image = "pine_sapling.png",
	wield_image = "pine_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = pine.grow_sapling,
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
			"pine:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 1, z = -4},
			{x = 4, y = 7, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
