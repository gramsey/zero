local S = minetest.get_translator("snow")

snow.ice_sounds = {
	footstep = {name = "snow_ice_footstep", gain = 0.2},
	dig = {name = "snow_ice_dig", gain = 0.3},
	dug = {name = "snow_ice_dug", gain = 0.3},
	place = {name = "snow_ice_footstep", gain = 1},
}

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("snow:ice", {
	description = S("Ice"),
	tiles = {"snow_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = snow.ice_sounds,
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("snow:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"snow_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "snow:ice",
	sounds = snow.ice_sounds,
})

