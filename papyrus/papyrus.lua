
local S = minetest.get_translator("papyrus")

minetest.register_node("papyrus:papyrus", {
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"papyrus.png"},
	inventory_image = "papyrus.png",
	wield_image = "papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2, oddly_breakable_by_hand = 3},
	sounds = dirt.sounds,

	after_dig_node = function(pos, node, metadata, digger)
		if digger == nil then return end
		local np = {x = pos.x, y = pos.y + 1, z = pos.z}
		local nn = minetest.get_node(np)
		if nn.name == node.name then
			minetest.node_dig(np, nn, digger)
		end
	end,
})

function papyrus.add_to_biome_on_dirt(biome) 
	minetest.register_decoration({
		name = biome..":papyrus_on_dirt",
		deco_type = "schematic",
		place_on = {"dirt:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {biome},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("papyrus") .. 
			"/schematics/papyrus_on_dirt.mts",
	})
end

function papyrus.add_to_biome_on_dry_dirt(biome)
	minetest.register_decoration({
		name = "papyrus:papyrus_on_dry_dirt",
		deco_type = "schematic",
		place_on = {"dirt:dry"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {biome},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("papyrus") ..
			"/schematics/papyrus_on_dry_dirt.mts",
	})
end

function papyrus.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	if minetest.get_item_group(name, "soil") == 0 then return end

	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "papyrus:papyrus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "papyrus:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"papyrus:papyrus"},
	neighbors = {"group:soil"},
	interval = 14,
	chance = 71,
	action = papyrus.grow_papyrus,
})


minetest.register_craft({
	type = "fuel",
	recipe = "papyrus:papyrus",
	burntime = 3,
})
