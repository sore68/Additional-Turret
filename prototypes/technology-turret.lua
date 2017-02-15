function turret_unlock_1(inputs)
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
			recipe = inputs.recipe,
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
			{"alien-science-pack", 1},
		},
		time = inputs.times,
	},
	upgrade = true,
	order = inputs.order,
}
end

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
			{"alien-science-pack", 1},
		},
		time = inputs.times,
	},
	upgrade = true,
	order = inputs.order,
}
end




data:extend({
turret_unlock_2{name = "turret-mk1-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk1-tech.png",
		recipe_1 = "at-cannon-turret-mk1",
		recipe_2 = "at-rocket-turret-mk1",
		prerequisites = {"tanks"},
		count = 120, times = 45, order = "e-c-c-a"},
turret_unlock_2{name = "turret-mk2-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk2-tech.png",
		recipe_1 = "at-cannon-turret-mk2",
		recipe_2 = "at-rocket-turret-mk2",
		prerequisites = {"turret-mk1-unlock"},
		count = 180, times = 90, order = "e-c-c-b"},
turret_unlock_1{name = "turret-mk3-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk3-tech.png",
		recipe = "at_CR_b",
		prerequisites = {"turret-mk2-unlock", "military-4"},
		count = 240, times = 90, order = "e-c-c-c"},

turret_unlock_1{name = "acid-thrower", icon = "__Additional-Turret__/graphics/technology/acid-thrower.png",
		recipe = "at-acidthrower-turret",
		prerequisites = {"flame-thrower"},
		count = 30, times = 10, order = "e-c-b-a"},

turret_unlock_1{name = "advanced-laser-research", icon = "__Additional-Turret__/graphics/technology/ad-laser-turret.png",
		recipe = "at-advanced-laser",
		prerequisites = {"laser"},
		count = 250, times = 45, order = "a-h-e"},
turret_unlock_2{name = "beam-research", icon = "__Additional-Turret__/graphics/technology/beam-turret.png",
		recipe_1 = "at-beam-turret-mk1",
		recipe_2 = "at-beam-turret-mk2",
		prerequisites = {"laser"},
		count = 300, times = 60, order = "a-h-d"},

turret_unlock_1{name = "capsule-turret", icon = "__Additional-Turret__/graphics/technology/lc-tech.png",
		recipe = "at_LC_b",
		prerequisites = {"advanced-laser-research", "military-3"},
		count = 250, times = 60, order = "e-c-c"},

})





data:extend({
{
  type = "technology",
  name = "artillery-set",
  icon_size = 128,
  icon = "__Additional-Turret__/graphics/technology/artillery-tech.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "at_A1_b"
    },
	{
      type = "unlock-recipe",
      recipe = "at_A2_b"
    },
	{
      type = "unlock-recipe",
      recipe = "Artillery_mk1_Ammo"
    },
	{
      type = "unlock-recipe",
      recipe = "Artillery_mk2_Ammo"
    },
	{
      type = "unlock-recipe",
      recipe = "target-marker"
    }
  },
  prerequisites = {"upgrade-shells-3"},
  unit =
  {
    count = 500,
    ingredients =
    {
      {"alien-science-pack", 1},
      {"science-pack-1", 1},
      {"science-pack-2", 1},
      {"science-pack-3", 1}
    },
    time = 45
  },
  order = "e-c-f"
}
})