
local S = minetest.get_translator("lock")

local old_is_protected = minetest.is_protected

-- things locked with a key are treated as protected (for dig etc)
function minetest.is_protected(pos, name)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node_or_nil(pos)

	local player = minetest.get_player_by_name(name)
	if player and minetest.check_player_privs(player, "protection_bypass") then
		return false
	end

	local def = nil
	if node then 
		def = minetest.registered_nodes[node.name] 
	end

	if def and def.lock_enabled then 
		local secret = meta:get_string("lock_secret") 
		if secret and secret ~= "" then 
			return true 
		end
	end

	return old_is_protected(pos, name)
end

function lock.is_locked (pos, name)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node_or_nil(pos)

	local def = nil
	if node then 
		def = minetest.registered_nodes[node.name] 
	end
	if not def or not def.lock_enabled then return false end

	local owner = meta:get_string("owner")
	local secret = meta:get_string("lock_secret")

	if not secret or secret == "" then return false end

	if secret and name == nil then return true end -- no name supplied

	if owner == name then return false end

	local player = minetest.get_player_by_name(name)
	if player == nil then return true end

	local itemstack = player:get_wielded_item()

	if  (itemstack:get_count() == 0) or 
		(itemstack:get_name() ~= "lock:key") then

		minetest.record_protection_violation(pos, name)
		minetest.chat_send_player(name, S("This is locked by @1", owner))
		return true
	end

	local key_meta = itemstack:get_meta()
	if key_meta:get_string("key_secret") ~= secret then
		minetest.record_protection_violation(pos, name)
		minetest.chat_send_player(name, S("This key does not fit!"))
		return true
	end

	return false
end
