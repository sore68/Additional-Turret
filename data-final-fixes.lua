require "config"
require ("libs/list_ammo")

-- local mod_detector = {}
-- mod_detector[1] = 0 -- bob's warfare/enemies
-- mod_detector[2] = 0 -- Predictabowl Enemies

function artillery_area_damage(inputs)
return
{
	type = "area",
	perimeter = inputs.perimeter,
	action_delivery =
	{
		type = "instant",
		target_effects =
		{
			{
				type = "damage",
				damage = {amount = inputs.amount, type = "explosion"}
			},
		}
	}
}
end

---------- mod detector
-- for _, tp in pairs(data.raw["damage-type"]) do
	-- if tp.name == "bob-pierce" then
		-- mod_detector[1] = 1
	-- end
-- end
-- for _, tp in pairs(data.raw["unit-spawner"]) do
	-- if tp.name == "evolved-spawner-mix" then
		-- mod_detector[2] = 1
	-- end
-- end

---------- global change
for v, x in pairs(data.raw) do
	for v1, x1 in pairs(x) do
		if x1.resistances then
			local a = {{false}, {0, 0}}
			for v2, x2 in pairs(x1.resistances) do
				if x2.type == "fire" then
					a[2][1] = x2.decrease or 0
					a[2][2] = x2.percent or 0
					a[1][1] = true
				end
			end
			if a[1][1] then
				x1.resistances[#x1.resistances + 1] = { decrease = a[2][1], percent = a[2][2], type = "sore-acid"}
			end
		end
	end
end

---------- selective strain
local damage_modif = 1
for _, tp in pairs(data.raw["unit-spawner"]) do
	if tp.max_health then
		local mh = math.floor(tp.max_health * 0.003 + 0.5)
		
		if damage_modif < mh then damage_modif = mh end
	end
end

-- local damage_modif = 0
-- if mod_detector[1] == 1 or mod_detector[2] == 1 then
	-- damage_modif = 5
-- else
	-- damage_modif = 1
-- end
for v, x in pairs(data.raw.projectile) do
	if x.name == "artillery-cluster" then
		x.action[#x.action+1] = artillery_area_damage{perimeter = 5, amount = 100 * damage_modif}
	end
	if x.name == "Artillery_mk1_Ammo" then
		x.action[#x.action+1] = artillery_area_damage{perimeter = 15, amount = 500 * damage_modif}
	end
	if x.name == "Artillery_mk2_Ammo" then
		x.action[#x.action+1] = artillery_area_damage{perimeter = 30, amount = 500 * damage_modif}
	end
end

---------- Config strain
if Config.enemy_corps_time then
	for v, x in pairs(data.raw.corpse) do
		if string.find(x.name, "corpse") or string.find(x.name, "scorchmark") then
			x.time_before_removed = Config.enemy_corps_time
		end
	end
end