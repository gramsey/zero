
local S = minetest.get_translator("lava");

bucket.register_liquid(
	"lava:source",
	"lava:flowing",
	"lava:bucket",
	"lava_bucket.png",
	S("Lava Bucket"),
	{tool = 1}
)

minetest.register_craft({
	type = "fuel",
	recipe = "lava:bucket",
	burntime = 60,
	replacements = {{"lava:bucket", "bucket:empty"}},
})

-- Register buckets as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "lava:bucket", chance = 0.45, y = {-32768, -1},
			types = {"normal"}},
	})
end
