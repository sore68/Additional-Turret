for _, capsule in pairs(data.raw.capsule) do
	if capsule.capsule_action.attack_parameters and capsule.capsule_action.attack_parameters.ammo_type.action.action_delivery.projectile then
		if not (string.find(capsule.name, "capture") or string.find(capsule.name, "train") or string.find(capsule.name, "goto")) then
			if string.find(capsule.name, "grenade") or string.find(capsule.name, "capsule") then
			
				data:extend({
					{
						type = "ammo",
						name = "at_" .. capsule.name,
						localised_name = {"item-name.dummy"},
						icon = capsule.icon,
						flags = {"goes-to-main-inventory", "hidden"},
						ammo_type = {
							category = "capsule",
							target_type = "position",
							action = {
								type = "direct",
								action_delivery = {
									type = "projectile",
									projectile = capsule.capsule_action.attack_parameters.ammo_type.action.action_delivery.projectile,
									starting_speed = 1
								}
							}
						},
						subgroup = "capsule",
						order = capsule.order,
						magazine_size = 1,
						stack_size = capsule.stack_size
					},
				})
			end
		end
	end
end