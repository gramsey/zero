flower.sounds = dirt.sounds

local defaults = {
	drawtype = "plantlike",
	waving = 1,
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, 
		flamable = 1, spread_above_dirt = 1, oddly_breakable_by_hand = 3},
	sounds = flower.sounds,
	selection_box = {
		type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
	} 
}


flower.rarity = {
	very_rare = -0.06,
	rare = -0.05,
	uncommon = -0.04,
	common = -0.03,
	very_common = -0.02,
}



function flower.register(name, def) 
	local def_table = table.copy(defaults)

	for k, v in pairs(def) do 
		def_table[k] = v 
	end

	if def.color then
		def_table.groups["color_"..def.color] = 1
		def_table.color = nil
	end

	minetest.register_node(name, def_table)
end

function flower.add_to_biome(name, biome, rarity)
	local short_name = name:gsub("^.*:","")

	-- use (crude) hash of name as seed
	local seed = 0
	for i = 1, #short_name do
		seed = seed + short_name:byte(i)
	end

	minetest.debug("adding", biome, ":",  short_name, " for ", name, " seed ", seed, " rarity ", rarity)

	minetest.register_decoration({
		name = biome..":"..short_name,
		deco_type = "simple",
		place_on = {"dirt:grass"},
		sidelen = 16,
		noise_params = {
			offset = rarity or -0.03,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = seed,
			octaves = 3,
			persist = 0.6
		},
		biomes = {biome},
		y_max = 31000,
		y_min = 1,
		decoration = name,
	})
end
