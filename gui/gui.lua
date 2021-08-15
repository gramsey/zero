
minetest.register_on_joinplayer(function(player)
	local formspec = [[
		bgcolor[#080808BB;true]
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
		background9[5,5;1,1;gui_formbg.png;true;10]
	]]
	player:set_formspec_prepend(formspec)

	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)

function gui.get_hotbar_bg(x,y)
	minetest.debug("get_hotbar_bg called with ".. x .. ":" .. y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	minetest.debug("out : " .. out)
	return out
end
