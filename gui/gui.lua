
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
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

gui.survival_form = "size[8,8.5]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"list[current_player;craft;1.75,0.5;3,3;]"..
	"list[current_player;craftpreview;5.75,1.5;1,1;]"..
	"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
	"listring[current_player;main]"..
	"listring[current_player;craft]"..
	gui.get_hotbar_bg(0,4.25)

