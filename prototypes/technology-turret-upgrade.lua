function damage_upgrade(inputs) -- damage_upgrade{name, icon, effects, prerequisites, ingredients, time, max_level, order}
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
		count_formula = "100*L",
		ingredients = inputs.ingredients,
		time = inputs.time
	},
	upgrade = true,
	max_level = inputs.max_level,
	order = inputs.order,
}
end

--------------

local name_list = {"turret-mk1-damage-", "turret-mk2-damage-", "turret-mk3-damage-", "thrower-turret-damage-"}
local icon_list = {
	"__Additional-Turret__/graphics/technology/turret-mk1-damage.png",
	"__Additional-Turret__/graphics/technology/turret-mk2-damage.png",
	"__Additional-Turret__/graphics/technology/turret-mk3-damage.png",
	"__Additional-Turret__/graphics/technology/acid-thrower-damage.png"
}
local effects_list = {
					{{
							type = "turret-attack",
							turret_id = "at-cannon-turret-mk1",
							modifier = 0.1,
						},
						{
							type = "turret-attack",
							turret_id = "at-rocket-turret-mk1",
							modifier = 0.1,
					}},
					{{
							type = "turret-attack",
							turret_id = "at-cannon-turret-mk2",
							modifier = 0.1,
						},
						{
							type = "turret-attack",
							turret_id = "at-rocket-turret-mk2",
							modifier = 0.1,
					}},
					{{
							type = "turret-attack",
							turret_id = "at_CR_s1",
							modifier = 0.1,
						},
						{
							type = "turret-attack",
							turret_id = "at_CR_s2",
							modifier = 0.1,
					}},
					{
						-- {
							-- type = "ammo-damage",
							-- ammo_category = "acid-thrower-ammo",
							-- modifier = 0.2
						-- },
						{
							type = "turret-attack",
							turret_id = "at-acidthrower-turret",
							modifier = 0.1,
					}},
					
				}
local prerequisites_list = {"turret-mk1-unlock", "turret-mk2-unlock", "turret-mk3-unlock", "acid-thrower"}
local ingredients_list = {{"science-pack-1", 1}, {"science-pack-2", 1}, {"science-pack-3", 1}, {"military-science-pack", 1}, {"high-tech-science-pack", 1}, {"space-science-pack", 1}}
local time_list = {10, 20, 30, 60, 120}
local max_level_list = {"10", "20", "40", "80", "infinite"}
local next_level = {"11", "21", "41", "81"}
local order_list = {"e-o-q-a", "e-o-q-c", "e-o-q-e", "e-o-p-a"}
for i = 1, 4 do
	data:extend({
		damage_upgrade{name = name_list[i].."1", icon = icon_list[i],
						effects = effects_list[i],
						prerequisites = {prerequisites_list[i]},
						ingredients = {ingredients_list[1], ingredients_list[2]},
						time = time_list[1], max_level = max_level_list[1], order = order_list[i]},
		damage_upgrade{name = name_list[i]..next_level[1], icon = icon_list[i],
						effects = effects_list[i],
						prerequisites = {name_list[i].."1"},
						ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3]},
						time = time_list[2], max_level = max_level_list[2], order = order_list[i]},
		damage_upgrade{name = name_list[i]..next_level[2], icon = icon_list[i],
						effects = effects_list[i],
						prerequisites = {name_list[i]..next_level[1]},
						ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4]},
						time = time_list[3], max_level = max_level_list[3], order = order_list[i]},
		damage_upgrade{name = name_list[i]..next_level[3], icon = icon_list[i],
						effects = effects_list[i],
						prerequisites = {name_list[i]..next_level[2]},
						ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4], ingredients_list[5]},
						time = time_list[4], max_level = max_level_list[4], order = order_list[i]},
		damage_upgrade{name = name_list[i]..next_level[4], icon = icon_list[i],
						effects = effects_list[i],
						prerequisites = {name_list[i]..next_level[3]},
						ingredients = {ingredients_list[1], ingredients_list[2], ingredients_list[3], ingredients_list[4], ingredients_list[5], ingredients_list[6]},
						time = time_list[5], max_level = max_level_list[5], order = order_list[i]},
	})
end