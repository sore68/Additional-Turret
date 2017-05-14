require ("prototypes.others")

function wall_layers()
return
{
	{
		filename = "__Additional-Turret__/graphics/entity/wall/wall-single.png",
		priority = "extra-high",
		scale = 1,
		width = 96,
		height = 96,
		shift = {0, 0}
	},
	-- {
		-- filename = "__Additional-Turret__/graphics/entity/wall/wall-single-shadow.png",
		-- priority = "extra-high",
		-- scale = 3,
		-- width = 47,
		-- height = 32,
		-- shift = {1.078125, 1.5},
		-- draw_as_shadow = true
	-- }
}
end

function blank()
return
{
	filename = "__base__/graphics/terrain/blank.png",
	priority = "medium",
	width = 1,
	height = 1,
	direction_count = 4,
	frame_count = 1,
	axially_symmetrical = false,
	shift = {0, 0},
}
end

function conditional_return(value, data)
	if not value then
		return nil
	else
		return data
	end
end

data:extend({
{
	type = "wall",
	name = "at_wall",
	icon = "__Additional-Turret__/graphics/icon/test.png",
	flags = {"placeable-neutral", "player-creation"},
	collision_box = {{-1.35, -1.35}, {1.35, 1.35}},
	selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
	minable = {mining_time = 0.5, result = "at_wall"},
	fast_replaceable_group = "wall",
	max_health = 1400,
	repair_speed_modifier = 2,
	corpse = "wall-remnants",
	repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
	mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
	vehicle_impact_sound =	{ filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
	attack_reaction =
	{
		{
			range = 5,
			damage_type = "physical",
			reaction_modifier = 0.1,
			action =
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-sticker",
							sticker = "wall-electroic-sticker"
						},
					}
				}
			},
		}
	},
	connected_gate_visualization =
	{
		filename = "__core__/graphics/arrows/underground-lines.png",
		priority = "high",
		width = 64,
		height = 64,
		scale = 0.5
	},
	resistances =
	{
		{
			type = "physical",
			decrease = 6,
			percent = 40
		},
		{
			type = "fire",
			percent = 100
		}
	},
	pictures =
	{
		single =
		{
			layers = wall_layers{}
		},
		straight_vertical =
		{
			{
				layers = wall_layers{}
			},
			{
				layers = wall_layers{}
			},
			{
				layers = wall_layers{}
			}
		},
		straight_horizontal =
		{
			{
				layers = wall_layers{}
			},
			{
				layers = wall_layers{}
			},
			{
				layers = wall_layers{}
			}
		},
		corner_right_down =
		{
			layers = wall_layers{}
		},
		corner_left_down =
		{
			layers = wall_layers{}
		},
		t_up =
		{
			layers = wall_layers{}
		},
		ending_right =
		{
			layers = wall_layers{}
		},
		ending_left =
		{
			layers = wall_layers{}
		}
	},

	wall_diode_green = conditional_return(not data.is_demo,
			{
				filename = "__base__/graphics/entity/gate/wall-diode-green.png",
				width = 21,
				height = 22,
				shift = {0, -0.78125}
			}),
	wall_diode_green_light = conditional_return(not data.is_demo,
			{
				minimum_darkness = 0.3,
				color = {g=1},
				shift = {0, -0.78125},
				size = 1,
				intensity = 0.3
			}),
	wall_diode_red = conditional_return(not data.is_demo,
	{
		filename = "__base__/graphics/entity/gate/wall-diode-red.png",
		width = 21,
		height = 22,
		shift = {0, -0.78125}
	}),
	wall_diode_red_light = conditional_return(not data.is_demo,
	{
		minimum_darkness = 0.3,
		color = {r=1},
		shift = {0, -0.78125},
		size = 1,
		intensity = 0.3
	}),

	circuit_wire_connection_point =
	{
		shadow =
		{
			red = {0.890625, 0.828125},
			green = {0.890625, 0.703125}
		},
		wire =
		{
			red = {-0.28125, -0.71875},
			green = {-0.28125, -0.84375}
		}
	},
	circuit_wire_max_distance = 7.5,
	circuit_connector_sprites = get_circuit_connector_sprites({0, -0.59375}, nil, 6),
	-- default_output_signal = data.is_demo and "signal-green" or "signal-G"
},

{
	type = "item",
	name = "at_wall",
	icon = "__Additional-Turret__/graphics/icon/test.png",
	flags = {"goes-to-quickbar"},
	subgroup = "defensive-structure",
	order = "a[stone-wall]-a[at_wall]",
	place_result = "at_wall",
	stack_size = 50
},
{
	type = "recipe",
	name = "at_wall",
	enabled = true,
	ingredients =
	{
		{"stone-wall", 4},
		{"steel-plate", 1},
		{"copper-cable", 6},
		{"solar-panel", 1},
		{"battery", 1}
	},
	result = "at_wall",
	requester_paste_multiplier = 10
}
})