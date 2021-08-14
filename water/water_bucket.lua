local S = minetest.get_translator("water");

bucket.register_liquid(
	"water:source",
	"water:flowing",
	"water:bucket",
	"water_bucket.png",
	S("Water Bucket"),
	{tool = 1, water_bucket = 1}
)

-- River water source is 'liquid_renewable = false' to avoid horizontal spread
-- of water sources in sloping rivers that can cause water to overflow
-- riverbanks and cause floods.
-- River water source is instead made renewable by the 'force renew' option
-- used here.

bucket.register_liquid(
	"water:river_source",
	"water:river_water_flowing",
	"water:bucket_river",
	"water_river_bucket.png",
	S("River Water Bucket"),
	{tool = 1, water_bucket = 1},
	true
)
