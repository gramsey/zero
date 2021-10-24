local S = minetest.get_translator("furnace")

-- FORMSPECS
local active_formspec = "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;furnace_fire_bg.png^[lowpart:"..
		"%d".. --(fuel_percent)
		":furnace_fire_fg.png]"..
		"image[3.75,1.5;1,1;furnace_gui_arrow_bg.png^[lowpart:"..
		"%d".. --(item_percent)
		":furnace_gui_arrow_fg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;fuel]"..
		"listring[current_player;main]"

local inactive_formspec = "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;furnace_fire_bg.png]"..
		"image[3.75,1.5;1,1;furnace_gui_arrow_bg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;fuel]"..
		"listring[current_player;main]"

local pipeworks_formspec = minetest.get_modpath("pipeworks") and function(meta)
	formspec = pipeworks.fs_helpers.cycling_button(
			meta,
			"image_button[0,3.5;1,0.6",
			"split_material_stacks",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		)..
		"label[0.9,3.51;"..
		S("Allow splitting incoming material (not fuel) stacks from tubes").."]"
	return  formspec
end

function furnace.get_active_formspec(fuel_percent, item_percent, pos, meta)
	local formspec = active_formspec:format(fuel_percent, item_percent)
	
	if (minetest.get_modpath("pipeworks") ~= nil) then
		return formspec .. pipeworks_formspec(meta)
	else
		return formspec
	end
end

function furnace.get_inactive_formspec(pos, meta)
	if (minetest.get_modpath("pipeworks") ~= nil) then
		return inactive_formspec .. pipeworks_formspec(meta)
	else
		return inactive_formspec
	end
end

--
-- Node callback functions that are the same for active and inactive furnace
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

local function get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", S("Furnace is empty"))
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function furnace_node_timer(pos, elapsed)
	--
	-- Initialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local cookable, cooked
	local fuel

	local update = true
	while elapsed > 0 and update do
		update = false

		srclist = inv:get_list("src")
		fuellist = inv:get_list("fuel")

		--
		-- Cooking
		--

		-- Check if we have cookable content
		local aftercooked
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		cookable = cooked.time ~= 0

		local el = math.min(elapsed, fuel_totaltime - fuel_time)
		if cookable then -- fuel lasts long enough, adjust el to cooking duration
			el = math.min(el, cooked.time - src_time)
		end

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + el
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + el
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)
						inv:set_stack("src", 1, aftercooked.items[1])
						src_time = src_time - cooked.time
						update = true
					else
						dst_full = true
					end
					-- Play cooling sound
					minetest.sound_play(fire.sound.extinguish,
						{pos = pos, max_hear_distance = 16, gain = 0.1}, true)
				else
					-- Item could not be cooked: probably missing fuel
					update = true
				end
			end
		else
			-- Furnace ran out of fuel
			if cookable then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- Take fuel from fuel list
					inv:set_stack("fuel", 1, afterfuel.items[1])
					-- Put replacements in dst list or drop them on the furnace.
					local replacements = fuel.replacements
					if replacements[1] then
						local leftover = inv:add_item("dst", replacements[1])
						if not leftover:is_empty() then
							local above = vector.new(pos.x, pos.y + 1, pos.z)
							local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above
							minetest.item_drop(replacements[1], nil, drop_pos)
						end
					end
					update = true
					fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = elapsed - el
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end
	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		if dst_full then
			item_state = S("100% (output full)")
		else
			item_state = S("@1%", item_percent)
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = S("Not cookable")
		else
			item_state = S("Empty")
		end
	end

	local fuel_state = S("Empty")
	local active = false
	local result = false

	if fuel_totaltime ~= 0 then
		active = true
		local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = S("@1%", fuel_percent)
		formspec = furnace.get_active_formspec(fuel_percent, item_percent, pos, meta)
		swap_node(pos, "furnace:furnace_active")
		-- make sure timer restarts automatically
		result = true

		-- Play sound every 5 seconds while the furnace is active
		if timer_elapsed == 0 or (timer_elapsed+1) % 5 == 0 then
			minetest.sound_play("furnace_active",
				{pos = pos, max_hear_distance = 16, gain = 0.5}, true)
		end
	else
		if fuellist and not fuellist[1]:is_empty() then
			fuel_state = S("@1%", 0)
		end
		formspec = furnace.get_inactive_formspec(pos, meta)
		swap_node(pos, "furnace:furnace")
		-- stop timer on the inactive furnace
		minetest.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)
	end


	local infotext
	if active then
		infotext = S("Furnace active")
	else
		infotext = S("Furnace inactive")
	end
	infotext = infotext .. "\n" .. S("(Item: @1; Fuel: @2)", item_state, fuel_state)


	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

--
-- Node definitions
--


local furnace_def = {
	description = S("Furnace"),
	tiles = {
		"furnace_top.png", "furnace_bottom.png",
		"furnace_side.png", "furnace_side.png",
		"furnace_side.png", "furnace_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = stone.sounds,

	can_dig = can_dig,

	on_timer = furnace_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('fuel', 1)
		inv:set_size('dst', 4)
		furnace_node_timer(pos, 0)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether furnace can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_take = function(pos)
		-- check whether the furnace is empty or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		get_inventory_drops(pos, "src", drops)
		get_inventory_drops(pos, "fuel", drops)
		get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "furnace:furnace"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
}

-- override fields for active furnace
local furnace_active_def = {
	drop = "furnace:furnace",
	tiles = {
		"furnace_top.png", "furnace_bottom.png",
		"furnace_side.png", "furnace_side.png",
		"furnace_side.png",
		{
			image = "furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
}

-- override fields for pipeworks
if (minetest.get_modpath("pipeworks") ~= nil) then
	local pipeworks_furnace_def = {
		groups = {cracky=2, tubedevice = 1, tubedevice_receiver = 1},
		tube = {
			insert_object = function(pos,node,stack,direction)
				minetest.debug("insert")
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local timer = minetest.get_node_timer(pos)
				if not timer:is_started() then
					timer:start(1.0)
				end
				if direction.y == 1 then
					return inv:add_item("fuel", stack)
				else
					return inv:add_item("src", stack)
				end
			end,
			can_insert = function(pos, node, stack, direction)
				minetest.debug("can insert")
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				minetest.debug("inv ".. dump(inv))
				if direction.y == 1 then
					return inv:room_for_item("fuel", stack)
				else
					if meta:get_int("split_material_stacks") == 1 then
						minetest.debug("split ")
						stack = stack:peek_item(1)
					end
					minetest.debug("room_for_item".. dump(inv:room_for_item("src", stack)))
					return inv:room_for_item("src", stack)
				end
			end,
			input_inventory = "dst",
			connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
		},
		on_receive_fields = function(pos, formname, fields, sender)
			if not pipeworks.may_configure(pos, sender) then return end
			pipeworks.fs_helpers.on_receive_fields(pos, fields)
			local meta = minetest.get_meta(pos)
			local formspec = furnace.get_active_formspec(0, 0, pos, meta)
			meta:set_string("formspec", formspec)
		end,
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig,
		on_rotate = pipeworks.on_rotate
	}


	for k, v in pairs(pipeworks_furnace_def) do 
		furnace_def[k] = v
	end
end

minetest.register_node("furnace:furnace", furnace_def)

local active_def = table.copy(furnace_def)
for k, v in pairs(furnace_active_def) do
	active_def[k] = v
end
	
minetest.register_node("furnace:furnace_active", active_def)

minetest.register_craft({
	output = "furnace:furnace",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", "", "group:stone"},
		{"group:stone", "group:stone", "group:stone"},
	}
})
