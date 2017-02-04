function damage_upgrade_1(inputs)
return
{
	type = "technology",
	name = inputs.name,
	icon_size = 128,
	icon = inputs.icon,
	effects =
	{
		{
			type = "turret-attack",
			turret_id = inputs.turret_id,
			modifier = inputs.modifier,
		},
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

function damage_upgrade_2(inputs)
return
{
	type = "technology",
	name = inputs.name,
	icon_size = 128,
	icon = inputs.icon,
	effects =
	{
		{
			type = "turret-attack",
			turret_id = inputs.turret_id_1,
			modifier = inputs.modifier_1,
		},
		{
			type = "turret-attack",
			turret_id = inputs.turret_id_2,
			modifier = inputs.modifier_2,
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

function artillery_upgrade(inputs)
return
{
	type = "technology",
	name = inputs.name,
	icon_size = 128,
	icon = inputs.icon,
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

-------------- mk1 turret damage
for i = 1, 6 do
	local tech_1_icon = "__Additional-Turret__/graphics/technology/turret-mk1-damage.png"
	local tech_2_icon = "__Additional-Turret__/graphics/technology/turret-mk2-damage.png"
	local tech_3_icon = "__Additional-Turret__/graphics/technology/turret-mk3-damage.png"
	local thrower_icon = "__Additional-Turret__/graphics/technology/acid-thrower-damage.png"
	local md
	if i <=3 then
		md = 0.3
	else
		md = 0.1*i
	end
	if i == 1 then
		data:extend({
			damage_upgrade_2{name = "turret-mk1-damage-1", icon = tech_1_icon,
					turret_id_1 = "at-cannon-turret-mk1", modifier_1 = md,
					turret_id_2 = "at-rocket-turret-mk1", modifier_2 = md,
					prerequisites = {"turret-mk1-unlock"},
					count = 50, times = 30, order = "e-o-q-a"},
			damage_upgrade_2{name = "turret-mk2-damage-1", icon = tech_2_icon,
					turret_id_1 = "at-cannon-turret-mk2", modifier_1 = md,
					turret_id_2 = "at-rocket-turret-mk2", modifier_2 = md,
					prerequisites = {"turret-mk2-unlock"},
					count = 50, times = 30, order = "e-o-q-c"},
			damage_upgrade_1{name = "thrower-turret-damage-1", icon = thrower_icon,
					turret_id = "at-acidthrower-turret", modifier = "0.2",
					prerequisites = {"piranha-research"},
					count = 50, times = 30, order = "e-o-p-a"},
			damage_upgrade_2{name = "turret-mk3-damage-1", icon = tech_3_icon,
					turret_id_1 = "at_CR_t1", modifier_1 = 0.2,
					turret_id_2 = "at_CR_t2", modifier_2 = 0.2,
					prerequisites = {"turret-mk3-unlock"},
					count = 100, times = 30, order = "e-o-q-e"},
		})
	else
		local j = i - 1
		data:extend({
			damage_upgrade_2{name = "turret-mk1-damage-"..i, icon = tech_1_icon,
					turret_id_1 = "at-cannon-turret-mk1", modifier_1 = md,
					turret_id_2 = "at-rocket-turret-mk1", modifier_2 = md,
					prerequisites = {"turret-mk1-damage-"..j},
					count = 50*(2^j), times = 30*i, order = "e-o-q-b"},
			damage_upgrade_2{name = "turret-mk2-damage-"..i, icon = tech_2_icon,
					turret_id_1 = "at-cannon-turret-mk2", modifier_1 = md,
					turret_id_2 = "at-rocket-turret-mk2", modifier_2 = md,
					prerequisites = {"turret-mk2-damage-"..j},
					count = 50*(2^j), times = 30*i, order = "e-o-q-d"},
			damage_upgrade_1{name = "thrower-turret-damage-"..i, icon = thrower_icon,
					turret_id = "at-acidthrower-turret", modifier = "0.2",
					prerequisites = {"thrower-turret-damage-"..j},
					count = 35*(2^j), times = 30*i, order = "e-o-p-b"},
			damage_upgrade_2{name = "turret-mk3-damage-"..i, icon = tech_3_icon,
					turret_id_1 = "at_CR_t1", modifier_1 = 0.2,
					turret_id_2 = "at_CR_t2", modifier_2 = 0.2,
					prerequisites = {"turret-mk3-damage-"..j},
					count = 50*(2^j), times = 30*i, order = "e-o-q-f"},
		})
	end
end

for i = 1, 3 do
	local art_1_icon = "__Additional-Turret__/graphics/technology/art-1-range.png"
	local art_2_icon = "__Additional-Turret__/graphics/technology/art-2-range.png"
	if i == 1 then
		data:extend({
			artillery_upgrade{name = "artillery-1-range-1", icon = art_1_icon,
					prerequisites = {"artillery-set"},
					count = 50, times = 60, order = "e-c-f-a"},
			artillery_upgrade{name = "artillery-2-range-1", icon = art_2_icon,
					prerequisites = {"artillery-set"},
					count = 100, times = 60, order = "e-c-f-b"},
		
		})
	else
		local j = i - 1
		data:extend({
			artillery_upgrade{name = "artillery-1-range-"..i, icon = art_1_icon,
					prerequisites = {"artillery-1-range-"..j},
					count = 50*(2^j), times = 60*i, order = "e-c-f-c"},
			artillery_upgrade{name = "artillery-2-range-"..i, icon = art_2_icon,
					prerequisites = {"artillery-2-range-"..j},
					count = 100*(2^j), times = 60*i, order = "e-c-f-d"},
		})
	end
end