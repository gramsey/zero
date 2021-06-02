
local alias_simple = minetest.settings:get("stone.alias_simple") or true;
local alias_map = minetest.settings:get("stone.alias_map") or true;
local alias_default = minetest.settings:get("stone.alias_map") or false;

--simple alias
if (alias_simple) then
	minetest.register_alias("stone", "stone:stone")
	minetest.register_alias("cobble", "stone:cobble")
	minetest.register_alias("mossycobble", "stone:mossycobble")
end

minetest.debug("about to run alias")
-- mapgen alias - note mapgen v6 not included
if (alias_map) then
	minetest.debug("adding alias mapgen_stone");
	minetest.register_alias("mapgen_stone", "stone:stone")
	minetest.debug("added");
end

-- backward compatibility (**DEPRECIATED - avoid using these)
if (alias_default) then
	minetest.register_alias("default:stone", "stone:stone")
	minetest.register_alias("default:cobble", "stone:cobble")
	minetest.register_alias("default:mossycobble", "stone:mossycobble")
end
