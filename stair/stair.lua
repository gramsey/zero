
local S = minetest.get_translator("stair")

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end


local recipe_desc
local function prepare_def(def)

	local defaults = {
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		node_box = {
			type = "fixed",
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			minetest.debug("rotate and place")
			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	}

	local new_def = table.copy(defaults)
	for k, v in pairs(def) do new_def[k] = v end


	recipe_desc = nil
	if def.recipeitem then
		node_def = minetest.registered_nodes[def.recipeitem]

		if not def.description then
			recipe_desc = node_def.description:gsub(" Planks","")
		end
		new_def.tiles = def.tiles or node_def.tiles
		new_def.groups = def.groups or node_def.groups
		new_def.sounds = def.sounds or node_def.sounds
	end
	return new_def
end

function stair.register_all(prefix, def)
	stair.register_stair(prefix, def)
	stair.register_inner(prefix, def)
	stair.register_outer(prefix, def)
	stair.register_slab(prefix, def)
end

function stair.register_stair(prefix, def)
	def = prepare_def(def)	

	if recipe_desc then
		def.description = S("@1 Stair", recipe_desc)
	end

	def.node_box.fixed = def.node_box.fixed or {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
	}

	local stair_name = prefix.."stair"

	if def.recipeitem then
		local item = def.recipeitem
		def.recipeitem = nil

		-- Craft
		minetest.register_craft({
			output = stair_name.." 8",
			recipe = {
				{"",	"",		item},
				{"",	item,	item},
				{item,	item,	item},
			},
		})

		-- Reverse craft
		minetest.register_craft({
			output = item.." 3",
			recipe = {
				{stair_name, stair_name},
				{stair_name, stair_name},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {item}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = stair_name,
				burntime = math.floor(baseburntime * 0.75),
			})
		end
	end

	minetest.register_node(stair_name, def)
end

function stair.register_inner(prefix, def)
	def = prepare_def(def)	

	if recipe_desc then
		def.description = S("Inner @1 Stair", recipe_desc)
	end

	def.node_box.fixed = def.node_box.fixed or {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
		{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
	}

	local stair_name = prefix.."stair_inner"

	if def.recipeitem then
		local item = def.recipeitem
		def.recipeitem = nil

		-- Craft
		minetest.register_craft({
			output = stair_name.." 7",
			recipe = {
				{"",	item,	""},
				{item,	"",		item},
				{item,	item,	item},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {item}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = stair_name,
				burntime = math.floor(baseburntime * 0.75),
			})
		end
	end

	minetest.register_node(stair_name, def)
end


function stair.register_outer(prefix, def)
	def = prepare_def(def)	

	if recipe_desc then
		def.description = S("Outer @1 Stair", recipe_desc)
	end

	def.node_box.fixed = def.node_box.fixed or {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
	}

	local stair_name = prefix.."stair_outer"

	if def.recipeitem then
		local item = def.recipeitem
		def.recipeitem = nil

		-- Craft
		minetest.register_craft({
			output = stair_name.." 6",
			recipe = {
				{"",	"",		""},
				{"",	item,	""},
				{item,	item,	item},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {item}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = stair_name,
				burntime = math.floor(baseburntime * 0.625),
			})
		end
	end

	minetest.register_node(stair_name, def)
end

function stair.register_slab(prefix, def)
	def = prepare_def(def)	

	if recipe_desc then
		def.description = S("@1 Slab", recipe_desc)
	end

	def.node_box.fixed = def.node_box.fixed or {-0.5, -0.5, -0.5, 0.5, 0, 0.5}

	local slab_name = prefix.."slab"

	if def.recipeitem then
		local item = def.recipeitem
		def.recipeitem = nil

		-- Craft
		minetest.register_craft({
			output = slab_name.." 6",
			recipe = {
				{item,	item,	item},
			},
		})

		-- Reverse Craft
		minetest.register_craft({
			output = item,
			recipe = {
				{slab_name},
				{slab_name},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {item}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = slab_name,
				burntime = math.floor(baseburntime * 0.5),
			})
		end
	end

	minetest.register_node(slab_name, def)
end
