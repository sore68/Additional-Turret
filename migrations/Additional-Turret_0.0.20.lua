game.reload_script()

for index, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()
	
	local technologies = force.technologies
	local modifier = {0, 0, 0, 0}
	
	for i = 1, 6 do
		local md
		if i <= 3 then
			md = 0.3
		else
			md = i * 0.1
		end
	
		if technologies["turret-mk1-damage-"..i].researched then
			modifier[1] = modifier[1] + md
		end
		if technologies["turret-mk2-damage-"..i].researched then
			modifier[2] = modifier[2] + md
		end
		if technologies["turret-mk3-damage-"..i].researched then
			modifier[3] = modifier[3] + md
		end
		if technologies["thrower-turret-damage-"..i].researched then
			modifier[4] = modifier[4] + 0.2
		end
	end
	
	force.set_turret_attack_modifier("at-cannon-turret-mk1", modifier[1])
	force.set_turret_attack_modifier("at-rocket-turret-mk1", modifier[1])
	force.set_turret_attack_modifier("at-cannon-turret-mk2", modifier[2])
	force.set_turret_attack_modifier("at-rocket-turret-mk2", modifier[2])
	force.set_turret_attack_modifier("at_CR_turret", modifier[3])
	force.set_turret_attack_modifier("at_CR_turretr", modifier[3])
	force.set_turret_attack_modifier("at-acidthrower-turret", modifier[4])
	force.set_turret_attack_modifier("at-beam-turret-mk1", 0)
	force.set_turret_attack_modifier("at-beam-turret-mk2", 0)
	force.set_turret_attack_modifier("at_Artillery_mk1", 0)
	
	force.set_ammo_damage_modifier("laser-turret", force.get_ammo_damage_modifier("laser-turret"))
end