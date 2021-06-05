
local S = minetest.get_translator("snow")

snow.sounds = {
	footstep = {name = "snow_footstep", gain = 0.2},
	dig = {name = "snow_footstep", gain = 0.3},
	dug = {name = "snow_footstep", gain = 0.3},
	place = {name = "snow_place", gain = 1},
}

minetest.register_node("snow:snow", {
	description = S("Snow"),
	tiles = {"snow.png"},
	inventory_image = "snow_ball.png",
	wield_image = "snow_ball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = snow.sounds,

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "dirt:grass" then
			minetest.set_node(pos, {name = "dirt:snow"})
		end
	end,
})

minetest.register_node("snow:block", {
	description = S("Snow Block"),
	tiles = {"snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = snow.sounds,

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "dirt:grass" then
			minetest.set_node(pos, {name = "dirt:snow"})
		end
	end,
})

function snow.add_to_biome(biome, def)
	local snow_def =  {
		name = biome..":patchy_snow",
		deco_type = "simple",
		place_on = {
			"snow:permafrost_with_moss",
			"snow:permafrost_with_stones",
			"group:stone",
			"group:soil",
			"gravel:gravel"
		},
		sidelen = 4,
		noise_params = {
			offset = 0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 172555,
			octaves = 3,
			persist = 1.0
		},
		biomes = { biome },
		y_max = 50,
		y_min = 1,
		decoration = "snow:snow",
	}

	def = def or {}
	for k, v in pairs(def) do 
		snow_def[k] = v 
	end

	minetest.register_decoration(snow_def)

end

