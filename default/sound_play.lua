
local minetest_sound_play = minetest.sound_play

function minetest.sound_play (name, ...)

	local new_name = default.shim.sound_alias[name]
	name = new_name or name

	minetest_sound_play(name, ...)
end

