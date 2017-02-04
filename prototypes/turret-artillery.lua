local at_A1_turret_shift = {0.5, -2.25}
local at_A2_turret_shift = {0.5, -2.25}


function at_A1_turret_attack()
return
{
	layers = 
	{
		{
			filename = "__Additional-Turret__/graphics/entity/artillery-big-mk1-attack.png",
			priority = "medium",
			width = 260,
			height = 295,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = at_A1_turret_shift,
		}
	}
}
end

function at_A2_turret_attack()
return
{
	layers = 
	{
		{
			filename = "__Additional-Turret__/graphics/entity/artillery-big-mk2-attack.png",
			priority = "medium",
			width = 260,
			height = 295,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = at_A2_turret_shift,
		}
	}
}
end

function blank()
return
{
	layers = 
	{
		{
			filename = "__base__/graphics/terrain/blank.png",
			width = 1,
			height = 1,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = at_A2_turret_shift,
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
			width = 256,
			height = 192,
			direction_count = 1,
			frame_count = 1,
			axially_symmetrical = false,
			shift = {0, 0},
		}
	}
}
end


data:extend({
------------ at_1
{
	type = "ammo-turret",
	name = "at_A1_b",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable"},
	minable = { mining_time = 3, result = "at_A1_b" },
	order = "b[turret]-d[artillery]-a[heavy]",
	open_sound = { filename = "__Additional-Turret__/sound/Artillery_open_sound.ogg", volume = 0.7 },
	max_health = 1200,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	selection_box = {{ -4, -3}, {4, 3}},
	
	folding_speed = 0.04,
	inventory_size = 1,
	automated_ammo_count = 10,
	
	folded_animation = blank{},
	folding_animation = blank{},
	base_picture = base{},
	

	attack_parameters =
	{
		type = "projectile",
		ammo_category = "dummy",
		cooldown = 1500,
		range = 300,
		min_range = 100,
		projectile_creation_distance = 1.8,
		action ={},
	},
	call_for_help_radius = 40
},

{
	type = "ammo-turret",
	name = "at_A1_t",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-a[heavy]",
	open_sound = { filename = "__Additional-Turret__/sound/Artillery_open_sound.ogg", volume = 0.7 },
	max_health = 600,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	-- selection_box = {{ -4, -3}, {4, 3}},
	folding_speed = 0.04,
	inventory_size = 1,
	automated_ammo_count = 10,
	emissions_per_tick = 0.5,
	
	folded_animation = at_A1_turret_attack{},
	folding_animation = at_A1_turret_attack{},
	
	vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

	attack_parameters =
	{
		type = "projectile",
		ammo_category = "artillery-mk1-shell",
		cooldown = 1500,
		range = 0,
		projectile_creation_distance = 1.8,
		action ={},
	},
	call_for_help_radius = 40
},

{
	type = "logistic-container",
	name = "at_A1_i",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "placeable-off-grid"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-a[heavy]",
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{-0.5, -0.5 }, {0.5, 0.5}}, --{{-3.2, -3.2 }, {3.2, 3.2}},
	selection_box = {{-0.5, -0.5 }, {0.5, 0.5}},
	fast_replaceable_group = "container",
	inventory_size = 1,
	logistic_mode = "requester",
	picture = blank{},
},

{
	type = "radar",
	name = "at_A1_r",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"placeable-neutral", "player-creation"},
	selectable_in_game = false,
	max_health = 600,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{ -3.6, -2.6}, {3.6, 2.6}},
	-- selection_box = {{ -4, -3}, {4, 3}},
	order = "b[turret]-d[artillery]-a[heavy]",
	energy_per_sector = "10MJ",
	max_distance_of_nearby_sector_revealed = 3,
	max_distance_of_sector_revealed = 8,
	energy_per_nearby_scan = "1MW",
	energy_source =
	{
		type = "electric",
		usage_priority = "secondary-input"
	},
	energy_usage = "1MW",
	pictures = blank{},

	working_sound =
	{
		sound =
		{
			filename = "__Additional-Turret__/sound/Artillery_base_sound.ogg",
			volume = 0.7
		},
		match_volume_to_activity = true,
	},
},
{
	type = "container",
	name = "at_A1_c",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-a[heavy]",
	max_health = 600 * 1.3,
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	selection_box = {{ -4, -3}, {4, 3}},
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


------------ at_2
{
	type = "ammo-turret",
	name = "at_A2_b",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable"},
	minable = { mining_time = 3, result = "at_A2_b" },
	order = "b[turret]-d[artillery]-b[experimental]",
	open_sound = { filename = "__Additional-Turret__/sound/Artillery_open_sound.ogg", volume = 1 },
	max_health = 3000,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	selection_box = {{ -4, -3}, {4, 3}},
	
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
		cooldown = 1500,
		range = 500,
	},
	
	call_for_help_radius = 40
},

{
	type = "ammo-turret",
	name = "at_A2_t",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-b[experimental]",
	open_sound = { filename = "__Additional-Turret__/sound/Artillery_open_sound.ogg", volume = 1 },
	max_health = 1500,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	-- selection_box = {{ -4, -3}, {4, 3}},
	folding_speed = 0.04,
	inventory_size = 1,
	automated_ammo_count = 10,
	emissions_per_tick = 0.5,
	
	folded_animation = at_A2_turret_attack{},
	folding_animation = at_A2_turret_attack{},
	
	vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

	attack_parameters =
	{
		type = "projectile",
		ammo_category = "artillery-mk1-shell",
		cooldown = 1500,
		range = 0,
		projectile_creation_distance = 1.8,
		action ={},
	},
	call_for_help_radius = 40
},

{
	type = "logistic-container",
	name = "at_A2_i",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"placeable-neutral", "placeable-player", "player-creation", "placeable-off-grid"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-b[experimental]",
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{-0.5, -0.5 }, {0.5, 0.5}}, --{{-3.2, -3.2 }, {3.2, 3.2}},
	selection_box = {{-0.5, -0.5 }, {0.5, 0.5}},
	fast_replaceable_group = "container",
	inventory_size = 1,
	logistic_mode = "requester",
	picture = blank{},
},

{
	type = "radar",
	name = "at_A2_r",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"placeable-neutral", "player-creation"},
	selectable_in_game = false,
	max_health = 1500,
	corpse = "big-remnants",
	dying_explosion = "massive-explosion",
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	-- selection_box = {{ -4, -3}, {4, 3}},
	order = "b[turret]-d[artillery]-b[experimental]",
	energy_per_sector = "100MJ",
	max_distance_of_nearby_sector_revealed = 6,
	max_distance_of_sector_revealed = 16,
	energy_per_nearby_scan = "5MW",
	energy_source =
	{
		type = "electric",
		usage_priority = "secondary-input"
	},
	energy_usage = "10MW",
	pictures = blank{},

	working_sound =
	{
		sound =
		{
			filename = "__Additional-Turret__/sound/Artillery_base_sound.ogg",
			volume = 1
		},
		match_volume_to_activity = true,
	},
},
{
	type = "container",
	name = "at_A2_c",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
	selectable_in_game = false,
	order = "b[turret]-d[artillery]-b[experimental]",
	max_health = 1500 * 1.3,
	collision_box = {{ -3.65, -2.65}, {3.65, 2.65}},
	selection_box = {{ -4, -3}, {4, 3}},
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


------------ target capsule entity
{
	type = "smoke-with-trigger",
	name = "target-cloud",
	flags = {"not-on-map"},
	show_when_smoke_off = true,
	animation =
	{
		filename = "__core__/graphics/shoot-cursor-red.png",
		priority = "low",
		width = 258,
		height = 183,
		frame_count = 1,
		animation_speed = 1,
		line_length = 1,
		scale = 1,
	},
	slow_down_factor = 0,
	affected_by_wind = false,
	cyclic = true,
	duration = 60 * 10, --10sec
	fade_away_duration = 2 * 60,
	spread_duration = 10,
	color = { r = 0.9, g = 0.2, b = 0.2 },
},
{
	type = "projectile",
	name = "target-capsule",
	flags = {"not-on-map"},
	acceleration = 0.005,
	action =
	{
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				type = "create-entity",
				trigger_created_entity = true,
				entity_name = "target-cloud"
			}
		}
	},
	light = {intensity = 0.5, size = 4},
	animation =
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
		frame_count = 1,
		width = 32,
		height = 32,
		priority = "high",
		tint = {r=1.0, g=0.2, b=0.2},
	},
	shadow =
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
		frame_count = 1,
		width = 32,
		height = 32,
		priority = "high"
	},
	smoke = capsule_smoke,
},
})




------------ recipe
data:extend({
{
	type = "recipe",
	name = "at_A1_b",
	enabled = false,
	energy_required = 30,
	ingredients = 
	{
		{"steel-plate", 100},
		{"concrete", 150},
		{"pipe", 100},
		{"processing-unit", 15},
		{"engine-unit", 10},
		{"radar", 20},
	},
	result = "at_A1_b",
},
{
	type = "recipe",
	name = "Artillery_mk1_Ammo",
	enabled = false,
	energy_required = 10,
	ingredients =
	{
		{"piranha-core", 1},
		{"explosives", 5},
		{"steel-plate", 2},
	},
	result = "Artillery_mk1_Ammo",
},
{
	type = "recipe",
	name = "at_A2_b",
	enabled = false,
	energy_required = 45,
	ingredients = 
	{
		{"at_A1_b", 1},
		{"battery", 20},
		{"radar", 20},
		{"processing-unit", 30},
		{"alien-artifact", 30}
	},
	result = "at_A2_b",
},
{
	type = "recipe",
	name = "Artillery_mk2_Ammo",
	enabled = false,
	energy_required = 15,
	ingredients = 
	{
		{"Artillery_mk1_Ammo", 5},
		{"explosives", 5},
		{"steel-plate", 2},
		{"alien-artifact", 2}
	},
	result = "Artillery_mk2_Ammo",
},
{
	type = "recipe",
	name = "target-capsule",
	enabled = false,
	energy_required = 12,
	ingredients = 
	{
		{"poison-capsule", 1},
		{"slowdown-capsule", 1},
		{"explosives", 5},
		{"alien-artifact", 5}
	},
	result = "target-capsule",
},
})




------------ ---item
data:extend({
{
	type = "item",
	name = "at_A1_b",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk1-icon.png",
	flags = {"goes-to-quickbar"},
	subgroup = "defensive-structure",
	order = "b[turret]-d[artillery]-a[heavy]",
	place_result = "at_A1_b",
	stack_size = 1,
},
{
	type = "item",
	name = "at_A2_b",
	icon = "__Additional-Turret__/graphics/icon/turret-artillery-big-mk2-icon.png",
	flags = {"goes-to-quickbar"},
	subgroup = "defensive-structure",
	order = "b[turret]-d[artillery]-b[experimental]",
	place_result = "at_A2_b",
	stack_size = 1,
},


{
	type = "ammo",
	name = "Artillery_mk1_Ammo",
	icon = "__Additional-Turret__/graphics/icon/ammo-artillery-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "artillery-mk1-shell",
		target_type = "direction",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "dummy_entity",
				starting_speed = 0.5,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				}
			}
		},
	},
	subgroup = "ammo",
	order = "e[artillery-shell]-a[heavy]",
	stack_size = 10
},
{
	type = "ammo",
	name = "Artillery_mk2_Ammo",
	icon = "__Additional-Turret__/graphics/icon/ammo-artillery-2-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "artillery-mk2-shell",
		target_type = "direction",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "dummy_entity",
				starting_speed = 0.5,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				}
			}
		},
	},
	subgroup = "ammo",
	order = "e[artillery-shell]-b[experimental]",
	stack_size = 10
},


{
	type = "capsule",
	name = "target-capsule",
	icon = "__Additional-Turret__/graphics/icon/ammo-target-capsule-icon.png",
	flags = {"goes-to-quickbar"},
	capsule_action =
	{
		type = "throw",
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "capsule",
			cooldown = 60*10,
			projectile_creation_distance = 0.6,
			range = 40,
			ammo_type =
			{
				category = "capsule",
				target_type = "position",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "projectile",
						projectile = "target-capsule",
						starting_speed = 0.3
					}
				}
			}
		}
	},
	subgroup = "capsule",
	order = "g[target-capsule]",
	stack_size = 20
},
})