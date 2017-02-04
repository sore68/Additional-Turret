-- require "config"
require "libs/list_ammo"

local ammo_setting_table = {{LCT = "distractor-capsule", CRC = "cluster-cannon-shell", CRR = "explosive-multiple-rocket"},
							{LCT = nil, CRC = nil, CRR = nil},
							{LCT = false, CRC = false, CRR = false},
							{LCT = 5, CRC = 20, CRR = 20}}
local at_range = {}
	at_range.at1 = 0
	at_range.at2 = 0

-- script.on_init(function() remote.call("Macromanaged_Turrets", "configure_logistic_turret", "my-cool-turret", {ammo = "my-awesome-ammo", count = 10}) end)  -- Configures a turret prototype with a default request
-- script.on_init(function() remote.call("Macromanaged_Turrets", "configure_logistic_turret", "my-cool-turret", true) end)                                    -- Configures a turret prototype without a default request
-- script.on_init(function() remote.call("Macromanaged_Turrets", "configure_logistic_turret", "my-cool-turret", "empty") end)                                 -- Does exactly the same thing as the previous example
-- remote.call("Macromanaged_Turrets", "configure_logistic_turret", "my-cool-turret")                                                                         -- Removes the turrets' config entry, turning them back into normal turrets

-- at_A12	{entities = {base = entity, turret = New_TT, inventory = New_TI, skill = New_TR}, state = {delay = 3, inv_sync = 0}, etc = {{1, 0, 0}, 0}}
-- at_LC	{entities = {base = entity, turret = New_TT, inventory = New_TI, skill = New_TL}, state = {delay = 3, inv_sync = 0}, etc = nil}
-- at_CR	{entities = {base = entity, turret = New_T2, inventory = New_I2, skill = nil}, state = {delay = 3, inv_sync = {0, 0}}, etc = 0}
------------------------------
script.on_load(function()

end)

script.on_init(function()

	recall_macromanaged_turrets()

end)

script.on_configuration_changed(function()

	recall_macromanaged_turrets()

end)
------------------------------

script.on_event({defines.events.on_built_entity,}, function(event) On_Built(event) end)
script.on_event({defines.events.on_robot_built_entity,}, function(event) On_Built(event) end)
script.on_event(defines.events.on_preplayer_mined_item, function(event) On_Destruction(event) end)
script.on_event(defines.events.on_robot_pre_mined, function(event) On_Destruction(event) end)

script.on_event(defines.events.on_trigger_created_entity, function(event) AddMark(event) end)

script.on_event(defines.events.on_research_finished, function(event)
	if string.sub(event.research.name, 1, 18) == "artillery-1-range-" then
		at_range["at1"] = tonumber(string.sub(event.research.name, 19))
		game.players[1].print({"artillery_max_range", {"entity-name.at_A1_b"}, 150+50*at_range["at1"]})
		-- game.players[1].print("Heavy howitzer max range = " .. 150+50*at_range["at1"])
	end
	if string.sub(event.research.name, 1, 18) == "artillery-2-range-" then
		at_range["at2"] = tonumber(string.sub(event.research.name, 19))
		game.players[1].print({"artillery_max_range", {"entity-name.at_A2_b"}, 200+100*at_range["at2"]})
		-- game.players[1].print("Experimental heavy howitzer max range = " .. 200+100*at_range["at2"])
	end
end)

script.on_event(defines.events.on_gui_click, function(event)
	
	if event.element.name == "at_setting" then
		expand_button(game.players[event.player_index])
		ammo_setting_table[2].LCT = nil
		ammo_setting_table[2].CRC = nil
		ammo_setting_table[2].CRR = nil
		ammo_setting_table[3].LCT = false
		ammo_setting_table[3].CRC = false
		ammo_setting_table[3].CRR = false
		
	elseif event.element.name == "at_save_button" then
		save_button(game.players[event.player_index])
		
		
	elseif string.sub(event.element.name, 1, 6) == "at_LCT" then
		ammo_selected_button(event, ammo_list.capsules)
	elseif string.sub(event.element.name, 1, 6) == "at_CRC" then
		ammo_selected_button(event, ammo_list.shells)
	elseif string.sub(event.element.name, 1, 6) == "at_CRR" then
		ammo_selected_button(event, ammo_list.rockets)
		
	elseif event.element.name == "at_button_stop" then
		finish_button(game.players[event.player_index])
		
	elseif event.element.name == "at_button_view" then
		view_area(game.players[event.player_index])
	
	elseif event.element.name == "at_config_box_3" then
		config_area(game.players[event.player_index])
	
	elseif event.element.name == "at_config_frame_button" then
		config_action(game.players[event.player_index])
	end
end)

script.on_event(defines.events.on_gui_checked_state_changed, function(event)
	if event.element.name == "at_radio_all" then
		game.players[event.player_index].gui.left.at_button.at_radio_frame.at_radio_near.state = false
	elseif event.element.name == "at_radio_near" then
		game.players[event.player_index].gui.left.at_button.at_radio_frame.at_radio_all.state = false
		
	elseif event.element.name == "at_checkbox_LCT" then
		ammo_setting_table[3].LCT = event.element.state
	elseif event.element.name == "at_checkbox_CRC" then
		ammo_setting_table[3].CRC = event.element.state
	elseif event.element.name == "at_checkbox_CRR" then
		ammo_setting_table[3].CRR = event.element.state
	elseif event.element.name == "at_config_box_1" then
		local frame = game.players[event.player_index].gui.left.at_artillery_range_frame
		if frame.at_config_box_2 then
			frame.at_config_box_2.destroy()
			frame.at_config_box_3.destroy()
		else
			frame.add{type = "label", name = "at_config_box_2", caption = "Changing this option may cause the UPS to drop."}
			frame.add{type = "button", name = "at_config_box_3", caption = "Agree"}
		end
	end
end)

script.on_event(defines.events.on_gui_text_changed, function(event)
	if event.element.name == "at_LCT_input_textfield" then
		number_holic(event)
	elseif event.element.name == "at_CRC_input_textfield" then
		number_holic(event)
	elseif event.element.name == "at_CRR_input_textfield" then
		number_holic(event)
	end
end)

script.on_event("at_button_opener", function(event)
	local player = game.players[event.player_index]
	
	local setting = player.gui.left.at_setting
	local button = player.gui.left.at_button
	local on_off_table = player.gui.left.at_on_off_table
	local config_frame = player.gui.left.at_config_frame
	
	if global.AT_Table or player.force.technologies["artillery-set"].researched or player.force.technologies["turret-mk3-unlock"].researched then
		create_button(player)
	else
		if setting		then	setting.destroy()	end
		if button		then	button.destroy()	end
		if on_off_table	then	on_off_table.destroy()	end
		if config_frame	then	config_frame.destroy()	end
	end
end)

script.on_event(defines.events.on_tick, function(event)
	if event.tick % 60 == 0 then
		for _, player in pairs(game.players) do
			if player.gui.left.at_on_off_table then
				change_request_chest(player)
			end
		end
	end
	
	if event.tick % 20 == 0 then
		if global.AT_Table ~= nil then
			for index, turrets in pairs(global.AT_Table) do
				if turrets.entities.base.valid then
					Turrets_Health_Check(turrets)
					turrets.state.delay = turrets.state.delay - 1
					if turrets.state.delay <= 0 and turrets.entities.base.valid then
						Turrets_Action(turrets)
					end
				else
					Turrets_Destroy(turrets)
					
					table.remove(global.AT_Table, index)
					if #global.AT_Table == 0 then
						global.AT_Table = nil
					end
				end
			end
			
		end
	end
	
end)

---------------------- buttons
function create_button(player)

	local setting = player.gui.left.at_setting
	local on_off_table = player.gui.left.at_on_off_table
	local config_frame = player.gui.left.at_config_frame
	
	if setting then
		setting.destroy()
		if player.gui.left["at_artillery_range_frame"] then
			player.gui.left["at_artillery_range_frame"].destroy()
		end
		if player.gui.left["at_button"] then
			player.gui.left["at_button"].destroy()
		end
		if config_frame then
			config_frame.destroy()
		end
	elseif on_off_table then
		ammo_setting_table[2].LCT = nil
		ammo_setting_table[2].CRC = nil
		ammo_setting_table[2].CRR = nil
		ammo_setting_table[3].LCT = false
		ammo_setting_table[3].CRC = false
		ammo_setting_table[3].CRR = false
		
		on_off_table.destroy()	
	else
		if not ammo_list.rockets then -- if not (ammo_list.shells and ammo_list.rockets) then
			input_ammo()
		end
		player.gui.left.add{type = "button", name = "at_setting", style = "at_setting_button_style"}
		local range_frame = player.gui.left.add{type = "frame", name = "at_artillery_range_frame", direction = "vertical"}
		range_frame.add{type = "label", name = "at_A1_turret_range", caption = "Heavy howitzer max range = " .. 150+50*at_range.at1}
		range_frame.add{type = "label", name = "at_A2_turret_range", caption = "Experimental heavy howitzer max range = " .. 200+100*at_range.at2}
		range_frame.add{type = "checkbox", name = "at_config_box_1", state = false, caption = "Advanced Settings"}
	end
end

function ammo_selected_button(event, list)
	if not (string.find(event.element.name, "frame") or string.find(event.element.name, "textfield")) then
		local name = string.sub(event.element.name, 4, 6)
		
		local ammo_type = ammo_filter(name)
		
		local frame1 = string.format("at_%s_checkbox_frame", name)
		local frame2 = string.format("at_%s_scroll_pane", name)
		local frame3 = string.format("at_%s_checkbox_frame_table", name)
		
		for _, ammo_name in pairs(ammo_type) do -- children_names?
			local frame4 = string.format("at_%s_%s", name, ammo_name[1])
			
			-- at_button.at_checkbox_frame.at_[3]_checkbox_frame.at_[3]_scroll_pane.at_[3]_checkbox_frame_table.at_[3]_[ammo name]
			
			game.players[event.player_index].gui.left.at_button.at_checkbox_frame[frame1][frame2][frame3][frame4].style = "at_select_style"
		end
		event.element.style = "at_selected_style"
		ammo_setting_table[2][name] = string.sub(event.element.name, 8)
	end
end

function save_button(player)
	local setting = player.gui.left["at_setting"]
	local button = player.gui.left["at_button"]
	
	if ammo_setting_table[3].LCT and ammo_setting_table[2].LCT then
		ammo_setting_table[1].LCT = ammo_setting_table[2].LCT
	end
	if ammo_setting_table[3].CRC and ammo_setting_table[2].CRC then
		ammo_setting_table[1].CRC = ammo_setting_table[2].CRC
	end
	if ammo_setting_table[3].CRR and ammo_setting_table[2].CRR then
		ammo_setting_table[1].CRR = ammo_setting_table[2].CRR
	end
	
	if button.at_radio_frame["at_radio_all"].state then
		if global.AT_Table then
			for _, turret in pairs(global.AT_Table) do
				if turret[1].name == "at_LC_turret" and ammo_setting_table[3].LCT then
					turret[2].clear_request_slot(1)
					turret[2].set_request_slot({name = ammo_setting_table[1].LCT, count = ammo_setting_table[4].LCT}, 1)
				elseif turret[1].name == "at_CR_turret" then
					if ammo_setting_table[3].CRC then
						turret[3][1][2].clear_request_slot(1)
						turret[3][1][2].set_request_slot({name = ammo_setting_table[1].CRC, count = ammo_setting_table[4].CRC}, 1)
					end
					if ammo_setting_table[3].CRR then
						turret[3][2][2].clear_request_slot(1)
						turret[3][2][2].set_request_slot({name = ammo_setting_table[1].CRR, count = ammo_setting_table[4].CRR}, 1)
					end
				end
			end
		end
	elseif button.at_radio_frame["at_radio_near"].state then
	
		-- at_button	at_checkbox_frame	at_CRC_checkbox_frame	at_checkbox_CRC_table
		local checker1 = button.at_checkbox_frame.at_LCT_checkbox_frame.at_checkbox_LCT_table.at_checkbox_LCT
		local checker2 = button.at_checkbox_frame.at_CRC_checkbox_frame.at_checkbox_CRC_table.at_checkbox_CRC
		local checker3 = button.at_checkbox_frame.at_CRR_checkbox_frame.at_checkbox_CRR_table.at_checkbox_CRR
		
		if checker1.state or checker2.state or checker3.state then
			local frame_table = player.gui.left.add{type = "table", name = "at_on_off_table", colspan = 1}
			local icon_frames = frame_table.add{type = "frame", name = "at_on_off_icon", direction = "horizontal"}
			local button_frame = frame_table.add{type = "frame", name = "at_on_off_button", direction = "horizontal"}
			
			if checker1.state and ammo_setting_table[3].LCT then
				local icon_frame = icon_frames.add{type = "frame", name = "at_on_off_LCT_frame", direction = "vertical"}
				icon_frame.add{type = "sprite", name = "at_on_off_script_LCT", sprite = "item/at_LC_b", tooltip = {"entity-name.at_LC_b"}}
				icon_frame.add{type = "sprite", name = "at_on_off_script_LCT"..ammo_setting_table[1].LCT, sprite = "item/"..ammo_setting_table[1].LCT, tooltip = game.item_prototypes[ammo_setting_table[1].LCT].localised_name}
				number_gen(icon_frame)
			end
			if checker2.state and ammo_setting_table[3].CRC then
				local icon_frame = icon_frames.add{type = "frame", name = "at_on_off_CRC_frame", direction = "vertical"}
				icon_frame.add{type = "sprite", name = "at_on_off_script_CRC", sprite = "item/at_CR_b", tooltip = {"entity-name.at_CR_b"}}
				icon_frame.add{type = "sprite", name = "at_on_off_script_CRC"..ammo_setting_table[1].CRC, sprite = "item/"..ammo_setting_table[1].CRC, tooltip = game.item_prototypes[ammo_setting_table[1].CRC].localised_name}
				number_gen(icon_frame)
			end
			if checker3.state and ammo_setting_table[3].CRR then
				local icon_frame = icon_frames.add{type = "frame", name = "at_on_off_CRR_frame", direction = "vertical"}
				icon_frame.add{type = "sprite", name = "at_on_off_script_CRR", sprite = "item/at_CR_b", tooltip = {"entity-name.at_CR_b"}}
				icon_frame.add{type = "sprite", name = "at_on_off_script_CRR"..ammo_setting_table[1].CRR, sprite = "item/"..ammo_setting_table[1].CRR, tooltip = game.item_prototypes[ammo_setting_table[1].CRR].localised_name}
				number_gen(icon_frame)
			end
			
			
			button_frame.add{type = "button", name = "at_button_stop", caption = "STOP"}
			button_frame.add{type = "button", name = "at_button_view", caption = "View range"}
		end
	end
	
	if button then
		button.destroy()
	end
	if setting then
		setting.destroy()
	end
	if player.gui.left["at_artillery_range_frame"] then
		player.gui.left["at_artillery_range_frame"].destroy()
	end
end

function expand_button(player)
	local button = player.gui.left["at_button"]
	if button then
		button.destroy()
		player.gui.left["at_setting"].destroy()
	else
		button = player.gui.left.add{type = "frame", name = "at_button", direction = "vertical"}
			button.add{type = "frame", name = "at_radio_frame", direction = "vertical"}
				button.at_radio_frame.add{type = "radiobutton", name = "at_radio_all", state = true, caption = "Change the request slot of the selected all turrets at the bottom."}
				button.at_radio_frame.add{type = "radiobutton", name = "at_radio_near", state = false, caption = "Change the request slot of the selected nearby turrets at the bottom."}
		
			button.add{type = "scroll-pane", name = "at_checkbox_frame", horizontal_scroll_policy = "never"}
			button.at_checkbox_frame.style.maximal_height = 400
			button.at_checkbox_frame.style.minimal_height = 300
				local checkbox_frame = button.at_checkbox_frame.add{type = "frame", name = "at_LCT_checkbox_frame", direction = "vertical"}
					checkbox_frame.add{type = "table", name = "at_checkbox_LCT_table", colspan = 2}
						checkbox_frame.at_checkbox_LCT_table.add{type = "sprite", name = "at_checkbox_LCT_sprite", sprite = "item/at_LC_b", tooltip = {"entity-name.at_LC_b"}}
						checkbox_frame.at_checkbox_LCT_table.add{type = "checkbox", name = "at_checkbox_LCT", state = false, caption = "Set Capsule flower inventory."}
					Add_list(checkbox_frame)
					checkbox_frame.add{type = "table", name = "at_textfield_LCT_frame", colspan = 2}
						checkbox_frame.at_textfield_LCT_frame.add{type = "label", name = "at_LCT_label_textfield", caption = "COUNT :"}
						checkbox_frame.at_textfield_LCT_frame.add{type = "textfield", name = "at_LCT_input_textfield", text = ammo_setting_table[4].LCT}
				
				
				checkbox_frame = button.at_checkbox_frame.add{type = "frame", name = "at_CRC_checkbox_frame", direction = "vertical"}
					checkbox_frame.add{type = "table", name = "at_checkbox_CRC_table", colspan = 2}
						checkbox_frame.at_checkbox_CRC_table.add{type = "sprite", name = "at_checkbox_CRC_sprite", sprite = "item/at_CR_b", tooltip = {"entity-name.at_CR_b"}}
						checkbox_frame.at_checkbox_CRC_table.add{type = "checkbox", name = "at_checkbox_CRC", state = false, caption = "Set Destroyer inventory(shell)."}
					Add_list(checkbox_frame)
					checkbox_frame.add{type = "table", name = "at_textfield_CRC_frame", colspan = 2}
						checkbox_frame.at_textfield_CRC_frame.add{type = "label", name = "at_CRC_label_textfield", caption = "COUNT :"}
						checkbox_frame.at_textfield_CRC_frame.add{type = "textfield", name = "at_CRC_input_textfield", text = ammo_setting_table[4].CRC}
				
				
				checkbox_frame = button.at_checkbox_frame.add{type = "frame", name = "at_CRR_checkbox_frame", direction = "vertical"}
					checkbox_frame.add{type = "table", name = "at_checkbox_CRR_table", colspan = 2}
						checkbox_frame.at_checkbox_CRR_table.add{type = "sprite", name = "at_checkbox_CRR_sprite", sprite = "item/at_CR_b", tooltip = {"entity-name.at_CR_b"}}
						checkbox_frame.at_checkbox_CRR_table.add{type = "checkbox", name = "at_checkbox_CRR", state = false, caption = "Set Destroyer inventory(rocket)."}
					Add_list(checkbox_frame)
					checkbox_frame.add{type = "table", name = "at_textfield_CRR_frame", colspan = 2}
						checkbox_frame.at_textfield_CRR_frame.add{type = "label", name = "at_CRR_label_textfield", caption = "COUNT :"}
						checkbox_frame.at_textfield_CRR_frame.add{type = "textfield", name = "at_CRR_input_textfield", text = ammo_setting_table[4].CRR}
			
			button.add{type = "button", name = "at_save_button", caption = "Apply"}
	end
	if player.gui.left["at_artillery_range_frame"] then
		player.gui.left["at_artillery_range_frame"].destroy()
	end
	if player.gui.left["at_config_frame"] then
		player.gui.left["at_config_frame"].destroy()
	end
end

function Add_list(frame)
	local ammo_type = ammo_filter(frame.name)
	
	frame.add{type = "scroll-pane", name = string.sub(frame.name, 1, 7).."scroll_pane", vertical_scroll_policy = "never"}
	frame[string.sub(frame.name, 1, 7).."scroll_pane"].style.maximal_width = 400
	frame[string.sub(frame.name, 1, 7).."scroll_pane"].style.minimal_width = 400
	
	local icon_frame = frame[string.sub(frame.name, 1, 7).."scroll_pane"].add{type = "table", name = frame.name .. "_table", colspan = #ammo_type}
	for _, ammo_name in pairs(ammo_type) do
		icon_frame.add{type = "sprite-button", name = string.sub(frame.name, 1, 7)..ammo_name[1], sprite = "item/"..ammo_name[1], style = "at_select_style", tooltip = game.item_prototypes[ammo_name[1]].localised_name}
	end
end

function finish_button(player)
	
	ammo_setting_table[2].LCT = nil
	ammo_setting_table[2].CRC = nil
	ammo_setting_table[2].CRR = nil
	ammo_setting_table[3].LCT = false
	ammo_setting_table[3].CRC = false
	ammo_setting_table[3].CRR = false
	
	player.gui.left.at_on_off_table.destroy()
end

function config_area(player)
	if global.limit_builder == nil then
		global.limit_builder = {50, 10, 100, 100}
	end
	if player.gui.left.at_artillery_range_frame then
		player.gui.left.at_artillery_range_frame.destroy()
	end
	local frame = player.gui.left.add{type = "frame", name = "at_config_frame", direction = "vertical"}
	frame.add{type = "label", name = "at_config_frame_label_1", caption = "Adjust the construction limits of the turret."}
	local turret_tb = {"at_A1_turret", "at_A2_turret", "at_LC_turret", "at_CR_turret"}
	for i = 1, 4 do
		local config_table = frame.add{type = "table", name = "at_config_frame_table_"..i, colspan = 2}
		config_table.add{type = "sprite", name = "at_config_frame_table1_sprite_"..i, sprite = "item/"..turret_tb[i].."_area", tooltip = game.item_prototypes[turret_tb[i].."_area"].localised_name}
		config_table.add{type = "textfield", name = "at_config_frame_table1_textfield_"..i, text = global.limit_builder[i]}
	end
	frame.add{type = "button", name = "at_config_frame_button", caption = "Apply"}
end

------------------------------
function config_action(player)
	if global.limit_builder == nil then
		global.limit_builder = {50, 10, 100, 100}
	end
	local frame = player.gui.left.at_config_frame
	local turret_tb = {"at_A1_turret", "at_A2_turret", "at_LC_turret", "at_CR_turret"}
	
	if global.AT_Table then
		for i = 1, 4 do
			local check = 0
			global.limit_builder[i] = tonumber(frame["at_config_frame_table_"..i]["at_config_frame_table1_textfield_"..i].text)
			for index, turret_name in pairs (global.AT_Table) do
				if turret_name[1].name == turret_tb[i] then
					check = check + 1
				end
			end
			if check > global.limit_builder[i] then
				check = check - global.limit_builder[i]
				for j = #global.AT_Table, 0, -1 do
					if global.AT_Table[j][1].name == turret_tb[i] then
						Turrets_Destroy(global.AT_Table[j])
						table.remove(global.AT_Table, j)
						check = check - 1
						if check == 0 then
							break
						end
					end
				end
			end
		end
	end
	frame.destroy()
	player.gui.left["at_setting"].destroy()
end

function input_ammo()
	-- ammo_list.shells = {}
	ammo_list.rockets = {}
	for v, x in pairs(game.item_prototypes) do
		if x.type == "ammo" then
			if x.ammo_type.category == "rocket" then
				ammo_list.rockets[#ammo_list.rockets+1] = {x.name, nil}
			end
		end
	end
end

function view_area(player)
	
	local pos = player.position
	local range = 25
	
	for i = -1, 1, 2 do
		for j = 0, math.floor(range/5 - 1) do
			local start_x, start_y, target_x, target_y
			
			start_x = pos.x - (range - range * 2 / math.floor(range/5) * j) * i
			start_y = pos.y - range * i
			target_x = pos.x - (range - range * 2 / math.floor(range/5) * (j + 1)) * i
			target_y = pos.y - range * i
			player.surface.create_entity({name = "guid-flash", position = {x = start_x, y = start_y}, force = player.force, target = {x = target_x, y = target_y}, speed = 0.1})
			
			start_x = pos.x + range * i
			start_y = pos.y - (range - range * 2 / math.floor(range/5) * j) * i
			target_x = pos.x + range * i
			target_y = pos.y - (range - range * 2 / math.floor(range/5) * (j + 1)) * i
			player.surface.create_entity({name = "guid-flash", position = {x = start_x, y = start_y}, force = player.force, target = {x = target_x, y = target_y}, speed = 0.1})
		end
	end
end

function change_request_chest(player)
	
	local pos = player.position
	local range = 25
	local unit = player.surface.find_entities_filtered({area = {{x = pos.x - range, y = pos.y - range}, {x = pos.x + range, y = pos.y + range}}, type = "logistic-container"})
	if #unit > 0 then
		for _, logistic_container in pairs(unit) do
			if logistic_container.name == "at_LC_i" and ammo_setting_table[3].LCT then
				logistic_container.clear_request_slot(1)
				logistic_container.set_request_slot({name = ammo_setting_table[1].LCT, count = ammo_setting_table[4].LCT}, 1)
			elseif logistic_container.name == "at_CR_i1" and ammo_setting_table[3].CRC then
				logistic_container.clear_request_slot(1)
				logistic_container.set_request_slot({name = ammo_setting_table[1].CRC, count = ammo_setting_table[4].CRC}, 1)
			elseif logistic_container.name == "at_CR_i2" and ammo_setting_table[3].CRR then
				logistic_container.clear_request_slot(1)
				logistic_container.set_request_slot({name = ammo_setting_table[1].CRR, count = ammo_setting_table[4].CRR}, 1)
			end
		end
	end
end

function number_holic(event)
	local text = tonumber(event.element.text)
	if type(text) == "number" then
		if text > 0 and text <= 75 then
			ammo_setting_table[4][string.sub(event.element.name, 4, 6)] = text
		elseif text > 75 then
			ammo_setting_table[4][string.sub(event.element.name, 4, 6)] = 75
		end
	else
		ammo_setting_table[4][string.sub(event.element.name, 4, 6)] = 20
	end
end

function ammo_filter(input)
	local ammo_output = {}
	
	if string.find(input, "LCT") then
		ammo_output = ammo_list.capsules
	elseif string.find(input, "CRC") then
		ammo_output = ammo_list.shells
	elseif string.find(input, "CRR") then
		ammo_output = ammo_list.rockets
	end
	return ammo_output
end

function number_gen(frame)
	local number
	local name
	if string.find(frame.name, "LCT") then
		number = ammo_setting_table[4].LCT
		name = "LCT"
	elseif string.find(frame.name, "CRC") then
		number = ammo_setting_table[4].CRC
		name = "CRC"
	elseif string.find(frame.name, "CRR") then
		number = ammo_setting_table[4].CRR
		name = "CRR"
	end
	
	frame.add{type = "table", name = "at_on_off_script_LCT_table", colspan = 2}
	if number < 10 then
		number = number + 100
	end
	frame.at_on_off_script_LCT_table.add{type = "sprite", name = "at_on_off_script_"..name.."_number_2", sprite = "number_"..tostring(math.floor(number / 10))}
	frame.at_on_off_script_LCT_table.add{type = "sprite", name = "at_on_off_script_"..name.."_number_1", sprite = "number_"..tostring(number % 10)}
end

function recall_macromanaged_turrets()
	local check = 0
	for v, x in pairs(game.item_prototypes) do
		if x.name == "MMT-logistic-turret-remote" then
			check = 1
			break
		end
	end
	if check == 1 then
		remote.call("Macromanaged_Turrets", "configure_logistic_turret", "at-cannon-turret-mk1", {ammo = "cluster-cannon-shell", count = 10})
		remote.call("Macromanaged_Turrets", "configure_logistic_turret", "at-cannon-turret-mk2", {ammo = "cluster-cannon-shell", count = 10})
		remote.call("Macromanaged_Turrets", "configure_logistic_turret", "at-rocket-turret-mk1", {ammo = "explosive-multiple-rocket", count = 10})
		remote.call("Macromanaged_Turrets", "configure_logistic_turret", "at-rocket-turret-mk2", {ammo = "explosive-multiple-rocket", count = 10})
	end
end
------------------------------
function On_Built(event)
	
	local entity = event.created_entity
	local surface = entity.surface
	local force = entity.force
	local position = entity.position
	local check = 0
	
	if global.AT_Table == nil then
		global.AT_Table = {}
	end
	if global.limit_builder == nil then
		global.limit_builder = {50, 10, 100, 100}
	end
	-- b/	t/	i/	s
	-- b/	t/	i/	r	at_A1_
	-- b/	t/	i/	r	at_A2_
	-- b/	t/	i/	l/c	at_LC_
	-- b/	cr/	ii/	nil	at_CR_
	
	
	-- Artillery has been built
	if entity.name == "at_A1_b" or entity.name == "at_A2_b" then
		local number = tonumber(string.sub(entity.name, string.find(entity.name, "%d")))
		check = limit_counter(entity.name)
		if check >= global.limit_builder[number] then
			overflow(event, number)
		else
			local New_TT = surface.create_entity({name = "at_A"..number.."_t", position = position, direction = entity.direction, force = force})
			local New_TI = surface.create_entity({name = "at_A"..number.."_i", position = position, direction = entity.direction, force = force})
			local New_TR = surface.create_entity({name = "at_A"..number.."_r", position = position, direction = entity.direction, force = force})
			New_TI.set_request_slot({name = ammo_list.artillery_shells[number][1], count = 5}, 1)
			
			entity.destructible = false
			entity.operable = false
			entity.minable = true
			
			New_TT.destructible = true
			New_TT.operable = false
			New_TT.minable = false
			
			New_TI.destructible = false
			New_TI.operable = false
			New_TI.minable = false
			
			New_TR.destructible = true
			New_TR.operable = false
			New_TR.minable = false
			
			table.insert(global.AT_Table, {entities = {base = entity, turret = New_TT, inventory = New_TI, skill = New_TR}, state = {delay = 3, inv_sync = 0}, etc = {{1, 0, 0}, 0}})
			-- global.AT_Table turrets(4 turret entity), state(delay, inventory sync), etc(scan(D, L, S), enemy)
		end
		
	elseif entity.name == "at_LC_b" then
		check = limit_counter(entity.name)
		if check >= global.limit_builder[3] then
			overflow(event, 3)
		else
			local New_TT = surface.create_entity({name = "at_LC".."_t", position = position, direction = entity.direction, force = force})
			local New_TI = surface.create_entity({name = "at_LC".."_i", position = position, direction = entity.direction, force = force})
			New_TI.set_request_slot({name = ammo_setting_table[1].LCT, count = ammo_setting_table[4].LCT}, 1)
			
			local i, j, New_TL = 1, 1, {}
			for k = 1, 4 do
				if k%2 == 1 then i = i * -1
				else j = j * -1
				end
				local LC_offset = 1.7
				local position_offset = {position.x + LC_offset * i , position.y + LC_offset * j }
				local _TL = surface.create_entity({name = "at_LC".."_l", position = position_offset, direction = entity.direction, force = force})
				
				_TL.destructible = true
				_TL.operable = false
				_TL.minable = false
				
				table.insert(New_TL, _TL)
			end
			
			entity.destructible = false
			entity.operable = false
			entity.minable = true
			
			New_TT.destructible = false
			New_TT.operable = false
			New_TT.minable = false
			
			New_TI.destructible = false
			New_TI.operable = true
			New_TI.minable = false
			
			table.insert(global.AT_Table, {entities = {base = entity, turret = New_TT, inventory = New_TI, skill = New_TL}, state = {delay = 3, inv_sync = 0}, etc = nil})
			-- global.AT_Table turrets(4 turret entity), state(delay, inventory sync), etc
		end
		
	elseif entity.name == "at_CR_b" then
		check = limit_counter(entity.name)
		if check >= global.limit_builder[4] then
			overflow(event, 4)
		else
			
			local New_TT, New_TI = {}, {}
			
			for k = 1, 2 do
				local i = 1
				if k%2 == 1 then
					i = i * -1
				end
				local LC_offset = 1.5
				local position_offset = {position.x + LC_offset * i , position.y + 1.5 }
				local _TI = surface.create_entity({name = "at_CR".."_i"..k, position = position_offset, direction = entity.direction, force = force})
				local _TT = surface.create_entity({name = "at_CR".."_t"..k, position = position, direction = entity.direction, force = force})
				
				_TI.destructible = false
				_TI.operable = true
				_TI.minable = false
				
				_TT.destructible = true
				_TT.operable = false
				_TT.minable = false
				
				if k == 1 then
					_TI.set_request_slot({name = ammo_setting_table[1].CRC, count = ammo_setting_table[4].CRC}, 1)
				else
					_TI.set_request_slot({name = ammo_setting_table[1].CRR, count = ammo_setting_table[4].CRR}, 1)
				end
				
				table.insert(New_TT, _TT)
				table.insert(New_TI, _TI)
			end
			
			entity.destructible = false
			entity.operable = false
			entity.minable = true
			
			table.insert(global.AT_Table, {entities = {base = entity, turret = New_TT, inventory = New_TI, skill = nil}, state = {delay = 3, inv_sync = {0, 0}}, etc = 0})
			-- global.AT_Table turrets(4 turret entity), state(delay, inventory sync), etc(active)
		end
	end
end

-- Artillery Stuff
function overflow(event, number)
	local entity = event.created_entity
	if event.player_index then
		game.players[event.player_index].print({"built_overflow", entity.localised_name, global.limit_builder[number]})
		game.players[event.player_index].insert({name = entity.name})
	else
		entity.surface.create_entity{name = "item-on-ground", position = entity.position, stack = {name = entity.name}}.order_deconstruction(entity.force)
	end
	entity.destroy()
end

function limit_counter(name)
	local check = 0
	for _, turrets in pairs (global.AT_Table) do
		if turrets.entities.base.valid and turrets.entities.base.name == name then
			check = check + 1
		end
	end
	return check
end

function Turrets_Health_Check(at_Turrets_Set)
	
	local entities = at_Turrets_Set.entities
	local base = entities.base
	local position = base.position
	local force = base.force
	local health_level = 0
	
	if base.name == "at_A1_b" then
		-- 600/600/1200/1.3/1:2-4
		if entities.turret.valid then
			if entities.turret.name == "at_A1".."_t" then
				health_level = health_level + entities.turret.health
			end
		else
			
			local A1T = base.surface.create_entity({name = "at_A1".."_c", position = position, force = force})
			
			A1T.health = 1
			A1T.operable = false
			A1T.destructible = false
			A1T.minable = false
			entities.turret = A1T
		end
		if entities.skill.valid then
			if entities.skill.name == "at_A1".."_r" then
				health_level = health_level + entities.skill.health
			end
		else
			
			local A1R = base.surface.create_entity({name = "at_A1".."_c", position = position, force = force})
			
			A1R.health = 1
			A1R.operable = false
			A1R.destructible = false
			A1R.minable = false
			entities.skill = A1R
		end
		
		if entities.turret.name == "at_A1_c" and entities.turret.health >= 550*1.3 then
			entities.turret.destroy()
			
			local CRT = base.surface.create_entity({name = "at_A1".."_t", position = position, force = force})
			
			CRT.health = 550
			CRT.operable = false
			CRT.destructible = true
			CRT.minable = false
			entities.turret = CRT
		end
		if entities.skill.name == "at_A1_c" and entities.skill.health >= 550*1.3 then
			entities.skill.destroy()
			
			local CRT = base.surface.create_entity({name = "at_A1".."_r", position = position, force = force})
			
			CRT.health = 550
			CRT.operable = false
			CRT.destructible = true
			CRT.minable = false
			entities.skill = CRT
		end
		
		if health_level <= 1 then
			base.surface.create_entity({name = "cluster-grenade", position = position, force = force, target = position, speed = 1})
			base.destroy()
		else
			base.health = health_level
		end
		
	elseif base.name == "at_A2_b" then
		-- 1500/1500/3000/1.3/1:2-4
		if entities.turret.valid then
			if entities.turret.name == "at_A2".."_t" then
				health_level = health_level + entities.turret.health
			end
		else
			
			local A2T = base.surface.create_entity({name = "at_A2".."_c", position = position, force = force})
			
			A2T.health = 1
			A2T.operable = false
			A2T.destructible = false
			A2T.minable = false
			entities.turret = A2T
		end
		if entities.skill.valid then
			if entities.skill.name == "at_A2".."_r" then
				health_level = health_level + entities.skill.health
			end
		else
			
			local A2R = base.surface.create_entity({name = "at_A2".."_c", position = position, force = force})
			
			A2R.health = 1
			A2R.operable = false
			A2R.destructible = false
			A2R.minable = false
			entities.skill = A2R
		end
		
		if entities.turret.name == "at_A2_c" and entities.turret.health >= 1400*1.3 then
			entities.turret.destroy()
			
			local CRT = base.surface.create_entity({name = "at_A2".."_t", position = position, force = force})
			
			CRT.health = 1400
			CRT.operable = false
			CRT.destructible = true
			CRT.minable = false
			entities.turret = CRT
		end
		if entities.skill.name == "at_A2_c" and entities.skill.health >= 1400*1.3 then
			entities.skill.destroy()
			
			local CRT = base.surface.create_entity({name = "at_A2".."_r", position = position, force = force})
			
			CRT.health = 1400
			CRT.operable = false
			CRT.destructible = true
			CRT.minable = false
			entities.skill = CRT
		end
		
		if health_level <= 1 then
			base.surface.create_entity({name = "cluster-grenade", position = position, force = force, target = position, speed = 1})
			base.surface.create_entity({name = "cluster-grenade", position = position, force = force, target = position, speed = 1})
			base.destroy()
		else
			base.health = health_level
		end
		
	elseif base.name == "at_LC_b" then
		-- 500/500/500/500/2000/1.3/1:4(4)
		local x, y, LC_offset = 1, 1, 1.7
		
		for i = 1, #entities.skill do
			if entities.skill[i].valid then
				if entities.skill[i].name == "at_LC_l" then
					health_level = health_level + entities.skill[i].health
				end
			else
				for k = 1, i do
					if k%2 == 1 then
						x = x * -1
					else
						y = y * -1
					end
				end
				
				local position_offset = {position.x + LC_offset * x , position.y + LC_offset * y }
				local LCC = base.surface.create_entity({name = "at_LC".."_c", position = position_offset, force = force})
				
				LCC.health = 1
				LCC.operable = false
				LCC.destructible = false
				LCC.minable = false
				entities.skill[i] = LCC
			end
			
			if entities.skill[i].name == "at_LC_c" and entities.skill[i].health >= 450*1.3 then
				entities.skill[i].destroy()
				for k = 1, i do
					if k%2 == 1 then
						x = x * -1
					else
						y = y * -1
					end
				end
				
				local position_offset = {position.x + LC_offset * x , position.y + LC_offset * y }
				local LCL = base.surface.create_entity({name = "at_LC".."_l", position = position_offset, force = force})
				
				LCL.health = 450
				LCL.operable = false
				LCL.destructible = true
				LCL.minable = false
				entities.skill[i] = LCL
			end
		end
		
		if health_level <= 1 then
			base.surface.create_entity({name = "cluster-grenade", position = position, force = force, target = position, speed = 1})
			base.destroy()
		else
			base.health = health_level
		end
		
	elseif base.name == "at_CR_b" then
		-- 1000/1000/2000/1.3/1:2(2)
		for i = 1, #entities.turret do
			if entities.turret[i].valid then
				if entities.turret[i].name == "at_CR_t"..i then
					health_level = health_level + entities.turret[i].health
				end
			else
				
				local CRC = base.surface.create_entity({name = "at_CR".."_c", position = position, force = force})
				
				CRC.health = 1
				CRC.operable = false
				CRC.destructible = false
				CRC.minable = false
				entities.turret[i] = CRC
			end
			
			if entities.turret[i].name == "at_CR_c" and entities.turret[i].health >= 950*1.3 then
				entities.turret[i].destroy()
				
				local CRT = base.surface.create_entity({name = "at_CR".."_t"..i, position = position, force = force})
				
				CRT.health = 950
				CRT.operable = false
				CRT.destructible = true
				CRT.minable = false
				entities.turret[i] = CRT
			end
		end
		
		if health_level <= 1 then
			base.surface.create_entity({name = "cluster-grenade", position = position, force = force, target = position, speed = 1})
			base.destroy()
		else
			base.health = health_level
		end
	end
end

function Turrets_Destroy(at_Turrets_Set)
	
	local turrets = at_Turrets_Set.entities
	
	if turrets.base.valid then
		turrets.base.destroy()
	end
	
	if #turrets.turret > 0 then
		for i = 1, #turrets.turret do
			if turrets.turret[i].valid then
				turrets.turret[i].destroy()
			end
		end
	else
		if turrets.turret.valid then
			turrets.turret.destroy()
		end
	end
	
	if #turrets.inventory > 0 then
		for i = 1, #turrets.inventory do
			if turrets.inventory[i].valid then
				turrets.inventory[i].destroy()
			end
		end
	else
		if turrets.inventory.valid then
			turrets.inventory.destroy()
		end
	end
	
	if turrets.skill then
		if #turrets.skill > 0 then
			for i = 1, #turrets.skill do
				if turrets.skill[i].valid then
					turrets.skill[i].destroy()
				end
			end
		else
			if turrets.skill.valid then
				turrets.skill.destroy()
			end
		end
	end
end

function Artillery_scanner(turrets)
	
	local function scanner_calculator(temp_grid, temp_check)
		
		local x, y
		if temp_check[1] == 1 then
			x = - (temp_grid[1] + temp_grid[2] * temp_check[3]) + temp_grid[2] * temp_check[2]
			y = - (temp_grid[1] + temp_grid[2] * temp_check[3])
		elseif temp_check[1] == 2 then
			x = (temp_grid[1] + temp_grid[2] * temp_check[3]) - temp_grid[2]
			y = - (temp_grid[1] + temp_grid[2] * temp_check[3]) + temp_grid[2] * temp_check[2]
		elseif temp_check[1] == 3 then
			x = (temp_grid[1] + temp_grid[2] * temp_check[3]) - temp_grid[2] - temp_grid[2] * temp_check[2]
			y = (temp_grid[1] + temp_grid[2] * temp_check[3]) - temp_grid[2]
		elseif temp_check[1] == 4 then
			x = - (temp_grid[1] + temp_grid[2] * temp_check[3])
			y = (temp_grid[1] + temp_grid[2] * temp_check[3]) - temp_grid[2] - temp_grid[2] * temp_check[2]
		end
		
		return x, y
	end
	
	local grid
	local scan_direction = turrets.etc[1][1]
	local scan_level = turrets.etc[1][2]
	local scan_interval = turrets.etc[1][3]
	-- scan_direction = 1(right) 2(down) 3(left) 4(up) / scan_level = 0(check) 1 2 3 4 5 6 7... / scan_interval = [near|0 1 2 3 4 5 ...|far]
	
	if turrets.entities.base.name == "at_A1_b" then
		grid = {150, 50, 150 + 50 * at_range.at1}
		--{grid, gap, max_range}
	elseif turrets.entities.base.name == "at_A2_b" then
		grid = {200, 100, 200 + 100 * at_range.at2}
	end
	
	local temp_scan_direction
	if scan_direction == 4 then
		temp_scan_direction = 1
	else
		temp_scan_direction = scan_direction + 1
	end
	local temp_x, temp_y = scanner_calculator(grid, {temp_scan_direction, 0, scan_interval})
	local x1, y1 = scanner_calculator(grid, turrets.etc[1])
	
	scan_level = scan_level + 1
	
	if scan_level > 0 then
		
		if x1 == temp_x and y1 == temp_y then
			
			scan_direction = scan_direction + 1
			scan_level = 1
			if scan_direction > 4 then
				scan_direction = 1
				if turrets.etc[2] == 0 then
					scan_interval = scan_interval + 1
					turrets.etc[2] = 0
					if grid[1] + grid[2] * scan_interval > grid[3] then
						scan_interval = 0
					end
				else
					scan_interval = 0
					turrets.etc[2] = 0
				end
			end
		end
	end
	
	local pos = turrets.entities.base.position
	local area = {{pos.x + x1, pos.y + y1}, {pos.x + x1 + grid[2], pos.y + y1 + grid[2]}}
	
	turrets.etc[1] = {scan_direction, scan_level, scan_interval}
	
	return area
end


function Turrets_Action(at_Turrets_Set)
	
	local Entities = at_Turrets_Set.entities
	local Base = Entities.base
	local delay = 3
	
	if Base.name == "at_A1_b" or Base.name == "at_A2_b" then
	
		local Inventory = Entities.inventory
		local Turret = Entities.turret
		local Skill = Entities.skill
		
		local number
		if tonumber(string.sub(Base.name, string.find(Base.name, "%d"))) then number = tonumber(string.sub(Base.name, string.find(Base.name, "%d"))) end
		
		local ammo_entity_name, ammo_count = inventory_sync(Inventory.get_inventory(1), Turret.get_inventory(1), ammo_list.artillery_shells, at_Turrets_Set.state.inv_sync)
		at_Turrets_Set.state.inv_sync = ammo_count
		Base.get_inventory(1).clear()
		if ammo_count > 0 then Base.get_inventory(1).insert({name = "dummy", count = ammo_count}) end
		
		if ammo_count > 0 and Turret.name == "at_A"..number.."_t" and Skill.name == "at_A"..number.."_r" and Skill.energy > 0 then
			local area = Artillery_scanner(at_Turrets_Set)
			-- Find Target
			local target
			marks = {}
			if number == 2 then
				if global.at_Target ~= nil then
					marks = global.at_Target
				end
				if #marks > 0 then
					for k,mark in pairs(marks) do
						if mark.valid == false then
							table.remove(global.at_Target, k)
							if #global.AT_Table == 0 then
								global.at_Target = nil
							end
							break
						end
						-- target = {mark}
					end
					target = {marks[math.random(#marks)]}
				end
			end
			
			if target == nil then
				spawner = Base.surface.find_entities_filtered({area = area, type = "unit-spawner"})
				if #spawner > 0 then
					target = {spawner[math.random(#spawner)]}
				else
					worm = Base.surface.find_entities_filtered({area = area, type = "turret"})
					if #worm > 0 then
						target = {worm[math.random(#worm)]}
					end
				end
			end
			
			if target ~= nil then
				-- Attack Target
				local offsetR
				local pos = Base.position
				at_Turrets_Set.etc[2] = at_Turrets_Set.etc[2] + 1
				if #marks > 0 then
					offsetR = 10
				else
					offsetR = 5
				end
				local offsetX = target[1].position.x + math.random(0,offsetR) * math.sin(math.random()*(math.pi*2))
				local offsetY = target[1].position.y + math.random(0,offsetR) * math.sin(math.random()*(math.pi*2))
				
				local newtarget = {offsetX, offsetY}
				
				local speed = (((pos.x - offsetX)^2 + (pos.y - offsetY)^2)^0.5) / 240
				
				
				Base.surface.create_entity({name = "ammo-action", position = {x = pos.x, y = pos.y - 5.625}, force = Base.force, target = {x = pos.x, y = pos.y - 100}, speed = 2})
				Base.surface.create_entity({name = "ammo-shadow", position = {x = pos.x, y = pos.y}, force = Base.force, target = newtarget, speed = speed})
				Base.surface.create_entity({name = "muzzle-flash", position = {x = pos.x, y = pos.y - 5.625}, force = Base.force, target = {x = pos.x, y = pos.y - 5.25}, speed = 0.01})
				Base.surface.create_entity({name = ammo_entity_name, position = {x = offsetX, y = offsetY - 240}, force = Base.force, target = newtarget, speed = 1})
				Base.surface.create_entity({name = "at_Artillery_shoot_sound", position = pos})
				
				local units = Base.surface.find_enemy_units(newtarget, 10 * number)
				if units and #units > 0 then
					for _, unit in pairs(units) do
						unit.set_command({type = defines.command.attack, target = Turret, distraction = defines.distraction.by_anything})
					end
				end
				
				-- Reduce Ammo
				Base.remove_item({name = "dummy", count = 1})
				Inventory.remove_item({name = ammo_entity_name, count = 1})
				Turret.remove_item({name = ammo_entity_name, count = 1})
				
				
				-- Delay between shots
				if #marks > 0 then
					delay = 3 * 5 * (3 - number)
				else
					delay = 3 * 10 * (3 - number) -- 20
				end
				
			else
				delay = 3 * 1
			end
		end
		
	elseif Base.name == "at_LC_b" then
		local Inventory = Entities.inventory
		local Turret = Entities.turret
		
		local ammo_entity_name ,ammo_count = inventory_sync(Inventory.get_inventory(1), Turret.get_inventory(1), ammo_list.capsules, at_Turrets_Set.state.inv_sync)
		at_Turrets_Set.state.inv_sync = ammo_count
		
		Base.get_inventory(1).clear()
		if ammo_count > 0 then Base.get_inventory(1).insert({name = "dummy", count = ammo_count}) end
		
		if ammo_count > 0 and Turret.name == "at_LC_t" then
			
			local range = 30
			local pos = Base.position
			
			-- Find Target
			local target = Base.surface.find_nearest_enemy{position = pos, max_distance = range}
			
			if target ~= nil then
				-- Attack Target
				Base.surface.create_entity({name = ammo_entity_name, position = pos, force = Base.force, target = target, speed = 0.75})
				Base.surface.create_entity({name = "at_LC_turret_sound", position = pos})
				
				-- Reduce Ammo
				Base.remove_item({name = "dummy", count = 1})
				Inventory.remove_item({name = ammo_entity_name, count = 1})
				Turret.remove_item({name = ammo_entity_name, count = 1})
				
				-- Delay between shots
				delay = 3 * 2 -- 2
			end
		end
		
	elseif Base.name == "at_CR_turret" then
		
		local Inventory1 = Entities.inventory[1]
		local Inventory2 = Entities.inventory[2]
		local Turret1 = Entities.turret[1]
		local Turret2 = Entities.turret[2]
		
		if not ammo_list.rockets then
			input_ammo()
		end
		
		local ammo_entity_name_s, ammo_count_s = inventory_sync(Inventory1.get_inventory(1), Turret1.get_inventory(1), ammo_list.shells, at_Turrets_Set.state.inv_sync[1])
		local ammo_entity_name_r, ammo_count_r = inventory_sync(Inventory2.get_inventory(1), Turret2.get_inventory(1), ammo_list.rockets, at_Turrets_Set.state.inv_sync[2])
		at_Turrets_Set.state.inv_sync[1] = ammo_count_s
		at_Turrets_Set.state.inv_sync[2] = ammo_count_r
		
		Base.get_inventory(1).clear()
		if ammo_count_r >= ammo_count_s then Base.get_inventory(1).insert({name = "dummy", count = ammo_count_r})
		else Base.get_inventory(1).insert({name = "dummy", count = ammo_count_s}) end
		
		local maxrange = 50
		delay = 1
		
		-- local body_direction = at_Turrets_Set[1].direction
		-- direction = 0(north) ~ 7
		
		if (ammo_count_s + ammo_count_r) > 0 and Turret1.name == "at_CR_t1" then
		
			local pos = Base.position
			local target = Base.surface.find_enemy_units(pos, maxrange)
			
			-- Fire at Enemy
			if #target ~= 0 then
				
				if at_Turrets_Set.etc == 0 then
					at_Turrets_Set.etc = 1
					Turret1.active = false
					Turret2.active = false
					delay = 3 * 2
					Base.surface.create_entity({name = "flying-text", position = pos, text = "Reload Ammo 2s", color = {r = 0.7, g = 0.7}})
				else
					at_Turrets_Set.etc = 0
					Turret1.active = true
					Turret2.active = true
					delay = 3 * 5
					Base.surface.create_entity({name = "flying-text", position = pos, text = "Fire!", color = {r = 1}})
				end
			end
		end
	end
	
	if delay == 0 then
		delay = 3 * 10
	end
	at_Turrets_Set.state.delay = delay
end


-- DeBug Messages 
function writeDebug(message)
	if game.players[1].name == "sore68" then
		game.players[1].print(tostring(message))
	end
end

function inventory_sync(inv_1, inv_2, ammo_table, check)

	local stack, _c, _n = {}, {0, 0}
	
	if not inv_1.is_empty() then
		for _, x in pairs(ammo_table) do
			if inv_1[1].prototype.name == x[1] then
				_n = x[2]
				_c[1] = 1
				break
			end
		end
		table.insert(stack, {name = inv_1[1].prototype.name, count = inv_1[1].count})
	end
	if not inv_2.is_empty() then
		table.insert(stack, {name = inv_2[1].prototype.name, count = inv_2[1].count})
		_c[2] = 1
	end
	writeDebug("#stack = " .. #stack)
	
	for index, shell in pairs(stack) do
		writeDebug(index .. ". name = " .. shell.name .. " count = " .. shell.count .. " : ".. _c[1] .. " / " .. _c[2])
	end
	
	if _c[1] == 1 then
		if _c[2] == 1 then
			if stack[1].name == stack[2].name then
				check = stack[1].count + stack[2].count - check
			else
				check = stack[1].count
			end
		else
			check = stack[1].count
		end
	else
		check = 0
	end
	-- writeDebug("check = " .. check)
	inv_1.clear()
	inv_2.clear()
	if check > 0 then
		inv_1.insert({name = stack[1].name, count = check})
		inv_2.insert({name = stack[1].name, count = check})
		if inv_1.valid and inv_2.valid then writeDebug("True") else writeDebug("False") end
	end
	
	return _n, check

end

function AddMark(event)

	if event.entity.name == 'target-cloud' then
		if global.at_Target == nil then
			global.at_Target = {}
		end
		table.insert(global.at_Target, event.entity)
		event.entity.surface.create_entity({name = "capsule_sound", position = event.entity.position})
		
	end
end

function Recall_Items(entity, player_index)
	local inv = entity.get_inventory(1)
	if not inv.is_empty() then
		if player_index then
			game.players[player_index].insert({name = inv[1].prototype.name, count = inv[1].count})
		else
			entity.surface.create_entity{name = "item-on-ground", position = entity.position, stack = {name = inv[1].prototype.name, count = inv[1].count}}.order_deconstruction(entity.force)
		end
	end
end

function On_Deconstruction(event)
	
end

function On_Destruction(event)
	
	if string.sub(event.entity.name, 1, 3) == "at_" then
		local entity = event.entity
		
		if event.player_index or event.robot then
			local pos = entity.position
			local entities = entity.surface.find_entities_filtered{area = {{pos.x - 2, pos.y - 2}, {pos.x + 2, pos.y + 2}}, type = "logistic-container"}
			for _, x in pairs(entities) do
				if string.sub(x.name, 1, 3) == "at_" and string.sub(x.name, 6, 7) == "_i" then
					Recall_Items(x, event.player_index)
				end
			end
			entities = entity.surface.find_entities_filtered{area = {{pos.x - 2, pos.y - 2}, {pos.x + 2, pos.y + 2}}, type = "ammo-turret"}
			for _, x in pairs(entities) do
				if string.sub(x.name, 1, 3) == "at_" and string.sub(x.name, 6, 7) == "_b" then
					x.get_inventory(1).clear()
				end
			end
		end
	end
end