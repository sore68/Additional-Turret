function turret_unlock(inputs) -- turret_unlock{name, icon, effects, prerequisites, count, ingredients, time, order}
return
{
	type = "technology",
	name = inputs.name,
	icon_size = 128,
	icon = inputs.icon,
	effects = inputs.effects,
	prerequisites = inputs.prerequisites,
	unit =
	{
		count = inputs.count,
		ingredients = inputs.ingredients,
		time = inputs.time
	},
	upgrade = true,
	order = inputs.order,
}
end

local ingredients_list = {{"science-pack-1", 1}, {"science-pack-2", 1}, {"science-pack-3", 1}, {"military-science-pack", 1}, {"high-tech-science-pack", 1}, {"space-science-pack", 1}}

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
			{"military-science-pack", 1},
		},
		time = inputs.time,
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
			{"science-pack-1", 2},
			{"science-pack-2", 1},
		},
		time = inputs.time,
	},
	upgrade = true,
	order = inputs.order,
}
end



ingredients_list = {{"science-pack-1", 1}, {"science-pack-2", 1}, {"science-pack-3", 1}, {"military-science-pack", 1}, {"high-tech-science-pack", 1}, {"space-science-pack", 1}}
data:extend({
turret_unlock{name = "turret-mk1-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk1-tech.png",
	effects = {{type = "unlock-recipe", recipe = "at-cannon-turret-mk1"},
		{type = "unlock-recipe", recipe = "at-rocket-turret-mk1"},
		{type = "unlock-recipe", recipe = "small-coal-cannon-shell"},
		{type = "unlock-recipe", recipe = "small-coal-rocket"}},
	prerequisites = {"turrets"}, 
	count = 200, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[4]}, time = 60, order = "e-c-c-a"},

turret_unlock{name = "turret-mk2-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk2-tech.png",
	effects = {{type = "unlock-recipe", recipe = "at-cannon-turret-mk2"},
		{type = "unlock-recipe", recipe = "at-rocket-turret-mk2"}},
	prerequisites = {"turret-mk1-unlock", "military-2"}, 
	count = 200, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4]}, time = 60, order = "e-c-c-b"},

turret_unlock{name = "turret-mk3-unlock", icon = "__Additional-Turret__/graphics/technology/turret-mk3-tech.png",
	effects = {{type = "unlock-recipe", recipe = "at_CR_b"}},
	prerequisites = {"turret-mk2-unlock", "military-3"}, 
	count = 500, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4]}, time = 120, order = "e-c-c-c"},

turret_unlock{name = "acid-thrower", icon = "__Additional-Turret__/graphics/technology/acid-thrower.png",
	effects = {{type = "unlock-recipe", recipe = "at-acidthrower-turret"}},
	prerequisites = {"flamethrower"}, 
	count = 50, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[4]}, time = 30, order = "e-c-b-a"},

turret_unlock{name = "advanced-laser-research", icon = "__Additional-Turret__/graphics/technology/ad-laser-turret.png",
	effects = {{type = "unlock-recipe", recipe = "at-advanced-laser"},
		{type = "unlock-recipe", recipe = "at-beam-turret-mk1"}},
	prerequisites = {"laser"}, 
	count = 200, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[4]}, time = 30, order = "a-h-e"},

turret_unlock{name = "beam-research", icon = "__Additional-Turret__/graphics/technology/beam-turret.png",
	effects = {{type = "unlock-recipe", recipe = "at-beam-turret-mk2"}},
	prerequisites = {"advanced-laser-research"}, 
	count = 250, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4]}, time = 60, order = "a-h-d"},

turret_unlock{name = "capsule-turret", icon = "__Additional-Turret__/graphics/technology/lc-tech.png",
	effects = {{type = "unlock-recipe", recipe = "at_LC_b"}},
	prerequisites = {"advanced-laser-research", "military-3"}, 
	count = 350, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4]}, time = 60, order = "e-c-c"},

turret_unlock{name = "artillery-set", icon = "__Additional-Turret__/graphics/technology/artillery-tech.png",
	effects = {{type = "unlock-recipe", recipe = "target-marker"},
		{type = "unlock-recipe", recipe = "at_A1_b"},
		{type = "unlock-recipe", recipe = "at_A2_b"},
		{type = "unlock-recipe", recipe = "Artillery_mk1_Ammo"},
		{type = "unlock-recipe", recipe = "Artillery_mk2_Ammo"}},
	prerequisites = {"upgrade-shells-3"}, 
	count = 250, ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4], ingredients_list[5]}, time = 60, order = "e-c-f"},
})