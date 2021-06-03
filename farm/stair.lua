
-- stone stairs (only ran if mod stair is included)
local S = minetest.get_translator("farm")

-- Register default stairs and slabs
stair.register_stair_and_slab(
	"straw",
	"farm:straw",
	{snappy = 3, flammable = 4},
	{"farm_straw.png"},
	S("Straw Stair"),
	S("Straw Slab"),
	dirt.grass_sounds,
	true
)
