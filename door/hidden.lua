local S = minetest.get_translator("door")

minetest.register_node("door:hidden", {
	description = S("Hidden PlaceHolder"),
	drawtype = "airlike",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	-- walkable prevents falling nodes breaking when they hit door
	walkable = true,
	pointable = false,
	diggable = false,
	buildable_to = false,
	floodable = false,
	groups = {not_in_creative_inventory = 1},
	on_blast = function() end,
	collision_box = {
		type = "fixed",
		fixed = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0} -- zero size: doesn't collide.
	},
})
