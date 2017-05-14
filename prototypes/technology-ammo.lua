function turret_unlock_2(inputs)
return
{
	type = "technology",
	name = inputs.name,
	icon_size = 128,
	icon = inputs.icon,
	effects =
	{
		{
			type = "unlock-recipe",
			recipe = inputs.recipe_1,
		},
		{
			type = "unlock-recipe",
			recipe = inputs.recipe_2,
		}
	},
	prerequisites = inputs.prerequisites,
	unit =
	{
		count = inputs.count,
		ingredients =
		{
			{"science-pack-1", 1},
			{"science-pack-2", 1},
			{"science-pack-3", 1},
			{"military-science-pack", 1},
		},
		time = inputs.times,
	},
	upgrade = true,
	order = inputs.order,
}
end



data:extend({
turret_unlock_2{name = "small-shells", icon = "__Additional-Turret__/graphics/technology/shells.png",
		recipe_1 = "small-cannon-shell",
		recipe_2 = "small-explosive-cannon-shell",
		prerequisites = {"turret-mk1-unlock"},
		count = 50, times = 30, order = "e-c-d"},

turret_unlock_2{name = "small-rockets", icon = "__Additional-Turret__/graphics/technology/rockets.png",
		recipe_1 = "small-rocket",
		recipe_2 = "small-explosive-rocket",
		prerequisites = {"turret-mk1-unlock", "explosive-rocketry"},
		count = 50, times = 30, order = "e-g-b"},

turret_unlock_2{name = "upgrade-shells-1", icon = "__Additional-Turret__/graphics/technology/ammo-upgrade.png",
		recipe_1 = "cluster-cannon-shell",
		recipe_2 = "explosive-multiple-rocket",
		prerequisites = {"turret-mk2-unlock", "small-shells", "small-rockets", "military-4"},
		count = 100, times = 30, order = "e-c-f"},

turret_unlock_2{name = "upgrade-shells-2", icon = "__Additional-Turret__/graphics/technology/ammo-upgrade.png",
		recipe_1 = "fire-cannon-shell",
		recipe_2 = "acid-rocket",
		prerequisites = {"upgrade-shells-1", "piranha-research"},
		count = 150, times = 45, order = "e-c-f"},

turret_unlock_2{name = "upgrade-shells-3", icon = "__Additional-Turret__/graphics/technology/ammo-upgrade.png",
		recipe_1 = "fire-cluster-cannon-shell",
		recipe_2 = "acid-multiple-rocket",
		prerequisites = {"upgrade-shells-2"},
		count = 200, times = 60, order = "e-c-f"},

})