
-- stone stairs (only ran if mod stair is included)
local S = minetest.get_translator("farming")

-- Register default stairs and slabs
stair.register_stair_and_slab(
	"straw",
	"farming:straw",
	{snappy = 3, flammable = 4},
	{"farming_straw.png"},
	S("Straw Stair"),
	S("Straw Slab"),
	grass.sounds,
	true
)
