local S = minetest.get_translator("fire")
-- Override coalblock to enable permanent flame above
-- Coalblock is non-flammable to avoid unwanted basic_flame nodes
minetest.override_item("coal:block", {
	after_destruct = function(pos)
		pos.y = pos.y + 1
		if minetest.get_node(pos).name == "fire:permanent_flame" then
			minetest.remove_node(pos)
		end
	end,
	on_ignite = function(pos)
		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(flame_pos).name == "air" then
			minetest.set_node(flame_pos, {name = "fire:permanent_flame"})
		end
	end
})
