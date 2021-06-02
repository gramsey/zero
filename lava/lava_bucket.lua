
local S = minetest.get_translator("lava");

bucket.register_liquid(
	"lava:lava_source",
	"lava:lava_flowing",
	"lava:lava_bucket",
	"lava_bucket.png",
	S("Lava Bucket"),
	{tool = 1}
)

minetest.register_craft({
	type = "fuel",
	recipe = "lava:lava_bucket",
	burntime = 60,
	replacements = {{"lava:lava_bucket", "bucket:bucket_empty"}},
})

-- Register buckets as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "lava:lava_bucket", chance = 0.45, y = {-32768, -1},
			types = {"normal"}},
	})
end
