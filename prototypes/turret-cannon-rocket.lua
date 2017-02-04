function cr_place(inputs)
return
{
	layers = 
	{
		{
			filename = "__Additional-Turret__/graphics/entity/cr-place.png",
			priority = "medium",
			scale = inputs.scale and inputs.scale or 0.875,
			width = 256,
			height = 256,
			frame_count = 1,
			direction_count = 8,
			axially_symmetrical = false,
			run_mode = inputs.run_mode and inputs.run_mode or "forward",
			shift = { 0, 0 },
		}
	}
}
end

function cr_sheet(inputs)
return
{
	layers = 
	{
		{
			filename = "__Additional-Turret__/graphics/entity/cr-sheet.png",
			priority = "medium",
			scale = 0.875,
			width = 256,
			height = 256,
			direction_count = inputs.direction_count and inputs.direction_count or 64,
			frame_count = 1,
			line_length = inputs.line_length and inputs.line_length or 8,
			axially_symmetrical = false,
			run_mode = inputs.run_mode and inputs.run_mode or "forward",
			shift = { 0, 0 },
		}
	}
}
end

function blank(inputs)
return
{
	layers = 
	{
		{
			filename = "__base__/graphics/terrain/blank.png",
			priority = "medium",
			width = 1,
			height = 1,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = at_Artillery_mk2_shift,
		}
	}
}
end

function base()
return
{
	layers = 
	{
		{
			filename = "__Additional-Turret__/graphics/base.png",
			width = 128,
			height = 128,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = {0, 0},
		}
	}
}
end

-- local turret_gun_shift = {
	-- north = {0, -1},
	-- east = {1, 0},
	-- south = {0,	1},
	-- west = { -1, 0},
-- }

data:extend({
{
	type = "ammo-turret",
	name = "at_CR_b",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable"},
	minable = {mining_time = 0.7, result = "at_CR_b"},
	order = "b[turret]-c[base]-e[cannon-rocket-mk3]",
	max_health = 2000,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{-1.65, -1.65 }, {1.65, 1.65}},
	selection_box = {{-2, -2 }, {2, 2}},
	
	folding_speed = 0.04,
	inventory_size = 1,
	automated_ammo_count = 10,
	
	folded_animation = blank{},
	folding_animation = blank{},
	base_picture = base{},
	
	vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	attack_parameters =
	{
		type = "projectile",
		ammo_category = "dummy",
		cooldown = 60,
		range = 40,
		min_range = 15
	},

	call_for_help_radius = 50
},
{
	type = "ammo-turret",
	name = "at_CR_t1",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	-- flags = {"placeable-neutral", "player-creation", "not-repairable"},
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	selectable_in_game = false,
	order = "b[turret]-c[base]-e[mk3]",
	max_health = 1000,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{-1.7, -1.7 }, {1.7, 1.7}},
	selection_box = {{-2, -2 }, {2, 2}},
	rotation_speed = 0.006,
	preparing_speed = 0.06,
	folding_speed = 0.06,
	inventory_size = 1,
	automated_ammo_count = 20,
	attacking_speed = 1,
	
	folded_animation = cr_sheet{direction_count = 8, line_length = 1},
	preparing_animation = cr_sheet{direction_count = 8, line_length = 1},
	prepared_animation = cr_sheet{},
	attacking_animation = cr_sheet{},
	folding_animation = cr_sheet{direction_count = 8, line_length = 1, run_mode = "backward"},
	
	vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	attack_parameters =
	{
		type = "projectile",
		ammo_category = "cannon-shell",
		cooldown = 10,
		projectile_creation_distance = 2.5,
		projectile_center = {0, -1},
		damage_modifier = 1,
		range = 40,
		min_range = 15,
		sound = 
		{
			{
				filename = "__Additional-Turret__/sound/cannon_3_sound.ogg",
				volume = 0.7
			}
		},
	},

	call_for_help_radius = 75
},
{
	type = "ammo-turret",
	name = "at_CR_t2",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	-- flags = {"placeable-player", "player-creation"},
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	selectable_in_game = false,
	order = "b[turret]-c[base]-e[mk3]",
	max_health = 1000,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{-1.7, -1.7 }, {1.7, 1.7}},
	selection_box = {{-2, -2 }, {2, 2}},
	rotation_speed = 0.012,
	preparing_speed = 0.08,
	folding_speed = 0.08,
	inventory_size = 1,
	automated_ammo_count = 20,
	attacking_speed = 0.1,
	
	folded_animation = blank{},
	-- base_picture = cr_place{scale = 0.5},
	base_picture = blank{},
	
	vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	attack_parameters =
	{
		type = "projectile",
		ammo_category = "rocket",
		cooldown = 30,
		projectile_creation_distance = 0,
		projectile_center = {0, 0},
		damage_modifier = 1,
		range = 50,
		min_range = 15,
		sound =
		{
			{
				filename = "__base__/sound/fight/rocket-launcher.ogg",
				volume = 0.7
			}
		},
	},
	call_for_help_radius = 50
},
{
	type = "logistic-container",
	name = "at_CR_i1",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "placeable-off-grid"},
	order = "b[turret]-c[base]-e[mk3]",
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	fast_replaceable_group = "container",
	inventory_size = 1,
	logistic_mode = "requester",
	-- picture = blank{},
	picture = {
		filename = "__base__/graphics/entity/logistic-chest/logistic-chest-requester.png",
		priority = "extra-high",
		width = 38,
		height = 32,
		shift = {0.09375, 0}
		-- shift = {-0.40625, 1.5}
	},
},
{
	type = "logistic-container",
	name = "at_CR_i2",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "placeable-off-grid"},
	order = "b[turret]-c[base]-e[mk3]",
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	fast_replaceable_group = "container",
	inventory_size = 1,
	logistic_mode = "requester",
	-- picture = blank{},
	picture = {
		filename = "__base__/graphics/entity/logistic-chest/logistic-chest-requester.png",
		priority = "extra-high",
		width = 38,
		height = 32,
		shift = {0.09375, 0}
		-- shift = {0.59375, 1.5}
	},
},
{
	type = "container",
	name = "at_CR_c",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
	selectable_in_game = false,
	order = "b[turret]-c[base]-e[mk3]",
	max_health = 1000 * 1.3,
	collision_box = {{-1.7, -1.7 }, {1.7, 1.7}},
	selection_box = {{-2, -2 }, {2, 2}},
	fast_replaceable_group = "container",
	inventory_size = 0,
	picture = {
		filename = "__base__/graphics/entity/remnants/big-remnants.png",
		priority = "extra-high",
		width = 109,
		height = 102,
		frame_count = 1,
		direction_count = 4,
		shift = {0, 0}
	},
},
})


--item
data:extend({
{
	type = "item",
	name = "at_CR_b",
	icon = "__Additional-Turret__/graphics/icon/turret-cr-icon.png",
	flags = {"goes-to-quickbar"},
	subgroup = "defensive-structure",
	order = "b[turret]-c[base]-e[mk3]",
	place_result = "at_CR_b",
	stack_size = 50,
},
})	


--recipe
data:extend({
{
	type = "recipe",
	name = "at_CR_b",
	enabled = false,
	energy_required = 20,
	ingredients =
	{
		{"at-cannon-turret-mk2", 6},
		{"at-rocket-turret-mk2", 3},
		{"steel-plate", 12},
		{"processing-unit", 2},
		{"logistic-chest-requester", 2}
	},
	result = "at_CR_b",
},
})