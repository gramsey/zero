
--simple alias
if (minetest.settings:get("dirt.alias_simple")) then
	minetest.register_alias("dirt", "dirt:dirt")
	minetest.register_alias("dirt_with_grass", "dirt:dirt_with_grass")
end

-- backward compatibility (**DEPRECIATED - avoid using these)
if (minetest.settings:get("dirt.alias_default")) then
	minetest.register_alias("default:dirt", "dirt:dirt")
	minetest.register_alias("default:dirt_with_grass", "dirt:dirt_with_grass")
end
