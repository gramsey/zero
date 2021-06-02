
local alias_simple = minetest.settings:get("stone.alias_simple") or true;
local alias_map = minetest.settings:get("stone.alias_map") or true;
local alias_default = minetest.settings:get("stone.alias_map") or false;

--simple alias
if (alias_simple) then
	minetest.register_alias("water_source", "water:water_source")
	minetest.register_alias("river_source", "water:river_source")
	minetest.register_alias("water_flowing", "water:water_flowing")
	minetest.register_alias("river_flowing", "water:river_flowing")
end

-- mapgen alias - note mapgen v6 not included
if (alias_map) then
	minetest.debug("adding water alias")
	minetest.register_alias("mapgen_water_source", "water:water_source")
	minetest.register_alias("mapgen_river_water_source", "water:river_source")
end

-- backward compatibility (**DEPRECIATED - avoid using these)
if (alias_default) then
	minetest.register_alias("default:water_source", "water:water_source")
	minetest.register_alias("default:river_water_source", "water:river_source")
	minetest.register_alias("default:water_flowing", "water:water_flowing")
	minetest.register_alias("default:river_water_flowing", "water:river_flowing")
end

