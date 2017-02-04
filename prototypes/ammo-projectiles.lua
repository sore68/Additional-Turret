local math3d = require "math3d"
local laser_acceleration = 0-- .05

local electronic_tint = {r = 0.5, g = 0.5, b = 0.5, a = 0.3}
local electronic_duration_in_ticks = 0.5 * 60 --1*60 = 1s
local electronic_damage_per_tick = { amount = 5 / 60, type = "electric" }

-- local poison_tint = {r = 0.1, g = 0.5, b = 0.3, a = 0.5}
-- local poison_duration_in_ticks = 10*60
-- local poison_damage_per_tick = { amount = 5 / 60, type = "poison" }



local animation_rocket = {
	filename = "__base__/graphics/entity/rocket/rocket.png",
	frame_count = 8,
	line_length = 8,
	width = 9,
	height = 35,
	shift = {0, 0},
	priority = "high"
}

local shadow_rocket = {
	filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
	frame_count = 1,
	width = 7,
	height = 24,
	priority = "high",
	shift = {0, 0}
}

local smoke_rocket = {
	{
		name = "smoke-fast",
		deviation = {0.15, 0.15},
		frequency = 1,
		position = {0, -1},
		slow_down_factor = 1,
		starting_frame = 3,
		starting_frame_deviation = 5,
		starting_frame_speed = 0,
		starting_frame_speed_deviation = 5
	}
}

local animation_cannon = {
	filename = "__base__/graphics/entity/bullet/bullet.png",
	frame_count = 1,
	width = 3,
	height = 50,
	priority = "high"
}

local animation_fake = {
	filename = "__base__/graphics/terrain/blank.png",
	frame_count = 1,
	width = 1,
	height = 1,
	priority = "high"
}

function cannon_cluster(inputs)
return
{
	type = "cluster",
	cluster_count = inputs.cluster_count and inputs.cluster_count or 3,
	distance = inputs.distance and inputs.distance or 3,
	distance_deviation = inputs.distance and inputs.distance/2 or 3/2,
	action_delivery =
	{
		type = "projectile",
		projectile = inputs.projectile,
		direction_deviation = inputs.direction_deviation and inputs.direction_deviation or 0.6,
		starting_speed = inputs.starting_speed and inputs.starting_speed or 1,
		starting_speed_deviation = inputs.starting_speed_deviation and inputs.starting_speed_deviation or 0.3}
}
end
-- cannon_cluster{cluster_count=, distance=, projectile="", direction_deviation=0.6, starting_speed=1 ,starting_speed_deviation=0.3}

function sticker_set(inputs)
return
{
	type = "sticker",
	name = inputs.name,
	flags = {"not-on-map"},
	
	animation = 
	{
		filename = inputs.filename and inputs.filename or "__Additional-Turret__/graphics/entity/spark.png",
		line_length = inputs.line_length and inputs.line_length or 5,
		width = inputs.width and inputs.width or 64,
		height = inputs.height and inputs.height or 64,
		frame_count = inputs.frame_count and inputs.frame_count or 5,
		axially_symmetrical = false,
		direction_count = inputs.direction_count and inputs.direction_count or 1,
		blend_mode = "normal",
		animation_speed = 0.5,
		scale = inputs.scale and inputs.scale or 0.5,
		tint = inputs.tint and inputs.tint or electric_tint,
		shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1),
	},
	duration_in_ticks = inputs.duration_in_ticks and inputs.duration_in_ticks or 7 * 60,
	target_movement_modifier = inputs.target_movement_modifier and inputs.target_movement_modifier or 0.4,
	damage_per_tick = inputs.damage_per_tick and inputs.damage_per_tick or electric_damage_per_tick
}
end
-- sticker_set{name="", filename="", line_length=, width=, height=, frame_count=, direction_count=, scale=, tint =, duration_in_ticks =, target_movement_modifier =, damage_per_tick =},

data:extend({
--------------cannon
{
	type = "projectile",
	name = "small-cannon-shell",
	flags = {"not-on-map"},
	acceleration = 0,
	piercing_damage = 150,
	action =
	{
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "damage",
					damage = { amount = 75 , type = "physical"}
				},
				{
					type = "damage",
					damage = { amount = 25 , type = "explosion"}
				},
				{
					type = "create-entity",
					entity_name = "small-scorchmark",
					check_buildability = true
				}
			}
		}
	},
	animation = animation_cannon,
},
{
	type = "projectile",
	name = "small-explosive-cannon-shell",
	flags = {"not-on-map"},
	acceleration = 0,
	piercing_damage = 15,
	action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = { amount = 15, type = "physical"}
					},
					{
						type = "create-entity",
						entity_name = "explosion"
					}
				}
			}
		},
		{
			type = "area",
			perimeter = 4.5,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 40, type = "explosion"}
					},
					{
						type = "create-entity",
						entity_name = "explosion"
					}
				}
			}
		}
	},
	animation = animation_cannon,
},
{
	type = "projectile",
	name = "cluster-cannon-shell",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "explosion", --"big-explosion",
						check_buildability = true
					},
					{
						type = "damage",
						damage = { amount = 40 , type = "explosion"}
					},
				}
			}
		},
		cannon_cluster{projectile = "small-explosive-cannon-shell",},
	},
	animation = animation_cannon,
},
{
	type = "projectile",
	name = "fire-cannon-shell",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					type = "create-entity",
					entity_name = "explosion"
				}
			}
		},
		{
			type = "area",
			perimeter = 4,
			force = "enemy",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 30, type = "explosion"}
					},
					{
						type = "create-entity",
						entity_name = "fire-flame-small"
					},
					{
						type = "create-sticker",
						sticker = "fire-sticker"
					},
					{
						type = "create-entity",
						entity_name = "explosion"
					},
				}
			}
		}
	},
	animation = animation_cannon,
},
{
	type = "projectile",
	name = "fire-cluster-cannon-shell",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = { amount = 20 , type = "explosion"}
					},
					{
						type = "create-entity",
						entity_name = "explosion", --"big-explosion",
						check_buildability = true
					},
					{
						type = "create-sticker",
						sticker = "fire-sticker"
					},
					{
						type = "create-entity",
						entity_name = "fire-flame-small"
					},
				}
			}
		},
		cannon_cluster{cluster_count = 5, projectile = "fire-cannon-shell",},
	},
	animation = animation_cannon,
},

--------------rocket
{
	type = "projectile",
	name = "small-rocket",
	flags = {"not-on-map"},
	acceleration = 0.01,
	action =
	{
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "create-entity",
					entity_name = "explosion"
				},
				{
					type = "damage",
					damage = {amount = 30, type = "explosion"}
				},
				{
					type = "create-entity",
					entity_name = "small-scorchmark",
					check_buildability = true
				}
			}
		}
	},
	animation = animation_rocket,
	shadow = shadow_rocket,
	smoke = smoke_rocket,
},
{
	type = "projectile",
	name = "small-explosive-rocket",
	flags = {"not-on-map"},
	acceleration = 0.01,
	action =
	{
		type = "area",
		perimeter = 7,
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "damage",
					damage = {amount = 20, type = "explosion"}
				},
				{
					type = "create-entity",
					entity_name = "explosion"
				}
			}
		}
	},
	animation = animation_rocket,
	shadow = shadow_rocket,
	smoke = smoke_rocket,
},
{
	type = "projectile",
	name = "acid-rocket",
	flags = {"not-on-map"},
	acceleration = 0.005,
	action =
	{
		type = "area",
		perimeter = 7,
		force = "enemy",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "damage",
					damage = {amount = 10, type = "explosion"}
				},
				{
					type = "create-entity",
					entity_name = "acid-flame-small"
				},
				{
					type = "create-sticker",
					sticker = "acid-sticker"
				},
				{
					type = "create-entity",
					entity_name = "explosion"
				},
			}
		}
	},
	animation = animation_rocket,
	shadow = shadow_rocket,
	smoke = smoke_rocket,
},

--------------laser beam
{
	type = "projectile",
	name = "electron-beam-1",
	flags = {"not-on-map"},
	acceleration = laser_acceleration,
	action =
	{
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "create-entity",
					entity_name = "laser-bubble"
				},
				{
					type = "damage",
					damage = { amount = 125, type = "laser"}
				},
				{
					type = "create-sticker",
					sticker = "electronic-sticker"
				},
			}
		}
	},
	animation = animation_fake,
},
{
	type = "projectile",
	name = "electron-beam-2",
	flags = {"not-on-map"},
	direction_only = true,
	acceleration = laser_acceleration,
	action =
	{
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
				{
					type = "create-entity",
					entity_name = "laser-bubble"
				},
			}
		}
	},
	light = {intensity = 0.5, size = 10},
	animation =
	{
		filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
		tint = {r=1, g=0.78, b=0},
		scale = 5,
		frame_count = 1,
		width = 12,
		height = 33,
		priority = "high",
		blend_mode = "additive"
	},
},
{
	type = "projectile",
	name = "at-advanced-laser-1",
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
				{
					type = "create-entity",
					entity_name = "laser-bubble"
				},
				{
					type = "damage",
					damage = { amount = 5, type = "laser"}
				},
			}
		}
	},
	light = {intensity = 0.5, size = 10},
	animation =
	{
		filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
		tint = {r=0.02, g=1, b=0.38},
		frame_count = 1,
		width = 12,
		height = 33,
		priority = "high",
		blend_mode = "additive"
	},
},

------------- dummy
-- {
	-- type = "projectile",
	-- name = "dummy_capsule",
	-- flags = {"not-on-map"},
	-- acceleration = 0,
	-- action =
	-- {
		-- type = "direct",
		-- action_delivery =
		-- {
			-- type = "instant",
			-- target_effects =
			-- {
			-- }
		-- }
	-- },
	-- animation = animation_fake,
-- },
{
	type = "projectile",
	name = "dummy_entity",
	flags = {"not-on-map"},
	acceleration = 0,
	animation = animation_fake,

},

------------- artillery
{
	type = "projectile",
	name = "artillery-cluster",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "explosion",
						check_buildability = true
					},
				}
			}
		},
		{
			type = "area",
			perimeter = 10,
			-- force = "enemy",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-sticker",
						sticker = "acid-sticker"
					},
					{
						type = "create-sticker",
						sticker = "fire-sticker"
					},
					{
						type = "create-fire",
						entity_name = "acid-flame"
					},
					{
						type = "create-fire",
						entity_name = "fire-flame"
					}
				}
			}
		},
		-- {
			-- type = "cluster",
			-- cluster_count = 7,
			-- distance = 3,
			-- distance_deviation = 3,
			-- action_delivery =
			-- {
				-- type = "stream",
				-- stream = "flamethrower-fire-stream",
				-- direction_deviation = 0.6,
				-- starting_speed = 1.5,
				-- starting_speed_deviation = 0.3
			-- }
		-- },
		-- {
			-- type = "cluster",
			-- cluster_count = 7,
			-- distance = 3,
			-- distance_deviation = 3,
			-- action_delivery =
			-- {
				-- type = "stream",
				-- stream = "flamethrower-acid-stream",
				-- direction_deviation = 0.6,
				-- starting_speed = 1.5,
				-- starting_speed_deviation = 0.3
			-- }
		-- },
		cannon_cluster{cluster_count = 3, distance = 5, projectile = "cluster-cannon-shell",},
	},
	animation = animation_cannon,
},
{
	type = "projectile",
	name = "Artillery_mk1_Ammo",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		cannon_cluster{cluster_count=5, distance=6, distance_deviation=4, projectile="artillery-cluster", direction_deviation=0.6, starting_speed=1.5 ,starting_speed_deviation=0.5}
	},
	
	animation = 
	{ 
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
		frame_count = 1,
		width = 32,
		height = 32,
		blend_mode = "additive",
		tint = {r=0.2,g=0.2,b=0.2},
		line_length = 1,
		axially_symmetrical = false,
		direction_count = 1,
		animation_speed = 2,
		shift = {0, 0},
	},
	
	shadow =
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
		frame_count = 1,
		width = 32,
		height = 32,
		priority = "high"
	},
},
{
	type = "projectile",
	name = "Artillery_mk2_Ammo",
	flags = {"not-on-map"},
	acceleration = 0,
	action =
	{
		{
			type = "area",
			perimeter = 20,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-sticker",
						sticker = "acid-sticker"
					},
					{
						type = "create-sticker",
						sticker = "fire-sticker"
					},
					{
						type = "create-fire",
						entity_name = "acid-flame"
					},
					{
						type = "create-fire",
						entity_name = "fire-flame"
					}
				}
			}
		},
		cannon_cluster{cluster_count=5, distance=20, distance_deviation=6, projectile="Artillery_mk1_Ammo", direction_deviation=0.6, starting_speed=1.7, starting_speed_deviation=0.7}
	},
	
	animation = 
	{ 
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
		frame_count = 1,
		width = 32,
		height = 32,
		blend_mode = "additive",
		tint = {r=0.7,g=0.2,b=0.3},
		line_length = 1,
		axially_symmetrical = false,
		direction_count = 1,
		animation_speed = 2,
		shift = {0, 0},
	},
	
	shadow =
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
		frame_count = 1,
		width = 32,
		height = 32,
		priority = "high"
	},
},
{
	type = "projectile",
	name = "muzzle-flash",
	flags = {"not-on-map"},
	acceleration = 0,
	animation = 
	{
		filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
		priority = "extra-high",
		width = 112,
		height = 94,
		frame_count = 54,
		line_length = 6,	
		animation_speed = 0.5
	},
	light = {intensity = 0.5, size = 6}

},
{
	type = "projectile",
	name = "ammo-action",
	flags = {"not-on-map"},
	acceleration = 0,
	animation = 
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
		frame_count = 1,
		width = 32,
		height = 32,
		blend_mode = "additive",
		tint = {r=0,g=0.2,b=0.7,a=0.9},
		line_length = 1,
		axially_symmetrical = false,
		direction_count = 1,
		animation_speed = 2,
		shift = {0, 0},
	},

},
{
	type = "projectile",
	name = "ammo-shadow",
	flags = {"not-on-map"},
	acceleration = 0,
	animation = 
	{
		filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
		frame_count = 1,
		width = 32,
		height = 32,
		priority = "high"
	},

},
------------------
{
	type = "projectile",
	name = "guid-flash",
	flags = {"not-on-map"},
	acceleration = 0,
	animation = 
	{
		filename = "__core__/graphics/visualization-construction-radius.png",
		priority = "extra-high",
		width = 12,
		height = 12,
		frame_count = 1,
		line_length = 1,	
		animation_speed = 0.5
	},
	light = {intensity = 0.5, size = 6}

},
})

data:extend({
sticker_set{name="electronic-sticker", filename="__Additional-Turret__/graphics/entity/spark.png", line_length=5, width=64, height=64, frame_count=5, direction_count=1, scale=0.5, tint = electronic_tint, duration_in_ticks=electronic_duration_in_ticks, target_movement_modifier=0.4, damage_per_tick=electronic_damage_per_tick},
-- sticker_set{name="poison-sticker", filename="__Additional-Turret__/graphics/entity/spark.png", line_length=5, width=64, height=64, frame_count=5, direction_count=1, scale=0.5, tint = poison_tint, duration_in_ticks=poison_duration_in_ticks, target_movement_modifier=0.4, damage_per_tick=poison_damage_per_tick},
})