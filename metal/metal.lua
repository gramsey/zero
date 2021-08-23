
local S = minetest.get_translator("metal");

metal.sounds = {
    footstep = {name = "metal_footstep", gain = 0.4},
    dig = {name = "metal_dig", gain = 0.5},
    dug = {name = "metal_dug", gain = 0.5},
    place = {name = "metal_place_node", gain = 0.5},
	open = {name = "metal_door_open", gain = 0.2}, 
	close = {name = "metal_door_close",  gain = 0.2},
}

function metal.register_metal(name, o) 
	local ingot_name = name .. ":ingot"
	local block_name = name .. ":block"
	local lump_name = name .. ":lump"
	local ore_name = name .. ":ore"

	local result = {}

	if(minetest.get_modpath("stone")) ~= nil then
		if (o.ore ~= nil) then
			minetest.register_node(ore_name, {
				description = o.ore.description,
				tiles = {"stone.png^" .. o.ore.png},
				groups = o.ore.groups or {cracky = 2},
				drop = lump_name,
				sounds = stone.sounds,
			})
			result.ore = ore_name
		end
	end

	if (o.lump ~= nil) then
		minetest.register_craftitem(lump_name, {
			description = o.lump.description,
			inventory_image = o.lump.png, 
		})
		result.lump = lump_name
	end

	if (o.block ~= nil) then
		minetest.register_node(block_name, {
			description = o.block.description,
			tiles = {o.block.png},
			is_ground_content = false,
			groups = o.block.groups or {cracky = 1, level = 2},
			sounds = o.sounds or metal.sounds,
		})
		result.block = block_name
	end

	if (o.ingot ~= nil) then
		minetest.register_craftitem(ingot_name, {
			description = o.ingot.description,
			inventory_image = o.ingot.png,
		})
		result.ingot = ingot_name
	end

	-- crafting
	if (o.ingot ~= nil and o.block ~= nil) then
		minetest.register_craft({
			output = ingot_name .. " 9",
			recipe = {
				{block_name},
			}
		})
	end

	if (o.ingot ~= nil and o.block ~= nil) then
		minetest.register_craft({
			type = "cooking",
			output = ingot_name,
			recipe = lump_name,
		})
		minetest.register_craft({
			output = block_name,
			recipe = {
				{ingot_name, ingot_name, ingot_name},
				{ingot_name, ingot_name, ingot_name},
				{ingot_name, ingot_name, ingot_name},
			}
		})
	end

	return result
end


