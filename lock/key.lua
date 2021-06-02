local S = minetest.get_translator("lock")

local function cut_key(itemstack, user, pointed_thing)

	-- check target, sort out secret, create new if needed
	if pointed_thing.type ~= "node" then return itemstack end
	local node = minetest.get_node(pointed_thing.under)
	if not node then return itemstack end

	local def = minetest.registered_nodes[node.name]
	local meta = minetest.get_meta(pointed_thing.under)

	if not def and meta then return itemstack end
	if not def.lock_enabled == true then return itemstack end

	local secret = meta:get_string("lock_secret")
	local owner = meta:get_string("owner")

	-- only the person who placed it can lock it
	if user:get_player_name() ~= owner then return itemstack end

	if not secret or secret == "" then
		local rng = math.random
		secret = string.format( "%04x%04x%04x%04x", 
			rng(2^16) - 1, rng(2^16) - 1, rng(2^16) - 1, rng(2^16) - 1)
		meta:set_string("lock_secret", secret)
	end

	-- remove blank key
	itemstack:take_item()

	-- create new key using node's secret
	local new_key = ItemStack("lock:key")
	local key_meta = new_key:get_meta()
	key_meta:set_string("key_secret", secret)
	key_meta:set_string("description", S("Key to @1's @2", owner, def.description))
	meta:set_string("infotext", S("Locked @1 (owned by @2)", def.description, owner))

	-- if only one key in hand, replace it, otherwise put new key in main inventory
	if itemstack:get_count() == 0 then
		itemstack = new_key
	else
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		if inv:add_item("main", new_key):get_count() > 0 then
			minetest.add_item(user:get_pos(), new_key)
		end 
	end

	return itemstack
end

-- blank key (was called skeleton key in mtg)
minetest.register_craftitem("lock:blank_key", {
    description = S("Blank Key"),
    inventory_image = "lock_blank_key.png",
    on_use = cut_key
})

minetest.register_craft({
    output = "lock:blank_key",
    recipe = {
        {"gold:ingot"},
    }
})

minetest.register_craft({
    type = "cooking",
    output = "gold:ingot",
    recipe = "lock:blank_key",
    cooktime = 5,
})

-- key
minetest.register_tool("lock:key", {
    description = S("Key"),
    inventory_image = "lock_key.png",
    groups = {key = 1, not_in_creative_inventory = 1},
    stack_max = 1, 
})

minetest.register_craft({
    type = "cooking",
    output = "gold:ingot",
    recipe = "lock:key",
    cooktime = 5,
})
