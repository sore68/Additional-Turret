data:extend({
{
	type = "ammo",
	name = "small-coal-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-c-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-coal-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-c[basic]-a[basic-coal]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "small-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-n-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-c[basic]-b[basic]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "small-explosive-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-e-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-explosive-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-c[basic]-c[explosive]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "cluster-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-e-2-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "cluster-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-c[basic]-d[cluster]",
	magazine_size = 4,
	stack_size = 75
},
{
	type = "ammo",
	name = "fire-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-f-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "fire-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-d[acid]-a[basic]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "fire-cluster-cannon-shell",
	icon = "__Additional-Turret__/graphics/icon/ammo-cannon-f-2-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "cannon-shell",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "fire-cluster-cannon-shell",
				starting_speed = 1,
				source_effects =
				{
					type = "create-explosion",
					entity_name = "explosion"
				},
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-d[acid]-b[cluster]",
	magazine_size = 4,
	stack_size = 75
},





{
	type = "ammo",
	name = "small-coal-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-c-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-coal-rocket",
				starting_speed = 0.4,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-c[basic]-a[basic]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "small-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-n-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-rocket",
				starting_speed = 0.4,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-c[basic]-b[basic]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "small-explosive-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-e-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "small-explosive-rocket",
				starting_speed = 0.4,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-c[basic]-c[explosive]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "explosive-multiple-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-e-2-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "area",
			force = "enemy",
			perimeter = 7,
			action_delivery =
			{
				type = "projectile",
				projectile = "small-explosive-rocket",
				starting_speed = 0.1,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-c[basic]-d[multiple]",
	magazine_size = 4,
	stack_size = 75
},
{
	type = "ammo",
	name = "acid-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-a-1-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "acid-rocket",
				starting_speed = 0.2,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-d[acid]-a[basic]",
	magazine_size = 4,
	stack_size = 100
},
{
	type = "ammo",
	name = "acid-multiple-rocket",
	icon = "__Additional-Turret__/graphics/icon/ammo-rocket-a-2-icon.png",
	flags = {"goes-to-main-inventory"},
	ammo_type =
	{
		category = "rocket",
		action =
		{
			type = "area",
			force = "enemy",
			perimeter = 7,
			action_delivery =
			{
				type = "projectile",
				projectile = "acid-rocket",
				starting_speed = 0.1,
				source_effects =
				{
					type = "create-entity",
					entity_name = "explosion-hit"
				}
			}
		}
	},
	subgroup = "ammo",
	order = "d[rocket-launcher]-d[acid]-b[multiple]",
	magazine_size = 4,
	stack_size = 75
},
{
    type = "ammo",
    name = "acid-thrower-ammo",
    icon = "__Additional-Turret__/graphics/icon/ammo-acid-thrower-icon.png",
    flags = {"goes-to-main-inventory"},
    ammo_type =
    {
      {
        source_type = "default",
        category = "flamethrower",
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "handheld-flamethrower-acid-stream",
            max_length = 15,
            duration = 160,
          }
        }
      },
      {
        source_type = "vehicle",
        consumption_modifier = 1.125,
        category = "flamethrower",
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "tank-flamethrower-fire-stream",
            max_length = 9,
            duration = 160,
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "e[flamethrower]-a[acid-thrower]",
    stack_size = 100
  },

------------- dummy
{
	type = "ammo",
	name = "dummy",
	icon = "__core__/graphics/shoot.png",
	flags = {"hidden"},
	ammo_type =
	{
		category = "dummy",
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "projectile",
				projectile = "dummy_entity",
				starting_speed = 1,
			}
		},
	},
	subgroup = "ammo",
	order = "d[cannon-shell]-c[basic]-a[basic]",
	magazine_size = 10,
	stack_size = 1000
},
})